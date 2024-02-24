Return-Path: <linux-kernel+bounces-79411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ADB8621B4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE8D2855DC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFA74A34;
	Sat, 24 Feb 2024 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9afMtX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D7625;
	Sat, 24 Feb 2024 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737350; cv=none; b=ffcG17frEOdWLwvP1TWpSC5xEcfuBZDNgGie9FwxzHnpE4y6jyaWBwKYJqDLb8WgZjTj/8G7dgWntOEMvSlQVF7+x5rzAKj50VOmkK6yO2tcl8lyI6NUCyKYy2ry6La6My1qBFHFqijAn0wX/W4EarIKtEJJp10qkl70uPmfr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737350; c=relaxed/simple;
	bh=SqW/eE4ssRbXCZM7r2fVia0zdNVyh9xWEqJ5//VHBpk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+cIjOpmQILHLzDeYe+umwdbRXAKjNL0+lg9D3kV9CNBXPp5rLCWyvj4Iyu3KdUG+BUJNP57mUsMhODdlcdhWKdB7+5aTje7A2H1bIwLZF+AMI7tUih2o6WGrmji3R3N4eZ3hdng2S9wiNkVVW0u2cgKC54fPW0OflU7wErVj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9afMtX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16619C433C7;
	Sat, 24 Feb 2024 01:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737350;
	bh=SqW/eE4ssRbXCZM7r2fVia0zdNVyh9xWEqJ5//VHBpk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C9afMtX6n6yz2v4DMQFskWpvmgaS8RYnt/l5D7tY1Tm/wOJBz5T4JI+62sEFGpmd5
	 HLvHZvCF8x1mTG0RmjZIKSJs3P1ycDsLdnZtkf41EImNCVvneaDDHKrVos3EYzWmku
	 kd0EPO1U15z7uF/5Xhf7FJuRdbtAuXzPXc0Q+h3p8GM9lCENk8HnQmzyIP0ZsXWJ1J
	 j3/LiKmmzR2nUkcb2+DDxKyNvFR6yPJvHwcXGENM3JjKRq56Ww8lPr/iZuPYiaOZDl
	 vo3+J1fS1cJ4Efh03Bd5pbwe4SY0qay+r1u7cOwHc8LTV27qg985MRzBsz6XUFc9Hi
	 ewT6meZI3/ORg==
Date: Fri, 23 Feb 2024 17:15:49 -0800
Subject: [PATCH 08/10] thread_with_stdio: Mark completed in ->release()
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873669018.1861398.16986816951760275853.stgit@frogsfrogsfrogs>
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

This fixes stdio_redirect_read() getting stuck, not noticing that the
pipe has been closed.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 lib/thread_with_file.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


diff --git a/lib/thread_with_file.c b/lib/thread_with_file.c
index 092996ca43fe7..f4946a437332a 100644
--- a/lib/thread_with_file.c
+++ b/lib/thread_with_file.c
@@ -201,6 +201,14 @@ EXPORT_SYMBOL_GPL(run_thread_with_file);
 
 /* thread_with_stdio */
 
+static void thread_with_stdio_done(struct thread_with_stdio *thr)
+{
+	thr->thr.done = true;
+	thr->stdio.done = true;
+	wake_up(&thr->stdio.input.wait);
+	wake_up(&thr->stdio.output.wait);
+}
+
 static ssize_t thread_with_stdio_read(struct file *file, char __user *ubuf,
 				      size_t len, loff_t *ppos)
 {
@@ -315,6 +323,7 @@ static int thread_with_stdio_release(struct inode *inode, struct file *file)
 	struct thread_with_stdio *thr =
 		container_of(file->private_data, struct thread_with_stdio, thr);
 
+	thread_with_stdio_done(thr);
 	thread_with_file_exit(&thr->thr);
 	darray_exit(&thr->stdio.input.buf);
 	darray_exit(&thr->stdio.output.buf);
@@ -336,10 +345,7 @@ static int thread_with_stdio_fn(void *arg)
 
 	thr->fn(thr);
 
-	thr->thr.done = true;
-	thr->stdio.done = true;
-	wake_up(&thr->stdio.input.wait);
-	wake_up(&thr->stdio.output.wait);
+	thread_with_stdio_done(thr);
 	return 0;
 }
 


