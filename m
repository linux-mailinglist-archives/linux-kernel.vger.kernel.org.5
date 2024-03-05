Return-Path: <linux-kernel+bounces-92471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C068720D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969171C21E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4E8612E;
	Tue,  5 Mar 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYj3mnjj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF1A762DF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646722; cv=none; b=hdcezGdLmnSSeKjJOogLLSV4Xj9Jbau6RgYLnMPCrwApZawRxuh/kF82gaOdd7q3HboSwQVnHhPMWvdp72HT3e2jheDNoajTAkmz5iDEkJiXGcFjrpen2+LEgi48t6wVocrgRS3d5vCX/oPnOtgm3+LeFGncCXIRoe8ogBEIZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646722; c=relaxed/simple;
	bh=xY2WUJurgVHEpDGkm1zAJ6SPaQq6x1poT9czjNrh8z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pswj4bnVY73Zgij5QtorVAUbfs3MkmOji2/GJ0kpVXK5PWQAWTp8CZ2MVuMMRmvNAgRZm65pGwNXkLPNfhkWE02lZUsvpTnh2YrgXbtj0BnK2k8kFDkaDnCoQneAUK/H/IJcV1uZl3SKgrqop5Tjs8bOJGU9n1dFq+3IoX3ZpJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYj3mnjj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709646719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HuPJFjAWsKypg8ZeoyYOV15NoGLVMPS18P+BxsXUyRk=;
	b=OYj3mnjjTt/MEcbI/fhO+wB+D2cCvFsH9/HQAZnYPitt+H5W9W4Q+ImVh2/ZGjMZ4XqLhS
	hD4pc5XQewaAfswwWMFSt8kb3RQ7ZIY4To2X0kYdBh3wByYFHfQZkXTdVI1UuE65kGludy
	pXldZGoq07DZe+FeZdjSfBQggrjDZ/w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-Jg5EqMjiNLyiWk3H3lZmLg-1; Tue, 05 Mar 2024 08:51:58 -0500
X-MC-Unique: Jg5EqMjiNLyiWk3H3lZmLg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso29227345e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709646717; x=1710251517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuPJFjAWsKypg8ZeoyYOV15NoGLVMPS18P+BxsXUyRk=;
        b=BSDBT5O+fyOrxG6EgF3sEFAjZlKWdN33QZy88vrpUjVNjqDccsK66/b7XZxSqxcyCF
         CYaQhkic5fp9UJhPXRETNJEaZ+e3oUt/vojKJRFTcegmSGknC67pA81S73m2JcdQZd5j
         0+2FEMzeIWGoVe6m3u1ka1DjzfK6z2a1bxZ8uYEwd3qpH9ir3zAm6zsoxRiwb7cWYcXJ
         YCnE6TS8bmKKOMY22rwZUOWqpVLV+8LdB/5EUHy3PWNakM39UnrErq/Ie7epEB4TN3KI
         X+BnzSOGDVBx1lW5bL2KKEEb3v/J8m4jw9bXJe8pG4Ja/or5i48wJV5sdVtaE343JYbg
         c1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXhNwiHaSlotXAXSDz/g4Z6QzB1MJE+xeyfN7h+im1A5Pz73xMREfD7Vk2H1NbkWJLSCokS3gdmKIfNd9D1iBV06q52HK1agpjWHtKf
X-Gm-Message-State: AOJu0Yw96dl+bAXQHe11egspk5qiGlKF32ccRBdh5wpz4C9ymZVMyU4O
	L0dOk67NxWvtx+nvG6spHVnKDIHeivtq2WWWk5WiExU0yAwOzM3fHghfjP9sJTE8iupC8BRbl4g
	FjKMt0dmuGF0dtlsZlRj+OTDT1S6Z2r2Ee41sZQrdMtI2PIW6pWAoFTUmrv9tzQ==
