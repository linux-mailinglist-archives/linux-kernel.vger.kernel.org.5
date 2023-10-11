Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41E37C5F35
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376363AbjJKVjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjJKVjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:39:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130279E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:39:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c88b467ef8so2702555ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1697060371; x=1697665171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cij0IHyKXxY2hfYjR0uKzbBaeg3ESIIhBuOBo9zIxPc=;
        b=fk9yK9phLrPkK1mdMmmwdCo/w3s3XlWzfrUxDbwZbnQ7LNGfjWrboURF99oP2OTFwN
         wlEue02D192aV5DoF3FF27TgNUvKzBgeYXu56NXeP3Onj/1PZyc1dpv+wGECjL3PbMhS
         qTBiVYwRx/wUs6jdkMZydxHSDxqEvfEudeww7u6f7zSHjY87EjhwujQYFaQDa+6G8RaL
         jodHTWwPawE1VVEdRdA+xmlUBtKUK87O84itNkCLXTdiapttArGfmmGLriXGQsryRdLd
         ANHvoklOF4NmN1DpTfXOQPIi60irYsWAeAoX9pywmms+gC6YSNQVvcArThQaOzjxpdEO
         3EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060371; x=1697665171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cij0IHyKXxY2hfYjR0uKzbBaeg3ESIIhBuOBo9zIxPc=;
        b=gty69oW9ShhC1FIchPs5bzZNVYmnkxOA/CyvGvy7KVjr4otVYIGiU0Zt39ruO8iOE9
         nEFrkcZVx1ZRJLD05ivA2zOT1oNPH43M8d+g4DpXkoqKsx/u28PAWJnr0Jwyke4zkDRN
         qy4HWD+wTffL9s/59WV7QLOZ0dcgScop3pAQJpyisLpU/DlIefo385wLAb+Cb82m0Bpg
         zzZhsk0PkNVx5BoYsS0FZUpTN1vPqXpIraZZMH4DDOB0s6A3C1A4flzqvUa1T+WpDweU
         X5uEBduolN4ifkP3fB/iaIDHxTp9/1xxifRgavUf85mvY7/NY4tsIFQbH4mLEHfX5DQw
         X/MQ==
X-Gm-Message-State: AOJu0Yxd8z4KAP5umsHPsiGQ0MccxKuaVMkBAWLKGlZRQnqQ7WG+n3gZ
        4emw4ul2nm9haWWdMkVX8pANAquKDJ+pmG91xXk=
X-Google-Smtp-Source: AGHT+IH2eARgwEAScz7GnH/+FJIK2sIwkOke97H4tzlK25ftZMA+W/nsubxcbD3nmZwSZQ1mvPikGA==
X-Received: by 2002:a17:902:b7c3:b0:1c9:de48:fc78 with SMTP id v3-20020a170902b7c300b001c9de48fc78mr388664plz.7.1697060371397;
        Wed, 11 Oct 2023 14:39:31 -0700 (PDT)
Received: from localhost ([208.88.159.129])
        by smtp.gmail.com with UTF8SMTPSA id f4-20020a17090274c400b001c407fac227sm318183plt.41.2023.10.11.14.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 14:39:30 -0700 (PDT)
From:   Seamus Connor <sconnor@purestorage.com>
To:     jlbec@evilplan.org
Cc:     Seamus Connor <sconnor@purestorage.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] [WIP] configfs: improve item creation performance
Date:   Wed, 11 Oct 2023 14:39:19 -0700
Message-Id: <20231011213919.52267-1-sconnor@purestorage.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

On my machine, creating 40,000 Items in a single directory takes roughly
40 seconds. With this patch applied, that time drops down to around 130
ms.

Signed-off-by: Seamus Connor <sconnor@purestorage.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
---

Thanks for taking a look. I've done some testing of this patch and it
seems to work well for my use case (LIO). I would like to get feedback
from the maintainers and work this change upstream if possible.

Thanks!


 fs/configfs/configfs_internal.h |  3 +--
 fs/configfs/dir.c               | 29 ++++++++++++++++++++---------
 fs/configfs/inode.c             | 24 ------------------------
 3 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index c0395363eab9..9501c4106bda 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -55,6 +55,7 @@ struct configfs_dirent {
 #define CONFIGFS_USET_IN_MKDIR	0x0200
 #define CONFIGFS_USET_CREATING	0x0400
 #define CONFIGFS_NOT_PINNED	(CONFIGFS_ITEM_ATTR | CONFIGFS_ITEM_BIN_ATTR)
+#define CONFIGFS_IS_PINNED	(CONFIGFS_ROOT | CONFIGFS_DIR | CONFIGFS_ITEM_LINK)
 
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
index d1f9d2632202..e426c6a30ad6 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -182,6 +182,11 @@ struct configfs_fragment *get_fragment(struct configfs_fragment *frag)
 	return frag;
 }
 
+static bool configfs_dirent_is_pinned(struct configfs_dirent *sd)
+{
+	return sd->s_type & CONFIGFS_IS_PINNED;
+}
+
 /*
  * Allocates a new configfs_dirent and links it to the parent configfs_dirent
  */
@@ -207,7 +212,10 @@ static struct configfs_dirent *configfs_new_dirent(struct configfs_dirent *paren
 		return ERR_PTR(-ENOENT);
 	}
 	sd->s_frag = get_fragment(frag);
-	list_add(&sd->s_sibling, &parent_sd->s_children);
+	if (configfs_dirent_is_pinned(sd))
+		list_add_tail(&sd->s_sibling, &parent_sd->s_children);
+	else
+		list_add(&sd->s_sibling, &parent_sd->s_children);
 	spin_unlock(&configfs_dirent_lock);
 
 	return sd;
@@ -220,10 +228,11 @@ static struct configfs_dirent *configfs_new_dirent(struct configfs_dirent *paren
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
@@ -289,10 +298,6 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
 
 	BUG_ON(!item);
 
-	error = configfs_dirent_exists(p->d_fsdata, dentry->d_name.name);
-	if (unlikely(error))
-		return error;
-
 	error = configfs_make_dirent(p->d_fsdata, dentry, item, mode,
 				     CONFIGFS_DIR | CONFIGFS_USET_CREATING,
 				     frag);
@@ -449,6 +454,10 @@ static struct dentry * configfs_lookup(struct inode *dir,
 
 	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+
+		if (configfs_dirent_is_pinned(sd))
+			break;
+
 		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
 		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
 			struct configfs_attribute *attr = sd->s_element;
@@ -1878,7 +1887,9 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
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

