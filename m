Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A6777D62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjHJQEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjHJQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:03:51 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B512D56
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HIPCDJSsxwQ4Z7FncOgmAwgXskTUAkWwa/WacW5WCfg=; b=DasqPtZZd1GsKciaNhIXf7/wKr
        6lu3EpJeW8qqWj+o/OhVj9Oxm9tscY3qX4IvAGX3qsRqs1euqkf9OMJLoGQPcUGkXzuWDGPyccfIu
        +La9q8pBs3Me7gfXID+NLzxKfPXdch6GJ+pGDGaB1PiCFahJXdXoaulFTE3q3ZyUOe9yiN8CfGtw3
        sI73KFqPq9boKfOrDMy6t4KhcGimdk1Lq1zNoYv6AJKqYthtpnX5l5hr8uczEsShqo0foo934g3/2
        y22Hm0qc2CpAdwGg1A+MGZrYvECnsldkP9APn2d1sx1INoof1QMqJibs4CGm+soleIYu86uvnlEak
        7aD2+hJA==;
Received: from [38.44.68.151] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qU88L-00GjYD-9m; Thu, 10 Aug 2023 18:03:33 +0200
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
Subject: [PATCH v2 07/34] drm/amd/display: explicitly define EOTF and inverse EOTF
Date:   Thu, 10 Aug 2023 15:02:47 -0100
Message-Id: <20230810160314.48225-8-mwen@igalia.com>
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

Instead of relying on color block names to get the transfer function
intention regarding encoding pixel's luminance, define supported
Electro-Optical Transfer Functions (EOTFs) and inverse EOTFs, that
includes pure gamma or standardized transfer functions.

Suggested-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 19 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 69 +++++++++++++++----
 2 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c749c9cb3d94..f6251ed89684 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -718,14 +718,21 @@ extern const struct amdgpu_ip_block_version dm_ip_block;
 
 enum amdgpu_transfer_function {
 	AMDGPU_TRANSFER_FUNCTION_DEFAULT,
-	AMDGPU_TRANSFER_FUNCTION_SRGB,
-	AMDGPU_TRANSFER_FUNCTION_BT709,
-	AMDGPU_TRANSFER_FUNCTION_PQ,
+	AMDGPU_TRANSFER_FUNCTION_SRGB_EOTF,
+	AMDGPU_TRANSFER_FUNCTION_BT709_EOTF,
+	AMDGPU_TRANSFER_FUNCTION_PQ_EOTF,
 	AMDGPU_TRANSFER_FUNCTION_LINEAR,
 	AMDGPU_TRANSFER_FUNCTION_UNITY,
-	AMDGPU_TRANSFER_FUNCTION_GAMMA22,
-	AMDGPU_TRANSFER_FUNCTION_GAMMA24,
-	AMDGPU_TRANSFER_FUNCTION_GAMMA26,
+	AMDGPU_TRANSFER_FUNCTION_GAMMA22_EOTF,
+	AMDGPU_TRANSFER_FUNCTION_GAMMA24_EOTF,
+	AMDGPU_TRANSFER_FUNCTION_GAMMA26_EOTF,
+	AMDGPU_TRANSFER_FUNCTION_SRGB_INV_EOTF,
+	AMDGPU_TRANSFER_FUNCTION_BT709_INV_EOTF,
+	AMDGPU_TRANSFER_FUNCTION_PQ_INV_EOTF,
+	AMDGPU_TRANSFER_FUNCTION_GAMMA22_INV_EOTF,
+	AMDGPU_TRANSFER_FUNCTION_GAMMA24_INV_EOTF,
+	AMDGPU_TRANSFER_FUNCTION_GAMMA26_INV_EOTF,
+        AMDGPU_TRANSFER_FUNCTION_COUNT
 };
 
 struct dm_plane_state {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 56ce008b9095..cc2187c0879a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -85,18 +85,59 @@ void amdgpu_dm_init_color_mod(void)
 }
 
 #ifdef AMD_PRIVATE_COLOR
