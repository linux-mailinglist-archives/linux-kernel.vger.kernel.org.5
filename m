Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769DE7C8EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjJMVLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMVL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:11:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3668CB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:11:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9b1e3a809so19470515ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1697231487; x=1697836287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4q1GE4xeOKxu5p4/yG/LK2JSVB5/5t0mNVDObbpOf4=;
        b=NvtOzWVZs2ZIvdzX+XVrHRWymMivxcI7GuRpVZO9efj/oEYyTc83uMBuO/8QMO6qI0
         pi3E2eJlPoWdudFogp80a73wckMkT+o49iZ1moAEH2mhIIxJTggFnLyc63oqb0IQtaIw
         rOTaqFlafobDs4P7E+YhDCOanWxeWfY4h55jgwSAqggof+3T1DpGePSCf9NHGy7UalUj
         TQngSy1ErumErbDogmZ7AuHxPeid1jAv8VWxW5pZltyx0zT19sNkE05YEXM0S15p1rXx
         Kswy7IKwKEQpALkAolZGn42JE6G6qzPWmHVsY1tYowubM6dIqxsBeZNowIpANjQZtChC
         PxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231487; x=1697836287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4q1GE4xeOKxu5p4/yG/LK2JSVB5/5t0mNVDObbpOf4=;
        b=IDiWMTUV9Wnw5kggjML8BfnY0NRim7+SY80al4qyRoL1Kbfz+s9O8xkMEhoDYc8obS
         4AC3MueI7xqAgmK68KQGrN2Qj1F3hskHUaqjesqd6Vr+58DEr5brda5cUU3OoSzXgw9d
         rGnCth4Z0QqmHVORZhhoEV5+ZHaXDzVnl+PTZrUG4ZfTuUAizo2L8eURbRnHdB/qU8VB
         SbUO9DMNDofqTLNnBfwU7UqFpKWx29AVCVdsYXRXIsgPtbG2kPR0xEatYuZxDHDxT7bU
         y1JgF8JKF2Vzt7clrMBs9VFy8qNjY+amdAFT3olU55aC67BsI8AvZEo5YxvfO9ecxXre
         9R1A==
X-Gm-Message-State: AOJu0YxKizdax5UtSH2z2VjOx2nK0cd3e1xBQ4Zq8afcmlI7nD8pYFrf
        f9ACyH8oA7Neh6cCCvQCQ5DtWA==
X-Google-Smtp-Source: AGHT+IHJ1UjeMRKPWbfrZFleco6sk16Ck9IvKzIV5T/aPvHCCKEm7tGpsv5/5PzTOT96Mf1ofmvhWA==
X-Received: by 2002:a17:902:c40a:b0:1c7:5a63:43bb with SMTP id k10-20020a170902c40a00b001c75a6343bbmr35075417plk.8.1697231487629;
        Fri, 13 Oct 2023 14:11:27 -0700 (PDT)
Received: from localhost ([208.88.159.128])
        by smtp.gmail.com with UTF8SMTPSA id x4-20020a170902ea8400b001c5076ae6absm4292850plb.126.2023.10.13.14.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 14:11:27 -0700 (PDT)
From:   Seamus Connor <sconnor@purestorage.com>
To:     Joel Becker <jlbec@evilplan.org>
Cc:     Seamus Connor <sconnor@purestorage.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] configfs: improve item creation performance
Date:   Fri, 13 Oct 2023 14:11:29 -0700
Message-Id: <20231013211129.72592-1-sconnor@purestorage.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <ZShUmLU3X5QMiWQH@google.com>
References: <ZShUmLU3X5QMiWQH@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the size of a directory increases item creation slows down.
Optimizing access to s_children removes this bottleneck.

dirents are already pinned into the cache, there is no need to scan the
s_children list looking for duplicate Items. The configfs_dirent_exists
check is moved to a location where it is called only during subsystem
initialization.

d_lookup will only need to call configfs_lookup in the case where the
item in question is not pinned to dcache. The only items not pinned to
dcache are attributes. These are placed at the front of the s_children
list, whilst pinned items are inserted at the back. configfs_lookup
stops scanning when it encounters the first pinned entry in s_children.

The assumption of the above optimizations is that there will be few
attributes, but potentially many Items in a given directory.

Signed-off-by: Seamus Connor <sconnor@purestorage.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
---

