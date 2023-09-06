Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E7E7935A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbjIFGvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjIFGvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:51:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91730E43
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:51:29 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 159893F1;
        Wed,  6 Sep 2023 08:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693983000;
        bh=9+YwYctXLvEJs60zHSY6wyocIempjTo8N/jz3tZYYWs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CxVNxPU10s7DOQfefseCeLnJm0SCXvAjr3ovcET/0Zh2SIq6xdpO17VynY9LdDbCu
         W2rK2DwkCwffnVhnlp0L6sAUoXLrY5utWGBd5mNxeOmdeQmOODjErufYsH8QwoCPkJ
         3d1ihI/TdxyViHY+dSKOSluLfLstYNbombmvfPKM=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 06 Sep 2023 09:50:48 +0300
Subject: [PATCH v4 01/12] drm/tegra: rgb: Parameterize V- and H-sync
 polarities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-tc358768-v4-1-31725f008a50@ideasonboard.com>
References: <20230906-tc358768-v4-0-31725f008a50@ideasonboard.com>
In-Reply-To: <20230906-tc358768-v4-0-31725f008a50@ideasonboard.com>
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
        Thierry Reding <thierry.reding@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=5+8Qt0dRuDZPu87i9IUGZHmIGywuwwho4mCUeHWUimE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk+CFo42NyY3wZOfzyAaJpXzsTa8M/eIixjIMdf
 P0mGzr/tDeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZPghaAAKCRD6PaqMvJYe
 9eGcD/98GTtyDMsinnUuVZ0ttkVS66umqHonmBjmpb9xvv2Ssu5eGmbc5OCNcrkvNqeS/+M16Cp
 fRwUjK3o1H6oKYsEJ6Z7J2/d1CYd1t0wZTDdRIPylE6zWRhT3oOOsbcANVH1k3xg+0gVu7Pla+c
 5tZzEFHKn9zRGMfpdZ8YVohQEU6VyMA5N9CNfZDl5vsGcz4a7HvXRdvtRvsKyrHI4xJv19c8WvV
 B9bxI9tcFl2/xJbriJIIdnt3oeIildyiG4IV+LOM1docg0EvykYFVMUYVfG51pDGTjzxPfF0M6z
 KQkJulnX9qbW7Qpi/NQzMugLvO9aqSX4sCCkghwjvIdb/pUQbDPuCfL4IVYbNS3FjhrM9U91Lqm
 4ZoXeK/bXkOKKrTVTxdNWRKxGVJf6zNrKXDY3lC3y6yjRxa0343Z+GbiqlDAPoEav4lvfksmPd0
 FerZv0sWtjQENxJHB3VNGfngtNzGyG/g/8Vx4mXEI67Ai6cfXpnNyvK34gTETP4A5Rwl549MVdU
 tZNpUi2RQeBnN/osasFp+UZwDjNYjnvK9YOfMMgdfPbBz2fJnVoYz43H8qRbehJGKgSyEWw60yj
 cbtTG3zGIubB2LzUDFI/TpgW9k2pMU/tYikmalRft/biRwJFZlt4Sg6r5P06qpfIqc/MPOnRzor
 jMcK1CbHPBt/8mQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

