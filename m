Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F5F7760BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjHIN3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjHIN2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:28:49 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0F4212C;
        Wed,  9 Aug 2023 06:28:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id E33B640004;
        Wed,  9 Aug 2023 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691587710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2P+Lq3Os6PhsddQJLSGREGSiIa3nInDDj2gadoU4xew=;
        b=dPv64ChFCSRE/8QPAKpweaNgvyIT0/zSPIf2QhtxA9oX4g4hePNfyMXmXKeMddeJjm8b3+
        FErKsJV8CeuBR7ih/N2Jt37daPNGLBA80qyaDVyhtEdseCee+mbMaf1vI6NgXtMTTG6q45
        XLc4vhmooPWwyzLKLmo6K5nmlTnF60M+ecJYyvHnqJuiMlkXmDjjfbbedJWaEzMWTPdVYv
        isNXd8tkZYAg2QcUy9XZYDozoS8MHBXEPtgX53lIFJ5lWVEwIGhVomNs9gRKRiYll3/98W
        FQUtH9Dj7GhKFj5XfglM/ezypaWGqmSlDXfyH5Xb7itH0Z13hQ5E3X7pmWLCCA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
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
        alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 11/28] soc: fsl: cpm1: qmc: Introduce qmc_chan_setup_tsa*
Date:   Wed,  9 Aug 2023 15:27:38 +0200
Message-ID: <20230809132757.2470544-12-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809132757.2470544-1-herve.codina@bootlin.com>
References: <20230809132757.2470544-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the qmc_chan_setup_tsa* functions to setup entries related
to the given channel.
Use them during QMC channels setup.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 161 ++++++++++++++++++++++++++++++---------
 1 file changed, 125 insertions(+), 36 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 261958e3199f..bddff0b74252 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -240,6 +240,11 @@ static void qmc_clrbits16(void __iomem *addr, u16 clr)
 	qmc_write16(addr, qmc_read16(addr) & ~clr);
 }
 
+static void qmc_clrsetbits16(void __iomem *addr, u16 clr, u16 set)
+{
+	qmc_write16(addr, (qmc_read16(addr) & ~clr) | set);
+}
+
 static void qmc_write32(void __iomem *addr, u32 val)
 {
 	iowrite32be(val, addr);
@@ -562,6 +567,122 @@ static void qmc_chan_read_done(struct qmc_chan *chan)
 	spin_unlock_irqrestore(&chan->rx_lock, flags);
 }
 
