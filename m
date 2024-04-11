Return-Path: <linux-kernel+bounces-140820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18458A191A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221C51F2219B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D6382899;
	Thu, 11 Apr 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zVLnH65h"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCDA81AAA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849608; cv=none; b=m3dhv3xkapLaFyxzXiNWyC7bAvHsDuwxr3w/fmAdGAgdp2yzL6bECnzoXJaIDy1x0hyw8h2rp0+8GBmDkZMHnomcQTWKI3G/MSVmOIMRiHkL6pviI+Rc3Cm+3RGyMxdLYWt53J1AK0WJyC9/GLbKSXBmu4CPUpSKO1uLcORugIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849608; c=relaxed/simple;
	bh=Xjw9ymH6QYPl3HgbkXc0fcLRxarZel6uludn6INpOQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUK/x9nD6sI2yGn8HC4y/UhFgxEoxYEJtceUARxKuK7jlqpq+nkMsfPyKorCGJdP1vnr5hX1obpbKdiEkAEHRNWhPtZSKMlxpCh0GZuZVeKrO1+aEFzqhUcT04PaYgksaNBQaPY1fpu61wgZ8bMzTdh6pXsqlaI+duzkmj0a7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zVLnH65h; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8881639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849604; x=1713454404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDyStLHZd9A7AvqhY+ypiXDkX0T5cqUhGABzb6RtvfE=;
        b=zVLnH65h2PPOFRnUE2zqA8fJYhVLQ4AjE/xS9+nT1NTnAweGgsu/RTVmFHQSuUlpKe
         jwVR+zNsowU1QPT6LMnYByxU3cxzK6nhzE2gswvd4zYHc86hg65Ezxs5G7zLze2rFDDI
         7X0uMtL56le0+coAlP+Ce3dVD/iIfx4luWP2wTCTvS0R1BpmLLsaHNIIpphfcu0hpA3a
         3ZqUrgKxnH9n0PiJ4bTfBeYRJJ8yeq5vMH4vaKaqU1oWjsmUnMafQRjhWky+xL56zpA/
         d9X/k9nwgMyR6wevEo27TZA3sbfVKgF8NffXU86DPF3o+Q42ItrmBLoDfAPhEPLCb9CV
         kovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849604; x=1713454404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDyStLHZd9A7AvqhY+ypiXDkX0T5cqUhGABzb6RtvfE=;
        b=JN6ZRm+JMydK1WuuKiOvUmK7ts8FnBrGq0UmQWXIfE4GhxScC9PKBVXrodAnnZU0kp
         1AFCvbhiBzMae8LQ6AIcPm5X1R4jVRQgrw0Qje4anTEZMofq2X3BxvvcVspMTHPLGFpq
         aRebTMvXgT2GaGIzTnWgCDHDYJy1+ULWgYlz3PHiIRRxwDt5BTtyfFWXug7NascVoilf
         4RqKrpSQzC6i/z9ioOgRt9UVWnbEfbCwkX+0a2fQ1LMaeX1f5XHEABGYvRwRT2klK/nV
         WfnFRLLc0YQCt9DVVcmBM9sKEHKytohIcwLf+6R79JBS9uEJDXY5ntgk+s/V4unBnmmk
         SBIg==
X-Gm-Message-State: AOJu0YygMUjg1jcTfFWY4F4IPeAjKFd7ZVW13tEw+9iBsqv1T/SmN69k
	TcUmScC0mPpnMLf0OGpli8L0an3XpbqwbfXVECKQXBdCK2zzeh7GA11lxrTunVXXmp2rZaQgpUM
	r
X-Google-Smtp-Source: AGHT+IECSAbZ7xa0uQ45gWWbO7756cCOSr2hnUeNMww7MlEOYcfe2gmHR9lif5LbbWpmo2e/I4ICVQ==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr173134ioj.2.1712849603756;
        Thu, 11 Apr 2024 08:33:23 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 060/437] ASoC: Intel: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:20 -0600
Message-ID: <20240411153126.16201-61-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 sound/soc/intel/avs/debugfs.c       | 69 +++++++++++++++--------------
 sound/soc/intel/avs/pcm.c           |  9 ++--
 sound/soc/intel/skylake/skl-debug.c | 19 ++++----
 3 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/sound/soc/intel/avs/debugfs.c b/sound/soc/intel/avs/debugfs.c
index 4dfbff0ce508..ebab29e5e2bd 100644
--- a/sound/soc/intel/avs/debugfs.c
+++ b/sound/soc/intel/avs/debugfs.c
@@ -48,9 +48,9 @@ void avs_dump_fw_log_wakeup(struct avs_dev *adev, const void __iomem *src, unsig
 	wake_up(&adev->trace_waitq);
 }
 
