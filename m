Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D147FFAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346784AbjK3TLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346808AbjK3TK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:10:56 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AFED48;
        Thu, 30 Nov 2023 11:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=+C2rMVaTduF6YlqPHUV8r6+wZ3YkoCss7GeQcUmG76E=; b=pDGP7fddQm5YkmjnInVtn2L6ho
        NabFh1q694EK1acKXNGOBRXPAcKvPZWqr/p17Yt4SgnHCH5usWuIzWKeaT7EI3FELU31iDkkeOcWF
        fxz1UeyQczXbowhF/RceAJTAg6Y6OzLUMGDbQ1VzUvoVSX37phe44P/gqq50N38ss2TY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48272 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r8mR9-0003sb-LH; Thu, 30 Nov 2023 14:11:00 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        hugo@hugovil.com
Date:   Thu, 30 Nov 2023 14:10:48 -0500
Message-Id: <20231130191050.3165862-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130191050.3165862-1-hugo@hugovil.com>
References: <20231130191050.3165862-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH 6/7] serial: max310x: add macro for max number of ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add macro to hold the maximum number of UART ports per IC/device.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index f3a99daebdaa..58dd5cc62014 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -30,6 +30,7 @@
 #define MAX310X_MAJOR			204
 #define MAX310X_MINOR			209
 #define MAX310X_UART_NRMAX		16
+#define MAX310X_MAX_PORTS		4 /* Maximum number of UART ports per IC. */
 
 /* MAX310X register definitions */
 #define MAX310X_RHR_REG			(0x00) /* RX FIFO */
@@ -1502,7 +1503,7 @@ static const struct max310x_if_cfg __maybe_unused max310x_spi_if_cfg = {
 static int max310x_spi_probe(struct spi_device *spi)
 {
 	const struct max310x_devtype *devtype;
-	struct regmap *regmaps[4];
+	struct regmap *regmaps[MAX310X_MAX_PORTS];
 	unsigned int i;
 	int ret;
 
@@ -1605,7 +1606,7 @@ static int max310x_i2c_probe(struct i2c_client *client)
 	const struct max310x_devtype *devtype =
 			device_get_match_data(&client->dev);
 	struct i2c_client *port_client;
-	struct regmap *regmaps[4];
+	struct regmap *regmaps[MAX310X_MAX_PORTS];
 	unsigned int i;
 	u8 port_addr;
 
-- 
2.39.2

