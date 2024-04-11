Return-Path: <linux-kernel+bounces-141132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5478A1A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF531C2360B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D3E1EBAA4;
	Thu, 11 Apr 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h5tvH4wC"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3E1EBA90
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850089; cv=none; b=lr4tUTbGBJwQ0evoP9TYjoBinsiig23ZqAuJU9XlP8hoT7V2S9kuTLbyreVQlDLABHc8lwSegzvGE18qMg0Ce5h2aeG0Nlp7+zQW4Z4iCc0u/SwC64n6ox17ZuvxgsM20u4NqhUbBC7/LvzI9wOzlP/RuyPd4DNp2fSpmVvSnUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850089; c=relaxed/simple;
	bh=YVKLd2CSJYUG91vN9zuh7P0ySoI747xJBbFJ5aVmvbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hY+LZsG4Qdb2rTK+RW8mr7dQN8f0/L8Ou3/lhtzDYw+6hB2doQY2oBjGZPmY0JmjjwNMqCFxqQXUNnO3hzM5CUdLfjZmAhE+OoLeIBlwC8kRl3lSK2Wjfq8BFY8noGJvDzbpsLpEDcLEYW3rJkx8+LoOoYTdkgsdxLM5qOstjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h5tvH4wC; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9075939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850087; x=1713454887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PQw3BxBhLy6E/TQJA9sZtmXmf+ppOrNefTSoVA4nOI=;
        b=h5tvH4wCnRanXNNmzmhx+z2NFohB+4dR00zUyE+XeMve8sIryMCO1q5E+Z5VLT+CfJ
         k0vCZWCrSAj0mJsfAiM292UWnQoUZQXgtNCJdbBqnRGAY66K8U360JU70/00AiBJEDrj
         fpO7ZpNCKEv+YzXlODY7wtJ8NHVrtK2V4CRkGLB2sT/xuNwaQXliHz1XeWN2fNPhtUhV
         UmOdaInyL3OQ8w/pga6Ph3B9HLQI7wyltXjC5fiO/fbDiK20cLp1OyFgbL26jbwgbOgM
         VBvoeD1XsgaKrp/dTssmlkDbjBLMN5gLVxW1vnEBIXDVE6nxnSqcZ1PQd5tQ22Z+6QY8
         hhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850087; x=1713454887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PQw3BxBhLy6E/TQJA9sZtmXmf+ppOrNefTSoVA4nOI=;
        b=xK2hbeMJUIEB659YcL0pr7YRJkBj9wPzMAV8QZkTtT7pdwXb7/LkHStMU2FUNEUK7w
         sYrBeJTwdfrqJ9SCOlK/p+880Ce9R1xMD6SXaoTkqIpcf9MENUWg09jceAdz7DWRv+WG
         jzlVaTv9eN9ag1t4TNOJDR4SOqoQSKzed2IgtWgg06JAIZjqFOXpsPIBzWLaZoRuU4OP
         bNxEwi03yoGyyLq28HLNF1a3gmznI+pAU/bvU+5pO+BK5H4nKbZNPES76sZGxYo/2QUJ
         +T17Y1F0YO6mmZWI9FAJBDSKhqp9lNaijKMo2Nw+QnRk9uX+JVsYxsT0wqQE+0aT/Q8A
         3AkQ==
X-Gm-Message-State: AOJu0Yy/bmPX1h7/c0AzLRx5V1BGsYP/DNcZHmZjnx9vuC55Zt5PndHW
	F7Qh4l+PpJ/daKAWiaAuD0CodadMLQNmlq8Oh9G2t/gRyBtLgyoXBylOa8WIyEOD0z/NnZJtphc
	3
X-Google-Smtp-Source: AGHT+IEiu4W4t70Oi2eSoum4dMPVvtr1ey08bB/fKO5JxJHLLx25iBx6Bw9BKTK7fARIwuEWmxu5Jw==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr194659ioj.2.1712850086003;
        Thu, 11 Apr 2024 08:41:26 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 352/437] s390: vmlogrdr: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:12 -0600
Message-ID: <20240411153126.16201-353-axboe@kernel.dk>
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
 drivers/s390/char/vmlogrdr.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index d7e408c8d0b8..52595690e43c 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -88,14 +88,13 @@ struct vmlogrdr_priv_t {
  */
 static int vmlogrdr_open(struct inode *, struct file *);
 static int vmlogrdr_release(struct inode *, struct file *);
-static ssize_t vmlogrdr_read (struct file *filp, char __user *data,
-			      size_t count, loff_t * ppos);
+static ssize_t vmlogrdr_read(struct kiocb *iocb, struct iov_iter *to);
 
 static const struct file_operations vmlogrdr_fops = {
 	.owner   = THIS_MODULE,
 	.open    = vmlogrdr_open,
 	.release = vmlogrdr_release,
-	.read    = vmlogrdr_read,
+	.read_iter = vmlogrdr_read,
 	.llseek  = no_llseek,
 };
 
@@ -473,11 +472,11 @@ static int vmlogrdr_receive_data(struct vmlogrdr_priv_t *priv)
 }
 
 
-static ssize_t vmlogrdr_read(struct file *filp, char __user *data,
-			     size_t count, loff_t * ppos)
+static ssize_t vmlogrdr_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	int rc;
-	struct vmlogrdr_priv_t * priv = filp->private_data;
+	struct vmlogrdr_priv_t * priv = iocb->ki_filp->private_data;
 
 	while (priv->buffer_free) {
 		rc = vmlogrdr_receive_data(priv);
@@ -492,10 +491,10 @@ static ssize_t vmlogrdr_read(struct file *filp, char __user *data,
 	if (count > priv->remaining)
 		count = priv->remaining;
 
-	if (copy_to_user(data, priv->current_position, count))
+	if (!copy_to_iter_full(priv->current_position, count, to))
 		return -EFAULT;
 
-	*ppos += count;
+	iocb->ki_pos += count;
 	priv->current_position += count;
 	priv->remaining -= count;
 
-- 
2.43.0


