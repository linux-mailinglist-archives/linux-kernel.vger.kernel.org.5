Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1289F7F0839
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 19:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjKSSBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 13:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSSBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 13:01:07 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE011A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 10:01:02 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4m6NrcUgrFU7r4m6Nraean; Sun, 19 Nov 2023 19:01:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700416860;
        bh=D9wojedEadZdu2iTbiZJ38zeqMFJAX9Aio1ZOOzrLHE=;
        h=From:To:Cc:Subject:Date;
        b=Rt54wfK+C6TaKiaI6K8DP50+lLKnTvR9gQtH11z1DGWEg+NBiU3YVSwh9HufpVqrA
         CtLpq493ZrCBkJcXqEenO3wLN/9MtPu3lo71Ptr7sELw08fmWKJLY7lGuMIizBuDX3
         XoA1YRajEuX6g7pRQaAPQ//87p9ifdeLLn1VK1bp+s2pxoRJSSfciO9viZD5bXrVVg
         p7RMS4HGtb3Al/YTyjxyQ1XAAwmJF0L9awGvcRfLvwWGte3gWJmbSNn/O+eYq/tySe
         8KUhcGlI2i/hyK6+jcFKW/XSm0DrwJp5CNuLAnfcjwIGkDZt+5Wb80JhPTQfEiw/lG
         OiCAttq3tj6tg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Nov 2023 19:01:00 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: sh-sci: convert not to use dma_request_slave_channel()
Date:   Sun, 19 Nov 2023 19:00:58 +0100
Message-Id: <d6773b9bd88dbbbea06bc6d5cd59aa117b1ee2ee.1700416841.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
This patch is NOT compile tested. I've not been able to find a correct
setting so that CONFIG_SERIAL_SH_SCI_DMA is set.
---
 drivers/tty/serial/sh-sci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 84ab434c94ba..b2cc2c1a111e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1558,10 +1558,9 @@ static struct dma_chan *sci_request_dma_chan(struct uart_port *port,
 	struct dma_slave_config cfg;
 	int ret;
 
-	chan = dma_request_slave_channel(port->dev,
-					 dir == DMA_MEM_TO_DEV ? "tx" : "rx");
-	if (!chan) {
-		dev_dbg(port->dev, "dma_request_slave_channel failed\n");
+	chan = dma_request_chan(port->dev, dir == DMA_MEM_TO_DEV ? "tx" : "rx");
+	if (IS_ERR(chan)) {
+		dev_dbg(port->dev, "dma_request_chan failed\n");
 		return NULL;
 	}
 
-- 
2.34.1

