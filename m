Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C368F7A8709
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjITOh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbjITOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:36:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D29ACCA;
        Wed, 20 Sep 2023 07:36:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0DFC433D9;
        Wed, 20 Sep 2023 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695220593;
        bh=NPcmog8rmIBDaqZDT4O0fzD3K2AFLpEEWCR2cLRhvQQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dFiXFmHUTKnj6NvyMNzPPY+oci/F+xV+LQ0BT0gzWbZry4cOvnWkTDDjCuZWWVMqp
         EtdRGyXIJ9qc4wczWkcRGWYYkNCh3XiREhDdrcQK2GhuvXTKeWfPiYtOv4pQFo+nSw
         qbgQEfKRNENbPuXMBNIQxgXCkMWZLp5Vk5sHOCRTqYtRnyV3vD2e82p7lr8DpKtTY6
         9AnYw2QRvgZvQuG+AEhgpSvKlt6SFBLNTPch7XnT/CTJrmj84sYIJLF3RHFl7lWlRo
         8vgL7aDa97j8/UWtg63Ta7q7t7O31eYGFDkxjXm1awk1Z/81+CZ6eZapKEUUmTvhEb
         ZVNJenYuT84aw==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 20 Sep 2023 16:35:33 +0200
Subject: [PATCH RFC v2 18/37] drm/rockchip: inno_hdmi: Get rid of mode_set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-kms-hdmi-connector-state-v2-18-17932daddd7d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NPcmog8rmIBDaqZDT4O0fzD3K2AFLpEEWCR2cLRhvQQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnczJa1O/2Y9BYrR3B9Yj+f0jvbzEo0Yc3Je48/8G05n
 fYp1+9tRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACay6j4jwztdwXe5TeUX+ENm
 hx2dkF+5bsnfMLVl904urNLf8YV3vS/D//z4IuXYZ3Pc592ZqDZpmcdT843/IwyEvoZWvDQsFav
 ewgYA
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

We're not doing anything special in atomic_mode_set so we can simply
merge it into atomic_enable.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index cc86d273ca4a..4db18195246e 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -490,21 +490,22 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	return 0;
 }
 
-static void inno_hdmi_encoder_mode_set(struct drm_encoder *encoder,
-				       struct drm_crtc_state *crtc_state,
-				       struct drm_connector_state *conn_state)
-{
-	struct drm_display_mode *adj_mode = &crtc_state->adjusted_mode;
-	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
-
-	inno_hdmi_setup(hdmi, adj_mode);
-}
-
 static void inno_hdmi_encoder_enable(struct drm_encoder *encoder,
 				     struct drm_atomic_state *state)
 {
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
 
+	conn_state = drm_atomic_get_new_connector_state(state, &hdmi->connector);
+	if (WARN_ON(!conn_state))
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (WARN_ON(!crtc_state))
+		return;
+
+	inno_hdmi_setup(hdmi, &crtc_state->adjusted_mode);
 	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
 }
 
@@ -533,7 +534,6 @@ static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.atomic_check	= inno_hdmi_encoder_atomic_check,
 	.atomic_enable	= inno_hdmi_encoder_enable,
 	.atomic_disable	= inno_hdmi_encoder_disable,
-	.atomic_mode_set	= inno_hdmi_encoder_mode_set,
 };
 
 static enum drm_connector_status

-- 
2.41.0

