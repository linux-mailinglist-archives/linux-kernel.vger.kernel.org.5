Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA37E3FA8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjKGNIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbjKGNIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:08:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F24F211E;
        Tue,  7 Nov 2023 04:31:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36691C433C7;
        Tue,  7 Nov 2023 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360289;
        bh=tx3KRHlt+m5YKkdow1scgL5QoTP7fdogK+Z0v/A4ucM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3fI1Obyyj8sAMce9F3t9MkMvjUA8eyYTXhN4Dff/JW0lydnXVM7fny8UKTIKpTGq
         guw9buYas0Lueq/NYaY8EVMsGI2qtoc5eFMhKZHjm9hk80dFZkAaI3dvGQEW7ZNp/2
         cBcaQqVMxQm3K66yc/V6T6vTu4LU6wP3sUilH0/YwPQlDZYqCTOcf47gXYfzmOIiVK
         V9G1GzXItXAB1lFPuoxQRcxLVZ9MidIfyi9Ftwk19OAMDa1OL6Jcw/WQk7ESvus3Ra
         ZisW+W26ksnIl1sRp0vCwwxFmC6KAhGnXyRFQCzsH029jmVVnT1qc938lbXcvYGgI0
         xlEwhH4SYeNjA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>, Frank Oltmanns <frank@oltmanns.dev>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Sasha Levin <sashal@kernel.org>, neil.armstrong@linaro.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 09/11] drm/panel: st7703: Pick different reset sequence
Date:   Tue,  7 Nov 2023 07:30:42 -0500
Message-ID: <20231107123100.3762796-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107123100.3762796-1-sashal@kernel.org>
References: <20231107123100.3762796-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

[ Upstream commit d12d635bb03c7cb4830acb641eb176ee9ff2aa89 ]

Switching to a different reset sequence, enabling IOVCC before enabling
VCC.

There also needs to be a delay after enabling the supplies and before
deasserting the reset. The datasheet specifies 1ms after the supplies
reach the required voltage. Use 10-20ms to also give the power supplies
some time to reach the required voltage, too.

This fixes intermittent panel initialization failures and screen
corruption during resume from sleep on panel xingbangda,xbd599 (e.g.
used in PinePhone).

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
Reported-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Guido Günther <agx@sigxcpu.org>
Tested-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Guido Günther <agx@sigxcpu.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230211171748.36692-2-frank@oltmanns.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index c22e7c49e0778..67e1da0a7db53 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -428,29 +428,30 @@ static int st7703_prepare(struct drm_panel *panel)
 		return 0;
 
 	dev_dbg(ctx->dev, "Resetting the panel\n");
-	ret = regulator_enable(ctx->vcc);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
+	ret = regulator_enable(ctx->iovcc);
 	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to enable vcc supply: %d\n", ret);
+		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
 		return ret;
 	}
-	ret = regulator_enable(ctx->iovcc);
+
+	ret = regulator_enable(ctx->vcc);
 	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
-		goto disable_vcc;
+		dev_err(ctx->dev, "Failed to enable vcc supply: %d\n", ret);
+		regulator_disable(ctx->iovcc);
+		return ret;
 	}
 
-	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-	usleep_range(20, 40);
+	/* Give power supplies time to stabilize before deasserting reset. */
+	usleep_range(10000, 20000);
+
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
-	msleep(20);
+	usleep_range(15000, 20000);
 
 	ctx->prepared = true;
 
 	return 0;
-
-disable_vcc:
-	regulator_disable(ctx->vcc);
-	return ret;
 }
 
 static int st7703_get_modes(struct drm_panel *panel,
-- 
2.42.0