-static ssize_t fw_regs_read(struct file *file, char __user *to, size_t count, loff_t *ppos)
+static ssize_t fw_regs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct avs_dev *adev = file->private_data;
+	struct avs_dev *adev = iocb->ki_filp->private_data;
 	char *buf;
 	int ret;
 
@@ -60,20 +60,20 @@ static ssize_t fw_regs_read(struct file *file, char __user *to, size_t count, lo
 
 	memcpy_fromio(buf, avs_sram_addr(adev, AVS_FW_REGS_WINDOW), AVS_FW_REGS_SIZE);
 
-	ret = simple_read_from_buffer(to, count, ppos, buf, AVS_FW_REGS_SIZE);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, AVS_FW_REGS_SIZE, to);
 	kfree(buf);
 	return ret;
 }
 
 static const struct file_operations fw_regs_fops = {
 	.open = simple_open,
-	.read = fw_regs_read,
+	.read_iter = fw_regs_read,
 	.llseek = no_llseek,
 };
 
-static ssize_t debug_window_read(struct file *file, char __user *to, size_t count, loff_t *ppos)
+static ssize_t debug_window_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct avs_dev *adev = file->private_data;
+	struct avs_dev *adev = iocb->ki_filp->private_data;
 	size_t size;
 	char *buf;
 	int ret;
@@ -85,27 +85,27 @@ static ssize_t debug_window_read(struct file *file, char __user *to, size_t coun
 
 	memcpy_fromio(buf, avs_sram_addr(adev, AVS_DEBUG_WINDOW), size);
 
-	ret = simple_read_from_buffer(to, count, ppos, buf, size);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, size, to);
 	kfree(buf);
 	return ret;
 }
 
 static const struct file_operations debug_window_fops = {
 	.open = simple_open,
-	.read = debug_window_read,
+	.read_iter = debug_window_read,
 	.llseek = no_llseek,
 };
 
-static ssize_t probe_points_read(struct file *file, char __user *to, size_t count, loff_t *ppos)
+static ssize_t probe_points_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct avs_dev *adev = file->private_data;
+	struct avs_dev *adev = iocb->ki_filp->private_data;
 	struct avs_probe_point_desc *desc;
 	size_t num_desc, len = 0;
 	char *buf;
 	int i, ret;
 
 	/* Prevent chaining, send and dump IPC value just once. */
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
@@ -127,7 +127,7 @@ static ssize_t probe_points_read(struct file *file, char __user *to, size_t coun
 		len += ret;
 	}
 
