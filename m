Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25BA8113A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441848AbjLMNw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379387AbjLMNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:51:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EEB19B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702475459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gt+qb4YpAajMbQL9rvZ8Y9MPqmE5bMZVduZ1rQOTpmc=;
        b=GMAgv4D9ZVgJtNaz7lRlqPVFwN7q1jVLRQky38HMn7ahhLSo6wLTvf5woQqigfDUTA8+2m
        i1R9XbR6UqjBaHIFZhLet3NV+xgQLwir0eF/UGAfJk8mCZ7O7mI2u7yn/79QraWc1hfGX9
        FfW6rmIm5mTqw0w6YSmYrst7JV3n0Lc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-j_ZxgNeUMBOFLTHSBwLmGw-1; Wed, 13 Dec 2023 08:50:58 -0500
X-MC-Unique: j_ZxgNeUMBOFLTHSBwLmGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A24FA8828C9;
        Wed, 13 Dec 2023 13:50:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B903A51E3;
        Wed, 13 Dec 2023 13:50:56 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/40] afs: Move the vnode/volume validity checking code into its own file
Date:   Wed, 13 Dec 2023 13:49:54 +0000
Message-ID: <20231213135003.367397-33-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code that does validity checking of vnodes and volumes with
respect to third-party changes into its own file.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/Makefile     |   1 +
 fs/afs/inode.c      | 172 -----------------------------------------
 fs/afs/internal.h   |  10 ++-
 fs/afs/validation.c | 183 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 175 deletions(-)
 create mode 100644 fs/afs/validation.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index b3849bea0553..dcdc0f1bb76f 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -28,6 +28,7 @@ kafs-y := \
 	server.o \
 	server_list.o \
 	super.o \
+	validation.o \
 	vlclient.o \
 	vl_alias.o \
 	vl_list.o \
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index f44a8a48bf24..102e7c37d33c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -572,178 +572,6 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 	return ERR_PTR(ret);
 }
 