In this revision I've added some commentary describing the changes, and
I have removed a helper function.

 fs/configfs/configfs_internal.h |  3 +--
 fs/configfs/dir.c               | 39 +++++++++++++++++++++++++--------
 fs/configfs/inode.c             | 24 --------------------
 3 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index c0395363eab9..b91036fd71b1 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -55,6 +55,7 @@ struct configfs_dirent {
 #define CONFIGFS_USET_IN_MKDIR	0x0200
 #define CONFIGFS_USET_CREATING	0x0400
 #define CONFIGFS_NOT_PINNED	(CONFIGFS_ITEM_ATTR | CONFIGFS_ITEM_BIN_ATTR)
+#define CONFIGFS_PINNED		(CONFIGFS_ROOT | CONFIGFS_DIR | CONFIGFS_ITEM_LINK)
 
 extern struct mutex configfs_symlink_mutex;
 extern spinlock_t configfs_dirent_lock;
@@ -73,8 +74,6 @@ extern int configfs_make_dirent(struct configfs_dirent *, struct dentry *,
 				void *, umode_t, int, struct configfs_fragment *);
 extern int configfs_dirent_is_ready(struct configfs_dirent *);
 
-extern void configfs_hash_and_remove(struct dentry * dir, const char * name);
-
 extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
 extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
 extern int configfs_setattr(struct user_namespace *mnt_userns,
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index d1f9d2632202..64a0eac83b90 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -207,7 +207,17 @@ static struct configfs_dirent *configfs_new_dirent(struct configfs_dirent *paren
 		return ERR_PTR(-ENOENT);
 	}
 	sd->s_frag = get_fragment(frag);
-	list_add(&sd->s_sibling, &parent_sd->s_children);
+
+	/*
+	 * configfs_lookup scans only for unpinned items. s_children is
+	 * partitioned so that configfs_lookup can bail out early.
+	 * CONFIGFS_PINNED and CONFIGFS_NOT_PINNED are not symmetrical.  readdir
+	 * cursors still need to be inserted at the front of the list.
+	 */
+	if (sd->s_type & CONFIGFS_PINNED)
+		list_add_tail(&sd->s_sibling, &parent_sd->s_children);
+	else
+		list_add(&sd->s_sibling, &parent_sd->s_children);
 	spin_unlock(&configfs_dirent_lock);
 
 	return sd;
@@ -220,10 +230,11 @@ static struct configfs_dirent *configfs_new_dirent(struct configfs_dirent *paren
  *
  * called with parent inode's i_mutex held
  */
-static int configfs_dirent_exists(struct configfs_dirent *parent_sd,
-				  const unsigned char *new)
+static int configfs_dirent_exists(struct dentry *dentry)
 {
-	struct configfs_dirent * sd;
+	struct configfs_dirent *parent_sd = dentry->d_parent->d_fsdata;
+	const unsigned char *new = dentry->d_name.name;
+	struct configfs_dirent *sd;
 
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_element) {
@@ -289,10 +300,6 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
 
 	BUG_ON(!item);
 
-	error = configfs_dirent_exists(p->d_fsdata, dentry->d_name.name);
-	if (unlikely(error))
-		return error;
-
 	error = configfs_make_dirent(p->d_fsdata, dentry, item, mode,
 				     CONFIGFS_DIR | CONFIGFS_USET_CREATING,
 				     frag);
@@ -449,6 +456,18 @@ static struct dentry * configfs_lookup(struct inode *dir,
 
 	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+
+		/*
+		 * s_children is partitioned, see configfs_new_dirent. The first
+		 * pinned item indicates we can stop scanning.
+		 */
+		if (sd->s_type & CONFIGFS_PINNED)
+			break;
+
+		/*
+		 * Note: CONFIGFS_PINNED and CONFIGFS_NOT_PINNED are asymmetric.
+		 * there may be a readdir cursor in this list
+		 */
 		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
 		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
 			struct configfs_attribute *attr = sd->s_element;
@@ -1878,7 +1897,9 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	if (dentry) {
 		d_add(dentry, NULL);
 
-		err = configfs_attach_group(sd->s_element, &group->cg_item,
+		err = configfs_dirent_exists(dentry);
+		if (!err)
+			err = configfs_attach_group(sd->s_element, &group->cg_item,
 					    dentry, frag);
 		if (err) {
 			BUG_ON(d_inode(dentry));
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index b601610e9907..15964e62329d 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -218,27 +218,3 @@ void configfs_drop_dentry(struct configfs_dirent * sd, struct dentry * parent)
 	}
 }
 
-void configfs_hash_and_remove(struct dentry * dir, const char * name)
-{
-	struct configfs_dirent * sd;
-	struct configfs_dirent * parent_sd = dir->d_fsdata;
-
-	if (d_really_is_negative(dir))
-		/* no inode means this hasn't been made visible yet */
-		return;
-
-	inode_lock(d_inode(dir));
-	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
-		if (!sd->s_element)
-			continue;
-		if (!strcmp(configfs_get_name(sd), name)) {
-			spin_lock(&configfs_dirent_lock);
-			list_del_init(&sd->s_sibling);
-			spin_unlock(&configfs_dirent_lock);
-			configfs_drop_dentry(sd, dir);
-			configfs_put(sd);
-			break;
-		}
-	}
-	inode_unlock(d_inode(dir));
-}
-- 
2.37.0

