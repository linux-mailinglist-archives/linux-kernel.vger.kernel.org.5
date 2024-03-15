Return-Path: <linux-kernel+bounces-104944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185687D64B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D65B1F2216C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C745676C;
	Fri, 15 Mar 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M+4I/rWV"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133654FA7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538663; cv=none; b=hjms90XdjpDCcduibYZ0lykG56cIkjjVuQvD5pxnridyn01Gimt030yAL8jUlQW20U337y/ppmahcjIPprUWswJFtsiwPuTO/Gc+fxn7jPO4aRXcGfnKLZ/g4Pp+6Ox66z0GaUwzDz0gm+BVR3l5+m8t7Gp/PVxtPFP04ypa478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538663; c=relaxed/simple;
	bh=S/LWxQwTqkvVjY27spi8XPjxed8P0WjgsxAUuc0By38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fX6aNIZ4uXkIluQcxj33ugslEHmZcnskyRbEz4pS788v0DdoYknDg9hIm2Pva2w63+Wxm4hW/49RDKNCfoPJ6AEvUgQOOdxOcJRNNNNPxxTIbHBXmewPVXutvsSPbLeLDBG/2G3EDII2Flzyzdb0aOK2H8hDgnUwF3mDuZsY/GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M+4I/rWV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso401603b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710538662; x=1711143462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u21mx/A0InX+jfUvXdgWsx7ujtb0nq15BM8VeCC2N2w=;
        b=M+4I/rWVitMgjJvBweePN+XLiA/uls9oc6I0/hQgoa76n6cVSfdx+NO4OyZTEQ2zNo
         eZGedtH1uMvWwLZYb1HV65kbIXsHjvS9yX9Gi3P20blULupMYz25U6480Wg9IK7GwLiQ
         ia4m9YKbC7Wy/90Nc1Fvw9RwL7fYNh6J9y8QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710538662; x=1711143462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u21mx/A0InX+jfUvXdgWsx7ujtb0nq15BM8VeCC2N2w=;
        b=mTBoyw3FQ5BLLfA7cH3Q/dALwS6CjtGNb/t3WFbB4hurf6w9tZSue+1dO0lFZIrpsY
         gHCTse+IXC0G4SeNFb2Oe9AMczkCZMaTj6HIAbnegPRlPTeV+I5HJV8g36hTdFJ+A9bW
         +2d/opAiChFDf7ajX3n0rP63ggzmiT9mL22VhUHl1lZuiJMWpEoHbQ00qE6Ou2Eetac9
         lJngef7M0nN36YQWOmdiuMK83NOCSzxSSCKK/eOi8AfIDu/hknaW6dJTx7MlgIEIBdF+
         x9ldF0lGfcdD5Ut9CBxgb4FnRTS54GJRN8P3Wsd+Up+sy3iOyxHFf0RlJSvoAVFVwq7z
         Tlyg==
X-Forwarded-Encrypted: i=1; AJvYcCUpBz8tRJ/1cmgsPtKg+lbb69K1W62t6iT+RCNId0OIx8h1ak+hXwwCCZy4eBuvmfr63jvaE+nn6CK9uyg5oa9hG8j833ztT6ewiAny
X-Gm-Message-State: AOJu0Yw2qfNku7hrEvYL90gojD4NL+NYsSDaQACEp9FGN8NRYS2g1+/I
	SaP8yJ2t/OJqzZMJY4Lwoo7sfDozMhUIREXaD+zkKvPxKf8xgGD/Mk1WM+UkUw==
X-Google-Smtp-Source: AGHT+IFHkJVolH5h+841qAYWFr1aVz8UmRYXrXeiD5DmDtlSomkKbIXgspiQa3PcR0RRjxQiW+T8Ew==
X-Received: by 2002:a05:6a20:7290:b0:1a3:539a:b23d with SMTP id o16-20020a056a20729000b001a3539ab23dmr1693119pzk.58.1710538661792;
        Fri, 15 Mar 2024 14:37:41 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:b23e:e8dc:3df4:aa2a])
        by smtp.gmail.com with ESMTPSA id a26-20020aa7865a000000b006e6b5e65579sm3837142pfo.106.2024.03.15.14.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 14:37:40 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sean Paul <sean@poorly.run>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] drm/msm/dp: Account for the timeout in wait_hpd_asserted() callback
Date: Fri, 15 Mar 2024 14:36:30 -0700
Message-ID: <20240315143621.v2.2.I7758d18a1773821fa39c034b16a12ef3f18a51ee@changeid>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240315213717.1411017-1-dianders@chromium.org>
References: <20240315213717.1411017-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DP wait_hpd_asserted() callback is passed a timeout which
indicates how long we should wait for HPD. This timeout was being
ignored in the MSM DP implementation and instead a hardcoded 500 ms
timeout was used. Fix it to use the proper timeout.

As part of this we move the hardcoded 500 ms number into the AUX
transfer function, which isn't given a timeout. The wait in the AUX
transfer function will be removed in a future commit.

Fixes: e2969ee30252 ("drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/msm/dp/dp_aux.c     | 5 +++--
 drivers/gpu/drm/msm/dp/dp_catalog.c | 7 ++++---
 drivers/gpu/drm/msm/dp/dp_catalog.h | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index e67a80d56948..75c51f3ee106 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -322,7 +322,8 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
 	 * avoid ever doing the extra long wait for DP.
 	 */
 	if (aux->is_edp) {
-		ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog);
+		ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog,
+								500000);
 		if (ret) {
 			DRM_DEBUG_DP("Panel not ready for aux transactions\n");
 			goto exit;
@@ -530,7 +531,7 @@ static int dp_wait_hpd_asserted(struct drm_dp_aux *dp_aux,
 	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
 
 	pm_runtime_get_sync(aux->dev);
-	ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog);
+	ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog, wait_us);
 	pm_runtime_put_sync(aux->dev);
 
 	return ret;
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 5142aeb705a4..944ccb74f06c 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -253,17 +253,18 @@ void dp_catalog_aux_update_cfg(struct dp_catalog *dp_catalog)
 	phy_calibrate(phy);
 }
 
-int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog *dp_catalog)
+int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog *dp_catalog,
+					      unsigned long wait_us)
 {
 	u32 state;
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 				struct dp_catalog_private, dp_catalog);
 
-	/* poll for hpd connected status every 2ms and timeout after 500ms */
+	/* poll for hpd connected status every 2ms and timeout after wait_us */
 	return readl_poll_timeout(catalog->io->dp_controller.aux.base +
 				REG_DP_DP_HPD_INT_STATUS,
 				state, state & DP_DP_HPD_STATE_STATUS_CONNECTED,
-				2000, 500000);
+				min(wait_us, 2000), wait_us);
 }
 
 static void dump_regs(void __iomem *base, int len)
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 38786e855b51..d116df1fc3ac 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -85,7 +85,8 @@ int dp_catalog_aux_clear_hw_interrupts(struct dp_catalog *dp_catalog);
 void dp_catalog_aux_reset(struct dp_catalog *dp_catalog);
 void dp_catalog_aux_enable(struct dp_catalog *dp_catalog, bool enable);
 void dp_catalog_aux_update_cfg(struct dp_catalog *dp_catalog);
-int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog *dp_catalog);
+int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog *dp_catalog,
+					      unsigned long wait_us);
 u32 dp_catalog_aux_get_irq(struct dp_catalog *dp_catalog);
 
 /* DP Controller APIs */
-- 
2.44.0.291.gc1ea87d7ee-goog


