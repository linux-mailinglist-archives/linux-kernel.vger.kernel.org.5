Return-Path: <linux-kernel+bounces-11965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606AF81EE48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE3E28384F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992F044373;
	Wed, 27 Dec 2023 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W299B+Dj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E0444362
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9c2db82b0so352189b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 02:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703673810; x=1704278610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQyauLZpBuVyKcsRSZOIv2oS+kk+ZdFH+9BKEUlZjBY=;
        b=W299B+DjU2xAnSgAQATMm8aDaG5I+61pHBx660sIJjq0xnAPJDJkwpe3MY3Ji1lbAm
         lfxqwakc/FCNZL9/u2HIPIXSmoOdY0ubNRI82iXLcezXj1Km6l9T8g2dpjKkwY+sA5Ct
         LwugKwgX6HgGSYbYxCTR15umV5xODdOGQsIAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703673810; x=1704278610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQyauLZpBuVyKcsRSZOIv2oS+kk+ZdFH+9BKEUlZjBY=;
        b=tnDYdBJVlpQVTckL6bVA66J5oJHAznQ8of/FVvsgLEpsy38KII8wp/mfj/6vu24rdV
         02cYscqmBkP0m1QUKZAQbIBk4uBsIW67eEgazhu7Fwj6juMZnY3rBYsJZbkbLfXSyXva
         i5rB3Tlz/SKajiugdi3ej9Lkz4XSdLzjYYg9eOxAKegYBOXzX9w/koPjDIh/ojtT7QUo
         PouHOKDxNMM7PGb+7M5tljqvJa64Oqreq3ehn1TfpPVWp8pYPeFxxS9Y3hArQfXWiBrR
         MQ/w2NpgJPYVf4yYh4voLC95O6xL64yABKMIL0VWvnPMPA3BcoYmkksOG5XkITEzVuXU
         k4Uw==
X-Gm-Message-State: AOJu0YxqXlOFBk9PVj1lfww73bv2AKS6tu/5qv0s5kKm5RtXcjIasDjO
	fwN4zpTP1hZvvapX35vh46jhLlL1RSeE0blGd8Ckwj8qSQ==
X-Google-Smtp-Source: AGHT+IGL05LvH/t32LDNIF/kC/4NeTQ036oBgMVdj8N46a0EgWRcxP6whWsvaqZNRtuVyS/anTFn0g==
X-Received: by 2002:a05:6a00:d6d:b0:6d9:a87c:4a3a with SMTP id n45-20020a056a000d6d00b006d9a87c4a3amr1559084pfv.68.1703673809766;
        Wed, 27 Dec 2023 02:43:29 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:18d2:7869:e8b9:f4e4])
        by smtp.gmail.com with ESMTPSA id q7-20020a056a0002a700b006cb6119f516sm6128004pfs.163.2023.12.27.02.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:43:29 -0800 (PST)
From: Pin-yen Lin <treapking@chromium.org>
To: Douglas Anderson <dianders@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sean Paul <seanpaul@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disable()
Date: Wed, 27 Dec 2023 18:42:53 +0800
Message-ID: <20231227104324.2457378-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable the autosuspend of runtime PM and use completion to make sure
ps8640_suspend() is called in ps8640_atomic_post_disable().

The ps8640 bridge seems to expect everything to be power cycled at the
disable process, but sometimes ps8640_aux_transfer() holds the runtime
PM reference and prevents the bridge from suspend.

Instead of force powering off the bridge and taking the risk of breaking
the AUX communication, disable the autosuspend and wait for
ps8640_suspend() being called here, and re-enable the autosuspend
afterwards.  With this approach, the bridge should be suspended after
the current ps8640_aux_transfer() completes.

Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power management")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 33 +++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 8161b1a1a4b1..f8ea486a76fd 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -107,6 +107,7 @@ struct ps8640 {
 	struct device_link *link;
 	bool pre_enabled;
 	bool need_post_hpd_delay;
+	struct completion suspend_completion;
 };
 
 static const struct regmap_config ps8640_regmap_config[] = {
@@ -417,6 +418,8 @@ static int __maybe_unused ps8640_suspend(struct device *dev)
 	if (ret < 0)
 		dev_err(dev, "cannot disable regulators %d\n", ret);
 
+	complete_all(&ps_bridge->suspend_completion);
+
 	return ret;
 }
 
@@ -465,11 +468,37 @@ static void ps8640_atomic_post_disable(struct drm_bridge *bridge,
 				       struct drm_bridge_state *old_bridge_state)
 {
 	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
+	struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
 
 	ps_bridge->pre_enabled = false;
 
 	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
-	pm_runtime_put_sync_suspend(&ps_bridge->page[PAGE0_DP_CNTL]->dev);
+
+	/*
+	 * The ps8640 bridge seems to expect everything to be power cycled at
+	 * the disable process, but sometimes ps8640_aux_transfer() holds the
+	 * runtime PM reference and prevents the bridge from suspend.
+	 * Instead of force powering off the bridge and taking the risk of
+	 * breaking the AUX communication, disable the autosuspend and wait for
+	 * ps8640_suspend() being called here, and re-enable the autosuspend
+	 * afterwards.  With this approach, the bridge should be suspended after
+	 * the current ps8640_aux_transfer() completes.
+	 */
+	reinit_completion(&ps_bridge->suspend_completion);
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_put_sync_suspend(dev);
+
+	/*
+	 * Mostly the suspend completes under 10 ms, but sometimes it could
+	 * take 708 ms to complete.  Set the timeout to 2000 ms here to be
+	 * extra safe.
+	 */
+	if (!wait_for_completion_timeout(&ps_bridge->suspend_completion,
+					 msecs_to_jiffies(2000))) {
+		dev_warn(dev, "Failed to wait for the suspend completion\n");
+	}
+
+	pm_runtime_use_autosuspend(dev);
 }
 
 static int ps8640_bridge_attach(struct drm_bridge *bridge,
@@ -693,6 +722,8 @@ static int ps8640_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	init_completion(&ps_bridge->suspend_completion);
+
 	ret = devm_of_dp_aux_populate_bus(&ps_bridge->aux, ps8640_bridge_link_panel);
 
 	/*
-- 
2.43.0.472.g3155946c3a-goog


