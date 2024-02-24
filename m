Return-Path: <linux-kernel+bounces-79416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F28621BF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC64A1C2280E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389BF5CB8;
	Sat, 24 Feb 2024 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMRrz7yz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672424691;
	Sat, 24 Feb 2024 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737428; cv=none; b=jWTpPGfK6SnKHVl+1Gj+9D8y5gztKvWzsKt4MvDZYXln4DI3I4GBrDSOWaZKJp/jfrOJ9jiOSXYQTLf1B8gBpD9n4YtwC0gyC4bdus/EeOHxrJ3Nbpz8+FJWR6X0XLjiCi5/G3Nxi7Q6amPCHgLn38XcqJMJ46f9D8Xz74LuwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737428; c=relaxed/simple;
	bh=DgDuStDbtXbx/gj/++6OCZ66DPB+bjIkuDO5hm8rH/I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMQWC6NGLEFCEsrafAHAW5tTkI3Jw0t99g5c8nQLxC0IJyHrfK8dxyrHI8foZzkU6eqgHjrNIpPb+fR4P2ZLsEd03ghuVlHmvfiXpwoEIBMvpZcllzNBfooNqRz7eZIY0FUs6VGyDoF7QHPsVZXVfjUf8g3X+E50YHi9kjG2T5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMRrz7yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA8FC433F1;
	Sat, 24 Feb 2024 01:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737428;
	bh=DgDuStDbtXbx/gj/++6OCZ66DPB+bjIkuDO5hm8rH/I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uMRrz7yzMPJu2KLe3x5dsgFpvLeAv7ZuamZcKrPOgZvkHLcF30TOZMru+vrti8nuz
	 gZHAaToYTqL3n85QuOzBXOsrax1jpfQ5eTQ7ZIzxnyE3vhcw9otYeiFGPEwQSvhhMT
	 Lhb5ITjTJnidzrmQeY5sK+aLmhM30iCB69G4XB2UloqeRsRRhjEcD5J331SxiD7ZCu
	 8BA3AjrNTjtay8OYNCAbowXMJjxP8VIQ3+E57ec9ahU771DdZcoVnBNC1iCUWRnY8D
	 biOvII1pw9NdOYfQN/REYCuhX+5y8nCT7H1BB5jgBEEv9dhjdDOe8WeaxVmaD4BCND
	 TlWL8mtl7bo+w==
Date: Fri, 23 Feb 2024 17:17:07 -0800
Subject: [PATCH 3/5] thread_with_file: create ops structure for
 thread_with_stdio
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873669449.1861696.15191973366470386898.stgit@frogsfrogsfrogs>
In-Reply-To: <170873669390.1861696.14195299906744951144.stgit@frogsfrogsfrogs>
References: <170873669390.1861696.14195299906744951144.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create an ops structure so we can add more file-based functionality in
the next few patches.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/chardev.c            |   18 ++++++++++++------
 include/linux/thread_with_file.h |   16 ++++++++++------
 lib/thread_with_file.c           |   16 ++++++----------
 3 files changed, 28 insertions(+), 22 deletions(-)


diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 4cbda66bb6e0f..a2f30f45f93f7 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -165,6 +165,11 @@ static void bch2_fsck_offline_thread_fn(struct thread_with_stdio *stdio)
 		bch2_fs_stop(c);
 }
 
