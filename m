Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF27E3DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjKGMbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjKGMbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:31:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADBE383B7;
        Tue,  7 Nov 2023 04:20:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40728C433C9;
        Tue,  7 Nov 2023 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359644;
        bh=7FsGvcfVEyhjsdO+V/3svSehtAl7khWkxgxIPxJyhKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YpBTveznW+BCyaOW6pneHgyGZN/faHUVUblboaz85Pm7P8YYn8JRmWPxTrhByMlu+
         zgHdk6nENfSAovIrRI4/rLZvmQRmPM0AFE8rCCt2zDaX4yE0/tGyhqz7nrmg/dK1vR
         Kkw+qosVFnBG5AxucfPbIOA+CHPjqCh26NgUM625SpRyG7zy8YEbmNgTTv2ecyXTMd
         pP6ixlQFlRu3A8iM970aiWHkykw5YWfCKmBluG4IayXfP9Uw1vy8cfgh8jOZ5tL1yx
         WmNxuwqgMHyhW655RhXzYPXwDL297pMI7LGU+z3htIjjU9Bu4J83qhO3jSDhaDf1tJ
         0DlNpCkAYjCyg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>, Frank Oltmanns <frank@oltmanns.dev>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Sasha Levin <sashal@kernel.org>, neil.armstrong@linaro.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 28/40] drm/panel: st7703: Pick different reset sequence
Date:   Tue,  7 Nov 2023 07:16:30 -0500
Message-ID: <20231107121837.3759358-28-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
index 6a39456395350..7bb723d445ade 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -506,29 +506,30 @@ static int st7703_prepare(struct drm_panel *panel)
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
 
 static const u32 mantix_bus_formats[] = {
-- 
2.42.0

