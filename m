Return-Path: <linux-kernel+bounces-60653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CECF850813
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B884E1C213B0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA9481C6;
	Sun, 11 Feb 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="G9bS6ykP"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22A45C14;
	Sun, 11 Feb 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707638221; cv=none; b=uYDzISAt0YmT2xu8EooBv60QAB1al8813fegQkhNOLCXtlVVG6iJJr1+SewQTNwQnm5JEq33hognA9M7tj0uoJOS0tfkf3QertGkmjVMQYlVN/JXqLmriiqMmj/g7CBBPmGpQyJE7lARet85+tYRfsfpylHdHyRxnJ6n8UQ0LEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707638221; c=relaxed/simple;
	bh=h9oO5QOlg26/w1S5GFWhUe5tICf6isWwo0AeSnwaHWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fr0CNeWBjNzaGd8PLGQPzrdQe6zdwWOh+4LJbyENTx3iQcorHvU0CTmybgh3k/muPcHhzA7js6ugWcbHfIU7H2z/nrsvb9U2qYa0jbh3uByBcFDL79fPtb/BgZ0z2L07JDSAa2A7nwykhyCtocZrJrD4VsLxHPwZ4JcvuJcFFjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=G9bS6ykP; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.101.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id EAD2730FB4B;
	Sun, 11 Feb 2024 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1707638210;
	bh=h9oO5QOlg26/w1S5GFWhUe5tICf6isWwo0AeSnwaHWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9bS6ykPPFHQZR4vK4OGgQnvxYV7SM4TY0Zu1pJlITzCZ8AqSI5LnNejIypYJChhv
	 ILv80Eq+zJkIukjz0RvMk8tpPdF4xQAiHd2lfEfkYC+DQqXCh/SsnsYtmfUDOksINz
	 L/4ePiyQvm8wgO5DyF+D3YPEU07Bp6qIa5ZFWdbQ=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 5/6] iio: pressure: hsc030pa add mandatory delay
Date: Sun, 11 Feb 2024 09:56:36 +0200
Message-ID: <20240211075645.28777-6-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211075645.28777-1-petre.rodan@subdimension.ro>
References: <20240211075645.28777-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a mandatory 2ms delay between consecutive chip reads.

A Technical Note pdf specifies that the measurement cycle in these
chips takes around 1.26ms. By adding this 2ms delay we make sure that
we never get stale measurements.

For more details, please see "Figure 1" in the pdf below:

https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v3 no changes
 drivers/iio/pressure/hsc030pa.h     | 1 +
 drivers/iio/pressure/hsc030pa_i2c.c | 3 +++
 drivers/iio/pressure/hsc030pa_spi.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
index f1079a70799f..56dc8e88194b 100644
--- a/drivers/iio/pressure/hsc030pa.h
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>
 
 #define HSC_REG_MEASUREMENT_RD_SIZE 4
+#define HSC_RESP_TIME_MS            2
 
 struct device;
 
diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
index b5810bafef40..b3fd230e71da 100644
--- a/drivers/iio/pressure/hsc030pa_i2c.c
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -8,6 +8,7 @@
  * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
@@ -25,6 +26,8 @@ static int hsc_i2c_recv(struct hsc_data *data)
 	struct i2c_msg msg;
 	int ret;
 
+	msleep_interruptible(HSC_RESP_TIME_MS);
+
 	msg.addr = client->addr;
 	msg.flags = client->flags | I2C_M_RD;
 	msg.len = HSC_REG_MEASUREMENT_RD_SIZE;
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
index 8d3441f1dcf9..818fa6303454 100644
--- a/drivers/iio/pressure/hsc030pa_spi.c
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -8,6 +8,7 @@
  * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -28,6 +29,7 @@ static int hsc_spi_recv(struct hsc_data *data)
 		.len = HSC_REG_MEASUREMENT_RD_SIZE,
 	};
 
+	msleep_interruptible(HSC_RESP_TIME_MS);
 	return spi_sync_transfer(spi, &xfer, 1);
 }
 
-- 
2.43.0


