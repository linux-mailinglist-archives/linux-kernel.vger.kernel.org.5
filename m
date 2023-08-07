Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9467729A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjHGPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjHGPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:44:46 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE85AA;
        Mon,  7 Aug 2023 08:44:43 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 9294B84BB5;
        Mon,  7 Aug 2023 17:44:41 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Mon, 07 Aug 2023 17:42:35 +0200
Subject: [PATCH v4 1/8] gpio: pxa: disable pinctrl calls for MMP_GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230807-pxa1908-lkml-v4-1-cb387d73b452@skole.hr>
References: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
In-Reply-To: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
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
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk0REytG9b9AZWUNTZvv+pvMIbHFwyUfLkkD//s
 pb8tJHOQCuJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNERMgAKCRCaEZ6wQi2W
 4ckaD/42wGkI8wWoLK9rc9E2SKbTT4WMoXNjPCTYTpjZrTLNguWNiYV5nlBkPY4//LOflEjROzI
 yYCZpZ2Sq9Jx+LzLxJiKRBS7Uvp9ViPSj8KxbKwPx9oiBGZ8QLZEEeqpmq+J7O2hdhOtwDE+sHu
 DSJeHGh/mKXC9yepsuvbWICVwGHVExOYok23qg8xwK8K8FEflzO/SUSgkL7oMTFOmCXBfBO/5jS
 W+3C3fUQUF4j4TEd9kzL9bPq6JL/LHDEQtC1Opxa0eJFTlyNZeOkv8Ajq+zG9U2TYz+lmeYAoK+
 xG1iwATLX5v+wQL2O2ZKx4/i8WXojN7kX/yspR8q9feajALzEQMjH/Wz+gi2Vok66UN9qOfGMOz
 Pt0ToLLmQxhaQGoH1zzh6v5syhd4T9rAS81nGS6ZsbsqAEQ+jqxYo6BGRlUAaBTr1gzg8nKQ0uS
 ISfYCT6G0GQ2M0gIhRk41NUJPUzukKdJX5AcxHE7XO8TMoizATel0wu7ECNTThVrjxJv9j801FI
 PjZgz8tHHKWhexK3zS2BCAOhazAkX7XLOfftyebEkm/pzd3cjliAhfJOOF/7nFiDuTMIB/y8Q01
 BL/a0kdYXzX5bALOn8gRWp4YJJx/Zc6uWuDLXsW4gvz5v4yDHWVHajRyY48uGo/u86p7wIiLk8H
 FYhjQ97ZRYVqDuQ==
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


