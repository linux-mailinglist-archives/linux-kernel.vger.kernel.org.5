Return-Path: <linux-kernel+bounces-94528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F797874114
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B96F1F24C40
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546ED143C44;
	Wed,  6 Mar 2024 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FaHIL/fV"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0127142630
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755439; cv=none; b=AgLFv8qjmXW1jRNuuK01JgxAjOIgtIM15weucG9MQaWQeqtVJ8G7CkSLksgTYjHKRLq6gP4Im7UBbYN2cOPqMdolWlF87D/4leEcxoQqwjVULG7tUh2PUVbY/Yj5yDVrxwAydDrFVFfx8Nfi0kq0zeI07s1QgHpvt5edK98+gzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755439; c=relaxed/simple;
	bh=v5m0xZ0V86aaMgnmonnHS6h2Id+Nb5Lp0MUuhAkv1nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1kxmyE+Z/vr1AXvN3KjXHP4EWyST+B5GDLygsKQC4PtqEid/wDDDNtjUleazitTghtBn/oN7ze2VpVx4gi26EX7O4aH1fomf9yvqdQaenlioQjQL4TIV7GCAdFXQTtvoGDlpkI39OQWZF5/SxVojFfwm48iCiTfqCWAWEKQ97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FaHIL/fV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e57a3bf411so95604b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709755437; x=1710360237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TO8narEInEW2sevq0mocA7Cmq1HqvsvqWDqWB03ZgLw=;
        b=FaHIL/fVPhIVZWBeg2PtvdjC48KJW3+3Xo4rfgqNb6JdVR28kydfZQkLlX7S/fvvGg
         JmJsUR98h7VHs8SbWWLL+p1vz02jVMnf5j2TsnURgNkT0SwoWmhRTP1enDfJ6G87mHei
         LfPBFALsyKU+5PBt3ch1NqjVlDu3Zrm5p+fKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755437; x=1710360237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO8narEInEW2sevq0mocA7Cmq1HqvsvqWDqWB03ZgLw=;
        b=Dq7etWQs/YOgpnLdFDDoe8OmmSIw5KDVlhpka5hfW/1YhgDYB8bp16C2iIEjuhS7m9
         qCnqOmtvuomGghrux7Iai3S2gscEPKMPDCACJQ2YI8YaG1Oh7MuL/D8r4dRffF6e+lU+
         OWGN5rzGedzzBWuyfr6YIYhyK0uuwU0yeATisevIPBoA6/uM5NcIsupInnJdt83jPbO1
         3CRySWgAXferRcEzMlAXbEb+ARXhoRxv91JX//8QfK7sfKAQyQiGV8ND03b1PoqZBNTR
         kH675B67mCyHAXGD96ZMSKYBEqwnlnIdKEGgw/COlr8+IoG1Kn/DZDO680MZEZ1LRijp
         QhBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeI4zU0AXVaSKCb377qYl4fhp9Sln2JwdWsH3SNAeCyJvGGriWeaP9uk0gPQ0p+cKD7lj1pOB+8HrIBce1UvoI1tWKlruscGq3tTg+
X-Gm-Message-State: AOJu0Yy/3AKMdZEYaTsb+DWFWNjTjT9NmuasJS4uiI/IecncFdmEGmg5
	FhNTyIf0sbUUSDnKxTXvZyrgP6oigCmxnnYZmrZJZeV7LdL+iVWbayNI4YfDMg==
X-Google-Smtp-Source: AGHT+IFaWxLfmbk2letB3HSWHPl2i/aon3QJrVq0CuAm8X0TzZjoFsVZYJU8YOQj3s4ApQg/9FzYNQ==
X-Received: by 2002:a05:6a20:7f99:b0:1a1:49be:c81d with SMTP id d25-20020a056a207f9900b001a149bec81dmr6833171pzj.33.1709755437070;
        Wed, 06 Mar 2024 12:03:57 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:a215:f6c0:3224:5460])
        by smtp.gmail.com with ESMTPSA id e3-20020aa79803000000b006e5667793d4sm11124241pfl.66.2024.03.06.12.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:03:56 -0800 (PST)
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
Subject: [PATCH v5 1/6] drm_edid: Add a function to get EDID base block
Date: Wed,  6 Mar 2024 11:55:51 -0800
Message-ID: <20240306200353.1436198-2-hsinyi@chromium.org>
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
although their EDID and names are different. Besides panel id, now we need
more information from the EDID base block to distinguish these panel
variants.

Add drm_edid_read_base_block() to return the EDID base block, which is
wrapped in struct drm_edid.

Caller can further use it to get panel id or check if the block contains
certain strings, such as panel name.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v4->v5: use _drm_edid_alloc
---
 drivers/gpu/drm/drm_edid.c        | 63 +++++++++++++++++++------------
 drivers/gpu/drm/panel/panel-edp.c |  8 +++-
 include/drm/drm_edid.h            |  3 +-
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 1ad94473e400..8c7e871eff58 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2764,58 +2764,71 @@ static u32 edid_extract_panel_id(const struct edid *edid)
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
+	return _drm_edid_alloc(base_block, EDID_LENGTH);
 }
-EXPORT_SYMBOL(drm_edid_get_panel_id);
+EXPORT_SYMBOL(drm_edid_read_base_block);
 
 /**
  * drm_get_edid_switcheroo - get EDID data for a vga_switcheroo output
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3fb5fcd326a4..fe51680feb61 100644
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
index 70ae6c290bdc..8b233865b085 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -565,7 +565,8 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
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


