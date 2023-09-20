Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB37A8734
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjITOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjITOhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:37:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A157B1718;
        Wed, 20 Sep 2023 07:37:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC105C433CB;
        Wed, 20 Sep 2023 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695220627;
        bh=TGSMVN8rfPhwS5amDVMAYsc9HM0SUQlWIoXQfpiVcYQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OrPevwjvY7nCca+nEY+ZoXHY2KLWmgoGSwcemuq07e6T6K3nCIJRL76f5Tx3fG1Q+
         IFVR1BV3roZYB05WzpTtYOcemKrR8HytpJTnKd4ilnzwBndtWNytCEPM1gnygBOWUX
         PNgndcKT28BNCNlLCUTt2nD3CZY64rb3egVb0uYStWxS1EyQ9zxjP1/lyT+D5r2H/Y
         B5AMW0Z5vrC07ajos6GWkzHiNcj/bonVNBw2PQu+T7ZfIM7ptRhirQh4X/NkHWqs8r
         Q2cBeZAfcUnqMpYLWVr71sazcVA64rFi9/LfYQp6vJQ5qFo+WzqSAkPqS58tfR9vyl
         xnDTbIhLP7XMQ==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 20 Sep 2023 16:35:45 +0200
Subject: [PATCH RFC v2 30/37] drm/rockchip: inno_hdmi: Switch to infoframe
 type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-kms-hdmi-connector-state-v2-30-17932daddd7d@kernel.org>
References: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
In-Reply-To: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5167; i=mripard@kernel.org;
 h=from:subject:message-id; bh=TGSMVN8rfPhwS5amDVMAYsc9HM0SUQlWIoXQfpiVcYQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnczFbRLrt2//i3u7ThVGGtpDST/LXeczP+XxeV/LNRX
 0Ql1n9hRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACbyvpHhf4ajutzefXMuLTsT
 s/D56eMcrutkMjet2ePXod1k9O/kMzWGvxIat3iyPilPczWf+2ap5Gn2BdelvzpaNz14wmC3Y+b
 h91wA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inno_hdmi driver relies on its own internal infoframe type matching
the hardware.

This works fine, but in order to make further reworks easier, let's
switch to the HDMI spec definition of those types.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 71 +++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index bc7fb1278cb2..ed1d10efbef4 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -156,61 +156,80 @@ static void inno_hdmi_reset(struct inno_hdmi *hdmi)
 	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
 }
 
