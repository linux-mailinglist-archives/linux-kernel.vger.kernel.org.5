Return-Path: <linux-kernel+bounces-140824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F438A191E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310121F2169B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762CF84FD5;
	Thu, 11 Apr 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZltHpDtg"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A184A3B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849613; cv=none; b=LZXq24fRrdAPTcT7eMecC0byffxOZsq3hFRjyhASJGlXK+aAsT7ZOI1UOMLeoEGStz6xLER5q1O4Jk0SkjjFL4YsgaUiFmuHZQOqmSjTc/FvQ1rhifAttyi0zzdK76RsWWriZ26LGS/rSgDGkFKrPGUZA1IyAiWaSWiQctmbhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849613; c=relaxed/simple;
	bh=rrBQgYpHCwAEWWkFPxfv35Ue70KnvIvyy2HW7s0Qh8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7cO++tmgCnPE9O7jfssNy2KfM9nR0Rsw9S9TTwNiwanVCak8nLsOpMREK5vpQgNegvpoD+p7v81sZNOEQXDhhbV+i3kNhnk7PArIMvZktZm5HotyBkszhCyurwprFeF4mvLriK3ENvQlWucQTP1UNZZMI3LpF8v1c7JtJd+Jj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZltHpDtg; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16115839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849611; x=1713454411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Mg5nSttiu9jhSU99CuPVX2s5BPmxHpPxQ+MtB0IkuE=;
        b=ZltHpDtga3mrffH4OosmgjVpZoWbNnf0isZxKZSDr43JeDWzKiU0qstl3KyTPn/heD
         Cr8FT4FtzpFo/bzV5dUIyBs+15Je9KVarZ1emyInsERn+4HqTpUHQudpmoDBqlPeK67G
         yp2+lbxUCayfwmhWvU7E6MneSMr+tdnXvYAY52+GTa3GsbHSggjPGPyNetVZnsSrfICn
         jddvB1iV8ucKPqBYJeOI3ZWjdGzujMc3vd/5mJe8qEdAI5vESmXOv6TNpQVD2vi99IBV
         U7yMLvhCIQeyvLI2xW3nV0yK+MOcGA7x2VaXu4kCselQFTAYKuZyiazjDYRB5KbeX4xk
         M9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849611; x=1713454411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Mg5nSttiu9jhSU99CuPVX2s5BPmxHpPxQ+MtB0IkuE=;
        b=YcyCvWkQic1b/M+RpssneTX0vsuxCyi35zzodokDMjRt95aj9D/TqL19xYNHU7zeu1
         4e89fbCgEDWPL1w1VB+m5gu+xh1HovZq61SXA7SfKYLGjbjnSNKx8/bzu+cLHWkdJCm2
         dZUhEBOTbbimQAQuLaJJIWIwj03Z3nsNGeyROqJcelIZz0IK5HC2m7/BIjxDaQUaGfES
         t93vMUAx1soS5uKxH+1Go3Sh/GMHr49e8hw6u+LAoQctkD8BrF+5hMPc8wtjPi3BnX6o
         aK8u7zgdnKtc9neXTE8kIFQ7PWXhHBcm6F40AVDrYTRKXQ+OTyyF6NPj2LrqZpucHgpy
         e5Cw==
X-Gm-Message-State: AOJu0YzJCV/El0ATvyvCvyVg6nr1DljH5v16c9uRUpm5S+3bb1Wincq7
	FdRVjeXLlgN4MqK41vMC14n+4Osk9YGZQnQ7HPAyzFIgcq/o76qpPHNlh9qzG9psjjU3TuS86Rl
	5
X-Google-Smtp-Source: AGHT+IGfPw3pX/4EqLcR1WzvEJK5q44DBwYolIvIMQCDvyw0iAKoeoCBBFetsDpNco1UV3kLY+eXeQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr174595iov.2.1712849611109;
        Thu, 11 Apr 2024 08:33:31 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 064/437] ASoC: SOF: icp3-dtrace: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:24 -0600
Message-ID: <20240411153126.16201-65-axboe@kernel.dk>
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
 sound/soc/sof/ipc3-dtrace.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/ipc3-dtrace.c b/sound/soc/sof/ipc3-dtrace.c
index 0dca139322f3..e8cc151b8110 100644
--- a/sound/soc/sof/ipc3-dtrace.c
+++ b/sound/soc/sof/ipc3-dtrace.c
@@ -217,10 +217,11 @@ static ssize_t dfsentry_trace_filter_write(struct file *file, const char __user
 	kfree(elems);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(dfsentry_trace_filter_write);
 
 static const struct file_operations sof_dfs_trace_filter_fops = {
 	.open = simple_open,
-	.write = dfsentry_trace_filter_write,
+	.write_iter = dfsentry_trace_filter_write_iter,
 	.llseek = default_llseek,
 };
 
@@ -313,14 +314,14 @@ static size_t sof_wait_dtrace_avail(struct snd_sof_dev *sdev, loff_t pos,
 	return sof_dtrace_avail(sdev, pos, buffer_size);
 }
 
-static ssize_t dfsentry_dtrace_read(struct file *file, char __user *buffer,
-				    size_t count, loff_t *ppos)
+static ssize_t dfsentry_dtrace_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_sof_dfsentry *dfse = file->private_data;
+	struct snd_sof_dfsentry *dfse = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct snd_sof_dev *sdev = dfse->sdev;
 	struct sof_dtrace_priv *priv = sdev->fw_trace_data;
 	unsigned long rem;
-	loff_t lpos = *ppos;
+	loff_t lpos = iocb->ki_pos;
 	size_t avail, buffer_size = dfse->size;
 	u64 lpos_64;
 
@@ -360,11 +361,11 @@ static ssize_t dfsentry_dtrace_read(struct file *file, char __user *buffer,
 	 */
 	snd_dma_buffer_sync(&priv->dmatb, SNDRV_DMA_SYNC_CPU);
 	/* copy available trace data to debugfs */
-	rem = copy_to_user(buffer, ((u8 *)(dfse->buf) + lpos), count);
+	rem = !copy_to_iter_full(((u8 *)(dfse->buf) + lpos), count, to);
 	if (rem)
 		return -EFAULT;
 
-	*ppos += count;
+	iocb->ki_pos += count;
 
 	/* move debugfs reading position */
 	return count;
@@ -385,7 +386,7 @@ static int dfsentry_dtrace_release(struct inode *inode, struct file *file)
 
 static const struct file_operations sof_dfs_dtrace_fops = {
 	.open = simple_open,
-	.read = dfsentry_dtrace_read,
+	.read_iter = dfsentry_dtrace_read,
 	.llseek = default_llseek,
 	.release = dfsentry_dtrace_release,
 };
-- 
2.43.0


