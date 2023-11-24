Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C577F6C42
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjKXGS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjKXGS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:18:27 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F3619AE;
        Thu, 23 Nov 2023 22:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XPyaCiQYgDLolwiCNI4gnwbAILovZtP7N3FDBMoCdWg=; b=YT8NS8sXC10KTuFYngOHZj6MLw
        F0rfl7O6hqpLvUe1f0tn7GTUUrF7npWoFU+dksKFXDOzUQ9joU+HTzA5h6T8w9g99A4HJd4RVm5Nu
        SK1Y8bJQf11J50MVIo6vyO7gjy5lhuVaanH4wF5u+i0uv7/8e2AxyTEfpdSk1I7IM/FBJPEfdThlf
        Ln9BJwAzsi/ZWKtMYPgT7q/ZyLXMSiemcb4DQ8jqFzwsG+tQeARTvl7a//YuELXLxJF9Wd3BYXTWD
        YL1Vow9HjBEUUTBDh+NsO4jVIT/xUxa2mpuptZveJa7wbk5xsUN9Mznh9GGstsK46beNMflPMyvCc
        zlBaCVLg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PKv-002Q0t-2v;
        Fri, 24 Nov 2023 06:06:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/20] dentry.h: trim externs
Date:   Fri, 24 Nov 2023 06:06:32 +0000
Message-Id: <20231124060644.576611-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
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

d_instantiate_unique() had been gone for 7 years; __d_lookup...()
and shrink_dcache_for_umount() are fs/internal.h fodder.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h          | 4 ++++
 include/linux/dcache.h | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 58e43341aebf..9e9fc629f935 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -215,6 +215,10 @@ extern struct dentry * d_alloc_pseudo(struct super_block *, const struct qstr *)
 extern char *simple_dname(struct dentry *, char *, int);
 extern void dput_to_list(struct dentry *, struct list_head *);
 extern void shrink_dentry_list(struct list_head *);
+extern void shrink_dcache_for_umount(struct super_block *);
+extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
+extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
+				const struct qstr *name, unsigned *seq);
 
 /*
  * pipe.c
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 8cd937bb2292..9706bf1dc5de 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -218,7 +218,6 @@ extern seqlock_t rename_lock;
  */
 extern void d_instantiate(struct dentry *, struct inode *);
 extern void d_instantiate_new(struct dentry *, struct inode *);
-extern struct dentry * d_instantiate_unique(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *);
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
@@ -240,7 +239,6 @@ extern struct dentry * d_obtain_alias(struct inode *);
 extern struct dentry * d_obtain_root(struct inode *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-extern void shrink_dcache_for_umount(struct super_block *);
 extern void d_invalidate(struct dentry *);
 
 /* only used at mount-time */
@@ -275,9 +273,6 @@ extern struct dentry *d_ancestor(struct dentry *, struct dentry *);
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry *d_lookup(const struct dentry *, const struct qstr *);
 extern struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
-extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
-extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
-				const struct qstr *name, unsigned *seq);
 
 static inline unsigned d_count(const struct dentry *dentry)
 {
-- 
2.39.2

