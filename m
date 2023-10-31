Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4EE7DD366
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346791AbjJaQyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346511AbjJaQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7C110F9;
        Tue, 31 Oct 2023 09:50:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A14C433C9;
        Tue, 31 Oct 2023 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698771013;
        bh=BKAqssSSrz/lWlwNaLsJkad1kx62XBx3UGaeEawTwAE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LKl9FeWJaHq869sseHpye9UOjmAohwH8x7IADYt/bJhPUJ0cfJkq7aM2HvYfKh9In
         DIkOPbNmYxurvX1rjCH5KuIkMP1B5mB12FwCH4suR93h4tmKpQsgDounwXNoc57OrV
         hVqZjH2snA6rhJaB5cp2M2u6cDdRmXtcq1900OP7LrExL9tkDHphfVtcCjqbBWM3OM
         MUbjP49xhviEC4wDmujF1UtnAD+8QcUzTrj/fZ+DPbiroo4MKVxBFdNxSi/D73d+r6
         qX//dJ7DRZdv+hxa+dIvg76nQcRISUUwJ9yhtSEjiL0lT1sv/r693XiCpdXTwmexsS
         hXvhN5cwWGwqQ==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 31 Oct 2023 17:48:48 +0100
Subject: [PATCH RFC v3 35/37] drm/sun4i: hdmi: Switch to container_of_const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-kms-hdmi-connector-state-v3-35-328b0fae43a7@kernel.org>
References: <20231031-kms-hdmi-connector-state-v3-0-328b0fae43a7@kernel.org>
In-Reply-To: <20231031-kms-hdmi-connector-state-v3-0-328b0fae43a7@kernel.org>
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
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmO+vddm8P4p5/ZuibZ+EbKgX7LSZpbzKKaU/7bsxsti
 tm/g7Oyo5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABMp7GX4Xz5jq8lTOQfNc49y
 v13qEZl2RYxbb2NS+LGyDFk7323n7zAyHAswNXWZfT54svCaIwExmcd4rt0veSN8xcrM51mcXZg
 KHwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

