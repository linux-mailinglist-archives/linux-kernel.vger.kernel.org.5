Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F327F0761
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjKSQNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjKSQM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:12:58 -0500
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D433126
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 08:12:53 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4kPhraC9JxVPt4kPhrzakJ; Sun, 19 Nov 2023 17:12:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700410371;
        bh=Cq+Ma44I5rcVPvAOPNh8K0fTdo2ud4VzNDLd8VR7lXI=;
        h=From:To:Cc:Subject:Date;
        b=ChbdukErzOOtfglZwCpdHBkaxrzADa93OvyXoTIXUi46MzloHVfMLE9En/DKorGUJ
         P67PUvUMGM2Tuxtf2ZASz8tK/Ha20efRoGORtHBBZhklDdIUkI80oBd/bEW+BYYg9W
         PGKQJBdN1GPrDtAaM78QjibbFvlRiI6FX7AWxIHUdDk6UTtvUmhzoOBmHv63yk3rnT
         Al4Uo4eCuAVvBlyUfbHLrIttdWucFsU0OYo3HETEMaekfESvUW/Ml+7at0b7oqvDk2
         oR8S8nSLKLLDDddjpWPU3hP3mkp2wWbGxh4pfjCP1WDB7uFgfZWjSfbSrJkY0RQg8w
         QdkqQ9/u2in5A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Nov 2023 17:12:51 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: imx: convert not to use dma_request_slave_channel()
Date:   Sun, 19 Nov 2023 17:12:48 +0100
Message-Id: <a46b493c6b5cfa09417e3e138e304fd01b61e748.1700410346.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel() is deprecated. dma_request_chan() should
be used directly instead.

Switch to the preferred function and update the error handling accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I don't think that the:
   sport->dma_chan_xx = NULL;
are really needed. I added it just to make sure that the behavior was
exactly the same as before.

Anyway, it can't hurt.

Changing the returned value from -EINVAL to something else is fine. The
only caller on check if == 0 or not.
---
 drivers/tty/serial/imx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 708b9852a575..5cb74d8f9d2a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1336,15 +1336,18 @@ static int imx_uart_dma_init(struct imx_port *sport)
 {
 	struct dma_slave_config slave_config = {};
 	struct device *dev = sport->port.dev;
+	struct dma_chan *chan;
 	int ret;
 
 	/* Prepare for RX : */
-	sport->dma_chan_rx = dma_request_slave_channel(dev, "rx");
-	if (!sport->dma_chan_rx) {
+	chan = dma_request_chan(dev, "rx");
+	if (IS_ERR(chan)) {
 		dev_dbg(dev, "cannot get the DMA channel.\n");
-		ret = -EINVAL;
+		sport->dma_chan_rx = NULL;
+		ret = PTR_ERR(chan);
 		goto err;
 	}
+	sport->dma_chan_rx = chan;
 
 	slave_config.direction = DMA_DEV_TO_MEM;
 	slave_config.src_addr = sport->port.mapbase + URXD0;
@@ -1366,12 +1369,14 @@ static int imx_uart_dma_init(struct imx_port *sport)
 	sport->rx_ring.buf = sport->rx_buf;
 
 	/* Prepare for TX : */
-	sport->dma_chan_tx = dma_request_slave_channel(dev, "tx");
-	if (!sport->dma_chan_tx) {
+	chan = dma_request_chan(dev, "tx");
+	if (IS_ERR(chan)) {
 		dev_err(dev, "cannot get the TX DMA channel!\n");
-		ret = -EINVAL;
+		sport->dma_chan_tx = NULL;
+		ret = PTR_ERR(chan);
 		goto err;
 	}
+	sport->dma_chan_tx = chan;
 
 	slave_config.direction = DMA_MEM_TO_DEV;
 	slave_config.dst_addr = sport->port.mapbase + URTX0;
-- 
2.34.1

