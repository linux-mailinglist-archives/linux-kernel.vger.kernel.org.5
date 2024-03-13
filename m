Return-Path: <linux-kernel+bounces-101928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDF287ACCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5AF1C21626
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEFD12E1EE;
	Wed, 13 Mar 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0JX+tY9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F812E1CE;
	Wed, 13 Mar 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348071; cv=none; b=jQIsARx6Zyd4ijAF75O0nACR7Go1WZvH96FZGvDA+5wAvjGY0O76dzCBDTPSB6QDJLgoja7DgEe6tYDLScZlFNDmC8Gqla2isi6skAo+KNYsLs2PZErSDyANG/Qfl3l4YXRnIItJJIemseiUu0pltNu5tkw8NFXMh6dvTNTsCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348071; c=relaxed/simple;
	bh=FzwpHjy6WjmSc7qANlKnuOG3K9jOS54LN9DawrGFtp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STdAX/HAdzCuQn3GPoW7rUDsxTi7AOzsbDOCAE4ehy7NSkWT5AcHcv6Uyxnzn1s/gZWuKunobwc33JQ9EGhjMLOnBpF6ouLRkjIdrDwygN6dC4rgAJ5DS6oLCghcAgwJdKzzsci11FRtCxcNqDyrAweVObkbiPp3FSXDMBcOFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0JX+tY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC391C433F1;
	Wed, 13 Mar 2024 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348070;
	bh=FzwpHjy6WjmSc7qANlKnuOG3K9jOS54LN9DawrGFtp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0JX+tY9OM2uP0kY+45bL839vEiY/9nlKxEt2c4tw/Q2BrWtgJ29IiAJqJ9flfPlb
	 OUref2SlzXtWw9KpEWOljjQdXa5T1oTHq+1q511fkTkFw5SHKaWaUWdweo8Yo5ABwb
	 AsOvM4FP4JrrsUWB2BIY/vsfjAOmKI29UfLLt6ScFk9vyKr7rbu/4NSH1Ez1fonBqa
	 P8V/XQ+diuZbwvsGQTbKkWXhUnOZbHreuY8lWH+hYrYRnb7pSA+ZiJvAzKs0QoQ70s
	 Wznm0YGrsI6etPMrA2rNOLiyLzLU+Uh6Euoddkk8hIXog7CTVLrdyLh5JTjG35LEz9
	 adLV+4Z7OVVuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Hanghong <hanghong.ma@amd.com>,
	Mark Broadworth <mark.broadworth@amd.com>,
	Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 60/71] drm/amd/display: Wrong colorimetry workaround
Date: Wed, 13 Mar 2024 12:39:46 -0400
Message-ID: <20240313163957.615276-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ma Hanghong <hanghong.ma@amd.com>

[ Upstream commit b1a98cf89a695d36c414653634ea7ba91b6e701f ]

[Why]
For FreeSync HDR, native color space flag in AMD VSIF(BT.709) should be
used when intepreting content and color space flag in VSC or AVI
infoFrame should be ignored. However, it turned out some userspace
application still use color flag in VSC or AVI infoFrame which is
incorrect.

[How]
Transfer function is used when building the VSC and AVI infoFrame. Set
colorimetry to BT.709 when all the following match:

1. Pixel format is YCbCr;
2. In FreeSync 2 HDR, color is COLOR_SPACE_2020_YCBCR;
3. Transfer function is TRANSFER_FUNC_GAMMA_22;

Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Ma Hanghong <hanghong.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: e6a7df96facd ("drm/amd/display: Fix MST Null Ptr for RV")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 5 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 6 ++++++
 drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h   | 3 ++-
 .../gpu/drm/amd/display/modules/info_packet/info_packet.c   | 6 +++++-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index da16048bf1004..bea49befdcacc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5938,6 +5938,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
 	int mode_refresh;
 	int preferred_refresh = 0;
+	enum color_transfer_func tf = TRANSFER_FUNC_UNKNOWN;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dsc_dec_dpcd_caps dsc_caps;
 #endif
@@ -6071,7 +6072,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
 				stream->use_vsc_sdp_for_colorimetry = true;
 		}
-		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space);
+		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
+			tf = TRANSFER_FUNC_GAMMA_22;
+		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
 		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 66923f51037a3..e2f80cd0ca8cb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3038,6 +3038,12 @@ static void set_avi_info_frame(
 		hdmi_info.bits.C0_C1   = COLORIMETRY_EXTENDED;
 	}
 
+	if (pixel_encoding && color_space == COLOR_SPACE_2020_YCBCR &&
+			stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
+		hdmi_info.bits.EC0_EC2 = 0;
+		hdmi_info.bits.C0_C1 = COLORIMETRY_ITU709;
+	}
+
 	/* TODO: un-hardcode aspect ratio */
 	aspect = stream->timing.aspect_ratio;
 
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 1d8b746b02f24..edf5845f6a1f7 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -35,7 +35,8 @@ struct mod_vrr_params;
 
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
-		enum dc_color_space cs);
+		enum dc_color_space cs,
+		enum color_transfer_func tf);
 
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet);
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 27ceba9d6d658..69691058ab898 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -132,7 +132,8 @@ enum ColorimetryYCCDP {
 
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
-		enum dc_color_space cs)
+		enum dc_color_space cs,
+		enum color_transfer_func tf)
 {
 	unsigned int vsc_packet_revision = vsc_packet_undefined;
 	unsigned int i;
@@ -382,6 +383,9 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 				colorimetryFormat = ColorimetryYCC_DP_AdobeYCC;
 			else if (cs == COLOR_SPACE_2020_YCBCR)
 				colorimetryFormat = ColorimetryYCC_DP_ITU2020YCbCr;
+
+			if (cs == COLOR_SPACE_2020_YCBCR && tf == TRANSFER_FUNC_GAMMA_22)
+				colorimetryFormat = ColorimetryYCC_DP_ITU709;
 			break;
 
 		default:
-- 
2.43.0