X-Received: by 2002:a05:600c:3111:b0:412:f09d:67ef with SMTP id g17-20020a05600c311100b00412f09d67efmr180232wmo.10.1709646716857;
        Tue, 05 Mar 2024 05:51:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGT+v94cNlPuRn9BCoWkkRgnChsa4Zxxoh4qGBCqYAJX2s5n9hG4uCCziRT82Hx/7k/SRmDOA==
X-Received: by 2002:a05:600c:3111:b0:412:f09d:67ef with SMTP id g17-20020a05600c311100b00412f09d67efmr180212wmo.10.1709646716359;
        Tue, 05 Mar 2024 05:51:56 -0800 (PST)
Received: from toolbox.fritz.box ([2001:9e8:898a:6d00:3d3a:c29e:3324:fc0e])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c500600b00412ee8e2f2asm1519587wmr.9.2024.03.05.05.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:51:56 -0800 (PST)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: 
Cc: Harry Wentland <harry.wentland@amd.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/drm_connector: Document Colorspace property variants
Date: Tue,  5 Mar 2024 14:51:49 +0100
Message-ID: <20240305135155.231687-1-sebastian.wick@redhat.com>
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

v2:
 * Talk about "pixel operation properties" that user space configures
 * Mention that user space is responsible for checking the EDID for sink
   support
 * Make it clear that drivers can choose between RGB and YCbCr on their
   own

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
---
 drivers/gpu/drm/drm_connector.c | 79 +++++++++++++++++++++++++--------
 include/drm/drm_connector.h     |  8 ----
 2 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index b0516505f7ae..65cdcc7d22db 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2147,24 +2147,67 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
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
+ *	This property is used to inform the driver about the color encoding
+ *	user space configured the pixel operation properties to produce.
+ *	The variants set the colorimetry, transfer characteristics, and which
+ *	YCbCr conversion should be used when necessary.
+ *	The transfer characteristics from HDR_OUTPUT_METADATA takes precedence
+ *	over this property.
+ *	User space always configures the pixel operation properties to produce
+ *	full quantization range data (see the Broadcast RGB property).
+ *
+ *	Drivers inform the sink about what colorimetry, transfer
+ *	characteristics, YCbCr conversion, and quantization range to expect
+ *	(this can depend on the output mode, output format and other
+ *	properties). Drivers also convert the user space provided data to what
+ *	the sink expects.
+ *
+ *	User space has to check if the sink supports all of the possible
+ *	colorimetries that the driver is allowed to pick by parsing the EDID.
+ *
+ *	For historical reasons this property exposes a number of variants which
+ *	result in undefined behavior.
+ *
+ *	Default:
+ *		The behavior is driver-specific.
+ *	BT2020_RGB:
+ *	BT2020_YCC:
+ *		User space configures the pixel operation properties to produce
+ *		RGB content with Rec. ITU-R BT.2020 colorimetry, Rec.
+ *		ITU-R BT.2020 (Table 4, RGB) transfer characteristics and full
+ *		quantization range.
+ *		User space can use the HDR_OUTPUT_METADATA property to set the
+ *		transfer characteristics to PQ (Rec. ITU-R BT.2100 Table 4) or
+ *		HLG (Rec. ITU-R BT.2100 Table 5) in which case, user space
+ *		configures pixel operation properties to produce content with
+ *		the respective transfer characteristics.
+ *		User space has to make sure the sink supports Rec.
+ *		ITU-R BT.2020 R'G'B' and Rec. ITU-R BT.2020 Y'C'BC'R
+ *		colorimetry.
+ *		Drivers can configure the sink to use an RGB format, tell the
+ *		sink to expect Rec. ITU-R BT.2020 R'G'B' colorimetry and convert
+ *		to the appropriate quantization range.
+ *		Drivers can configure the sink to use a YCbCr format, tell the
+ *		sink to expect Rec. ITU-R BT.2020 Y'C'BC'R colorimetry, convert
+ *		to YCbCr using the Rec. ITU-R BT.2020 non-constant luminance
+ *		conversion matrix and convert to the appropriate quantization
+ *		range.
+ *		The variants BT2020_RGB and BT2020_YCC are equivalent and the
+ *		driver chooses between RGB and YCbCr on its own.
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


