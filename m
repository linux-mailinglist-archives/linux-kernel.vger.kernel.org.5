Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065B27FC1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbjK1OJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346064AbjK1OIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:08:36 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2652619A3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:08:37 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id E531060005;
        Tue, 28 Nov 2023 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701180516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHk9CdyIDprG+6Gwz4WRxtkc6hwo9HZn9NzP3/YrC7w=;
        b=Desx5TSsmTS0/uzGXiO4Lq4aFbdVWG8lmbAaJFFFRhvlRy1o2l+lhBElBTKkjBGOfMnqIE
        uSpc3zCiWMxyWDER3hRO2XYyHLp5pnytJH1HIJz04GYla3n0CmIZ501+Y/ASQ2UJleAkkJ
        r58O62KxHlo4gFC3JOSNEuaZzMj/udWounvjEO0T9UV8LTgaMBYLX6NBsT9JMlKCRHLUIy
        c3wygvYCjTeLlHou2sJ+0gyDWPksKZy4XMAC4q+OmDfLsLCPG941Wrc4Xxj1XTQZ6IH7zB
        CzJLNqj+or7iNXvEY8anY6SbtslaasEn6tlUPbvCbNqJRNi5xtsp/BK8aDHLoQ==
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
Subject: [PATCH 14/17] soc: fsl: cpm1: qmc: Introduce is_tsa_64rxtx flag
Date:   Tue, 28 Nov 2023 15:08:13 +0100
Message-ID: <20231128140818.261541-15-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128140818.261541-1-herve.codina@bootlin.com>
References: <20231128140818.261541-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support runtime timeslot route changes, some operations will
be different according the routing table used (common Rx and Tx table or
one table for Rx and one for Tx).

The is_tsa_64rxtx flag is introduced to avoid extra computation to
determine the table format each time we need it.
It is set once at initialization.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 5ca4120779f8..e651b3bba1ca 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -216,6 +216,7 @@ struct qmc {
 	u16 __iomem *int_curr;
 	dma_addr_t int_dma_addr;
 	size_t int_size;
+	bool is_tsa_64rxtx;
 	struct list_head chan_head;
 	struct qmc_chan *chans[64];
 };
@@ -696,7 +697,7 @@ static int qmc_chan_setup_tsa(struct qmc_chan *chan, bool enable)
 	 * Setup one common 64 entries table or two 32 entries (one for Tx
 	 * and one for Tx) according to assigned TS numbers.
 	 */
-	if (info.nb_tx_ts > 32 || info.nb_rx_ts > 32)
+	if (chan->qmc->is_tsa_64rxtx)
 		return qmc_chan_setup_tsa_64rxtx(chan, &info, enable);
 
 	ret = qmc_chan_setup_tsa_32rx(chan, &info, enable);
@@ -1053,6 +1054,7 @@ static int qmc_init_tsa_64rxtx(struct qmc *qmc, const struct tsa_serial_info *in
 	 * Everything was previously checked, Tx and Rx related stuffs are
 	 * identical -> Used Rx related stuff to build the table
 	 */
+	qmc->is_tsa_64rxtx = true;
 
 	/* Invalidate all entries */
 	for (i = 0; i < 64; i++)
@@ -1081,6 +1083,7 @@ static int qmc_init_tsa_32rx_32tx(struct qmc *qmc, const struct tsa_serial_info
 	 * Use a Tx 32 entries table and a Rx 32 entries table.
 	 * Everything was previously checked.
 	 */
+	qmc->is_tsa_64rxtx = false;
 
 	/* Invalidate all entries */
 	for (i = 0; i < 32; i++) {
-- 
2.42.0

