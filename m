Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8467B1434
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjI1HK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjI1HKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:10:48 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F942699;
        Thu, 28 Sep 2023 00:08:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 0F73F2000F;
        Thu, 28 Sep 2023 07:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695884889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VNINkLFfha4Th+iIY5tUoXJZhImwUnHfix4Wn4Cn9s=;
        b=E+LYRtqSBU9mbG8UnheJN5oohUxQZPcT5DNCY5pnmN0Aj3NcOAh0NEOJ7AaUQxtHDoQcbv
        sm+CM7IJ4hMaNhzuWc+R48q0nHrJZgF4uOIsAMWw5d2tQ3/Kh/YzW6TwCXR/hidwnZjSfQ
        OZghr7uekujeYsQRqB2/bAO8ZuQTNlKKmSJ+x29pgR9OOdRWE5bn5SNIsa6ENsk/YQ2i8S
        XIEMWy7/9M1r2h69SJQ7/pUGqleyaRPRGJxvRwWSlMYu9E5/MRRQ4KdXCsdMmii6pT2z2J
        2sibS+ZHFTZQ3iDBu7sc947ZC0A5mfIggEZ48IsnNc5U8kW649MdZ7ZnnzWjQw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 18/30] soc: fsl: cpm1: qmc: Split Tx and Rx TSA entries setup
Date:   Thu, 28 Sep 2023 09:06:36 +0200
Message-ID: <20230928070652.330429-19-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928070652.330429-1-herve.codina@bootlin.com>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tx and Rx entries for a given channel are set in one function.

In order to modify Rx entries and Tx entries independently of one other,
split this function in one for the Rx part and one for the Tx part.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 49 ++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 26cd7e1ccafc..eeceb81bf107 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -610,14 +610,14 @@ static int qmc_chan_setup_tsa_64rxtx(struct qmc_chan *chan, const struct tsa_ser
 	return 0;
 }
 
-static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_serial_info *info,
-					bool enable)
+static int qmc_chan_setup_tsa_32rx(struct qmc_chan *chan, const struct tsa_serial_info *info,
+				   bool enable)
 {
 	unsigned int i;
 	u16 curr;
 	u16 val;
 
-	/* Use a Tx 32 entries table and a Rx 32 entries table */
+	/* Use a Rx 32 entries table */
 
 	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
 
@@ -633,6 +633,30 @@ static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_
 			return -EBUSY;
 		}
 	}
+
+	/* Set entries based on Rx stuff */
+	for (i = 0; i < info->nb_rx_ts; i++) {
+		if (!(chan->rx_ts_mask & (((u64)1) << i)))
+			continue;
+
+		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2),
+				 ~QMC_TSA_WRAP, enable ? val : 0x0000);
+	}
+
+	return 0;
+}
+
+static int qmc_chan_setup_tsa_32tx(struct qmc_chan *chan, const struct tsa_serial_info *info,
+				   bool enable)
+{
+	unsigned int i;
+	u16 curr;
+	u16 val;
+
+	/* Use a Tx 32 entries table */
+
+	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
+
 	/* Check entries based on Tx stuff */
 	for (i = 0; i < info->nb_tx_ts; i++) {
 		if (!(chan->tx_ts_mask & (((u64)1) << i)))
@@ -646,14 +670,6 @@ static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_
 		}
 	}
 
-	/* Set entries based on Rx stuff */
-	for (i = 0; i < info->nb_rx_ts; i++) {
-		if (!(chan->rx_ts_mask & (((u64)1) << i)))
-			continue;
-
-		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2),
-				 ~QMC_TSA_WRAP, enable ? val : 0x0000);
-	}
 	/* Set entries based on Tx stuff */
 	for (i = 0; i < info->nb_tx_ts; i++) {
 		if (!(chan->tx_ts_mask & (((u64)1) << i)))
@@ -680,9 +696,14 @@ static int qmc_chan_setup_tsa(struct qmc_chan *chan, bool enable)
 	 * Setup one common 64 entries table or two 32 entries (one for Tx
 	 * and one for Tx) according to assigned TS numbers.
 	 */
-	return ((info.nb_tx_ts > 32) || (info.nb_rx_ts > 32)) ?
-		qmc_chan_setup_tsa_64rxtx(chan, &info, enable) :
-		qmc_chan_setup_tsa_32rx_32tx(chan, &info, enable);
+	if (info.nb_tx_ts > 32 || info.nb_rx_ts > 32)
+		return qmc_chan_setup_tsa_64rxtx(chan, &info, enable);
+
+	ret = qmc_chan_setup_tsa_32rx(chan, &info, enable);
+	if (ret)
+		return ret;
+
+	return qmc_chan_setup_tsa_32tx(chan, &info, enable);
 }
 
 static int qmc_chan_command(struct qmc_chan *chan, u8 qmc_opcode)
-- 
2.41.0

