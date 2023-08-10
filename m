Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C30C777D89
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbjHJQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjHJQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:04:03 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4B6270A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RBq3zrPlKV7Z/TpdqMJPw3e+LzkaiVaJANcVurw3tUQ=; b=J5w2BI5xVpyTZVFCBbkSKaTly1
        N0cGwICKLPJimvAoF6jkU0v1ammmhYg8WXFwWElktQZXGYmsPdpnoFeDOA1+FbpaqCcZY2321yPLD
        XJXjULxBcjIl3q2stsUtligrYcJwmcq3H6nAhvliMx/EuPO3HEXlv6y3aHYj1v6OLjQ7zEqzT71Iy
        HK4JtxE6ABVQFMB5VUF1kUL2y42JkLOHdtbcFmYmHAIs6+dldXstA2JYE3YTSfTswmuxQaLuJQNo5
        OCpSD3DIW+pXfkAH0GsxYoas7p/GQ/IdX9/1N0qyFQN6alNMBnnJwB5gO6QEPM5Sq7izz1Ef0G6pz
        LVD04nfg==;
Received: from [38.44.68.151] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qU88c-00GjYD-LZ; Thu, 10 Aug 2023 18:03:50 +0200
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
Subject: [PATCH v2 15/34] drm/amd/display: encapsulate atomic regamma operation
Date:   Thu, 10 Aug 2023 15:02:55 -0100
Message-Id: <20230810160314.48225-16-mwen@igalia.com>
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

We will wire up MPC 3D LUT to DM CRTC color pipeline in the next patch,
but so far, only for atomic interface. By checking
set_output_transfer_func in DC drivers with MPC 3D LUT support, we can
verify that regamma is only programmed when 3D LUT programming fails. As
a groundwork to introduce 3D LUT programming and better understand each
step, detach atomic regamma programming from the crtc colocr updating
code.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 53 ++++++++++++-------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 0a9aa162d4a0..c0bf55416b4d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -503,6 +503,36 @@ static int __set_output_tf(struct dc_transfer_func *func,
 	return res ? 0 : -ENOMEM;
 }
 
+static int amdgpu_dm_set_atomic_regamma(struct dc_stream_state *stream,
+					const struct drm_color_lut *regamma_lut,
+					uint32_t regamma_size, bool has_rom)
+{
+	struct dc_transfer_func *out_tf = stream->out_transfer_func;
+	int ret = 0;
+
+	if (regamma_size) {
+		/* CRTC RGM goes into RGM LUT.
+		 *
+		 * Note: there is no implicit sRGB regamma here. We are using
+		 * degamma calculation from color module to calculate the curve
+		 * from a linear base.
+		 */
+		out_tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+		out_tf->tf = TRANSFER_FUNCTION_LINEAR;
+
+		ret = __set_output_tf(out_tf, regamma_lut, regamma_size, has_rom);
+	} else {
+		/*
+		 * No CRTC RGM means we can just put the block into bypass
+		 * since we don't have any plane level adjustments using it.
+		 */
+		out_tf->type = TF_TYPE_BYPASS;
+		out_tf->tf = TRANSFER_FUNCTION_LINEAR;
+	}
+
+	return ret;
+}
+
 /**
  * __set_input_tf - calculates the input transfer function based on expected
  * input space.
@@ -650,27 +680,12 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 				    regamma_size, has_rom);
 		if (r)
 			return r;
-	} else if (has_regamma) {
-		/* CRTC RGM goes into RGM LUT.
-		 *
-		 * Note: there is no implicit sRGB regamma here. We are using
-		 * degamma calculation from color module to calculate the curve
-		 * from a linear base.
-		 */
-		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
-		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
-
-		r = __set_output_tf(stream->out_transfer_func, regamma_lut,
-				    regamma_size, has_rom);
+	} else {
+		regamma_size = has_regamma ? regamma_size : 0;
+		r = amdgpu_dm_set_atomic_regamma(stream, regamma_lut,
+						 regamma_size, has_rom);
 		if (r)
 			return r;
-	} else {
-		/*
-		 * No CRTC RGM means we can just put the block into bypass
-		 * since we don't have any plane level adjustments using it.
-		 */
-		stream->out_transfer_func->type = TF_TYPE_BYPASS;
-		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
 	}
 
 	/*
-- 
2.40.1

