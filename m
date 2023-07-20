Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312375A6FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjGTGzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGTGzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:55:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939B10A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:55:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704991ea05so5205497b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689836102; x=1690440902;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6NrGsEHnDYLyNJqvwAEW/Qe4/fd0kz4NPjCMl8a0lCE=;
        b=B91pALtjxL5niF8zoPcxIastjU+J9gimCXkruBNCQgADWJtxA2+JER3zmkYzVkBBnk
         MvJwm/C0aEkPVxXfGRILNGsfW+DCjRvkN2GoXMuBDJFzxBMuOmkMPA6r1yjpFTrlLqV0
         5A857sKZKzdSJ1h8yoJs+rV8gU6iKSjZoLIIV06U9sHuVwsIyUZNtm/EUC+DqkMLS28C
         GtVj3AUgrHYm4Mr2CcyYGim3H+S8aBtZ+sIaEgyI66wwU5RR75WHtQ/E/FgOskhAT+B4
         ZQI80x8YwsoeL/4NBtHVERFqXesvL70UhpBOW1hV+yoU71HAb+FzGMlFAEJo1gRiVrLf
         LtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836102; x=1690440902;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6NrGsEHnDYLyNJqvwAEW/Qe4/fd0kz4NPjCMl8a0lCE=;
        b=HfkJjf0YuQZHps5YlWvsRk0knPembcDWRZ1So7qHQ80CmqR/DgTcVQmk+Xa2AxDZd6
         lLY94xBkfmn9DiUq9YEfBsD0F8kLUTqGyUF1tdwaKnqvdBtUzVH1DEP3XOvIywB1rIEI
         nZJtZGlSakM785AQ2+qKg+ihWiYNPIAohDTs8LqgDhR59BWMYZ0yKNhQd7u2Jn8lOzZ7
         b8rOzJkmf0b01J7Wcre6PRG9Yy6omZ1FG9HHmllcEh+RNcvogBnTqdWOpGa9rDctR1mV
         tr//SWhozff3Imtvzri4qyAxUgHGZsFiMyfFitCkyWH8AyJeTh0gFgDZ3m9oYCMgtjT7
         npAw==
X-Gm-Message-State: ABy/qLZ4WkwO1T6saWE5XHithIrLNUSaNV+ccAaB25TLvZgxYObTgjAU
        TzxhwcyTsPJiBtJti4dc9HOBRCQ=
X-Google-Smtp-Source: APBJJlFhZw/NRj76MsfDecdVc5P9tSi1HtsFkfBgB68OTX2wk1VwPDXGlGw/6crZl26Lw5teVJQDgIc=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a81:8d47:0:b0:573:8316:8d04 with SMTP id
 w7-20020a818d47000000b0057383168d04mr74936ywj.4.1689836101886; Wed, 19 Jul
 2023 23:55:01 -0700 (PDT)
Date:   Thu, 20 Jul 2023 06:54:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720065430.2178136-1-ovt@google.com>
Subject: [PATCH] shmem: add support for user extended attributes
From:   Oleksandr Tymoshenko <ovt@google.com>
To:     Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ovt@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User extended attributes are not enabled in tmpfs because
the size of the value is not limited and the memory allocated
for it is not counted against any limit. Malicious
non-privileged user can exhaust kernel memory by creating
user.* extended attribute with very large value.

There are still situations when enabling suport for extended
user attributes on tmpfs is required and the attack vector
is not applicable, for instance batch jobs with trusted binaries.

This patch introduces two mount options to enable/disable
support for user.* extended attributes on tmpfs:

user_xattr    enable support for user extended aatributes
nouser_xattr  disable support for user extended attributes

The default behavior of the filesystem is not changed.

Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 Documentation/filesystems/tmpfs.rst | 12 ++++++++
 include/linux/shmem_fs.h            |  1 +
 mm/shmem.c                          | 45 +++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index f18f46be5c0c..5700ba72d095 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -215,6 +215,16 @@ will give you tmpfs instance on /mytmpfs which can allocate 10GB
 RAM/SWAP in 10240 inodes and it is only accessible by root.
 
 
+tmpfs, when compiled with CONFIG_TMPFS_XATTR, does not support
+Extended User Attributes for security reasons. The support can be
+enabled/disabled by two mount options:
+
+============  ===========================================
+user_xattr    Enable support for Extended User Attributes
+nouser_xattr  Disable upport for Extended User Attributes
+============  ===========================================
+
+
 :Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
 :Updated:
