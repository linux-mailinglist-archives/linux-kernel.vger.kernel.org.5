Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C25777D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbjHJQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjHJQEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:04:08 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07272727
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nmKo6EG4yJEeg3szQnnM47rtZ1BHlAw2Ggsh0JxPp4k=; b=fqDAb0Ysn7t4QTFhUBfw5PxJdm
        61jvFta8P0CVulsInztQcTgMcKsDsyogBEIoqsBSfVSzEzlbQILPAMjV8yfJWsnXKgfgNHDWF/svW
        Dkc8oLlyr9+qp5ZnJSrtVkgzJzZFLFDdQdDP++7Pv8jLmnmt4/3Mx3zPSVZYiGr511nc870TWHZ/F
        8lhCQl0n4GzIKqWnaPxnGgRWptvCwaskcpbrhlc2DRqT/0qPlzcLjbTLLM4BssfxdFLFsdVkGvLmB
        iovr8l2MxWglCoM/rjSlLg8rL4wK5b9IMItmlKfs7XdUPxzTcDWOQnDxIGsL8+7kn+RLhoodzr9G0
        D7BkA+sg==;
Received: from [38.44.68.151] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qU88j-00GjYD-5c; Thu, 10 Aug 2023 18:03:57 +0200
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
Subject: [PATCH v2 18/34] drm/amd/display: mark plane as needing reset if color props change
Date:   Thu, 10 Aug 2023 15:02:58 -0100
Message-Id: <20230810160314.48225-19-mwen@igalia.com>
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

From: Joshua Ashton <joshua@froggi.es>

We should reset a plane state if at least one of the color management
properties differs from old and new state.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Joshua Ashton <joshua@froggi.es>
Co-developed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 272974b88cda..78fdd0b95ae8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9524,6 +9524,10 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	 */
 	for_each_oldnew_plane_in_state(state, other, old_other_state, new_other_state, i) {
 		struct amdgpu_framebuffer *old_afb, *new_afb;
+		struct dm_plane_state *dm_new_other_state, *dm_old_other_state;
+
+		dm_new_other_state = to_dm_plane_state(new_other_state);
+		dm_old_other_state = to_dm_plane_state(old_other_state);
 
 		if (other->type == DRM_PLANE_TYPE_CURSOR)
 			continue;
@@ -9560,6 +9564,17 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 		    old_other_state->color_encoding != new_other_state->color_encoding)
 			return true;
 
+		/* HDR/Transfer Function changes. */
+		if (dm_old_other_state->degamma_tf != dm_new_other_state->degamma_tf ||
+		    dm_old_other_state->degamma_lut != dm_new_other_state->degamma_lut ||
+		    dm_old_other_state->hdr_mult != dm_new_other_state->hdr_mult ||
+		    dm_old_other_state->shaper_lut != dm_new_other_state->shaper_lut ||
+		    dm_old_other_state->shaper_tf != dm_new_other_state->shaper_tf ||
+		    dm_old_other_state->lut3d != dm_new_other_state->lut3d ||
+		    dm_old_other_state->blend_lut != dm_new_other_state->blend_lut ||
+		    dm_old_other_state->blend_tf != dm_new_other_state->blend_tf)
+			return true;
+
 		/* Framebuffer checks fall at the end. */
 		if (!old_other_state->fb || !new_other_state->fb)
 			continue;
-- 
2.40.1

