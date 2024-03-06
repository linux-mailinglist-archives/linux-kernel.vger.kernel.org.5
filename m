Return-Path: <linux-kernel+bounces-94530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC40874117
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93800286DD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296414262B;
	Wed,  6 Mar 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BYRzg4OQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ABF14374D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755441; cv=none; b=s2UTG3bxLzszPT5a0U0x/fgXwrjKEPTxhDa20fUT7ZqbOzwXgx0jN0HAZNptCu5dNTRKOKtayJU+/J/rzsLK21YO7TUVEAxL22qnn6F0AF9Ns/HP5qX/b4ikBqmdI2G1tBh0iS2K+3KqrqQMcMULPa4jUSgaDSMmljZ2izQk4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755441; c=relaxed/simple;
	bh=4iHWWRMdzWrUYQZlSrJyyHmHQ8zWNejad1qscDWR5GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moJpMVO2E1gpzSCPs94T6MeWcNf0SYia8sMab4iFuDHnVIwE5hjZ6/ppkrRg1wLHj7R10V090Yg/JJ5qWT+x1c1uQUu7MRqpW3ZL+8yUS+1tWHOfZcCz50xTZ1suH0gH+F4HKu8XoVGaN0w5Lg9H93MAE0epeIhucgjBtU++sEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BYRzg4OQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e63e9abf6aso86265b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709755439; x=1710360239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRJUYRt2oq67C0/LdzkUEFZ3CsguCNeMnqbNn5e2Vjw=;
        b=BYRzg4OQVb4CuD4uk2AIAKWHpScWRfu0qeYCR9HU/YRmZ7lZfrb+YzKrOtTUlkPVqu
         /LJgUYEn7LOy+9tkXdrCqFAWN4aUZ/hrTMB/tSISfs8cUl2TfSL1fyQpmv9FRfqeg26I
         GFDFLbQl5RF6eg4t4sf4Wj83yQvhdXqSr9hk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755439; x=1710360239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRJUYRt2oq67C0/LdzkUEFZ3CsguCNeMnqbNn5e2Vjw=;
        b=A2DrKDHs7M4d4EYxbFG/Pv/U414VftIsHIP2t3LoVm/IiPxitMksqTErANCOtIZ2FG
         4C2d2T7JJaBGWaXaHFrmpmeXMziba0dj62izF/SwgFIeADdpbqte7k3QYw2ew7SIr5Kl
         AW/FB//BWC9VvZka+iahQQBWs7bXrB9Fz1gTzm7h+WUW5vwItJrmDmjwLiR7wXa+nYm5
         swZBK3PnGAl8CPBsG4krlccjhfgTqMs1m8ED/0k/hV2meeQ16npLmWQiZBbDngO7bpjf
         xI4lbm1si9Ii6tABjsGAQccQj9RG6DKXhGm8HfBVbf1SVHmBsYNL0KKyRVG4WA/VhiKa
         3jqw==
X-Forwarded-Encrypted: i=1; AJvYcCXcS2mqCfU7NmcE7y6H6bk2H7WmfhelGyFMnPV9ALkf6InnpNshwTwma3W5ojxB0hLNEyahINe5upGlAsviYLaMX4MFIEiLa6VkjQig
X-Gm-Message-State: AOJu0YwoKzhdaSF5q9vKLz9RHk3rx5AlaFMLmVgq5YM8kcgj5uXzukmq
	lTdHgaaLJ3XawvcL/vLxTphbwJ16rTCXmmtttvOMO8dGfBHqxaeE9PnLLAbRJg==
X-Google-Smtp-Source: AGHT+IEXmTS6PLw1/iaxz3ACFLOd7WH1/YNx8U/VqwNBQW526mexbfJ/D5D3qnZ8ATCE2qu9PJRPeg==
X-Received: by 2002:a05:6a00:2da3:b0:6e6:451c:a519 with SMTP id fb35-20020a056a002da300b006e6451ca519mr6034543pfb.5.1709755438763;
        Wed, 06 Mar 2024 12:03:58 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:a215:f6c0:3224:5460])
        by smtp.gmail.com with ESMTPSA id e3-20020aa79803000000b006e5667793d4sm11124241pfl.66.2024.03.06.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:03:58 -0800 (PST)
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
Subject: [PATCH v5 3/6] drm/edid: Add a function to match EDID with identity
Date: Wed,  6 Mar 2024 11:55:53 -0800
Message-ID: <20240306200353.1436198-4-hsinyi@chromium.org>
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

