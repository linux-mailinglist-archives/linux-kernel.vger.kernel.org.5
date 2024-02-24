Return-Path: <linux-kernel+bounces-79401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B737C8621A1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E1E1C21122
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692B4416;
	Sat, 24 Feb 2024 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nvctf3rP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113417C9;
	Sat, 24 Feb 2024 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737241; cv=none; b=oxm7Y+C3V6BR4e4DgGUFRQX6feAJUBEK1LX8K7RB5VpsVlHRd+yzU1RLGvFBA9uMAwJflikyITUxS0+CbQxbdiJjhrza4XELBUaFIjkAl5U8sI+YmAlqwfVpexvOo+cdFBRTAHRiubCVe8yEvyGsmVR3ku+Vf7qB2DFjIo7Fyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737241; c=relaxed/simple;
	bh=UUGGJo6hKBHRWFMWSEO+bPNBd3Zh6s07ybvSES63b78=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8UDl7CesLx86mfyY/dkUYAF73PnSnviRkmvi6ZFVBPaLMJOBnS3iWQFBLMUhuyaUmvjKaXDRSuqxY3SpzlooZ9SuMeHKlfCzjNcbEnVjaEqsJ+EUdeP2r7vvcBDcvL108tCceXxJMwWsQz5IgG0sZpb4Nv1d+QdgmmB3lFbpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nvctf3rP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7E7C433F1;
	Sat, 24 Feb 2024 01:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737240;
	bh=UUGGJo6hKBHRWFMWSEO+bPNBd3Zh6s07ybvSES63b78=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Nvctf3rPhx0heBX5B5IJbfRJd87JvqO2t5LwUPuXzSSLtq3cvzZEgdOJ1PJqtnv8Q
	 dLPjIENfHdfXpxPO96JqKrPat2SeQIRjbcKKt7LfoxJQVvgClscrFgEHAVy8inFkB9
	 C91X2Eoql7bIb1cRQ4yKwLZzh6s+gXxADHIcS/QXkx+OTsqdDOt84Z0Uu23Y6bXQvS
	 Bg7keY5jGM2gx5keRGvqFbzOFbb1KIwx+eZ+3cRuUt2uw3X3t5Ow6AOwhMfczI6f5E
	 tZ/n/oTU0LTXa8ayUSRZiqA7XnOzEXdkbO92Y5/vtomYuJbYyzxew+qVwLrnPkm7LM
	 gwFFtqz57ydlQ==
Date: Fri, 23 Feb 2024 17:14:00 -0800
Subject: [PATCH 01/10] bcachefs: thread_with_stdio: eliminate double buffering
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668902.1861398.15653563093468101671.stgit@frogsfrogsfrogs>
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

The output buffer lock has to be a spinlock so that we can write to it
from interrupt context, so we can't use a direct copy_to_user; this
switches thread_with_file_read() to use fault_in_writeable() and
copy_to_user_nofault(), similar to how thread_with_file_write() works.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/bcachefs/thread_with_file.c |   56 ++++++++++++----------------------------
 fs/bcachefs/thread_with_file.h |    1 -
 2 files changed, 17 insertions(+), 40 deletions(-)


diff --git a/fs/bcachefs/thread_with_file.c b/fs/bcachefs/thread_with_file.c
index 9220d7de10db6..8c3afb4c3204f 100644
--- a/fs/bcachefs/thread_with_file.c
+++ b/fs/bcachefs/thread_with_file.c
@@ -67,16 +67,15 @@ int bch2_run_thread_with_file(struct thread_with_file *thr,
 
 static inline bool thread_with_stdio_has_output(struct thread_with_stdio *thr)
 {
-	return thr->stdio.output_buf.pos ||
-		thr->output2.nr ||
-		thr->thr.done;
+	return thr->stdio.output_buf.pos || thr->thr.done;
 }
 
-static ssize_t thread_with_stdio_read(struct file *file, char __user *buf,
+static ssize_t thread_with_stdio_read(struct file *file, char __user *ubuf,
 				      size_t len, loff_t *ppos)
 {
 	struct thread_with_stdio *thr =
 		container_of(file->private_data, struct thread_with_stdio, thr);
+	struct printbuf *buf = &thr->stdio.output_buf;
 	size_t copied = 0, b;
 	int ret = 0;
 
@@ -89,44 +88,25 @@ static ssize_t thread_with_stdio_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	if (thr->thr.done)
-		return 0;
-
-	while (len) {
-		ret = darray_make_room(&thr->output2, thr->stdio.output_buf.pos);
-		if (ret)
+	while (len && buf->pos) {
+		if (fault_in_writeable(ubuf, len) == len) {
+			ret = -EFAULT;
 			break;
+		}
 
 		spin_lock_irq(&thr->stdio.output_lock);
-		b = min_t(size_t, darray_room(thr->output2), thr->stdio.output_buf.pos);
+		b = min_t(size_t, len, buf->pos);
 
-		memcpy(&darray_top(thr->output2), thr->stdio.output_buf.buf, b);
-		memmove(thr->stdio.output_buf.buf,
-			thr->stdio.output_buf.buf + b,
-			thr->stdio.output_buf.pos - b);
-
-		thr->output2.nr += b;
-		thr->stdio.output_buf.pos -= b;
+		if (b && !copy_to_user_nofault(ubuf, buf->buf, b)) {
+			memmove(buf->buf,
+				buf->buf + b,
+				buf->pos - b);
+			buf->pos -= b;
+			ubuf	+= b;
+			len	-= b;
+			copied	+= b;
+		}
 		spin_unlock_irq(&thr->stdio.output_lock);
-
-		b = min(len, thr->output2.nr);
-		if (!b)
-			break;
-
-		b -= copy_to_user(buf, thr->output2.data, b);
-		if (!b) {
-			ret = -EFAULT;
-			break;
-		}
-
-		copied	+= b;
-		buf	+= b;
-		len	-= b;
-
-		memmove(thr->output2.data,
-			thr->output2.data + b,
-			thr->output2.nr - b);
-		thr->output2.nr -= b;
 	}
 
 	return copied ?: ret;
@@ -140,7 +120,6 @@ static int thread_with_stdio_release(struct inode *inode, struct file *file)
 	bch2_thread_with_file_exit(&thr->thr);
 	printbuf_exit(&thr->stdio.input_buf);
 	printbuf_exit(&thr->stdio.output_buf);
-	darray_exit(&thr->output2);
 	thr->exit(thr);
 	return 0;
 }
@@ -245,7 +224,6 @@ int bch2_run_thread_with_stdio(struct thread_with_stdio *thr,
 	spin_lock_init(&thr->stdio.output_lock);
 	init_waitqueue_head(&thr->stdio.output_wait);
 
-	darray_init(&thr->output2);
 	thr->exit = exit;
 
 	return bch2_run_thread_with_file(&thr->thr, &thread_with_stdio_fops, fn);
diff --git a/fs/bcachefs/thread_with_file.h b/fs/bcachefs/thread_with_file.h
index 05879c5048c87..b5098b52db709 100644
--- a/fs/bcachefs/thread_with_file.h
+++ b/fs/bcachefs/thread_with_file.h
@@ -20,7 +20,6 @@ int bch2_run_thread_with_file(struct thread_with_file *,
 struct thread_with_stdio {
 	struct thread_with_file	thr;
 	struct stdio_redirect	stdio;
-	DARRAY(char)		output2;
 	void			(*exit)(struct thread_with_stdio *);
 };
 


