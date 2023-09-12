Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B73C79DAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjILVZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjILVZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:25:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED48E10CC;
        Tue, 12 Sep 2023 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694553900;
        bh=Wmu1+Z9yrBCAmEnc1DatlQpRMBdDXqfSMezQJyU+ih8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=U9FnZjwVVDq/gFpBj0poKZjyMq+xOqtkKuIxgzMiEEITTDD8kyEy05bjzsadaCi1H
         R+44xIV44q9At6udAO7CH/Q8pHUUGYHvoLhKACav6DnF5qmMQ9bZwHe7u9ShppoiJm
         IMpcP97IjxyBzpKw8tGYV8i32TBv9oPqahg95RQg=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 12 Sep 2023 23:24:44 +0200
Subject: [PATCH 5/5] bcachefs: Avoid unused symbol warnings from headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230912-bcachefs-cleanup-v1-5-c1f717424e6a@weissschuh.net>
References: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
In-Reply-To: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694553898; l=7973;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Wmu1+Z9yrBCAmEnc1DatlQpRMBdDXqfSMezQJyU+ih8=;
 b=6uesjb03g638/ql3k0Md5pUt3lb4dz/4y+OxV5wT8bheOXgdQ4HJVsSg9D4cGnQub5Q+RKDQd
 5EgP5mC6dl5BRUAf9YBZ8jB5Xb2G8XLxegiTSIVqflhMwBwnSiRJlCE
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables defined in headers generate unused variable compiler
warnings in CUs that do not use said functions.
Avoid the warnings by either replacing the variables by enums and by
explicitly inhibiting the warning.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/bcachefs/bcachefs.h        |  3 ++-
 fs/bcachefs/bcachefs_format.h | 15 ++++++-----
 fs/bcachefs/btree_types.h     | 63 ++++++++++++++++++++++---------------------
 fs/bcachefs/fs-ioctl.h        |  8 +++---
 fs/bcachefs/opts.h            |  3 ++-
 5 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 30b3d7b9f9dc..b5a8ea44f9ef 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -186,6 +186,7 @@
 #include <linux/backing-dev-defs.h>
 #include <linux/bug.h>
 #include <linux/bio.h>
+#include <linux/compiler.h>
 #include <linux/closure.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
@@ -371,7 +372,7 @@ BCH_DEBUG_PARAMS()
 #undef BCH_DEBUG_PARAM
 
 #ifndef CONFIG_BCACHEFS_DEBUG
-#define BCH_DEBUG_PARAM(name, description) static const bool bch2_##name;
+#define BCH_DEBUG_PARAM(name, description) static const __used bool bch2_##name;
 BCH_DEBUG_PARAMS_DEBUG()
 #undef BCH_DEBUG_PARAM
 #endif
diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index 1cce2504bca6..a13455dbb32c 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -74,6 +74,7 @@
 
 #include <asm/types.h>
 #include <asm/byteorder.h>
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/uuid.h>
 #include "vstructs.h"
@@ -83,8 +84,8 @@ typedef uuid_t __uuid_t;
 #endif
 
 #define BITMASK(name, type, field, offset, end)				\
-static const unsigned	name##_OFFSET = offset;				\
-static const unsigned	name##_BITS = (end - offset);			\
+static const __used unsigned	name##_OFFSET = offset;			\
+static const __used unsigned	name##_BITS = (end - offset);		\
 									\
 static inline __u64 name(const type *k)					\
 {									\
@@ -98,9 +99,9 @@ static inline void SET_##name(type *k, __u64 v)				\
 }
 
 #define LE_BITMASK(_bits, name, type, field, offset, end)		\
