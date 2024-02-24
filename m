Return-Path: <linux-kernel+bounces-79410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACA18621B2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B65E282165
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C046FB8;
	Sat, 24 Feb 2024 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1tX27U0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74214A04;
	Sat, 24 Feb 2024 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737334; cv=none; b=WAOlHauHs7cBRIlCT8Vmkjlgoq7x4LXRg/C2c0GCWS9adwy9gWFc/V+2LyobPhuI4fiCHji4EBJaA7KgWEMcCfaF7GiOZU8O+ZOTIUPGn8CGndNvPi6VQE5Nxz51HQzR/8hk9BXTl35wsBjXI2D3Y89QNvDe4uCtJzqcGYnBcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737334; c=relaxed/simple;
	bh=ftNNa3Js5gnHzb/IfqcMRc3GeQwMLobWjfB0wQO5sg4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2KUlDaYPj9Q6I5w13cfAxwsjXU9RoVFQfqhN0f8occ5+w0N014TTuUxOS2GkRi/kNapgeoZH1cavoBziWOnRyNDJWLEppxwIqBaA7JmoHuyjUyzN3VnOru7N0kxCYRALjFhhb4kLGaSF9MM9TsXTIPBiECUdAhGCWi5IBtgyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1tX27U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790D2C433C7;
	Sat, 24 Feb 2024 01:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737334;
	bh=ftNNa3Js5gnHzb/IfqcMRc3GeQwMLobWjfB0wQO5sg4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=j1tX27U0fEGG+VLUoj+lVn95FZws8+6DQ+lYFu94O/kfz9KRhHLSoslO1ncosIf4m
	 iA6fNGDj/O4uBAJdDY4Sl5xG6D80FoFx4ClwKd1MqgsllavcBeMY8BcHtVgkVodqSq
	 axrWwxyPlzncD+dEqkYEWWiTAu4w+k3jow3BQfkJPrVQ38iX4ucdeH5BLCniedgqa9
	 znPlQIV3gNnlzpGxiyJcjijd97nsu/xUiMd5UkDqQpVs/B4tvpJJjzGlqKpQP3aKzk
	 178/v08jlQBW0l/T7UB1pvkjVmzY/wxT46JhEawv731KKKw8NdH2fJQCz8ooaF9qGR
	 RHOgxe+gjoZYg==
Date: Fri, 23 Feb 2024 17:15:34 -0800
Subject: [PATCH 07/10] thread_with_file: Lift from bcachefs
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873669000.1861398.18399402042856050828.stgit@frogsfrogsfrogs>
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

thread_with_file and thread_with_stdio are abstractions for connecting
kthreads to file descriptors, which is handy for all sorts of things -
the running kthread has its lifetime connected to the file descriptor,
which means an asynchronous job running in the kernel can easily exit in
response to a ctrl-c, and the file descriptor also provides a
communications channel.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS                            |    9 +
 fs/bcachefs/Kconfig                    |    1 
 fs/bcachefs/Makefile                   |    1 
 fs/bcachefs/bcachefs.h                 |    2 
 fs/bcachefs/chardev.c                  |   10 -
 fs/bcachefs/error.c                    |    4 
 fs/bcachefs/super.c                    |    4 
 include/linux/thread_with_file.h       |   35 ++-
 include/linux/thread_with_file_types.h |    8 -
 lib/Kconfig                            |    3 
 lib/Makefile                           |    1 
 lib/thread_with_file.c                 |  326 ++++++++++++++++----------------
 12 files changed, 212 insertions(+), 192 deletions(-)
 rename fs/bcachefs/thread_with_file.h => include/linux/thread_with_file.h (63%)
 rename fs/bcachefs/thread_with_file_types.h => include/linux/thread_with_file_types.h (64%)
 rename fs/bcachefs/thread_with_file.c => lib/thread_with_file.c (79%)


diff --git a/MAINTAINERS b/MAINTAINERS
index 97905e0d57a52..5799134b24737 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21888,6 +21888,15 @@ F:	Documentation/userspace-api/media/drivers/thp7312.rst
 F:	drivers/media/i2c/thp7312.c
 F:	include/uapi/linux/thp7312.h
 
