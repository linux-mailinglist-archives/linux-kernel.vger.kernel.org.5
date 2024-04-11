Return-Path: <linux-kernel+bounces-140927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497738A19A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A8C287BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41431A38FE;
	Thu, 11 Apr 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ieseGsgG"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09D1A38DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849772; cv=none; b=sse7f+GgwuWz6DsasZ+/OVEVpCa70zxHRtmiqMS06aWPUaD4cEUUGQfmD3XwpjCAzJESYnnZyXlz5+KgrTu0Edv5jHfrtKiwlR6ijwxtYrlTBqnRhNN0l2fG4GStGID9QF0lpTD9yRZ0uq+aSXKnZY0Wr/Xa3ZjzxTb0KRjk2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849772; c=relaxed/simple;
	bh=twycO02VICSyua+S42Z41bDXI3vMA3cbCRt8cdsenRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyX/+MiwsaeO918eIMe+7Ak8rOLkxWRfqCN3LFvKVYjt8XpgsIoxJEMa/K4qEBgB1uImoQnMFPaE6IXcnY3u//UDyG4wqG5DjFvO7zQYc0O5mXWdsEkUU1nxJJCTCQLQKzIBmCo3Ci4uD+S0T9MsYeEQ1RMt8poFa2nugHOzlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ieseGsgG; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9790139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849770; x=1713454570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwO8HCq/CBDdgPKYG66qd5vuQddMB2sooLT/MNROoRw=;
        b=ieseGsgGED3NgObmRtE/E6jYzbL3W+9rjnxzGf2un92vfB05H+IQOIXOrhxVV/oFKu
         BtOTvccou93/ck5idl75nZp/AKR/jhBIjkAFwHfN48fOubqmEXCRt5LIy14GThJuirGR
         d2uMyUs6amaHsdYgRS5wqc92swIOw5qlmFo/jXqnt2q/O/lfGFqi71U7bXPp3XmOvgEr
         ugcncsblOKtvR2K2zVaYEUcSSUluY08sYU2rAuKT0uTYEQaN6ClH1gRQHi2NRXE6JYTr
         LPbgsDC/Dq5+4OugHfztS5RsN8S6iHtQUEzlPFDFO61b/L2RMBARoZSCn11pFyHg8q23
         gFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849770; x=1713454570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwO8HCq/CBDdgPKYG66qd5vuQddMB2sooLT/MNROoRw=;
        b=bq0oEs9FGuQbRJWteVh28BN99Yb0Y+t+QYmNPkrvtIEKjcsZSfduKlNNhr/MegTdga
         jyvpu6LI/u2Z9RWTFKbOO8qrfY08pvf/Ru13xu8rglyJfKullgb1deLgJ6PL2YDKFwVo
         XpL2jfI3cCbC2FWSfufNtLXF053St8kpjGHHnS7ghqcqbWb6BwoNURvu/5DEKFZbIdLR
         +7GFXvSwwtOw0Zy4kRnopsdKbF9/fl+AmytUYqZ/dXdy5/km7HHUfYOBdTgzx39V4Ln4
         /b42JS+nfnfwxPseSKZ6JS14HTn5BPoXA/+C1dWVMgXCin6sK6h5dS/08+PNcErKsI2C
         us7Q==
X-Gm-Message-State: AOJu0YxihbZszep8vNO30/Q6HVLwbjYHHJJMDNXUVbPW7OKIh7G3T6sb
	cb1aB6dKGqWxT1AGV88F1wM1wIwdNDi8HAmx7H1UYCyoZUkAZSBlRxaPRq/xk9tLTfusSGYf1zi
	N
X-Google-Smtp-Source: AGHT+IG+yk7P37bWFCH0e2jBRcVfijTNwizP8k7zlcG4RLnwTpYaIXYr+gpb1BvWAaDHyf68EAlEOw==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr217049iof.0.1712849769874;
        Thu, 11 Apr 2024 08:36:09 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 159/437] usb: dwc2: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:59 -0600
Message-ID: <20240411153126.16201-160-axboe@kernel.dk>
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
 drivers/usb/dwc2/debugfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc2/debugfs.c b/drivers/usb/dwc2/debugfs.c
index 1d72ece9cfe4..b106744e13b5 100644
--- a/drivers/usb/dwc2/debugfs.c
+++ b/drivers/usb/dwc2/debugfs.c
@@ -24,16 +24,16 @@
  * @count: The ubuf size.
  * @ppos: Unused parameter.
  */
-static ssize_t testmode_write(struct file *file, const char __user *ubuf, size_t
-		count, loff_t *ppos)
+static ssize_t testmode_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file		*s = file->private_data;
+	struct seq_file		*s = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(from);
 	struct dwc2_hsotg	*hsotg = s->private;
 	unsigned long		flags;
 	u32			testmode = 0;
 	char			buf[32];
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	if (!strncmp(buf, "test_j", 6))
@@ -108,8 +108,8 @@ static int testmode_open(struct inode *inode, struct file *file)
 static const struct file_operations testmode_fops = {
 	.owner		= THIS_MODULE,
 	.open		= testmode_open,
-	.write		= testmode_write,
-	.read		= seq_read,
+	.write_iter	= testmode_write,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


