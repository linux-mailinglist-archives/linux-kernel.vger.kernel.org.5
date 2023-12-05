Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCFC805BD6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442585AbjLEPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442406AbjLEPV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:21:58 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4309410EA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:21:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 168D34001D;
        Tue,  5 Dec 2023 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701789701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bd6V9l+8bS6As2+K/MjWt5mahUE4lNX5ObA4PLj5bLk=;
        b=Sh2cL8Ov+o9ZZqjkwW8K8DMYAiHqzR5NIEQFEvynU5/wZwaaenOWr/feHREqR0XB+bNdcM
        RTE5Fg3auuphyfk2J5FGUUZsBpym8JTRs3TXa7FNr6vFfFbFCM/Bo53KjowK4W+riuS1fN
        rmYBMKWFgZC+bsQtt9s19sm0Rx2wVcW88Spqu21Ba/S5ofMvZzaAT3xHWJQE8DwMPUPDZU
        POQKmHoMI4B5oP2X6LWiDH+U0ed+cukNoR7q9/86qW8xcNJCFAkfC0FVTHw7rFP/IoAJ+Y
        MQKzwAJdpt5nonEhonw80Ya7k1PFLu6Le6B7wnEWZGB5vX0cNzxfysPT/w6qpw==
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
Subject: [PATCH v2 16/17] soc: fsl: cpm1: qmc: Remove timeslots handling from setup_chan()
Date:   Tue,  5 Dec 2023 16:21:13 +0100
Message-ID: <20231205152116.122512-17-herve.codina@bootlin.com>
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

Timeslots setting is done at channel start() and stop().
There is no more need to do that during setup_chan().

Simply remove timeslot setting from setup_chan().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index bc72c1bc0ec4..45d9cb40a118 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -723,30 +723,6 @@ static int qmc_chan_setup_tsa_rx(struct qmc_chan *chan, bool enable)
 	return qmc_chan_setup_tsa_32rx(chan, &info, enable);
 }
 
-static int qmc_chan_setup_tsa(struct qmc_chan *chan, bool enable)
-{
-	struct tsa_serial_info info;
-	int ret;
-
-	/* Retrieve info from the TSA related serial */
-	ret = tsa_serial_get_info(chan->qmc->tsa_serial, &info);
-	if (ret)
-		return ret;
-
-	/*
-	 * Setup one common 64 entries table or two 32 entries (one for Tx
-	 * and one for Tx) according to assigned TS numbers.
-	 */
-	if (chan->qmc->is_tsa_64rxtx)
-		return qmc_chan_setup_tsa_64rxtx(chan, &info, enable);
-
-	ret = qmc_chan_setup_tsa_32rx(chan, &info, enable);
-	if (ret)
-		return ret;
-
-	return qmc_chan_setup_tsa_32tx(chan, &info, enable);
-}
-
 static int qmc_chan_command(struct qmc_chan *chan, u8 qmc_opcode)
 {
 	return cpm_command(chan->id << 2, (qmc_opcode << 4) | 0x0E);
@@ -1321,10 +1297,6 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
 
 	chan->qmc = qmc;
 
-	ret = qmc_chan_setup_tsa(chan, true);
-	if (ret)
-		return ret;
-
 	/* Set channel specific parameter base address */
 	chan->s_param = qmc->dpram + (chan->id * 64);
 	/* 16 bd per channel (8 rx and 8 tx) */
-- 
2.43.0