+static int qmc_chan_setup_tsa_64rxtx(struct qmc_chan *chan, const struct tsa_serial_info *info)
+{
+	unsigned int i;
+	u16 curr;
+	u16 val;
+
+	/*
+	 * Use a common Tx/Rx 64 entries table.
+	 * Tx and Rx related stuffs must be identical
+	 */
+	if (chan->tx_ts_mask != chan->rx_ts_mask) {
+		dev_err(chan->qmc->dev, "chan %u uses different Rx and Tx TS\n", chan->id);
+		return -EINVAL;
+	}
+
+	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
+
+	/* Check entries based on Rx stuff*/
+	for (i = 0; i < info->nb_rx_ts; i++) {
+		if (!(chan->rx_ts_mask & (((u64)1) << i)))
+			continue;
+
+		curr = qmc_read16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2));
+		if (curr & QMC_TSA_VALID && (curr & ~QMC_TSA_WRAP) != val) {
+			dev_err(chan->qmc->dev, "chan %u TxRx entry %d already used\n",
+				chan->id, i);
+			return -EBUSY;
+		}
+	}
+
+	/* Set entries based on Rx stuff*/
+	for (i = 0; i < info->nb_rx_ts; i++) {
+		if (!(chan->rx_ts_mask & (((u64)1) << i)))
+			continue;
+
+		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2),
+				 ~QMC_TSA_WRAP, val);
+	}
+
+	return 0;
+}
+
+static int qmc_chan_setup_tsa_32rx_32tx(struct qmc_chan *chan, const struct tsa_serial_info *info)
+{
+	unsigned int i;
+	u16 curr;
+	u16 val;
+
+	/* Use a Tx 32 entries table and a Rx 32 entries table */
+
+	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
+
+	/* Check entries based on Rx stuff */
+	for (i = 0; i < info->nb_rx_ts; i++) {
+		if (!(chan->rx_ts_mask & (((u64)1) << i)))
+			continue;
+
+		curr = qmc_read16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2));
+		if (curr & QMC_TSA_VALID && (curr & ~QMC_TSA_WRAP) != val) {
+			dev_err(chan->qmc->dev, "chan %u Rx entry %d already used\n",
+				chan->id, i);
+			return -EBUSY;
+		}
+	}
+	/* Check entries based on Tx stuff */
+	for (i = 0; i < info->nb_tx_ts; i++) {
+		if (!(chan->tx_ts_mask & (((u64)1) << i)))
+			continue;
+
+		curr = qmc_read16(chan->qmc->scc_pram + QMC_GBL_TSATTX + (i * 2));
+		if (curr & QMC_TSA_VALID && (curr & ~QMC_TSA_WRAP) != val) {
+			dev_err(chan->qmc->dev, "chan %u Tx entry %d already used\n",
+				chan->id, i);
+			return -EBUSY;
+		}
+	}
+
+	/* Set entries based on Rx stuff */
+	for (i = 0; i < info->nb_rx_ts; i++) {
+		if (!(chan->rx_ts_mask & (((u64)1) << i)))
+			continue;
+
+		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2),
+				 ~QMC_TSA_WRAP, val);
+	}
+	/* Set entries based on Tx stuff */
+	for (i = 0; i < info->nb_tx_ts; i++) {
+		if (!(chan->tx_ts_mask & (((u64)1) << i)))
+			continue;
+
+		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATTX + (i * 2),
+				 ~QMC_TSA_WRAP, val);
+	}
+
+	return 0;
+}
+
+static int qmc_chan_setup_tsa(struct qmc_chan *chan)
+{
+	struct tsa_serial_info info;
+	int ret;
+
+	/* Retrieve info from the TSA related serial */
+	ret = tsa_serial_get_info(chan->qmc->tsa_serial, &info);
+	if (ret)
+		return ret;
+
+	/*
+	 * Setup one common 64 entries table or two 32 entries (one for Tx
+	 * and one for Tx) according to assigned TS numbers.
+	 */
+	return ((info.nb_tx_ts > 32) || (info.nb_rx_ts > 32)) ?
+		qmc_chan_setup_tsa_64rxtx(chan, &info) :
+		qmc_chan_setup_tsa_32rx_32tx(chan, &info);
+}
+
 static int qmc_chan_command(struct qmc_chan *chan, u8 qmc_opcode)
 {
 	return cpm_command(chan->id << 2, (qmc_opcode << 4) | 0x0E);
@@ -921,7 +1042,6 @@ static int qmc_of_parse_chans(struct qmc *qmc, struct device_node *np)
 
 static int qmc_init_tsa_64rxtx(struct qmc *qmc, const struct tsa_serial_info *info)
 {
-	struct qmc_chan *chan;
 	unsigned int i;
 	u16 val;
 
@@ -935,18 +1055,6 @@ static int qmc_init_tsa_64rxtx(struct qmc *qmc, const struct tsa_serial_info *in
 	for (i = 0; i < 64; i++)
 		qmc_write16(qmc->scc_pram + QMC_GBL_TSATRX + (i * 2), 0x0000);
 
-	/* Set entries based on Rx stuff*/
-	list_for_each_entry(chan, &qmc->chan_head, list) {
-		for (i = 0; i < info->nb_rx_ts; i++) {
-			if (!(chan->rx_ts_mask & (((u64)1) << i)))
-				continue;
-
-			val = QMC_TSA_VALID | QMC_TSA_MASK |
-			      QMC_TSA_CHANNEL(chan->id);
-			qmc_write16(qmc->scc_pram + QMC_GBL_TSATRX + (i * 2), val);
-		}
-	}
-
 	/* Set Wrap bit on last entry */
 	qmc_setbits16(qmc->scc_pram + QMC_GBL_TSATRX + ((info->nb_rx_ts - 1) * 2),
 		      QMC_TSA_WRAP);
@@ -963,7 +1071,6 @@ static int qmc_init_tsa_64rxtx(struct qmc *qmc, const struct tsa_serial_info *in
 
 static int qmc_init_tsa_32rx_32tx(struct qmc *qmc, const struct tsa_serial_info *info)
 {
-	struct qmc_chan *chan;
 	unsigned int i;
 	u16 val;
 
@@ -978,28 +1085,6 @@ static int qmc_init_tsa_32rx_32tx(struct qmc *qmc, const struct tsa_serial_info
 		qmc_write16(qmc->scc_pram + QMC_GBL_TSATTX + (i * 2), 0x0000);
 	}
 
-	/* Set entries based on Rx and Tx stuff*/
-	list_for_each_entry(chan, &qmc->chan_head, list) {
-		/* Rx part */
-		for (i = 0; i < info->nb_rx_ts; i++) {
-			if (!(chan->rx_ts_mask & (((u64)1) << i)))
-				continue;
-
-			val = QMC_TSA_VALID | QMC_TSA_MASK |
-			      QMC_TSA_CHANNEL(chan->id);
-			qmc_write16(qmc->scc_pram + QMC_GBL_TSATRX + (i * 2), val);
-		}
-		/* Tx part */
-		for (i = 0; i < info->nb_tx_ts; i++) {
-			if (!(chan->tx_ts_mask & (((u64)1) << i)))
-				continue;
-
-			val = QMC_TSA_VALID | QMC_TSA_MASK |
-			      QMC_TSA_CHANNEL(chan->id);
-			qmc_write16(qmc->scc_pram + QMC_GBL_TSATTX + (i * 2), val);
-		}
-	}
-
 	/* Set Wrap bit on last entries */
 	qmc_setbits16(qmc->scc_pram + QMC_GBL_TSATRX + ((info->nb_rx_ts - 1) * 2),
 		      QMC_TSA_WRAP);
@@ -1081,6 +1166,10 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
 
 	chan->qmc = qmc;
 
+	ret = qmc_chan_setup_tsa(chan);
+	if (ret)
+		return ret;
+
 	/* Set channel specific parameter base address */
 	chan->s_param = qmc->dpram + (chan->id * 64);
 	/* 16 bd per channel (8 rx and 8 tx) */
-- 
2.41.0

