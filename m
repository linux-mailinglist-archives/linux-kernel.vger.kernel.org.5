Return-Path: <linux-kernel+bounces-21219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C9828C33
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1561C242CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D243D3D0B0;
	Tue,  9 Jan 2024 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="NFyOBa68"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0153C6A4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e4f71288bso9849915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704823881; x=1705428681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5TmlSqr2R0DSFOwP1jgxjjJC7p4LGOYCLeSujiTr2s=;
        b=NFyOBa68JSBivYbQH0MOufyWc2LTeC9fzzWCLqo5MyR8S74VtriYTjyi7CbKsmbxBQ
         Jo2vJYt6mR0ObOGPBPS4GUthV+fKNBR5PSDA7TFZB88oVG0yLQ5n4KQ9RohvH3OtjMzM
         ORjB+0Tveacfdk3r8xudlzdIEyKp1O16XIlT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704823881; x=1705428681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5TmlSqr2R0DSFOwP1jgxjjJC7p4LGOYCLeSujiTr2s=;
        b=UjlI3n2DCcABYX77Zku1GgjIFWgqNz4yx+sG2kGLNGFolZLp8ZSjCQ2uFGDpXaPHZ3
         Wt0eDhXypwtdScLrKBC4rSQ+vVvYE3yyJ9lokjCChiunGcYev1RNO+IwOi4B6L+R4Nbc
         AZLC2zZy5JmpEyDPhcEEFAY03PUsOyVmEitk2JpLPjZwiflybYSa69d5j4m5lQrArv3g
         UBjDo6qdNFdCVQCK9bdGVxTISrjbL5dpk4uQewVrvzFFcP5jWwLs3MXrUOL/yYibR6cP
         VNq6U/YdwIpbLy3eaTvF90Rjk0VzLt9p1vm5Y6Ab05xgIVhZHZLYxnxp5fyUZMZUVAU6
         IGMA==
X-Gm-Message-State: AOJu0Yxh50Crrb6xZa2uZ6QDAaU2dPClHq/iSRP4WA34CxuWv2Vjib+7
	JvQxaYvC7IUyqnrThW+mOUA6gN0piOTt0A==
X-Google-Smtp-Source: AGHT+IE8mUwmBNyBZAX/TyOCIvUTmkvOp0uvsitYL/5KGkF2V5MZ5MAl58F6Q1VC6O24Tg7pMyScTA==
X-Received: by 2002:a05:600c:468b:b0:40d:8909:b3a3 with SMTP id p11-20020a05600c468b00b0040d8909b3a3mr2205592wmo.20.1704823881662;
        Tue, 09 Jan 2024 10:11:21 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id n25-20020a05600c3b9900b0040e527602c8sm2104579wms.9.2024.01.09.10.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:11:21 -0800 (PST)
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
Subject: [PATCH 1/7] drm/amd/display: Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check
Date: Tue,  9 Jan 2024 18:10:58 +0000
Message-ID: <20240109181104.1670304-2-andri@yngvason.is>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109181104.1670304-1-andri@yngvason.is>
References: <20240109181104.1670304-1-andri@yngvason.is>
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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c8c00c2a5224a..10e041a3b2545 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5524,10 +5524,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	timing_out->v_border_bottom = 0;
 	/* TODO: un-hardcode */
 	if (drm_mode_is_420_only(info, mode_in)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if (drm_mode_is_420_also(info, mode_in)
-			&& aconnector->force_yuv420_output)
+			|| (drm_mode_is_420_also(info, mode_in) && aconnector->force_yuv420_output))
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-- 
2.43.0


