Return-Path: <linux-kernel+bounces-91193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD3870B0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCA1284625
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB637B3EA;
	Mon,  4 Mar 2024 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QyYHGNnW"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8787A159
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581942; cv=none; b=C584+RnVrhC1tOW6KwLl+F+JQ/QlMs1H6zjkz0FeNg94u1UtQrDQIvTivbaSkwIG3DD6vDh1070gADYYcv5VELVQh2xfuHRPustBdChXAX7ijkxTFXdsWlQFdH7Dxn243K8KRLSKy+ReTCIW/HePCuaDsGwgJY51B0hiWkQgdH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581942; c=relaxed/simple;
	bh=WlQfA5jIaBJNeWgdErSeeR3iEfBYv5DAdJelAVtiK9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8y0UvdU15tBQz2weylaDS5Wa03bKhY+IvkANjKFqMuv4iDKAw4mPIms4m1JK3kQ/5ce/NhdzQtgIZTa62mr0kmXfhsavc/jYTGlckt9eplJFknwqy3zyhirZm7ar6boTXXRODPcz/pFFTevFvkOB/nJflt2Xsv7vFLoMGKLtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QyYHGNnW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso3330727b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 11:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709581940; x=1710186740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3Jp14BDf8QPEEvMzAymcf9k4zD9ixOAGCQ7prLq3JA=;
        b=QyYHGNnW77pMlUltIkgFoG+DH8Er80KLGyz8og77cZpOsq/CBJOyWqcYrYC5y/8kPI
         v3pu5GtCAH/k8JizCUE4bGJf7O9ng27wv9tbQ1tQRMvaJCL9O2TeMTAGVTUTm66KOR6u
         p3RhppDQ/ZG79o+qspvRV5mlBU++jbBXTe/+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581940; x=1710186740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3Jp14BDf8QPEEvMzAymcf9k4zD9ixOAGCQ7prLq3JA=;
        b=u9iDOsrrhEJUdhOrH39g7iI4opU/V8Pl+9epQcBndVBmWMHMqwkdCfYDo/pLVGzM6C
         w6nO0wmMzknqX7e6ZdVshDyot/G1Gnfy3dV6DNg1UmECfOyvTePHY0hrNvui2wRZPSke
         /KLwz3QVbFIwt2LnwNyDFnRvFK9/xfJddTmVf9MnDccjSAEyfN/jhxBVpTuL7VHIfH7L
         emg3SGD32HdsB40sDiR/efh9P7At+9KOF2g/MBPvbTPZBxlJvxDUOTJ7T9NEU4mAklqh
         W/Oh5xnsLNGmKunFQedqtyXAeLykgfcxkyqYccNZKDaQ3fZsZ2ghZURDv9hCFnsLZCde
         blvg==
X-Forwarded-Encrypted: i=1; AJvYcCV8sDfJsyK/IRuBGxfNhJOQvOdBn0SJA4erzg3TXELK7kPjiC/X0/DSEFyGVmkMCdm3ODaxqkfrkdQLS8adwkdq1nbgAWLt96kdEqFa
X-Gm-Message-State: AOJu0YxKm2EgpU48MH5EZw0oVOghIRukxuNUKzUcxMN7fcSiQhuXItEK
	TwLDjP/HuHM5C5Xo+xIxuTU/BS7gyyi4wehCk/NtQ4TSR6u7AxwPTFANAxw6fA==
X-Google-Smtp-Source: AGHT+IHK/PazsA/rAq12BUCaXQt6do7doHeEYNnPIuOEBjQwpxHmb2OW8AC1Tseh0xuGhFovu2zIEA==
X-Received: by 2002:a05:6a00:18a8:b0:6e6:21b3:cf2 with SMTP id x40-20020a056a0018a800b006e621b30cf2mr4672758pfh.8.1709581940519;
        Mon, 04 Mar 2024 11:52:20 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:bcf3:25da:25cd:199])
        by smtp.gmail.com with ESMTPSA id r27-20020aa7845b000000b006e04d2be954sm7600820pfn.187.2024.03.04.11.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:52:20 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] drm/panel: panel-edp: Match edp_panels with panel name
Date: Mon,  4 Mar 2024 11:44:58 -0800
Message-ID: <20240304195214.14563-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240304195214.14563-1-hsinyi@chromium.org>
References: <20240304195214.14563-1-hsinyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's found that some panels have variants that they share the same panel id
although their EDID and names are different. When matching generic edp
panels, we should first match with both panel id and panel name by checking
if edid contains the name string. If not found, match with panel id only.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2->v3: move string matching to drm_edid
---
 drivers/gpu/drm/panel/panel-edp.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index fc2d648fd3ab..e3044e34c5f8 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -761,7 +761,8 @@ static void panel_edp_parse_panel_timing_node(struct device *dev,
 		dev_err(dev, "Reject override mode: No display_timing found\n");
 }
 
-static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
+static const struct edp_panel_entry *find_edp_panel(u32 panel_id,
+						    struct edid_base_block *base_block);
 
 static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 {
@@ -799,7 +800,6 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	base_block = drm_edid_get_base_block(panel->ddc);
 	if (base_block) {
 		panel_id = drm_edid_get_panel_id(base_block);
-		kfree(base_block);
 	} else {
 		dev_err(dev, "Couldn't identify panel via EDID\n");
 		ret = -EIO;
@@ -807,7 +807,9 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	}
 	drm_edid_decode_panel_id(panel_id, vend, &product_id);
 
-	panel->detected_panel = find_edp_panel(panel_id);
+	panel->detected_panel = find_edp_panel(panel_id, base_block);
+
+	kfree(base_block);
 
 	/*
 	 * We're using non-optimized timings and want it really obvious that
@@ -2087,13 +2089,18 @@ static const struct edp_panel_entry edp_panels[] = {
 	{ /* sentinal */ }
 };
 
-static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
+static const struct edp_panel_entry *find_edp_panel(u32 panel_id,
+						    struct edid_base_block *base_block)
 {
 	const struct edp_panel_entry *panel;
 
-	if (!panel_id)
-		return NULL;
+	 /* Match with both panel_id and name */
+	for (panel = edp_panels; panel->panel_id; panel++)
+		if (panel->panel_id == panel_id &&
+		    drm_edid_has_monitor_string(base_block, panel->name))
+			return panel;
 
+	/* Match with only panel_id */
 	for (panel = edp_panels; panel->panel_id; panel++)
 		if (panel->panel_id == panel_id)
 			return panel;
-- 
2.44.0.rc1.240.g4c46232300-goog


