Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959807F6C07
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbjKXGF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjKXGEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:20 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974410D3;
        Thu, 23 Nov 2023 22:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jw2SmoPh0qPYG8JBwFCByN8FOehIviEhno/pqpGWIrg=; b=SOooeC54qTWTsfPph2jbWrQ7fC
        IZfv8eynAFwpniQ6EVVIcHNhLUtIZmc8H6J6/R+AH7UXWx0DJ/TzCr+kBPQXc0WsbhN4iHA62sEl6
        CaPKDJvDjK1nuWbYb/Azzr/muuI2Ra5FDaqmY++7uffeOWjZVPEgpYCRATNSWPydSNtnCsemwTabT
        ouIYMERGYA82q287yUEz3UBUAxQp8qg1X9yKIs7p3wD75+aOXvwHKcWUtTC4SHQXDjZILGupHzB+c
        7r/xNymhRWW9SojOiGdrtd4rD0rJF/HcU6MEJts+OFssmsblcKLvupYUuDy6eOM/w7srYFBs22z9u
        no52taJA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PIf-002Puk-2B;
        Fri, 24 Nov 2023 06:04:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/21] Call retain_dentry() with refcount 0
Date:   Fri, 24 Nov 2023 06:04:14 +0000
Message-Id: <20231124060422.576198-13-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of bumping it from 0 to 1, calling retain_dentry(), then
decrementing it back to 0 (with ->d_lock held all the way through),
just leave refcount at 0 through all of that.

It will have a visible effect for ->d_delete() - now it can be
called with refcount 0 instead of 1 and it can no longer play
silly buggers with dropping/regaining ->d_lock.  Not that any
in-tree instances tried to (it's pretty hard to get right).

Any out-of-tree ones will have to adjust (assuming they need any
changes).

Note that we do not need to extend rcu-critical area here - we have
verified that refcount is non-negative after having grabbed ->d_lock,
so nobody will be able to free dentry until they get into __dentry_kill(),
which won't happen until they manage to grab ->d_lock.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst |  8 ++++++++
 fs/dcache.c                           | 10 ++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 331405f4b29f..3714efcb6f65 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1070,3 +1070,11 @@ The list of children anchored in parent dentry got turned into hlist now.
 Field names got changed (->d_children/->d_sib instead of ->d_subdirs/->d_child
 for anchor/entries resp.), so any affected places will be immediately caught
 by compiler.
+
+---
+
+**mandatory**
+
+	->d_delete() instances are now called for dentries with ->d_lock held
+and refcount equal to 0.  They are not permitted to drop/regain ->d_lock.
+None of in-tree instances did anything of that sort.  Make sure yours do not...
diff --git a/fs/dcache.c b/fs/dcache.c
index 80992e49561c..8ce0fe70f303 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -888,15 +888,14 @@ void dput(struct dentry *dentry)
 		}
 
 		/* Slow case: now with the dentry lock held */
-		dentry->d_lockref.count = 1;
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
-			dentry->d_lockref.count--;
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
 
+		dentry->d_lockref.count = 1;
 		dentry = dentry_kill(dentry);
 	}
 }
@@ -921,13 +920,8 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 		return;
 	}
 	rcu_read_unlock();
-	dentry->d_lockref.count = 1;
-	if (!retain_dentry(dentry)) {
-		--dentry->d_lockref.count;
+	if (!retain_dentry(dentry))
 		to_shrink_list(dentry, list);
-	} else {
-		--dentry->d_lockref.count;
-	}
 	spin_unlock(&dentry->d_lock);
 }
 
-- 
2.39.2

