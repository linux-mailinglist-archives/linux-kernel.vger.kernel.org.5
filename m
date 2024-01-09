Return-Path: <linux-kernel+bounces-20824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496018285B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2126287368
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DF4381AE;
	Tue,  9 Jan 2024 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O3Jl6D/w"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D4381A2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d542701796so11036555ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 04:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704801934; x=1705406734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0SAVymi5HmCwUg9UqsOLYPHTs9Rt+kpxHENMqJZJIrQ=;
        b=O3Jl6D/wdAYSbI2Jr7KNfdx1EVjGnERJFlqV2foCMA6tTxcpyPPuRE+LZrMrj0cqAh
         1PI7NQXPm5dCw6cSsh/Jaa7vqcIrRdfWzgg4OlOcJpJWkbDWfwEjNFzzV9iB276IDeoQ
         b4Gw6BV0XMHdmCE+4hT+66AjJ5kbntBMubzuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801934; x=1705406734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SAVymi5HmCwUg9UqsOLYPHTs9Rt+kpxHENMqJZJIrQ=;
        b=Cx5CshxsDa4C/T0u8CdBB/9aYAjAmqCflPYl4mpblcInfmR9qSihnHP+1wZtFt9PpB
         InO2z79jJ4m423CKGUNvWiWThmXAIYkvau1cWuSNlhBICLL/UyZm+DReDF1vYhSOT/7u
         G1FKgDZuQgrpIqRUT1LP/PTkz4HihMSZRxl+yN0XBJKy+RKOfB2d6jM6mRTzCW7Os1X0
         o64izxi3Q3S+P6JHG4dQ2V6IP4OV8PEPfh8kHwM73EZArf+y2LYHM5Dw2kx1ww6aVvI9
         +BNwoNaArUBZBbHPFnWhoLTPRP0ItA/KMZqNDd2pYky2ARTToPcdWTCBD5d/5kw76tYZ
         wzig==
X-Gm-Message-State: AOJu0YwC3uxI7P6syYRd6+GNMoeK+WQSddBgWM51eS0sUYJM56tCppyv
	/s9LBhG1i/5v6QyqVRSRM7+dTuex+e6m
X-Google-Smtp-Source: AGHT+IGeIKw+NVQF8nxXIKc3J2iYRmJkKhs/dP1TPBvnnpLOXB7Mx5ephj6FfLKbn60L490sa8BQKg==
X-Received: by 2002:a17:903:22d2:b0:1d4:cf2b:6bfe with SMTP id y18-20020a17090322d200b001d4cf2b6bfemr3057932plg.0.1704801934037;
        Tue, 09 Jan 2024 04:05:34 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:3368:3e0c:8daf:b528])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902729700b001d54b86774dsm1638321pll.67.2024.01.09.04.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:05:33 -0800 (PST)
From: Pin-yen Lin <treapking@chromium.org>
To: Douglas Anderson <dianders@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	Sean Paul <seanpaul@chromium.org>,
	linux-kernel@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2] drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disable()
Date: Tue,  9 Jan 2024 20:04:57 +0800
Message-ID: <20240109120528.1292601-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ps8640 bridge seems to expect everything to be power cycled at the
disable process, but sometimes ps8640_aux_transfer() holds the runtime
PM reference and prevents the bridge from suspend.

Prevent that by introducing a mutex lock between ps8640_aux_transfer()
and .post_disable() to make sure the bridge is really powered off.

Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power management")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v2:
- Use mutex instead of the completion and autosuspend hack

 drivers/gpu/drm/bridge/parade-ps8640.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 8161b1a1a4b1..46c84ce66041 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -107,6 +107,7 @@ struct ps8640 {
 	struct device_link *link;
 	bool pre_enabled;
 	bool need_post_hpd_delay;
+	struct mutex aux_lock;
 };
 
 static const struct regmap_config ps8640_regmap_config[] = {
@@ -344,10 +345,12 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
 	struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
 	int ret;
 
+	mutex_lock(&ps_bridge->aux_lock);
 	pm_runtime_get_sync(dev);
 	ret = ps8640_aux_transfer_msg(aux, msg);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
+	mutex_unlock(&ps_bridge->aux_lock);
 
 	return ret;
 }
@@ -469,7 +472,18 @@ static void ps8640_atomic_post_disable(struct drm_bridge *bridge,
 	ps_bridge->pre_enabled = false;
 
 	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
+
+	/*
+	 * The bridge seems to expect everything to be power cycled at the
+	 * disable process, so grab a lock here to make sure
+	 * ps8640_aux_transfer() is not holding a runtime PM reference and
+	 * preventing the bridge from suspend.
+	 */
+	mutex_lock(&ps_bridge->aux_lock);
+
 	pm_runtime_put_sync_suspend(&ps_bridge->page[PAGE0_DP_CNTL]->dev);
+
+	mutex_unlock(&ps_bridge->aux_lock);
 }
 
 static int ps8640_bridge_attach(struct drm_bridge *bridge,
@@ -618,6 +632,8 @@ static int ps8640_probe(struct i2c_client *client)
 	if (!ps_bridge)
 		return -ENOMEM;
 
+	mutex_init(&ps_bridge->aux_lock);
+
 	ps_bridge->supplies[0].supply = "vdd12";
 	ps_bridge->supplies[1].supply = "vdd33";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ps_bridge->supplies),
-- 
2.43.0.472.g3155946c3a-goog