@@ -223,3 +233,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by root.
    KOSAKI Motohiro, 16 Mar 2010
 :Updated:
    Chris Down, 13 July 2020
+:Updated:
+   Oleksandr Tymoshenko, 19 July 2023
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 9029abd29b1c..f06d18b9041c 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -53,6 +53,7 @@ struct shmem_sb_info {
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
+	bool user_xattr;	      /* user.* xattrs are allowed */
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
diff --git a/mm/shmem.c b/mm/shmem.c
index 2f2e0e618072..4f7d46d65494 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -85,6 +85,7 @@ static struct vfsmount *shm_mnt;
 
 #define BLOCKS_PER_PAGE  (PAGE_SIZE/512)
 #define VM_ACCT(size)    (PAGE_ALIGN(size) >> PAGE_SHIFT)
+#define TMPFS_USER_XATTR_INDEX 1
 
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
@@ -116,11 +117,13 @@ struct shmem_options {
 	int huge;
 	int seen;
 	bool noswap;
+	bool user_xattr;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
 #define SHMEM_SEEN_NOSWAP 16
+#define SHMEM_SEEN_USER_XATTR 32
 };
 
 #ifdef CONFIG_TMPFS
@@ -3447,6 +3450,16 @@ static int shmem_xattr_handler_get(const struct xattr_handler *handler,
 				   const char *name, void *buffer, size_t size)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+
+	switch (handler->flags) {
+	case TMPFS_USER_XATTR_INDEX:
+		if (!sbinfo->user_xattr)
+			return -EOPNOTSUPP;
+		break;
+	default:
+		break;
+	}
 
 	name = xattr_full_name(handler, name);
 	return simple_xattr_get(&info->xattrs, name, buffer, size);
@@ -3459,8 +3472,18 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 				   size_t size, int flags)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	int err;
 
+	switch (handler->flags) {
+	case TMPFS_USER_XATTR_INDEX:
+		if (!sbinfo->user_xattr)
+			return -EOPNOTSUPP;
+		break;
+	default:
+		break;
+	}
+
 	name = xattr_full_name(handler, name);
 	err = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
 	if (!err) {
@@ -3482,9 +3505,17 @@ static const struct xattr_handler shmem_trusted_xattr_handler = {
 	.set = shmem_xattr_handler_set,
 };
 
+static const struct xattr_handler shmem_user_xattr_handler = {
+	.prefix = XATTR_USER_PREFIX,
+	.flags = TMPFS_USER_XATTR_INDEX,
+	.get = shmem_xattr_handler_get,
+	.set = shmem_xattr_handler_set,
+};
+
 static const struct xattr_handler *shmem_xattr_handlers[] = {
 	&shmem_security_xattr_handler,
 	&shmem_trusted_xattr_handler,
+	&shmem_user_xattr_handler,
 	NULL
 };
 
@@ -3604,6 +3635,8 @@ enum shmem_param {
 	Opt_inode32,
 	Opt_inode64,
 	Opt_noswap,
+	Opt_user_xattr,
+	Opt_nouser_xattr,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3626,6 +3659,8 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
 	fsparam_flag  ("noswap",	Opt_noswap),
+	fsparam_flag  ("user_xattr",	Opt_user_xattr),
+	fsparam_flag  ("nouser_xattr",	Opt_nouser_xattr),
 	{}
 };
 
@@ -3717,6 +3752,14 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->noswap = true;
 		ctx->seen |= SHMEM_SEEN_NOSWAP;
 		break;
+	case Opt_user_xattr:
+		ctx->user_xattr = true;
+		ctx->seen |= SHMEM_SEEN_USER_XATTR;
+		break;
+	case Opt_nouser_xattr:
+		ctx->user_xattr = false;
+		ctx->seen |= SHMEM_SEEN_USER_XATTR;
+		break;
 	}
 	return 0;
 
@@ -3834,6 +3877,8 @@ static int shmem_reconfigure(struct fs_context *fc)
 		sbinfo->max_inodes  = ctx->inodes;
 		sbinfo->free_inodes = ctx->inodes - inodes;
 	}
+	if (ctx->seen & SHMEM_SEEN_USER_XATTR)
+		sbinfo->user_xattr = ctx->user_xattr;
 
 	/*
 	 * Preserve previous mempolicy unless mpol remount option was specified.
-- 
2.41.0.255.g8b1d071c50-goog

