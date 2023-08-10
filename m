Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E991777DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbjHJQHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbjHJQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:06:45 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1242F3A85
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yHq44umxbz72Rz20XH2iZBLZvHRwkDfszD2Vw3Zd6YQ=; b=kit+Ut9J060t8AHo+kdeRRtW83
        esElv5o5fK0t51UmcWOjxpqDo1Z/xghlfWB8/5CyBb3rHa3kLLpi6YoXl/5rQjbPxdlGyH6yFEXwY
        2IGwBzuxDNJWuVX7xmeUVMyhPPPN7VGqjM3E80i6qNzxQRIfQZJZB28A9YlG5kd9V0Ruk5n48aGCr
        BZdcf5PdluDxGxNgTRgd09CmGYA98QT1x31nqbZoraltAfDLk3arBIqw/QmaGRGZDas1K1eU/mfck
        ryIm6EsaOhOY8ZWudDPTialNvePMUYkRFJc6QHb9MOblFdd0PRzzjocTXCi31NCK9T3rRMOoGgUzJ
        7rbFJ9ag==;
Received: from [38.44.68.151] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qU89F-00GjYD-Ia; Thu, 10 Aug 2023 18:04:29 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Simon Ser <contact@emersion.fr>, kernel-dev@igalia.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/34] drm/amd/display: add plane CTM support
Date:   Thu, 10 Aug 2023 15:03:13 -0100
Message-Id: <20230810160314.48225-34-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810160314.48225-1-mwen@igalia.com>
References: <20230810160314.48225-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map the plane CTM driver-specific property to DC plane, instead of DC
stream. The remaining steps to program DPP block are already implemented
on DC shared-code.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dfe61c5ed49e..f239410234b3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9578,6 +9578,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 		if (dm_old_other_state->degamma_tf != dm_new_other_state->degamma_tf ||
 		    dm_old_other_state->degamma_lut != dm_new_other_state->degamma_lut ||
 		    dm_old_other_state->hdr_mult != dm_new_other_state->hdr_mult ||
+		    dm_old_other_state->ctm != dm_new_other_state->ctm ||
 		    dm_old_other_state->shaper_lut != dm_new_other_state->shaper_lut ||
 		    dm_old_other_state->shaper_tf != dm_new_other_state->shaper_tf ||
 		    dm_old_other_state->lut3d != dm_new_other_state->lut3d ||
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 86a918ab82be..7ff329101fd4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1158,6 +1158,8 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 				      struct dc_plane_state *dc_plane_state)
 {
 	struct amdgpu_device *adev = drm_to_adev(crtc->base.state->dev);
+	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane_state);
+	struct drm_color_ctm *ctm = NULL;
 	struct dc_color_caps *color_caps = NULL;
 	bool has_crtc_cm_degamma;
 	int ret;
@@ -1209,6 +1211,29 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 			return ret;
 	}
 
+	/* Setup CRTC CTM. */
+	if (dm_plane_state->ctm) {
+		ctm = (struct drm_color_ctm *)dm_plane_state->ctm->data;
+
+		/*
+		 * So far, if we have both plane and CRTC CTM, plane CTM takes
+		 * the priority and we discard data for CRTC CTM, as
+		 * implemented in dcn10_program_gamut_remap().  However, we
+		 * have MPC gamut_remap_matrix from DCN3 family, therefore we
+		 * can remap MPC programing of the matrix to MPC block and
+		 * provide support for both DPP and MPC matrix at the same
+		 * time.
+		 */
+		__drm_ctm_to_dc_matrix(ctm, dc_plane_state->gamut_remap_matrix.matrix);
+
+		dc_plane_state->gamut_remap_matrix.enable_remap = true;
+		dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
+	} else {
+		/* Bypass CTM. */
+		dc_plane_state->gamut_remap_matrix.enable_remap = false;
+		dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
+	}
+
 	return amdgpu_dm_plane_set_color_properties(plane_state,
 						    dc_plane_state, color_caps);
 }
-- 
2.40.1

