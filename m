Return-Path: <linux-kernel+bounces-140816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF918A1915
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BEF283339
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153E87F46B;
	Thu, 11 Apr 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gVIJf2HG"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85917A15D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849599; cv=none; b=pC47i39DU4OtOzeeO+j68D8UHiRK+4qiU0zv5xU4I6GC/Eyk4N4AJtOIMkKwL0rTVjtoirXhPvtE3ExVmupHAtpjEdwP62rtJf+4LxEJaD5vaL5kjlwQC0cXEygVibt4K5v1fWbHBu3XL6gExcVJl1ovwVtTp0G795Uu4IMfjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849599; c=relaxed/simple;
	bh=zAhR8pVOpb3GLx+NZ4rajBiZjWs2yPe7alnAfdmBlmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF0+cRTGllN+7E7WLpVhugRX7d0incf4Uc6md50P7qA/3LMgo84qyxpeXfhkfpMpqUizcRbK1CZsUmp0Jw2qsQg1HlCELLrYuH2HM1k0a785asZz4jDSLLTMJvKGMuslhFLAryOIQk64ETVG48+FOY1E/GViPlqHLIWqFDPd7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gVIJf2HG; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9726539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849597; x=1713454397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTyRdE9qtn5zwHXPNZ8vyCVIFL75oJVPeCU0zp4i2dA=;
        b=gVIJf2HGQTFTf45hK7ASySovvlku7pKqWzmg6pD53MintXfUJ6IrpiRajjyO7F2SfG
         eK/U074fCIOU8CGPfB6AoZEKaX+N0yaPMZ3xvg60wFLVwTb/BmDFq/dXnCoXHJ3yy6K2
         KTcXcpqHxRz6KE5Yb2v5le1Qi26NALBSGpcMNwmINEcXb3Ggdc9sUDR2t8OYQm4DdPTR
         7AjyytQK1TB2ZRZn9bEAH9WQz0aH8AS8N5LLGWC6RNuGOR6drUur1W3wj+Ex+CqVg1qt
         rFpI+WCggmst/q4XqpgiUctzNvX9rC0FKq2ZUFZvqx/14twEDWFqnpDbfwCi9M/JImLw
         dSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849597; x=1713454397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTyRdE9qtn5zwHXPNZ8vyCVIFL75oJVPeCU0zp4i2dA=;
        b=uIgOn8x+ECwMrSOne/yrXD1NOCorqiabTv9PR02JAKwno5CSgtdYIFgZUOssmm0SJW
         7IO06Agq9S7RbcLi+MetCHjWpkVi3e59ygkTFWGSGG7lQpyW0sfD6S1VWBPiFVTlM1nV
         agHnNWdk/sF/hILcK15jXZQpzszqqYKG/EIQlioMnRR3vGNEL3fF9wi32Nmb9I3zETjU
         6ydJxGVMGNohlTbk7OGSJ6Jyjhr+2NPyy7lQkViQ+CdlVRCCFWb/LPQl7S2qcgWybu89
         30bUij98Pxa1K5NugbGIRw2M9cu1l6NIkJkXKpRLrdggpv0eWfZ0f8oMbC9MX6lSdzMb
         1Fmw==
X-Gm-Message-State: AOJu0YysyN56xBHfNi1Qg1p9MjLT8wca9iNMxSlTm4z38njp+y0JErFt
	Cg+iclAlt1oZcItTPcHNFfDGjC/OhYmnnUfZgjqR/WAg+d8WwWMXPW4NEnUTLK8LuD801/4Xok7
	h
X-Google-Smtp-Source: AGHT+IFmWjqL99gXC3ZOv60whwLekoiAKXWhZwEZ3Pqd3/6fg7PeixKGAKrlHc3OvBlA3WDce+fVDA==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr34298iob.2.1712849596776;
        Thu, 11 Apr 2024 08:33:16 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 056/437] net: rfkill: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:16 -0600
Message-ID: <20240411153126.16201-57-axboe@kernel.dk>
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
 net/rfkill/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index c3feb4f49d09..36271888c130 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1226,10 +1226,10 @@ static __poll_t rfkill_fop_poll(struct file *file, poll_table *wait)
 	return res;
 }
 
-static ssize_t rfkill_fop_read(struct file *file, char __user *buf,
-			       size_t count, loff_t *pos)
+static ssize_t rfkill_fop_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rfkill_data *data = file->private_data;
+	struct rfkill_data *data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct rfkill_int_event *ev;
 	unsigned long sz;
 	int ret;
@@ -1237,7 +1237,7 @@ static ssize_t rfkill_fop_read(struct file *file, char __user *buf,
 	mutex_lock(&data->mtx);
 
 	while (list_empty(&data->events)) {
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto out;
 		}
@@ -1259,7 +1259,7 @@ static ssize_t rfkill_fop_read(struct file *file, char __user *buf,
 	sz = min_t(unsigned long, sizeof(ev->ev), count);
 	sz = min_t(unsigned long, sz, data->max_size);
 	ret = sz;
-	if (copy_to_user(buf, &ev->ev, sz))
+	if (!copy_to_iter_full(&ev->ev, sz, to))
 		ret = -EFAULT;
 
 	list_del(&ev->list);
@@ -1269,10 +1269,10 @@ static ssize_t rfkill_fop_read(struct file *file, char __user *buf,
 	return ret;
 }
 
-static ssize_t rfkill_fop_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *pos)
+static ssize_t rfkill_fop_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct rfkill_data *data = file->private_data;
+	struct rfkill_data *data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct rfkill *rfkill;
 	struct rfkill_event_ext ev;
 	int ret;
@@ -1288,7 +1288,7 @@ static ssize_t rfkill_fop_write(struct file *file, const char __user *buf,
 	 */
 	count = min(count, sizeof(ev));
 	count = min_t(size_t, count, data->max_size);
-	if (copy_from_user(&ev, buf, count))
+	if (!copy_from_iter_full(&ev, count, from))
 		return -EFAULT;
 
 	if (ev.type >= NUM_RFKILL_TYPES)
@@ -1392,8 +1392,8 @@ static long rfkill_fop_ioctl(struct file *file, unsigned int cmd,
 static const struct file_operations rfkill_fops = {
 	.owner		= THIS_MODULE,
 	.open		= rfkill_fop_open,
-	.read		= rfkill_fop_read,
-	.write		= rfkill_fop_write,
+	.read_iter	= rfkill_fop_read,
+	.write_iter	= rfkill_fop_write,
 	.poll		= rfkill_fop_poll,
 	.release	= rfkill_fop_release,
 	.unlocked_ioctl	= rfkill_fop_ioctl,
-- 
2.43.0


