Return-Path: <linux-kernel+bounces-79274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5E861FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39652286CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0802E14CACB;
	Fri, 23 Feb 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MriA/p38"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B5145B1B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728006; cv=none; b=JmbGrA0/9cNKL24f2b1NYETVWboQRekYoPzNTWnAFrZBWQcSN/uuyFNQJ2RT5q7TGt4OOa2kkMZRozLe3SngWaA3n4/4E+FEH29vxnj9hJEyrAONi4Dvx6O3iKpXlXhFAyvLJowUNl+EBwo1WGzd0WEkojYe3PSFVDkdXltU1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728006; c=relaxed/simple;
	bh=Pjl8ko0DWDowcGUxGWXv4KdIPeEjmRIMNi+B2vSNeiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8miZBrT9GI1pVZv5oURBHRE8YfVTf0XfLkO1s8lv6EQ0P2e3fNB5SN/GNq+8aPfgNFcgubCGjbEeQc6tR/sl6qwwpRgEKEtkrlAymaNerKup7u46rFX7RcEFEeunO6AOrJRhIVq4FjjT4ZF/8U1dfrwN6onRE+xzkRcO12g8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MriA/p38; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29a2d0f69a6so1016132a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708728004; x=1709332804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtJto2Kd/SieW6LbOckqb66w6924YRC023lFGaAJu7I=;
        b=MriA/p38et10AfvSKffP3yy21UKPkzln1pQrU+V9qBRGzuXuMiFIAyVhAMSOMmrO4T
         6ZSM09OJi5OBR9MHGa+Gjsb3SpaGyTE7yIj8YqCH4kXw8jUQVNiUyO2lM0Te4A7V0/nU
         dcHizdcjjM9pGYEY3RQa4+/+jUEe058lapUHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708728004; x=1709332804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtJto2Kd/SieW6LbOckqb66w6924YRC023lFGaAJu7I=;
        b=iBwv005lqSTNrGWK31/sIjUej+g5U8OsvQuQe2f7e/L856IijQS2sA4ikl6teABdRB
         NKvw2ED5RBL6EkQmwpcD125uNCFWNY19VR5iNq2AsbQH1hWKXmyHY4KLLYPdKC4lcib+
         aDpv6kFUiY2CCiI6x/T4pv93pab14cEGjpYpLH6EcHb4fEMoYaWcCqADcO3SKYKAS215
         HIm/vfWImUkTw/vNVPm5AcLpqqZabFBoAWi2rwh3nJYKp/8g3/diTM2xu/YtD53rYdum
         k+n5w3Rw7VzcZyXkyn+NAngPARFzyfi+CSd+HV9ENRN54JTzJMXxsEaMuHF7z6cATGYu
         uAcg==
X-Forwarded-Encrypted: i=1; AJvYcCUKlHUltXpWBUlvYT+4eD4HA+qliNbiEvfx9m7PAar7uf5OjIVaKKI7QLPpV3xQaZXcduo/P21cBZR34g6rxPJA9p/hXYynZMF1/tOQ
X-Gm-Message-State: AOJu0YyBZsin1cw9hsJ/OYe1EuSHvM4P1FScAUKJK8Cfk/fm6Cnueh87
	r/9KcLsAeuEGr8T7A8RNybsPYEHXkDqFW5l6G9k53HqiqvRuGldXfYu6unUhfA==
X-Google-Smtp-Source: AGHT+IEVPk3T/BcnGztFSXqnNC//o637SLCFJjp4OfpRUNvGShjjo4L/qCoxs5rN+qfxLlvAOkyQ8A==
X-Received: by 2002:a17:90b:4f4a:b0:299:96fe:1135 with SMTP id pj10-20020a17090b4f4a00b0029996fe1135mr997780pjb.44.1708728004586;
        Fri, 23 Feb 2024 14:40:04 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:8ff9:a089:c05c:9af])
        by smtp.gmail.com with ESMTPSA id cz4-20020a17090ad44400b002966a13f2e9sm2032873pjb.37.2024.02.23.14.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 14:40:04 -0800 (PST)
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
Subject: [PATCH 2/2] drm/panel: panel-edp: Match with panel hash for overridden modes
Date: Fri, 23 Feb 2024 14:29:18 -0800
Message-ID: <20240223223958.3887423-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240223223958.3887423-1-hsinyi@chromium.org>
References: <20240223223958.3887423-1-hsinyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's found that some panels have variants that they share the same panel id
although their EDID and names are different. One of the variants requires
using overridden modes to resolve glitching issue as described in commit
70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode"). Other variants should
use the modes parsed from EDID.