+static u32 inno_hdmi_get_frame_index(struct inno_hdmi *hdmi,
+				    enum hdmi_infoframe_type type)
+{
+	struct drm_device *drm = hdmi->connector.dev;
+
+	switch (type) {
+	case HDMI_INFOFRAME_TYPE_VENDOR:
+		return INFOFRAME_VSI;
+	case HDMI_INFOFRAME_TYPE_AVI:
+		return INFOFRAME_AVI;
+	default:
+		drm_err(drm, "Unknown infoframe type: %u\n", type);
+	}
+
+	return 0;
+}
+
 static u32 inno_hdmi_get_frame_mask(struct inno_hdmi *hdmi,
-				    u32 frame_index)
+				    enum hdmi_infoframe_type type)
 {
 	struct drm_device *drm = hdmi->connector.dev;
 
-	switch (frame_index) {
-	case INFOFRAME_VSI:
+	switch (type) {
+	case HDMI_INFOFRAME_TYPE_VENDOR:
 		return m_PACKET_VSI_EN;
-	case INFOFRAME_AVI:
+	case HDMI_INFOFRAME_TYPE_AVI:
 		return 0;
 	default:
-		drm_err(drm, "Unknown infoframe type: %u\n", frame_index);
+		drm_err(drm, "Unknown infoframe type: %u\n", type);
 	}
 
 	return 0;
 }
 
 static u32 inno_hdmi_get_frame_disable(struct inno_hdmi *hdmi,
-				       u32 frame_index)
+				       enum hdmi_infoframe_type type)
 {
 	struct drm_device *drm = hdmi->connector.dev;
 
-	switch (frame_index) {
-	case INFOFRAME_VSI:
+	switch (type) {
+	case HDMI_INFOFRAME_TYPE_VENDOR:
 		return v_PACKET_VSI_EN(0);
-	case INFOFRAME_AVI:
+	case HDMI_INFOFRAME_TYPE_AVI:
 		return 0;
 	default:
-		drm_err(drm, "Unknown infoframe type: %u\n", frame_index);
+		drm_err(drm, "Unknown infoframe type: %u\n", type);
 	}
 
 	return 0;
 }
 
 static u32 inno_hdmi_get_frame_enable(struct inno_hdmi *hdmi,
-				      u32 frame_index)
+				      enum hdmi_infoframe_type type)
 {
 	struct drm_device *drm = hdmi->connector.dev;
 
-	switch (frame_index) {
-	case INFOFRAME_VSI:
+	switch (type) {
+	case HDMI_INFOFRAME_TYPE_VENDOR:
 		return v_PACKET_VSI_EN(1);
-	case INFOFRAME_AVI:
+	case HDMI_INFOFRAME_TYPE_AVI:
 		return 0;
 	default:
-		drm_err(drm, "Unknown infoframe type: %u\n", frame_index);
+		drm_err(drm, "Unknown infoframe type: %u\n", type);
 	}
 
 	return 0;
 }
 
-static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi, u32 frame_index)
+static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi,
+				    enum hdmi_infoframe_type type)
 {
-	u32 disable = inno_hdmi_get_frame_disable(hdmi, frame_index);
-	u32 mask = inno_hdmi_get_frame_mask(hdmi, frame_index);
+	u32 frame_index = inno_hdmi_get_frame_index(hdmi, type);
+	u32 disable = inno_hdmi_get_frame_disable(hdmi, type);
+	u32 mask = inno_hdmi_get_frame_mask(hdmi, type);
 
 	if (mask)
 		hdmi_modb(hdmi, HDMI_PACKET_SEND_AUTO, mask, disable);
@@ -219,14 +238,14 @@ static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi, u32 frame_index)
 }
 
 static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi,
-				  union hdmi_infoframe *frame, u32 frame_index)
+				  union hdmi_infoframe *frame, enum hdmi_infoframe_type type)
 {
-	u32 enable = inno_hdmi_get_frame_enable(hdmi, frame_index);
-	u32 mask = inno_hdmi_get_frame_mask(hdmi, frame_index);
+	u32 enable = inno_hdmi_get_frame_enable(hdmi, type);
+	u32 mask = inno_hdmi_get_frame_mask(hdmi, type);
 	u8 packed_frame[HDMI_MAXIMUM_INFO_FRAME_SIZE];
 	ssize_t rc, i;
 
-	inno_hdmi_disable_frame(hdmi, frame_index);
+	inno_hdmi_disable_frame(hdmi, type);
 
 	rc = hdmi_infoframe_pack(frame, packed_frame,
 				 sizeof(packed_frame));
@@ -253,11 +272,11 @@ static int inno_hdmi_config_video_vsi(struct inno_hdmi *hdmi,
 							 &hdmi->connector,
 							 mode);
 	if (rc) {
-		inno_hdmi_disable_frame(hdmi, INFOFRAME_VSI);
+		inno_hdmi_disable_frame(hdmi, HDMI_INFOFRAME_TYPE_VENDOR);
 		return rc;
 	}
 
-	return inno_hdmi_upload_frame(hdmi, &frame, INFOFRAME_VSI);
+	return inno_hdmi_upload_frame(hdmi, &frame, HDMI_INFOFRAME_TYPE_VENDOR);
 }
 
 static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
@@ -270,13 +289,13 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 						      &hdmi->connector,
 						      mode);
 	if (rc) {
-		inno_hdmi_disable_frame(hdmi, INFOFRAME_AVI);
+		inno_hdmi_disable_frame(hdmi, HDMI_INFOFRAME_TYPE_AVI);
 		return rc;
 	}
 
 	frame.avi.colorspace = HDMI_COLORSPACE_RGB;
 
-	return inno_hdmi_upload_frame(hdmi, &frame, INFOFRAME_AVI);
+	return inno_hdmi_upload_frame(hdmi, &frame, HDMI_INFOFRAME_TYPE_AVI);
 }
 
 static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)

-- 
2.41.0

