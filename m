Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE387658BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjG0QaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjG0QaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:30:16 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204A226AB;
        Thu, 27 Jul 2023 09:30:13 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 4D8F8838C5;
        Thu, 27 Jul 2023 18:30:12 +0200 (CEST)
From:   =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v2 2/9] gpio: pxa: use dynamic allocation of base
Date:   Thu, 27 Jul 2023 18:29:00 +0200
Message-ID: <20230727162909.6031-3-duje.mihanovic@skole.hr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727162909.6031-1-duje.mihanovic@skole.hr>
References: <20230727162909.6031-1-duje.mihanovic@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the warning in dmesg that static allocation of the base is
deprecated.

This will break some older PXA boards (such as Spitz) as they still
seem to rely on fixed GPIO numbers with gpio_request and such.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/gpio/gpio-pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index d92650aecb06..b48d142b736d 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -351,6 +351,7 @@ static int pxa_init_gpio_chip(struct pxa_gpio_chip *pchip, int ngpio, void __iom
 
 	pchip->chip.parent = pchip->dev;
 	pchip->chip.label = "gpio-pxa";
+	pchip->chip.base = -1;
 	pchip->chip.direction_input  = pxa_gpio_direction_input;
 	pchip->chip.direction_output = pxa_gpio_direction_output;
 	pchip->chip.get = pxa_gpio_get;
-- 
2.41.0


