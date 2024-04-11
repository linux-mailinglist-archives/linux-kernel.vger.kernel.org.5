Return-Path: <linux-kernel+bounces-141160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6508A1AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA881C21023
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99AD1F2E09;
	Thu, 11 Apr 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sELHvVYi"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC741F2DE0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850138; cv=none; b=r3pU1uNqEK5gDplLnEO3/f5PJoCjq8lwOzuuDl8kuTJgfHNswpJgOWHAboghNILnwyW56BHYCjkLTShQtihyJCBZbtfoqlDODUlc/5ihVY6sUbIE7AroGvDEXLGjD4EISdpBEPLI3U/lIZAHaBbPRDj56fy4OMpdGrayiH4wuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850138; c=relaxed/simple;
	bh=SbAU/FwVbtOHDDcY5lL7CWcvQ3CkPESZCrnOaalHhak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ2dcEy9TlrW7JlhYUzcgHA7JzGAvW9AzlVTuh/rd10396jVHkLGk5f/2SsWRk/kurU7hUCPga/d/05NN8je6SP+fyb+Hdgad0lHc5oI8wPW4A9ZbWH645UVBTwQEx/oQAvcrW7cT9rzAKk1J10AirYLnyETnu5PQtJ/tSK2HoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sELHvVYi; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58256439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850136; x=1713454936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCxICJZlmBvpED/2sMV/O0eu+9mJQyptygEH/vLZNS8=;
        b=sELHvVYi64OjU/nNiNiwzvfOWY8fufsWzgTpi5K0xeMBPshspQqMlg90L99uYLdhgo
         9C2BhBOaP+TxeWPvInS/Ok+63UU8JUe/z8+Dxcfn0SKzbwenlWOsNSDiyDDHLzPa5ClH
         wQjBHMmSuDko018TPgyEUzsO3OqJ1tBZ70kMPwJGxH2ON991dwzKMB0buRSpsuaE230a
         sfi8CXLsoANzLXSTR8LmM8fZ0J8KguR5iBIW9q3VOFRljKHNjXdRJWAyqs29+XwCMU7i
         btSVdh2LH4To+55keKo16v7dYNuDbsYXf5gLE/3IgWnKv4x3XmOLNJL2uEOoHoDBojfv
         ZZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850136; x=1713454936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCxICJZlmBvpED/2sMV/O0eu+9mJQyptygEH/vLZNS8=;
        b=RwItd7LLSCkY2WPB71eWM4UO3oCIrYZUInODHHOh14c8gPKK+h73475TV7EhQU0tuv
         +p/iOlhkxRrg9HfVTA16T4fCFGX4EFDWsl7SF6ErqWYAlxLmS2IEJ6KMpeRKE+1Bnh3A
         iI2BlV9358E16kiABy0LSW/LTfF9G1Ho1dvUnZBZm0sXd+pfu9bY+KpUKsP+DlmZNS9Q
         qOdoyWM4aLLpu/2798c3JLPwPwgwgD6c5pmSFLODILsBPcK4cBRV1rr1PDrnoHMsW+2h
         KGvXb2ZPjcGhuSy0XAUEmYdY4COgGdmSSDjW5IfSndVqaJyPlgIovsYHMg9H8exA9BCV
         YTPQ==
X-Gm-Message-State: AOJu0YyMFh2/6FZuM/IAV9EF+AN8Nlu/tNgFOR+0J1MkbJE2nT9TKbQ4
	es2N38mgFkdTNuzRbultmQzx6MoF3YAd/hK2HSmg7uDzFTsFrUWEzdDdXhy0RkfMqscIr0D+tWi
	P
X-Google-Smtp-Source: AGHT+IG5VLDXR1UqBBBi/B+QI7Jj6SgvSLtOtaeaYAXyF2ao8+nobH4KuSYSJbmSRyKO1fwXk6YRPg==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr203728iov.2.1712850135768;
        Thu, 11 Apr 2024 08:42:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 378/437] iio: adis16400: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:38 -0600
Message-ID: <20240411153126.16201-379-axboe@kernel.dk>
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
 drivers/iio/imu/adis16400.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 3eda32e12a53..78182bc33bac 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -204,10 +204,10 @@ enum {
 
 #ifdef CONFIG_DEBUG_FS
 
-static ssize_t adis16400_show_serial_number(struct file *file,
-		char __user *userbuf, size_t count, loff_t *ppos)
+static ssize_t adis16400_show_serial_number(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct adis16400_state *st = file->private_data;
+	struct adis16400_state *st = iocb->ki_filp->private_data;
 	u16 lot1, lot2, serial_number;
 	char buf[16];
 	size_t len;
@@ -229,12 +229,12 @@ static ssize_t adis16400_show_serial_number(struct file *file,
 	len = snprintf(buf, sizeof(buf), "%.4x-%.4x-%.4x\n", lot1, lot2,
 			serial_number);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations adis16400_serial_number_fops = {
 	.open = simple_open,
-	.read = adis16400_show_serial_number,
+	.read_iter = adis16400_show_serial_number,
 	.llseek = default_llseek,
 	.owner = THIS_MODULE,
 };
-- 
2.43.0