-static const unsigned	name##_OFFSET = offset;				\
-static const unsigned	name##_BITS = (end - offset);			\
-static const __u##_bits	name##_MAX = (1ULL << (end - offset)) - 1;	\
+static const __used unsigned	name##_OFFSET = offset;			\
+static const __used unsigned	name##_BITS = (end - offset);		\
+static const __used __u##_bits	name##_MAX = (1ULL << (end - offset)) - 1; \
 									\
 static inline __u64 name(const type *k)					\
 {									\
@@ -1639,7 +1640,7 @@ enum bcachefs_metadata_version {
 	bcachefs_metadata_version_max
 };
 
-static const unsigned bcachefs_metadata_required_upgrade_below = bcachefs_metadata_version_major_minor;
+static const __used unsigned bcachefs_metadata_required_upgrade_below = bcachefs_metadata_version_major_minor;
 
 #define bcachefs_metadata_version_current	(bcachefs_metadata_version_max - 1)
 
@@ -1946,7 +1947,7 @@ enum bch_csum_type {
 	BCH_CSUM_NR
 };
 
-static const unsigned bch_crc_bytes[] = {
+static const __used unsigned bch_crc_bytes[] = {
 	[BCH_CSUM_none]				= 0,
 	[BCH_CSUM_crc32c_nonzero]		= 4,
 	[BCH_CSUM_crc32c]			= 4,
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index 70398aaa095e..a9ab52e8f9d9 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -181,36 +181,39 @@ struct btree_node_iter {
 	} data[MAX_BSETS];
 };
 
-/*
- * Iterate over all possible positions, synthesizing deleted keys for holes:
- */
-static const u16 BTREE_ITER_SLOTS		= 1 << 0;
-static const u16 BTREE_ITER_ALL_LEVELS		= 1 << 1;
-/*
- * Indicates that intent locks should be taken on leaf nodes, because we expect
- * to be doing updates:
- */
-static const u16 BTREE_ITER_INTENT		= 1 << 2;
-/*
- * Causes the btree iterator code to prefetch additional btree nodes from disk:
- */
-static const u16 BTREE_ITER_PREFETCH		= 1 << 3;
-/*
- * Used in bch2_btree_iter_traverse(), to indicate whether we're searching for
- * @pos or the first key strictly greater than @pos
- */
-static const u16 BTREE_ITER_IS_EXTENTS		= 1 << 4;
-static const u16 BTREE_ITER_NOT_EXTENTS		= 1 << 5;
-static const u16 BTREE_ITER_CACHED		= 1 << 6;
-static const u16 BTREE_ITER_WITH_KEY_CACHE	= 1 << 7;
-static const u16 BTREE_ITER_WITH_UPDATES	= 1 << 8;
-static const u16 BTREE_ITER_WITH_JOURNAL	= 1 << 9;
-static const u16 __BTREE_ITER_ALL_SNAPSHOTS	= 1 << 10;
-static const u16 BTREE_ITER_ALL_SNAPSHOTS	= 1 << 11;
-static const u16 BTREE_ITER_FILTER_SNAPSHOTS	= 1 << 12;
-static const u16 BTREE_ITER_NOPRESERVE		= 1 << 13;
-static const u16 BTREE_ITER_CACHED_NOFILL	= 1 << 14;
-static const u16 BTREE_ITER_KEY_CACHE_FILL	= 1 << 15;
+enum {
+	/*
+	 * Iterate over all possible positions, synthesizing deleted keys for holes:
+	 */
+	BTREE_ITER_SLOTS		= 1 << 0,
+	BTREE_ITER_ALL_LEVELS		= 1 << 1,
+	/*
+	 * Indicates that intent locks should be taken on leaf nodes, because we expect
+	 * to be doing updates:
+	 */
+	BTREE_ITER_INTENT		= 1 << 2,
+	/*
+	 * Causes the btree iterator code to prefetch additional btree nodes from disk:
+	 */
+	BTREE_ITER_PREFETCH		= 1 << 3,
+
+	/*
+	 * Used in bch2_btree_iter_traverse(), to indicate whether we're searching for
+	 * @pos or the first key strictly greater than @pos
+	 */
+	BTREE_ITER_IS_EXTENTS		= 1 << 4,
+	BTREE_ITER_NOT_EXTENTS		= 1 << 5,
+	BTREE_ITER_CACHED		= 1 << 6,
+	BTREE_ITER_WITH_KEY_CACHE	= 1 << 7,
+	BTREE_ITER_WITH_UPDATES		= 1 << 8,
+	BTREE_ITER_WITH_JOURNAL		= 1 << 9,
+	__BTREE_ITER_ALL_SNAPSHOTS	= 1 << 10,
+	BTREE_ITER_ALL_SNAPSHOTS	= 1 << 11,
+	BTREE_ITER_FILTER_SNAPSHOTS	= 1 << 12,
+	BTREE_ITER_NOPRESERVE		= 1 << 13,
+	BTREE_ITER_CACHED_NOFILL	= 1 << 14,
+	BTREE_ITER_KEY_CACHE_FILL	= 1 << 15,
+};
 #define __BTREE_ITER_FLAGS_END			       16
 
 enum btree_path_uptodate {
diff --git a/fs/bcachefs/fs-ioctl.h b/fs/bcachefs/fs-ioctl.h
index f201980ef2c3..0ebf4106ed2f 100644
--- a/fs/bcachefs/fs-ioctl.h
+++ b/fs/bcachefs/fs-ioctl.h
@@ -2,10 +2,12 @@
 #ifndef _BCACHEFS_FS_IOCTL_H
 #define _BCACHEFS_FS_IOCTL_H
 
+#include <linux/compiler.h>
+
 /* Inode flags: */
 
 /* bcachefs inode flags -> vfs inode flags: */
-static const unsigned bch_flags_to_vfs[] = {
+static const __used unsigned bch_flags_to_vfs[] = {
 	[__BCH_INODE_SYNC]	= S_SYNC,
 	[__BCH_INODE_IMMUTABLE]	= S_IMMUTABLE,
 	[__BCH_INODE_APPEND]	= S_APPEND,
@@ -13,7 +15,7 @@ static const unsigned bch_flags_to_vfs[] = {
 };
 
 /* bcachefs inode flags -> FS_IOC_GETFLAGS: */
-static const unsigned bch_flags_to_uflags[] = {
+static const __used unsigned bch_flags_to_uflags[] = {
 	[__BCH_INODE_SYNC]	= FS_SYNC_FL,
 	[__BCH_INODE_IMMUTABLE]	= FS_IMMUTABLE_FL,
 	[__BCH_INODE_APPEND]	= FS_APPEND_FL,
@@ -22,7 +24,7 @@ static const unsigned bch_flags_to_uflags[] = {
 };
 
 /* bcachefs inode flags -> FS_IOC_FSGETXATTR: */
-static const unsigned bch_flags_to_xflags[] = {
+static const __used unsigned bch_flags_to_xflags[] = {
 	[__BCH_INODE_SYNC]	= FS_XFLAG_SYNC,
 	[__BCH_INODE_IMMUTABLE]	= FS_XFLAG_IMMUTABLE,
 	[__BCH_INODE_APPEND]	= FS_XFLAG_APPEND,
diff --git a/fs/bcachefs/opts.h b/fs/bcachefs/opts.h
index 8a9db110d64f..35831159e207 100644
--- a/fs/bcachefs/opts.h
+++ b/fs/bcachefs/opts.h
@@ -3,6 +3,7 @@
 #define _BCACHEFS_OPTS_H
 
 #include <linux/bug.h>
+#include <linux/compiler.h>
 #include <linux/log2.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
@@ -469,7 +470,7 @@ struct bch_opts {
 #undef x
 };
 
-static const struct bch_opts bch2_opts_default = {
+static const __used struct bch_opts bch2_opts_default = {
 #define x(_name, _bits, _mode, _type, _sb_opt, _default, ...)		\
 	._name##_defined = true,					\
 	._name = _default,						\

-- 
2.42.0

