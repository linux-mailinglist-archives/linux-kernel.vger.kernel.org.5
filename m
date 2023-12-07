Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B5B808D53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443654AbjLGPvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443733AbjLGPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:51:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7992691
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:50:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5A8C433AB;
        Thu,  7 Dec 2023 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701964246;
        bh=1bLue8N/fvBWkSCqcYBq0WADSzUFdODNuK87DFi9fQs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GMZEC6Z+6kPQXSMvInDEeVjjxR1IHuEOJUtUJSIeOCjxAbVjEqZ11xajBz/ml24um
         YAftZgYyqcup2XHIR8x0Uxuvyrk2vUOEQzH5J1/wZUDTxwnuhJlFhoGFWDbjrm293B
         ve0bm1QP3u3C939rhN0/QzVLmfDNHAYV5lNQfn3tg72jze4hI/WELOSnJAHUuMyddn
         0+O5T0c0W8GAACvaYYdLLZ/SeNmPfPRPcfPsSBCKEcRRqMooGSJf76IFFCXXGZlL3R
         EdeZZPxk4fOmJOlI3DZge547eFTHAtDtY8PTEgKEOC2uG2JLbT8LkEn+Ba5r3EQf7j
         RXsd2YI9LoZpA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 07 Dec 2023 16:49:49 +0100
Subject: [PATCH v5 26/44] drm/rockchip: inno_hdmi: no need to store vic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-kms-hdmi-connector-state-v5-26-6538e19d634d@kernel.org>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
In-Reply-To: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1bLue8N/fvBWkSCqcYBq0WADSzUFdODNuK87DFi9fQs=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmFL9ty495u2KG42v6L9nLvf0kBedssm+5FsTuzLlbub
 jl7Pi6ko5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABNp2MzwP3PmweNGVRdeMza2
 +2mz38pMavVZslAv7kKi6d/NLs+3yTMy9H+wEEl1P8aSo2dseeTSvcept7qlTm6MePt3QbVugiQ
 LNwA=
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

The mode's VIC is only ever used in the inno_hdmi_setup() function so
there's no need to store it in the main structure.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 4db18195246e..294f0d442c0c 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -28,7 +28,6 @@
 #include "inno_hdmi.h"
 
 struct hdmi_data_info {
-	int vic;
 	bool sink_has_audio;
 	unsigned int enc_in_format;
 	unsigned int enc_out_format;
@@ -443,16 +442,15 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 			   struct drm_display_mode *mode)
 {
 	struct drm_display_info *display = &hdmi->connector.display_info;
-
-	hdmi->hdmi_data.vic = drm_match_cea_mode(mode);
+	u8 vic = drm_match_cea_mode(mode);
 
 	hdmi->hdmi_data.enc_in_format = HDMI_COLORSPACE_RGB;
 	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
 
-	if ((hdmi->hdmi_data.vic == 6) || (hdmi->hdmi_data.vic == 7) ||
-	    (hdmi->hdmi_data.vic == 21) || (hdmi->hdmi_data.vic == 22) ||
-	    (hdmi->hdmi_data.vic == 2) || (hdmi->hdmi_data.vic == 3) ||
-	    (hdmi->hdmi_data.vic == 17) || (hdmi->hdmi_data.vic == 18))
+	if ((vic == 6) || (vic == 7) ||
+	    (vic == 21) || (vic == 22) ||
+	    (vic == 2) || (vic == 3) ||
+	    (vic == 17) || (vic == 18))
 		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_601;
 	else
 		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;

-- 
2.43.0

