Return-Path: <linux-kernel+bounces-79930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CE48628D0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EBF282211
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032AD9445;
	Sun, 25 Feb 2024 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v1MNIKkb"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49A33E1
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828719; cv=none; b=d4T1l0lDd8dEzLyClbECZI87fCdNMPxxXsd2RvXUx0xFGl1JMjQhkyGaKLF3H6idM4uHmIwBNOo9zXr4ii36K9Fn92sUlFY15KJJW5NsBRR7IfdxSO+9u9a5Md/yQbfOPpPBfwSSVUoXPL8x7A6V2CB4ob+2SgIpOCR0DBfdK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828719; c=relaxed/simple;
	bh=HeNS1iPBZ5lAlddImoTA33wWf0HYkhdae2awGoF0K+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5Xyh9dn1SOVVyzSbBDcxWrUKEnqJqdwhSIVbaUw0FfJuM6obY7/zaXJUbQxRyzqybEzl2r2dcCFmGftJ2YbjzcjZSnn+djsZzHU4xjRFWvI+1b82qWLhAn5TTOdyGllmaD0IjATDA3WdnU/Be/p9OdjaUXv4Daa+9jt7kC8F70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v1MNIKkb; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl/wHtbVZwctaDzKPv15EO94P0+3HzLA0UW5JZF/pxI=;
	b=v1MNIKkbFwTFtfvLjog2D14bfQficAunRudKPocggSrwalxyTzlI/kLXdSKQHcufvWC4Zg
	8h9qboDqXIG39mInHi+z9p3D9LTfrz4CJMxApn4rxGCNjxeYNmHoIZMqQfrSkBJsbnxZb5
	2dBovt6i+oJCeXgaQYd8Fnghgq/3VsA=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 01/21] bcachefs: KEY_TYPE_accounting
Date: Sat, 24 Feb 2024 21:38:03 -0500
Message-ID: <20240225023826.2413565-2-kent.overstreet@linux.dev>
In-Reply-To: <20240225023826.2413565-1-kent.overstreet@linux.dev>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

New key type for the disk space accounting rewrite.

 - Holds a variable sized array of u64s (may be more than one for
   accounting e.g. compressed and uncompressed size, or buckets and
   sectors for a given data type)

 - Updates are deltas, not new versions of the key: this means updates
   to accounting can happen via the btree write buffer, which we'll be
   teaching to accumulate deltas.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/Makefile                 |   3 +-
 fs/bcachefs/bcachefs.h               |   1 +
 fs/bcachefs/bcachefs_format.h        |  80 +++------------
 fs/bcachefs/bkey_methods.c           |   1 +
 fs/bcachefs/disk_accounting.c        |  70 ++++++++++++++
 fs/bcachefs/disk_accounting.h        |  52 ++++++++++
 fs/bcachefs/disk_accounting_format.h | 139 +++++++++++++++++++++++++++
 fs/bcachefs/replicas_format.h        |  21 ++++
 fs/bcachefs/sb-downgrade.c           |  12 ++-
 fs/bcachefs/sb-errors_types.h        |   3 +-
 10 files changed, 311 insertions(+), 71 deletions(-)
 create mode 100644 fs/bcachefs/disk_accounting.c
 create mode 100644 fs/bcachefs/disk_accounting.h
 create mode 100644 fs/bcachefs/disk_accounting_format.h
 create mode 100644 fs/bcachefs/replicas_format.h

diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index f42f6d256945..94b2edb4155f 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -27,10 +27,11 @@ bcachefs-y		:=	\
 	checksum.o		\
 	clock.o			\
 	compress.o		\
+	data_update.o		\
 	debug.o			\
 	dirent.o		\
+	disk_accounting.o	\
 	disk_groups.o		\
-	data_update.o		\
 	ec.o			\
 	errcode.o		\
 	error.o			\
diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 0bee9dab6068..62812fc1cad0 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -509,6 +509,7 @@ enum gc_phase {
 	GC_PHASE_BTREE_logged_ops,
 	GC_PHASE_BTREE_rebalance_work,
 	GC_PHASE_BTREE_subvolume_children,
+	GC_PHASE_BTREE_accounting,
 
 	GC_PHASE_PENDING_DELETE,
 };
diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index bff8750ac0d7..313ca7dc370d 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -416,7 +416,8 @@ static inline void bkey_init(struct bkey *k)
 	x(bucket_gens,		30)			\
 	x(snapshot_tree,	31)			\
 	x(logged_op_truncate,	32)			\
