Return-Path: <linux-kernel+bounces-84306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE186A4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BE7B2440A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34D06125;
	Wed, 28 Feb 2024 01:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YXCjJu/p"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9182F2103
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082701; cv=none; b=aMyJNXUasNdFJPhLTvZCzXTvlHLzhIY24zWArBFHSBTQqKmGo/lvO9aupMHPBrZTZ35qDq6R5+5tt5TDAMNwsUpQfurKJOpI+tHHSkeEpMfzfUh88fKgLtGHfc6UErpEvkobFYmDEfAiFWZR6sH9itj3yHMHFYdSL25eJFewg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082701; c=relaxed/simple;
	bh=+Za4WiG0WeyFO8aiqq35F/0dX8b+SoiVTKiGqv26ccQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0F/M8pwJJIeRHs3rFseWM2qA34I4WjO/nsVdoO0J+tWb9h8EtDHWJ+0m9mfkB6AgKyY8s4l+uM6WbP0XWl1pJbfpddZXFyneh4J3M1HR+oHZWwFAwvC0KobLTyvYXlz3arohwHBSF9JZ+kv3wjTWcjXF5E2R2LGLj3XgU7uY2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YXCjJu/p; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc49b00bdbso43938445ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709082699; x=1709687499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXmDMoR5fxDfWHfx9hk2z/Xni/CCYvEBdkiUT3ERlc4=;
        b=YXCjJu/pDXM02doM7Ol9O5QLVQIXeH+9fvOKY08FxUrKvW9WmKJ9x9Ohafd1o6lRmE
         YqM7HXaJzBzfBVqMOTqSQHNVCZRLx8WvpksriTLhVY26lm07BtF7ThiKqHUAFmgywSZW
         V2UzkH6yaUemZ4/1bQNdc8ttWCF/L/ZiLR8bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709082699; x=1709687499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXmDMoR5fxDfWHfx9hk2z/Xni/CCYvEBdkiUT3ERlc4=;
        b=kh1raWzf3h8gCsQ3xpHpyEwEqmeR415hFwncU3of2fSp0uraq30/31K2WpklMJZES4
         llm409iPMazl2dm3Pi06kYymzuLCjch0wN3vVQYpoiOJHccSHcLRM95gGia7k1HqKT2l
         FDa3PfA+Nj4goYD70V5YI9FiYEdWTqhxMUOHq9eUgnwFof8Nib/gJiju1cZE2AeYnlan
         DF9KXQZ9PKyCao7KVASyja5EwR5wcZwd52HE36ei6BhPDB82Y+gJbYXVTOvasNylSpX3
         gY/64o2t2f3A90eCtLarfxiT2Nntm702bOAyqQDXe0OBBnJ7HtYq53GtRUHtzxFvNlih
         733w==
X-Forwarded-Encrypted: i=1; AJvYcCWuLvrw57VLZKjnz7jIp+SVq0x9iKZAN1P6ziR2OlYpeNqe+fH7TbgY8qSdj8sQpzeAkJWKyTqLLugEN9+HOnALV1RUahar8O7zsQox
X-Gm-Message-State: AOJu0Yxss8KsQsBiqUxVhuXHhNd02ZpNggRS9QRosJObpRaoGthhkz5l
	7Fq+y5McgLkHSWN9CTS5FP5HDBvGcNe479kC2rc+IUY2HYk0Ut8outQogqs+6Q==
X-Google-Smtp-Source: AGHT+IFZU274TcXtjwUJ4KumuJnFvswQ8pqcET9/pvdjkcdY+FVA+6GXBMXUpT3bKpLlEHZ2fby6QQ==
X-Received: by 2002:a17:902:8303:b0:1dc:5e8a:93b with SMTP id bd3-20020a170902830300b001dc5e8a093bmr9108581plb.8.1709082698923;
        Tue, 27 Feb 2024 17:11:38 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:87d1:e95d:b670:4783])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm2131529plb.280.2024.02.27.17.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 17:11:38 -0800 (PST)
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
Subject: [PATCH v2 1/3] drm_edid: Support getting EDID through ddc without connector
Date: Tue, 27 Feb 2024 17:05:58 -0800
Message-ID: <20240228011133.1238439-2-hsinyi@chromium.org>
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

