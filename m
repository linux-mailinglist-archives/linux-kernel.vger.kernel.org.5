Return-Path: <linux-kernel+bounces-60552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0724185069E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE221C21447
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2B35FDA4;
	Sat, 10 Feb 2024 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efZhc3TJ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B716027A;
	Sat, 10 Feb 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707601983; cv=none; b=Qqs+RAemtkUC8SmvuA5z/kptIA6XUKSY6P3iX2NokI8wvv9luOcQEGUI3gK25MGlqgzJbVRtXbUWdwUYT5EmIoVjBXO2a1Yg2nusxqh2iGF0n4bnXdNrV9dFpPaTp33MxTLKePsT5pwmIjvzjWzh5n+ou9v+UEPGGvqt7gc8cvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707601983; c=relaxed/simple;
	bh=9o7zsXvraSjsCEIhLU7II+BaKhLy7FlP98jc26bW638=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VGpJ1H/7ZIYO6cjOiS6/viJwnkfNmDqC3sFfHt3+M/Gzmx7gjgpZZZXpY9CFWLRTx0MYmK/yWeY+qG+1v9i6csvwoH/GKlK4IW29m8KMao0ft5pKRON3++aLGyhbgUmp5uEQb80nbVSpzphlfrHd2S6ncdtxP3z4kpnmN9J9goE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efZhc3TJ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso22774381fa.3;
        Sat, 10 Feb 2024 13:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707601980; x=1708206780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+VuQ9yysl3g1DNmr5ri0m5tR/HKq6LHQGQTGRbQekY=;
        b=efZhc3TJgQTF4sJR8WSMTw1p3qS1CXYCkKDnXoR0sr27FAMSJ1QWY8F4cSOkMhsInQ
         28n543rlBSSf1ok+bGgLqkrCusgMJ3Kzq7uvIFeuAbYQd/y9pQe4OZLrhKAsBc8WOWxT
         49NOoRmLHJ482yr44uCtXnoH/tOxFt8u01ZkPewveiwBC6+ufyAwsdEPtdvy+DXSS0zO
         bgM0K/CJW6KPG4AFUIYxNsH5b+tTqouC/nn0p2vWhKQBI8g2WVI68ydpdQ+hlXci9WwV
         R13QNtHZkyOOJmEOKEPXk/euUMuCsciFOKU7CFQz+qvWrQFFCqzh55Fc8Dhha9C1xdvF
         Xagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707601980; x=1708206780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+VuQ9yysl3g1DNmr5ri0m5tR/HKq6LHQGQTGRbQekY=;
        b=qGyyFkiA8/DVUJPig4HkpNUVH4mWlTtPFZevFDP2cPjHmuicLrv5Tu25z3rhtQS2BN
         MExpmjuA4fF3LK1paMagLtswliu9HtvBvhQYQ7OL2Cp3e6axFAH6PTTh5a9HU1smghWt
         7gbDErZrg8XMHJIqb1fx8QHeIC9riyR558hsHyiVxD4N0egLvIoESsBuSj+JcDjFcJkG
         9IXAK8pouo+UKUE1ymZ49STel7UtRK0saUcHa762muGWc/z6gikSoCpWcGUmmmkoUGU+
         /H4PscjLhLVSN8Bspk1ToWpXN4ZrVVgj/TFpkOFWXD0uAh+EESJXKxrnQC8PiTVVXX1N
         tHXg==
X-Forwarded-Encrypted: i=1; AJvYcCXOUScT95L3ea628hR3+sAG16U//oKuvofbveQC12LDw8dttYHsgoMv7kO8/nSZ35CeU1T2yRIZGikfXKQEGTofJv49RY66OvrISlShVq1YaYWwgSrbOLzSGv8pcgPEu2crJQ/96vyyMOc=
X-Gm-Message-State: AOJu0YwmY0wJWkNGh0wvPVNC/rfIulcaJBs5gGhWs+E9Q39g2ZpvZyrp
	TUanHMJR16C1HRwu3kEDT6BZzRxWGVv8B9TlFXDv6XB9fNXvnBWe
X-Google-Smtp-Source: AGHT+IGw0OVQhQFYgKkVLvI6KnpqZ//x1zhr8YOO3UNJuiIirHCdyXrW80fmJRufwwn63Z+vykzFAw==
X-Received: by 2002:a19:2d47:0:b0:511:47a4:ef0e with SMTP id t7-20020a192d47000000b0051147a4ef0emr1677909lft.7.1707601979600;
        Sat, 10 Feb 2024 13:52:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2cPEPDaaSC/hrzZi+46NnAVWNP88hnIjxa10U8y44az98mEw8yO7NnW0zgknZAIvkOEZePm7dtPrLpXjOSIF/iDY36PUYTcXVdtUpYzpz4d41vs6jD39ZlxLMMFa0o69BbtyBnRVGKT7hv7T3ZJRitxjBEzzdgrnu1niUHF6Tgf3/z/gtqV9H/fAV/vXMez9nGi9/XFAI4Suy+XI64cbyPQU6uzLT0vVwDSmBbDaExoO8owVPhsVD5v8vaaXpHIq/f0jsxX2llD4wCoUVR/wJf6FYsIwYl70loRr4YESmRR9nIzIDg2jPILkxOp+p0chcbry1MnnHHuRx0v0OWT5CGyl/TVfyUh09wKbZa29nS1nXuXZfgw==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:52:59 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 05/19] hid-ft260: fix unprotected write_buf concurrent access
