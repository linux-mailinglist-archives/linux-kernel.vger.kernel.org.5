Return-Path: <linux-kernel+bounces-93175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4939872BDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7560B28A6C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5F1846B;
	Wed,  6 Mar 2024 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C9eZZF2i"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F46FAF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685834; cv=none; b=NZsSiKVpNOVwj1dhAgwVgYbSBK9mjqkzxAZtRZC7PBzGiKHmXoY/mTtzddDXuiBYeXqbZ/qNZNDmfrZFHl+85TMWbO3uxIO7j3OPoqfBCLno3mMTHpAyMoiitw8M1f9W6nSznFavCT3Qx8+6sZ9TOWjQgUiAJqMtB8MR9I26Xq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685834; c=relaxed/simple;
	bh=+gMAu/mH8Zbo9TI1zOpILsB3HJUn23XAjsmJee8sbgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY1Ris8zM2dDBEAOBmXWwBAgYlgZJqRgBlN05hrrR4RC81ppzu/tq0luO73rr8ILAqoALLEtxfnzEy0MK6Yz8i3RubhXdGAJSdMxnkMusJwcKjePY4Fb84zSg/Nqwm3rj5pq/ttRneuaHHqEIyNJ0+RekCdhPJS373sQeXKkfgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C9eZZF2i; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c1a2f7e302so3443816b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709685831; x=1710290631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwnVHHF+SAy7EA+lave/HwOmjTm+ySnhWai82DKOimc=;
        b=C9eZZF2iy1N33E7Zzza8p6Y8NX7HrESwhJnsSqCa6+wOXWJLhHKRbsGX6wmbfnUuAF
         pZRaeSwLp8gI4sfBP/lKAYgCnwBsL4YW777g0XFA2TIoRIl45k9ZIJMiwQssTa3pCPB+
         +lHGp7VMh2XOdhM8Ie+CxagN3trd4sLWCSjbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709685831; x=1710290631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwnVHHF+SAy7EA+lave/HwOmjTm+ySnhWai82DKOimc=;
        b=n89lfDqcrFyt/prqQanI5mi2IlxoDzcSt332Ju+pa7Tl/xiG5ZKL4PlX9VY+3u9AL1
         evQkNblsu7qDXP7as0oZ4uHSWeF+ybT5XGtTM4+E2MtqyAERNYHBxSCEhzzCml/aRx0B
         pdBrBp4j60BKwsJg+wU0mWu26IU9vtFwB9pwkksi12kFIU8aJ3iyqkqQ1T0QBuiOQBr3
         Q2S2J1HBAX7t3q2zmQAaDLh4A6f8ecKhNZcbnNTC/frDruNroloFF+zHEqQYDAtux+Va
         GnAUWc+Tgp/lM36kp70T8psArA5q89roktLpznY35uXc9Zq78k06kz4ccGcaXSARFsTa
         lztg==
X-Forwarded-Encrypted: i=1; AJvYcCU0+LOC9Ew3uzJH1cQIE40V65xn+EebETa4946v4Dy6ivJ5a3RPgXlMZ+BZUYzSvRorCdEjiJixxWE7KscwKEfSoPt4Nc0tEMQS0FO7
X-Gm-Message-State: AOJu0YzzTUcEfPKJMW7h/WHzcbH+kvR34DKvdnViQZTwCB6bTc7SO6sY
	+hrVimGzcXj4MkxLE2uuI+OeVsVocE5MVqLXkyQ9zL84n/fls2xi+3nJ2rtr0g==
X-Google-Smtp-Source: AGHT+IEohVRqWaXH8EBXFArEg9r3SrVjJiR1PWflATvQ2Oat0xAfK/zbvZ2qASv1MelHpAUDLJQEZg==
X-Received: by 2002:a05:6808:4286:b0:3c1:f46c:d796 with SMTP id dq6-20020a056808428600b003c1f46cd796mr3054966oib.34.1709685831519;
        Tue, 05 Mar 2024 16:43:51 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:29bc:b3d:1ba8:cf52])
        by smtp.gmail.com with ESMTPSA id x37-20020a631725000000b005dc48e56191sm8512885pgl.11.2024.03.05.16.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 16:43:51 -0800 (PST)
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
Subject: [PATCH v4 1/5] drm_edid: Add a function to get EDID base block
Date: Tue,  5 Mar 2024 16:34:01 -0800
Message-ID: <20240306004347.974304-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240306004347.974304-1-hsinyi@chromium.org>
References: <20240306004347.974304-1-hsinyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's found that some panels have variants that they share the same panel id
although their EDID and names are different. Besides panel id, now we need
more information from the EDID base block to distinguish these panel
variants.

Add drm_edid_read_base_block() to return the EDID base block, which is
wrapped in struct drm_edid.

