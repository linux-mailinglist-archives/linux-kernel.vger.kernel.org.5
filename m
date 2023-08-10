Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581BF777D86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbjHJQFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjHJQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:04:39 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C26F273E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wQwhIXsV1C7gbDckw8GBUxkilhRkaN98qW0UYe6jZI0=; b=Y169RT4TuxloU9TMEAtMBDoZpi
        1hKmFcZxyJlfpjUmBU+KgNQClbQWBj5q71XB/PE032Im0UQb6xFSY7mzERV7xRndFcqdbN2Plai8d
        9SSqrjMohwB2Qoo8ph84O5u0ephdZZUBO/Xc6x46V2YG0zlhDp1MaWv/JCVqwnMKFOCMsIL6gm1hg
        dlDDqstrS5StXAbltqQ8WNmQljqwbHbuRM5RiOYWhf/j7PToz9GD9BuEPOYzz9epbHJuBbQ6UnoxX
        9qInWlC9z6Nun9U1COL8X69R1oP+zMAXSRP6kufL3fY4AkIrHx6OHVHxuOwLcs718uV2Zg/JJY5qy
        ATEk6u8g==;
Received: from [38.44.68.151] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qU88p-00GjYD-KQ; Thu, 10 Aug 2023 18:04:03 +0200
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
Subject: [PATCH v2 21/34] drm/amd/display: reject atomic commit if setting both plane and CRTC degamma
Date:   Thu, 10 Aug 2023 15:03:01 -0100
Message-Id: <20230810160314.48225-22-mwen@igalia.com>
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

DC only has pre-blending degamma caps (plane/DPP) that is currently in
use for CRTC/post-blending degamma, so that we don't have HW caps to
perform plane and CRTC degamma at the same time. Reject atomic updates
when serspace sets both plane and CRTC degamma properties.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index d019a091b08e..5659f88d1f2c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -919,9 +919,20 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 	has_crtc_cm_degamma = (crtc->cm_has_degamma || crtc->cm_is_degamma_srgb);
 
 	ret = __set_dm_plane_degamma(plane_state, dc_plane_state);
-	if (ret != -EINVAL)
+	if (ret == -ENOMEM)
 		return ret;
 
+	/* We only have one degamma block available (pre-blending) for the
+	 * whole color correction pipeline, so that we can't actually perform
+	 * plane and CRTC degamma at the same time. Explicitly reject atomic
+	 * updates when userspace sets both plane and CRTC degamma properties.
+	 */
+	if (has_crtc_cm_degamma && ret != -EINVAL){
+		drm_dbg_kms(crtc->base.crtc->dev,
+			    "doesn't support plane and CRTC degamma at the same time\n");
+			return -EINVAL;
+	}
+
 	/* If we are here, it means we don't have plane degamma settings, check
 	 * if we have CRTC degamma waiting for mapping to pre-blending degamma
 	 * block
-- 
2.40.1

