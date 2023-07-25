Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBCA761B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGYOYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjGYOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:24:08 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BB9136;
        Tue, 25 Jul 2023 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3cFxvmO7sr+2mXLVwLsYIFte9IVFO4PRYte249nYxi0=; b=xXkDTr7Dl+mL1rrAzE1nbtT4V2
        3IaRkderAgNLBt8DNoqgbZh2K/EsO1vfOgPJxad1j+d4B7Njqz2bfmoJermebm81vkSJcggDkfOST
        AllvGuolvFhziGIi9kPLVN9Q7uclLtonVK6LyOWxw+iHSiQeSqNdY5z6SbCQqGHnxFMU=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:34256 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qOIx8-0003Kt-IW; Tue, 25 Jul 2023 10:23:55 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Jul 2023 10:23:35 -0400
Message-Id: <20230725142343.1724130-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230725142343.1724130-1-hugo@hugovil.com>
References: <20230725142343.1724130-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v9 03/10] serial: sc16is7xx: remove obsolete out_thread label
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Commit c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later
in probe") moved GPIO setup code later in probe function. Doing so
also required to move ports cleanup code (out_ports label) after the
GPIO cleanup code.

After these moves, the out_thread label becomes misplaced and makes
part of the cleanup code illogical.

This patch remove the now obsolete out_thread label and make GPIO
setup code jump to out_ports label if it fails.

Fixes: c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later in probe")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 306ae512b38a..32d43d00a583 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1516,7 +1516,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->gpio.can_sleep	 = 1;
 		ret = gpiochip_add_data(&s->gpio, s);
 		if (ret)
-			goto out_thread;
+			goto out_ports;
 	}
 #endif
 
@@ -1542,8 +1542,6 @@ static int sc16is7xx_probe(struct device *dev,
 #ifdef CONFIG_GPIOLIB
 	if (devtype->nr_gpio)
 		gpiochip_remove(&s->gpio);
-
-out_thread:
 #endif
 
 out_ports:
-- 
2.30.2

