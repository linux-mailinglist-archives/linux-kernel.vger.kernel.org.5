Return-Path: <linux-kernel+bounces-21224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D820828C40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC48288D99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751FE3C46E;
	Tue,  9 Jan 2024 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="Qx1js/bV"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FC03D55D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e4d515c9aso15956565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704823908; x=1705428708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt0c3XMcNoO4kFPW/v1FdVP0dkTx8zEwl7ZVK3nsems=;
        b=Qx1js/bVClfb+QSGHwM2n4FN/oVWIBTM1WHt0MS/KQ8T0UKWHg9UcJa/XYtoVdTI6Q
         7DvKY0f3gFZPPGAJOtj3ovMoLox6FPjoc0hgtzCINOKlFp32nrnQVrCyE557C5YiYBLY
         x20U4fe+9fTaNZEmHnxA8sVsWA0zRIFNN4HQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704823908; x=1705428708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qt0c3XMcNoO4kFPW/v1FdVP0dkTx8zEwl7ZVK3nsems=;
        b=cLTsggmTkWz2KUzoTStlb4IYPhA/uwIbg4SOKbgTvXHMcy9MOzoOQaHv/Ki7eYuE50
         +AhZ3dSb3S+5cmHB0fAkfa2QoElzzZfbRznavPSDZsSGq/akrYGRFOkn5hVCKHooo4oh
         VubTzjZsnXXY47XIWkAs5l4v8rJ/I5EW4nf8Ts8UAK21iJsmKxpVtc0J9M4xynMV6Ide
         xGYmISSg1s3zf7b4iJYWO1o2c9PrP/gRI3XWfVXu+O7AJs49V1o6ZrxsqOCUDmzpYOZ1
         khu874lLRRFQaxLlaxxt6arThttUDGpKSxNtIQElwaBoXINpONu7sBOMjIvDc+a8r3XT
         UdCg==
X-Gm-Message-State: AOJu0YySuVcm7xgi9sOyp4CD0AHQ2S1qwe3j1EiXEncBTsOLP4FIwLfy
	aDvUdyrSa4Lb+OGJz0uCLUm2t68g2HynTA==
X-Google-Smtp-Source: AGHT+IFgwClqgXbf2UT4umhrLU7jfpYqaURbrVxuW4v/iRn1SN3rphz7JKJNAvzao7RlEeWaArDvaQ==
X-Received: by 2002:a7b:ca45:0:b0:40e:482d:e718 with SMTP id m5-20020a7bca45000000b0040e482de718mr1724173wml.33.1704823908518;
        Tue, 09 Jan 2024 10:11:48 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id n25-20020a05600c3b9900b0040e527602c8sm2104579wms.9.2024.01.09.10.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:11:48 -0800 (PST)
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
Subject: [PATCH 6/7] drm/amd/display: Add handling for new "preferred color format" property
Date: Tue,  9 Jan 2024 18:11:03 +0000
Message-ID: <20240109181104.1670304-7-andri@yngvason.is>
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

This commit implements the "preferred color format" drm property for the
AMD GPU driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Tested-by: Andri Yngvason <andri@yngvason.is>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++++++++----
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 +++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b44d06c3b1706..262d420877c91 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5522,15 +5522,32 @@ static void fill_stream_properties_from_drm_display_mode(
 	timing_out->h_border_right = 0;
 	timing_out->v_border_top = 0;
 	timing_out->v_border_bottom = 0;
-	/* TODO: un-hardcode */
-	if (drm_mode_is_420_only(info, mode_in)
-			|| (drm_mode_is_420_also(info, mode_in) && aconnector->force_yuv420_output))
+
+	if (connector_state
+			&& (connector_state->preferred_color_format == DRM_COLOR_FORMAT_YCBCR420
+			|| aconnector->force_yuv420_output) && drm_mode_is_420(info, mode_in))
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+	else if (connector_state
+			&& connector_state->preferred_color_format == DRM_COLOR_FORMAT_YCBCR444
+			&& connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
-	else
+	else if (connector_state
+			&& connector_state->preferred_color_format == DRM_COLOR_FORMAT_RGB444
+			&& !drm_mode_is_420_only(info, mode_in))
 		timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
+	else
+		/*
+		 * connector_state->preferred_color_format not possible
+		 * || connector_state->preferred_color_format == 0 (auto)
+		 * || connector_state->preferred_color_format == DRM_COLOR_FORMAT_YCBCR422
+		 */
+		if (drm_mode_is_420_only(info, mode_in))
+			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
+		else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
+				&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
+		else
+			timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
 
 	timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;
 	timing_out->display_color_depth = convert_color_depth_from_display_info(
@@ -7456,6 +7473,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 
 	if (!aconnector->mst_root) {
 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
+		drm_connector_attach_preferred_color_format_property(&aconnector->base);
 		drm_connector_attach_active_color_format_property(&aconnector->base);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a4d1b3ea8f81c..dc8cea0ac2c11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -600,6 +600,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	if (connector->max_bpc_property)
 		drm_connector_attach_max_bpc_property(connector, 8, 16);
 
+	connector->preferred_color_format_property = master->base.preferred_color_format_property;
+	if (connector->preferred_color_format_property)
+		drm_connector_attach_preferred_color_format_property(&aconnector->base);
+
 	connector->active_color_format_property = master->base.active_color_format_property;
 	if (connector->active_color_format_property)
 		drm_connector_attach_active_color_format_property(&aconnector->base);
-- 
2.43.0


