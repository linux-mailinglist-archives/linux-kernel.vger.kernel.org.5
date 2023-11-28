Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0A7FB7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjK1K31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjK1K2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:28:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A21FC4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:26:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A54C433CB;
        Tue, 28 Nov 2023 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701167168;
        bh=j0kuHfqXTtY8F7hrGO9Pbcf8nYj5w/LWDfi3cdsMJFw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GreJCsxor3J3MaN2sdm9FGAyljzhQha5IG6DygLFv/9gxFDNpzjiBMFDGXXcbkY6n
         1IUL1yg4aL5D7IR9zlTVa9O97MaycX+Jt+1mQFImpUYj9k48lJkg0oc8qw7eSVtw2s
         HMMzF39qrn157fuHKHJctEq2jFSfEmW1Y4vmZEOhU2QeZhI1CGXW6wqZqobVATO14g
         9bADjIANqLoh9JUuvSa6X06RhFn3+W9WErCxcbeik3dwL9A4Ype0rqyhH88A5Rsfv6
         ncv+fxZhO/BVKg3DkBXPFAlgM148KuLYrejOVVObimJgskEBrHRv7Q5LJt7nrq5pSj
         YB8EJmbHaImNA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 28 Nov 2023 11:24:48 +0100
Subject: [PATCH v4 37/45] drm/rockchip: inno_hdmi: Create mask retrieval
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-kms-hdmi-connector-state-v4-37-c7602158306e@kernel.org>
References: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
In-Reply-To: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4130; i=mripard@kernel.org;
 h=from:subject:message-id; bh=j0kuHfqXTtY8F7hrGO9Pbcf8nYj5w/LWDfi3cdsMJFw=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmp+y8/j3Uw/9oUEdr3eXl94sJ7/yp+TebRZnzj7fpwR
 /B8v68pHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZiIhRkjw1zG43u2px/d3VSs
 1J3fen13royOHK9FQs2X5olPtkQbz2VkOM2jefINT2bij/xp+45YvfeZYRwacGjOz4n/NOyfLPz
 +gxEA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register mask and bits to enable or disable a given infoframe
depends on its type.

This is currently passed as an argument to the function that writes an
infoframe, but let's create a helper function to retrieve them based on
the type to make further reworks easier.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 75 ++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index e3a421d98dd4..bc7fb1278cb2 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -156,10 +156,62 @@ static void inno_hdmi_reset(struct inno_hdmi *hdmi)
 	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
 }
 
-static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi,
-				    u32 frame_index,
-				    u32 mask, u32 disable)
+static u32 inno_hdmi_get_frame_mask(struct inno_hdmi *hdmi,
+				    u32 frame_index)
 {
+	struct drm_device *drm = hdmi->connector.dev;
+
+	switch (frame_index) {
+	case INFOFRAME_VSI:
+		return m_PACKET_VSI_EN;
+	case INFOFRAME_AVI:
+		return 0;
+	default:
+		drm_err(drm, "Unknown infoframe type: %u\n", frame_index);
+	}
+
+	return 0;
+}
+
+static u32 inno_hdmi_get_frame_disable(struct inno_hdmi *hdmi,
+				       u32 frame_index)
+{
+	struct drm_device *drm = hdmi->connector.dev;
+
+	switch (frame_index) {
+	case INFOFRAME_VSI:
+		return v_PACKET_VSI_EN(0);
+	case INFOFRAME_AVI:
+		return 0;
+	default:
+		drm_err(drm, "Unknown infoframe type: %u\n", frame_index);
+	}
+
+	return 0;
+}
+
+static u32 inno_hdmi_get_frame_enable(struct inno_hdmi *hdmi,
+				      u32 frame_index)
+{
+	struct drm_device *drm = hdmi->connector.dev;
+
+	switch (frame_index) {
+	case INFOFRAME_VSI:
+		return v_PACKET_VSI_EN(1);
+	case INFOFRAME_AVI:
+		return 0;
+	default:
+		drm_err(drm, "Unknown infoframe type: %u\n", frame_index);
+	}
+
+	return 0;
+}
+
+static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi, u32 frame_index)
+{
+	u32 disable = inno_hdmi_get_frame_disable(hdmi, frame_index);
+	u32 mask = inno_hdmi_get_frame_mask(hdmi, frame_index);
+
 	if (mask)
 		hdmi_modb(hdmi, HDMI_PACKET_SEND_AUTO, mask, disable);
 
@@ -167,13 +219,14 @@ static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi,
 }
 
 static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi,
-				  union hdmi_infoframe *frame, u32 frame_index,
-				  u32 mask, u32 disable, u32 enable)
+				  union hdmi_infoframe *frame, u32 frame_index)
 {
+	u32 enable = inno_hdmi_get_frame_enable(hdmi, frame_index);
+	u32 mask = inno_hdmi_get_frame_mask(hdmi, frame_index);
 	u8 packed_frame[HDMI_MAXIMUM_INFO_FRAME_SIZE];
 	ssize_t rc, i;
 
-	inno_hdmi_disable_frame(hdmi, frame_index, mask, disable);
+	inno_hdmi_disable_frame(hdmi, frame_index);
 
 	rc = hdmi_infoframe_pack(frame, packed_frame,
 				 sizeof(packed_frame));
@@ -200,13 +253,11 @@ static int inno_hdmi_config_video_vsi(struct inno_hdmi *hdmi,
 							 &hdmi->connector,
 							 mode);
 	if (rc) {
-		inno_hdmi_disable_frame(hdmi, INFOFRAME_VSI,
-					m_PACKET_VSI_EN, v_PACKET_VSI_EN(0));
+		inno_hdmi_disable_frame(hdmi, INFOFRAME_VSI);
 		return rc;
 	}
 
-	return inno_hdmi_upload_frame(hdmi, &frame, INFOFRAME_VSI,
-		m_PACKET_VSI_EN, v_PACKET_VSI_EN(0), v_PACKET_VSI_EN(1));
+	return inno_hdmi_upload_frame(hdmi, &frame, INFOFRAME_VSI);
 }
 
 static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
@@ -219,13 +270,13 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 						      &hdmi->connector,
 						      mode);
 	if (rc) {
-		inno_hdmi_disable_frame(hdmi, INFOFRAME_AVI, 0, 0);
+		inno_hdmi_disable_frame(hdmi, INFOFRAME_AVI);
 		return rc;
 	}
 
 	frame.avi.colorspace = HDMI_COLORSPACE_RGB;
 
-	return inno_hdmi_upload_frame(hdmi, &frame, INFOFRAME_AVI, 0, 0, 0);
+	return inno_hdmi_upload_frame(hdmi, &frame, INFOFRAME_AVI);
 }
 
 static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)

-- 
2.41.0

