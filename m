Return-Path: <linux-kernel+bounces-79409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A68621B0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE22852DE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F6BD536;
	Sat, 24 Feb 2024 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBNcymFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CAED2F7;
	Sat, 24 Feb 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737319; cv=none; b=nhyDVPqoD5GXrEozWmEBPExtru5uwcsO0MIhjfSWxwZw6eQhQhpITwiR+DoeHOdSgT2It2IqA4BCX62P3Qt3Fcx33qjtbkF0soWsQrdKXAkqVdPsHBoLEY05cPPoYGdzU6IDXhoC7XX8FuNwxo9U5oyEw4OB0aSGTDEX1B1fGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737319; c=relaxed/simple;
	bh=joOu/D8PuU6W1wT2j833vTQ3gAxGeC2aBKOfHH/tZoE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3B5XVw9e3od8tSn9pfhkfwqoL4buPJ/krkrehJQDul4FegmESQUmpXvBsx1o9F+ekQrrNwMRjIBQpvZW5ZAn0aLbJKy8RIm+ubqmEz80NxPxy0IYyDCkpD1EQzaUllHv2sklUMvruO9qbsea+BLd6mGlAdAW6YLFShjTkWXyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBNcymFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2AEC43399;
	Sat, 24 Feb 2024 01:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737318;
	bh=joOu/D8PuU6W1wT2j833vTQ3gAxGeC2aBKOfHH/tZoE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OBNcymFOIlICwIcjUYNbfZGCXcjrR5WwDkm7c1yRmD/lfHVXQMkc19aMCFV1CN8KA
	 fUw8LE4cu1mzrcbHiVrtsh/vkn3Edx4BUEtpX2xUUOi3IQYiU83I7vTYl1GcQ6gWkX
	 rINdO8BfKK7nLrc1JVQvHHtUtKYmwCHBL2OSvOfRrw+a1b8e+sBilGZV5eeujCrIk8
	 uKgjnQ+Cu0ASj8igwguOY/5zP0dfU3N0kv+zdSaK9SMaB6RxUtVokMFVtvLqEDyDNN
	 j2TycUbtq2ywlRvKn9+v4cwGTe8QLlQR4BzyrrRpos+4GEoME0uglayIm2lzC6V8H0
	 aUHyAo0PhAF5Q==
Date: Fri, 23 Feb 2024 17:15:18 -0800
Subject: [PATCH 06/10] darray: lift from bcachefs
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668982.1861398.687203266316507902.stgit@frogsfrogsfrogs>
In-Reply-To: <170873668859.1861398.2367011381778949840.stgit@frogsfrogsfrogs>
References: <170873668859.1861398.2367011381778949840.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Kent Overstreet <kent.overstreet@linux.dev>

dynamic arrays - inspired from CCAN darrays, basically c++ stl vectors.

Used by thread_with_stdio, which is also being lifted from bcachefs for
xfs.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS                            |    7 ++++
 fs/bcachefs/Makefile                   |    1 -
 fs/bcachefs/btree_types.h              |    2 +
 fs/bcachefs/btree_update.c             |    2 +
 fs/bcachefs/btree_write_buffer_types.h |    2 +
 fs/bcachefs/fsck.c                     |    2 +
 fs/bcachefs/journal_sb.c               |    2 +
 fs/bcachefs/sb-downgrade.c             |    3 +-
 fs/bcachefs/sb-errors_types.h          |    2 +
 fs/bcachefs/sb-members.h               |    2 +
 fs/bcachefs/subvolume.h                |    1 -
 fs/bcachefs/subvolume_types.h          |    2 +
 fs/bcachefs/thread_with_file_types.h   |    2 +
 fs/bcachefs/util.h                     |   29 +---------------
 include/linux/darray.h                 |   59 +++++++++++++++++++++-----------
 include/linux/darray_types.h           |   22 ++++++++++++
 lib/Makefile                           |    2 +
 lib/darray.c                           |   12 +++++--
 18 files changed, 93 insertions(+), 61 deletions(-)
 rename fs/bcachefs/darray.h => include/linux/darray.h (66%)
 create mode 100644 include/linux/darray_types.h
 rename fs/bcachefs/darray.c => lib/darray.c (56%)


diff --git a/MAINTAINERS b/MAINTAINERS
index aa762fe654e3e..97905e0d57a52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5810,6 +5810,13 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DARRAY
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+L:	linux-bcachefs@vger.kernel.org
+S:	Maintained
+F:	include/linux/darray.h
+F:	include/linux/darray_types.h
+
 DATA ACCESS MONITOR
 M:	SeongJae Park <sj@kernel.org>
 L:	damon@lists.linux.dev
diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index b11ba74b8ad41..bb17d146b0900 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -27,7 +27,6 @@ bcachefs-y		:=	\
 	checksum.o		\
 	clock.o			\
 	compress.o		\
-	darray.o		\
 	debug.o			\
 	dirent.o		\
 	disk_groups.o		\
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index 4a5a64499eb76..0d5eecbd3e9cf 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -2,12 +2,12 @@
 #ifndef _BCACHEFS_BTREE_TYPES_H
 #define _BCACHEFS_BTREE_TYPES_H
 
+#include <linux/darray_types.h>
 #include <linux/list.h>
 #include <linux/rhashtable.h>
 
 #include "btree_key_cache_types.h"
 #include "buckets_types.h"
-#include "darray.h"
 #include "errcode.h"
 #include "journal_types.h"
 #include "replicas_types.h"
diff --git a/fs/bcachefs/btree_update.c b/fs/bcachefs/btree_update.c
index c3ff365acce9a..e5193116b092f 100644
--- a/fs/bcachefs/btree_update.c
+++ b/fs/bcachefs/btree_update.c
@@ -14,6 +14,8 @@
 #include "snapshot.h"
 #include "trace.h"
 
+#include <linux/darray.h>
+
 static inline int btree_insert_entry_cmp(const struct btree_insert_entry *l,
 					 const struct btree_insert_entry *r)
 {
diff --git a/fs/bcachefs/btree_write_buffer_types.h b/fs/bcachefs/btree_write_buffer_types.h
index 9b9433de9c368..5f248873087c3 100644
--- a/fs/bcachefs/btree_write_buffer_types.h
+++ b/fs/bcachefs/btree_write_buffer_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_BTREE_WRITE_BUFFER_TYPES_H
 #define _BCACHEFS_BTREE_WRITE_BUFFER_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 #include "journal_types.h"
 
 #define BTREE_WRITE_BUFERED_VAL_U64s_MAX	4
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index 6a760777bafb0..04d3d9957a203 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -5,7 +5,6 @@
 #include "btree_cache.h"
 #include "btree_update.h"
 #include "buckets.h"
-#include "darray.h"
 #include "dirent.h"
 #include "error.h"
 #include "fs-common.h"
@@ -18,6 +17,7 @@
 #include "xattr.h"
 
 #include <linux/bsearch.h>
+#include <linux/darray.h>
 #include <linux/dcache.h> /* struct qstr */
 
 /*
diff --git a/fs/bcachefs/journal_sb.c b/fs/bcachefs/journal_sb.c
index ae4fb8c3a2bc2..156691c203bef 100644
--- a/fs/bcachefs/journal_sb.c
+++ b/fs/bcachefs/journal_sb.c
@@ -2,8 +2,8 @@
 
 #include "bcachefs.h"
 #include "journal_sb.h"
-#include "darray.h"
 
+#include <linux/darray.h>
 #include <linux/sort.h>
 
 /* BCH_SB_FIELD_journal: */
diff --git a/fs/bcachefs/sb-downgrade.c b/fs/bcachefs/sb-downgrade.c
index 441dcb1bf160e..626eaaea5b01d 100644
--- a/fs/bcachefs/sb-downgrade.c
+++ b/fs/bcachefs/sb-downgrade.c
@@ -6,12 +6,13 @@
  */
 
 #include "bcachefs.h"
-#include "darray.h"
 #include "recovery.h"
 #include "sb-downgrade.h"
 #include "sb-errors.h"
 #include "super-io.h"
 
+#include <linux/darray.h>
+
 #define RECOVERY_PASS_ALL_FSCK		BIT_ULL(63)
 
 /*
diff --git a/fs/bcachefs/sb-errors_types.h b/fs/bcachefs/sb-errors_types.h
index c08aacdfd073c..9a3a74ca0806b 100644
--- a/fs/bcachefs/sb-errors_types.h
+++ b/fs/bcachefs/sb-errors_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_SB_ERRORS_TYPES_H
 #define _BCACHEFS_SB_ERRORS_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 #define BCH_SB_ERRS()							\
 	x(clean_but_journal_not_empty,				0)	\
diff --git a/fs/bcachefs/sb-members.h b/fs/bcachefs/sb-members.h
index be0a941832715..e4d4d842229a6 100644
--- a/fs/bcachefs/sb-members.h
+++ b/fs/bcachefs/sb-members.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_SB_MEMBERS_H
 #define _BCACHEFS_SB_MEMBERS_H
 
-#include "darray.h"
+#include <linux/darray.h>
 
 extern char * const bch2_member_error_strs[];
 
diff --git a/fs/bcachefs/subvolume.h b/fs/bcachefs/subvolume.h
index a6f56f66e27cb..3ca1d183369c5 100644
--- a/fs/bcachefs/subvolume.h
+++ b/fs/bcachefs/subvolume.h
@@ -2,7 +2,6 @@
 #ifndef _BCACHEFS_SUBVOLUME_H
 #define _BCACHEFS_SUBVOLUME_H
 
-#include "darray.h"
 #include "subvolume_types.h"
 
 enum bkey_invalid_flags;
diff --git a/fs/bcachefs/subvolume_types.h b/fs/bcachefs/subvolume_types.h
index ae644adfc3916..40f16e3a6dd04 100644
--- a/fs/bcachefs/subvolume_types.h
+++ b/fs/bcachefs/subvolume_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_SUBVOLUME_TYPES_H
 #define _BCACHEFS_SUBVOLUME_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 typedef DARRAY(u32) snapshot_id_list;
 
diff --git a/fs/bcachefs/thread_with_file_types.h b/fs/bcachefs/thread_with_file_types.h
index e0daf4eec341e..41990756aa261 100644
--- a/fs/bcachefs/thread_with_file_types.h
+++ b/fs/bcachefs/thread_with_file_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_THREAD_WITH_FILE_TYPES_H
 #define _BCACHEFS_THREAD_WITH_FILE_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 struct stdio_buf {
 	spinlock_t		lock;
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index cf8d16a911622..b354307903057 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -5,23 +5,22 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/closure.h>
+#include <linux/darray.h>
 #include <linux/errno.h>
 #include <linux/freezer.h>
 #include <linux/kernel.h>
-#include <linux/sched/clock.h>
 #include <linux/llist.h>
 #include <linux/log2.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/ratelimit.h>
+#include <linux/sched/clock.h>
 #include <linux/slab.h>
 #include <linux/time_stats.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <linux/mean_and_variance.h>
 
-#include "darray.h"
-
 struct closure;
 
 #ifdef CONFIG_BCACHEFS_DEBUG
@@ -662,30 +661,6 @@ static inline void memset_u64s_tail(void *s, int c, unsigned bytes)
 	memset(s + bytes, c, rem);
 }
 
-/* just the memmove, doesn't update @_nr */
-#define __array_insert_item(_array, _nr, _pos)				\
-	memmove(&(_array)[(_pos) + 1],					\
-		&(_array)[(_pos)],					\
-		sizeof((_array)[0]) * ((_nr) - (_pos)))
-
-#define array_insert_item(_array, _nr, _pos, _new_item)			\
-do {									\
-	__array_insert_item(_array, _nr, _pos);				\
-	(_nr)++;							\
-	(_array)[(_pos)] = (_new_item);					\
-} while (0)
-
-#define array_remove_items(_array, _nr, _pos, _nr_to_remove)		\
-do {									\
-	(_nr) -= (_nr_to_remove);					\
-	memmove(&(_array)[(_pos)],					\
-		&(_array)[(_pos) + (_nr_to_remove)],			\
-		sizeof((_array)[0]) * ((_nr) - (_pos)));		\
-} while (0)
-
-#define array_remove_item(_array, _nr, _pos)				\
-	array_remove_items(_array, _nr, _pos, 1)
-
 static inline void __move_gap(void *array, size_t element_size,
 			      size_t nr, size_t size,
 			      size_t old_gap, size_t new_gap)
diff --git a/fs/bcachefs/darray.h b/include/linux/darray.h
similarity index 66%
rename from fs/bcachefs/darray.h
rename to include/linux/darray.h
index 4b340d13caace..ff167eb795f22 100644
--- a/fs/bcachefs/darray.h
+++ b/include/linux/darray.h
@@ -1,34 +1,26 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _BCACHEFS_DARRAY_H
-#define _BCACHEFS_DARRAY_H
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
+#ifndef _LINUX_DARRAY_H
+#define _LINUX_DARRAY_H
 
 /*
- * Dynamic arrays:
+ * Dynamic arrays
  *
  * Inspired by CCAN's darray
  */
 
+#include <linux/darray_types.h>
 #include <linux/slab.h>
 
-#define DARRAY_PREALLOCATED(_type, _nr)					\
-struct {								\
-	size_t nr, size;						\
-	_type *data;							\
-	_type preallocated[_nr];					\
-}
-
-#define DARRAY(_type) DARRAY_PREALLOCATED(_type, 0)
-
-typedef DARRAY(char)	darray_char;
-typedef DARRAY(char *) darray_str;
-
-int __bch2_darray_resize(darray_char *, size_t, size_t, gfp_t);
+int __darray_resize_slowpath(darray_char *, size_t, size_t, gfp_t);
 
 static inline int __darray_resize(darray_char *d, size_t element_size,
 				  size_t new_size, gfp_t gfp)
 {
 	return unlikely(new_size > d->size)
-		? __bch2_darray_resize(d, element_size, new_size, gfp)
+		? __darray_resize_slowpath(d, element_size, new_size, gfp)
 		: 0;
 }
 
@@ -69,6 +61,28 @@ static inline int __darray_make_room(darray_char *d, size_t t_size, size_t more,
 #define darray_first(_d)	((_d).data[0])
 #define darray_last(_d)		((_d).data[(_d).nr - 1])
 
+/* Insert/remove items into the middle of a darray: */
+
+#define array_insert_item(_array, _nr, _pos, _new_item)			\
+do {									\
+	memmove(&(_array)[(_pos) + 1],					\
+		&(_array)[(_pos)],					\
+		sizeof((_array)[0]) * ((_nr) - (_pos)));		\
+	(_nr)++;							\
+	(_array)[(_pos)] = (_new_item);					\
+} while (0)
+
+#define array_remove_items(_array, _nr, _pos, _nr_to_remove)		\
+do {									\
+	(_nr) -= (_nr_to_remove);					\
+	memmove(&(_array)[(_pos)],					\
+		&(_array)[(_pos) + (_nr_to_remove)],			\
+		sizeof((_array)[0]) * ((_nr) - (_pos)));		\
+} while (0)
+
+#define array_remove_item(_array, _nr, _pos)				\
+	array_remove_items(_array, _nr, _pos, 1)
+
 #define darray_insert_item(_d, pos, _item)				\
 ({									\
 	size_t _pos = (pos);						\
@@ -79,10 +93,15 @@ static inline int __darray_make_room(darray_char *d, size_t t_size, size_t more,
 	_ret;								\
 })
 
+#define darray_remove_items(_d, _pos, _nr_to_remove)			\
+	array_remove_items((_d)->data, (_d)->nr, (_pos) - (_d)->data, _nr_to_remove)
+
 #define darray_remove_item(_d, _pos)					\
-	array_remove_item((_d)->data, (_d)->nr, (_pos) - (_d)->data)
+	darray_remove_items(_d, _pos, 1)
 
-#define __darray_for_each(_d, _i)						\
+/* Iteration: */
+
+#define __darray_for_each(_d, _i)					\
 	for ((_i) = (_d).data; _i < (_d).data + (_d).nr; _i++)
 
 #define darray_for_each(_d, _i)						\
@@ -106,4 +125,4 @@ do {									\
 	darray_init(_d);						\
 } while (0)
 
-#endif /* _BCACHEFS_DARRAY_H */
+#endif /* _LINUX_DARRAY_H */
diff --git a/include/linux/darray_types.h b/include/linux/darray_types.h
new file mode 100644
index 0000000000000..a400a0c3600d8
--- /dev/null
+++ b/include/linux/darray_types.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
+#ifndef _LINUX_DARRAY_TYpES_H
+#define _LINUX_DARRAY_TYpES_H
+
+#include <linux/types.h>
+
+#define DARRAY_PREALLOCATED(_type, _nr)					\
+struct {								\
+	size_t nr, size;						\
+	_type *data;							\
+	_type preallocated[_nr];					\
+}
+
+#define DARRAY(_type) DARRAY_PREALLOCATED(_type, 0)
+
+typedef DARRAY(char)	darray_char;
+typedef DARRAY(char *)	darray_str;
+
+#endif /* _LINUX_DARRAY_TYpES_H */
diff --git a/lib/Makefile b/lib/Makefile
index 57858997c87aa..830907bb8fc85 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -48,7 +48,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
-	 generic-radix-tree.o bitmap-str.o
+	 generic-radix-tree.o bitmap-str.o darray.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/fs/bcachefs/darray.c b/lib/darray.c
similarity index 56%
rename from fs/bcachefs/darray.c
rename to lib/darray.c
index ac35b8b705ae1..7cb064f14b391 100644
--- a/fs/bcachefs/darray.c
+++ b/lib/darray.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
 
+#include <linux/darray.h>
 #include <linux/log2.h>
+#include <linux/module.h>
 #include <linux/slab.h>
-#include "darray.h"
 
-int __bch2_darray_resize(darray_char *d, size_t element_size, size_t new_size, gfp_t gfp)
+int __darray_resize_slowpath(darray_char *d, size_t element_size, size_t new_size, gfp_t gfp)
 {
 	if (new_size > d->size) {
 		new_size = roundup_pow_of_two(new_size);
@@ -22,3 +26,7 @@ int __bch2_darray_resize(darray_char *d, size_t element_size, size_t new_size, g
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__darray_resize_slowpath);
+
+MODULE_AUTHOR("Kent Overstreet");
+MODULE_LICENSE("GPL");


