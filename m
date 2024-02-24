Return-Path: <linux-kernel+bounces-79403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDCA8621A6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBE01F26782
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D246A2;
	Sat, 24 Feb 2024 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXsByNU7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB417CE;
	Sat, 24 Feb 2024 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737272; cv=none; b=Nh39L65NnoJxt5PrQ11DvSYax7QhQGtmJr1uZAlQaBVUTS5DkAmRrpXLrZUOhgYmMTssQ7oYVzbZQnkm+WoLYi3Gv1vC8fs1S9g8kAtUGPY5+YffLURqAe2IzRpNArvPlLz8/iJxHXKKgLmRAHKU6HaT8fpqEDxVxTSPE2z0OwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737272; c=relaxed/simple;
	bh=4DWCYNwd0sAkpJVbYblT2DpEN5SOBTiIC1AWEcInB6g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6Edyo/wpIGlwaPWhgR+VczdaAlShDm0u+qSO3rf8WvY3hZT7vefbBL0vRfR5GIHjtaYZu1wYBcvDEhHry1os6ln7jjV6A6B7gw3ONXYmXK0bkZDQm+asbCtcFVQvkesF7xybaA4nHRlcWXFl9lbuNVXZT3WUpKtn5jLdoMAk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXsByNU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B58C433C7;
	Sat, 24 Feb 2024 01:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737272;
	bh=4DWCYNwd0sAkpJVbYblT2DpEN5SOBTiIC1AWEcInB6g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eXsByNU7G6qWzcIJZAiYxd2Ze4BGVRPjUy1ayH18d9s0CrUSvn7S6cPbN8IteaDJx
	 39wFSbUXxOeOywBXSCrvjd6f5n5cHkqrzqD8TTcAjsKVHB6hqjOOdVWWKVVf/OjKRJ
	 98yOZt5FV0+peamfS6IfETJSxDwuuhHjcaHICRaEVQzlrePnzQoAANQpL8WVN3VnDB
	 MYJ3E/CAMVfWF7U0TO4xdY1v/zzMgaw5zVp4Xkz/4cnJ9K+UG6yJwYUTbHhaiBQ4OT
	 EeybXtSh+9MglKtk8erTepZG4pvmahntTNKX+AgGXZ2yAUmjOf0tdq5H0psNT9YPDI
	 7wNNts6ARsDHg==
Date: Fri, 23 Feb 2024 17:14:31 -0800
Subject: [PATCH 03/10] bcachefs: thread_with_stdio: kill
 thread_with_stdio_done()
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668934.1861398.15847269494413781482.stgit@frogsfrogsfrogs>
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

Move the cleanup code to a wrapper function, where we can call it after
the thread_with_stdio fn exits.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/bcachefs/chardev.c          |   14 ++++----------
 fs/bcachefs/thread_with_file.c |   20 +++++++++++++++++---
 fs/bcachefs/thread_with_file.h |   11 ++---------
 3 files changed, 23 insertions(+), 22 deletions(-)


diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 226b39c176673..11711f54057e1 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -155,17 +155,14 @@ static void bch2_fsck_thread_exit(struct thread_with_stdio *_thr)
 	kfree(thr);
 }
 
-static int bch2_fsck_offline_thread_fn(void *arg)
+static void bch2_fsck_offline_thread_fn(struct thread_with_stdio *stdio)
 {
-	struct fsck_thread *thr = container_of(arg, struct fsck_thread, thr);
+	struct fsck_thread *thr = container_of(stdio, struct fsck_thread, thr);
 	struct bch_fs *c = bch2_fs_open(thr->devs, thr->nr_devs, thr->opts);
 
 	thr->thr.thr.ret = PTR_ERR_OR_ZERO(c);
 	if (!thr->thr.thr.ret)
 		bch2_fs_stop(c);
-
-	thread_with_stdio_done(&thr->thr);
-	return 0;
 }
 
 static long bch2_ioctl_fsck_offline(struct bch_ioctl_fsck_offline __user *user_arg)
