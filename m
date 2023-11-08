Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCED7E5926
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjKHOeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjKHOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:34:06 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C261FC4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:34:03 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507bd19eac8so9120054e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699454042; x=1700058842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XORLfLOVJ2jQDbg32nclaixgD4oigISmdEZzRfl6mkQ=;
        b=IcaMB8IjImBULJ/qiQBgUKoRwl9C5u0thSNnUZreqIZHkgh7jVZVDZb+1Fa6d/emvL
         2NlHpyTFR4sohIegZsOqulu/CtRmI9S6zC72DtjXW8ij3nI8IVxn3a7Z4tUFpPhCTWQb
         4+E0EItUkG8CxY1NHXWrpwhB/f+J0UTZNTvxxtsk/WRW1xfQTmQZwGsywg9QDwyPKrDx
         Z9W+IimFtSzqXeQHqe3ZS4NERbdc/b+iK/AlvZOOgCllMzXukhd9cxPwf/C0CG3R9FdP
         I6hLd9YMI3vR5aoflBvFYnSjhT8xLC3NGioJnwpyInDVNpG9+bW+lAU1cItBz4ao6155
         3hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454042; x=1700058842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XORLfLOVJ2jQDbg32nclaixgD4oigISmdEZzRfl6mkQ=;
        b=WSJ/6AZyOgcQ0bGuZv8IafhWaOquFSa5Ucr8ePsHJH7uMDLr5mDpzn6Xt9nl8pK8DX
         PmMBqO+h3L77dyZcHs01S/ggfXFQaSLJFObsgVnkm44g1oN6nZAZznrr3ti0iXKY/Blc
         cavHYFxy37DvRWUFfsclBTSQMIUF+OOEEb9nm0SmXMMN5NkbIhM/pL2M79OrRyV9KKY6
         YjRx5tsTxChBQ/tBw3MPrxkn4ednHEFa+lS9IfczNj/3DiEkeCy2oi7qIqmiLekLVn9s
         NnyzVYT5R9PrBzeEJsT/0VPKoMr8+bOnk7+DiNPHXuWBIubrDM0+qDpwrO4nzvFFC9TR
         O3Wg==
X-Gm-Message-State: AOJu0YwRtr1rj6UZA+IU0NsZ9BzM2ne7Kz5CRVZWAp6iAaAOTsEUAEEB
        ONhynvgs0Ra6TXYbLnXijB3U6g==
X-Google-Smtp-Source: AGHT+IFUUB+MEIyguPoyxj1+fLJV+aOZb8wF1YqAbqWQ7eWQC+wzmv7GE9RSys2AiakbuL3fuZImwg==
X-Received: by 2002:ac2:5d2b:0:b0:500:7685:83d with SMTP id i11-20020ac25d2b000000b005007685083dmr1266850lfb.48.1699454041779;
        Wed, 08 Nov 2023 06:34:01 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q10-20020ac24a6a000000b00507a3b8b007sm686773lfp.110.2023.11.08.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:34:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 08 Nov 2023 15:33:51 +0100
Subject: [PATCH 3/6] MIPS: NI 169445: Fix NAND GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-fix-mips-nand-v1-3-5fc5586d04de@linaro.org>
References: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
In-Reply-To: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the GPIOs defined in the device tree to recommended
practice, which is also what the Linux NAND GPIO driver is actually
using.

In the process, fix up the CE and WP lines to be active low, as is
required for proper hardware description.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/mips/boot/dts/ni/169445.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/dts/ni/169445.dts b/arch/mips/boot/dts/ni/169445.dts
index 5389ef46c480..3e7b46d5072c 100644
--- a/arch/mips/boot/dts/ni/169445.dts
+++ b/arch/mips/boot/dts/ni/169445.dts
@@ -1,4 +1,5 @@
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	#address-cells = <1>;
@@ -57,18 +58,18 @@ gpio2: gpio@14 {
 			no-output;
 		};
 
-		nand@0 {
+		nand-controller@0 {
 			compatible = "gpio-control-nand";
 			nand-on-flash-bbt;
 			nand-ecc-mode = "soft_bch";
 			nand-ecc-step-size = <512>;
 			nand-ecc-strength = <4>;
 			reg = <0x0 4>;
-			gpios = <&gpio2 0 0>, /* rdy */
-				<&gpio1 1 0>, /* nce */
-				<&gpio1 2 0>, /* ale */
-				<&gpio1 3 0>, /* cle */
-				<&gpio1 4 0>; /* nwp */
+			rdy-gpios = <&gpio2 0 GPIO_ACTIVE_HIGH>;
+			ce-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+			ale-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+			cle-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+			wp-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
 
 		serial@80000 {

-- 
2.34.1