For example, AUO 0x405c B116XAK01.0, it has at least 2 different variants
that EDID and panel name are different, but using the same panel id. One of
the variants require using overridden mode. Same case for AUO 0x615c
B116XAN06.1.

Add such entries and use the hash of the EDID to match the panel needs the
overridden modes.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 52 +++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f6ddbaa103b5..42c430036846 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -21,6 +21,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/crc32.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -213,6 +214,9 @@ struct edp_panel_entry {
 	/** @panel_id: 32-bit ID for panel, encoded with drm_edid_encode_panel_id(). */
 	u32 panel_id;
 
+	/** @panel_hash: the CRC32 hash of the EDID base block. */
+	u32 panel_hash;
+
 	/** @delay: The power sequencing delays needed for this panel. */
 	const struct panel_delay *delay;
 
@@ -758,13 +762,13 @@ static void panel_edp_parse_panel_timing_node(struct device *dev,
 		dev_err(dev, "Reject override mode: No display_timing found\n");
 }
 
-static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
+static const struct edp_panel_entry *find_edp_panel(u32 panel_id, u32 panel_hash);
 
 static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 {
 	struct panel_desc *desc;
 	void *base_block;
-	u32 panel_id;
+	u32 panel_id, panel_hash;
 	char vend[4];
 	u16 product_id;
 	u32 reliable_ms = 0;
@@ -796,15 +800,17 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	base_block = drm_edid_get_base_block(panel->ddc);
 	if (base_block) {
 		panel_id = drm_edid_get_panel_id(base_block);
+		panel_hash = crc32_le(~0, base_block, EDID_LENGTH) ^ 0xffffffff;
 		kfree(base_block);
 	} else {
 		dev_err(dev, "Couldn't identify panel via EDID\n");
 		ret = -EIO;
 		goto exit;
 	}
+
 	drm_edid_decode_panel_id(panel_id, vend, &product_id);
 
-	panel->detected_panel = find_edp_panel(panel_id);
+	panel->detected_panel = find_edp_panel(panel_id, panel_hash);
 
 	/*
 	 * We're using non-optimized timings and want it really obvious that
@@ -1006,6 +1012,19 @@ static const struct panel_desc auo_b101ean01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b116xa3_mode = {
+	.clock = 70589,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 40,
+	.hsync_end = 1366 + 40 + 40,
+	.htotal = 1366 + 40 + 40 + 32,
+	.vdisplay = 768,
+	.vsync_start = 768 + 10,
+	.vsync_end = 768 + 10 + 12,
+	.vtotal = 768 + 10 + 12 + 6,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
 static const struct drm_display_mode auo_b116xak01_mode = {
 	.clock = 69300,
 	.hdisplay = 1366,
@@ -1926,11 +1945,13 @@ static const struct panel_delay delay_200_500_e50_po2e200 = {
 	.delay = _delay \
 }
 
-#define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name, _mode) \
+#define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_id, \
+			 _hash, _delay, _name, _mode) \
 { \
 	.name = _name, \
 	.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
 					     product_id), \
+	.panel_hash = _hash, \
 	.delay = _delay, \
 	.override_edid_mode = _mode \
 }
@@ -2077,13 +2098,32 @@ static const struct edp_panel_entry edp_panels[] = {
 	{ /* sentinal */ }
 };
 
-static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
+/*
+ * Similar to edp_panels, this table lists panel variants that require using
+ * overridden modes but have the same panel id as one of the entries in edp_panels.
+ *
+ * Sort first by vendor, then by product ID.
+ */
+static const struct edp_panel_entry edp_panels_variants[] = {
+	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, 0xa9951478, &auo_b116xak01.delay,
+			 "B116XAK01.0", &auo_b116xa3_mode),
+	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x615c, 0x109b75b3, &delay_200_500_e50,
+			 "B116XAN06.1", &auo_b116xa3_mode),
+
+	{ /* sentinal */ }
+};
+
+static const struct edp_panel_entry *find_edp_panel(u32 panel_id, u32 panel_hash)
 {
 	const struct edp_panel_entry *panel;
 
-	if (!panel_id)
+	if (!panel_id || !panel_hash)
 		return NULL;
 
+	for (panel = edp_panels_variants; panel->panel_id; panel++)
+		if (panel->panel_id == panel_id && panel->panel_hash == panel_hash)
+			return panel;
+
 	for (panel = edp_panels; panel->panel_id; panel++)
 		if (panel->panel_id == panel_id)
 			return panel;
-- 
2.44.0.rc0.258.g7320e95886-goog


