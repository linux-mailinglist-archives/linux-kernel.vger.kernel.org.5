Return-Path: <linux-kernel+bounces-141199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626838A1AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929CE1C22194
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6116C1FE071;
	Thu, 11 Apr 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KmB0IYW4"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D891FD5D0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850197; cv=none; b=RHd5kKv26RO5SynAnapddbQwGtd2W9JB++Lsy2yX5xn7x6pBNeC5VIDoQ1Gef8oGxKtuZpEOueSTeKlPp+kMJjXAdFuK8oazKLxi9wBSX08JY+gHZjeoga2PKhobvIrThvcNtzcNyw6eqJ7gOVB3hnuWYWs9WP6O/CA17ASd/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850197; c=relaxed/simple;
	bh=Phd2Hxdlp1RIcZGVooWufe0DG1joD78U/Ivu9KJOrSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5RpSvcXJ9VEd7vTR183Wi+/hyBbFy7wu22EQrZ/6iqNG4ac6p8enUR8flGraPqj0wEzKDR+EpKApQOjUMembavWZXuErBAXDFYgzFefmkGoQ8LGf8HOm72vbZ+/HE2ZdAwNmi6GQb2G3La5UokKS/r0URfqQ+LM0VJc0mqPs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KmB0IYW4; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170662239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850195; x=1713454995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdrLRF7qah3kBrQNcINDfDbpBp50A8eMde+QLgtlIh0=;
        b=KmB0IYW4O4e58dxIRBFfnmx26EVnOZj8eq4V1EeqY8+uQCJJSTfBG0KsKSCo0P7iaT
         Ke+FkeG/7nvkHLZv0BAZ1cfvMAJwJ1pa1Pcp/hPQtIvaECbz5uMWfimWuR6sZ6I6ok9f
         bsV/SUSKBDcB1o+V1SlzhH6HdX9/eSeYrE2BI/cGGBB5M/uSsWqMAK7qSAElaR8vo/b4
         6HY0fWZQcT7lhluD+BXEJXXcbWc4HcCjR/3k47S13yT/YIp76bb58pq58TXP0m1tqYJn
         zJ7EQRmAjuCJehFWdGPMs/SUgvfpHxQZD9T+cU/QTdKwu2ZoBSxjRVW+z0kMLq0M3z8J
         xbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850195; x=1713454995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdrLRF7qah3kBrQNcINDfDbpBp50A8eMde+QLgtlIh0=;
        b=vDrTL1xgVQXNPdm4IF7wHVvv1L1VjXPv9tIb7VF1Zl6LRGBTWFLFaacqZdp2yBtWFT
         0T5nYIxSHpSJ6zV700MOkwKPxHVgjMAHJHl0MdZcZBEUTMP1nUbHc/Euu9ZDj66zw4xA
         ats9IY5HiIXawHswbX3VcvdRE/pQDGSvPu54VLktxzxY1uTRLlaeIApI8BBFir+48+tW
         Hn0qcVR84FRoFFOQg23xx+Yood1MRm6sglrkjGMKeyLIWY7gCyP6LcFizhiw8blBF5Vy
         WmxTWkRrsjOwY2OD56H6I+aYfZEaEdR+cy6r4XnvDQUd/8X3UMXtWfAnusMdjOwj4qA+
         p8Sw==
X-Gm-Message-State: AOJu0YzOWZYMbZhWcgk0oeEXSq6fXi/yRR4MjgiNcRAaOpvcADPzkRfi
	5gYQtImPY1bcAEQtk/N/1YJtxITU+YMpm0vyCHH4np1kk0JBB72bkGEzRqkGIwEWCOYMmqWpi9h
	z
X-Google-Smtp-Source: AGHT+IE/iKXnDTRwSmXXe4ceUXecG00+7PGdZtdQ2G6r4eDUzPKQ2OwbGTg6eY48Balru3MFrWqSHA==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr35306ioc.1.1712850195301;
        Thu, 11 Apr 2024 08:43:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 415/437] media/common: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:15 -0600
Message-ID: <20240411153126.16201-416-axboe@kernel.dk>
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
 drivers/media/common/siano/smsdvb-debugfs.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/media/common/siano/smsdvb-debugfs.c b/drivers/media/common/siano/smsdvb-debugfs.c
index 73990e469df9..e81b17b599ec 100644
--- a/drivers/media/common/siano/smsdvb-debugfs.c
+++ b/drivers/media/common/siano/smsdvb-debugfs.c
@@ -280,15 +280,14 @@ static __poll_t smsdvb_stats_poll(struct file *file, poll_table *wait)
 	return rc > 0 ? EPOLLIN | EPOLLRDNORM : 0;
 }
 
-static ssize_t smsdvb_stats_read(struct file *file, char __user *user_buf,
-				      size_t nbytes, loff_t *ppos)
+static ssize_t smsdvb_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int rc = 0, len;
-	struct smsdvb_debugfs *debug_data = file->private_data;
+	struct smsdvb_debugfs *debug_data = iocb->ki_filp->private_data;
 
 	kref_get(&debug_data->refcount);
 
-	if (file->f_flags & O_NONBLOCK) {
+	if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 		rc = smsdvb_stats_wait_read(debug_data);
 		if (!rc) {
 			rc = -EWOULDBLOCK;
@@ -306,14 +305,14 @@ static ssize_t smsdvb_stats_read(struct file *file, char __user *user_buf,
 		goto ret;
 	}
 
-	len = debug_data->stats_count - *ppos;
+	len = debug_data->stats_count - iocb->ki_pos;
 	if (len >= 0)
-		rc = simple_read_from_buffer(user_buf, nbytes, ppos,
-					     debug_data->stats_data, len);
+		rc = simple_copy_to_iter(debug_data->stats_data, &iocb->ki_pos,
+					 len, to);
 	else
 		rc = 0;
 
-	if (*ppos >= debug_data->stats_count) {
+	if (iocb->ki_pos >= debug_data->stats_count) {
 		spin_lock(&debug_data->lock);
 		debug_data->stats_was_read = true;
 		spin_unlock(&debug_data->lock);
@@ -341,7 +340,7 @@ static int smsdvb_stats_release(struct inode *inode, struct file *file)
 static const struct file_operations debugfs_stats_ops = {
 	.open = smsdvb_stats_open,
 	.poll = smsdvb_stats_poll,
-	.read = smsdvb_stats_read,
+	.read_iter = smsdvb_stats_read,
 	.release = smsdvb_stats_release,
 	.llseek = generic_file_llseek,
 };
-- 
2.43.0