Some panels are interested in the EDID during early probe when connector
is still unknown.

Add a function drm_get_edid_no_connector() to get edid without connector.
No functional change for existing usage.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v1->v2:
add a function to return the entire edid without updating connector.
---
 drivers/gpu/drm/drm_edid.c | 45 ++++++++++++++++++++++++++++----------
 include/drm/drm_edid.h     |  1 +
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 1ad94473e400..15b97c8ed993 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2364,7 +2364,7 @@ static struct edid *_drm_do_get_edid(struct drm_connector *connector,
 	struct edid *edid, *new;
 	size_t alloc_size = EDID_LENGTH;
 
-	override = drm_edid_override_get(connector);
+	override = connector ? drm_edid_override_get(connector) : false;
 	if (override) {
 		alloc_size = override->size;
 		edid = kmemdup(override->edid, alloc_size, GFP_KERNEL);
@@ -2385,18 +2385,20 @@ static struct edid *_drm_do_get_edid(struct drm_connector *connector,
 	if (status == EDID_BLOCK_READ_FAIL)
 		goto fail;
 
-	/* FIXME: Clarify what a corrupt EDID actually means. */
-	if (status == EDID_BLOCK_OK || status == EDID_BLOCK_VERSION)
-		connector->edid_corrupt = false;
-	else
-		connector->edid_corrupt = true;
+	if (connector) {
+		/* FIXME: Clarify what a corrupt EDID actually means. */
+		if (status == EDID_BLOCK_OK || status == EDID_BLOCK_VERSION)
+			connector->edid_corrupt = false;
+		else
+			connector->edid_corrupt = true;
 
-	if (!edid_block_status_valid(status, edid_block_tag(edid))) {
-		if (status == EDID_BLOCK_ZERO)
-			connector->null_edid_counter++;
+		if (!edid_block_status_valid(status, edid_block_tag(edid))) {
+			if (status == EDID_BLOCK_ZERO)
+				connector->null_edid_counter++;
 
-		connector_bad_edid(connector, edid, 1);
-		goto fail;
+			connector_bad_edid(connector, edid, 1);
+			goto fail;
+		}
 	}
 
 	if (!edid_extension_block_count(edid))
@@ -2444,7 +2446,8 @@ static struct edid *_drm_do_get_edid(struct drm_connector *connector,
 	}
 
 	if (invalid_blocks) {
-		connector_bad_edid(connector, edid, num_blocks);
+		if (connector)
+			connector_bad_edid(connector, edid, num_blocks);
 
 		edid = edid_filter_invalid_blocks(edid, &alloc_size);
 	}
@@ -2637,6 +2640,24 @@ struct edid *drm_get_edid(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_get_edid);
 
+/**
+ * drm_get_edid_no_connector - get EDID data without updating connector status
+ * @adapter: I2C adapter to use for DDC
+ *
+ * Similar to drm_edid_read_ddc(), but not checking any connector status. Use
+ * this function to get EDID when connector is still unknown.
+ *
+ * Return: Pointer to valid EDID or NULL if we couldn't find any.
+ */
+struct edid *drm_get_edid_no_connector(struct i2c_adapter *adapter)
+{
+	if (!drm_probe_ddc(adapter))
+		return NULL;
+
+	return _drm_do_get_edid(NULL, drm_do_probe_ddc_edid, adapter, NULL);
+}
+EXPORT_SYMBOL(drm_get_edid_no_connector);
+
 /**
  * drm_edid_read_custom - Read EDID data using given EDID block read function
  * @connector: Connector to use
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 70ae6c290bdc..80c9e32ff80e 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -565,6 +565,7 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
 	void *data);
 struct edid *drm_get_edid(struct drm_connector *connector,
 			  struct i2c_adapter *adapter);
+struct edid *drm_get_edid_no_connector(struct i2c_adapter *adapter);
 u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
 struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
 				     struct i2c_adapter *adapter);
-- 
2.44.0.rc1.240.g4c46232300-goog


