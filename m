Return-Path: <linux-kernel+bounces-79402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0F18621A3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629DA281859
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B944963D9;
	Sat, 24 Feb 2024 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijULxIhe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E842539A;
	Sat, 24 Feb 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737256; cv=none; b=S/VSrrjGfplo213sDbNGcwgmp4qMNnzQBEdWD3jDLRavv4g4twk1YOd/4oPZcF61MZqMSggEqBcIPPFknP0jjregGOXy0lN8Fs9HXMFVtgI0K8MpcPXRNUUFNgX+EWvoOh5LD8aQuzAkQWuaF3HLed/uyC/Swj4BEAR/NGSHVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737256; c=relaxed/simple;
	bh=NjLiI8pacKpcUJAY1OZkiN3LT8gdA1loA+Lw/eP3d1o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUlP7ArKUlJn5bfL3QsFviSSz8bJFtVwAzWPAcKn4HJ42kjPow1kYwUEUBes7x/L0WxCgtEfUE+aTQW8SI5cOhv9AyLY4Cie0Ymhvph+BnxxzwFNzFG2cRF7Ws442vILzF1v2mrBbFFnCjFfmJSfSZ19RJqTqsaZ2VzbwrV576Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijULxIhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64671C433F1;
	Sat, 24 Feb 2024 01:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737256;
	bh=NjLiI8pacKpcUJAY1OZkiN3LT8gdA1loA+Lw/eP3d1o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ijULxIheSS3c7QQEx0EyMeXuLhwHWDAqe3Kzv0GheYiuuQJume2I3NLcJHR6KcQfo
	 KWR0vfIBExdxOR1ZiHZ2vokUEzjX66z4XPCa0p8OyMTX6vPp9ReKFDfjTpZ1kgMgnd
	 A77hYh2J01H14tmWHFcKDWGmQQenCNtYDvnHDblNI+jQDHTq6PEIUuNsyhXwwFQerD
	 jhUj3e+Wvwtrfkdx3drArIDqVHF2X5ofdGWUn2PNxnh6AtCNcb+3RAowMG2cHmN8cw
	 Ky6kPxIMDAjMRB67LJOgYa08GxNJ/5VnwuDEvqdBxepCDqntjP68XeVcCikfI5SjfZ
	 qnL/8mK9NTS0w==
Date: Fri, 23 Feb 2024 17:14:15 -0800
Subject: [PATCH 02/10] bcachefs: thread_with_stdio: convert to darray
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668918.1861398.3412112770361050404.stgit@frogsfrogsfrogs>
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

- eliminate the dependency on printbufs, so that we can lift
   thread_with_file for use in xfs
 - add a nonblocking parameter to stdio_redirect_printf(), and either
   block if the buffer is full or drop it on the floor - don't buffer
   infinitely

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/bcachefs/super.c                  |    9 -
 fs/bcachefs/thread_with_file.c       |  229 +++++++++++++++++++++-------------
 fs/bcachefs/thread_with_file.h       |    7 +
 fs/bcachefs/thread_with_file_types.h |   15 ++
 4 files changed, 160 insertions(+), 100 deletions(-)


diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 2c238030fb5d7..0cff8c5f3c104 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -56,6 +56,7 @@
 #include "super.h"
 #include "super-io.h"
 #include "sysfs.h"
+#include "thread_with_file.h"
 #include "trace.h"
 
 #include <linux/backing-dev.h>
@@ -95,16 +96,10 @@ void __bch2_print(struct bch_fs *c, const char *fmt, ...)
 	if (likely(!stdio)) {
 		vprintk(fmt, args);
 	} else {
-		unsigned long flags;
-
 		if (fmt[0] == KERN_SOH[0])
 			fmt += 2;
 
-		spin_lock_irqsave(&stdio->output_lock, flags);
-		prt_vprintf(&stdio->output_buf, fmt, args);
-		spin_unlock_irqrestore(&stdio->output_lock, flags);
-
-		wake_up(&stdio->output_wait);
+		bch2_stdio_redirect_vprintf(stdio, true, fmt, args);
 	}
 	va_end(args);
 }
