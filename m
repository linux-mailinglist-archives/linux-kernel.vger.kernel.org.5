Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D530803F70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjLDUdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjLDUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:33:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5EF129
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:33:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC57C433C9;
        Mon,  4 Dec 2023 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722016;
        bh=SehovYGp2WIhK9Sz1LzhxlrOBSnyqZqFJHAjzsJbaEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFeYO7U6A/f2Xi/74vpfmSKfnUL6ea0urPNwFRhARqWLtmeSFzPat9lhSQGUmy+DZ
         /7Bp74b8wvXvu/a3bdzbvwMA5+Ur9/irJSR1kMGT4S+mAjrbDvAam+iy9dHBMQSXDD
         eoFIvOnT4JanyLwjcrfoJV+gbr5oKlin3mX41qZZS3RStet5gU0aVNoV+X1MIfOmCB
         aLw2YrK10C2AJhrNKsGWjaVn2Dngak1xfnDyfk6tTHYSY66rFG/S/Q4ky5tz93nmGN
         5qH5y3IGzsLWx9XzDYb4ErRYLxid3JosgUQAMj+R1eoeArM69llO5NSG082QyxdR/4
         Uj1TIuN5CpmSg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/32] ksmbd: separately allocate ci per dentry
Date:   Mon,  4 Dec 2023 15:32:26 -0500
Message-ID: <20231204203317.2092321-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 4274a9dc6aeb9fea66bffba15697a35ae8983b6a ]

xfstests generic/002 test fail when enabling smb2 leases feature.
This test create hard link file, but removeal failed.
ci has a file open count to count file open through the smb client,
but in the case of hard link files, The allocation of ci per inode
cause incorrectly open count for file deletion. This patch allocate
ci per dentry to counts open counts for hard link.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c   |  2 +-
 fs/smb/server/vfs.c       |  2 +-
 fs/smb/server/vfs_cache.c | 33 +++++++++++++--------------------
 fs/smb/server/vfs_cache.h |  6 +++---
 4 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 93262ca3f58a7..a85f3cc7c181f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3038,7 +3038,7 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
-	rc = ksmbd_query_inode_status(d_inode(path.dentry->d_parent));
+	rc = ksmbd_query_inode_status(path.dentry->d_parent);
 	if (rc == KSMBD_INODE_STATUS_PENDING_DELETE) {
 		rc = -EBUSY;
 		goto err_out;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 9919c07035d80..1b6c671f8a942 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -715,7 +715,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out3;
 	}
 
-	parent_fp = ksmbd_lookup_fd_inode(d_inode(old_child->d_parent));
+	parent_fp = ksmbd_lookup_fd_inode(old_child->d_parent);
 	if (parent_fp) {
 		if (parent_fp->daccess & FILE_DELETE_LE) {
 			pr_err("parent dir is opened with delete access\n");
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index c91eac6514dd9..ddf233994ddbb 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -66,14 +66,14 @@ static unsigned long inode_hash(struct super_block *sb, unsigned long hashval)
 	return tmp & inode_hash_mask;
 }
 
-static struct ksmbd_inode *__ksmbd_inode_lookup(struct inode *inode)
+static struct ksmbd_inode *__ksmbd_inode_lookup(struct dentry *de)
 {
 	struct hlist_head *head = inode_hashtable +
-		inode_hash(inode->i_sb, inode->i_ino);
+		inode_hash(d_inode(de)->i_sb, (unsigned long)de);
 	struct ksmbd_inode *ci = NULL, *ret_ci = NULL;
 
 	hlist_for_each_entry(ci, head, m_hash) {
-		if (ci->m_inode == inode) {
+		if (ci->m_de == de) {
 			if (atomic_inc_not_zero(&ci->m_count))
 				ret_ci = ci;
 			break;
@@ -84,26 +84,16 @@ static struct ksmbd_inode *__ksmbd_inode_lookup(struct inode *inode)
 
 static struct ksmbd_inode *ksmbd_inode_lookup(struct ksmbd_file *fp)
 {
-	return __ksmbd_inode_lookup(file_inode(fp->filp));
+	return __ksmbd_inode_lookup(fp->filp->f_path.dentry);
 }
 
-static struct ksmbd_inode *ksmbd_inode_lookup_by_vfsinode(struct inode *inode)
-{
-	struct ksmbd_inode *ci;
-
-	read_lock(&inode_hash_lock);
-	ci = __ksmbd_inode_lookup(inode);
-	read_unlock(&inode_hash_lock);
-	return ci;
-}
-
-int ksmbd_query_inode_status(struct inode *inode)
+int ksmbd_query_inode_status(struct dentry *dentry)
 {
 	struct ksmbd_inode *ci;
 	int ret = KSMBD_INODE_STATUS_UNKNOWN;
 
 	read_lock(&inode_hash_lock);
-	ci = __ksmbd_inode_lookup(inode);
+	ci = __ksmbd_inode_lookup(dentry);
 	if (ci) {
 		ret = KSMBD_INODE_STATUS_OK;
 		if (ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS))
@@ -143,7 +133,7 @@ void ksmbd_fd_set_delete_on_close(struct ksmbd_file *fp,
 static void ksmbd_inode_hash(struct ksmbd_inode *ci)
 {
 	struct hlist_head *b = inode_hashtable +
-		inode_hash(ci->m_inode->i_sb, ci->m_inode->i_ino);
+		inode_hash(d_inode(ci->m_de)->i_sb, (unsigned long)ci->m_de);
 
 	hlist_add_head(&ci->m_hash, b);
 }
@@ -157,7 +147,6 @@ static void ksmbd_inode_unhash(struct ksmbd_inode *ci)
 
 static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
 {
-	ci->m_inode = file_inode(fp->filp);
 	atomic_set(&ci->m_count, 1);
 	atomic_set(&ci->op_count, 0);
 	atomic_set(&ci->sop_count, 0);
@@ -166,6 +155,7 @@ static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
 	INIT_LIST_HEAD(&ci->m_fp_list);
 	INIT_LIST_HEAD(&ci->m_op_list);
 	rwlock_init(&ci->m_lock);
+	ci->m_de = fp->filp->f_path.dentry;
 	return 0;
 }
 
@@ -488,12 +478,15 @@ struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid)
 	return fp;
 }
 
-struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode)
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry)
 {
 	struct ksmbd_file	*lfp;
 	struct ksmbd_inode	*ci;
+	struct inode		*inode = d_inode(dentry);
 
-	ci = ksmbd_inode_lookup_by_vfsinode(inode);
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(dentry);
+	read_unlock(&inode_hash_lock);
 	if (!ci)
 		return NULL;
 
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 03d0bf941216f..8325cf4527c46 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -51,7 +51,7 @@ struct ksmbd_inode {
 	atomic_t			op_count;
 	/* opinfo count for streams */
 	atomic_t			sop_count;
-	struct inode			*m_inode;
+	struct dentry			*m_de;
 	unsigned int			m_flags;
 	struct hlist_node		m_hash;
 	struct list_head		m_fp_list;
@@ -140,7 +140,7 @@ struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
-struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode);
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
 unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp);
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work);
@@ -164,7 +164,7 @@ enum KSMBD_INODE_STATUS {
 	KSMBD_INODE_STATUS_PENDING_DELETE,
 };
 
-int ksmbd_query_inode_status(struct inode *inode);
+int ksmbd_query_inode_status(struct dentry *dentry);
 bool ksmbd_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_clear_inode_pending_delete(struct ksmbd_file *fp);
-- 
2.42.0

