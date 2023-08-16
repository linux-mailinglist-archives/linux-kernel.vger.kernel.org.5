Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FDE77E048
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbjHPLZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbjHPLZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:25:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1232121
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:25:48 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E72ECC85;
        Wed, 16 Aug 2023 13:24:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692185073;
        bh=ZXPuvKRX9sprHbo4Gpv06P7fu4Zcz2YshqV8Y8PC7RA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pwUcqjDnjxDTPJOB5LLs42TFguNy6jxlko33YjqoNsEeFgPRLO+sMpQe+MjneSCmS
         jXOX5nOCp+qAG0A34L8Dws5VSN7LOQCu4vAYW+OHJ3KYfynaGT7+4cnLY41xKyggXn
         NTpeemrgY8dg5Lxm/4NTzmg/CC/7TufY0OM5Tso8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 16 Aug 2023 14:25:04 +0300
Subject: [PATCH v2 01/12] drm/tegra: rgb: Parameterize V- and H-sync
 polarities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230816-tc358768-v2-1-242b9d5f703a@ideasonboard.com>
References: <20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com>
In-Reply-To: <20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=GghajFVwAuY/jQ2Sbjd3Hk+E+RHO699TYVsqwsh7V5U=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk3LIzXTggTDUU/b8Y6cxIrzc6YDU8xIreubHaS
 CQ3so3qymqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZNyyMwAKCRD6PaqMvJYe
 9VcdD/4jtfA+Exg74OnSyr8FP5u4K+47fKDod2jyMhDssy7Kef6F1jPQT03bTGO17A+ZP5HHVAo
 lY7Tx5scXojq/ofDRswxIIOb2T+f4aLt4dXXzr/GT2d082MpktW828ql2CHrFPuJF5kTvlh3lSJ
 RFF++8d/0nSGoouc9rj/U8suKN82Y1b9cCxslavCtdDEn35TcBcfkczuCEQZqlNB8D/GP1udZnD
 hQZzGI5n/unYbWUKWc6xlHUAOdCUwixdwhliD8Canu0f6HuwUJ+8iVf2tXxQzrQqkxB6NDmCYMB
 OypfGci0wzVR6f9H9wKjuFYFNyb+Sz8SL3iiiZBlJcYOIMIhHr3klqezZ97MjucrkkZ4x8vzsWo
 wCk/WRt89ygZs8rnucd971ov0RhfCILDBYBASTRdfwt7It/yjdxS7liUqCwUit3eSyj/sN46MHx
 678datOimyls8RsUcCKPGEyUsVWFcCqbX2PmFQaJR15sgHMk3yOVIHb97XxkwW/lZfu5Gc0cEKU
 lFuxWj9sSh5JxDOqEszaySboqTZj6uJKuzobn5VvnAiR9yKlDOr4G6VB2tZpNdLTvB4D+iMYe/F
 O4qAonbYqFMTvkbaIGP53lv22bAIhtNde+UoTInM6Dd9RSyk//fQHKousjHBlQaTj6U9yYFRRHN
 5RLBpLtAFSJHM7Q==
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

