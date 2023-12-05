Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C89805C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442467AbjLEPVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442413AbjLEPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:21:29 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92646122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:21:35 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 8D73140019;
        Tue,  5 Dec 2023 15:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701789694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDL7N04gw5BRlFHTIZAz5PXmdYE8Pno1RSYn/SHVcJM=;
        b=ouyRyNt54e1mcTBloSV6JtW7i7S1zO4bPFu5CaE9zkCqiWEwSB8aE/OYMjkr2HOk3YEfeZ
        PfsS4jNuAiPkRrxngxdXDUdyNzsr09awPpj8nQWGnaDsdpwelx8yv5dvE095/aklXHnABf
        cPDMQvpQXS4H++q43Qyrdfmf2duFKkl4rIdE/AQEaVEN3MQBUwrMd9HLVVzwpZpvEOiEcF
        ej/bCfR8iYqjbVX/9mKDqZn4akkPUDp/LZTW7lB7mwr3vRZ/vPOySHWhii0TTExInozMdS
        kCBtNzNWSgC0oP8eXpicGjp6BoG1bUaOuVn+jGfe5eEgKQmspmCnisJ98QVLkQ==
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
Subject: [PATCH v2 08/17] soc: fsl: cpm1: qmc: Rename qmc_setup_tsa* to qmc_init_tsa*
Date:   Tue,  5 Dec 2023 16:21:05 +0100
Message-ID: <20231205152116.122512-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205152116.122512-1-herve.codina@bootlin.com>
References: <20231205152116.122512-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qmc_setup_tsa* are called once at initialisation.
They initialize the QMC TSA table.
In order to introduce setup function later on for dynamic timeslots
management, rename the function to avoid later confusion.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 0413e25d4c67..e3f2afb8fa4d 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -919,7 +919,7 @@ static int qmc_of_parse_chans(struct qmc *qmc, struct device_node *np)
 	return qmc_check_chans(qmc);
 }
 
-static int qmc_setup_tsa_64rxtx(struct qmc *qmc, const struct tsa_serial_info *info)
+static int qmc_init_tsa_64rxtx(struct qmc *qmc, const struct tsa_serial_info *info)
 {
 	struct qmc_chan *chan;
 	unsigned int i;
@@ -961,7 +961,7 @@ static int qmc_setup_tsa_64rxtx(struct qmc *qmc, const struct tsa_serial_info *i
 	return 0;
 }
 
-static int qmc_setup_tsa_32rx_32tx(struct qmc *qmc, const struct tsa_serial_info *info)
+static int qmc_init_tsa_32rx_32tx(struct qmc *qmc, const struct tsa_serial_info *info)
 {
 	struct qmc_chan *chan;
 	unsigned int i;
@@ -1019,7 +1019,7 @@ static int qmc_setup_tsa_32rx_32tx(struct qmc *qmc, const struct tsa_serial_info
 	return 0;
 }
 
-static int qmc_setup_tsa(struct qmc *qmc)
+static int qmc_init_tsa(struct qmc *qmc)
 {
 	struct tsa_serial_info info;
 	int ret;
@@ -1030,12 +1030,12 @@ static int qmc_setup_tsa(struct qmc *qmc)
 		return ret;
 
 	/*
-	 * Setup one common 64 entries table or two 32 entries (one for Tx and
-	 * one for Tx) according to assigned TS numbers.
+	 * Initialize one common 64 entries table or two 32 entries (one for Tx
+	 * and one for Tx) according to assigned TS numbers.
 	 */
 	return ((info.nb_tx_ts > 32) || (info.nb_rx_ts > 32)) ?
-		qmc_setup_tsa_64rxtx(qmc, &info) :
-		qmc_setup_tsa_32rx_32tx(qmc, &info);
+		qmc_init_tsa_64rxtx(qmc, &info) :
+		qmc_init_tsa_32rx_32tx(qmc, &info);
 }
 
 static int qmc_setup_chan_trnsync(struct qmc *qmc, struct qmc_chan *chan)
@@ -1391,7 +1391,7 @@ static int qmc_probe(struct platform_device *pdev)
 	qmc_write32(qmc->scc_pram + QMC_GBL_C_MASK32, 0xDEBB20E3);
 	qmc_write16(qmc->scc_pram + QMC_GBL_C_MASK16, 0xF0B8);
 
-	ret = qmc_setup_tsa(qmc);
+	ret = qmc_init_tsa(qmc);
 	if (ret)
 		goto err_tsa_serial_disconnect;
 
-- 
2.43.0

