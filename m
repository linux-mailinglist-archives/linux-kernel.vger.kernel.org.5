Return-Path: <linux-kernel+bounces-79275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC5861FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A10D28717B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659C514DFDB;
	Fri, 23 Feb 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cpu4ndIt"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9F143C63
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728007; cv=none; b=M6hWLNFmjp9uZGz8D+jF9gDpCFxy2YxOUG0H43rzKNs/MskD4sBmvlUUv7OrQAWVFgUx+ewyS5UcSuzo2zxPYBLUxAnVknsXz4wMr95vTxFtlwfkX0Eee1+jg0M0nj0/hS7AAxzWuI+LuzzAPbdbziu4r3bHEL39wSOreXs9q0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728007; c=relaxed/simple;
	bh=ZGM0H9OX6IuYQLFMOB8tArMAbsmHZckmY8VWfmMOH+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3ZpgZSiHmoa1WwUTb+Su2vw1+0glKsCblDJn91cPpMMrUU0DU9Bg9SPhyWdXarjXVwD2yxx4tXrJl56TU+S/bLz+MSbX2ENEybRzq4e5YdGj2RbnpoNqIcc7D+y0WqfFOphLgw8yAZkYPEuEEDENBS24ArUJyAztqABnsHb9Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cpu4ndIt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1277353a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708728003; x=1709332803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2NLOgJvFk9/xpCgoWWX0mwY7XC1SqoEPJetQl38NRg=;
        b=cpu4ndIt16D5/QrGZ6s67ePQzuC2xQc8W2t8TcoIXfeQpxWN+nVbhXIB4re+qdjKte
         thBi8YZdynxnmZ6eECAuP1F3WAjYlrFPCicTS9WFUyv7o3+IuEbqVqCYPquNp/bPwVO4
         HqNRRLO9/iGBgOreXYOhJMYmqFKAF0S2vYAaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708728003; x=1709332803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2NLOgJvFk9/xpCgoWWX0mwY7XC1SqoEPJetQl38NRg=;
        b=FEQahFM731n67qDc0tV99lvj6dP+KErCWjvPDEH97NXdrvQL6tjXIb23fu/0DB8aWZ
         kKQX+1U3Uhjf9rGUKiQvtgTMZyM5aVkxItVXVoORRfCLp6YJTHbIGB4lJBx0QbK+ZfDF
         /TiB+aG3+yU5DhSYA+rJ6ggZINCELrYPN4NNEwMkJcLh2na7uYEENwg4JKLWVQti6go+
         l746vw3dD/r94IeaVb7ruOvUPgdxzgujltumwhdPmgHWJb9NQFVl+D518Bas357RJePK
         v2BKBJEFFtQQg1S+F94gZHr6gVR/1/mRsvsoRsdLftrnGlZ/BbFL6mx+LdQBIrZVWlGI
         UUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA+kj9ysENdUqPkuZrEBkwvBoNW6KR7C2yQDevIeeQR77QdW4Va5z75mid52YTCSTRTB0QVtagf/a3gsa84QSr/QhEl2Z+beIEuMd8
X-Gm-Message-State: AOJu0Yy6Ramdjp/laUDXD1pKPKisQPoBWhjjQGEeZiPFyPutLhieHTdf
	AldKyrdEbRSN9/urcsulv/4+cUbQEGCe3MlESP0zlrYXWZkOj6pZkyzvIi2rUA==
X-Google-Smtp-Source: AGHT+IEqAmzztLLv9pUMQIH60NYC+Jh68DPyMwr8SAMILCs8UUd15S395jHWIMuyyILxwr0lYYsk4g==
X-Received: by 2002:a17:90b:380d:b0:299:2da5:a843 with SMTP id mq13-20020a17090b380d00b002992da5a843mr1194908pjb.14.1708728003603;
        Fri, 23 Feb 2024 14:40:03 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:8ff9:a089:c05c:9af])
        by smtp.gmail.com with ESMTPSA id cz4-20020a17090ad44400b002966a13f2e9sm2032873pjb.37.2024.02.23.14.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 14:40:03 -0800 (PST)
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
Subject: [PATCH 1/2] drm_edid: Add a function to get EDID base block
Date: Fri, 23 Feb 2024 14:29:17 -0800
Message-ID: <20240223223958.3887423-2-hsinyi@chromium.org>
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
although their EDID and names are different. Besides panel id, now we need
the hash of entire EDID base block to distinguish these panel variants.

