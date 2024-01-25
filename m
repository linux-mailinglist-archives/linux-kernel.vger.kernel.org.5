Return-Path: <linux-kernel+bounces-39433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437183D111
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C60B1C24608
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F091D6AB;
	Thu, 25 Jan 2024 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rg6zDdom"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49961B59A;
	Thu, 25 Jan 2024 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227061; cv=none; b=hw6tyITyJuZdixd6k3mhaGYCovw500s47eMdh11J8jHPCjiVIfhi+k/HGD0a+uCKt2G8y2KCndy8soEQPaMZ6BDrDep3PH/zZfRbBLp1hH1MHnypFrVbiqToVHjQc2t7igbpb/wb2F2olJ7qUtujJNwKVvM3e4IjE9bYhHLaOCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227061; c=relaxed/simple;
	bh=FKBREtj8gYP8EY7HfUrJK9Zp1Jdp/dowThfEAGkB4+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0fpifCzue4hGDGr4o3fduWoYEDAzvrersN9EYyCtZdZZo+WVLwgItNFIwhkV9xLsANUAPxfGCPmLuTHrtEBkqqwN0F7sBo7qM85WhkLgooH5cSvoA16+b2m1EVWW7jmLrxPRiGzhafaVvPG1aQqLRcFFyF6yb342UOsiV/cMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rg6zDdom; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706227059; x=1737763059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FKBREtj8gYP8EY7HfUrJK9Zp1Jdp/dowThfEAGkB4+4=;
  b=Rg6zDdomHb701a52Ibx9TbYZRCiwRVHbp67jgaYQks4Ig5lW0yVTqj0P
   8CfqWC/bPJ/PIhMrTYjqaYqqE2x4l8lSnSK9UySwegQTiL+mFGAskFeTJ
   6dUQGlVNSs3WPBPuGGv66qE4ZQ7OJ1400S4DLrFBNakHum3U2oBS9IhMl
   kqbp+sEzQEn4fhMCprQqnQ+/oxzRUdUsYQ00IxOHZcmVKW/r6awtEov6m
   4nIOROjEo2Tf0OdwSBW8W+PylP807uOAi+XjPmdKrJyqizhAgPj20FoFb
   V8wNv33LiV34pVi90EfxtYLFlQCaqYfDSiuxnRCZtjGqaYbYkiBeIu+or
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15867575"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15867575"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:57:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930191107"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930191107"
Received: from vcostago-mobl3.jf.intel.com ([10.24.14.99])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:57:36 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [RFC v2 4/4] fs: Optimize credentials reference count for backing file ops
Date: Thu, 25 Jan 2024 15:57:23 -0800
Message-ID: <20240125235723.39507-5-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125235723.39507-1-vinicius.gomes@intel.com>
References: <20240125235723.39507-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For backing file operations, users are expected to pass credentials
that will outlive the backing file common operations.

Use the specialized guard statements to override/revert the
credentials.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/backing-file.c | 124 ++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 64 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index a681f38d84d8..9874f09f860f 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -140,7 +140,7 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			       struct backing_file_ctx *ctx)
 {
 	struct backing_aio *aio = NULL;
-	const struct cred *old_cred;
+	const struct cred *old_cred = ctx->cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -153,29 +153,28 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 	    !(file->f_mode & FMODE_CAN_ODIRECT))
 		return -EINVAL;
 
-	old_cred = override_creds(ctx->cred);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(flags);
+	scoped_guard(cred, old_cred) {
+		if (is_sync_kiocb(iocb)) {
+			rwf_t rwf = iocb_to_rw_flags(flags);
 
-		ret = vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
-	} else {
-		ret = -ENOMEM;
-		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
-		if (!aio)
-			goto out;
+			ret = vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
+		} else {
+			ret = -ENOMEM;
+			aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
+			if (!aio)
+				goto out;
 
-		aio->orig_iocb = iocb;
-		kiocb_clone(&aio->iocb, iocb, get_file(file));
-		aio->iocb.ki_complete = backing_aio_rw_complete;
-		refcount_set(&aio->ref, 2);
-		ret = vfs_iocb_iter_read(file, &aio->iocb, iter);
-		backing_aio_put(aio);
-		if (ret != -EIOCBQUEUED)
-			backing_aio_cleanup(aio, ret);
+			aio->orig_iocb = iocb;
+			kiocb_clone(&aio->iocb, iocb, get_file(file));
+			aio->iocb.ki_complete = backing_aio_rw_complete;
+			refcount_set(&aio->ref, 2);
+			ret = vfs_iocb_iter_read(file, &aio->iocb, iter);
+			backing_aio_put(aio);
+			if (ret != -EIOCBQUEUED)
+				backing_aio_cleanup(aio, ret);
+		}
 	}
 out:
