Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F00779EF6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjHLK0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHLK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:26:05 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CED170D;
        Sat, 12 Aug 2023 03:26:08 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 293A182A9B;
        Sat, 12 Aug 2023 12:26:07 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sat, 12 Aug 2023 12:25:05 +0200
Subject: [PATCH v5 1/8] gpio: pxa: disable pinctrl calls for MMP_GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230812-pxa1908-lkml-v5-1-a5d51937ee34@skole.hr>
References: <20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr>
In-Reply-To: <20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr>
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
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk114Ejn0o+sJ9R66MpkeqR5THvpE/2hx19CFsu
 I+erCRU2huJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNdeBAAKCRCaEZ6wQi2W
 4U+wD/4rCSSTNj8ky6MrA4t2w8MZUprN7nQFoRNWTzeT1k/JBeLJD232B4AWHVBaN8s645nc8zZ
 t/uLIrN77JlBAzm9+qTc97mF3MPZ3bmrxlRLgnqnLWxg+l+B+PmA4GzmoIw7QN1qW6F3De+LPkl
 yfIMQX653+tM16G8/P4FTzM/jcc4QvVmjuWEjLfv/Ocz0+5BuQxuqODvOVaMFZIsqimCp2ocYdB
 Uf6Br+DO06FPqtJ1+SEH2fUR8W/D6sR0K0D0dA3syjHqbN1tiUNlc74zJB6zFeZqciFt2f28OoP
 27sT3lXuTCuj2CrUvF+Zs7YpfUge+P/fEyubSiAX0yvqfPfb/R5O+xFhGZhqzUwFsQ0r+nFw5UX
 qg9N5idsmwbelsRjz5UVoBgXymjaq8ehv0k8JkC/iRKAJF6Xe4JLuPSor5s+P4CskhKHBxGz7fR
 lwE/VpOFmjErezbJtr77NHhla7OGyTqcvkbb08q5AnWX4+Uy8nsBqs3CHEUXKNg60o8xY4PNl4k
 zCjYDqU7WX2C3rUC/n9iJTKYlCgiproqDqGQ/kq7JgptLm+qYKuD5GctY7ilirzgUm5a32VVenv
 BOWkAtwezBuJpuJnb0rHbaM5aXDVAuWn5lyetOgXqetp4br3+/PDSRd1BDDieLQsxybkM4N/XRu
 TXEKM5RqVOxT1oQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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