+THREAD WITH FILE
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+M:	Darrick J. Wong <djwong@kernel.org>
+L:	linux-bcachefs@vger.kernel.org
+S:	Maintained
+F:	include/linux/thread_with_file.c
+F:	include/linux/thread_with_file_types.c
+F:	lib/thread_with_file.c
+
 THUNDERBOLT DMA TRAFFIC TEST DRIVER
 M:	Isaac Hazan <isaac.hazan@intel.com>
 L:	linux-usb@vger.kernel.org
diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
index 8c587ddd2f85e..08073d76e5a42 100644
--- a/fs/bcachefs/Kconfig
+++ b/fs/bcachefs/Kconfig
@@ -25,6 +25,7 @@ config BCACHEFS_FS
 	select SRCU
 	select SYMBOLIC_ERRNAME
 	select TIME_STATS
+	select THREAD_WITH_FILE
 	help
 	The bcachefs filesystem - a modern, copy on write filesystem, with
 	support for multiple devices, compression, checksumming, etc.
diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index bb17d146b0900..d335b6572d72d 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -80,7 +80,6 @@ bcachefs-y		:=	\
 	super-io.o		\
 	sysfs.o			\
 	tests.o			\
-	thread_with_file.o	\
 	trace.o			\
 	two_state_shared_lock.o	\
 	util.o			\
diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 04e4a65909a4f..5f801256e8740 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -200,6 +200,7 @@
 #include <linux/seqlock.h>
 #include <linux/shrinker.h>
 #include <linux/srcu.h>
+#include <linux/thread_with_file_types.h>
 #include <linux/time_stats.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -466,7 +467,6 @@ enum bch_time_stats {
 #include "replicas_types.h"
 #include "subvolume_types.h"
 #include "super_types.h"
-#include "thread_with_file_types.h"
 
 /* Number of nodes btree coalesce will try to coalesce at once */
 #define GC_MERGE_NODES		4U
diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 11711f54057e1..4cbda66bb6e0f 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -11,7 +11,6 @@
 #include "replicas.h"
 #include "super.h"
 #include "super-io.h"
-#include "thread_with_file.h"
 
 #include <linux/cdev.h>
 #include <linux/device.h>
@@ -20,6 +19,7 @@
 #include <linux/major.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
+#include <linux/thread_with_file.h>
 #include <linux/uaccess.h>
 
 __must_check