Add drm_edid_get_base_block to returns the EDID base block, so caller can
further use it to get panel id and/or the hash.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/drm_edid.c        | 55 +++++++++++++++++--------------
 drivers/gpu/drm/panel/panel-edp.c |  8 +++--
 include/drm/drm_edid.h            |  3 +-
 3 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 923c4423151c..55598ca4a5d1 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2770,58 +2770,63 @@ static u32 edid_extract_panel_id(const struct edid *edid)
 }
 
 /**
- * drm_edid_get_panel_id - Get a panel's ID through DDC
- * @adapter: I2C adapter to use for DDC
+ * drm_edid_get_panel_id - Get a panel's ID from EDID base block
+ * @base_bock: EDID base block that contains panel ID.
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
+u32 drm_edid_get_panel_id(void *base_block)
+{
+	return edid_extract_panel_id(base_block);
+}
+EXPORT_SYMBOL(drm_edid_get_panel_id);
+
+/**
+ * drm_edid_get_base_block - Get a panel's EDID base block
+ * @adapter: I2C adapter to use for DDC
+ *
+ * This function returns the first block of the EDID of a panel.
+ *
  * This function is intended to be used during early probing on devices where
  * more than one panel might be present. Because of its intended use it must
- * assume that the EDID of the panel is correct, at least as far as the ID
- * is concerned (in other words, we don't process any overrides here).
+ * assume that the EDID of the panel is correct, at least as far as the base
+ * block is concerned (in other words, we don't process any overrides here).
  *
  * NOTE: it's expected that this function and drm_do_get_edid() will both
  * be read the EDID, but there is no caching between them. Since we're only
  * reading the first block, hopefully this extra overhead won't be too big.
  *
- * Return: A 32-bit ID that should be different for each make/model of panel.
- *         See the functions drm_edid_encode_panel_id() and
- *         drm_edid_decode_panel_id() for some details on the structure of this
- *         ID.
+ * Caller should free the base block after use.
  */
-
-u32 drm_edid_get_panel_id(struct i2c_adapter *adapter)
+void *drm_edid_get_base_block(struct i2c_adapter *adapter)
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
+		return NULL;
+	}
 
-	kfree(base_block);
-
-	return panel_id;
+	return base_block;
 }
-EXPORT_SYMBOL(drm_edid_get_panel_id);
+EXPORT_SYMBOL(drm_edid_get_base_block);
 
 /**
  * drm_get_edid_switcheroo - get EDID data for a vga_switcheroo output
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index bd71d239272a..f6ddbaa103b5 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -763,6 +763,7 @@ static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
 static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 {
 	struct panel_desc *desc;
+	void *base_block;
 	u32 panel_id;
 	char vend[4];
 	u16 product_id;
@@ -792,8 +793,11 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 		goto exit;
 	}
 
-	panel_id = drm_edid_get_panel_id(panel->ddc);
-	if (!panel_id) {
+	base_block = drm_edid_get_base_block(panel->ddc);
+	if (base_block) {
+		panel_id = drm_edid_get_panel_id(base_block);
+		kfree(base_block);
+	} else {
 		dev_err(dev, "Couldn't identify panel via EDID\n");
 		ret = -EIO;
 		goto exit;
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 7923bc00dc7a..56b60f9204d3 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -410,7 +410,8 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
 	void *data);
 struct edid *drm_get_edid(struct drm_connector *connector,
 			  struct i2c_adapter *adapter);
-u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
+void *drm_edid_get_base_block(struct i2c_adapter *adapter);
+u32 drm_edid_get_panel_id(void *base_block);
 struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
 				     struct i2c_adapter *adapter);
 struct edid *drm_edid_duplicate(const struct edid *edid);
-- 
2.44.0.rc0.258.g7320e95886-goog


