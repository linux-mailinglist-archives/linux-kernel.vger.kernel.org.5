Return-Path: <linux-kernel+bounces-132569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B976C8996BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EBE288BED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1112FF9A;
	Fri,  5 Apr 2024 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6c2ioHm"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BD12EBE3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302813; cv=none; b=CYIG8p8m514WsUBVo8LFuKDmijcfm2Gs7zHp27TTRfIacMOzOok+zUqtS1KhphoOyLvXg35/ZLVCw3c/Ho5cAK8ftcPNV4RzycGWpZGA32cC29Lob9UdvIxinHeGBsgswsdELe8+jGLsB54qRK5uQUYROVhNvUkye71QNX4HV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302813; c=relaxed/simple;
	bh=g/WMOp/DBXdvY4p/J51T2DdQvuOBI7ftgCcNNdq/ZQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsCR1cv8FMaSBOPAE60K7aeKR9YRnJrD5mezh0V4uHwqdbGDlYk+zOLvEqJAz830FrxicZr6wtHqQh/zwqe+JzdjnFe9nm3hEPpCgCWqBsozMCNQgYo4qJcmL7pFeb+W7pKjH9HNgfWnjSGMosm3z7/r45jPhgmjZUuml349JE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6c2ioHm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343cd12630aso837628f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712302809; x=1712907609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwPl8LYnfW65bMF9In5HJ2vXzRSbzAQqtlyK3TQNiLw=;
        b=O6c2ioHmM6UHqD82oZb7itLZ1/dZkbupucM00HrIGRsXmE97pu3ymcvi/gRqRQuYzD
         SBTsTPCpFmujAL2z4wU6E7EmJJZ0sohJV40Qon8VXZTe20lnIzxX2fBb7q494edRtWcP
         Hup7x7eVQhlRgBKHkVWRYiNW00SHcHhTX40sLWwVkE9BVPtgibwfk0l2wfv3SL+fFeDF
         nCL4pa39IwXqHkr+uIwBJxBe0EFbDq3bY5HM5PHAMo8paZNwqS6g2OKtlvN+BpgMuLaC
         J0VDUn8XcDgnLSERHOHYalLs8bsc4nJNtTRXmb/i/mzz4a814bIxCvRcuZq+xEADvtMe
         v6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712302809; x=1712907609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwPl8LYnfW65bMF9In5HJ2vXzRSbzAQqtlyK3TQNiLw=;
        b=t3mKUzu4EsxiZ0W9snJ+83A/wAyE0PaKQO1U4kkXLXBfN2djcFoLjhhKMS12BYaszW
         RLqIxq++d9zBCoPSzhyY2tkb2T0JXwDFN26l6d49FN2IYFdFwEYRlEEyLgr+qxX+ikhr
         PZrdo4o7RNfopg6cVZvoNGewzUlaHinbUAhMakITJttRJL3AHsiJJaB2IKxbb2kpcrW/
         5eAF/zJ32lQxrivZvJ14A+EvjLXl+LVpILlh3z0Wd1DHwrAyc7LrWnR3nlJcogGH0YdX
         neHB6pGW6CevyqJxhvJomlucOGGcUmllROLI4HBCxGzCUnWF0bMMjFSBqHTZWWNe7CL0
         Tv1A==
X-Forwarded-Encrypted: i=1; AJvYcCXYbehpqBAzTC2Z3r9I8mvSyQ5KR5i2Oo06BKBHNYZ957rYC6zKIBXkDDEYpvv2GZCII1XZJU6Vsqw9uiBEFUXY5hJYbS9+dpoZUBEm
X-Gm-Message-State: AOJu0Yxt7tqLfIOfPgAA7NWvxJpbP6n13w65zsaNIOgwNQG93OAA0VR6
	pBvaeMPJ6KSCs6tASo2+Kwkqkf4Tq427lhdHKn9uB0iC21L8W4Ao
X-Google-Smtp-Source: AGHT+IE0sMMNCxSYmp0x3kPCLZg78NOnz9SZri+Mr58KiTRI2D6/xbzd9ED7iUBVyJbGpQkDY/NsWQ==
X-Received: by 2002:adf:f345:0:b0:343:75eb:bb79 with SMTP id e5-20020adff345000000b0034375ebbb79mr490731wrp.49.1712302809544;
        Fri, 05 Apr 2024 00:40:09 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b003434f526cb5sm1311643wrm.95.2024.04.05.00.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:40:08 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] staging: pi433: Rename struct pi433_device buffer field to tx_buffer.
Date: Fri,  5 Apr 2024 10:39:54 +0300
Message-Id: <20240405074000.3481217-2-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405074000.3481217-1-ikobh7@gmail.com>
References: <20240405074000.3481217-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver holds buffers in different structs, as does the HW.
Using explicit names for buffers increases readability.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 8c513ac62156..13b464ab7db8 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -90,7 +90,7 @@ struct pi433_device {
 	struct task_struct	*tx_task_struct;
 	wait_queue_head_t	tx_wait_queue;
 	u8			free_in_fifo;
-	char			buffer[MAX_MSG_SIZE];
+	char			tx_buffer[MAX_MSG_SIZE];
 
 	/* rx related values */
 	struct pi433_rx_cfg	rx_cfg;
@@ -613,8 +613,8 @@ static int pi433_tx_thread(void *data)
 		if (tx_cfg.enable_address_byte == OPTION_ON)
 			size++;
 
-		/* prime buffer */
-		memset(device->buffer, 0, size);
+		/* prime tx_buffer */
+		memset(device->tx_buffer, 0, size);
 		position = 0;
 
 		/* add length byte, if requested */
@@ -623,15 +623,15 @@ static int pi433_tx_thread(void *data)
 			 * according to spec, length byte itself must be
 			 * excluded from the length calculation
 			 */
-			device->buffer[position++] = size - 1;
+			device->tx_buffer[position++] = size - 1;
 
 		/* add adr byte, if requested */
 		if (tx_cfg.enable_address_byte == OPTION_ON)
-			device->buffer[position++] = tx_cfg.address_byte;
+			device->tx_buffer[position++] = tx_cfg.address_byte;
 
 		/* finally get message data from fifo */
-		retval = kfifo_out(&device->tx_fifo, &device->buffer[position],
-				   sizeof(device->buffer) - position);
+		retval = kfifo_out(&device->tx_fifo, &device->tx_buffer[position],
+				   sizeof(device->tx_buffer) - position);
 		dev_dbg(device->dev,
 			"read %d message byte(s) from fifo queue.\n", retval);
 
@@ -715,7 +715,7 @@ static int pi433_tx_thread(void *data)
 
 				device->free_in_fifo = 0;
 				rf69_write_fifo(spi,
-						&device->buffer[position],
+						&device->tx_buffer[position],
 						write_size);
 				position += write_size;
 			} else {
@@ -723,7 +723,7 @@ static int pi433_tx_thread(void *data)
 				device->free_in_fifo -= size;
 				repetitions--;
 				rf69_write_fifo(spi,
-						&device->buffer[position],
+						&device->tx_buffer[position],
 						(size - position));
 				position = 0; /* reset for next repetition */
 			}
-- 
2.34.1