Date: Sat, 10 Feb 2024 23:51:33 +0200
Message-Id: <20240210215147.77629-6-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UART code uses the write_buf unsafely, compromising the data integrity
of both I2C and UART channels.

The I2C channel uses the write_buf to send the HID reports. It uses mutex
to make it atomically. For UART to use this buffer, it should grab the
same mutex first. But then it will degrade the performance of both
channels. The better approach is to have a separate Tx buffer for UART.

I fixed it and briefly tested the data integrity simultaneously writing
via I2C and UART channels.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 77638cae595e..3d6beac0b8b6 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -38,9 +38,12 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 			pr_info("%s: " format, __func__, ##arg);	  \
 	} while (0)
 
-#define FT260_REPORT_MAX_LENGTH (64)
-#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
-#define FT260_UART_DATA_REPORT_ID(len) (FT260_UART_REPORT_MIN + (len - 1) / 4)
+#define FT260_REPORT_MAX_LEN (64)
+#define FT260_DATA_REPORT_ID(min, len) (min + (len - 1) / 4)
+#define FT260_I2C_DATA_REPORT_ID(len) \
+		FT260_DATA_REPORT_ID(FT260_I2C_REPORT_MIN, len)
+#define FT260_UART_DATA_REPORT_ID(len) \
+		FT260_DATA_REPORT_ID(FT260_UART_REPORT_MIN, len)
 
 #define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
 
@@ -56,7 +59,8 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
  * read payload length to be 180 bytes.
  */
 #define FT260_RD_DATA_MAX (180)
-#define FT260_WR_DATA_MAX (60)
+#define FT260_WR_I2C_DATA_MAX (60)
+#define FT260_WR_UART_DATA_MAX (62)
 
 /*
  * Device interface configuration.
@@ -229,7 +233,7 @@ struct ft260_i2c_write_request_report {
 	u8 address;		/* 7-bit I2C address */
 	u8 flag;		/* I2C transaction condition */
 	u8 length;		/* data payload length */
-	u8 data[FT260_WR_DATA_MAX]; /* data payload */
+	u8 data[FT260_WR_I2C_DATA_MAX]; /* data payload */
 } __packed;
 
 struct ft260_i2c_read_request_report {
@@ -249,7 +253,7 @@ struct ft260_input_report {
 struct ft260_uart_write_request_report {
 	u8 report;		/* FT260_UART_REPORT */
 	u8 length;		/* data payload length */
-	u8 data[] __counted_by(length);	/* variable data payload */
+	u8 data[FT260_WR_UART_DATA_MAX]; /* data payload */
 } __packed;
 
 struct ft260_configure_uart_request {
@@ -318,10 +322,10 @@ struct ft260_device {
 	struct work_struct wakeup_work;
 	bool reschedule_work;
 
-
 	struct completion wait;
 	struct mutex lock;
-	u8 write_buf[FT260_REPORT_MAX_LENGTH];
+	u8 i2c_wr_buf[FT260_REPORT_MAX_LEN];
+	u8 uart_wr_buf[FT260_REPORT_MAX_LEN];
 	unsigned long need_wakeup_at;
 	u8 *read_buf;
 	u16 read_idx;
@@ -503,7 +507,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 	int ret, wr_len, idx = 0;
 	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)dev->write_buf;
+		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
 	if (len < 1)
 		return -EINVAL;
@@ -511,12 +515,12 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 	rep->flag = FT260_FLAG_START;
 
 	do {
-		if (len <= FT260_WR_DATA_MAX) {
+		if (len <= FT260_WR_I2C_DATA_MAX) {
 			wr_len = len;
 			if (flag == FT260_FLAG_START_STOP)
 				rep->flag |= FT260_FLAG_STOP;
 		} else {
-			wr_len = FT260_WR_DATA_MAX;
+			wr_len = FT260_WR_I2C_DATA_MAX;
 		}
 
 		rep->report = FT260_I2C_DATA_REPORT_ID(wr_len);
@@ -552,7 +556,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)dev->write_buf;
+		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
 	if (data_len >= sizeof(rep->data))
 		return -EINVAL;
@@ -1167,10 +1171,10 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
 		goto tty_out;
 	}
 
-	rep = (struct ft260_uart_write_request_report *)port->write_buf;
+	rep = (struct ft260_uart_write_request_report *)port->uart_wr_buf;
 
 	do {
-		len = min(data_len, FT260_WR_DATA_MAX);
+		len = min(data_len, FT260_WR_UART_DATA_MAX);
 
 		rep->report = FT260_UART_DATA_REPORT_ID(len);
 		rep->length = len;
-- 
2.40.1