diff --git a/fs/bcachefs/thread_with_file.c b/fs/bcachefs/thread_with_file.c
index 8c3afb4c3204f..ca81d3fec3eef 100644
--- a/fs/bcachefs/thread_with_file.c
+++ b/fs/bcachefs/thread_with_file.c
@@ -2,7 +2,6 @@
 #ifndef NO_BCACHEFS_FS
 
 #include "bcachefs.h"
-#include "printbuf.h"
 #include "thread_with_file.h"
 
 #include <linux/anon_inodes.h>
@@ -65,48 +64,74 @@ int bch2_run_thread_with_file(struct thread_with_file *thr,
 	return ret;
 }
 
-static inline bool thread_with_stdio_has_output(struct thread_with_stdio *thr)
+/* stdio_redirect */
+
+static bool stdio_redirect_has_input(struct stdio_redirect *stdio)
 {
-	return thr->stdio.output_buf.pos || thr->thr.done;
+	return stdio->input.buf.nr || stdio->done;
 }
 
+static bool stdio_redirect_has_output(struct stdio_redirect *stdio)
+{
+	return stdio->output.buf.nr || stdio->done;
+}
+
+#define WRITE_BUFFER		4096
+
+static bool stdio_redirect_has_input_space(struct stdio_redirect *stdio)
+{
+	return stdio->input.buf.nr < WRITE_BUFFER || stdio->done;
+}
+
+static bool stdio_redirect_has_output_space(struct stdio_redirect *stdio)
+{
+	return stdio->output.buf.nr < WRITE_BUFFER || stdio->done;
+}
+
+static void stdio_buf_init(struct stdio_buf *buf)
+{
+	spin_lock_init(&buf->lock);
+	init_waitqueue_head(&buf->wait);
+	darray_init(&buf->buf);
+}
+
+/* thread_with_stdio */
+
 static ssize_t thread_with_stdio_read(struct file *file, char __user *ubuf,
 				      size_t len, loff_t *ppos)
 {
 	struct thread_with_stdio *thr =
 		container_of(file->private_data, struct thread_with_stdio, thr);
-	struct printbuf *buf = &thr->stdio.output_buf;
+	struct stdio_buf *buf = &thr->stdio.output;
 	size_t copied = 0, b;
 	int ret = 0;
 
-	if ((file->f_flags & O_NONBLOCK) &&
-	    !thread_with_stdio_has_output(thr))
+	if (!(file->f_flags & O_NONBLOCK)) {
+		ret = wait_event_interruptible(buf->wait, stdio_redirect_has_output(&thr->stdio));
+		if (ret)
+			return ret;
+	} else if (!stdio_redirect_has_output(&thr->stdio))
 		return -EAGAIN;
 
-	ret = wait_event_interruptible(thr->stdio.output_wait,
-		thread_with_stdio_has_output(thr));
-	if (ret)
-		return ret;
-
-	while (len && buf->pos) {
+	while (len && buf->buf.nr) {
 		if (fault_in_writeable(ubuf, len) == len) {
 			ret = -EFAULT;
 			break;
 		}
 
-		spin_lock_irq(&thr->stdio.output_lock);
-		b = min_t(size_t, len, buf->pos);
+		spin_lock_irq(&buf->lock);
+		b = min_t(size_t, len, buf->buf.nr);
 
-		if (b && !copy_to_user_nofault(ubuf, buf->buf, b)) {
-			memmove(buf->buf,
-				buf->buf + b,
-				buf->pos - b);
-			buf->pos -= b;
+		if (b && !copy_to_user_nofault(ubuf, buf->buf.data, b)) {
 			ubuf	+= b;
 			len	-= b;
 			copied	+= b;
+			buf->buf.nr -= b;
+			memmove(buf->buf.data,
+				buf->buf.data + b,
+				buf->buf.nr);
 		}
-		spin_unlock_irq(&thr->stdio.output_lock);
+		spin_unlock_irq(&buf->lock);
 	}
 
 	return copied ?: ret;
@@ -118,25 +143,18 @@ static int thread_with_stdio_release(struct inode *inode, struct file *file)
 		container_of(file->private_data, struct thread_with_stdio, thr);
 
 	bch2_thread_with_file_exit(&thr->thr);
-	printbuf_exit(&thr->stdio.input_buf);
-	printbuf_exit(&thr->stdio.output_buf);
+	darray_exit(&thr->stdio.input.buf);
+	darray_exit(&thr->stdio.output.buf);
 	thr->exit(thr);
 	return 0;
 }
 
-#define WRITE_BUFFER		4096
-
-static inline bool thread_with_stdio_has_input_space(struct thread_with_stdio *thr)
-{
-	return thr->stdio.input_buf.pos < WRITE_BUFFER || thr->thr.done;
-}
-
 static ssize_t thread_with_stdio_write(struct file *file, const char __user *ubuf,
 				       size_t len, loff_t *ppos)
 {
 	struct thread_with_stdio *thr =
 		container_of(file->private_data, struct thread_with_stdio, thr);
-	struct printbuf *buf = &thr->stdio.input_buf;
+	struct stdio_buf *buf = &thr->stdio.input;
 	size_t copied = 0;
 	ssize_t ret = 0;
 
@@ -152,29 +170,29 @@ static ssize_t thread_with_stdio_write(struct file *file, const char __user *ubu
 			break;
 		}
 
-		spin_lock(&thr->stdio.input_lock);
-		if (buf->pos < WRITE_BUFFER)
-			bch2_printbuf_make_room(buf, min(b, WRITE_BUFFER - buf->pos));
-		b = min(len, printbuf_remaining_size(buf));
+		spin_lock(&buf->lock);
+		if (buf->buf.nr < WRITE_BUFFER)
+			darray_make_room_gfp(&buf->buf, min(b, WRITE_BUFFER - buf->buf.nr), __GFP_NOWARN);
+		b = min(len, darray_room(buf->buf));
 
-		if (b && !copy_from_user_nofault(&buf->buf[buf->pos], ubuf, b)) {
-			ubuf += b;
-			len -= b;
-			copied += b;
-			buf->pos += b;
+		if (b && !copy_from_user_nofault(&buf->buf.data[buf->buf.nr], ubuf, b)) {
+			buf->buf.nr += b;
+			ubuf	+= b;
+			len	-= b;
+			copied	+= b;
 		}
-		spin_unlock(&thr->stdio.input_lock);
+		spin_unlock(&buf->lock);
 
 		if (b) {
-			wake_up(&thr->stdio.input_wait);
+			wake_up(&buf->wait);
 		} else {
 			if ((file->f_flags & O_NONBLOCK)) {
 				ret = -EAGAIN;
 				break;
 			}
 
-			ret = wait_event_interruptible(thr->stdio.input_wait,
-					thread_with_stdio_has_input_space(thr));
+			ret = wait_event_interruptible(buf->wait,
+					stdio_redirect_has_input_space(&thr->stdio));
 			if (ret)
 				break;
 		}
@@ -188,14 +206,14 @@ static __poll_t thread_with_stdio_poll(struct file *file, struct poll_table_stru
 	struct thread_with_stdio *thr =
 		container_of(file->private_data, struct thread_with_stdio, thr);
 
-	poll_wait(file, &thr->stdio.output_wait, wait);
-	poll_wait(file, &thr->stdio.input_wait, wait);
+	poll_wait(file, &thr->stdio.output.wait, wait);
+	poll_wait(file, &thr->stdio.input.wait, wait);
 
 	__poll_t mask = 0;
 
-	if (thread_with_stdio_has_output(thr))
+	if (stdio_redirect_has_output(&thr->stdio))
 		mask |= EPOLLIN;
-	if (thread_with_stdio_has_input_space(thr))
+	if (stdio_redirect_has_input_space(&thr->stdio))
 		mask |= EPOLLOUT;
 	if (thr->thr.done)
 		mask |= EPOLLHUP|EPOLLERR;
@@ -203,75 +221,112 @@ static __poll_t thread_with_stdio_poll(struct file *file, struct poll_table_stru
 }
 
 static const struct file_operations thread_with_stdio_fops = {
-	.release	= thread_with_stdio_release,
+	.llseek		= no_llseek,
 	.read		= thread_with_stdio_read,
 	.write		= thread_with_stdio_write,
 	.poll		= thread_with_stdio_poll,
-	.llseek		= no_llseek,
+	.release	= thread_with_stdio_release,
 };
 
 int bch2_run_thread_with_stdio(struct thread_with_stdio *thr,
 			       void (*exit)(struct thread_with_stdio *),
 			       int (*fn)(void *))
 {
-	thr->stdio.input_buf = PRINTBUF;
-	thr->stdio.input_buf.atomic++;
-	spin_lock_init(&thr->stdio.input_lock);
-	init_waitqueue_head(&thr->stdio.input_wait);
-
-	thr->stdio.output_buf = PRINTBUF;
-	thr->stdio.output_buf.atomic++;
-	spin_lock_init(&thr->stdio.output_lock);
-	init_waitqueue_head(&thr->stdio.output_wait);
-
+	stdio_buf_init(&thr->stdio.input);
+	stdio_buf_init(&thr->stdio.output);
 	thr->exit = exit;
 
 	return bch2_run_thread_with_file(&thr->thr, &thread_with_stdio_fops, fn);
 }
 
-int bch2_stdio_redirect_read(struct stdio_redirect *stdio, char *buf, size_t len)
+int bch2_stdio_redirect_read(struct stdio_redirect *stdio, char *ubuf, size_t len)
 {
-	wait_event(stdio->input_wait,
-		   stdio->input_buf.pos || stdio->done);
+	struct stdio_buf *buf = &stdio->input;
 
+	wait_event(buf->wait, stdio_redirect_has_input(stdio));
 	if (stdio->done)
 		return -1;
 
-	spin_lock(&stdio->input_lock);
-	int ret = min(len, stdio->input_buf.pos);
-	stdio->input_buf.pos -= ret;
-	memcpy(buf, stdio->input_buf.buf, ret);
-	memmove(stdio->input_buf.buf,
-		stdio->input_buf.buf + ret,
-		stdio->input_buf.pos);
-	spin_unlock(&stdio->input_lock);
+	spin_lock(&buf->lock);
+	int ret = min(len, buf->buf.nr);
+	buf->buf.nr -= ret;
+	memcpy(ubuf, buf->buf.data, ret);
+	memmove(buf->buf.data,
+		buf->buf.data + ret,
+		buf->buf.nr);
+	spin_unlock(&buf->lock);
 
-	wake_up(&stdio->input_wait);
+	wake_up(&buf->wait);
 	return ret;
 }
 
-int bch2_stdio_redirect_readline(struct stdio_redirect *stdio, char *buf, size_t len)
+int bch2_stdio_redirect_readline(struct stdio_redirect *stdio, char *ubuf, size_t len)
 {
-	wait_event(stdio->input_wait,
-		   stdio->input_buf.pos || stdio->done);
+	struct stdio_buf *buf = &stdio->input;
 
+	wait_event(buf->wait, stdio_redirect_has_input(stdio));
 	if (stdio->done)
 		return -1;
 
-	spin_lock(&stdio->input_lock);
-	int ret = min(len, stdio->input_buf.pos);
-	char *n = memchr(stdio->input_buf.buf, '\n', ret);
-	if (n)
-		ret = min(ret, n + 1 - stdio->input_buf.buf);
-	stdio->input_buf.pos -= ret;
-	memcpy(buf, stdio->input_buf.buf, ret);
-	memmove(stdio->input_buf.buf,
-		stdio->input_buf.buf + ret,
-		stdio->input_buf.pos);
-	spin_unlock(&stdio->input_lock);
-
-	wake_up(&stdio->input_wait);
+	spin_lock(&buf->lock);
+	int ret = min(len, buf->buf.nr);
+	char *n = memchr(buf->buf.data, '\n', ret);
+	if (!n)
+		ret = min(ret, n + 1 - buf->buf.data);
+	buf->buf.nr -= ret;
+	memcpy(ubuf, buf->buf.data, ret);
+	memmove(buf->buf.data,
+		buf->buf.data + ret,
+		buf->buf.nr);
+	spin_unlock(&buf->lock);
+
+	wake_up(&buf->wait);
 	return ret;
 }
 
+__printf(3, 0)
+static void bch2_darray_vprintf(darray_char *out, gfp_t gfp, const char *fmt, va_list args)
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
+void bch2_stdio_redirect_vprintf(struct stdio_redirect *stdio, bool nonblocking,
+				 const char *fmt, va_list args)
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
+	bch2_darray_vprintf(&buf->buf, nonblocking ? __GFP_NOWARN : GFP_KERNEL, fmt, args);
+	spin_unlock_irqrestore(&buf->lock, flags);
+
+	wake_up(&buf->wait);
+}
+
+void bch2_stdio_redirect_printf(struct stdio_redirect *stdio, bool nonblocking,
+				const char *fmt, ...)
+{
+
+	va_list args;
+	va_start(args, fmt);
+	bch2_stdio_redirect_vprintf(stdio, nonblocking, fmt, args);
+	va_end(args);
+}
+
 #endif /* NO_BCACHEFS_FS */
diff --git a/fs/bcachefs/thread_with_file.h b/fs/bcachefs/thread_with_file.h
index b5098b52db709..4243c7c5ad3f3 100644
--- a/fs/bcachefs/thread_with_file.h
+++ b/fs/bcachefs/thread_with_file.h
@@ -27,8 +27,8 @@ static inline void thread_with_stdio_done(struct thread_with_stdio *thr)
 {
 	thr->thr.done = true;
 	thr->stdio.done = true;
-	wake_up(&thr->stdio.input_wait);
-	wake_up(&thr->stdio.output_wait);
+	wake_up(&thr->stdio.input.wait);
+	wake_up(&thr->stdio.output.wait);
 }
 
 int bch2_run_thread_with_stdio(struct thread_with_stdio *,
@@ -37,4 +37,7 @@ int bch2_run_thread_with_stdio(struct thread_with_stdio *,
 int bch2_stdio_redirect_read(struct stdio_redirect *, char *, size_t);
 int bch2_stdio_redirect_readline(struct stdio_redirect *, char *, size_t);
 
+__printf(3, 0) void bch2_stdio_redirect_vprintf(struct stdio_redirect *, bool, const char *, va_list);
+__printf(3, 4) void bch2_stdio_redirect_printf(struct stdio_redirect *, bool, const char *, ...);
+
 #endif /* _BCACHEFS_THREAD_WITH_FILE_H */
diff --git a/fs/bcachefs/thread_with_file_types.h b/fs/bcachefs/thread_with_file_types.h
index 90b5e645e98ce..e0daf4eec341e 100644
--- a/fs/bcachefs/thread_with_file_types.h
+++ b/fs/bcachefs/thread_with_file_types.h
@@ -2,14 +2,21 @@
 #ifndef _BCACHEFS_THREAD_WITH_FILE_TYPES_H
 #define _BCACHEFS_THREAD_WITH_FILE_TYPES_H
 
+#include "darray.h"
+
+struct stdio_buf {
+	spinlock_t		lock;
+	wait_queue_head_t	wait;
+	darray_char		buf;
+};
+
 struct stdio_redirect {
-	spinlock_t		output_lock;
-	wait_queue_head_t	output_wait;
-	struct printbuf		output_buf;
+	struct stdio_buf	input;
+	struct stdio_buf	output;
 
 	spinlock_t		input_lock;
 	wait_queue_head_t	input_wait;
-	struct printbuf		input_buf;
+	darray_char		input_buf;
 	bool			done;
 };
 


