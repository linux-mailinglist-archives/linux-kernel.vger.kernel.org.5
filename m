Return-Path: <linux-kernel+bounces-96348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A31875ADC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B23281517
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6910147A76;
	Thu,  7 Mar 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HvYP1IXL"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC53D3BB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709852821; cv=none; b=oMA33FPATM8yKk1+3oO0vAp9SZW3KULo7bNbb0xkE707w1PmzixuQk4i4Hs3m43lKRKZvP0tWAgtAud9nrBN/WBzMGspR63Dh1vQwQGCG4KyOBXBRXUUuD0+ATzCzX5Pw47t589nzoFlcxoA1Pf5tl2E+jZ1cxLaCuonuTM1x4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709852821; c=relaxed/simple;
	bh=zouM2k1CYoagABxzGcy6uv8QYPhVehi1ieqNzFnTmZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBkc2YtRZihMsZJ3RTKVHEWMgLNr+mZerCgibhkfXw7vR0TAGFeVFUgRpa3fN/zzda0AUOs6bxA3gJDH7ybJBUl6grw1GsEYc6ZiilWRdFcSZZZgEe22FWbtMXVgxmvD/PRY95osEe0nSKci0HDY+F5LslKYooW/LiYHkx1w5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HvYP1IXL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dcab44747bso12082015ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709852819; x=1710457619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYEZNIcMNd/BeaNkmjBMYO1g1hMPvuNRl+gv7+BprBg=;
        b=HvYP1IXLbTTd1zYcpdDCa1sBKW+dQiZwqMwP9oN6B09EBXcec5d5KjHa5LFfY30aw/
         av6bGFXB3Khz2t7TF0vt59JLiMFh8z6urW03yjgTRxYtrjzQhoRUJFOOlXHMtkhysfLz
         sIhsISMpWmSc8GwZki8lU4kWwEriNdbCJK4m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709852819; x=1710457619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYEZNIcMNd/BeaNkmjBMYO1g1hMPvuNRl+gv7+BprBg=;
        b=F0Qs5tvNIHKV/O2+jShRBvPj3HtiJ0f/g+o98RRWsYvOCafqyfnrhqR7E/JMANLma4
         9zai1h6KeQLUX5FZqVLpxjbGE6b3uNvq7onZonrUDDpKhHrkKdHZlIBzTOt+/wvQqOs0
         HAkMyjyoXP6mG6g/74ijgnyIQeEo3WegtMvsj5NdhU+FOczbqEmp+S9pWrcE82RW8rPb
         wUsbwtqi+wutMgZExx5OEeUL+bEvIv2EHxdk4fegreq/vs8uANDK7ieZno+QdMpbGU7n
         TNSvvx6u/mAYTAMprtH+dS9I7cEo7baHNffrYAG/cvpF/rzeFzNQzfN8K/iNFn0gv6Qa
         xYKg==
X-Forwarded-Encrypted: i=1; AJvYcCXGJu0XTIPmNugYPxCcrpOd/n3EHwCvF6Ck41tR27kGidNQ+Zs4AuTr6RkWK/6l0kE/wmUJGZ/zkj18ff6LPQtxoOlQ0xkEwr6/c+99
X-Gm-Message-State: AOJu0Yx2UYQ0wfmejNGeD+F8kPz3CZlh8HN8KEEmgR4J4LGkrOZ4uU7M
	XmweI+KRZrorE8fs52UUd6y0NGg1ZuVDD1fUDDte5b2r6ExHfJ6kotIBmaNNqQ==
X-Google-Smtp-Source: AGHT+IH4JN/Y0kdeG70rMVv9p/9iS1bg9i0S07bplO9mD21xLH7uN7ZRgi0aG8PNT/zsDNvLmvr2xQ==
X-Received: by 2002:a17:902:c146:b0:1dc:b874:583f with SMTP id 6-20020a170902c14600b001dcb874583fmr8850154plj.38.1709852819245;
        Thu, 07 Mar 2024 15:06:59 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:bf8f:10d4:f877:bee3])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f2d300b001db63cfe07dsm15196654plc.283.2024.03.07.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:06:58 -0800 (PST)
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
Subject: [PATCH v6 2/5] drm/edid: Add a function to match EDID with identity
Date: Thu,  7 Mar 2024 14:57:42 -0800
Message-ID: <20240307230653.1807557-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240307230653.1807557-1-hsinyi@chromium.org>
References: <20240307230653.1807557-1-hsinyi@chromium.org>
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
v5->v6: finalize the trailing white space and/or NUL decision:
Allow only white space before \n.
---
 drivers/gpu/drm/drm_edid.c | 65 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_edid.h     |  9 ++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 284255a0315e..58fe35058181 100644
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
@@ -5408,6 +5413,66 @@ drm_parse_hdmi_vsdb_audio(struct drm_connector *connector, const u8 *db)
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
+	for (i = name_len; i < desc_len; i++) {
+		if (desc[i] == '\n')
+			break;
+		/* Allow white space before EDID string terminator. */
+		if (!isspace(desc[i]))
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
index 8b233865b085..5e3fc8c83a31 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -367,6 +367,13 @@ struct edid {
 	u8 checksum;
 } __attribute__((packed));
 
+/* EDID matching */
+struct drm_edid_ident {
+	/* ID encoded by drm_edid_encode_panel_id() */
+	u32 panel_id;
+	const char *name;
+};
+
 #define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1] << 8))
 
 /* Short Audio Descriptor */
@@ -567,6 +574,8 @@ struct edid *drm_get_edid(struct drm_connector *connector,
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


