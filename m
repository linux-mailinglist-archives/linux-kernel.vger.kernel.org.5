Return-Path: <linux-kernel+bounces-93229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE6A872C91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842071F24B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A40CDF49;
	Wed,  6 Mar 2024 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="iECa9yxT"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4E79DE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691060; cv=none; b=aMZtuxkXPzfRsb8SI2a/9zz27IJ/k38yFgWNRYOEA/JsDZcqU0QbbgE/oNixLMXaYDXYPmRTBtoWohVVRh1hpcRUdiD5BkcStqA86csc6TGJvBft8/kabGUNlv8J3lSleBiV57SWTkraDMFN2727onoy94pkjmlNZ64z/s4BcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691060; c=relaxed/simple;
	bh=m0JFzhbCYRltGtekfKUn6fpcNdUzP/Wm9UQTmk0KYGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPzQyQQXh+mr4DBb/ualpmINX8sE29ZZ5OmnlQVckALMggFjRmDJbYn1PXcR7ehSNWaxhe3x/YGHGzBJcVM6iqxzJZMhGP36DqPJ8DOKZtz+7PbjMhVZ56tlZ6hQe4dbb9EdQtj24BFKGJDcRTlJeTFWJ+HfOT0JPWOFam0914k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=iECa9yxT; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZGM4CTvY0+d25ts8P1XACik2JTlfRT4G4KiIsDIO+0o=;
  b=iECa9yxTcR1CiuFx2MY4zxPYso0/S4KmXwNCr6EKMQx04aGuMw/DCCza
   NPJYV3VSMKhWqqHf4DgAXGzi9jOJC4SO2aepsnjqADzNX6+lJ6kxE7TiR
   k/JXkJKdWiAoqv2KSh3pT6YYONKVWlfsT/1EHXK23ofBY7XHRZUxLosCt
   dj0M7fzh9lODhDm/3jufe1JSHtt4LfKsPfuLxIWClwpVOw5k/GeU4K+Hr
   hmqwt3lCXcggeBR1gnP9jpDmzn2KH46Hq6L7YGW3cEjo85IApyrfa/VLt
   cpyj1dBbpJ1tbGc3HvN0JK0DyGttrbyEuT6QHfb5jyNHCDCbtHQ59i8dR
   A==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 06 Mar 2024 10:09:45 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 42629eri035636;
	Wed, 6 Mar 2024 10:09:40 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 10:09:40 +0800
From: kuro <kuro.chung@ite.com.tw>
To:
CC: Allen Chen <allen.chen@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>,
        Kuro Chung <kuro.chung@ite.com.tw>,
        Kenneth Haung <kenneth.hung@ite.com.tw>,
        Allen Chen <allen.chen@ite.corp-partner.google.com>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/1] UPSTREAM: drm/bridge: it6505: fix hibernate to resume no display issue
Date: Wed, 6 Mar 2024 10:20:03 +0800
Message-ID: <20240306022003.259245-2-kuro.chung@ite.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240306022003.259245-1-kuro.chung@ite.com.tw>
References: <20240306022003.259245-1-kuro.chung@ite.com.tw>
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
	AB1182823ED4183B2573C8A499561AD63DC9946A6777A5F025F3089B587BDBE82002:8
X-MAIL:mse.ite.com.tw 42629eri035636

From: kuro chung <kuro.chung@ite.com.tw>

ITE added a FIFO reset bit for input video. When system power resume,
the TTL input of it6505 may get some noise before video signal stable
and the hardware function reset is required.
But the input FIFO reset will also trigger error interrupts of output module rising.
Thus, it6505 have to wait a period can clear those expected error interrupts
caused by manual hardware reset in one interrupt handler calling to avoid interrupt looping.

Signed-off-by: Allen Chen <allen.chen@ite.corp-partner.google.com>
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