-	revert_creds(old_cred);
-
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
 
@@ -187,7 +186,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 				struct kiocb *iocb, int flags,
 				struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
+	const struct cred *old_cred = ctx->cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -210,39 +209,37 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 	 */
 	flags &= ~IOCB_DIO_CALLER_COMP;
 
-	old_cred = override_creds(ctx->cred);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(flags);
+	scoped_guard(cred, old_cred) {
+		if (is_sync_kiocb(iocb)) {
+			rwf_t rwf = iocb_to_rw_flags(flags);
 
-		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
-		if (ctx->end_write)
-			ctx->end_write(ctx->user_file);
-	} else {
-		struct backing_aio *aio;
+			ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
+			if (ctx->end_write)
+				ctx->end_write(ctx->user_file);
+		} else {
+			struct backing_aio *aio;
 
-		ret = backing_aio_init_wq(iocb);
-		if (ret)
-			goto out;
+			ret = backing_aio_init_wq(iocb);
+			if (ret)
+				return ret;
 
-		ret = -ENOMEM;
-		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
-		if (!aio)
-			goto out;
+			ret = -ENOMEM;
+			aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
+			if (!aio)
+				return ret;
 
-		aio->orig_iocb = iocb;
-		aio->end_write = ctx->end_write;
-		kiocb_clone(&aio->iocb, iocb, get_file(file));
-		aio->iocb.ki_flags = flags;
-		aio->iocb.ki_complete = backing_aio_queue_completion;
-		refcount_set(&aio->ref, 2);
-		ret = vfs_iocb_iter_write(file, &aio->iocb, iter);
-		backing_aio_put(aio);
-		if (ret != -EIOCBQUEUED)
-			backing_aio_cleanup(aio, ret);
+			aio->orig_iocb = iocb;
+			aio->end_write = ctx->end_write;
+			kiocb_clone(&aio->iocb, iocb, get_file(file));
+			aio->iocb.ki_flags = flags;
+			aio->iocb.ki_complete = backing_aio_queue_completion;
+			refcount_set(&aio->ref, 2);
+			ret = vfs_iocb_iter_write(file, &aio->iocb, iter);
+			backing_aio_put(aio);
+			if (ret != -EIOCBQUEUED)
+				backing_aio_cleanup(aio, ret);
+		}
 	}
-out:
-	revert_creds(old_cred);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(backing_file_write_iter);
@@ -252,15 +249,15 @@ ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
 				 unsigned int flags,
 				 struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
+	const struct cred *old_cred = ctx->cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(in->f_mode & FMODE_BACKING)))
 		return -EIO;
 
-	old_cred = override_creds(ctx->cred);
-	ret = vfs_splice_read(in, ppos, pipe, len, flags);
-	revert_creds(old_cred);
+	scoped_guard(cred, old_cred) {
+		ret = vfs_splice_read(in, ppos, pipe, len, flags);
+	}
 
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
@@ -274,7 +271,7 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 				  unsigned int flags,
 				  struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
+	const struct cred *old_cred = ctx->cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(out->f_mode & FMODE_BACKING)))
@@ -284,12 +281,11 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (ret)
 		return ret;
 
-	old_cred = override_creds(ctx->cred);
-	file_start_write(out);
-	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
-	file_end_write(out);
-	revert_creds(old_cred);
-
+	scoped_guard(cred, old_cred) {
+		file_start_write(out);
+		ret = iter_file_splice_write(pipe, out, ppos, len, flags);
+		file_end_write(out);
+	}
 	if (ctx->end_write)
 		ctx->end_write(ctx->user_file);
 
@@ -300,7 +296,7 @@ EXPORT_SYMBOL_GPL(backing_file_splice_write);
 int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 		      struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
+	const struct cred *old_cred = ctx->cred;
 	int ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
@@ -312,9 +308,9 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	old_cred = override_creds(ctx->cred);
-	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
+	scoped_guard(cred, old_cred) {
+		ret = call_mmap(vma->vm_file, vma);
+	}
 
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
-- 
2.43.0


