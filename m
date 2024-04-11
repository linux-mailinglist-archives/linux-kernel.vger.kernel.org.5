Return-Path: <linux-kernel+bounces-141162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FBA8A1AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9710F1C236BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951841F4644;
	Thu, 11 Apr 2024 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Xu+xAy7b"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA41F39F4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850142; cv=none; b=R0YNtWZmLEr+83VRAUmBIlVWe2KkNLHhf/JcjRRoIcJ4CavWvJXoZn9Dr5quRuq921h4u2hkSrkOVIvhZwlY3ScJirg/FZjTmkVjpFDhN/CCwUIdfifqdnLKHKq5gRcezcI/pLqtmT73hixQyNU61kviFiOIgaLzOcRQ+97sWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850142; c=relaxed/simple;
	bh=PufdMhA0v/c5yadV0ywGKInA5O7Icay3BUWBf9vkM4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9yE0kEPW9/w2R/WfazfL+5ahtUVfGUFYCgp/wBE24HZiueYhEsPePop6e1rjG95QBWI+7lQSUrqlmen4M2DT/RS0ejW9fT1PVKbgiHOU/dyG153wby5VYxeAhHUUc1nNyqvHsOGKkhlEDr9RJikeyzQlZ06kj0SihbWn6fTiFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Xu+xAy7b; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170646339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850139; x=1713454939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y+/EjmopQWRiX2vp/UgsPsoCUKkjRpEhi1WN9QSBwI=;
        b=Xu+xAy7bcWWQLbe5aQ0Ug3bBwA8ZHniwlNS6VE34xesV1qHt8Xl/jAQyrUXhzBHJsU
         N/Q3NPO4O+sMYX9huoedW7e9baGUSE+hLWz9/aeprlq5SzPJ0opsAcHGfi7ZmkQjhckE
         4c+t2WadX6HqbuvmNvV+6SOLIWbJtNw7j0WSc+eDuFlKs0NHWcAI6RlVkSSpue2Xzo5t
         6RDwLAgnmI5NuDP8ZQdYe2ZacQYBO+PpzmLjCRz6NQpmF5JuDmIDeEvCa8m4W+syiuT3
         DLZ6IIj5WHtI8AQNLgVdBENIH8sGgHikd9M0Xa0LEbtV5A/balQjz6Vvp2AyWkMB8OA1
         d9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850139; x=1713454939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y+/EjmopQWRiX2vp/UgsPsoCUKkjRpEhi1WN9QSBwI=;
        b=JhPT6YMtUJdsgyf7dW9WfpQfQX+ag5MCVioXNCxiwP3Vy+kp2+jcsqrJ5dv/dHUFcf
         Kgu59PjzhgFQjqIY5o+0YgMsyPRqCoVdQMRHgqpSaKutyqTvzRNw7niizsbSZJrNopLU
         Ls8I/JJeVKTRtHT0DoUpYNZKTsE66f61mQEEppEypslQS6aigVR27W5Uvm3u9mGoHBBx
         f51JGq7FmKhoKW8mlTlfxgRjSVN2jR1qKSaAyQJVHySeImuKmMYC6oVgQTShP9kTiHHh
         6/rUuuWa4uQvfxFEieui/QlpIKo815wqyRTFGDQb9ejFE+aNGmcgQ2vOLBUayqlEvE6l
         P0Dw==
X-Gm-Message-State: AOJu0YxcIFJpXpt/57tUfP7pvPIpzC7NVxgyZTMcWKytaIgBspY2A5xQ
	IvfD6zq03qBvr4OHM7JyhcWoFcWgjVaYJ6bs/W8LiZwKps7/mF/EWKfI3aghw3FDn26odPjNeI1
	D
X-Google-Smtp-Source: AGHT+IHHlG/ZIop658cPJj++SLhCzguoTo5TOF5edsCc4qffVoDNnH+31CWOP31vCQT11E9H97MTyQ==
X-Received: by 2002:a92:2912:0:b0:36a:f9aa:5757 with SMTP id l18-20020a922912000000b0036af9aa5757mr3599016ilg.2.1712850139449;
        Thu, 11 Apr 2024 08:42:19 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 380/437] iio: adis16480: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:40 -0600
Message-ID: <20240411153126.16201-381-axboe@kernel.dk>
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
 drivers/iio/imu/adis16480.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index b40a55bba30c..2664a187872f 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -188,10 +188,10 @@ MODULE_PARM_DESC(low_rate_allow,
 
 #ifdef CONFIG_DEBUG_FS
 
-static ssize_t adis16480_show_firmware_revision(struct file *file,
-		char __user *userbuf, size_t count, loff_t *ppos)
+static ssize_t adis16480_show_firmware_revision(struct kiocb *iocb,
+						struct iov_iter *to)
 {
-	struct adis16480 *adis16480 = file->private_data;
+	struct adis16480 *adis16480 = iocb->ki_filp->private_data;
 	char buf[7];
 	size_t len;
 	u16 rev;
@@ -203,20 +203,20 @@ static ssize_t adis16480_show_firmware_revision(struct file *file,
 
 	len = scnprintf(buf, sizeof(buf), "%x.%x\n", rev >> 8, rev & 0xff);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations adis16480_firmware_revision_fops = {
 	.open = simple_open,
-	.read = adis16480_show_firmware_revision,
+	.read_iter = adis16480_show_firmware_revision,
 	.llseek = default_llseek,
 	.owner = THIS_MODULE,
 };
 
-static ssize_t adis16480_show_firmware_date(struct file *file,
-		char __user *userbuf, size_t count, loff_t *ppos)
+static ssize_t adis16480_show_firmware_date(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct adis16480 *adis16480 = file->private_data;
+	struct adis16480 *adis16480 = iocb->ki_filp->private_data;
 	u16 md, year;
 	char buf[12];
 	size_t len;
@@ -233,12 +233,12 @@ static ssize_t adis16480_show_firmware_date(struct file *file,
 	len = snprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n",
 			md >> 8, md & 0xff, year);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations adis16480_firmware_date_fops = {
 	.open = simple_open,
-	.read = adis16480_show_firmware_date,
+	.read_iter = adis16480_show_firmware_date,
 	.llseek = default_llseek,
 	.owner = THIS_MODULE,
 };
-- 
2.43.0


