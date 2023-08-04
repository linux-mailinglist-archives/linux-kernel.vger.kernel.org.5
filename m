Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCAD7701D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHDNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjHDNew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:34:52 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898AB11B;
        Fri,  4 Aug 2023 06:34:42 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 7D3D9837FE;
        Fri,  4 Aug 2023 15:34:40 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 04 Aug 2023 15:32:31 +0200
Subject: [PATCH v3 1/8] gpio: pxa: disable pinctrl calls for MMP_GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230804-pxa1908-lkml-v3-1-8e48fca37099@skole.hr>
References: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
In-Reply-To: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=717;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=KpHlcLrUY59P26MylBMaHpzA91WHfXQj5w9V31CEE9k=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBkzP48AZceUblxAiuJ5KgUSAnXzzFTNjATUDUjM
 C5BfXeom6qJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZMz+PAAKCRCaEZ6wQi2W
 4V+iD/9LZHUwUQv8ebIUN4OHwIkM4NYbYKjSgrY0mPmZYX4ZWO/4R0GWHMS24Dh4qWUT4EoTEq3
 q8usrjH1B7NIB5FVYLW5B13eVT3eXUrnmxI82VInekPQ0LCbFS5sZS80/Lr0uMTXM90U3nvomkW
 1SM5MHuKvtoWDqLdNY6mE35obYgli7uHNoO/QvCprshio0ETcZWnzjqaMzlKXngW3CcThLhdVLC
 0sm9qQo+nngr5z9raW+svdF8ilndckrN0FHcWFg2QKjwnOYH3qngkZYZC0Q2X0n+TrpVRJULSRr
 VvJJH/6/z03q1Z7+zYcZhY+UVhamD9rJwdccuFmPpOjuxjorCXrMO+2PqW/VOjBLKHFjcGIwjec
 68kJeNhqN78zHtO5OLPAhighRYQLBAZgMj8ziu7pC19BaLUZKQ/bxDTXWK++KNJyGaqrJN1poCa
 hDq88OAtrxNv8yPPuRL2+eSnFC/92/d0PVt8Tq0tDM4k1LOT3BmiYu2C9fqO2O0yM/SzYSEV/Wu
 huCX4YljTpettw91qzBKuZbIIwH2A9jwrDehtzKNzIfxUWjNISqfrRSBleZOJsNEgW94RQoVF3E
 b6qW9t5Brb1VQ5DC5vOo63rVdqJHv1oyQvlyk8LSVz3j63cGE+7VS/nG9wN3WNRRoU+afpvBu2E
 DH75gaHziN7O+JA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to PXA3xx and MMP2, pinctrl-single isn't capable of setting
pin direction on MMP either.

Fixes: a770d946371e ("gpio: pxa: add pin control gpio direction and request")
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/gpio/gpio-pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index a1630ed4b741..d92650aecb06 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -238,6 +238,7 @@ static bool pxa_gpio_has_pinctrl(void)
 	switch (gpio_type) {
 	case PXA3XX_GPIO:
 	case MMP2_GPIO:
+	case MMP_GPIO:
 		return false;
 
 	default:

-- 
2.41.0