+static const struct thread_with_stdio_ops bch2_offline_fsck_ops = {
+	.exit		= bch2_fsck_thread_exit,
+	.fn		= bch2_fsck_offline_thread_fn,
+};
+
 static long bch2_ioctl_fsck_offline(struct bch_ioctl_fsck_offline __user *user_arg)
 {
 	struct bch_ioctl_fsck_offline arg;
@@ -217,9 +222,7 @@ static long bch2_ioctl_fsck_offline(struct bch_ioctl_fsck_offline __user *user_a
 
 	opt_set(thr->opts, stdio, (u64)(unsigned long)&thr->thr.stdio);
 
-	ret = run_thread_with_stdio(&thr->thr,
-			bch2_fsck_thread_exit,
-			bch2_fsck_offline_thread_fn);
+	ret = run_thread_with_stdio(&thr->thr, &bch2_offline_fsck_ops);
 err:
 	if (ret < 0) {
 		if (thr)
@@ -794,6 +797,11 @@ static void bch2_fsck_online_thread_fn(struct thread_with_stdio *stdio)
 	bch2_ro_ref_put(c);
 }
 
+static const struct thread_with_stdio_ops bch2_online_fsck_ops = {
+	.exit		= bch2_fsck_thread_exit,
+	.fn		= bch2_fsck_online_thread_fn,
+};
+
 static long bch2_ioctl_fsck_online(struct bch_fs *c,
 				   struct bch_ioctl_fsck_online arg)
 {
@@ -834,9 +842,7 @@ static long bch2_ioctl_fsck_online(struct bch_fs *c,
 			goto err;
 	}
 
-	ret = run_thread_with_stdio(&thr->thr,
-			bch2_fsck_thread_exit,
-			bch2_fsck_online_thread_fn);
+	ret = run_thread_with_stdio(&thr->thr, &bch2_online_fsck_ops);
 err:
 	if (ret < 0) {
 		bch_err_fn(c, ret);
diff --git a/include/linux/thread_with_file.h b/include/linux/thread_with_file.h
index 7b133a15d3540..445b1b12a0bd6 100644
--- a/include/linux/thread_with_file.h
+++ b/include/linux/thread_with_file.h
@@ -52,19 +52,23 @@ int run_thread_with_file(struct thread_with_file *,
 			 const struct file_operations *,
 			 int (*fn)(void *));
 
+struct thread_with_stdio;
+
+struct thread_with_stdio_ops {
+	void (*exit)(struct thread_with_stdio *);
+	void (*fn)(struct thread_with_stdio *);
+};
+
 struct thread_with_stdio {
 	struct thread_with_file	thr;
 	struct stdio_redirect	stdio;
-	void			(*exit)(struct thread_with_stdio *);
-	void			(*fn)(struct thread_with_stdio *);
+	const struct thread_with_stdio_ops	*ops;
 };
 
 int run_thread_with_stdio(struct thread_with_stdio *,
-			  void (*exit)(struct thread_with_stdio *),
-			  void (*fn)(struct thread_with_stdio *));
+			  const struct thread_with_stdio_ops *);
 int run_thread_with_stdout(struct thread_with_stdio *,
-			  void (*exit)(struct thread_with_stdio *),
-			  void (*fn)(struct thread_with_stdio *));
+			  const struct thread_with_stdio_ops *);
 int stdio_redirect_read(struct stdio_redirect *, char *, size_t);
 int stdio_redirect_readline(struct stdio_redirect *, char *, size_t);
 
diff --git a/lib/thread_with_file.c b/lib/thread_with_file.c
index 70a805ef017f9..2edf33c3e7dc5 100644
--- a/lib/thread_with_file.c
+++ b/lib/thread_with_file.c
@@ -359,7 +359,7 @@ static int thread_with_stdio_release(struct inode *inode, struct file *file)
 	thread_with_file_exit(&thr->thr);
 	darray_exit(&thr->stdio.input.buf);
 	darray_exit(&thr->stdio.output.buf);
-	thr->exit(thr);
+	thr->ops->exit(thr);
 	return 0;
 }
 
@@ -398,33 +398,29 @@ static int thread_with_stdio_fn(void *arg)
 {
 	struct thread_with_stdio *thr = arg;
 
-	thr->fn(thr);
+	thr->ops->fn(thr);
 
 	thread_with_stdio_done(thr);
 	return 0;
 }
 
 int run_thread_with_stdio(struct thread_with_stdio *thr,
-			  void (*exit)(struct thread_with_stdio *),
-			  void (*fn)(struct thread_with_stdio *))
+			  const struct thread_with_stdio_ops *ops)
 {
 	stdio_buf_init(&thr->stdio.input);
 	stdio_buf_init(&thr->stdio.output);
-	thr->exit	= exit;
-	thr->fn		= fn;
+	thr->ops = ops;
 
 	return run_thread_with_file(&thr->thr, &thread_with_stdio_fops, thread_with_stdio_fn);
 }
 EXPORT_SYMBOL_GPL(run_thread_with_stdio);
 
 int run_thread_with_stdout(struct thread_with_stdio *thr,
-			  void (*exit)(struct thread_with_stdio *),
-			  void (*fn)(struct thread_with_stdio *))
+			   const struct thread_with_stdio_ops *ops)
 {
 	stdio_buf_init(&thr->stdio.input);
 	stdio_buf_init(&thr->stdio.output);
-	thr->exit	= exit;
-	thr->fn		= fn;
+	thr->ops = ops;
 
 	return run_thread_with_file(&thr->thr, &thread_with_stdout_fops, thread_with_stdio_fn);
 }


