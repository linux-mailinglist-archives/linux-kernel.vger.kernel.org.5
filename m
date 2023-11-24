Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12E67F6C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbjKXGFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKXGEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:21 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6DD6F;
        Thu, 23 Nov 2023 22:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8RRk+S2n/uw/+Y4R6e9tnmBokKLdxLRo06V3rJC510w=; b=cXc+PzGvTnLdl+fV1c3J1aMKt4
        VUuI5hMfOehEIHZRdqFKT0cGImgrnUYLFpFBeZz0YghHlllPzM5a6a8j+XK1Jn702DoSYibWB5J6t
        e+cjDQ5UPG2DysKIR3D4/GGUFbFltx3Et8i8FB8k/t3xNPd8iukMAzefu3jfwvFU+zHnOj0pFtrCP
        WCxBWdECMfKfOg6181QJHKDSldgAnkb63P28c8oeJTwb6YWFOBRLVAXDLjmHhi/3YLgD2ab+YQGQt
        VF4yomOVzT58cZSgurHJjgWC4sKIsc8AlCytZwOkuVUwIWOu3pN28YyTPVAvSaSBo701jtj+jkf7q
        8EMZW+rw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PIg-002Pv0-0Z;
        Fri, 24 Nov 2023 06:04:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/21] to_shrink_list(): call only if refcount is 0
Date:   Fri, 24 Nov 2023 06:04:18 +0000
Message-Id: <20231124060422.576198-17-viro@zeniv.linux.org.uk>
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

The only thing it does if refcount is not zero is d_lru_del(); no
point, IMO, seeing that plain dput() does nothing of that sort...

Note that 2 of 3 current callers are guaranteed that refcount is 0.

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5284b02747cd..704676bf06fd 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -915,8 +915,7 @@ __must_hold(&dentry->d_lock)
 	if (!(dentry->d_flags & DCACHE_SHRINK_LIST)) {
 		if (dentry->d_flags & DCACHE_LRU_LIST)
 			d_lru_del(dentry);
-		if (!dentry->d_lockref.count)
-			d_shrink_add(dentry, list);
+		d_shrink_add(dentry, list);
 	}
 }
 
@@ -1115,10 +1114,8 @@ EXPORT_SYMBOL(d_prune_aliases);
 static inline void shrink_kill(struct dentry *victim, struct list_head *list)
 {
 	struct dentry *parent = victim->d_parent;
-	if (parent != victim) {
-		--parent->d_lockref.count;
+	if (parent != victim && !--parent->d_lockref.count)
 		to_shrink_list(parent, list);
-	}
 	__dentry_kill(victim);
 }
 
-- 
2.39.2

