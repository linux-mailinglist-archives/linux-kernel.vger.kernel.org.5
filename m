Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACBC805BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442418AbjLEPVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346137AbjLEPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:21:29 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98B5A9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:21:34 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id A725140016;
        Tue,  5 Dec 2023 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701789693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CH30td9T992ZcnPYMJ2jKOsiF+4ZPdmUv7OxdVim8jo=;
        b=TJj3Nn6Gf7TOul1jvegZEjqExz5j5thj0t/3531uP6G5RPtM/rYzmT6heliCJQK/7/qTEE
        ER6itkYhT/HB2Ztv3u9zFGooof5wgfWCQLp7pmUv4MmuKNG7gNGCKb9CLwCRRmhbwav8lk
        7iqxDT3ewH5423ddovm/J/ynF3RfPbsoOkCwxPLVEm1HONsWJ0mjoIYcqNSqzgUqKu6DQg
        Ew0ZP09hM9WNlSiEHv94sD2PDsxUZoP7lrWqO7OLIUKHlDn687jRONdRrDT9N7EFTp2AR4
        jH96j5pt3V0UvncPZrAX5yGxoTUPp19Jn2OfjutpA08U3KJ5khavuFzhFxIuhA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 07/17] soc: fsl: cpm1: qmc: Introduce available timeslots masks
Date:   Tue,  5 Dec 2023 16:21:04 +0100
Message-ID: <20231205152116.122512-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205152116.122512-1-herve.codina@bootlin.com>
References: <20231205152116.122512-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Available timeslots masks define timeslots available for the related
channel. These timeslots are defined by the QMC binding.

Timeslots used are initialized to available timeslots but can be a
subset of available timeslots.
This prepares the dynamic timeslots management (ie. changing timeslots
at runtime).

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index e716f13669a0..0413e25d4c67 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -177,7 +177,9 @@ struct qmc_chan {
 	struct qmc *qmc;
 	void __iomem *s_param;
 	enum qmc_mode mode;
+	u64	tx_ts_mask_avail;
 	u64	tx_ts_mask;
+	u64	rx_ts_mask_avail;
 	u64	rx_ts_mask;
 	bool is_reverse_data;
 
@@ -875,7 +877,8 @@ static int qmc_of_parse_chans(struct qmc *qmc, struct device_node *np)
 			of_node_put(chan_np);
 			return ret;
 		}
-		chan->tx_ts_mask = ts_mask;
+		chan->tx_ts_mask_avail = ts_mask;
+		chan->tx_ts_mask = chan->tx_ts_mask_avail;
 
 		ret = of_property_read_u64(chan_np, "fsl,rx-ts-mask", &ts_mask);
 		if (ret) {
@@ -884,7 +887,8 @@ static int qmc_of_parse_chans(struct qmc *qmc, struct device_node *np)
 			of_node_put(chan_np);
 			return ret;
 		}
-		chan->rx_ts_mask = ts_mask;
+		chan->rx_ts_mask_avail = ts_mask;
+		chan->rx_ts_mask = chan->rx_ts_mask_avail;
 
 		mode = "transparent";
 		ret = of_property_read_string(chan_np, "fsl,operational-mode", &mode);
-- 
2.43.0

