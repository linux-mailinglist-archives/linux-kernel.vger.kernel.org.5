Return-Path: <linux-kernel+bounces-79414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC988621BB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2684AB2182C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B29DDCF;
	Sat, 24 Feb 2024 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvNUddRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC14C6B;
	Sat, 24 Feb 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737397; cv=none; b=JFw3tBGAlLla/XdtAcN1cRAq1bTMh4aX8h/VzN2+rp3LC3oMpcqKKAaTMB3ORjDMT3hdzzyLmKOEdc7+ZF7Eg69znF4Y/ZMvt9PWRfAWdnVM3oFGyYFfc6FofMQ3ZlDPy5ea7D4b2Qqxoph8cQ8SemoVKhCfKmCFfv0ExCz/88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737397; c=relaxed/simple;
	bh=N5BbLf22VJJFUcs1rkRIy9TnRfixcYINsE+roESUlYY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaeUZ2oilxeu413c/acIcd2T+klIGWMnoZ12gw7mIBbUtSih5hBtdEPiNoFKyp05lyNyv8wLjBt+ugyCDnKwwDocWDDPQKQiXmfbsOpayqJtOaOEveQxx2iQVHVSOsIAljYub9A01mH93jZAMZATB8OfFso8PSoU692/EbrCzIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvNUddRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11D8C433C7;
	Sat, 24 Feb 2024 01:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737397;
	bh=N5BbLf22VJJFUcs1rkRIy9TnRfixcYINsE+roESUlYY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DvNUddRaPdKJD636x3F8T/hFYH/97iqVGwp9X+vFguzGI54dKbE7Zf5UpnHnUICfh
	 Phm71WuHorVTVBFYF8EJEaShJDE1Jq9MKDLuKrn2BzhKm6IDyplKcHd2I5mEpZ4GSW
	 F8nYrdWu6u+Udgz94PIJquvZed0396HvfI5qVcKJcPenRgF4BetRKf76gemB/UufK2
	 ZBMGmb/emxXL6PlQAWEgtKLaLH9VjU7fKJf0+7ywSSKNq+82y/GrjPi4OVxKVSYK66
	 P5QPjPsRdaRDDSgENW+3qKagiKyx/5k5ZWC+LrYdfI6DWNTjX7NtnBzOacfOuHQnkF
	 wkMDZude8VKqw==
Date: Fri, 23 Feb 2024 17:16:36 -0800
Subject: [PATCH 1/5] thread_with_file: allow creation of readonly files
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873669417.1861696.15370508953432477102.stgit@frogsfrogsfrogs>
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

Create a new run_thread_with_stdout function that opens a file in
O_RDONLY mode so that the kernel can write things to userspace but
userspace cannot write to the kernel.  This will be used to convey xfs
health event information to userspace.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/thread_with_file.h |    3 +++
 lib/thread_with_file.c           |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)


diff --git a/include/linux/thread_with_file.h b/include/linux/thread_with_file.h
index 54091f7ff3383..5f7e85bc8322b 100644
--- a/include/linux/thread_with_file.h
+++ b/include/linux/thread_with_file.h
@@ -62,6 +62,9 @@ struct thread_with_stdio {
 int run_thread_with_stdio(struct thread_with_stdio *,
 			  void (*exit)(struct thread_with_stdio *),
 			  void (*fn)(struct thread_with_stdio *));
+int run_thread_with_stdout(struct thread_with_stdio *,
+			  void (*exit)(struct thread_with_stdio *),
+			  void (*fn)(struct thread_with_stdio *));
 int stdio_redirect_read(struct stdio_redirect *, char *, size_t);
 int stdio_redirect_readline(struct stdio_redirect *, char *, size_t);
 
diff --git a/lib/thread_with_file.c b/lib/thread_with_file.c
index b09dc60ba6280..71028611b8d59 100644
--- a/lib/thread_with_file.c
+++ b/lib/thread_with_file.c
@@ -344,6 +344,22 @@ static int thread_with_stdio_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static __poll_t thread_with_stdout_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct thread_with_stdio *thr =
+		container_of(file->private_data, struct thread_with_stdio, thr);
+
+	poll_wait(file, &thr->stdio.output.wait, wait);
+
+	__poll_t mask = 0;
+
+	if (stdio_redirect_has_output(&thr->stdio))
+		mask |= EPOLLIN;
+	if (thr->thr.done)
+		mask |= EPOLLHUP|EPOLLERR;
+	return mask;
+}
+
 static const struct file_operations thread_with_stdio_fops = {
 	.llseek		= no_llseek,
 	.read		= thread_with_stdio_read,
@@ -352,6 +368,13 @@ static const struct file_operations thread_with_stdio_fops = {
 	.release	= thread_with_stdio_release,
 };
 
+static const struct file_operations thread_with_stdout_fops = {
+	.llseek		= no_llseek,
+	.read		= thread_with_stdio_read,
+	.poll		= thread_with_stdout_poll,
+	.release	= thread_with_stdio_release,
+};
+
 static int thread_with_stdio_fn(void *arg)
 {
 	struct thread_with_stdio *thr = arg;
@@ -375,5 +398,18 @@ int run_thread_with_stdio(struct thread_with_stdio *thr,
 }
 EXPORT_SYMBOL_GPL(run_thread_with_stdio);
 
+int run_thread_with_stdout(struct thread_with_stdio *thr,
+			  void (*exit)(struct thread_with_stdio *),
+			  void (*fn)(struct thread_with_stdio *))
+{
+	stdio_buf_init(&thr->stdio.input);
+	stdio_buf_init(&thr->stdio.output);
+	thr->exit	= exit;
+	thr->fn		= fn;
+
+	return run_thread_with_file(&thr->thr, &thread_with_stdout_fops, thread_with_stdio_fn);
+}
+EXPORT_SYMBOL_GPL(run_thread_with_stdout);
+
 MODULE_AUTHOR("Kent Overstreet");
 MODULE_LICENSE("GPL");


