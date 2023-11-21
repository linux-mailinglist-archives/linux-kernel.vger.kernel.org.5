Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2EE7F2C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjKUL6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjKUL4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:56:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D6A1A2;
        Tue, 21 Nov 2023 03:56:49 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 852916607324;
        Tue, 21 Nov 2023 11:56:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700567808;
        bh=XEVVBoXHkUpKz+mYu2BhuD+v7qTvXaba6bcEiQ5SYSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYYbo9QldXFXkudLNK5rBpyLOm3Syq0rkmS15Dw5elqhdCQEjLJ8kZzlIAH/9feSQ
         fKlAppZeczG0BvHBMcVMzFWOKlTqcdLR38gs+mDI8TFzbgqxnvL3+7ke7vlfaIarOE
         WD4+zgmW1iKsLDiocSUyAnRL7xZwxGw2tTmygpebAcSBxHok6hcBdGsl3UxPU4RhG9
         8XEQk0x8kv80N5b4iMA7KyObYnlaCUOR78JlP1dzoe2MuBlgaduv01uzC1TJkOv2/K
         NbRxwgmUpxDmArQm49ItmhnUMfHWIiHPkJZFJP92lDNXXN9DWJqILJhvwM+4X/RRD7
         +oX/uQYLfW/Jg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v2 16/20] soc: mediatek: mtk-svs: Check if SVS mode is available in the beginning
Date:   Tue, 21 Nov 2023 12:56:20 +0100
Message-ID: <20231121115624.56855-17-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
References: <20231121115624.56855-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The svs_init01() and svs_init02() functions are already checking if the
INIT01 and INIT02 modes are available - but that's done in for loops and
for each SVS bank.

Give those a shortcut to get out early if no SVS bank features the
desired init mode: this is especially done to avoid some locking in
the svs_init01(), but also to avoid multiple for loops to check the
same, when no bank supports a specific mode.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index ae0cc22a2941..16a16c5a3f24 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1400,6 +1400,16 @@ static irqreturn_t svs_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static bool svs_mode_available(struct svs_platform *svsp, u8 mode)
+{
+	int i;
+
+	for (i = 0; i < svsp->bank_max; i++)
+		if (svsp->banks[i].mode_support & mode)
+			return true;
+	return false;
+}
+
 static int svs_init01(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
@@ -1408,6 +1418,9 @@ static int svs_init01(struct svs_platform *svsp)
 	int ret = 0, r;
 	u32 opp_freq, opp_vboot, buck_volt, idx, i;
 
+	if (!svs_mode_available(svsp, SVSB_MODE_INIT01))
+		return 0;
+
 	/* Keep CPUs' core power on for svs_init01 initialization */
 	cpuidle_pause_and_lock();
 
@@ -1575,6 +1588,9 @@ static int svs_init02(struct svs_platform *svsp)
 	int ret;
 	u32 idx;
 
+	if (!svs_mode_available(svsp, SVSB_MODE_INIT02))
+		return 0;
+
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		svsb = &svsp->banks[idx];
 
-- 
2.42.0

