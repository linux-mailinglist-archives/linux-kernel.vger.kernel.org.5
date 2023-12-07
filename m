Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8836808D07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443672AbjLGPvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443705AbjLGPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:51:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D271BCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:50:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9BFC433B7;
        Thu,  7 Dec 2023 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701964240;
        bh=zO46BEH/qfu0CixrowksluYDZc217GLndsOE/KC1EdM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hMS+0Vqt+qR+tob/ei3PXa4k1sWLRiOz/xAniL7zz3kmt0XcgvIxb3+u6OrJprL0l
         gzpb9o9ikIGNi39tytp671JuL2X5u3aEp5De5BudQ91H7sYeHzv5ujZhRO2/GKRhGb
         siozNngD9OXULyyHeL0dJttcn2lltNs8PDc0qDuogs6Sd8850MnYaSdYq57fJUYfIQ
         ZueYQeYPPbWfj/noqgVerMJqbT9iySwJmHG/y5mm2nRvYHMQx6xz2FJQAJOSTT43u0
         IGi/GUiGfCl7qz2gN89VsN/S/+Pa/yui9WC5amkYPG/LIqspfh8bD9S2Y2y8OqNOtY
         lF6FO6IrPCiTA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 07 Dec 2023 16:49:47 +0100
Subject: [PATCH v5 24/44] drm/rockchip: inno_hdmi: Switch encoder hooks to
 atomic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-kms-hdmi-connector-state-v5-24-6538e19d634d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zO46BEH/qfu0CixrowksluYDZc217GLndsOE/KC1EdM=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmFL9sCNuq3Hbny/sDSv5npaUfMGcoN9KetZDQ8E6P1u
 EJawCygo5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABPZ+Y+R4ZFLBOPt1EC7oJiz
 +2uX7d62evNhv6Dlf/90fi+rW6770I/hf0Dn71NRNyb9O8pwdvOdC8dz5fSsC3fVXswJFPvZsHV
 bCxMA
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

The inno_hdmi encoder still uses the !atomic variants of enable, disable
and modeset. Convert to their atomic equivalents.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 4f5844fc115a..cc86d273ca4a 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -491,22 +491,25 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 }
 
 static void inno_hdmi_encoder_mode_set(struct drm_encoder *encoder,
-				       struct drm_display_mode *mode,
-				       struct drm_display_mode *adj_mode)
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
 {
+	struct drm_display_mode *adj_mode = &crtc_state->adjusted_mode;
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
 
 	inno_hdmi_setup(hdmi, adj_mode);
 }
 
-static void inno_hdmi_encoder_enable(struct drm_encoder *encoder)
+static void inno_hdmi_encoder_enable(struct drm_encoder *encoder,
+				     struct drm_atomic_state *state)
 {
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
 
 	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
 }
 
-static void inno_hdmi_encoder_disable(struct drm_encoder *encoder)
+static void inno_hdmi_encoder_disable(struct drm_encoder *encoder,
+				      struct drm_atomic_state *state)
 {
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
 
@@ -527,10 +530,10 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 }
 
 static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
-	.enable     = inno_hdmi_encoder_enable,
-	.disable    = inno_hdmi_encoder_disable,
-	.mode_set   = inno_hdmi_encoder_mode_set,
-	.atomic_check = inno_hdmi_encoder_atomic_check,
+	.atomic_check	= inno_hdmi_encoder_atomic_check,
+	.atomic_enable	= inno_hdmi_encoder_enable,
+	.atomic_disable	= inno_hdmi_encoder_disable,
+	.atomic_mode_set	= inno_hdmi_encoder_mode_set,
 };
 
 static enum drm_connector_status

-- 
2.43.0

