Return-Path: <linux-kernel+bounces-141127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA21D8A1A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C87A1F21FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1484F8BB;
	Thu, 11 Apr 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="09GisqaT"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06831EA766
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850081; cv=none; b=AxLmizQwyoAaDF1/hFECwRp9SMr9AS0T+RD9eMd09VUiHbMil90bAXqsDGX2NZ2jJk69KpBLnAniNmQK9BPMZ0ejlF34UutSblu+E8p7l0cxDHcy5jRmEhm6AABoDnzbw7rQW51+tMMHbTl5ww3xvRsmBiHwxCtFhlsXtWLU/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850081; c=relaxed/simple;
	bh=BgZjQsQGTijQ+oISUnhnL7/zU5NbKY8xpCp3DvKPqPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiAJ4C26rUyxye+dlveW9DWRq2VaOiIwQeL2U17kgAYIzrOItXa2E/a183uHFsME/RZzyESskad7JIoFb73nu93uY3LlYYForR3zI4YZ+2wpJla239vwv8bHnVHWjQGNcG2qes9Jf+eOFtkZk0AeF1Cmc18dTrv6U3uGIs0B8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=09GisqaT; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58235739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850078; x=1713454878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7BcAfTHJYzKApAcG52Bw9lqr+jvQ0JQ0YgQDrbMYsI=;
        b=09GisqaTDrkdCvp8qVwfPlh06G5U9BVl9HMXXbgsDZPCXW5QMuLTuTwNiyhxlApIPH
         eEnm3huaueCoG+zPQa9izdHCw6JaLtnEIdFuj82trr1qaUnuwl47uXMxU6Nqy3QyaP1G
         uooOxEtUMKK/us2V0WP9TNjVd3Wgs45bMZ8sakNP93IdgFrMjV8lYcQIYNG0BC5OTErG
         qfbSvIfnAd1rp1RFQHs8fHHG+WV7/W3CbVCjgDbklfiz1UG5uljfFx15xigF9Aqu+trR
         xOL93wnJzBcWT8iIo37p0eN6Y4XaLIG/dFlInvueuHjv/E/C1pbXdV3GX1kVTiIjsmZv
         JenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850078; x=1713454878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7BcAfTHJYzKApAcG52Bw9lqr+jvQ0JQ0YgQDrbMYsI=;
        b=T/lC7aKVk+uMcxLTUaQq/OsDEYs6AMhp07RmZfZosKD8B0revAJvUCNQKxaeQGr5Ea
         Fe4DHn2jMlsgIIl7UueP2sBNO6vjzbCCQje5O/iYlZCtXQebuEqZwiOneHD3sVcBO/Cp
         bXEpJUJZTnCN1T5kIOUZCMobYb1VYjP+edELbmVIQi+spCEoz1SnrSvfRaz5PdnsLMUc
         PiOUB2tIZ6QRpbSb3h3FvipeY4HeHNjAgm+ELQ7lD0DJMzNe5/3KJr1orNjFs4QHrKnu
         PN+81Fh6CqlHLdUFqM8doHZIfqwhSsTRxAKyhV+ByvJafoZap8p4RLs6h8cq/fkIQOg9
         EWFQ==
X-Gm-Message-State: AOJu0YxI6LBpcvs3bQWdSGfexO5v6xKqgKGfj6+4t5eTMyz0kbA3upCy
	pcIr+3sY/gYCEjqU0ajrwwdyRmOVBtC8qG5X/Kfx77TGphs/OJduaae5JweMJn4QsH1Qc2VNVhO
	k
X-Google-Smtp-Source: AGHT+IFEkCMKLDghvelPXDbj9GsSJino+/gyhRPw6ovdrSkNbS785jVMSQ2vFR7/Jj7ndUwaA+fTnw==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr211904iog.0.1712850078456;
        Thu, 11 Apr 2024 08:41:18 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 348/437] s390: crypto: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:08 -0600
Message-ID: <20240411153126.16201-349-axboe@kernel.dk>
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
 drivers/s390/crypto/zcrypt_api.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index eba07f8ef308..bc2b385ea550 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -475,8 +475,7 @@ static void zcdn_destroy_all(void)
  *
  * This function is not supported beyond zcrypt 1.3.1.
  */
-static ssize_t zcrypt_read(struct file *filp, char __user *buf,
-			   size_t count, loff_t *f_pos)
+static ssize_t zcrypt_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return -EPERM;
 }
@@ -486,8 +485,7 @@ static ssize_t zcrypt_read(struct file *filp, char __user *buf,
  *
  * Write is not allowed
  */
-static ssize_t zcrypt_write(struct file *filp, const char __user *buf,
-			    size_t count, loff_t *f_pos)
+static ssize_t zcrypt_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return -EPERM;
 }
@@ -1905,8 +1903,8 @@ static long zcrypt_compat_ioctl(struct file *filp, unsigned int cmd,
  */
 static const struct file_operations zcrypt_fops = {
 	.owner		= THIS_MODULE,
-	.read		= zcrypt_read,
-	.write		= zcrypt_write,
+	.read_iter	= zcrypt_read,
+	.write_iter	= zcrypt_write,
 	.unlocked_ioctl	= zcrypt_unlocked_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= zcrypt_compat_ioctl,
-- 
2.43.0


