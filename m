Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B197F0744
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjKSPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjKSPzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:55:25 -0500
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435A8128
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:55:21 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4k8jra5LJxVPt4k8jrzYqY; Sun, 19 Nov 2023 16:55:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700409318;
        bh=Pk/dqXN8wqk5MN1OczjCM6gfHKmZ2sdCVcd4g3SfGHU=;
        h=From:To:Cc:Subject:Date;
        b=DEIHA1P0nqzgSjkJf9O8nWTv/D9NfWyIw1YGskUroT1NBO110kk5Ozj5WEZ8ACT3Z
         gGl/iqRkvaIWUGv6Hz6k0SkX3rQMLlRtomZvUzAedUi7qyriZDF8WcOqxvOi1oItaD
         +58UV04puQ8nQt5eFa6RW3732cA55yvcLvNlK+DmBEkpxhMP5x035UmGy90wztY+kV
         aydw5TDN/DNbwMiwNIo5+NZZfux2gLPZB0t2b6C8SPQnd2U7JXF7JDJYiHbMN8aCy5
         H7OtZnEj7t1jisCbbEJoozGPOTu+uHPTy1azyMhOKfWJb+FqH5GqIhG984M1MPXSf3
         TFYAtCT9D6amQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Nov 2023 16:55:18 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] serial: atmel: convert not to use dma_request_slave_channel()
Date:   Sun, 19 Nov 2023 16:55:15 +0100
Message-Id: <f2e9790d8b49aeba8b43ce018d30a35b837ac1eb.1700409299.git.christophe.jaillet@wanadoo.fr>
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
v2: Also update atmel_prepare_rx_dma()
---
 drivers/tty/serial/atmel_serial.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 1946fafc3f3e..6aeb4648843b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1013,14 +1013,18 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	struct device *mfd_dev = port->dev->parent;
 	dma_cap_mask_t		mask;
 	struct dma_slave_config config;
+	struct dma_chan *chan;
 	int ret, nent;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	atmel_port->chan_tx = dma_request_slave_channel(mfd_dev, "tx");
-	if (atmel_port->chan_tx == NULL)
+	chan = dma_request_chan(mfd_dev, "tx");
+	if (IS_ERR(chan)) {
+		atmel_port->chan_tx = NULL;
 		goto chan_err;
+	}
+	atmel_port->chan_tx = chan;
 	dev_info(port->dev, "using %s for tx DMA transfers\n",
 		dma_chan_name(atmel_port->chan_tx));
 
@@ -1188,6 +1192,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	dma_cap_mask_t		mask;
 	struct dma_slave_config config;
 	struct circ_buf		*ring;
+	struct dma_chan *chan;
 	int ret, nent;
 
 	ring = &atmel_port->rx_ring;
@@ -1195,9 +1200,12 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_CYCLIC, mask);
 
-	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
-	if (atmel_port->chan_rx == NULL)
+	chan = dma_request_chan(mfd_dev, "rx");
+	if (IS_ERR(chan)) {
+		atmel_port->chan_rx = NULL;
 		goto chan_err;
+	}
+	atmel_port->chan_rx = chan;
 	dev_info(port->dev, "using %s for rx DMA transfers\n",
 		dma_chan_name(atmel_port->chan_rx));
 
-- 
2.34.1

