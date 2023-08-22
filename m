Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27477846E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjHVQUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbjHVQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:20:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4FA193
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:20:03 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97E941211;
        Tue, 22 Aug 2023 18:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692721124;
        bh=JrwUDETZB5eMPJTDxOAxu4s6pxxmetjU3ZvnBP+Q+9E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=vJCLO2P3ohgUmaam0xE6l1KCAYaD3FrRslzzklUiA5Wp+RShHzpR4rb24GZVqF7pg
         7Ibeoh7tBvPXepmxKVCAnYpjdu6siLD7siFNlp1ZVZu07QjyJAyRMJWzr1TPa1V7Cj
         QZC0hTiB9bifah6hDKoWHYlHFU4NR/+N2lfVvcdk=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Tue, 22 Aug 2023 19:19:34 +0300
Subject: [PATCH v3 01/12] drm/tegra: rgb: Parameterize V- and H-sync
 polarities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-tc358768-v3-1-c82405dac0c1@ideasonboard.com>
References: <20230822-tc358768-v3-0-c82405dac0c1@ideasonboard.com>
In-Reply-To: <20230822-tc358768-v3-0-c82405dac0c1@ideasonboard.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Thierry Reding <treding@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=sL6zTXqRvJeIplRfAhFNbyY7r8WIKADc5W6NZoL5o+U=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk5OAqU5MuEmEFpSME7lAO3Fy/cQBYySuCZUqj/
 aasICiJWvyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZOTgKgAKCRD6PaqMvJYe
 9Wa2D/9dsXKpNX70WeLAUVLc4MA8l2ppNEaZn495yXdwRF+kWbUwDjoy50fm3mUCXWE+A5p2nXh
 AyfCv33a6DtYOtWAE9kvmxypkBojQQLcO7tvpJJyy3HKXQFX651ybDvbEeHJbCZo74UXl9Wso8W
 0/Rji29G/dYvf7EFr+iy6BbPebSUO5m4cg1sqLDkq+ekhFCVgYK+fj7acmYknIQwMLgKF6Yv8s8
 TvTKY08VDE6I/V5kuF5ut44bfmkLyJ7i/XLrQ75P0EevKWE/+qCCm+/B5G+3vsovhq5zb/LMyN3
 8puYiYSEqqhh66xGysr4W/jERE1xSaauQwTLOgCpQ4XnZrCy0ApytfhxfZHQgWRy1ApXwqhSnbZ
 PzRkOcvHEl4jNo7E6+8nVCqv9XtfuikZvzMWqtTCqBRbwq+4L5Elxnv1skoHneo2zz7Sh0nG55N
 P4vckn3Rj5FIH4nP8DyEJkSTcJKEsSlwkNrQdbcBXaXBUtn+kSFLNErnq4B9VPl0oXU8My8RDlZ
 0YU9wOpHGaAkc4Zi68yd3aCnW213mKVKubVUlAPL25+/MhJeprBS8YGuzKoSljx9ei4njz1FDPg
 G0UUvCNrV1BbGNXtgxIHnomHi4KwYxPKRvxg/PMg8k50z/lBwiJqffXZNKcOSD/1RTD552DEHAV
 yPCJJz5uQ1eTRBA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The polarities of the V- and H-sync signals are encoded as flags in the
display mode, so use the existing information to setup the signals for
the RGB interface.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
[tomi.valkeinen@ideasonboard.com: default to positive sync]
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tegra/rgb.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 79566c9ea8ff..fc66bbd913b2 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -99,6 +99,7 @@ static void tegra_rgb_encoder_disable(struct drm_encoder *encoder)
 
 static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
 {
+	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct tegra_output *output = encoder_to_output(encoder);
 	struct tegra_rgb *rgb = to_rgb(output);
 	u32 value;
@@ -108,10 +109,19 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
 	value = DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
 	tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS);
 
-	/* XXX: parameterize? */
+	/* configure H- and V-sync signal polarities */
 	value = tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1));
-	value &= ~LVS_OUTPUT_POLARITY_LOW;
-	value &= ~LHS_OUTPUT_POLARITY_LOW;
+
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		value |= LHS_OUTPUT_POLARITY_LOW;
+	else
+		value &= ~LHS_OUTPUT_POLARITY_LOW;
+
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		value |= LVS_OUTPUT_POLARITY_LOW;
+	else
+		value &= ~LVS_OUTPUT_POLARITY_LOW;
+
 	tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
 
 	/* XXX: parameterize? */

-- 
2.34.1

