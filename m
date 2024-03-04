Return-Path: <linux-kernel+bounces-90001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30EC86F8CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1501F21497
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658436127;
	Mon,  4 Mar 2024 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="nS0543c5"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C65211C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709521786; cv=none; b=YFB9GZYwLQGxzwtS0zx2Wt0X+HxffE/OxZnXewXKjS8RcM8pWzB+LnOn1FYhsxa+8YB7/Evl/kK8JBjaUAexC58tTYQxWwa4LNODU7MWwlszXgR6SNZLpRc9ORrgr1HPUafTsPjYgJZKUbeLWqTIuOmxWXKD7sYOfjxg/CIXDyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709521786; c=relaxed/simple;
	bh=+uebR4UVRCidfrSG2g4L1A2cP17hscIePZLmM4rYqMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaLPrZKDJ7/dU0rJ5Yn7b+LRbBoTIR6h7z5bX4OkSe8yVasW3cFQnfZyBM9Z43OJqx1vvz4UXn31oU851iWy5qArKA1p2l4ho0Barhg26XdkYRxWZ7RSSfDDtPDmgmdq06OoE5EB6abUDcFbjcA02ZmYOPnkFmsjtK7hca9b1DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=nS0543c5; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hseO+L+Af1dH00xH6zIMorO/c7gROuvZj1lTdWgi5NE=;
  b=nS0543c5wHZAD0Rm+J+sfE+2xaNNj2UOcezTz0xZYPu7w5/BRzqLaTT8
   yGxeVQbcnFxUAU78XwXPiQRUK9X1b+5fB7Rwlf68WuS/b3RLhT/CXglXE
   aEvkGpfGmldtSshXmfRQq4luAN+t/lqW/g6lxfbMyXQN2Bi/nt2WIK/Zz
   GSS08wA2F5SuG+PEbJM++LRI6t9ez8fc/YI9yIV8tB7zqw4yVF9wshsB8
   us5rYn6dUSmZdNdOl5JGM4srSs5KF7ynnAWgYz19PUKmkTPOLLhbjeRJ5
   5/K8Q72/2d53FkZ0icZEOqdBD3UHFA+TKXoeeFmh2e2BI15jJ1jRkm/K7
   A==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 04 Mar 2024 11:08:35 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 42438Ung022597;
	Mon, 4 Mar 2024 11:08:30 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 11:08:30 +0800
From: kuro <kuro.chung@ite.com.tw>
To:
CC: Allen Chen <allen.chen@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>,
        Kuro Chung <kuro.chung@ite.com.tw>,
        Kenneth Haung <kenneth.hung@ite.com.tw>,
        Allen Chen <allen.chen@ite.corp-partner.google.com>,
        Andrzej Hajda
	<a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss
	<robert.foss@linaro.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] UPSTREAM: drm/bridge: it6505: fix hibernate to resume no display issue
Date: Mon, 4 Mar 2024 11:19:44 +0800
Message-ID: <20240304031945.250763-2-kuro.chung@ite.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304031945.250763-1-kuro.chung@ite.com.tw>
References: <20240304031945.250763-1-kuro.chung@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP:
	DEF683D84CA243BD742B6F8DB7F8C7D6B72F9DB62C2C36C95AEFC5AF1FA04CD52002:8
X-MAIL:mse.ite.com.tw 42438Ung022597

From: kuro chung <kuro.chung@ite.com.tw>

ITE added a FIFO reset bit for input video. When system power resume,
the TTL input of it6505 may get some noise before video signal stable
and the hardware function reset is required.
But the input FIFO reset will also trigger error interrupts of output module rising.
Thus, it6505 have to wait a period can clear those expected error interrupts
caused by manual hardware reset in one interrupt handler calling to avoid interrupt looping.

Signed-off-by: Allen Chen <allen.chen@ite.corp-partner.google.com>
(cherry picked from commit Iaa3cd9da92a625496f579d87d0ab74ca9c4937c4)

BUG=None
TEST=None