Create a type drm_edid_ident as the identity of an EDID. Currently it
contains panel id and monitor name.

Create a function that can match a given EDID and an identity:
1. Reject if the panel id doesn't match.
2. If name is not null in identity, try to match it in the detailed timing
   blocks. Note that some panel vendors put the monitor name after
   EDID_DETAIL_MONITOR_STRING.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v4->v5: use strncmp, change function/variable names.
---
 drivers/gpu/drm/drm_edid.c | 65 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_edid.h     |  8 +++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index febe374fa969..29ef35ebee32 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -100,6 +100,11 @@ struct detailed_mode_closure {
 	int modes;
 };
 
+struct drm_edid_match_closure {
+	const struct drm_edid_ident *ident;
+	bool matched;
+};
+
 #define LEVEL_DMT	0
 #define LEVEL_GTF	1
 #define LEVEL_GTF2	2
@@ -5405,6 +5410,66 @@ drm_parse_hdmi_vsdb_audio(struct drm_connector *connector, const u8 *db)
 		    connector->audio_latency[0], connector->audio_latency[1]);
 }
 
+static void
+match_identity(const struct detailed_timing *timing, void *data)
+{
+	struct drm_edid_match_closure *closure = data;
+	unsigned int i;
+	const char *name = closure->ident->name;
+	unsigned int name_len = strlen(name);
+	const char *desc = timing->data.other_data.data.str.str;
+	unsigned int desc_len = ARRAY_SIZE(timing->data.other_data.data.str.str);
+
+	if (name_len > desc_len ||
+	    !(is_display_descriptor(timing, EDID_DETAIL_MONITOR_NAME) ||
+	      is_display_descriptor(timing, EDID_DETAIL_MONITOR_STRING)))
+		return;
+
+	if (strncmp(name, desc, name_len))
+		return;
+
+	/* Allow trailing white spaces and \0. */
+	for (i = name_len; i < desc_len; i++) {
+		if (desc[i] == '\n')
+			break;
+		if (!isspace(desc[i]) && !desc[i])
+			return;
+	}
+
+	closure->matched = true;
+}
+
+/**
+ * drm_edid_match - match drm_edid with given identity
+ * @drm_edid: EDID
+ * @ident: the EDID identity to match with
+ *
+ * Check if the EDID matches with the given identity.
+ *
+ * Return: True if the given identity matched with EDID, false otherwise.
+ */
+bool drm_edid_match(const struct drm_edid *drm_edid,
+		    const struct drm_edid_ident *ident)
+{
+	if (!drm_edid || drm_edid_get_panel_id(drm_edid) != ident->panel_id)
+		return false;
+
+	/* Match with name only if it's not NULL. */
+	if (ident->name) {
+		struct drm_edid_match_closure closure = {
+			.ident = ident,
+			.matched = false,
+		};
+
+		drm_for_each_detailed_block(drm_edid, match_identity, &closure);
+
+		return closure.matched;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(drm_edid_match);
+
 static void
 monitor_name(const struct detailed_timing *timing, void *data)
 {
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 8b233865b085..28f05a7b2f7b 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -367,6 +367,12 @@ struct edid {
 	u8 checksum;
 } __attribute__((packed));
 
+/* EDID matching */
+struct drm_edid_ident {
+	u32 panel_id;
+	const char *name;
+};
+
 #define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1] << 8))
 
 /* Short Audio Descriptor */
@@ -567,6 +573,8 @@ struct edid *drm_get_edid(struct drm_connector *connector,
 			  struct i2c_adapter *adapter);
 const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter *adapter);
 u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid);
+bool drm_edid_match(const struct drm_edid *drm_edid,
+		    const struct drm_edid_ident *ident);
 struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
 				     struct i2c_adapter *adapter);
 struct edid *drm_edid_duplicate(const struct edid *edid);
-- 
2.44.0.278.ge034bb2e1d-goog


