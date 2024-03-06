Return-Path: <linux-kernel+bounces-94532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECCF874119
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5B91F24DD0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C7144053;
	Wed,  6 Mar 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dld9EuqG"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FE143C6C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755443; cv=none; b=AyM7YzK3FoZcoSC/Jvy5lQJcPfSZiDJS1TjrO7XAlKC1/IFw1B8fRqVlptQ/VEK4K+IqWGZHVUmSbafko6VnFM4Ji+eFjzDKUAnjMcAcXdSM/2hNV+XwLH3LgFPMWTwWztFpPnn1SelCjidnOc3rLmcBNTkWob5AKcQeETMteqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755443; c=relaxed/simple;
	bh=YnbFyUg19IyC4NGlQHUfGlIjWONpLIgFxHpFqJtP19A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uelPhWyT3nJ8MA0Hf72PqwAJITO7PKq0bhdzXsv0r84MD/WD53Sx5ai6flnJc+g815l5Wxmy3gQe5fXfM3skkfEGjK4liWDVSNtR0b+wrg/RhH6kkwM5K4uTwQYlwwOBc4s/3TFYUhqnAagMciRha4MbY0qxMFzmBw02cvAp2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dld9EuqG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e622b46f45so97471b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709755441; x=1710360241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CE2sNS/vxOPb5cf5bC+myjwShUIoD0EfwdnD7Qy1Os=;
        b=dld9EuqG0dwtisitmT/BUAykAtkuPJJLVAvmptVB5hwrB4Bjo3nTBvTj7kuyR/Lknd
         2apEF27+aVMq3b9LIGUUCr0EXvRhu8Odr3lTXcPGfexQ7It0qk3pTht8lwvLUyKs0bS0
         oi1tiJvL7zNOC4YLL/0rLHnXl4kUVm1nGA/j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755441; x=1710360241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CE2sNS/vxOPb5cf5bC+myjwShUIoD0EfwdnD7Qy1Os=;
        b=Bv62RlAvwRq6YD798FkMcOepi2rvSdKv+38NVXtB2tzf/EsMVkqcqYq8W/kbGtlPsd
         sDNVY+jvsAGWWSb/Uv0+PqmxFLbKRBOXTo+DxFqNEKjZl2dwr+fw9xbbbx1fATJAtyDF
         o4+G9o5zngILFNYHGRydiOGLxNGnrn6D7oyt5fFrKdrCGGZmMmYYsDboZRX5dFpDOrm+
         g8IQfV+Ael9HaQ/3pCBFC271tq5XuqCP33TKpmJKVUc0UuxA5hx2m8R3LjeLuiQBZWD9
         y51ADGWghGaMwTCcNlyS229EQMMzQE0eTIU++t+vxKtqdN5wAs5hcxp4ur9UkU4YZ1cZ
         slZg==
X-Forwarded-Encrypted: i=1; AJvYcCW5rokb1try04DQGLWfRfv683s3L7DMXLq4Spl+4z+bT0pVtcIwid65P8uNWj4iwPgDTfrIZ9dxS/MKMCb2ueVLDBn2w3GwR0ZQ8pfR
X-Gm-Message-State: AOJu0YxSQ3IKPVmYlZfguCd6sE/md02WMcy4VKlrwuE7Lzz7KUWK18gj
	/QSJ5qmIwdWut8h7Q5GqH8p5Oa+nDXfeWkaJ/chlOGM2AISyyLuJWpSqYrstYg==
