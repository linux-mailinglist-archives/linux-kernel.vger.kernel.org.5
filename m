Return-Path: <linux-kernel+bounces-127833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E489518C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42842287FD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49557657B5;
	Tue,  2 Apr 2024 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iph6/H3+"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBF626A0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056468; cv=none; b=b2AYkucUwvnlqsLYI3L7ACPHFPBqg/DU3C8qW63ojxsC/0lU6z/lNZ7I4J2tWp3jsjDY9wucSOm4S8nY7RWra+w7HLJxoPlxlag+88g53T1touSnKY1SRn5xCVyRgIoxQ5RUnu4nKGqw/mUI4a4bn2/WapHTuv222ol8WiJqR4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056468; c=relaxed/simple;
	bh=g/WMOp/DBXdvY4p/J51T2DdQvuOBI7ftgCcNNdq/ZQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kh0XZrs+yRv1mgzpyhEmzZgEP9i5b+bJcpvVi+H1qf5yEUlEC/QU/6nOZ1cFQ88fSZwIUMoG0A0gWYGRrF5sNMaWyMIlQ3Prfg2+CNktUgLfPkgirDd4nNjHkD2IVyooBkuCa19lDrpzptCXhna0mnemz96NbP2FBPhqpKyOCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iph6/H3+; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d47000f875so2080102e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712056465; x=1712661265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwPl8LYnfW65bMF9In5HJ2vXzRSbzAQqtlyK3TQNiLw=;
        b=Iph6/H3+8m9q7/eVHUTq8b/7ZXJ/2t+4k1RMSQQ3w4j3GQhSU+VtY1iSJ2BxzBDjCt
         vmpYOHAqBl48wRVeMNrAKzLX+OwTJ71HfpU9i0cXIOvUamtCJBN8bFOn5KNcjsmzdpZo
         hqc5Igfkkn8Cn5oNyc+j+6gWe9TPlz3ohM7MMJeHockVHbUPXjrcbV4CkXVecDb/o2y1
         56Rg6JX/AiKh6CLHZxcA8ugED8FXGub+h+p2cY0B2ejBRwog1oUbt4WzuZkfmjjqrHh3
         LFS8JHJjKDg6fTmW/xyrinaW4tmE3uyJYuXTNY7P/mh6o6JDcjURbjjZH5eFLqCVHcYR
         7L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056465; x=1712661265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwPl8LYnfW65bMF9In5HJ2vXzRSbzAQqtlyK3TQNiLw=;
        b=uxAguD06/jxosug0z7sVEaDhJalodgYlLUTm1ncitkapdPJ/a7MMijMtmpefnfv+pA
         +w+4aGx05eE44IdhxEn7ZTZOq2nZ11H/8d2Y7IE3pBuyzNMS3vUj16nQnX9ZnteaSnY4
         MRD/Wa3FC/0C+Ws+iHw+Q9RCxETe8z9IKd2YLmZ8hqr+WGeOCf+RV56h7/TzzPQISfZY
         GyF+cb5pS/mvRX8bhdfISJphaQtoiGpw2IPXAFMLv4J9KHi/Fi8oiP5yDhMLU7kWSvn3
         hWsoM2hZDIYWiSaAttpJlREZ2NUJpq8Xrr3wPh5cpuJScyRRMG4334yXqJnzBGvRjWcz
         O3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMQTV2kMTX3xIuqa85iuwmz+a1IC6Ew74U8zu3r994YIR93Hw8oEJn0+1Ec5+Wu/yOkCoeVoN66LPBuvHIZ7pcowc6SrGZMFWMs3To
X-Gm-Message-State: AOJu0YyOS2PhjPPnFLCL6GlXWSnOqD7hDNIJ/piKRfN6xXVel1Gi2KtE
	lC63NF33bAZCnz9EtcgJTR7BJ2ZxTm3WKBu/i8Pbr0FERWTxpLtw
X-Google-Smtp-Source: AGHT+IGQ+gz5kG9dTgq1zUZPBLECe9wqwN5K7d6gbfjwiXOgW0CKfm40k68E2evbnEs3WIhJ/0Q7UQ==
X-Received: by 2002:a67:f2d0:0:b0:478:46db:6222 with SMTP id a16-20020a67f2d0000000b0047846db6222mr9938357vsn.24.1712056464764;
        Tue, 02 Apr 2024 04:14:24 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:737b:ef00:2c6f:6cdc:f641:6ecf])
        by smtp.gmail.com with ESMTPSA id 11-20020a05621420cb00b006968a6fb010sm5428855qve.91.2024.04.02.04.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:14:24 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] staging: pi433: Rename struct pi433_device buffer field to tx_buffer.
Date: Tue,  2 Apr 2024 14:14:09 +0300
Message-Id: <20240402111414.871089-2-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402111414.871089-1-ikobh7@gmail.com>
References: <20240402111414.871089-1-ikobh7@gmail.com>
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