@@ -217,7 +217,7 @@ static long bch2_ioctl_fsck_offline(struct bch_ioctl_fsck_offline __user *user_a
 
 	opt_set(thr->opts, stdio, (u64)(unsigned long)&thr->thr.stdio);
 
-	ret = bch2_run_thread_with_stdio(&thr->thr,
+	ret = run_thread_with_stdio(&thr->thr,
 			bch2_fsck_thread_exit,
 			bch2_fsck_offline_thread_fn);
 err:
@@ -422,7 +422,7 @@ static int bch2_data_job_release(struct inode *inode, struct file *file)
 {
 	struct bch_data_ctx *ctx = container_of(file->private_data, struct bch_data_ctx, thr);
 
-	bch2_thread_with_file_exit(&ctx->thr);
+	thread_with_file_exit(&ctx->thr);
 	kfree(ctx);
 	return 0;
 }
@@ -472,7 +472,7 @@ static long bch2_ioctl_data(struct bch_fs *c,
 	ctx->c = c;
 	ctx->arg = arg;
 
-	ret = bch2_run_thread_with_file(&ctx->thr,
+	ret = run_thread_with_file(&ctx->thr,
 			&bcachefs_data_ops,
 			bch2_data_thread);
 	if (ret < 0)
@@ -834,7 +834,7 @@ static long bch2_ioctl_fsck_online(struct bch_fs *c,
 			goto err;
 	}
 
-	ret = bch2_run_thread_with_stdio(&thr->thr,
+	ret = run_thread_with_stdio(&thr->thr,
 			bch2_fsck_thread_exit,
 			bch2_fsck_online_thread_fn);
 err:
diff --git a/fs/bcachefs/error.c b/fs/bcachefs/error.c
index d32c8bebe46c3..70a1253959740 100644
--- a/fs/bcachefs/error.c
+++ b/fs/bcachefs/error.c
@@ -2,7 +2,7 @@
 #include "bcachefs.h"
 #include "error.h"
 #include "super.h"
-#include "thread_with_file.h"
+#include <linux/thread_with_file.h>
 
 #define FSCK_ERR_RATELIMIT_NR	10
 
@@ -105,7 +105,7 @@ static enum ask_yn bch2_fsck_ask_yn(struct bch_fs *c)
 	do {
 		bch2_print(c, " (y,n, or Y,N for all errors of this type) ");
 
-		int r = bch2_stdio_redirect_readline(stdio, buf, sizeof(buf) - 1);
+		int r = stdio_redirect_readline(stdio, buf, sizeof(buf) - 1);
 		if (r < 0)
 			return YN_NO;
 		buf[r] = '\0';
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 0cff8c5f3c104..38a87c8fc8235 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -56,7 +56,6 @@
 #include "super.h"
 #include "super-io.h"
 #include "sysfs.h"
-#include "thread_with_file.h"
 #include "trace.h"
 
 #include <linux/backing-dev.h>
@@ -68,6 +67,7 @@
 #include <linux/percpu.h>
 #include <linux/random.h>
 #include <linux/sysfs.h>
+#include <linux/thread_with_file.h>
 #include <crypto/hash.h>
 
 MODULE_LICENSE("GPL");
@@ -99,7 +99,7 @@ void __bch2_print(struct bch_fs *c, const char *fmt, ...)
 		if (fmt[0] == KERN_SOH[0])
 			fmt += 2;
 
-		bch2_stdio_redirect_vprintf(stdio, true, fmt, args);
+		stdio_redirect_vprintf(stdio, true, fmt, args);
 	}
 	va_end(args);
 }
diff --git a/fs/bcachefs/thread_with_file.h b/include/linux/thread_with_file.h
similarity index 63%
rename from fs/bcachefs/thread_with_file.h
rename to include/linux/thread_with_file.h
index f06f8ff19a790..54091f7ff3383 100644
--- a/fs/bcachefs/thread_with_file.h
+++ b/include/linux/thread_with_file.h
@@ -1,8 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _BCACHEFS_THREAD_WITH_FILE_H
-#define _BCACHEFS_THREAD_WITH_FILE_H
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
+#ifndef _LINUX_THREAD_WITH_FILE_H
+#define _LINUX_THREAD_WITH_FILE_H
 
-#include "thread_with_file_types.h"
+#include <linux/thread_with_file_types.h>
 
 /*
  * Thread with file: Run a kthread and connect it to a file descriptor, so that
@@ -13,7 +16,7 @@
  *
  * thread_with_file, the low level version.
  * You get to define the full file_operations, including your release function,
- * which means that you must call bch2_thread_with_file_exit() from your
+ * which means that you must call thread_with_file_exit() from your
  * .release method
  *
  * thread_with_stdio, the higher level version
@@ -44,10 +47,10 @@ struct thread_with_file {
 	bool			done;
 };
 
-void bch2_thread_with_file_exit(struct thread_with_file *);
-int bch2_run_thread_with_file(struct thread_with_file *,
-			      const struct file_operations *,
-			      int (*fn)(void *));
+void thread_with_file_exit(struct thread_with_file *);
+int run_thread_with_file(struct thread_with_file *,
+			 const struct file_operations *,
+			 int (*fn)(void *));
 
 struct thread_with_stdio {
 	struct thread_with_file	thr;
@@ -56,13 +59,13 @@ struct thread_with_stdio {
 	void			(*fn)(struct thread_with_stdio *);
 };
 
-int bch2_run_thread_with_stdio(struct thread_with_stdio *,
-			       void (*exit)(struct thread_with_stdio *),
-			       void (*fn)(struct thread_with_stdio *));
-int bch2_stdio_redirect_read(struct stdio_redirect *, char *, size_t);
-int bch2_stdio_redirect_readline(struct stdio_redirect *, char *, size_t);
+int run_thread_with_stdio(struct thread_with_stdio *,
+			  void (*exit)(struct thread_with_stdio *),
+			  void (*fn)(struct thread_with_stdio *));
+int stdio_redirect_read(struct stdio_redirect *, char *, size_t);
+int stdio_redirect_readline(struct stdio_redirect *, char *, size_t);
 
-__printf(3, 0) void bch2_stdio_redirect_vprintf(struct stdio_redirect *, bool, const char *, va_list);
-__printf(3, 4) void bch2_stdio_redirect_printf(struct stdio_redirect *, bool, const char *, ...);
+__printf(3, 0) void stdio_redirect_vprintf(struct stdio_redirect *, bool, const char *, va_list);
+__printf(3, 4) void stdio_redirect_printf(struct stdio_redirect *, bool, const char *, ...);
 
-#endif /* _BCACHEFS_THREAD_WITH_FILE_H */
+#endif /* _LINUX_THREAD_WITH_FILE_H */
diff --git a/fs/bcachefs/thread_with_file_types.h b/include/linux/thread_with_file_types.h
similarity index 64%
rename from fs/bcachefs/thread_with_file_types.h
rename to include/linux/thread_with_file_types.h
index 41990756aa261..98d0ad1253221 100644
--- a/fs/bcachefs/thread_with_file_types.h
+++ b/include/linux/thread_with_file_types.h
@@ -1,8 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _BCACHEFS_THREAD_WITH_FILE_TYPES_H
-#define _BCACHEFS_THREAD_WITH_FILE_TYPES_H
+#ifndef _LINUX_THREAD_WITH_FILE_TYPES_H
+#define _LINUX_THREAD_WITH_FILE_TYPES_H
 
 #include <linux/darray_types.h>
+#include <linux/spinlock_types.h>
+#include <linux/wait.h>
 
 struct stdio_buf {
 	spinlock_t		lock;
@@ -20,4 +22,4 @@ struct stdio_redirect {
 	bool			done;
 };
 
-#endif /* _BCACHEFS_THREAD_WITH_FILE_TYPES_H */
+#endif /* _LINUX_THREAD_WITH_FILE_TYPES_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 3ba8b965f8c7e..9258d04e939db 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -789,3 +789,6 @@ config FIRMWARE_TABLE
 config TIME_STATS
 	tristate
 	select MEAN_AND_VARIANCE
+
+config THREAD_WITH_FILE
+	tristate
diff --git a/lib/Makefile b/lib/Makefile
index 830907bb8fc85..e77304f69df03 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -371,6 +371,7 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
 obj-$(CONFIG_PARMAN) += parman.o
 
 obj-$(CONFIG_TIME_STATS) += time_stats.o
+obj-$(CONFIG_THREAD_WITH_FILE) += thread_with_file.o
 
 obj-y += group_cpus.o
 
diff --git a/fs/bcachefs/thread_with_file.c b/lib/thread_with_file.c
similarity index 79%
rename from fs/bcachefs/thread_with_file.c
rename to lib/thread_with_file.c
index dde9679b68b42..092996ca43fe7 100644
--- a/fs/bcachefs/thread_with_file.c
+++ b/lib/thread_with_file.c
@@ -1,26 +1,160 @@
 // SPDX-License-Identifier: GPL-2.0
-#ifndef NO_BCACHEFS_FS
-
-#include "bcachefs.h"
-#include "thread_with_file.h"
-
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
 #include <linux/anon_inodes.h>
+#include <linux/darray.h>
 #include <linux/file.h>
 #include <linux/kthread.h>
+#include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/poll.h>
+#include <linux/thread_with_file.h>
 
-void bch2_thread_with_file_exit(struct thread_with_file *thr)
+/* stdio_redirect */
+
+#define STDIO_REDIRECT_BUFSIZE		4096
+
+static bool stdio_redirect_has_input(struct stdio_redirect *stdio)
+{
+	return stdio->input.buf.nr || stdio->done;
+}
+
+static bool stdio_redirect_has_output(struct stdio_redirect *stdio)
+{
+	return stdio->output.buf.nr || stdio->done;
+}
+
+static bool stdio_redirect_has_input_space(struct stdio_redirect *stdio)
+{
+	return stdio->input.buf.nr < STDIO_REDIRECT_BUFSIZE || stdio->done;
+}
+
+static bool stdio_redirect_has_output_space(struct stdio_redirect *stdio)
+{
+	return stdio->output.buf.nr < STDIO_REDIRECT_BUFSIZE || stdio->done;
+}
+
+static void stdio_buf_init(struct stdio_buf *buf)
+{
+	spin_lock_init(&buf->lock);
+	init_waitqueue_head(&buf->wait);
+	darray_init(&buf->buf);
+}
+
+int stdio_redirect_read(struct stdio_redirect *stdio, char *ubuf, size_t len)
+{
+	struct stdio_buf *buf = &stdio->input;
+
+	wait_event(buf->wait, stdio_redirect_has_input(stdio));
+	if (stdio->done)
+		return -1;
+
+	spin_lock(&buf->lock);
+	int ret = min(len, buf->buf.nr);
+	memcpy(ubuf, buf->buf.data, ret);
+	darray_remove_items(&buf->buf, buf->buf.data, ret);
+	spin_unlock(&buf->lock);
+
+	wake_up(&buf->wait);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stdio_redirect_read);
+
+int stdio_redirect_readline(struct stdio_redirect *stdio, char *ubuf, size_t len)
+{
+	struct stdio_buf *buf = &stdio->input;
+	size_t copied = 0;
+	ssize_t ret = 0;
+again:
+	wait_event(buf->wait, stdio_redirect_has_input(stdio));
+	if (stdio->done) {
+		ret = -1;
+		goto out;
+	}
+
+	spin_lock(&buf->lock);
+	size_t b = min(len, buf->buf.nr);
+	char *n = memchr(buf->buf.data, '\n', b);
+	if (n)
+		b = min_t(size_t, b, n + 1 - buf->buf.data);
+	memcpy(ubuf, buf->buf.data, b);
+	darray_remove_items(&buf->buf, buf->buf.data, b);
+	ubuf += b;
+	len -= b;
+	copied += b;
+	spin_unlock(&buf->lock);
+
+	wake_up(&buf->wait);
+
+	if (!n && len)
+		goto again;
+out:
+	return copied ?: ret;
+}
+EXPORT_SYMBOL_GPL(stdio_redirect_readline);
+
+__printf(3, 0)
+static void darray_vprintf(darray_char *out, gfp_t gfp, const char *fmt, va_list args)
+{
+	size_t len;
+
+	do {
+		va_list args2;
+		va_copy(args2, args);
+
+		len = vsnprintf(out->data + out->nr, darray_room(*out), fmt, args2);
+	} while (len + 1 > darray_room(*out) && !darray_make_room_gfp(out, len + 1, gfp));
+
+	out->nr += min(len, darray_room(*out));
+}
+
+void stdio_redirect_vprintf(struct stdio_redirect *stdio, bool nonblocking,
+			    const char *fmt, va_list args)
+{
+	struct stdio_buf *buf = &stdio->output;
+	unsigned long flags;
+
+	if (!nonblocking)
+		wait_event(buf->wait, stdio_redirect_has_output_space(stdio));
+	else if (!stdio_redirect_has_output_space(stdio))
+		return;
+	if (stdio->done)
+		return;
+
+	spin_lock_irqsave(&buf->lock, flags);
+	darray_vprintf(&buf->buf, nonblocking ? GFP_NOWAIT : GFP_KERNEL, fmt, args);
+	spin_unlock_irqrestore(&buf->lock, flags);
+
+	wake_up(&buf->wait);
+}
+EXPORT_SYMBOL_GPL(stdio_redirect_vprintf);
+
+void stdio_redirect_printf(struct stdio_redirect *stdio, bool nonblocking,
+			   const char *fmt, ...)
+{
+
+	va_list args;
+	va_start(args, fmt);
+	stdio_redirect_vprintf(stdio, nonblocking, fmt, args);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(stdio_redirect_printf);
+
+/* thread with file: */
+
+void thread_with_file_exit(struct thread_with_file *thr)
 {
 	if (thr->task) {
 		kthread_stop(thr->task);
 		put_task_struct(thr->task);
 	}
 }
+EXPORT_SYMBOL_GPL(thread_with_file_exit);
 
-int bch2_run_thread_with_file(struct thread_with_file *thr,
-			      const struct file_operations *fops,
-			      int (*fn)(void *))
+int run_thread_with_file(struct thread_with_file *thr,
+			 const struct file_operations *fops,
+			 int (*fn)(void *))
 {
 	struct file *file = NULL;
 	int ret, fd = -1;
@@ -63,37 +197,7 @@ int bch2_run_thread_with_file(struct thread_with_file *thr,
 		kthread_stop(thr->task);
 	return ret;
 }
-
-/* stdio_redirect */
-
-static bool stdio_redirect_has_input(struct stdio_redirect *stdio)
-{
-	return stdio->input.buf.nr || stdio->done;
-}
-
-static bool stdio_redirect_has_output(struct stdio_redirect *stdio)
-{
-	return stdio->output.buf.nr || stdio->done;
-}
-
-#define STDIO_REDIRECT_BUFSIZE		4096
-
-static bool stdio_redirect_has_input_space(struct stdio_redirect *stdio)
-{
-	return stdio->input.buf.nr < STDIO_REDIRECT_BUFSIZE || stdio->done;
-}
-
-static bool stdio_redirect_has_output_space(struct stdio_redirect *stdio)
-{
-	return stdio->output.buf.nr < STDIO_REDIRECT_BUFSIZE || stdio->done;
-}
-
-static void stdio_buf_init(struct stdio_buf *buf)
-{
-	spin_lock_init(&buf->lock);
-	init_waitqueue_head(&buf->wait);
-	darray_init(&buf->buf);
-}
+EXPORT_SYMBOL_GPL(run_thread_with_file);
 
 /* thread_with_stdio */
 
@@ -126,10 +230,7 @@ static ssize_t thread_with_stdio_read(struct file *file, char __user *ubuf,
 			ubuf	+= b;
 			len	-= b;
 			copied	+= b;
-			buf->buf.nr -= b;
-			memmove(buf->buf.data,
-				buf->buf.data + b,
-				buf->buf.nr);
+			darray_remove_items(&buf->buf, buf->buf.data, b);
 		}
 		spin_unlock_irq(&buf->lock);
 	}
@@ -137,18 +238,6 @@ static ssize_t thread_with_stdio_read(struct file *file, char __user *ubuf,
 	return copied ?: ret;
 }
 
-static int thread_with_stdio_release(struct inode *inode, struct file *file)
-{
-	struct thread_with_stdio *thr =
-		container_of(file->private_data, struct thread_with_stdio, thr);
-
-	bch2_thread_with_file_exit(&thr->thr);
-	darray_exit(&thr->stdio.input.buf);
-	darray_exit(&thr->stdio.output.buf);
-	thr->exit(thr);
-	return 0;
-}
-
 static ssize_t thread_with_stdio_write(struct file *file, const char __user *ubuf,
 				       size_t len, loff_t *ppos)
 {
@@ -221,6 +310,18 @@ static __poll_t thread_with_stdio_poll(struct file *file, struct poll_table_stru
 	return mask;
 }
 
+static int thread_with_stdio_release(struct inode *inode, struct file *file)
+{
+	struct thread_with_stdio *thr =
+		container_of(file->private_data, struct thread_with_stdio, thr);
+
+	thread_with_file_exit(&thr->thr);
+	darray_exit(&thr->stdio.input.buf);
+	darray_exit(&thr->stdio.output.buf);
+	thr->exit(thr);
+	return 0;
+}
+
 static const struct file_operations thread_with_stdio_fops = {
 	.llseek		= no_llseek,
 	.read		= thread_with_stdio_read,
@@ -242,117 +343,18 @@ static int thread_with_stdio_fn(void *arg)
 	return 0;
 }
 
-int bch2_run_thread_with_stdio(struct thread_with_stdio *thr,
-			       void (*exit)(struct thread_with_stdio *),
-			       void (*fn)(struct thread_with_stdio *))
+int run_thread_with_stdio(struct thread_with_stdio *thr,
+			  void (*exit)(struct thread_with_stdio *),
+			  void (*fn)(struct thread_with_stdio *))
 {
 	stdio_buf_init(&thr->stdio.input);
 	stdio_buf_init(&thr->stdio.output);
 	thr->exit	= exit;
 	thr->fn		= fn;
 
-	return bch2_run_thread_with_file(&thr->thr, &thread_with_stdio_fops, thread_with_stdio_fn);
+	return run_thread_with_file(&thr->thr, &thread_with_stdio_fops, thread_with_stdio_fn);
 }
+EXPORT_SYMBOL_GPL(run_thread_with_stdio);
 
-int bch2_stdio_redirect_read(struct stdio_redirect *stdio, char *ubuf, size_t len)
-{
-	struct stdio_buf *buf = &stdio->input;
-
-	wait_event(buf->wait, stdio_redirect_has_input(stdio));
-	if (stdio->done)
-		return -1;
-
-	spin_lock(&buf->lock);
-	int ret = min(len, buf->buf.nr);
-	buf->buf.nr -= ret;
-	memcpy(ubuf, buf->buf.data, ret);
-	memmove(buf->buf.data,
-		buf->buf.data + ret,
-		buf->buf.nr);
-	spin_unlock(&buf->lock);
-
-	wake_up(&buf->wait);
-	return ret;
-}
-
-int bch2_stdio_redirect_readline(struct stdio_redirect *stdio, char *ubuf, size_t len)
-{
-	struct stdio_buf *buf = &stdio->input;
-	size_t copied = 0;
-	ssize_t ret = 0;
-again:
-	wait_event(buf->wait, stdio_redirect_has_input(stdio));
-	if (stdio->done) {
-		ret = -1;
-		goto out;
-	}
-
-	spin_lock(&buf->lock);
-	size_t b = min(len, buf->buf.nr);
-	char *n = memchr(buf->buf.data, '\n', b);
-	if (n)
-		b = min_t(size_t, b, n + 1 - buf->buf.data);
-	buf->buf.nr -= b;
-	memcpy(ubuf, buf->buf.data, b);
-	memmove(buf->buf.data,
-		buf->buf.data + b,
-		buf->buf.nr);
-	ubuf += b;
-	len -= b;
-	copied += b;
-	spin_unlock(&buf->lock);
-
-	wake_up(&buf->wait);
-
-	if (!n && len)
-		goto again;
-out:
-	return copied ?: ret;
-}
-
-__printf(3, 0)
-static void bch2_darray_vprintf(darray_char *out, gfp_t gfp, const char *fmt, va_list args)
-{
-	size_t len;
-
-	do {
-		va_list args2;
-		va_copy(args2, args);
-
-		len = vsnprintf(out->data + out->nr, darray_room(*out), fmt, args2);
-	} while (len + 1 > darray_room(*out) && !darray_make_room_gfp(out, len + 1, gfp));
-
-	out->nr += min(len, darray_room(*out));
-}
-
-void bch2_stdio_redirect_vprintf(struct stdio_redirect *stdio, bool nonblocking,
-				 const char *fmt, va_list args)
-{
-	struct stdio_buf *buf = &stdio->output;
-	unsigned long flags;
-
-	if (!nonblocking)
-		wait_event(buf->wait, stdio_redirect_has_output_space(stdio));
-	else if (!stdio_redirect_has_output_space(stdio))
-		return;
-	if (stdio->done)
-		return;
-
-	spin_lock_irqsave(&buf->lock, flags);
-	bch2_darray_vprintf(&buf->buf, nonblocking ? GFP_NOWAIT : GFP_KERNEL, fmt, args);
-	spin_unlock_irqrestore(&buf->lock, flags);
-
-	wake_up(&buf->wait);
-}
-
-void bch2_stdio_redirect_printf(struct stdio_redirect *stdio, bool nonblocking,
-				const char *fmt, ...)
-{
-
-	va_list args;
-	va_start(args, fmt);
-	bch2_stdio_redirect_vprintf(stdio, nonblocking, fmt, args);
-	va_end(args);
-}
-
-#endif /* NO_BCACHEFS_FS */
+MODULE_AUTHOR("Kent Overstreet");
+MODULE_LICENSE("GPL");


