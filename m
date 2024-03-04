Return-Path: <linux-kernel+bounces-91192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEE5870B09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F0DB22940
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43007AE6E;
	Mon,  4 Mar 2024 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Il9iQkuY"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648CB79DD8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581941; cv=none; b=m50HjtS9NI2Au49fETCnvzJc6l+au5BqTXLt0iHNDWs9gHZah32rixbYNAxC8A9uUe5N183uyQJzBMDNX41QQtXNNArAPKNYq+ZMtcjYUZWjEzlJD73xplNob3688Pg6UBwobCubx1PW0ZUs0mJAJir58hLsDgzpvx7bV/QiiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581941; c=relaxed/simple;
	bh=6lBTJsXd4ETHA4C7cBv+MW2uOtQLsXgZJo1S2Nxvgic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOAkCdx2jLVNgiY/P2rphriW4Q8FjRUI9ZaDG+vfrTSu4yTAPdYDuhIZddaxGapULM79dK51S1lxpQRfMYJgohBK8E0wRRb06KQ7pE4xHDH3aFjvskgCYQ8vpb6cr++ePV1FXdzpp19eVxxHqxI7aF8Zt06bbp3UKeu/Atsb2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Il9iQkuY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6277f72d8so836318b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 11:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709581939; x=1710186739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oeg1ks8Z5TiI329gqNMDbm7TYAS4q9yMPCP31gjx14E=;
        b=Il9iQkuYh7NiretuJh/xfuvfWbHxJIIgcmHBDuzN1QTYNKBVpH0D4eVwJkwlNMJ5Xm
         O2LkYhu/Bll8e3Gcnio8ROAMfTifyEk4MZiR15PVw82iN5SK43R9qxE9UzVRQXsDrws+
         QafUmKT4HCkN+p7Q5xw4ruJHTxoO5NOJwU0AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581939; x=1710186739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oeg1ks8Z5TiI329gqNMDbm7TYAS4q9yMPCP31gjx14E=;
        b=SMbAqCNgTPgjaA80wjfTWboDmRiDhsc6kOGxKjyuBYCbsqt4rGBL/ryGY9zz2BbUK+
         N5+wNGSiCUE5NiXAMIGyOKqQloK0AKhqaVqtvMhSoDl9l1n9GoMzlqh5lYuq4oC+l/TB
         ONKFuPbhOnUP64mtKvDom3EJCt8f+V725HtmlXWxafnOYWn3xrWyohllNBB1VhbWALcE
         6P+rtU/pN1udCSFVRrOKxW51248X1ynB4cPCpnpZdkCZbXfUcSJ0tnaSUluEQPW01utJ
         d/lloJshy9jdaSu1WRWG8klg7IJBIwRPh9iAZ6weqxZmeH9J0W62eUZ1kg9u/yMjQV+U
         nF+w==
X-Forwarded-Encrypted: i=1; AJvYcCUqh875z1byO+7stIUJ0OmBaTNW3elip9iekCJoLKhS9+ZFIB8oy98GWNBjjCkIfC2W/Ru6kKxTdrUVt4DQTl0yevrJ7OQS8sQell/Y
X-Gm-Message-State: AOJu0Yx5YcQC1wSmJyWwu9PtOK9551V6A83PL0avRG3ZrxigIQUS+R9W
	3NicKIZQxGhjD49jxZ/ulqLUk/yQFOQ6yf27aCHux/Dr+AS/UODQlq3h6ny/ow==
X-Google-Smtp-Source: AGHT+IHLmXC5K65w/XvN1QDNXYVbf7LPTiLwzZQXv2LlpjmfZV2obLbzbD8eHFHeFT4rlwCqsjH5GQ==
X-Received: by 2002:a05:6a20:3d01:b0:1a1:14f2:4b70 with SMTP id y1-20020a056a203d0100b001a114f24b70mr9419789pzi.22.1709581939567;
        Mon, 04 Mar 2024 11:52:19 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:bcf3:25da:25cd:199])
        by smtp.gmail.com with ESMTPSA id r27-20020aa7845b000000b006e04d2be954sm7600820pfn.187.2024.03.04.11.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:52:19 -0800 (PST)
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
Subject: [PATCH v3 2/4] drm/edid: Add a function to check monitor string
Date: Mon,  4 Mar 2024 11:44:57 -0800
Message-ID: <20240304195214.14563-3-hsinyi@chromium.org>
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

Add a function to check if the EDID base block contains a given string.

One of the use cases is fetching panel from a list of panel names, since
some panel vendors put the monitor name after EDID_DETAIL_MONITOR_STRING
instead of EDID_DETAIL_MONITOR_NAME.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2->v3: move string matching to drm_edid
---
 drivers/gpu/drm/drm_edid.c | 49 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_edid.h     |  1 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 13454bc64ca2..fcdc2bd143dd 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2789,6 +2789,55 @@ u32 drm_edid_get_panel_id(struct edid_base_block *base_block)
 }
 EXPORT_SYMBOL(drm_edid_get_panel_id);
 
+/**
+ * drm_edid_has_monitor_string - Check if a EDID base block has certain string.
+ * @base_block: EDID base block to check.
+ * @str: pointer to a character array to hold the string to be checked.
+ *
+ * Check if the detailed timings section of a EDID base block has the given
+ * string.
+ *
+ * Return: True if the EDID base block contains the string, false otherwise.
+ */
+bool drm_edid_has_monitor_string(struct edid_base_block *base_block, const char *str)
+{
+	unsigned int i, j, k, buflen = strlen(str);
+
+	for (i = 0; i < EDID_DETAILED_TIMINGS; i++) {
+		struct detailed_timing *timing = &base_block->edid.detailed_timings[i];
+		unsigned int size = ARRAY_SIZE(timing->data.other_data.data.str.str);
+
+		if (buflen > size || timing->pixel_clock != 0 ||
+		    timing->data.other_data.pad1 != 0 ||
+		    (timing->data.other_data.type != EDID_DETAIL_MONITOR_NAME &&
+		     timing->data.other_data.type != EDID_DETAIL_MONITOR_STRING))
+			continue;
+
+		for (j = 0; j < buflen; j++) {
+			char c = timing->data.other_data.data.str.str[j];
+
+			if (c != str[j] ||  c == '\n')
+				break;
+		}
+
+		if (j == buflen) {
+			/* Allow trailing white spaces. */
+			for (k = j; k < size; k++) {
+				char c = timing->data.other_data.data.str.str[k];
+
+				if (c == '\n')
+					return true;
+				else if (c != ' ')
+					break;
+			}
+			if (k == size)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * drm_edid_get_base_block - Get a panel's EDID base block
  * @adapter: I2C adapter to use for DDC
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 2455d6ab2221..248ddb0a6b5d 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -416,6 +416,7 @@ struct edid *drm_get_edid(struct drm_connector *connector,
 			  struct i2c_adapter *adapter);
 struct edid_base_block *drm_edid_get_base_block(struct i2c_adapter *adapter);
 u32 drm_edid_get_panel_id(struct edid_base_block *base_block);
+bool drm_edid_has_monitor_string(struct edid_base_block *base_block, const char *str);
 struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
 				     struct i2c_adapter *adapter);
 struct edid *drm_edid_duplicate(const struct edid *edid);
-- 
2.44.0.rc1.240.g4c46232300-goog