X-Google-Smtp-Source: AGHT+IETZdUaUGspqsCyXd6rJT/N5p6jaVTBU5cNKikpauZE+EH7NLX+lSXVUp6nj8dsq6Y/lQsAUw==
X-Received: by 2002:a05:6a20:a104:b0:1a1:6f1b:a86a with SMTP id q4-20020a056a20a10400b001a16f1ba86amr126518pzk.28.1709755440790;
        Wed, 06 Mar 2024 12:04:00 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:a215:f6c0:3224:5460])
        by smtp.gmail.com with ESMTPSA id e3-20020aa79803000000b006e5667793d4sm11124241pfl.66.2024.03.06.12.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:04:00 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
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
Subject: [PATCH v5 5/6] drm/panel-edp: Match edp_panels with panel identity
Date: Wed,  6 Mar 2024 11:55:55 -0800
Message-ID: <20240306200353.1436198-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240306200353.1436198-1-hsinyi@chromium.org>
References: <20240306200353.1436198-1-hsinyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's found that some panels have variants that they share the same panel id
although their EDID and names are different. When matching generic edp
panels, we should first match with both panel identity, which contains both
panel id and panel name. If not found, match with panel id only.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v5: no change
---
 drivers/gpu/drm/panel/panel-edp.c | 45 ++++++++++++++++---------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index fe51680feb61..772bf6011d79 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -210,15 +210,12 @@ struct panel_desc {
  * struct edp_panel_entry - Maps panel ID to delay / panel name.
  */
 struct edp_panel_entry {
-	/** @panel_id: 32-bit ID for panel, encoded with drm_edid_encode_panel_id(). */
-	u32 panel_id;
+	/** @ident: edid identity used for panel matching. */
+	const struct drm_edid_ident ident;
 
 	/** @delay: The power sequencing delays needed for this panel. */
 	const struct panel_delay *delay;
 
-	/** @name: Name of this panel (for printing to logs). */
-	const char *name;
-
 	/** @override_edid_mode: Override the mode obtained by edid. */
 	const struct drm_display_mode *override_edid_mode;
 };
@@ -691,7 +688,7 @@ static int detected_panel_show(struct seq_file *s, void *data)
 	else if (!p->detected_panel)
 		seq_puts(s, "HARDCODED\n");
 	else
-		seq_printf(s, "%s\n", p->detected_panel->name);
+		seq_printf(s, "%s\n", p->detected_panel->ident.name);
 
 	return 0;
 }
@@ -761,7 +758,7 @@ static void panel_edp_parse_panel_timing_node(struct device *dev,
 		dev_err(dev, "Reject override mode: No display_timing found\n");
 }
 
-static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
+static const struct edp_panel_entry *find_edp_panel(u32 panel_id, const struct drm_edid *edid);
 
 static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 {
@@ -799,7 +796,6 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	base_block = drm_edid_read_base_block(panel->ddc);
 	if (base_block) {
 		panel_id = drm_edid_get_panel_id(base_block);
-		drm_edid_free(base_block);
 	} else {
 		dev_err(dev, "Couldn't identify panel via EDID\n");
 		ret = -EIO;
@@ -807,7 +803,9 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	}
 	drm_edid_decode_panel_id(panel_id, vend, &product_id);
 
-	panel->detected_panel = find_edp_panel(panel_id);
+	panel->detected_panel = find_edp_panel(panel_id, base_block);
+
+	drm_edid_free(base_block);
 
 	/*
 	 * We're using non-optimized timings and want it really obvious that
@@ -840,7 +838,7 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 		panel->detected_panel = ERR_PTR(-EINVAL);
 	} else {
 		dev_info(dev, "Detected %s %s (%#06x)\n",
-			 vend, panel->detected_panel->name, product_id);
+			 vend, panel->detected_panel->ident.name, product_id);
 
 		/* Update the delay; everything else comes from EDID */
 		desc->delay = *panel->detected_panel->delay;
@@ -1954,17 +1952,21 @@ static const struct panel_delay delay_200_500_e50_po2e200 = {
 
 #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
 { \
-	.name = _name, \
-	.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
-					     product_id), \
+	.ident = { \
+		.name = _name, \
+		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
+						     product_id), \
+	}, \
 	.delay = _delay \
 }
 
 #define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name, _mode) \
 { \
-	.name = _name, \
-	.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
-					     product_id), \
+	.ident = { \
+		.name = _name, \
+		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
+						     product_id), \
+	}, \
 	.delay = _delay, \
 	.override_edid_mode = _mode \
 }
@@ -2111,15 +2113,16 @@ static const struct edp_panel_entry edp_panels[] = {
 	{ /* sentinal */ }
 };
 
-static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
+static const struct edp_panel_entry *find_edp_panel(u32 panel_id, const struct drm_edid *edid)
 {
 	const struct edp_panel_entry *panel;
 
-	if (!panel_id)
-		return NULL;
+	for (panel = edp_panels; panel->ident.panel_id; panel++)
+		if (drm_edid_match(edid, &panel->ident))
+			return panel;
 
-	for (panel = edp_panels; panel->panel_id; panel++)
-		if (panel->panel_id == panel_id)
+	for (panel = edp_panels; panel->ident.panel_id; panel++)
+		if (panel->ident.panel_id == panel_id)
 			return panel;
 
 	return NULL;
-- 
2.44.0.278.ge034bb2e1d-goog


