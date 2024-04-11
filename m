Return-Path: <linux-kernel+bounces-141161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE30C8A1AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9469B1F21BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A51F39E8;
	Thu, 11 Apr 2024 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wQ3sLEZY"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B01F2E0B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850140; cv=none; b=eehAMxBf9TP4jjDsHCMWeFF9ErH1gVrFr7/nD4qxmR7O4tQ0zhYQvlfpM4GbVS7iTBKpeTVcgq9lLBWPY3wAnKfaHD7x8gstzT/CMj0CiOIKfCNY6xT+KgKecielbjE08Ww1WbWIdcAM7PiQdoNPueLqe7qZ/xRuNLHGdjrg/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850140; c=relaxed/simple;
	bh=VAZcZZkqXcPqNUdJnrc1dlWwxxtcIQqMO3emXrr71EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acS60gANPn3gNcmEwuLe4bsQfrnueAK8myvt5nTpY9lPCS4LXyMZZ5SdBK9k5D0ZY7R3lMnB0grKXztgpMJwRpi0y2V2O2k6LB4nUJsmjqlFPFd3vzByFSQC6f9m4BcU/yQ9zlmNOfyqLqk7g66OCOtqASc6ItD1HteakYb93uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wQ3sLEZY; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58258339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850138; x=1713454938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyIc0suwaFMIabZjrKP7+0E0ode+kl0xVnkWWjt4uyc=;
        b=wQ3sLEZYnURsRgKzhLSfND/qlKYA1C6OKS3fDp8f1n+hNOP4Fd8ZmNmyAqAMngSZlt
         j1waNSO8FuO5n7rfaInAw7LLMulX/BJBWQYPNa1htejQ1KoNdWqvr6nmTobGL7X3q6vk
         eOFolyS6skztyeCZqSq7EkGewg62lrY+HAlv3n74LdqkGa8aCwHEhRDUI+MjN9gCjGe9
         DoTdhxXklgGZFPNWOEismGTApBcrqw3mXXyBFsK7bwqpFEYu7Q+jyYu3alT/hsw11bfV
         e8lFQVoXwrlNbvU7x9l+vtXLNbExhnc+ru4JwJCvdizob0DfXEIsaETyKy0JuZtT/oJN
         XkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850138; x=1713454938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyIc0suwaFMIabZjrKP7+0E0ode+kl0xVnkWWjt4uyc=;
        b=EbzAoaO+6K03PnfTxnf3aQxC1UEWlqEaD0UXhgFmZ+f5CI3WBkACAhhDCbR0pJMv7f
         eT+18TugEJ0BD/M1J7m/foyUi0g7JUHxDOTYECyAgR391Se/EYCntA1v4Xirv3hW8NuH
         vPVv71qsWzRc4jhN02bpClnHrNEHCTFfsi1/8Ur20fI47mkxhzCb7+v1RHYlM6ZQ8Bm4
         kTK9ge1157KUluuT+2/KsIFKIBmk/AgHmYCsyo4AvY5/JgtcICVs3TFB8B8ljTKuqKLg
         oAZ+yxtgD6ppWE38OYLw4rIROnOLXtdCF8cPhV8kAubMA3u8CfCJzfeZHOPB+5OQ5b4C
         AtuQ==
X-Gm-Message-State: AOJu0YynUwYo0ZI05Q5msp5rA3d54WZa6Ui2fAHHKHvUaThWM3uWNKf0
	fBY29TdJgoFoV11slxvxU70KcLrlrpIiljKqDL48eQo61aQ0GiNpgDrU7shKHmgXAvNoMziX2tw
	3
X-Google-Smtp-Source: AGHT+IFe8TUS+zD1mhhbXbRnwz3uhtMtSpFvvT7d/8+OmsHy9Xq9e4fYGHW0a8pdK0g1HJBzoX1uzA==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr203816iov.2.1712850137837;
        Thu, 11 Apr 2024 08:42:17 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 379/437] iio: adis16475: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:39 -0600
Message-ID: <20240411153126.16201-380-axboe@kernel.dk>
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
 drivers/iio/imu/adis16475.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 01f55cc902fa..6772ca783e9d 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -142,11 +142,10 @@ MODULE_PARM_DESC(low_rate_allow,
 		 "Allow IMU rates below the minimum advisable when external clk is used in SCALED mode (default: N)");
 
 #ifdef CONFIG_DEBUG_FS
-static ssize_t adis16475_show_firmware_revision(struct file *file,
-						char __user *userbuf,
-						size_t count, loff_t *ppos)
+static ssize_t adis16475_show_firmware_revision(struct kiocb *iocb,
+						struct iov_iter *to)
 {
-	struct adis16475 *st = file->private_data;
+	struct adis16475 *st = iocb->ki_filp->private_data;
 	char buf[7];
 	size_t len;
 	u16 rev;
@@ -158,21 +157,20 @@ static ssize_t adis16475_show_firmware_revision(struct file *file,
 
 	len = scnprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev & 0xff);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations adis16475_firmware_revision_fops = {
 	.open = simple_open,
-	.read = adis16475_show_firmware_revision,
+	.read_iter = adis16475_show_firmware_revision,
 	.llseek = default_llseek,
 	.owner = THIS_MODULE,
 };
 
-static ssize_t adis16475_show_firmware_date(struct file *file,
-					    char __user *userbuf,
-					    size_t count, loff_t *ppos)
+static ssize_t adis16475_show_firmware_date(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct adis16475 *st = file->private_data;
+	struct adis16475 *st = iocb->ki_filp->private_data;
 	u16 md, year;
 	char buf[12];
 	size_t len;
@@ -189,12 +187,12 @@ static ssize_t adis16475_show_firmware_date(struct file *file,
 	len = snprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n", md >> 8, md & 0xff,
 		       year);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations adis16475_firmware_date_fops = {
 	.open = simple_open,
-	.read = adis16475_show_firmware_date,
+	.read_iter = adis16475_show_firmware_date,
 	.llseek = default_llseek,
 	.owner = THIS_MODULE,
 };
-- 
2.43.0