-/*
- * mark the data attached to an inode as obsolete due to a write on the server
- * - might also want to ditch all the outstanding writes and dirty pages
- */
-static void afs_zap_data(struct afs_vnode *vnode)
-{
-	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
-
-	afs_invalidate_cache(vnode, 0);
-
-	/* nuke all the non-dirty pages that aren't locked, mapped or being
-	 * written back in a regular file and completely discard the pages in a
-	 * directory or symlink */
-	if (S_ISREG(vnode->netfs.inode.i_mode))
-		invalidate_remote_inode(&vnode->netfs.inode);
-	else
-		invalidate_inode_pages2(vnode->netfs.inode.i_mapping);
-}
-
-/*
- * Check to see if we have a server currently serving this volume and that it
- * hasn't been reinitialised or dropped from the list.
- */
-static bool afs_check_server_good(struct afs_vnode *vnode)
-{
-	struct afs_server_list *slist;
-	struct afs_server *server;
-	bool good;
-	int i;
-
-	if (vnode->cb_fs_s_break == atomic_read(&vnode->volume->cell->fs_s_break))
-		return true;
-
-	rcu_read_lock();
-
-	slist = rcu_dereference(vnode->volume->servers);
-	for (i = 0; i < slist->nr_servers; i++) {
-		server = slist->servers[i].server;
-		if (server == vnode->cb_server) {
-			good = (vnode->cb_s_break == server->cb_s_break);
-			rcu_read_unlock();
-			return good;
-		}
-	}
-
-	rcu_read_unlock();
-	return false;
-}
-
-/*
- * Check the validity of a vnode/inode.
- */
-bool afs_check_validity(struct afs_vnode *vnode)
-{
-	enum afs_cb_break_reason need_clear = afs_cb_break_no_break;
-	time64_t now = ktime_get_real_seconds();
-	unsigned int cb_break;
-	int seq;
-
-	do {
-		seq = read_seqbegin(&vnode->cb_lock);
-		cb_break = vnode->cb_break;
-
-		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
-			if (vnode->cb_v_break != vnode->volume->cb_v_break)
-				need_clear = afs_cb_break_for_v_break;
-			else if (!afs_check_server_good(vnode))
-				need_clear = afs_cb_break_for_s_reinit;
-			else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
-				need_clear = afs_cb_break_for_zap;
-			else if (vnode->cb_expires_at - 10 <= now)
-				need_clear = afs_cb_break_for_lapsed;
-		} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-			;
-		} else {
-			need_clear = afs_cb_break_no_promise;
-		}
-
-	} while (read_seqretry(&vnode->cb_lock, seq));
-
-	if (need_clear == afs_cb_break_no_break)
-		return true;
-
-	write_seqlock(&vnode->cb_lock);
-	if (need_clear == afs_cb_break_no_promise)
-		vnode->cb_v_break = vnode->volume->cb_v_break;
-	else if (cb_break == vnode->cb_break)
-		__afs_break_callback(vnode, need_clear);
-	else
-		trace_afs_cb_miss(&vnode->fid, need_clear);
-	write_sequnlock(&vnode->cb_lock);
-	return false;
-}
-
-/*
- * Returns true if the pagecache is still valid.  Does not sleep.
- */
-bool afs_pagecache_valid(struct afs_vnode *vnode)
-{
-	if (unlikely(test_bit(AFS_VNODE_DELETED, &vnode->flags))) {
-		if (vnode->netfs.inode.i_nlink)
-			clear_nlink(&vnode->netfs.inode);
-		return true;
-	}
-
-	if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags) &&
-	    afs_check_validity(vnode))
-		return true;
-
-	return false;
-}
-
-/*
- * validate a vnode/inode
- * - there are several things we need to check
- *   - parent dir data changes (rm, rmdir, rename, mkdir, create, link,
- *     symlink)
- *   - parent dir metadata changed (security changes)
- *   - dentry data changed (write, truncate)
- *   - dentry metadata changed (security changes)
- */
-int afs_validate(struct afs_vnode *vnode, struct key *key)
-{
-	int ret;
-
-	_enter("{v={%llx:%llu} fl=%lx},%x",
-	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
-	       key_serial(key));
-
-	if (afs_pagecache_valid(vnode))
-		goto valid;
-
-	down_write(&vnode->validate_lock);
-
-	/* if the promise has expired, we need to check the server again to get
-	 * a new promise - note that if the (parent) directory's metadata was
-	 * changed then the security may be different and we may no longer have
-	 * access */
-	if (!test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
-		_debug("not promised");
-		ret = afs_fetch_status(vnode, key, false, NULL);
-		if (ret < 0) {
-			if (ret == -ENOENT) {
-				set_bit(AFS_VNODE_DELETED, &vnode->flags);
-				ret = -ESTALE;
-			}
-			goto error_unlock;
-		}
-		_debug("new promise [fl=%lx]", vnode->flags);
-	}
-
-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-		_debug("file already deleted");
-		ret = -ESTALE;
-		goto error_unlock;
-	}
-
-	/* if the vnode's data version number changed then its contents are
-	 * different */
-	if (test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
-		afs_zap_data(vnode);
-	up_write(&vnode->validate_lock);
-valid:
-	_leave(" = 0");
-	return 0;
-
-error_unlock:
-	up_write(&vnode->validate_lock);
-	_leave(" = %d", ret);
-	return ret;
-}
-
 /*
  * read the attributes of an inode
  */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a50dfb2f8d7d..4a3d946b1d2a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1235,9 +1235,6 @@ extern int afs_ilookup5_test_by_fid(struct inode *, void *);
 extern struct inode *afs_iget_pseudo_dir(struct super_block *, bool);
 extern struct inode *afs_iget(struct afs_operation *, struct afs_vnode_param *);
 extern struct inode *afs_root_iget(struct super_block *, struct key *);
-extern bool afs_check_validity(struct afs_vnode *);
-extern int afs_validate(struct afs_vnode *, struct key *);
-bool afs_pagecache_valid(struct afs_vnode *);
 extern int afs_getattr(struct mnt_idmap *idmap, const struct path *,
 		       struct kstat *, u32, unsigned int);
 extern int afs_setattr(struct mnt_idmap *idmap, struct dentry *, struct iattr *);