-	ret = simple_read_from_buffer(to, count, ppos, buf, len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 free_desc:
 	kfree(desc);
 exit:
@@ -135,16 +135,16 @@ static ssize_t probe_points_read(struct file *file, char __user *to, size_t coun
 	return ret;
 }
 
-static ssize_t probe_points_write(struct file *file, const char __user *from, size_t count,
-				  loff_t *ppos)
+static ssize_t probe_points_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct avs_dev *adev = file->private_data;
+	struct avs_dev *adev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct avs_probe_point_desc *desc;
 	u32 *array, num_elems;
 	size_t bytes;
 	int ret;
 
-	ret = parse_int_array_user(from, count, (int **)&array);
+	ret = parse_int_array_iter(from, (int **)&array);
 	if (ret < 0)
 		return ret;
 
@@ -168,21 +168,22 @@ static ssize_t probe_points_write(struct file *file, const char __user *from, si
 
 static const struct file_operations probe_points_fops = {
 	.open = simple_open,
-	.read = probe_points_read,
-	.write = probe_points_write,
+	.read_iter = probe_points_read,
+	.write_iter = probe_points_write,
 	.llseek = no_llseek,
 };
 
-static ssize_t probe_points_disconnect_write(struct file *file, const char __user *from,
-					     size_t count, loff_t *ppos)
+static ssize_t probe_points_disconnect_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct avs_dev *adev = file->private_data;
+	struct avs_dev *adev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	union avs_probe_point_id *id;
 	u32 *array, num_elems;
 	size_t bytes;
 	int ret;
 
-	ret = parse_int_array_user(from, count, (int **)&array);
+	ret = parse_int_array_iter(from, (int **)&array);
 	if (ret < 0)
 		return ret;
 
@@ -206,7 +207,7 @@ static ssize_t probe_points_disconnect_write(struct file *file, const char __use
 
 static const struct file_operations probe_points_disconnect_fops = {
 	.open = simple_open,
-	.write = probe_points_disconnect_write,
+	.write_iter = probe_points_disconnect_write,
 	.llseek = default_llseek,
 };
 
@@ -230,6 +231,7 @@ static ssize_t strace_read(struct file *file, char __user *to, size_t count, lof
 	*ppos += copied;
 	return copied;
 }
+FOPS_READ_ITER_HELPER(strace_read);
 
 static int strace_open(struct inode *inode, struct file *file)
 {
@@ -279,7 +281,7 @@ static int strace_release(struct inode *inode, struct file *file)
 
 static const struct file_operations strace_fops = {
 	.llseek = default_llseek,
-	.read = strace_read,
+	.read_iter = strace_read_iter,
 	.open = strace_open,
 	.release = strace_release,
 };
@@ -351,26 +353,25 @@ static int disable_logs(struct avs_dev *adev, u32 resource_mask)
 	return ret;
 }
 
-static ssize_t trace_control_read(struct file *file, char __user *to, size_t count, loff_t *ppos)
+static ssize_t trace_control_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct avs_dev *adev = file->private_data;
+	struct avs_dev *adev = iocb->ki_filp->private_data;
 	char buf[64];
 	int len;
 
 	len = snprintf(buf, sizeof(buf), "0x%08x\n", adev->logged_resources);
-
-	return simple_read_from_buffer(to, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t trace_control_write(struct file *file, const char __user *from, size_t count,
-				   loff_t *ppos)
+static ssize_t trace_control_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct avs_dev *adev = file->private_data;
+	struct avs_dev *adev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 *array, num_elems;
 	u32 resource_mask;
 	int ret;
 
-	ret = parse_int_array_user(from, count, (int **)&array);
+	ret = parse_int_array_iter(from, (int **)&array);
 	if (ret < 0)
 		return ret;
 
@@ -403,8 +404,8 @@ static ssize_t trace_control_write(struct file *file, const char __user *from, s
 
 static const struct file_operations trace_control_fops = {
 	.llseek = default_llseek,
-	.read = trace_control_read,
-	.write = trace_control_write,
+	.read_iter = trace_control_read,
+	.write_iter = trace_control_write,
 	.open = simple_open,
 };
 
diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index 2cafbc392cdb..631cb410fdfe 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -792,10 +792,9 @@ const struct snd_soc_dai_ops avs_dai_fe_ops = {
 	.trigger = avs_dai_fe_trigger,
 };
 
-static ssize_t topology_name_read(struct file *file, char __user *user_buf, size_t count,
-				  loff_t *ppos)
+static ssize_t topology_name_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_soc_component *component = file->private_data;
+	struct snd_soc_component *component = iocb->ki_filp->private_data;
 	struct snd_soc_card *card = component->card;
 	struct snd_soc_acpi_mach *mach = dev_get_platdata(card->dev);
 	char buf[64];
@@ -804,12 +803,12 @@ static ssize_t topology_name_read(struct file *file, char __user *user_buf, size
 	len = scnprintf(buf, sizeof(buf), "%s/%s\n", component->driver->topology_name_prefix,
 			mach->tplg_filename);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations topology_name_fops = {
 	.open = simple_open,
-	.read = topology_name_read,
+	.read_iter = topology_name_read,
 	.llseek = default_llseek,
 };
 
diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index a15aa2ffa681..a1715364729d 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -64,10 +64,9 @@ static ssize_t skl_print_fmt(struct skl_module_fmt *fmt, char *buf,
 			fmt->ch_map);
 }
 
-static ssize_t module_read(struct file *file, char __user *user_buf,
-			   size_t count, loff_t *ppos)
+static ssize_t module_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct skl_module_cfg *mconfig = file->private_data;
+	struct skl_module_cfg *mconfig = iocb->ki_filp->private_data;
 	struct skl_module *module = mconfig->module;
 	struct skl_module_res *res = &module->resources[mconfig->res_idx];
 	char *buf;
@@ -149,7 +148,7 @@ static ssize_t module_read(struct file *file, char __user *user_buf,
 			mconfig->dma_id, mconfig->mem_pages, mconfig->m_state,
 			mconfig->m_type);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 
 	kfree(buf);
 	return ret;
@@ -157,7 +156,7 @@ static ssize_t module_read(struct file *file, char __user *user_buf,
 
 static const struct file_operations mcfg_fops = {
 	.open = simple_open,
-	.read = module_read,
+	.read_iter = module_read,
 	.llseek = default_llseek,
 };
 
@@ -170,10 +169,9 @@ void skl_debug_init_module(struct skl_debug *d,
 			    &mcfg_fops);
 }
 
-static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t fw_softreg_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct skl_debug *d = file->private_data;
+	struct skl_debug *d = iocb->ki_filp->private_data;
 	struct sst_dsp *sst = d->skl->dsp;
 	size_t w0_stat_sz = sst->addr.w0_stat_sz;
 	void __iomem *in_base = sst->mailbox.in_base;
@@ -203,15 +201,14 @@ static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
 			tmp[ret++] = '\n';
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, tmp, ret);
+	ret = simple_copy_to_iter(tmp, &iocb->ki_pos, ret, to);
 	kfree(tmp);
-
 	return ret;
 }
 
 static const struct file_operations soft_regs_ctrl_fops = {
 	.open = simple_open,
-	.read = fw_softreg_read,
+	.read_iter = fw_softreg_read,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


