Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9CE78F8A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbjIAGhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIAGhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:37:47 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C239E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:37:42 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id B146A60420;
        Fri,  1 Sep 2023 06:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1693550260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WYttLDCfhSCFxKufWQTJm+SdWNk8ml/opxZYoHJTyPU=;
        b=unVnqlJe7L3VtfTscf+t8jVQLTsxeehFoDe6ZgslGkCtSZXYLAyXFa8TeRZARbfTv6D1AV
        9Ihq2PpIpKt8BXQ2FpwKBZ8AAVUf31PY22Z7L99q5Kpf3u3HpyvVRAMaBa64c7YS95VeNH
        nLtAQzRS0c28xbmNKq+XtfvvU6uIQMk=
Received: from frank-G5.. (fttx-pool-80.245.79.3.bambit.de [80.245.79.3])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id B01E03602D4;
        Fri,  1 Sep 2023 06:37:39 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org
Subject: [RFC] thermal/drivers/mediatek: fix temperature on mt7986
Date:   Fri,  1 Sep 2023 08:37:30 +0200
Message-Id: <20230901063730.7577-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 34822b24-5ea6-4a61-a66e-084d6433f5b6
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
index f59d36de20a0..ed08767eaa60 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -691,6 +691,9 @@ static const struct mtk_thermal_data mt7986_thermal_data = {
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

