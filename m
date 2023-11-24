Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD307F6BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjKXGEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKXGES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:18 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC55B10C8;
        Thu, 23 Nov 2023 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OhCzST4Viql9jwYwDDeDZI5/cnICIyfnJcJBswRqBMo=; b=t84e8FxetnlLzWy6Ty94DCvdp+
        V+lOFj3AjZZCzxAAB+FbLC5E7PoA1tyT2Himsg0ubdZrmaued/gFs8XQ7m90MyynxiIifH8ism8yU
        eeqc0tw2fyWrC3fa+/3a8wVXuqm929QwW99VDKHNj2DgawwS503lweZLdhrQrgADV0QZRvdanKhvm
        6YpA7633x3LGyEB/j4VWDX87FJR7uTJtGN3yM0rUR8yiKg0AwLTBTBLdGe3fBlIf5QUvXQHDFoMrI
        IvkDn3KWOrqm0Ix3rsp4AwY8FASYrTTYfWeWC+ayNe9q2V8ij3ELqc/Y1u1wR+jR+rt2fHW2q8ct+
        hWI6DAtA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PId-002PuB-1w;
        Fri, 24 Nov 2023 06:04:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/21] fast_dput(): new rules for refcount
Date:   Fri, 24 Nov 2023 06:04:09 +0000
Message-Id: <20231124060422.576198-8-viro@zeniv.linux.org.uk>
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

By now there is only one place in entire fast_dput() where we return
false; that happens after refcount had been decremented and found (under
->d_lock) to be zero.  In that case, just prior to returning false to
caller, fast_dput() forcibly changes the refcount from 0 to 1.

Lift that resetting refcount to 1 into the callers; later in the series
it will be massaged out of existence.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9edabc7e2e64..a00e9ba22480 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -847,13 +847,6 @@ static inline bool fast_dput(struct dentry *dentry)
 		spin_unlock(&dentry->d_lock);
 		return true;
 	}
-
-	/*
-	 * Re-get the reference we optimistically dropped. We hold the
-	 * lock, and we just tested that it was zero, so we can just
-	 * set it to 1.
-	 */
-	dentry->d_lockref.count = 1;
 	return false;
 }
 
@@ -896,6 +889,7 @@ void dput(struct dentry *dentry)
 		}
 
 		/* Slow case: now with the dentry lock held */
+		dentry->d_lockref.count = 1;
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
@@ -930,6 +924,7 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 		return;
 	}
 	rcu_read_unlock();
+	dentry->d_lockref.count = 1;
 	if (!retain_dentry(dentry))
 		__dput_to_list(dentry, list);
 	spin_unlock(&dentry->d_lock);
-- 
2.39.2