@@ -763,9 +760,9 @@ static long bch2_ioctl_disk_resize_journal(struct bch_fs *c,
 	return ret;
 }
 
-static int bch2_fsck_online_thread_fn(void *arg)
+static void bch2_fsck_online_thread_fn(struct thread_with_stdio *stdio)
 {
-	struct fsck_thread *thr = container_of(arg, struct fsck_thread, thr);
+	struct fsck_thread *thr = container_of(stdio, struct fsck_thread, thr);
 	struct bch_fs *c = thr->c;
 
 	c->stdio_filter = current;
@@ -793,11 +790,8 @@ static int bch2_fsck_online_thread_fn(void *arg)
 	c->stdio_filter = NULL;
 	c->opts.fix_errors = old_fix_errors;
 
-	thread_with_stdio_done(&thr->thr);
-
 	up(&c->online_fsck_mutex);
 	bch2_ro_ref_put(c);
-	return 0;
 }
 
 static long bch2_ioctl_fsck_online(struct bch_fs *c,
diff --git a/fs/bcachefs/thread_with_file.c b/fs/bcachefs/thread_with_file.c
index ca81d3fec3eef..eb8ab4c47a94b 100644
--- a/fs/bcachefs/thread_with_file.c
+++ b/fs/bcachefs/thread_with_file.c
@@ -228,15 +228,29 @@ static const struct file_operations thread_with_stdio_fops = {
 	.release	= thread_with_stdio_release,
 };
 
+static int thread_with_stdio_fn(void *arg)
+{
+	struct thread_with_stdio *thr = arg;
+
+	thr->fn(thr);
+
+	thr->thr.done = true;
+	thr->stdio.done = true;
+	wake_up(&thr->stdio.input.wait);
+	wake_up(&thr->stdio.output.wait);
+	return 0;
+}
+
 int bch2_run_thread_with_stdio(struct thread_with_stdio *thr,
 			       void (*exit)(struct thread_with_stdio *),
-			       int (*fn)(void *))
+			       void (*fn)(struct thread_with_stdio *))
 {
 	stdio_buf_init(&thr->stdio.input);
 	stdio_buf_init(&thr->stdio.output);
-	thr->exit = exit;
+	thr->exit	= exit;
+	thr->fn		= fn;
 
-	return bch2_run_thread_with_file(&thr->thr, &thread_with_stdio_fops, fn);
+	return bch2_run_thread_with_file(&thr->thr, &thread_with_stdio_fops, thread_with_stdio_fn);
 }
 
 int bch2_stdio_redirect_read(struct stdio_redirect *stdio, char *ubuf, size_t len)
diff --git a/fs/bcachefs/thread_with_file.h b/fs/bcachefs/thread_with_file.h
index 4243c7c5ad3f3..66212fcae226a 100644
--- a/fs/bcachefs/thread_with_file.h
+++ b/fs/bcachefs/thread_with_file.h
@@ -21,19 +21,12 @@ struct thread_with_stdio {
 	struct thread_with_file	thr;
 	struct stdio_redirect	stdio;
 	void			(*exit)(struct thread_with_stdio *);
+	void			(*fn)(struct thread_with_stdio *);
 };
 
-static inline void thread_with_stdio_done(struct thread_with_stdio *thr)
-{
-	thr->thr.done = true;
-	thr->stdio.done = true;
-	wake_up(&thr->stdio.input.wait);
-	wake_up(&thr->stdio.output.wait);
-}
-
 int bch2_run_thread_with_stdio(struct thread_with_stdio *,
 			       void (*exit)(struct thread_with_stdio *),
-			       int (*fn)(void *));
+			       void (*fn)(struct thread_with_stdio *));
 int bch2_stdio_redirect_read(struct stdio_redirect *, char *, size_t);
 int bch2_stdio_redirect_readline(struct stdio_redirect *, char *, size_t);
 


