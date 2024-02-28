Return-Path: <linux-kernel+bounces-84307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F71B86A4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D5F28AD6F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC914F6C;
	Wed, 28 Feb 2024 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wp5cOO8S"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5424400
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082702; cv=none; b=ijyMDAOXgPJJ+xHTrGGfi+wKPwblQtLx5/gJdxU7jm73/1SOeNmKMWiR2h2f58H/JNCDp058s0yswN29ShsNuvWK5OnRZi1TliROALaTNvH8RAzsN6HYttO6n2ZXiLnM8ODMgczr0Ni4Xw5cjb00KARvqg243LtKpCzRcleRLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082702; c=relaxed/simple;
	bh=yzb11FO0nW1yy8hePLHX/ocuoarx6rze5KYkOu5/1xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/GLxiCM1UUPtfUZTdAOxRQ3fliR4Jke+nvJT50yV7UURXLsUqyjYkFd6xp/vekTMmv6zYXCgfJtZtqC+P92GUfholIAaysYCJU6vtBeCZJDhUPCX5vEI2mdz8R8YYK9XQndyqwFGVoPJvCbIjU2XA4uNJ20ntUIWV7Zs64Yy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wp5cOO8S; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc0e5b223eso41303755ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709082700; x=1709687500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqVPOgao3nUBQcfuJjPRQ/Z77KczM3H/soIyvGzsAUo=;
        b=Wp5cOO8SpN1+T1t826nQPc3iHmyI+ofOiO7Jr1U/ZzQBba+ZzKxk9mfMIMX3EqWWo6
         3VJxHh4MgGtcdejyu9khPx2PbEa8KgIcOny9fF5yRMOQPaAQuZmcSwmid51l/w/N3Ng3
         UQ3iNL4Lbjb0G1D2I9Lqz+lxIbaHP1jb6L084=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709082700; x=1709687500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqVPOgao3nUBQcfuJjPRQ/Z77KczM3H/soIyvGzsAUo=;
        b=uHj/++G5i2icnHgeWSC070eIn7cQqNgcJa0a2613OT5cVLWF9XbBURi3XPwbjVOnhF
         PCc2JITfW0Eew6XKE24FlbpnMMe3ZmrOtp7aNes1/jDEkB7JwsuJSpAuw9veI4N9wdgN
         Jljycy91OaEChzg258gXXEKZBkYT7LIHIqL2B02/U/ZKpF5qPiG58DZ23er27RzJDRS2
         V3aEuwG2KBRB8wLL8opNcPqP1lmiu3cTk+41sk7o2C3nmZ4HjOWzbGTtYDS1UkRfJ46F
         G9w7zVDGCP8pJ2UqUcUWm/jD/jwS6r4iFtvObXzMSUsFKByz5xYYw6AYckuXN76MXeqh
         DAfg==
X-Forwarded-Encrypted: i=1; AJvYcCUtx+eVjAz1lgEtsn9K3IslMWB8EGNrcf9F8Q6kHLR7GOw0btq39vIZ6zKDR3AQeZty/dJ2wdzBi3YyXSvsmnar0bCwXUhoPdZyz++3
X-Gm-Message-State: AOJu0YxhSNyf4nYEsZ7/zI7hVtwWzgSzQmaxciC/HPZH9S3OEh11VnMd
	V3eudXBDmMRMJEa9m0ARf1YFTA+1G983KYmHA+FdZw+oFJa75KWRUuUc1k+zTQ==
X-Google-Smtp-Source: AGHT+IEanBcdy/4EmkJInHO9eSzsmi9IHlJxuOJZ78Yq00y6wV5YFHQmlw+GKcpe6EBwL9YtY+2iHA==
X-Received: by 2002:a17:902:d4c6:b0:1dc:af71:4d46 with SMTP id o6-20020a170902d4c600b001dcaf714d46mr6771119plg.13.1709082699902;
        Tue, 27 Feb 2024 17:11:39 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:87d1:e95d:b670:4783])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm2131529plb.280.2024.02.27.17.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 17:11:39 -0800 (PST)
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
Subject: [PATCH v2 2/3] drm/panel: panel-edp: Match edp_panels with panel name
Date: Tue, 27 Feb 2024 17:05:59 -0800
Message-ID: <20240228011133.1238439-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240228011133.1238439-1-hsinyi@chromium.org>
References: <20240228011133.1238439-1-hsinyi@chromium.org>
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
v1->v2:
match with panel name instead of crc hash.
Note that we can't directly use drm_edid_get_monitor_name(), because some
panel store the name after EDID_DETAIL_MONITOR_STRING instead of
EDID_DETAIL_MONITOR_NAME.
---
 drivers/gpu/drm/drm_edid.c        | 69 +++++++------------------------
 drivers/gpu/drm/panel/panel-edp.c | 44 +++++++++++++++++---
 include/drm/drm_edid.h            |  2 +-
 3 files changed, 54 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 15b97c8ed993..c4126475ff0a 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2764,7 +2764,19 @@ const struct drm_edid *drm_edid_read(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_edid_read);
 
