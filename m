Return-Path: <linux-kernel+bounces-29641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382DC83112F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2035282FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834C2443D;
	Thu, 18 Jan 2024 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qfviq2ln"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AA28FD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543163; cv=none; b=nE/7AZBVXQqrS7tzeIvNfLckBW7UHsXOuPa7xlzto3ncr5uPWX05bIjtW9Eso1N28Axl/d5JHwDD7WluDf2/znA2biLjzfXHLFn4OPXdqxDNXESeml8F5WNr4x2E/+195WqE/Uwka796jdfpQKTSvBacd3gA9PCoUu2IdcA2QJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543163; c=relaxed/simple;
	bh=qUn0tXssemFdVBvSxGg93sz4Fd7eoMBJDAi5n1ms+/A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=Fxc0kHKUHbwvsKI/bKlrfbAAsIyyYfxIQrKACF/uiRdQuE2muRoVxUMnkj4fbPhJX40H5LxoTx3Dc797gX3dciS99xl2VrftMTUKycizIm+Y04II0CSL0IQA2CpeObTPrl3bwey3ly4CRUQVX5ITVIniyKhgTYpdykxg+vI6U9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qfviq2ln; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5988e55ede0so4346243eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705543161; x=1706147961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0aZ0gh2nMEIgtdl3btOXR1faHkRWy2p55YtG63QiVs=;
        b=Qfviq2lneXjktAlOHn5A7YrzGJDC8zkDNy2bCtV/OTt/i+Eqb8gzNPVOGg6LYH0Ew3
         ls+gPNICcPrdeGjI2o8KQL0OD+usPsADdSacMjgTzopK8Rlzdt4RZZYAI0vSYsA1wQLr
         w52eKV5YqFzu23Hf5YdMSQD2LByd93tgtCj7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705543161; x=1706147961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0aZ0gh2nMEIgtdl3btOXR1faHkRWy2p55YtG63QiVs=;
        b=GbI05I8ZDs0TK2l/uuEWip0Dy+vJoScHp7L0MxsymN61peBreNmtvmHNCzwn8febRK
         3I0TXwcMDkC9Gr1IEZEuuaYZr0hfBr82Tmzz486guL09ta3vH6zNDkaa6RyQdRqAYXjI
         rl7N2BhSq6Yl8PBogxbSofYECLni8AuquhM7UTx92DulnFs0qU0rscs59h/d02qNJ7hu
         TaprEniPX4JSYDRtdXXCvKOkn26DMN/Sh28WgtFz+5Ds961PMg88q/GlqKtLint87jKl
         ddCWDLKEfU9vlTsIw1z/lFaWUhSfnvKR1O0UlMjaguFeF4OGO5Rj9KcNS2QuuBtQwqML
         Cq1w==
X-Gm-Message-State: AOJu0Yz62B0ty65sgefkrlSb487Y4MFrgjd7pJA2eeovtH+U/Srz6e0Y
	oaP4NI1GadDgJPajNCsEdPOFpKcKbZWbGX20QsE1YHe+dsBgNF6krbY3T6Ox1Q==
X-Google-Smtp-Source: AGHT+IHCITwuSs+RUYFe/ZYh2Aaq7Mwt3FYk63+r+HrTRQNnTtj99c4qfSNv1QoNApfW32peMOyUlQ==
X-Received: by 2002:a4a:d490:0:b0:598:8de8:be69 with SMTP id o16-20020a4ad490000000b005988de8be69mr175483oos.10.1705543161418;
        Wed, 17 Jan 2024 17:59:21 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:2557:c164:9ba8:60b])
        by smtp.gmail.com with ESMTPSA id h10-20020a65638a000000b005c2420fb198sm270879pgv.37.2024.01.17.17.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:59:21 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Xin Ji <xji@analogixsemi.com>,
	Pin-yen Lin <treapking@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Ensure bridge is suspended in disable()
Date: Wed, 17 Jan 2024 17:58:14 -0800
Message-ID: <20240118015916.2296741-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to commit 26db46bc9c67 ("drm/bridge: parade-ps8640: Ensure bridge
is suspended in .post_disable()"). Add a mutex to ensure that aux transfer
won't race with atomic_disable by holding the PM reference and prevent
the bridge from suspend.

Also we need to use pm_runtime_put_sync_suspend() to suspend the bridge
instead of idle with pm_runtime_put_sync().

Fixes: 3203e497eb76 ("drm/bridge: anx7625: Synchronously run runtime suspend.")
Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid through aux channel")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 7 ++++++-
 drivers/gpu/drm/bridge/analogix/anx7625.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index ef31033439bc..29d91493b101 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1762,6 +1762,7 @@ static ssize_t anx7625_aux_transfer(struct drm_dp_aux *aux,
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
 	int ret = 0;
 
+	mutex_lock(&ctx->aux_lock);
 	pm_runtime_get_sync(dev);
 	msg->reply = 0;
 	switch (request) {
@@ -1778,6 +1779,7 @@ static ssize_t anx7625_aux_transfer(struct drm_dp_aux *aux,
 					msg->size, msg->buffer);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
+	mutex_unlock(&ctx->aux_lock);
 
 	return ret;
 }
@@ -2474,7 +2476,9 @@ static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
 	ctx->connector = NULL;
 	anx7625_dp_stop(ctx);
 
-	pm_runtime_put_sync(dev);
+	mutex_lock(&ctx->aux_lock);
+	pm_runtime_put_sync_suspend(dev);
+	mutex_unlock(&ctx->aux_lock);
 }
 
 static enum drm_connector_status
@@ -2668,6 +2672,7 @@ static int anx7625_i2c_probe(struct i2c_client *client)
 
 	mutex_init(&platform->lock);
 	mutex_init(&platform->hdcp_wq_lock);
+	mutex_init(&platform->aux_lock);
 
 	INIT_DELAYED_WORK(&platform->hdcp_work, hdcp_check_work_func);
 	platform->hdcp_workqueue = create_workqueue("hdcp workqueue");
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 66ebee7f3d83..39ed35d33836 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -475,6 +475,8 @@ struct anx7625_data {
 	struct workqueue_struct *hdcp_workqueue;
 	/* Lock for hdcp work queue */
 	struct mutex hdcp_wq_lock;
+	/* Lock for aux transfer and disable */
+	struct mutex aux_lock;
 	char edid_block;
 	struct display_timing dt;
 	u8 display_timing_valid;
-- 
2.43.0.381.gb435a96ce8-goog


