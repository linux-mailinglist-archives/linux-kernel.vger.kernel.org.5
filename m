Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3D797487
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbjIGPj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345353AbjIGPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:31 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658B71FC9;
        Thu,  7 Sep 2023 08:35:08 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout1.routing.net (Postfix) with ESMTP id 04FFB4081B;
        Thu,  7 Sep 2023 11:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1694085635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bmzyT3vhoavJV5YD/9bjCpBgNAP4o0u/rneto0+CusE=;
        b=w2FAf1f6NYSPYwdHbMqEXFMlOVdC4HmF1Q212UWEGrvaarckAZKkNtvCHUdLCSOkVipCza
        Ooe2QjKtAInOu1Qw0vq5sGegkzD3DyUtuvitA1FJ0oYh0f41J0DtoO6oUXy+UblT8QEd0e
        daPaIchb0Lp+CpS0c9Icp9+HxKt+47Y=
Received: from frank-G5.. (fttx-pool-217.61.150.154.bambit.de [217.61.150.154])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 0FBA2360465;
        Thu,  7 Sep 2023 11:20:34 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org
Subject: [PATCH] thermal/drivers/mediatek: Fix control buffer enablement on MT7896
Date:   Thu,  7 Sep 2023 13:20:18 +0200
Message-Id: <20230907112018.52811-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: e7eeb8e1-00de-41f6-a5df-ce2e9164136e
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Reading thermal sensor on mt7986 devices returns invalid temperature:

bpi-r3 ~ # cat /sys/class/thermal/thermal_zone0/temp
 -274000

Fix this by adding missing members in mtk_thermal_data struct which were
used in mtk_thermal_turn_on_buffer after commit 33140e668b10.

Cc: stable@vger.kernel.org
Fixes: 33140e668b10 ("thermal/drivers/mediatek: Control buffer enablement tweaks")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 843214d30bd8..967b9a1aead4 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -690,6 +690,9 @@ static const struct mtk_thermal_data mt7986_thermal_data = {
 	.adcpnp = mt7986_adcpnp,
 	.sensor_mux_values = mt7986_mux_values,
 	.version = MTK_THERMAL_V3,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
+	.apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
+	.apmixed_buffer_ctl_set = BIT(0),
 };
 
 static bool mtk_thermal_temp_is_valid(int temp)
-- 
2.34.1

