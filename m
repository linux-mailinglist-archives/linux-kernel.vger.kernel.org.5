Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C177F7A8745
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbjITOi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbjITOiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:38:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EC4CD4;
        Wed, 20 Sep 2023 07:37:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8235C433CA;
        Wed, 20 Sep 2023 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695220641;
        bh=BKAqssSSrz/lWlwNaLsJkad1kx62XBx3UGaeEawTwAE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EtN6A+MKtH7qocG6NTeWELFzrImwk7f49faBZSnroJ/zTK+i0DNgeEEH+FDHZ+XZD
         Rcf7dMVCTghvN1vhIrYdvfBaoZnuub2d8bxIzTz5Wfgadu2wQAhTy27GDHjHepUZve
         UiuiKMSRAmoomKV6O/HqMOnximPKTz46FRztFxn4didL1e/3F3wuu7ugLpj5mmi04F
         2VjoDQ1S9D3piYoBcQgwTM4mMQ+qNsh8mraasiyORexLFmuI7s5+s+2nNtsYh3oBXe
         fBX2CrLYHDanA1z79sAW16lIAfXPU8QtwA0FMgK0UOA7LY/ugww5QZxH/v0TZcWjZm
         kreap6LRbh7zA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 20 Sep 2023 16:35:50 +0200
Subject: [PATCH RFC v2 35/37] drm/sun4i: hdmi: Switch to container_of_const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-kms-hdmi-connector-state-v2-35-17932daddd7d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BKAqssSSrz/lWlwNaLsJkad1kx62XBx3UGaeEawTwAE=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnczFYZmq/yffmeSE+sO+ZV+LTO//EmfpsWr61Zi0Vqn
 YPmHJ/eUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgImsfs7IMLfG0cOgUbJuw4EV
 3XNYD1Yt9Qqa53vy+N3HgiLNjWsM2RgZVm3kNjXsfbV9xnOnw4sf1l/Z/fA5K9v2r7viUlYm7Ej
 ZzgYA
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

container_of_const() allows to preserve the pointer constness and is
thus more flexible than inline functions.

Let's switch all our instances of container_of() to container_of_const().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index bae69d696765..c276d984da6b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -30,19 +30,11 @@
 #include "sun4i_drv.h"
 #include "sun4i_hdmi.h"
 
-static inline struct sun4i_hdmi *
-drm_encoder_to_sun4i_hdmi(struct drm_encoder *encoder)
-{
-	return container_of(encoder, struct sun4i_hdmi,
-			    encoder);
-}
+#define drm_encoder_to_sun4i_hdmi(e)		\
+	container_of_const(e, struct sun4i_hdmi, encoder)
 
-static inline struct sun4i_hdmi *
-drm_connector_to_sun4i_hdmi(struct drm_connector *connector)
-{
-	return container_of(connector, struct sun4i_hdmi,
-			    connector);
-}
+#define drm_connector_to_sun4i_hdmi(c)		\
+	container_of_const(c, struct sun4i_hdmi, connector)
 
 static int sun4i_hdmi_setup_avi_infoframes(struct sun4i_hdmi *hdmi,
 					   struct drm_display_mode *mode)

-- 
2.41.0

