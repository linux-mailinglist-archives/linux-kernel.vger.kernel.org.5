Return-Path: <linux-kernel+bounces-91019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF1870885
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E16C1F22E23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E201612F7;
	Mon,  4 Mar 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVWTkQqt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D1249F1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574321; cv=none; b=KqyrW4ZVmaNdVWUvQxsHDbAZAT13wkq5e/7k+t/sOb8A5qdF+BSSTey9gFzfXnHznaF3OdvHgALocsNxE9rslzXkaYFdi7zzB+RpnVnpv8xaSvphe0aH1i5d7tAIfS4cFK4ptcYso1GL6ZvpQdPjt5WZv8pRm2TGkdOpJiZAyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574321; c=relaxed/simple;
	bh=DJFh0Ns68NNZLWFZ1dPqWF0AXDgESfnpYjvCjHPZmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFjBOb93jDcxUZ/9Ga0jnPw1HZEIG9eL4XmdSjL9oT6ACQR66kfGLcwi4GnkM6+Czgq02dg39OYGYMSzWy5rEMVaO+KZxCBhpxrzBhh9L6Am+B00MfyU/HUqtoaWSTPGW1QeV5nstR7nEMazazbIwmg3SrzeYXBt/fYRf8VwB8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVWTkQqt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709574318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fvYPB4mVnCnJmx+wGFaBsbHFJyHxXWZZH+8erB8RAuQ=;
	b=BVWTkQqtdsVH5QdcBLppg7/L0d3fZEpWyiAXCR93dn49uBSufdJvmQ4oGW2vC28tSKgwFN
	p6Q70tdn+yA0FjedhEBOJb1R1xD2q4brBucsLLpmMmzhFDjwTaMww+2A2iYxIQrIiKoG2U
	abxeByThGiAKtBcDApAbiSmkdHezhz8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-cDDf0YuTONKEyuxXbK-fAg-1; Mon, 04 Mar 2024 12:45:15 -0500
X-MC-Unique: cDDf0YuTONKEyuxXbK-fAg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d308b0c76so2597365f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574314; x=1710179114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvYPB4mVnCnJmx+wGFaBsbHFJyHxXWZZH+8erB8RAuQ=;
        b=HlExOSRSrWSTBjOvi7kdhiAGIwDlBm4Aas2WsXbo/R4trQRywdftmBHgA7uQLnx+hG
         6fDG+0aCztwKfvHITQvN9dEwkF0FqB/5OukvkC6WZtg2wC8eCRaaz4nwPIeW2c7IFFS7
         NjzJnelVmeb3kPV6hjMnYFBG2YPZiNzjc0Mg+Yb8fcDjWXv98r2g52ZrAeIKpIUnYWZ1
         QyzYK4Fi/yrG+QqYYpi57G/Ttzo9mHZkzgQHX8na3F4/gpbYuQtOx/ieTQ2nkIWWB9t7
         pDfLA2K4FTRBRnqXl39EOmUY4rlic45hR5wjIvRHdCMEjQl2nMyaB/qoF+dvLqQQ/JK5
         CArA==
X-Forwarded-Encrypted: i=1; AJvYcCVuj+FZA50u6A7ulYKIsU0JhHUnTotFgXHe+MXh6s0P7a6yYyOo7ofxJtp0x3WzFw2TkYI3ZBMhBvuvGjpLYGw7xRtrk8+HjqV1vm/2
X-Gm-Message-State: AOJu0Yyetq8bp+FSKVdYH3VoD5q8GiarLk0HtCZGcyawLfI6XQrogHKn
	lnIvSz9THSBKTg4tCSfeaUrwYcuEhsBxmhhpNyR70kJfrVTRIaHTGM2x6KwkJmG9PB45Lk0bJBG
	NkxOxJhnT/xPOZMs7QFyV8Xtb5bTEAIHGRpjevU+v2ob99/uFClW7AOjbaLgvQw==
X-Received: by 2002:adf:d052:0:b0:33d:61c7:9b2c with SMTP id v18-20020adfd052000000b0033d61c79b2cmr153215wrh.34.1709574314168;
        Mon, 04 Mar 2024 09:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfSIScZUyUHr+intkv3X7lZCQsIDrLLSY2NfMGegPwvMGfJpkjJ/IHIgPw/s/cmx74Wojjag==
X-Received: by 2002:adf:d052:0:b0:33d:61c7:9b2c with SMTP id v18-20020adfd052000000b0033d61c79b2cmr153203wrh.34.1709574313795;
        Mon, 04 Mar 2024 09:45:13 -0800 (PST)
Received: from toolbox.fritz.box ([2001:9e8:89b0:4c00:a0ac:17d3:a942:8863])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d6646000000b0033e34982311sm4737615wrw.81.2024.03.04.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:45:13 -0800 (PST)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: 
Cc: Harry Wentland <harry.wentland@amd.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/drm_connector: Document Colorspace property variants
Date: Mon,  4 Mar 2024 18:45:08 +0100
Message-ID: <20240304174512.145862-1-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial idea of the Colorspace prop was that this maps 1:1 to
InfoFrames/SDP but KMS does not give user space enough information nor
control over the output format to figure out which variants can be used
for a given KMS commit. At the same time, properties like Broadcast RGB
expect full range quantization range being produced by user space from
the CRTC and drivers to convert to the range expected by the sink for
the chosen output format, mode, InfoFrames, etc.

