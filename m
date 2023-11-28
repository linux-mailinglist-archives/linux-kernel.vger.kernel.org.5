Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529C97FB7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344460AbjK1KaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjK1K32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:29:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B4324F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:26:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F82EC433C7;
        Tue, 28 Nov 2023 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701167184;
        bh=BKAqssSSrz/lWlwNaLsJkad1kx62XBx3UGaeEawTwAE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Xniu33YR4/yU3WHn9V40iLgAKdo2Jeqbft/ixk0X2dc6ZGri7kPdbSlYJO7rRwAb7
         w3Spgy6B0zWROYaqUMYsFv+s2y20p9lYtqKQ/MMJ38BYDbUU1zjO5v/ICbhmFE4WSo
         v4oCfBDdKVnM9jKlyo1A3i1rrXm5U/ZEs4T1hltYVZaoIv6ex1GxW0W2ZtfVV/oHUS
         xmxYKi+z/pe3ppj86QKSMlX8YCIS4V/oPHchnzLQE8ZHCxZz1Lfgie1XnFkJSSr87I
         GQ9UM3IYt1uJwXwTZR3+kJkEDGf9lOIZDsX+LgCnp/woDBvggL4FmqEPz6kC+24w27
         avfx/C7GSeMCQ==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 28 Nov 2023 11:24:54 +0100
Subject: [PATCH v4 43/45] drm/sun4i: hdmi: Switch to container_of_const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-kms-hdmi-connector-state-v4-43-c7602158306e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BKAqssSSrz/lWlwNaLsJkad1kx62XBx3UGaeEawTwAE=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmp+y/7KW9anrmo5fXx9lMamZVL91aycFY9XK8WFm/U0
 T2Rw31LRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACayRYyRYbbLu/1XL5/fwRy6
 2CLkx46W566G1YbCG2d9St05/9Kllw2MDD9VNr/asivo6OaC07arvm568UPIyyvHmVNr2+M4w8T
 5qSwA
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