-static const struct drm_prop_enum_list amdgpu_transfer_function_enum_list[] = {
-	{ AMDGPU_TRANSFER_FUNCTION_DEFAULT, "Default" },
-	{ AMDGPU_TRANSFER_FUNCTION_SRGB, "sRGB" },
-	{ AMDGPU_TRANSFER_FUNCTION_BT709, "BT.709" },
-	{ AMDGPU_TRANSFER_FUNCTION_PQ, "PQ (Perceptual Quantizer)" },
-	{ AMDGPU_TRANSFER_FUNCTION_LINEAR, "Linear" },
-	{ AMDGPU_TRANSFER_FUNCTION_UNITY, "Unity" },
-	{ AMDGPU_TRANSFER_FUNCTION_GAMMA22, "Gamma 2.2" },
-	{ AMDGPU_TRANSFER_FUNCTION_GAMMA24, "Gamma 2.4" },
-	{ AMDGPU_TRANSFER_FUNCTION_GAMMA26, "Gamma 2.6" },
+static const char * const
+amdgpu_transfer_function_names[] = {
+	[AMDGPU_TRANSFER_FUNCTION_DEFAULT]		= "Default",
+	[AMDGPU_TRANSFER_FUNCTION_LINEAR]		= "Linear",
+	[AMDGPU_TRANSFER_FUNCTION_UNITY]		= "Unity",
+	[AMDGPU_TRANSFER_FUNCTION_SRGB_EOTF]		= "sRGB EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_BT709_EOTF]		= "BT.709 EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_PQ_EOTF]		= "PQ EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_GAMMA22_EOTF]		= "Gamma 2.2 EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_GAMMA24_EOTF]		= "Gamma 2.4 EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_GAMMA26_EOTF]		= "Gamma 2.6 EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_SRGB_INV_EOTF]	= "sRGB inv_EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_BT709_INV_EOTF]	= "BT.709 inv_EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_PQ_INV_EOTF]		= "PQ inv_EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_GAMMA22_INV_EOTF]	= "Gamma 2.2 inv_EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_GAMMA24_INV_EOTF]	= "Gamma 2.4 inv_EOTF",
+	[AMDGPU_TRANSFER_FUNCTION_GAMMA26_INV_EOTF]	= "Gamma 2.6 inv_EOTF",
 };
 
+static const u32 amdgpu_eotf =
+	BIT(AMDGPU_TRANSFER_FUNCTION_SRGB_EOTF) |
+	BIT(AMDGPU_TRANSFER_FUNCTION_BT709_EOTF) |
+	BIT(AMDGPU_TRANSFER_FUNCTION_PQ_EOTF) |
+	BIT(AMDGPU_TRANSFER_FUNCTION_GAMMA22_EOTF) |
+	BIT(AMDGPU_TRANSFER_FUNCTION_GAMMA24_EOTF) |
+	BIT(AMDGPU_TRANSFER_FUNCTION_GAMMA26_EOTF);
+
+static struct drm_property *
+amdgpu_create_tf_property(struct drm_device *dev,
+			  const char *name,
+			  u32 supported_tf)
+{
+	u32 transfer_functions = supported_tf |
+				 BIT(AMDGPU_TRANSFER_FUNCTION_DEFAULT) |
+				 BIT(AMDGPU_TRANSFER_FUNCTION_LINEAR) |
+				 BIT(AMDGPU_TRANSFER_FUNCTION_UNITY);
+	struct drm_prop_enum_list enum_list[AMDGPU_TRANSFER_FUNCTION_COUNT];
+	int i, len;
+
+	len = 0;
+	for (i = 0; i < AMDGPU_TRANSFER_FUNCTION_COUNT; i++) {
+		if ((transfer_functions & BIT(i)) == 0)
+			continue;
+
+		enum_list[len].type = i;
+		enum_list[len].name = amdgpu_transfer_function_names[i];
+		len++;
+	}
+
+	return drm_property_create_enum(dev, DRM_MODE_PROP_ENUM,
+					name, enum_list, len);
+}
+
 int
 amdgpu_dm_create_color_properties(struct amdgpu_device *adev)
 {
@@ -116,11 +157,9 @@ amdgpu_dm_create_color_properties(struct amdgpu_device *adev)
 		return -ENOMEM;
 	adev->mode_info.plane_degamma_lut_size_property = prop;
 
-	prop = drm_property_create_enum(adev_to_drm(adev),
-					DRM_MODE_PROP_ENUM,
-					"AMD_PLANE_DEGAMMA_TF",
-					amdgpu_transfer_function_enum_list,
-					ARRAY_SIZE(amdgpu_transfer_function_enum_list));
+	prop = amdgpu_create_tf_property(adev_to_drm(adev),
+					 "AMD_PLANE_DEGAMMA_TF",
+					 amdgpu_eotf);
 	if (!prop)
 		return -ENOMEM;
 	adev->mode_info.plane_degamma_tf_property = prop;
-- 
2.40.1