@@ -1547,6 +1544,13 @@ void afs_detach_volume_from_servers(struct afs_volume *volume, struct afs_server
 extern int __init afs_fs_init(void);
 extern void afs_fs_exit(void);
 
+/*
+ * validation.c
+ */
+bool afs_check_validity(struct afs_vnode *vnode);
+bool afs_pagecache_valid(struct afs_vnode *vnode);
+int afs_validate(struct afs_vnode *vnode, struct key *key);
+
 /*
  * vlclient.c
  */
diff --git a/fs/afs/validation.c b/fs/afs/validation.c
new file mode 100644
index 000000000000..18ba2c5e8ead
--- /dev/null
+++ b/fs/afs/validation.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* vnode and volume validity verification.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include "internal.h"
+
+/*
+ * mark the data attached to an inode as obsolete due to a write on the server
+ * - might also want to ditch all the outstanding writes and dirty pages
+ */
+static void afs_zap_data(struct afs_vnode *vnode)
+{
+	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
+
+	afs_invalidate_cache(vnode, 0);
+
+	/* nuke all the non-dirty pages that aren't locked, mapped or being
+	 * written back in a regular file and completely discard the pages in a
+	 * directory or symlink */
+	if (S_ISREG(vnode->netfs.inode.i_mode))
+		invalidate_remote_inode(&vnode->netfs.inode);
+	else
+		invalidate_inode_pages2(vnode->netfs.inode.i_mapping);
+}
+
+/*
+ * Check to see if we have a server currently serving this volume and that it
+ * hasn't been reinitialised or dropped from the list.
+ */
+static bool afs_check_server_good(struct afs_vnode *vnode)
+{
+	struct afs_server_list *slist;
+	struct afs_server *server;
+	bool good;
+	int i;
+
+	if (vnode->cb_fs_s_break == atomic_read(&vnode->volume->cell->fs_s_break))
+		return true;
+
+	rcu_read_lock();
+
+	slist = rcu_dereference(vnode->volume->servers);
+	for (i = 0; i < slist->nr_servers; i++) {
+		server = slist->servers[i].server;
+		if (server == vnode->cb_server) {
+			good = (vnode->cb_s_break == server->cb_s_break);
+			rcu_read_unlock();
+			return good;
+		}
+	}
+
+	rcu_read_unlock();
+	return false;
+}
+
+/*
+ * Check the validity of a vnode/inode.
+ */
+bool afs_check_validity(struct afs_vnode *vnode)
+{
+	enum afs_cb_break_reason need_clear = afs_cb_break_no_break;
+	time64_t now = ktime_get_real_seconds();
+	unsigned int cb_break;
+	int seq;
+
+	do {
+		seq = read_seqbegin(&vnode->cb_lock);
+		cb_break = vnode->cb_break;
+
+		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
+			if (vnode->cb_v_break != vnode->volume->cb_v_break)
+				need_clear = afs_cb_break_for_v_break;
+			else if (!afs_check_server_good(vnode))
+				need_clear = afs_cb_break_for_s_reinit;
+			else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
+				need_clear = afs_cb_break_for_zap;
+			else if (vnode->cb_expires_at - 10 <= now)
+				need_clear = afs_cb_break_for_lapsed;
+		} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+			;
+		} else {
+			need_clear = afs_cb_break_no_promise;
+		}
+
+	} while (read_seqretry(&vnode->cb_lock, seq));
+
+	if (need_clear == afs_cb_break_no_break)
+		return true;
+
+	write_seqlock(&vnode->cb_lock);
+	if (need_clear == afs_cb_break_no_promise)
+		vnode->cb_v_break = vnode->volume->cb_v_break;
+	else if (cb_break == vnode->cb_break)
+		__afs_break_callback(vnode, need_clear);
+	else
+		trace_afs_cb_miss(&vnode->fid, need_clear);
+	write_sequnlock(&vnode->cb_lock);
+	return false;
+}
+
+/*
+ * Returns true if the pagecache is still valid.  Does not sleep.
+ */
+bool afs_pagecache_valid(struct afs_vnode *vnode)
+{
+	if (unlikely(test_bit(AFS_VNODE_DELETED, &vnode->flags))) {
+		if (vnode->netfs.inode.i_nlink)
+			clear_nlink(&vnode->netfs.inode);
+		return true;
+	}
+
+	if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags) &&
+	    afs_check_validity(vnode))
+		return true;
+
+	return false;
+}
+
+/*
+ * validate a vnode/inode
+ * - there are several things we need to check
+ *   - parent dir data changes (rm, rmdir, rename, mkdir, create, link,
+ *     symlink)
+ *   - parent dir metadata changed (security changes)
+ *   - dentry data changed (write, truncate)
+ *   - dentry metadata changed (security changes)
+ */
+int afs_validate(struct afs_vnode *vnode, struct key *key)
+{
+	int ret;
+
+	_enter("{v={%llx:%llu} fl=%lx},%x",
+	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
+	       key_serial(key));
+
+	if (afs_pagecache_valid(vnode))
+		goto valid;
+
+	down_write(&vnode->validate_lock);
+
+	/* if the promise has expired, we need to check the server again to get
+	 * a new promise - note that if the (parent) directory's metadata was
+	 * changed then the security may be different and we may no longer have
+	 * access */
+	if (!test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
+		_debug("not promised");
+		ret = afs_fetch_status(vnode, key, false, NULL);
+		if (ret < 0) {
+			if (ret == -ENOENT) {
+				set_bit(AFS_VNODE_DELETED, &vnode->flags);
+				ret = -ESTALE;
+			}
+			goto error_unlock;
+		}
+		_debug("new promise [fl=%lx]", vnode->flags);
+	}
+
+	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+		_debug("file already deleted");
+		ret = -ESTALE;
+		goto error_unlock;
+	}
+
+	/* if the vnode's data version number changed then its contents are
+	 * different */
+	if (test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
+		afs_zap_data(vnode);
+	up_write(&vnode->validate_lock);
+valid:
+	_leave(" = 0");
+	return 0;
+
+error_unlock:
+	up_write(&vnode->validate_lock);
+	_leave(" = %d", ret);
+	return ret;
+}

