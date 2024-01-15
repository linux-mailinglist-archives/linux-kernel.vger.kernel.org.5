Return-Path: <linux-kernel+bounces-26219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768382DCF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4881F2297D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E45182A1;
	Mon, 15 Jan 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="IBpUvbjF"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4DF1802F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e800461baso4099925e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1705334799; x=1705939599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS6uEFfS17C84C/JkCgS0wU+p+hCSHHIkna0klpWICo=;
        b=IBpUvbjFF1VwQWOu945p9bQfwFn7nh+nz7kYiV0HQol0DcWV1O00cuZ1NWKk/gKrs/
         VeRjFFZdMdC4b8qVqyykSsry/Awd15U1H0/R9V4rW2Zx9VNyiuECJ+kWrrqG+a40Wzd+
         3RuPHZwfuzmmdwBLwEEYU8hJg6D5VlZUMMh1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334799; x=1705939599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KS6uEFfS17C84C/JkCgS0wU+p+hCSHHIkna0klpWICo=;
        b=NNFjvH+I1wjMKABjuFzm+TUg0QU1NoPPJcbSVzc3mQQOzRpaDejjjQyVMU7NLwwGrd
         4okwEOtaQfIFHRvJ1SVOZuGppBLs8gdljBGutxFq41tXMmomwXABg1n7NCN75VXTrTyS
         uDmOWD2lRWvh9M4FT4/F4EuNbfppJ+0sNqzKO22g/3T824JZ/GSq3kQIQHd3jSwfL8TT
         nwYyc1+wq9j8nWIfBXP4i1j4LerGfYuiTC+MxPMgGbuCiRawE8cmghAERZpAohG0+w6u
         /W/UF61ZkRqA0PWgJ/5FAoVO3QbVwksM3zgVyIUrCL/EInat08Q/XeJvQYhDxzfqRKg/
         8RrQ==
X-Gm-Message-State: AOJu0YxZMT7hjn5ouA6CC5xjmCOud37FIhA8bzrz0VnatOIWw0Z9TFi5
	h00NDCr3d5pRuiZiDqE8fwcYG5WNk0vdWA==
X-Google-Smtp-Source: AGHT+IGIFWa9QLCBbPDN6iDa6GNEG3d3p28dSrUxb7dRFIBura+H4RnbieSbhVlV5zzIcWtVLi78jg==
X-Received: by 2002:a05:600c:a0e:b0:40c:34f9:6c2a with SMTP id z14-20020a05600c0a0e00b0040c34f96c2amr1712919wmp.159.1705334799361;
        Mon, 15 Jan 2024 08:06:39 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm20174140wmq.44.2024.01.15.08.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:06:38 -0800 (PST)
From: Andri Yngvason <andri@yngvason.is>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Simon Ser <contact@emersion.fr>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Andri Yngvason <andri@yngvason.is>
Subject: [PATCH v2 1/4] drm/amd/display: Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check
Date: Mon, 15 Jan 2024 16:05:51 +0000
Message-ID: <20240115160554.720247-2-andri@yngvason.is>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115160554.720247-1-andri@yngvason.is>
References: <20240115160554.720247-1-andri@yngvason.is>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Werner Sembach <wse@tuxedocomputers.com>

Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check that was performed in the
drm_mode_is_420_only() case, but not in the drm_mode_is_420_also() &&
force_yuv420_output case.

Without further knowledge if YCbCr 4:2:0 is supported outside of HDMI,
there is no reason to use RGB when the display
reports drm_mode_is_420_only() even on a non HDMI connection.

This patch also moves both checks in the same if-case. This  eliminates an
extra else-if-case.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Tested-by: Andri Yngvason <andri@yngvason.is>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f6575d7dee971..cc4d1f7f97b98 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5575,11 +5575,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	timing_out->v_border_bottom = 0;
 	/* TODO: un-hardcode */
 	if (drm_mode_is_420_only(info, mode_in)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if (drm_mode_is_420_also(info, mode_in)
-			&& aconnector
-			&& aconnector->force_yuv420_output)
+			|| (drm_mode_is_420_also(info, mode_in) && aconnector->force_yuv420_output))
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-- 
2.43.0