-	x(logged_op_finsert,	33)
+	x(logged_op_finsert,	33)			\
+	x(accounting,		34)
 
 enum bch_bkey_type {
 #define x(name, nr) KEY_TYPE_##name	= nr,
@@ -501,17 +502,19 @@ struct bch_sb_field {
 	x(downgrade,			14)
 
 #include "alloc_background_format.h"
+#include "dirent_format.h"
+#include "disk_accounting_format.h"
 #include "extents_format.h"
-#include "reflink_format.h"
 #include "ec_format.h"
 #include "inode_format.h"
-#include "dirent_format.h"
-#include "xattr_format.h"
-#include "quota_format.h"
 #include "logged_ops_format.h"
+#include "quota_format.h"
+#include "reflink_format.h"
+#include "replicas_format.h"
+#include "sb-counters_format.h"
 #include "snapshot_format.h"
 #include "subvolume_format.h"
-#include "sb-counters_format.h"
+#include "xattr_format.h"
 
 enum bch_sb_field_type {
 #define x(f, nr)	BCH_SB_FIELD_##f = nr,
@@ -680,69 +683,11 @@ LE64_BITMASK(BCH_KDF_SCRYPT_P,	struct bch_sb_field_crypt, kdf_flags, 32, 48);
 
 /* BCH_SB_FIELD_replicas: */
 
-#define BCH_DATA_TYPES()		\
-	x(free,		0)		\
-	x(sb,		1)		\
-	x(journal,	2)		\
-	x(btree,	3)		\
-	x(user,		4)		\
-	x(cached,	5)		\
-	x(parity,	6)		\
-	x(stripe,	7)		\
-	x(need_gc_gens,	8)		\
-	x(need_discard,	9)
-
-enum bch_data_type {
-#define x(t, n) BCH_DATA_##t,
-	BCH_DATA_TYPES()
-#undef x
-	BCH_DATA_NR
-};
-
-static inline bool data_type_is_empty(enum bch_data_type type)
-{
-	switch (type) {
-	case BCH_DATA_free:
-	case BCH_DATA_need_gc_gens:
-	case BCH_DATA_need_discard:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static inline bool data_type_is_hidden(enum bch_data_type type)
-{
-	switch (type) {
-	case BCH_DATA_sb:
-	case BCH_DATA_journal:
-		return true;
-	default:
-		return false;
-	}
-}
-
-struct bch_replicas_entry_v0 {
-	__u8			data_type;
-	__u8			nr_devs;
-	__u8			devs[];
-} __packed;
-
 struct bch_sb_field_replicas_v0 {
 	struct bch_sb_field	field;
 	struct bch_replicas_entry_v0 entries[];
 } __packed __aligned(8);
 
-struct bch_replicas_entry_v1 {
-	__u8			data_type;
-	__u8			nr_devs;
-	__u8			nr_required;
-	__u8			devs[];
-} __packed;
-
-#define replicas_entry_bytes(_i)					\
-	(offsetof(typeof(*(_i)), devs) + (_i)->nr_devs)
-
 struct bch_sb_field_replicas {
 	struct bch_sb_field	field;
 	struct bch_replicas_entry_v1 entries[];
@@ -875,7 +820,8 @@ struct bch_sb_field_downgrade {
 	x(rebalance_work,		BCH_VERSION(1,  3))		\
 	x(member_seq,			BCH_VERSION(1,  4))		\
 	x(subvolume_fs_parent,		BCH_VERSION(1,  5))		\
-	x(btree_subvolume_children,	BCH_VERSION(1,  6))
+	x(btree_subvolume_children,	BCH_VERSION(1,  6))		\
+	x(disk_accounting_v2,		BCH_VERSION(1,  7))
 
 enum bcachefs_metadata_version {
 	bcachefs_metadata_version_min = 9,
@@ -1525,7 +1471,9 @@ enum btree_id_flags {
 	x(rebalance_work,	18,	BTREE_ID_SNAPSHOT_FIELD,		\
 	  BIT_ULL(KEY_TYPE_set)|BIT_ULL(KEY_TYPE_cookie))			\
 	x(subvolume_children,	19,	0,					\
-	  BIT_ULL(KEY_TYPE_set))
+	  BIT_ULL(KEY_TYPE_set))						\
+	x(accounting,		20,	BTREE_ID_SNAPSHOT_FIELD,		\
+	  BIT_ULL(KEY_TYPE_accounting))						\
 
 enum btree_id {
 #define x(name, nr, ...) BTREE_ID_##name = nr,
diff --git a/fs/bcachefs/bkey_methods.c b/fs/bcachefs/bkey_methods.c
index 5e52684764eb..da25bdd1e8a6 100644
--- a/fs/bcachefs/bkey_methods.c
+++ b/fs/bcachefs/bkey_methods.c
@@ -7,6 +7,7 @@
 #include "btree_types.h"
 #include "alloc_background.h"
 #include "dirent.h"
+#include "disk_accounting.h"
 #include "ec.h"
 #include "error.h"
 #include "extents.h"
diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
new file mode 100644
index 000000000000..209f59e87b34
--- /dev/null
+++ b/fs/bcachefs/disk_accounting.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "bcachefs.h"
+#include "btree_update.h"
+#include "buckets.h"
+#include "disk_accounting.h"
+#include "replicas.h"
+
+static const char * const disk_accounting_type_strs[] = {
+#define x(t, n, ...) [n] = #t,
+	BCH_DISK_ACCOUNTING_TYPES()
+#undef x
+	NULL
+};
+
+int bch2_accounting_invalid(struct bch_fs *c, struct bkey_s_c k,
+			    enum bkey_invalid_flags flags,
+			    struct printbuf *err)
+{
+	return 0;
+}
+
+void bch2_accounting_key_to_text(struct printbuf *out, struct disk_accounting_key *k)
+{
+	if (k->type >= BCH_DISK_ACCOUNTING_TYPE_NR) {
+		prt_printf(out, "unknown type %u", k->type);
+		return;
+	}
+
+	prt_str(out, disk_accounting_type_strs[k->type]);
+	prt_str(out, " ");
+
+	switch (k->type) {
+	case BCH_DISK_ACCOUNTING_nr_inodes:
+		break;
+	case BCH_DISK_ACCOUNTING_persistent_reserved:
+		prt_printf(out, "replicas=%u", k->persistent_reserved.nr_replicas);
+		break;
+	case BCH_DISK_ACCOUNTING_replicas:
+		bch2_replicas_entry_to_text(out, &k->replicas);
+		break;
+	case BCH_DISK_ACCOUNTING_dev_data_type:
+		prt_printf(out, "dev=%u data_type=", k->dev_data_type.dev);
+		bch2_prt_data_type(out, k->dev_data_type.data_type);
+		break;
+	case BCH_DISK_ACCOUNTING_dev_stripe_buckets:
+		prt_printf(out, "dev=%u", k->dev_stripe_buckets.dev);
+		break;
+	}
+}
+
+void bch2_accounting_to_text(struct printbuf *out, struct bch_fs *c, struct bkey_s_c k)
+{
+	struct bkey_s_c_accounting acc = bkey_s_c_to_accounting(k);
+	struct disk_accounting_key acc_k;
+	bpos_to_disk_accounting_key(&acc_k, k.k->p);
+
+	bch2_accounting_key_to_text(out, &acc_k);
+
+	for (unsigned i = 0; i < bch2_accounting_counters(k.k); i++)
+		prt_printf(out, " %lli", acc.v->d[i]);
+}
+
+void bch2_accounting_swab(struct bkey_s k)
+{
+	for (u64 *p = (u64 *) k.v;
+	     p < (u64 *) bkey_val_end(k);
+	     p++)
+		*p = swab64(*p);
+}
diff --git a/fs/bcachefs/disk_accounting.h b/fs/bcachefs/disk_accounting.h
new file mode 100644
index 000000000000..e15299665859
--- /dev/null
+++ b/fs/bcachefs/disk_accounting.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_DISK_ACCOUNTING_H
+#define _BCACHEFS_DISK_ACCOUNTING_H
+
+static inline unsigned bch2_accounting_counters(const struct bkey *k)
+{
+	return bkey_val_u64s(k) - offsetof(struct bch_accounting, d) / sizeof(u64);
+}
+
+static inline void bch2_accounting_accumulate(struct bkey_i_accounting *dst,
+					      struct bkey_s_c_accounting src)
+{
+	EBUG_ON(dst->k.u64s != src.k->u64s);
+
+	for (unsigned i = 0; i < bch2_accounting_counters(&dst->k); i++)
+		dst->v.d[i] += src.v->d[i];
+	if (bversion_cmp(dst->k.version, src.k->version) < 0)
+		dst->k.version = src.k->version;
+}
+
+static inline void bpos_to_disk_accounting_key(struct disk_accounting_key *acc, struct bpos p)
+{
+	acc->_pad = p;
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	bch2_bpos_swab(&acc->_pad);
+#endif
+}
+
+static inline struct bpos disk_accounting_key_to_bpos(struct disk_accounting_key *k)
+{
+	struct bpos ret = k->_pad;
+
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	bch2_bpos_swab(&ret);
+#endif
+	return ret;
+}
+
+int bch2_accounting_invalid(struct bch_fs *, struct bkey_s_c,
+			    enum bkey_invalid_flags, struct printbuf *);
+void bch2_accounting_key_to_text(struct printbuf *, struct disk_accounting_key *);
+void bch2_accounting_to_text(struct printbuf *, struct bch_fs *, struct bkey_s_c);
+void bch2_accounting_swab(struct bkey_s);
+
+#define bch2_bkey_ops_accounting ((struct bkey_ops) {	\
+	.key_invalid	= bch2_accounting_invalid,	\
+	.val_to_text	= bch2_accounting_to_text,	\
+	.swab		= bch2_accounting_swab,		\
+	.min_val_size	= 8,				\
+})
+
+#endif /* _BCACHEFS_DISK_ACCOUNTING_H */
diff --git a/fs/bcachefs/disk_accounting_format.h b/fs/bcachefs/disk_accounting_format.h
new file mode 100644
index 000000000000..e06a42f0d578
--- /dev/null
+++ b/fs/bcachefs/disk_accounting_format.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_DISK_ACCOUNTING_FORMAT_H
+#define _BCACHEFS_DISK_ACCOUNTING_FORMAT_H
+
+#include "replicas_format.h"
+
+/*
+ * Disk accounting - KEY_TYPE_accounting - on disk format:
+ *
+ * Here, the key has considerably more structure than a typical key (bpos); an
+ * accounting key is 'struct disk_accounting_key', which is a union of bpos.
+ *
+ * This is a type-tagged union of all our various subtypes; a disk accounting
+ * key can be device counters, replicas counters, et cetera - it's extensible.
+ *
+ * The value is a list of u64s or s64s; the number of counters is specific to a
+ * given accounting type.
+ *
+ * Unlike with other key types, updates are _deltas_, and the deltas are not
+ * resolved until the update to the underlying btree, done by btree write buffer
+ * flush or journal replay.
+ *
+ * Journal replay in particular requires special handling. The journal tracks a
+ * range of entries which may possibly have not yet been applied to the btree
+ * yet - it does not know definitively whether individual entries are dirty and
+ * still need to be applied.
+ *
+ * To handle this, we use the version field of struct bkey, and give every
+ * accounting update a unique version number - a total ordering in time; the
+ * version number is derived from the key's position in the journal. Then
+ * journal replay can compare the version number of the key from the journal
+ * with the version number of the key in the btree to determine if a key needs
+ * to be replayed.
+ *
+ * For this to work, we must maintain this strict time ordering of updates as
+ * they are flushed to the btree, both via write buffer flush and via journal
+ * replay. This has complications for the write buffer code while journal replay
+ * is still in progress; the write buffer cannot flush any accounting keys to
+ * the btree until journal replay has finished replaying its accounting keys, or
+ * the (newer) version number of the keys from the write buffer will cause
+ * updates from journal replay to be lost.
+ */
+
+struct bch_accounting {
+	struct bch_val		v;
+	__u64			d[];
+};
+
+#define BCH_ACCOUNTING_MAX_COUNTERS		3
+
+#define BCH_DATA_TYPES()		\
+	x(free,		0)		\
+	x(sb,		1)		\
+	x(journal,	2)		\
+	x(btree,	3)		\
+	x(user,		4)		\
+	x(cached,	5)		\
+	x(parity,	6)		\
+	x(stripe,	7)		\
+	x(need_gc_gens,	8)		\
+	x(need_discard,	9)
+
+enum bch_data_type {
+#define x(t, n) BCH_DATA_##t,
+	BCH_DATA_TYPES()
+#undef x
+	BCH_DATA_NR
+};
+
+static inline bool data_type_is_empty(enum bch_data_type type)
+{
+	switch (type) {
+	case BCH_DATA_free:
+	case BCH_DATA_need_gc_gens:
+	case BCH_DATA_need_discard:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool data_type_is_hidden(enum bch_data_type type)
+{
+	switch (type) {
+	case BCH_DATA_sb:
+	case BCH_DATA_journal:
+		return true;
+	default:
+		return false;
+	}
+}
+
+#define BCH_DISK_ACCOUNTING_TYPES()		\
+	x(nr_inodes,		0)		\
+	x(persistent_reserved,	1)		\
+	x(replicas,		2)		\
+	x(dev_data_type,	3)		\
+	x(dev_stripe_buckets,	4)
+
+enum disk_accounting_type {
+#define x(f, nr)	BCH_DISK_ACCOUNTING_##f	= nr,
+	BCH_DISK_ACCOUNTING_TYPES()
+#undef x
+	BCH_DISK_ACCOUNTING_TYPE_NR,
+};
+
+struct bch_nr_inodes {
+};
+
+struct bch_persistent_reserved {
+	__u8			nr_replicas;
+};
+
+struct bch_dev_data_type {
+	__u8			dev;
+	__u8			data_type;
+};
+
+struct bch_dev_stripe_buckets {
+	__u8			dev;
+};
+
+struct disk_accounting_key {
+	union {
+	struct {
+		__u8				type;
+		union {
+		struct bch_nr_inodes		nr_inodes;
+		struct bch_persistent_reserved	persistent_reserved;
+		struct bch_replicas_entry_v1	replicas;
+		struct bch_dev_data_type	dev_data_type;
+		struct bch_dev_stripe_buckets	dev_stripe_buckets;
+		};
+	};
+		struct bpos			_pad;
+	};
+};
+
+#endif /* _BCACHEFS_DISK_ACCOUNTING_FORMAT_H */
diff --git a/fs/bcachefs/replicas_format.h b/fs/bcachefs/replicas_format.h
new file mode 100644
index 000000000000..ed94f8c636b3
--- /dev/null
+++ b/fs/bcachefs/replicas_format.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_REPLICAS_FORMAT_H
+#define _BCACHEFS_REPLICAS_FORMAT_H
+
+struct bch_replicas_entry_v0 {
+	__u8			data_type;
+	__u8			nr_devs;
+	__u8			devs[];
+} __packed;
+
+struct bch_replicas_entry_v1 {
+	__u8			data_type;
+	__u8			nr_devs;
+	__u8			nr_required;
+	__u8			devs[];
+} __packed;
+
+#define replicas_entry_bytes(_i)					\
+	(offsetof(typeof(*(_i)), devs) + (_i)->nr_devs)
+
+#endif /* _BCACHEFS_REPLICAS_FORMAT_H */
diff --git a/fs/bcachefs/sb-downgrade.c b/fs/bcachefs/sb-downgrade.c
index 3337419faeff..33db8d7ca8c4 100644
--- a/fs/bcachefs/sb-downgrade.c
+++ b/fs/bcachefs/sb-downgrade.c
@@ -52,9 +52,15 @@
 	  BCH_FSCK_ERR_subvol_fs_path_parent_wrong)		\
 	x(btree_subvolume_children,				\
 	  BIT_ULL(BCH_RECOVERY_PASS_check_subvols),		\
-	  BCH_FSCK_ERR_subvol_children_not_set)
+	  BCH_FSCK_ERR_subvol_children_not_set)			\
+	x(disk_accounting_v2,					\
+	  BIT_ULL(BCH_RECOVERY_PASS_check_allocations),		\
+	  BCH_FSCK_ERR_accounting_mismatch)
 
-#define DOWNGRADE_TABLE()
+#define DOWNGRADE_TABLE()					\
+	x(disk_accounting_v2,					\
+	  BIT_ULL(BCH_RECOVERY_PASS_check_alloc_info),		\
+	  BCH_FSCK_ERR_dev_usage_buckets_wrong)
 
 struct upgrade_downgrade_entry {
 	u64		recovery_passes;
@@ -108,7 +114,7 @@ void bch2_sb_set_upgrade(struct bch_fs *c,
 		}
 }
 
-#define x(ver, passes, ...) static const u16 downgrade_ver_##errors[] = { __VA_ARGS__ };
+#define x(ver, passes, ...) static const u16 downgrade_##ver##_errors[] = { __VA_ARGS__ };
 DOWNGRADE_TABLE()
 #undef x
 
diff --git a/fs/bcachefs/sb-errors_types.h b/fs/bcachefs/sb-errors_types.h
index 0df4b0e7071a..383e13711001 100644
--- a/fs/bcachefs/sb-errors_types.h
+++ b/fs/bcachefs/sb-errors_types.h
@@ -264,7 +264,8 @@
 	x(subvol_children_not_set,				256)	\
 	x(subvol_children_bad,					257)	\
 	x(subvol_loop,						258)	\
-	x(subvol_unreachable,					259)
+	x(subvol_unreachable,					259)	\
+	x(accounting_mismatch,					260)
 
 enum bch_sb_error_id {
 #define x(t, n) BCH_FSCK_ERR_##t = n,
-- 
2.43.0


