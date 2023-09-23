Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21C7ABE4D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjIWHPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjIWHPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:15:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE30A7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 00:15:42 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jwrbqrekTcLIgjwrbqAzVs; Sat, 23 Sep 2023 09:15:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695453340;
        bh=Pwbdp/ALGy4X1W3d5bb3j8VmlzglmaHLWQ82s+zIwjM=;
        h=From:To:Cc:Subject:Date;
        b=bsXnvC+OsPEQQYIP6GC2EcGJcwME9UMZuNil/vQx6pXE8Vz3SIcCBxlJuXLeu8Uqj
         uw+ErlMH6E+a7lSNvdRjPzzE8qGDtwKYul1uni7zIapmNguUaCcOnjAoM5+IY9xYgk
         pwJujQ1DJpxrWbwmvXnz170LInVGPwBPVs2YfLvrHLnfgD+EFf2Flv33TkyBxC6yUl
         2DnTgiOfGDV3j/I0pT0DjAWDYibH/W0bTkzpCCm9TDUOx0v14Vz6hybqdK+f3Se6E1
         Dd+foaEyIbawZ71lt4+4d+Rwn6QLFbLV7ZLAanJWFfSSoFz1oXb7xYNqkYv4dlay80
         FyTjIFWMxs7aA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 23 Sep 2023 09:15:40 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Bryan Wu <bryan.wu@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jamie Iles <jamie@jamieiles.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org
Subject: [PATCH] leds: trigger: ledtrig-cpu:: Fix a warning when compiling with W=1
Date:   Sat, 23 Sep 2023 09:15:38 +0200
Message-Id: <3f4be7a99933cf8566e630da54f6ab913caac432.1695453322.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to teach the compiler that 'trig->name' will never be truncated,
we need to tell it that 'cpu' is not negative.

When building with W=1, this fixes the following warnings:

  drivers/leds/trigger/ledtrig-cpu.c: In function ‘ledtrig_cpu_init’:
  drivers/leds/trigger/ledtrig-cpu.c:155:56: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 5 [-Werror=format-truncation=]
    155 |                 snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
        |                                                        ^~
  drivers/leds/trigger/ledtrig-cpu.c:155:52: note: directive argument in the range [-2147483648, 7]
    155 |                 snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
        |                                                    ^~~~~~~
  drivers/leds/trigger/ledtrig-cpu.c:155:17: note: ‘snprintf’ output between 5 and 15 bytes into a destination of size 8
    155 |                 snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 8f88731d052d ("led-triggers: create a trigger for CPU activity")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/leds/trigger/ledtrig-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-cpu.c b/drivers/leds/trigger/ledtrig-cpu.c
index 8af4f9bb9cde..05848a2fecff 100644
--- a/drivers/leds/trigger/ledtrig-cpu.c
+++ b/drivers/leds/trigger/ledtrig-cpu.c
@@ -130,7 +130,7 @@ static int ledtrig_prepare_down_cpu(unsigned int cpu)
 
 static int __init ledtrig_cpu_init(void)
 {
-	int cpu;
+	unsigned int cpu;
 	int ret;
 
 	/* Supports up to 9999 cpu cores */
@@ -152,7 +152,7 @@ static int __init ledtrig_cpu_init(void)
 		if (cpu >= 8)
 			continue;
 
-		snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
+		snprintf(trig->name, MAX_NAME_LEN, "cpu%u", cpu);
 
 		led_trigger_register_simple(trig->name, &trig->_trig);
 	}
-- 
2.34.1

