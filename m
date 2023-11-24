Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD81F7F6C04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbjKXGFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXGEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:20 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E143C10D0;
        Thu, 23 Nov 2023 22:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vqFH5rERW58IIdMxyKTO+oPeZnb8OZczTTpmKipGyrA=; b=IZalQm1CDM/26zqZNWLkuzZQnL
        XoCFW8H56OWRSgycnTzbTmahD10SLdxGszLx2xyNWABvWa2x0BFbuIcT0xuC3LKURvZmBqaH7VDp1
        viy2p+jmxKAOv1za7I1rZM4eHxwbJIa6urXvjPrb+grgYsE2NGb2ojtftJhvNm8eRguMUIDzQ8xv3
        nwfibLMUZxvrvT6JjL2BZmtzIcYmRjyGgdZbBXT5LPjgZ6LZBN+pTOD0Suj2GSYW/4VfZEzeF15Q2
        V1T8UOCAuCh26oo7Cv8hUS0rw3HeVbREBIcFly1u+l+Gk+FTqeLAdfwrK4yy5V6lrNLN8z49Ll1Fy
        ohFGTtwg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PIe-002PuZ-11;
        Fri, 24 Nov 2023 06:04:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/21] dentry_kill(): don't bother with retain_dentry() on slow path
Date:   Fri, 24 Nov 2023 06:04:13 +0000
Message-Id: <20231124060422.576198-12-viro@zeniv.linux.org.uk>
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

We have already checked it and dentry used to look not worthy
of keeping.  The only hard obstacle to evicting dentry is
non-zero refcount; everything else is advisory - e.g. memory
pressure could evict any dentry found with refcount zero.
On the slow path in dentry_kill() we had dropped and regained
->d_lock; we must recheck the refcount, but everything else
is not worth bothering with.

Note that filesystem can not count upon ->d_delete() being
called for dentry - not even once.  Again, memory pressure
(as well as d_prune_aliases(), or attempted rmdir() of ancestor,
or...) will not call ->d_delete() at all.

So from the correctness point of view we are fine doing the
check only once.  And it makes things simpler down the road.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b527db8e5901..80992e49561c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -739,14 +739,10 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	spin_lock(&dentry->d_lock);
 	parent = lock_parent(dentry);
 got_locks:
-	if (unlikely(dentry->d_lockref.count != 1)) {
-		dentry->d_lockref.count--;
-	} else if (likely(!retain_dentry(dentry))) {
-		dentry->d_lockref.count--;
+	dentry->d_lockref.count--;
+	if (likely(dentry->d_lockref.count == 0)) {
 		__dentry_kill(dentry);
 		return parent;
-	} else {
-		dentry->d_lockref.count--;
 	}
 	/* we are keeping it, after all */
 	if (inode)
-- 
2.39.2