This change documents the reality of the Colorspace property. The
Default variant unfortunately is very much driver specific and not
reflected by the EDID. The BT2020 variants are in active use by generic
compositors which have expectations from the driver about the
conversions it has to do when selecting certain output formats.

Everything else is also marked as undefined. Coming up with valid
behavior that makes it usable from user space and consistent with other
KMS properties for those variants is left as an exercise for whoever
wants to use them.

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
---
 drivers/gpu/drm/drm_connector.c | 67 ++++++++++++++++++++++++---------
 include/drm/drm_connector.h     |  8 ----
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index b0516505f7ae..1c4ce7f90a76 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2147,24 +2147,55 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
  * DOC: standard connector properties
  *
  * Colorspace:
- *     This property helps select a suitable colorspace based on the sink
- *     capability. Modern sink devices support wider gamut like BT2020.
- *     This helps switch to BT2020 mode if the BT2020 encoded video stream
- *     is being played by the user, same for any other colorspace. Thereby
- *     giving a good visual experience to users.
- *
- *     The expectation from userspace is that it should parse the EDID
- *     and get supported colorspaces. Use this property and switch to the
- *     one supported. Sink supported colorspaces should be retrieved by
- *     userspace from EDID and driver will not explicitly expose them.
- *
- *     Basically the expectation from userspace is:
- *      - Set up CRTC DEGAMMA/CTM/GAMMA to convert to some sink
- *        colorspace
- *      - Set this new property to let the sink know what it
- *        converted the CRTC output to.
- *      - This property is just to inform sink what colorspace
- *        source is trying to drive.
+ *	This property selects the colorimetry and transfer characteristics user
+ *	space configured the CRTC to produce.
+ *	The transfer characteristics might get overwritten by the
+ *	HDR_OUTPUT_METADATA property.
+ *	The quantization range is always full (see the Broadcast RGB property).
+ *
+ *	The driver is expected to send the right metadata to the sink which can
+ *	depend on the property value, the output mode and the output format.
+ *	It's also responsible for converting to the output format, taking into
+ *	account YCbCr conversion and quantization range.
+ *
+ *	For historical reasons this property exposes a number of variants which
+ *	result in undefined behavior.
+ *
+ *	Default:
+ *		The behavior is driver-specific.
+ *	BT2020_RGB:
+ *	BT2020_YCC:
+ *		User space configures the state such that the CRTC produces RGB
+ *		content with Rec. ITU-R BT.2020 colorimetry, Rec. ITU-R BT.2020
+ *		(Table 4, RGB) transfer characteristics and full quantization
+ *		range.
+ *		User space can use the HDR_OUTPUT_METADATA property to set the
+ *		transfer characteristics to PQ (Rec. ITU-R BT.2100 Table 4) or
+ *		HLG (Rec. ITU-R BT.2100 Table 5) in which case, user space
+ *		configures the CRTC to produce content with the respective
+ *		transfer characteristics.
+ *		Drivers can configure the sink to use an RGB format, tell the
+ *		sink to expect Rec. ITU-R BT.2020 R'G'B' colorimetry and convert
+ *		to the appropriate quantization range.
+ *		Drivers can configure the sink to use a YCbCr format, tell the
+ *		sink to expect Rec. ITU-R BT.2020 Y'C'BC'R colorimetry, convert
+ *		to YCbCr using the Rec. ITU-R BT.2020 non-constant luminance
+ *		conversion matrix and convert to the appropriate quantization
+ *		range.
+ *	SMPTE_170M_YCC:
+ *	BT709_YCC:
+ *	XVYCC_601:
+ *	XVYCC_709:
+ *	SYCC_601:
+ *	opYCC_601:
+ *	opRGB:
+ *	BT2020_CYCC:
+ *	DCI-P3_RGB_D65:
+ *	DCI-P3_RGB_Theater:
+ *	RGB_WIDE_FIXED:
+ *	RGB_WIDE_FLOAT:
+ *	BT601_YCC:
+ *		The behavior is undefined.
  *
  * Because between HDMI and DP have different colorspaces,
  * drm_mode_create_hdmi_colorspace_property() is used for HDMI connector and
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index fe88d7fc6b8f..02c42b01a3a7 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -437,14 +437,6 @@ enum drm_privacy_screen_status {
  *
  * DP definitions come from the DP v2.0 spec
  * HDMI definitions come from the CTA-861-H spec
- *
- * A note on YCC and RGB variants:
- *
- * Since userspace is not aware of the encoding on the wire
- * (RGB or YCbCr), drivers are free to pick the appropriate
- * variant, regardless of what userspace selects. E.g., if
- * BT2020_RGB is selected by userspace a driver will pick
- * BT2020_YCC if the encoding on the wire is YUV444 or YUV420.
   *
  * @DRM_MODE_COLORIMETRY_DEFAULT:
  *   Driver specific behavior.
-- 
2.44.0


