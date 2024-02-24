Return-Path: <linux-kernel+bounces-79417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3717B8621C1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F8A1F27D07
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4E98F6E;
	Sat, 24 Feb 2024 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wqb8uP3n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9C69473;
	Sat, 24 Feb 2024 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737444; cv=none; b=GXo4ngTHdJpPt1VO2/UAoOn7ypaHEaJNQ1ka7ic/J1TVbg624wJZSHfiWx/dn90W2ogCu2AWCwLW9tBbQrKudr33UEihKNYzHzMyuAOKPsIdDo9jCcA8JC1gTKnD51Xk+HUiwYe6+u8lCKPOaczw+maKJ4pikYac5/ZAxHcZqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737444; c=relaxed/simple;
	bh=6IgKAnRC9HZ1+DMx6qKSJXO282zOxYj2aK6NUSak7mk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bq/VMMMuRs9xZmKZhIQe8Hfal8qItvoPubbCmNpu+fLbiqKc7m45EvrYgxPiHKpNd7S/37z3EvzAGnYsJohP7JphZQHE5kMYUgTVaqiNnCKDfbwxKPKnToz5YGwX9B6kZnrpzndMQpnCXChYiLEWk0rf0SCh7rbECUdH1H2adGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqb8uP3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53E1C433F1;
	Sat, 24 Feb 2024 01:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737443;
	bh=6IgKAnRC9HZ1+DMx6qKSJXO282zOxYj2aK6NUSak7mk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Wqb8uP3nEts44NoynAnfg3U+0J8HQh8VOOnAhIr1TugjJfxfrXA4qaUNKp6BfS9C+
	 teqcKULtwbzl9POLu3eBa8zacMjWL2Z765IgRu4xsVflxDfJ8I+U2yk5NKrOYCiyXT
	 u03WSOHXd/QjYtdMgaiadMd8czDYBng7K1GbFy9F7p7OMyYgqKU08aFQrdjTbNLEaN
	 MQ6odQ2KA8zSf3nK/v/LCi5gcPRt34ZSRlEcy5LN/lNIOW4E0Nk0RIcEr73buYuG4i
	 j33ovb8qtry7TvaJtMwv09qnLwjW7i5el2WsDrWnMA5irxrFJ+FgqcN9DiEt0LWX+7
	 0YmX5v/KpCYQg==
Date: Fri, 23 Feb 2024 17:17:23 -0800
Subject: [PATCH 4/5] thread_with_file: allow ioctls against these files
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873669465.1861696.18118008706761741778.stgit@frogsfrogsfrogs>
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

Make it so that a thread_with_stdio user can handle ioctls against the
file descriptor.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/thread_with_file.h |    1 +
 lib/thread_with_file.c           |   12 ++++++++++++
 2 files changed, 13 insertions(+)


diff --git a/include/linux/thread_with_file.h b/include/linux/thread_with_file.h
index 445b1b12a0bd6..33770938d5d9a 100644
--- a/include/linux/thread_with_file.h
+++ b/include/linux/thread_with_file.h
@@ -57,6 +57,7 @@ struct thread_with_stdio;
 struct thread_with_stdio_ops {
 	void (*exit)(struct thread_with_stdio *);
 	void (*fn)(struct thread_with_stdio *);
+	long (*unlocked_ioctl)(struct thread_with_stdio *, unsigned int, unsigned long);
 };
 
 struct thread_with_stdio {
diff --git a/lib/thread_with_file.c b/lib/thread_with_file.c
index 2edf33c3e7dc5..8b129744a48a3 100644
--- a/lib/thread_with_file.c
+++ b/lib/thread_with_file.c
@@ -379,12 +379,23 @@ static __poll_t thread_with_stdout_poll(struct file *file, struct poll_table_str
 	return mask;
 }
 
+static long thread_with_stdio_ioctl(struct file *file, unsigned int cmd, unsigned long p)
+{
+	struct thread_with_stdio *thr =
+		container_of(file->private_data, struct thread_with_stdio, thr);
+
+	if (thr->ops->unlocked_ioctl)
+		return thr->ops->unlocked_ioctl(thr, cmd, p);
+	return -ENOTTY;
+}
+
 static const struct file_operations thread_with_stdio_fops = {
 	.llseek		= no_llseek,
 	.read		= thread_with_stdio_read,
 	.write		= thread_with_stdio_write,
 	.poll		= thread_with_stdio_poll,
 	.release	= thread_with_stdio_release,
+	.unlocked_ioctl	= thread_with_stdio_ioctl,
 };
 
 static const struct file_operations thread_with_stdout_fops = {
@@ -392,6 +403,7 @@ static const struct file_operations thread_with_stdout_fops = {
 	.read		= thread_with_stdio_read,
 	.poll		= thread_with_stdout_poll,
 	.release	= thread_with_stdio_release,
+	.unlocked_ioctl	= thread_with_stdio_ioctl,
 };
 
 static int thread_with_stdio_fn(void *arg)