-static u32 edid_extract_panel_id(const struct edid *edid)
+/**
+ * edid_extract_panel_id - Extract a panel's ID from EDID
+ * @edid: EDID used to extract the panel's ID.
+ *
+ * Extract panel ID from EDID.
+ *
+ * Return: A 32-bit ID that should be different for each make/model of panel.
+ *         See the functions drm_edid_encode_panel_id() and
+ *         drm_edid_decode_panel_id() for some details on the structure of this
+ *         ID.
+ */
+
+u32 edid_extract_panel_id(const struct edid *edid)
 {
 	/*
 	 * We represent the ID as a 32-bit number so it can easily be compared
@@ -2783,60 +2795,7 @@ static u32 edid_extract_panel_id(const struct edid *edid)
 	       (u32)edid->mfg_id[1] << 16   |
 	       (u32)EDID_PRODUCT_ID(edid);
 }
-
-/**
- * drm_edid_get_panel_id - Get a panel's ID through DDC
- * @adapter: I2C adapter to use for DDC
- *
- * This function reads the first block of the EDID of a panel and (assuming
- * that the EDID is valid) extracts the ID out of it. The ID is a 32-bit value
- * (16 bits of manufacturer ID and 16 bits of per-manufacturer ID) that's
- * supposed to be different for each different modem of panel.
- *
- * This function is intended to be used during early probing on devices where
- * more than one panel might be present. Because of its intended use it must
- * assume that the EDID of the panel is correct, at least as far as the ID
- * is concerned (in other words, we don't process any overrides here).
- *
- * NOTE: it's expected that this function and drm_do_get_edid() will both
- * be read the EDID, but there is no caching between them. Since we're only
- * reading the first block, hopefully this extra overhead won't be too big.
- *
- * Return: A 32-bit ID that should be different for each make/model of panel.
- *         See the functions drm_edid_encode_panel_id() and
- *         drm_edid_decode_panel_id() for some details on the structure of this
- *         ID.
- */
-
-u32 drm_edid_get_panel_id(struct i2c_adapter *adapter)
-{
-	enum edid_block_status status;
-	void *base_block;
-	u32 panel_id = 0;
-
-	/*
-	 * There are no manufacturer IDs of 0, so if there is a problem reading
-	 * the EDID then we'll just return 0.
-	 */
-
-	base_block = kzalloc(EDID_LENGTH, GFP_KERNEL);
-	if (!base_block)
-		return 0;
-
-	status = edid_block_read(base_block, 0, drm_do_probe_ddc_edid, adapter);
-
-	edid_block_status_print(status, base_block, 0);
-
-	if (edid_block_status_valid(status, edid_block_tag(base_block)))
-		panel_id = edid_extract_panel_id(base_block);
-	else
-		edid_block_dump(KERN_NOTICE, base_block, 0);
-
-	kfree(base_block);
-
-	return panel_id;
-}
-EXPORT_SYMBOL(drm_edid_get_panel_id);
+EXPORT_SYMBOL(edid_extract_panel_id);
 
 /**
  * drm_get_edid_switcheroo - get EDID data for a vga_switcheroo output
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3fb5fcd326a4..72ad552bff24 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -761,11 +761,13 @@ static void panel_edp_parse_panel_timing_node(struct device *dev,
 		dev_err(dev, "Reject override mode: No display_timing found\n");
 }
 
-static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
+static bool edid_has_name(struct edid *edid, const char *panel_name);
+static const struct edp_panel_entry *find_edp_panel(u32 panel_id, struct edid *edid);
 
 static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 {
 	struct panel_desc *desc;
+	struct edid *edid;
 	u32 panel_id;
 	char vend[4];
 	u16 product_id;
@@ -795,15 +797,19 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 		goto exit;
 	}
 
-	panel_id = drm_edid_get_panel_id(panel->ddc);
-	if (!panel_id) {
+	edid = drm_get_edid_no_connector(panel->ddc);
+	if (!edid) {
 		dev_err(dev, "Couldn't identify panel via EDID\n");
 		ret = -EIO;
 		goto exit;
 	}
+	panel_id = edid_extract_panel_id(edid);
 	drm_edid_decode_panel_id(panel_id, vend, &product_id);
 
-	panel->detected_panel = find_edp_panel(panel_id);
+	panel->detected_panel = find_edp_panel(panel_id, edid);
+
+	/* Read EDID again in panel_edp_get_modes() when connector is known. */
+	kfree(edid);
 
 	/*
 	 * We're using non-optimized timings and want it really obvious that
@@ -2107,13 +2113,41 @@ static const struct edp_panel_entry edp_panels[] = {
 	{ /* sentinal */ }
 };
 
-static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
+static bool edid_has_name(struct edid *edid, const char *panel_name)
+{
+	int i, j;
+	char buf[13];
+
+	for (i = 0; i < 4; i++) {
+		strncpy(buf, edid->detailed_timings[i].data.other_data.data.str.str,
+			sizeof(buf));
+		for (j = 0; j < 13; j++) {
+			if (buf[j] == 0x0a) {
+				buf[j] = '\0';
+				break;
+			}
+		}
+		buf[12] = '\0';
+		if (strncmp(panel_name, buf, strlen(panel_name)) == 0)
+			return true;
+	}
+
+	return false;
+}
+
+static const struct edp_panel_entry *find_edp_panel(u32 panel_id, struct edid *edid)
 {
 	const struct edp_panel_entry *panel;
 
 	if (!panel_id)
 		return NULL;
 
+	/* Match with both panel_id and name. Find if EDID contains name. */
+	for (panel = edp_panels; panel->panel_id; panel++)
+		if (panel->panel_id == panel_id && edid_has_name(edid, panel->name))
+			return panel;
+
+	/* Match with only panel_id */
 	for (panel = edp_panels; panel->panel_id; panel++)
 		if (panel->panel_id == panel_id)
 			return panel;
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 80c9e32ff80e..4cefff357789 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -566,7 +566,7 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
 struct edid *drm_get_edid(struct drm_connector *connector,
 			  struct i2c_adapter *adapter);
 struct edid *drm_get_edid_no_connector(struct i2c_adapter *adapter);
-u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
+u32 edid_extract_panel_id(const struct edid *edid);
 struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
 				     struct i2c_adapter *adapter);
 struct edid *drm_edid_duplicate(const struct edid *edid);
-- 
2.44.0.rc1.240.g4c46232300-goog