Change-Id: Iaa3cd9da92a625496f579d87d0ab74ca9c4937c4
---
 drivers/gpu/drm/bridge/ite-it6505.c | 54 ++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index b53da9bb65a16..e592e14a48578 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1318,6 +1318,8 @@ static void it6505_video_reset(struct it6505 *it6505)
 	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_VID_MUTE, EN_VID_MUTE);
 	it6505_set_bits(it6505, REG_INFOFRAME_CTRL, EN_VID_CTRL_PKT, 0x00);
 	it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, VIDEO_RESET);
+	it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, 0x02);
+	it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, 0x00);
 	it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, RST_501_FIFO);
 	it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, 0x00);
 	it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, 0x00);
@@ -2480,10 +2482,6 @@ static void it6505_irq_video_fifo_error(struct it6505 *it6505)
 	struct device *dev = &it6505->client->dev;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "video fifo overflow interrupt");
-	it6505->auto_train_retry = AUTO_TRAIN_RETRY;
-	flush_work(&it6505->link_works);
-	it6505_stop_hdcp(it6505);
-	it6505_video_reset(it6505);
 }
 
 static void it6505_irq_io_latch_fifo_overflow(struct it6505 *it6505)
@@ -2491,10 +2489,6 @@ static void it6505_irq_io_latch_fifo_overflow(struct it6505 *it6505)
 	struct device *dev = &it6505->client->dev;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "IO latch fifo overflow interrupt");
-	it6505->auto_train_retry = AUTO_TRAIN_RETRY;
-	flush_work(&it6505->link_works);
-	it6505_stop_hdcp(it6505);
-	it6505_video_reset(it6505);
 }
 
 static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
@@ -2502,6 +2496,46 @@ static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
 	return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
 }
 
+static bool it6505_is_video_error_int(const int *int_status)
+{
+	if ((it6505_test_bit(BIT_INT_VID_FIFO_ERROR, (unsigned int *)int_status)) || (it6505_test_bit(BIT_INT_IO_FIFO_OVERFLOW, (unsigned int *)int_status)))
+		return 1;
+	return 0;
+}
+
+static void it6505_irq_video_error_handler(struct it6505 *it6505)
+{
+	struct device *dev = &it6505->client->dev;
+	int int_status[3] = {0};
+	int reg_0d;
+	int i;
+
+	it6505->auto_train_retry = AUTO_TRAIN_RETRY;
+	flush_work(&it6505->link_works);
+	it6505_stop_hdcp(it6505);
+	it6505_video_reset(it6505);
+
+	DRM_DEV_DEBUG_DRIVER(dev, "Video Error reset wait video...");
+
+	for (i = 0; i < 10; i++) {
+		usleep_range(10000, 11000);
+		int_status[2] = it6505_read(it6505, INT_STATUS_03);
+		reg_0d = it6505_read(it6505, REG_SYSTEM_STS);
+		it6505_write(it6505, INT_STATUS_03, int_status[2]);
+
+		DRM_DEV_DEBUG_DRIVER(dev, "reg08 = 0x%02x", int_status[2]);
+		DRM_DEV_DEBUG_DRIVER(dev, "reg0D = 0x%02x", reg_0d);
+
+		if ((reg_0d & VIDEO_STB) && (reg_0d >= 0))
+			break;
+
+		if (it6505_is_video_error_int(int_status)) {
+			it6505_video_reset(it6505);
+			DRM_DEV_DEBUG_DRIVER(dev, "Video Error reset wait video (%d)", i);
+		}
+	}
+}
+
 static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 {
 	struct it6505 *it6505 = data;
@@ -2522,7 +2556,7 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 		{ BIT_INT_VID_FIFO_ERROR, it6505_irq_video_fifo_error },
 		{ BIT_INT_IO_FIFO_OVERFLOW, it6505_irq_io_latch_fifo_overflow },
 	};
-	int int_status[3], i;
+	int int_status[3], i, reg_0d;
 
 	if (it6505->enable_drv_hold || !it6505->powered)
 		return IRQ_HANDLED;
@@ -2550,6 +2584,8 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 			if (it6505_test_bit(irq_vec[i].bit, (unsigned int *)int_status))
 				irq_vec[i].handler(it6505);
 		}
+		if (it6505_is_video_error_int(int_status))
+			it6505_irq_video_error_handler(it6505);
 	}
 
 	pm_runtime_put_sync(dev);
-- 
2.25.1


