Return-Path: <linux-kernel+bounces-64694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0991A854190
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E32843AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0EC23BE;
	Wed, 14 Feb 2024 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Op3CotVH"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04E19B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707878402; cv=none; b=X0MrSZGPqjLAVDJn0kb/PShRRKjf+70IgX0DZ86SMIPIEwIoFvKFfLFsOtMo6Z4fRYnUs2EOV+zfVJUu86nvgKWPQhsb2gtbenvNTGrxeAwmyC6mDHxYWWIAba9t5zuuYeMEKZnMbR94jAwQ+rrX7X+lgGmnuxfXPYWcF8dBDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707878402; c=relaxed/simple;
	bh=CYxd5rvayFeIfJaUtwf3Hu5j05ggYoN7X86N/TMEUkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7J+U5TCLd11q0UUEdHCjBVb2LnIZOMbT3NHxo8x6Wn9ejlRbRLvfhqDaFQ537UWuZI9dAlTL1XHRvT4fuPXUVCvp8eoxbALc5F9Q/0iHnsuB8g0KhblsFsU+BQj7zl1iC8nH4cXqswduGDI3n2+p2JeupoutkzI3RkN3Ovk+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Op3CotVH; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707878397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q7F/Gkay+YXzeNupEkSWDnoQuQojQ9N7tE1k2rTAa4E=;
	b=Op3CotVHCC4KBCh4pI4Z6tJJsLgxkVeSzVxU98Dg8KB9L2ED5yuZaC3m/9hNo2ICSgxUnT
	JPwM/EXmPHvXXpRtsGhl6hygDtUU0QPmYXUC4dqvl9P7yZX7m97qlWrxVzOhN4x7iPbIiS
	exqeAPxnMRdQwX05+znY/xGjVrdStM4=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton Kees Cook <"akpm@linux-foundation.orgkees"@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH] darray: lift from bcachefs
Date: Tue, 13 Feb 2024 21:39:47 -0500
Message-ID: <20240214023949.3997464-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

dynamic arrays - inspired from CCAN darrays, basically c++ stl vectors.

Used by thread_with_stdio, which is also being lifted from bcachefs for
xfs.

this is in my for-next branch - this is underlying infrastructure for
the thread-with-file stuff that darrick and I have been hacking on; but
it's also something I use heavily in bcachefs and is a gap in our data
structures.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 MAINTAINERS                             |  7 +++
 fs/bcachefs/Makefile                    |  1 -
 fs/bcachefs/btree_types.h               |  2 +-
 fs/bcachefs/btree_update.c              |  2 +
 fs/bcachefs/btree_write_buffer_types.h  |  2 +-
 fs/bcachefs/fsck.c                      |  2 +-
 fs/bcachefs/journal_io.h                |  2 +-
 fs/bcachefs/journal_sb.c                |  2 +-
 fs/bcachefs/sb-downgrade.c              |  3 +-
 fs/bcachefs/sb-errors_types.h           |  2 +-
 fs/bcachefs/sb-members.h                |  2 +-
 fs/bcachefs/subvolume.h                 |  1 -
 fs/bcachefs/subvolume_types.h           |  2 +-
 fs/bcachefs/thread_with_file_types.h    |  2 +-
 fs/bcachefs/util.h                      | 29 +-----------
 {fs/bcachefs => include/linux}/darray.h | 59 ++++++++++++++++---------
 include/linux/darray_types.h            | 22 +++++++++
 lib/Makefile                            |  2 +-
 {fs/bcachefs => lib}/darray.c           | 12 ++++-
 19 files changed, 94 insertions(+), 62 deletions(-)
 rename {fs/bcachefs => include/linux}/darray.h (66%)
 create mode 100644 include/linux/darray_types.h
 rename {fs/bcachefs => lib}/darray.c (56%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2face46f365..cec0ca4e108e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5806,6 +5806,13 @@ F:	net/ax25/ax25_out.c
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
index b11ba74b8ad4..bb17d146b090 100644
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
index 4a5a64499eb7..0d5eecbd3e9c 100644
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
index c3ff365acce9..e5193116b092 100644
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
index 9b9433de9c36..5f248873087c 100644
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
index 10d144c5a37a..a4b44c4f9bdc 100644
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
diff --git a/fs/bcachefs/journal_io.h b/fs/bcachefs/journal_io.h
index 1f395f43cf76..f18b90000cc5 100644
--- a/fs/bcachefs/journal_io.h
+++ b/fs/bcachefs/journal_io.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_JOURNAL_IO_H
 #define _BCACHEFS_JOURNAL_IO_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 struct journal_ptr {
 	bool		csum_good;
diff --git a/fs/bcachefs/journal_sb.c b/fs/bcachefs/journal_sb.c
index ae4fb8c3a2bc..156691c203be 100644
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
index 441dcb1bf160..626eaaea5b01 100644
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
index dbfd91ab86cf..cadf12ce9173 100644
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
index be0a94183271..e4d4d842229a 100644
--- a/fs/bcachefs/sb-members.h
+++ b/fs/bcachefs/sb-members.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_SB_MEMBERS_H
 #define _BCACHEFS_SB_MEMBERS_H
 
-#include "darray.h"
+#include <linux/darray.h>
 
 extern char * const bch2_member_error_strs[];
 
diff --git a/fs/bcachefs/subvolume.h b/fs/bcachefs/subvolume.h
index a6f56f66e27c..3ca1d183369c 100644
--- a/fs/bcachefs/subvolume.h
+++ b/fs/bcachefs/subvolume.h
@@ -2,7 +2,6 @@
 #ifndef _BCACHEFS_SUBVOLUME_H
 #define _BCACHEFS_SUBVOLUME_H
 
-#include "darray.h"
 #include "subvolume_types.h"
 
 enum bkey_invalid_flags;
diff --git a/fs/bcachefs/subvolume_types.h b/fs/bcachefs/subvolume_types.h
index ae644adfc391..40f16e3a6dd0 100644
--- a/fs/bcachefs/subvolume_types.h
+++ b/fs/bcachefs/subvolume_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_SUBVOLUME_TYPES_H
 #define _BCACHEFS_SUBVOLUME_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 typedef DARRAY(u32) snapshot_id_list;
 
diff --git a/fs/bcachefs/thread_with_file_types.h b/fs/bcachefs/thread_with_file_types.h
index e0daf4eec341..41990756aa26 100644
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
index c4cd32a2aeb2..1b3aced8d83c 100644
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
@@ -630,30 +629,6 @@ static inline void memset_u64s_tail(void *s, int c, unsigned bytes)
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
index 4b340d13caac..ff167eb795f2 100644
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
+
+/* Iteration: */
 
-#define __darray_for_each(_d, _i)						\
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
index 000000000000..a400a0c3600d
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
index 57858997c87a..830907bb8fc8 100644
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
index ac35b8b705ae..7cb064f14b39 100644
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
-- 
2.43.0


