Return-Path: <linux-kernel+bounces-122871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6427088FEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872C51C25C32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88F7F46E;
	Thu, 28 Mar 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDwhS+vT"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C137D414
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627974; cv=none; b=L4kkeCxK837w255WGDLLZA2MbCWqVSJrylzQNYzmWScYft/XmST07ecgUOrMYmPLTRQsiXxcf9+918AFA9LucaoRP0E+CdmHP5/plviNnS1rEhwdqe4Pk5crrpDtA4FBZFBchF1m6GWXDbn0HVrK+i4dTgbOQhnPqHWCEGnQFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627974; c=relaxed/simple;
	bh=URk7fibNLFgzKg25jKRBtY4kibQ99F3/DTCHeKbgi78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3WsqBH95R/pB30qv8g3qzZ7U81be1urLp5ggzHLP9QQQz1Otu9FAUGg08BsuudAFzQB+d1WXlwBTz3+B7BlJRUWFej/sxg461wnPpYq7hd3ewgvwHaeFJNMhj4FaAxXjpTaR6eOefPwvUSG3Sb4Y7QmRdVZC1QWYaOtDRT0WxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDwhS+vT; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6c8d741e8so12402891fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711627971; x=1712232771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pHbsx3RtRZlv3pDf9iCJ8YxxZWB5X7vBVRsbvu4oC4=;
        b=IDwhS+vTLO2Z/mGH3tzEBeNsw5ef4uTbJc9nCJFRq/pRczqnERAw74DIcuki9/wlLR
         w2DeVG5VUK5QXWvuOteowwEjrWX8JPrl/cXRwL89g1HI8kNFzD/HQSeiUL6WltIEMFBI
         6e5ZHZTwS/WY6CvvyA7413zXjJzmG/ebSuo6ojA090gKp94WOgwzm36hM07OTaMuSYfh
         AGAg3RWxhIH8UwnLJ645u4bXjZTvd0NYQ05XFW2kC8Z27BBrHBhWnVICddWqk4OVsHH4
         4zv8zKopQNuYZz2cA2YiV0nNsvAVOb5fQOGsL1D4ueUfzf49C83cP+fkTQViHVNLG7T7
         dqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711627971; x=1712232771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pHbsx3RtRZlv3pDf9iCJ8YxxZWB5X7vBVRsbvu4oC4=;
        b=czmF+3lIgPRqt7L/3hvahtVU6N2mjs4qaLp1gcyB4XqEHWMVzvy8ddbgX4khiUBfXJ
         SbTRI/phLwKmd41V1ZYqh+zzSKGGldqxMgjGMjp1RoZK1s/3Yy3BShfie6xYIAKqBVRA
         o7b6sQK6cpBW9tnqzfmYm3HwTj4yF8yl3MGLi4JYiWtvF/sl0ktnHvA9DczqC89Kxdch
         UloTSVXzqadfk2m1SldcubvRDKNXWblLKrQCpeqbmKnsPm6gIrvlOjucofVrPsyKOH8j
         elrW15FoqtT8a+mRaLiE1OCzw2hkK9qHrBCPJRvo+CQNYgUVAgCEjLk7lBlhq8WoDlNE
         fUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH5sMxoEb4nSxlDE/L6kXJ7K4ydMnKiUCyp/17+E8BFh3XuxL0pVWoc1cgK8TmRj7IvLmsBC+ZwBT0vQwwHjh0eUiPodeJFmOScAO8
X-Gm-Message-State: AOJu0Yzl4sDwqqJe4bqcwUau+H7q9Eu8BuU8HMufyYzP5MYclLoXOro4
	9ZNOQuullXYwYiDljb+c94kV1mUlumZKP2aOFgAqzmvSqVMQN4bd
X-Google-Smtp-Source: AGHT+IGdaMYhdpddVfAxwiAOprPo8P0Hi3KDjALTqxK6436N8wfrHsCU3tjwnVQqr/iQ10Asu3PZmg==
X-Received: by 2002:a2e:99cb:0:b0:2d4:9ac6:6d00 with SMTP id l11-20020a2e99cb000000b002d49ac66d00mr2061402ljj.36.1711627970818;
        Thu, 28 Mar 2024 05:12:50 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:125e:963c:4e4b:b7c5])
        by smtp.gmail.com with ESMTPSA id bd11-20020a05600c1f0b00b00415460a63ebsm1416456wmb.29.2024.03.28.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:12:50 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] staging: pi433: Rename struct pi433_device buffer field to tx_buffer.
Date: Thu, 28 Mar 2024 14:12:39 +0200
Message-Id: <20240328121244.1244719-2-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328121244.1244719-1-ikobh7@gmail.com>
References: <20240328121244.1244719-1-ikobh7@gmail.com>
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

base-commit: 20952655235dd9b1447829591774f1d8561f7c6a
prerequisite-patch-id: 91943193af2fea74182be67fb583235a3fbeb77b
prerequisite-patch-id: 2cad031ba6a0782a67ab1645ff034a8be65c2e76
prerequisite-patch-id: 1a852ed8f9d133aec7c651fd9007e59e39c55fb7
-- 
2.34.1