Caller can further use it to get panel id or check if the block contains
certain strings, such as panel name.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v3->v4: change drm_edid_read_base_block return type to drm_edid.
---
 drivers/gpu/drm/drm_edid.c        | 63 +++++++++++++++++++------------
 drivers/gpu/drm/panel/panel-edp.c |  8 +++-
 include/drm/drm_edid.h            |  3 +-
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 923c4423151c..f9e09f327f81 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2770,58 +2770,71 @@ static u32 edid_extract_panel_id(const struct edid *edid)
 }
 
 /**
- * drm_edid_get_panel_id - Get a panel's ID through DDC
- * @adapter: I2C adapter to use for DDC
+ * drm_edid_get_panel_id - Get a panel's ID from EDID
+ * @drm_edid: EDID that contains panel ID.
  *
- * This function reads the first block of the EDID of a panel and (assuming
+ * This function uses the first block of the EDID of a panel and (assuming
  * that the EDID is valid) extracts the ID out of it. The ID is a 32-bit value
  * (16 bits of manufacturer ID and 16 bits of per-manufacturer ID) that's
  * supposed to be different for each different modem of panel.
  *
+ * Return: A 32-bit ID that should be different for each make/model of panel.
+ *         See the functions drm_edid_encode_panel_id() and
+ *         drm_edid_decode_panel_id() for some details on the structure of this
+ *         ID.
+ */
+u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid)
+{
+	return edid_extract_panel_id(drm_edid->edid);
+}
+EXPORT_SYMBOL(drm_edid_get_panel_id);
+
+/**
+ * drm_edid_read_base_block - Get a panel's EDID base block
+ * @adapter: I2C adapter to use for DDC
+ *
+ * This function returns the drm_edid containing the first block of the EDID of
+ * a panel.
+ *
  * This function is intended to be used during early probing on devices where
  * more than one panel might be present. Because of its intended use it must
- * assume that the EDID of the panel is correct, at least as far as the ID
- * is concerned (in other words, we don't process any overrides here).
+ * assume that the EDID of the panel is correct, at least as far as the base
+ * block is concerned (in other words, we don't process any overrides here).
+ *
+ * Caller should call drm_edid_free() after use.
  *
  * NOTE: it's expected that this function and drm_do_get_edid() will both
  * be read the EDID, but there is no caching between them. Since we're only
  * reading the first block, hopefully this extra overhead won't be too big.
  *
- * Return: A 32-bit ID that should be different for each make/model of panel.
- *         See the functions drm_edid_encode_panel_id() and
- *         drm_edid_decode_panel_id() for some details on the structure of this
- *         ID.
+ * WARNING: Only use this function when the connector is unknown. For example,
+ * during the early probe of panel. The EDID read from the function is temporary
+ * and should be replaced by the full EDID returned from other drm_edid_read.
+ *
+ * Return: Pointer to allocated EDID base block, or NULL on any failure.
  */
-
-u32 drm_edid_get_panel_id(struct i2c_adapter *adapter)
+const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter *adapter)
 {
 	enum edid_block_status status;
 	void *base_block;
-	u32 panel_id = 0;
-
-	/*
-	 * There are no manufacturer IDs of 0, so if there is a problem reading
-	 * the EDID then we'll just return 0.
-	 */
 
 	base_block = kzalloc(EDID_LENGTH, GFP_KERNEL);
 	if (!base_block)
-		return 0;
+		return NULL;
 
 	status = edid_block_read(base_block, 0, drm_do_probe_ddc_edid, adapter);
 
 	edid_block_status_print(status, base_block, 0);
 
-	if (edid_block_status_valid(status, edid_block_tag(base_block)))
-		panel_id = edid_extract_panel_id(base_block);
-	else
+	if (!edid_block_status_valid(status, edid_block_tag(base_block))) {
 		edid_block_dump(KERN_NOTICE, base_block, 0);
+		kfree(base_block);
+		return NULL;
+	}
 
-	kfree(base_block);
-
-	return panel_id;
+	return drm_edid_alloc(base_block, EDID_LENGTH);
 }
-EXPORT_SYMBOL(drm_edid_get_panel_id);
+EXPORT_SYMBOL(drm_edid_read_base_block);
 
 /**
  * drm_get_edid_switcheroo - get EDID data for a vga_switcheroo output
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 745f3e48f02a..d094cfc43da8 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -766,6 +766,7 @@ static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
 static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 {
 	struct panel_desc *desc;
+	const struct drm_edid *base_block;
 	u32 panel_id;
 	char vend[4];
 	u16 product_id;
@@ -795,8 +796,11 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 		goto exit;
 	}
 
-	panel_id = drm_edid_get_panel_id(panel->ddc);
-	if (!panel_id) {
+	base_block = drm_edid_read_base_block(panel->ddc);
+	if (base_block) {
+		panel_id = drm_edid_get_panel_id(base_block);
+		drm_edid_free(base_block);
+	} else {
 		dev_err(dev, "Couldn't identify panel via EDID\n");
 		ret = -EIO;
 		goto exit;
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 7923bc00dc7a..9686a7cee6a6 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -410,7 +410,8 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
 	void *data);
 struct edid *drm_get_edid(struct drm_connector *connector,
 			  struct i2c_adapter *adapter);
-u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
+const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter *adapter);
+u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid);
 struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
 				     struct i2c_adapter *adapter);
 struct edid *drm_edid_duplicate(const struct edid *edid);
-- 
2.44.0.278.ge034bb2e1d-goog


