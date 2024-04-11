Return-Path: <linux-kernel+bounces-140976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19258A19E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56824285CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB911BC7BC;
	Thu, 11 Apr 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RCzpU39g"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765473A8C0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849849; cv=none; b=ikp1k6M4HfHyBruCnnqysY4DkH4ZZgVlv4ENqJxb1o6bc5LR0QYDZRC+8d4uySyWivUhv1DyNeZbheB8FFNjIavRhakj+SiGwsS9FwVMEaV5fL2bPG2toL0rkXbdYGbkpfgUcte+Bbeu9BHFTDJ3FxfNMQp2m9vJJ3IYhvdGx6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849849; c=relaxed/simple;
	bh=0/SqUhOqyvP7dy+vm6DJOfkb0cXjPjSgzA5axHn0tPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAuSvp+BrCwXM/9Y9XD2olpvGfDmGHdrcEtPgs6JS4L2K5mccT9Cqb7aaYThQhqUvjyATHX5t2SRf90XQEe8Xksbdkk8MA7PRFQMidndzVRh8SP9owYlfREDK3eZ3QSsiqg4zuLt0dGCzl0GuCg8LqoylwyDovwxlzypG6D6k6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RCzpU39g; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9819539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849847; x=1713454647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hTcAQNOw+MiQWoEZcItkLvAsb+s8QLNOgcdw+/kA+0=;
        b=RCzpU39gsqaqWCXS1DH3jL+rgvzP6dWSzx+MJtV+mrO4APr/m/doGHS5Apz1lnA0F5
         k1bDgwmDsJEZBfzczSJg/TlEgIKtEgZLOayO7lqqWDbFyUNJ8PCANz9ukVm6Ob7DN9VB
         Oa42tqkCvF5R7H/2NEVBwSMVXqZ1qiqWlfNLIjfh3MIIxkCtLJs6KglTcYA739dHteWb
         VnyJ5o/gI6m1pV5+8gpDmLVD+jV1b7AjHrjWmeKLJ398iWRlyod7pt60nFaLcvyBj5fE
         /i4UH6zg98wr0yw7yKRHAEzdrq3aRrSQlv5tjpmbire8V8HnHUCKxPNIl3wG/ve3GeoI
         rrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849847; x=1713454647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hTcAQNOw+MiQWoEZcItkLvAsb+s8QLNOgcdw+/kA+0=;
        b=T5a0GBkwhlpWWQfNgmZGRceh5e5pN/vKEQUYcc/754Xt3rUbyqDfFG7eSPhouLkIrE
         dlFLFwFbP315cV1NxP7utMnAcBdn8oL43YWxDErn+egKPggmeYH91CudOMnVcepnGEtc
         YmdqyBotS6Bz71Xb+6Kkifa/iL+G5s2k8iwtlr238KB6kCzd0rpKIsQlFmLl+rVoh+FU
         +GvtkzW6ggbQDHnBtBDvkODn1k6kg5viRpkyrWaIZaoiXXsZGrZipSPVxYuEZCzep+ks
         Y2K7mcljLb3B2iaP+NCIDFG7xAuRUqIJ8Tp7tjRYXokwUfuyAaU8at3PSjf7V3yGPyZp
         AOxA==
X-Gm-Message-State: AOJu0Yw8MeBnL4sZehGnuxrjQij07GRSQ4GHBjhPETdsHUYoJfgbpIDq
	d+oI62kodADHrdqY/fpw9bZpMrKCAiBhFDfmqoKXyZXbBcUWi5R+JgXSSmi3IpVjSelAy/9Qxan
	C
X-Google-Smtp-Source: AGHT+IE7RwaCw8KQF7ouMhe3VdA0QmFxpnxQwnqQynS9goV9pf0wyevBnTTW+KyXt8LH9dsYQNX24w==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr44760iob.2.1712849847192;
        Thu, 11 Apr 2024 08:37:27 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 207/437] virt: fsl_hypervisor: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:47 -0600
Message-ID: <20240411153126.16201-208-axboe@kernel.dk>
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
 drivers/virt/fsl_hypervisor.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index e92e2ceb12a4..dc84e0006201 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -590,11 +590,10 @@ static __poll_t fsl_hv_poll(struct file *filp, struct poll_table_struct *p)
  * return them to the caller as an array of 32-bit integers.  Otherwise,
  * block until there is at least one handle to return.
  */
-static ssize_t fsl_hv_read(struct file *filp, char __user *buf, size_t len,
-			   loff_t *off)
+static ssize_t fsl_hv_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct doorbell_queue *dbq = filp->private_data;
-	uint32_t __user *p = (uint32_t __user *) buf; /* for put_user() */
+	struct doorbell_queue *dbq = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	unsigned long flags;
 	ssize_t count = 0;
 
@@ -613,7 +612,7 @@ static ssize_t fsl_hv_read(struct file *filp, char __user *buf, size_t len,
 			spin_unlock_irqrestore(&dbq->lock, flags);
 			if (count)
 				break;
-			if (filp->f_flags & O_NONBLOCK)
+			if (iocb->ki_filp->f_flags & O_NONBLOCK)
 				return -EAGAIN;
 			if (wait_event_interruptible(dbq->wait,
 						     dbq->head != dbq->tail))
@@ -639,9 +638,8 @@ static ssize_t fsl_hv_read(struct file *filp, char __user *buf, size_t len,
 
 		spin_unlock_irqrestore(&dbq->lock, flags);
 
-		if (put_user(dbell, p))
+		if (put_iter(dbell, to))
 			return -EFAULT;
-		p++;
 		count += sizeof(uint32_t);
 		len -= sizeof(uint32_t);
 	}
@@ -700,7 +698,7 @@ static const struct file_operations fsl_hv_fops = {
 	.open = fsl_hv_open,
 	.release = fsl_hv_close,
 	.poll = fsl_hv_poll,
-	.read = fsl_hv_read,
+	.read_iter = fsl_hv_read,
 	.unlocked_ioctl = fsl_hv_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 };
-- 
2.43.0


