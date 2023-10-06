Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4DB7BB86E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjJFNBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjJFNBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:01:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D7E1738
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:00:43 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231006130041euoutp0184fc4e70ff082c65b9e4571a492a9f45~LhjPgN8B20240502405euoutp01x
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:00:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231006130041euoutp0184fc4e70ff082c65b9e4571a492a9f45~LhjPgN8B20240502405euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696597242;
        bh=abGhTwdfkPSXmGau8dmreOOqNAsta01p/xrYBl7NXzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+qvzxlpCIHNU6XTOH2E0Z/gc2TwAjssh6On7kzV7vT7m1h+f54356u7BUnmxNoVJ
         jT83qlnp0rFyHe/VDOIUds6CnUYRDPtIbk5GnUvz5fSlam6WFKDjx10Wcjlx3shrNP
         gjehXN19vxzLgVC9QcffOlHHnArhOMUgvLaw2X6A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231006130041eucas1p2ed62ed5f8c513fcffb6097235db13a24~LhjPHGylE2196721967eucas1p2c;
        Fri,  6 Oct 2023 13:00:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id ED.13.37758.9F400256; Fri,  6
        Oct 2023 14:00:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231006130041eucas1p1fd945c734c0d35067107e7c699201bdb~LhjOqoppP3121531215eucas1p1o;
        Fri,  6 Oct 2023 13:00:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231006130041eusmtrp230bdbb5ee5dd38bb2b10626476a08e48~LhjOqCYQX0212502125eusmtrp2h;
        Fri,  6 Oct 2023 13:00:41 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-9e-652004f9bb5f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5F.1E.10549.8F400256; Fri,  6
        Oct 2023 14:00:41 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006130040eusmtip21462b213c9f036b15634f5f0a6f3bf10~LhjOCzCT81292012920eusmtip2U;
        Fri,  6 Oct 2023 13:00:40 +0000 (GMT)
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/4] pinctrl: samsung: use add_pin_ranges method to add
 pinctrl ranges
Date:   Fri,  6 Oct 2023 14:55:55 +0200
Message-ID: <20231006125557.212681-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231006125557.212681-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87o/WRRSDRY/lrV4MG8bm8Xe11vZ
        Lab8Wc5ksenxNVaLzfP/MFpc3jWHzWLG+X1MFhOPTWa2WHvkLrvF4TftrBardv1hdOD22Dnr
        LrvHnWt72Dw2L6n36NuyitHj8ya5ANYoLpuU1JzMstQifbsEroz2W/1MBScUKlY/f8zUwNgp
        3cXIySEhYCIx7/4pti5GLg4hgRWMElfuT2KGcL4wSjxsOsUOUiUk8JlR4maPIkxH69W7TBBF
        yxkldn1oZIVwWpkkZmxcBNbBJmAg8eDNMnaQhIhAO6NEz61bjCAOs8A+JonJGy+yglQJC0RI
        bFqznAnEZhFQlZjUuI0ZxOYVsJWYPWkvM8Q+eYk9i76D1XAK2Ek0Pf/OAlEjKHFy5hMwmxmo
        pnnrbLDDJQSucEhMn/WSFaLZRWLiqYPsELawxKvjW6BsGYn/O+czQdj5EjM2vwcaxAFkV0jc
        PegFYVpLfDzDDGIyC2hKrN+lD1HsKLFw/nYmiAo+iRtvBSEO4JOYtG06M0SYV6KjTQiiWlXi
        +J5JUH9ISzxpuQ210kNi8uvpzBMYFWcheWUWkldmIexdwMi8ilE8tbQ4Nz212DgvtVyvODG3
        uDQvXS85P3cTIzAdnf53/OsOxhWvPuodYmTiYDzEKMHBrCTCm94gkyrEm5JYWZValB9fVJqT
        WnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgmy8TBKdXA1N4957yWRs1LF3PLCLs/SzfV3pl2
        42z9ywW233mZ+zIvl8U3lwWHGhve/XeKhWdd54mzb8uPKD6QWVC+QVEwx+vK4pMs6/p0X4g1
        tnqXfXqzzLKgxEqcbaW14OVtGrInPb7/P9onyPAwPDf02TL12XHM9xLua/5paX/VZai7bAf3
        N/0Dpz9UPIhe+vNiU0eQoVrMs/fdXJ+PTJ/OXFsjNc2gpuNNtOq6tbY7lZztzP2dxOfuTbs5
        Vynq0NfuXSInJl/2Z2NrySs584ZxxuJ8zb+VimsupecfPbzwTznnrHtflSrlvVMZRV732ql/
        r8qvT/T5U7iNOfXNZEatve0iorxXzJNrQ+XkH23kK7itxFKckWioxVxUnAgAqc8Gg7YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xe7o/WRRSDbprLR7M28Zmsff1VnaL
        KX+WM1lsenyN1WLz/D+MFpd3zWGzmHF+H5PFxGOTmS3WHrnLbnH4TTurxapdfxgduD12zrrL
        7nHn2h42j81L6j36tqxi9Pi8SS6ANUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzW
        yshUSd/OJiU1J7MstUjfLkEvo/1WP1PBCYWK1c8fMzUwdkp3MXJySAiYSLRevcvUxcjFISSw
        lFHi4M4V7BAJaYnDX6ZA2cISf651sUEUNTNJ3Py4hgUkwSZgIPHgzTKwIhGBbkaJbxO5QIqY
        BQ4wSSyZdZANJCEsECbx4do7MJtFQFViUuM2ZhCbV8BWYvakvcwQG+Ql9iz6zgRicwrYSTQ9
        /w62QAio5tCOPUwQ9YISJ2c+AYszA9U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoT
        c4tL89L1kvNzNzECY2fbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd70BplUId6UxMqq1KL8+KLS
        nNTiQ4ymQHdPZJYSTc4HRm9eSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwf
        EwenVAOTz7Wzck29V8vUNJsuF6+e/u75zHMLpptc2+656HZ469lQsURJ8SntFjL3+OXn3PX9
        dHh7cE2H8O0rN1I3c7+an6v0f+uV1zERP1f0GXhO1z17dYGuUuBttcuzst3120NnB2/pdJvl
        tmyNoQLDVlclngM31FbUWVuGrjrtZuD3WmLvGt7s1dJ1qeLbOVLkf21RT5ep3L+qbKmm2MlO
        2yui0bFb22/L702ZLegqf9tFgHGSqOmLK49/uvIwhUYtflloqSf/yKCql9HvznSTiK231Xdp
        LvvPauWdsdbro8cX25VPHj4vTZ/Wl7XLRPzHo9Ll/HIttrr51m68ceeOP7pXsTymZs+CqnK/
        865HF7QrsRRnJBpqMRcVJwIAenemsyYDAAA=
X-CMS-MailID: 20231006130041eucas1p1fd945c734c0d35067107e7c699201bdb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231006130041eucas1p1fd945c734c0d35067107e7c699201bdb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231006130041eucas1p1fd945c734c0d35067107e7c699201bdb
References: <20231006125557.212681-1-m.majewski2@samsung.com>
        <CGME20231006130041eucas1p1fd945c734c0d35067107e7c699201bdb@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preferable since we can read the base in the global GPIO
numberspace from the chip instead of needing to select it ourselves.

Past versions could not do this, since they needed to add all the ranges
before enabling the pinctrl subsystem, which was done before registering
the GPIO chip. However, right now we enable the pinctrl subsystem after
registering the chip and so this became possible.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 31 +++++++++++++----------
 drivers/pinctrl/samsung/pinctrl-samsung.h |  2 ++
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index e496af72a587..511a3ac51f76 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -665,6 +665,21 @@ static int samsung_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 	return (virq) ? : -ENXIO;
 }
 
+static int samsung_add_pin_ranges(struct gpio_chip *gc)
+{
+	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
+
+	bank->grange.name = bank->name;
+	bank->grange.id = bank->id;
+	bank->grange.pin_base = bank->drvdata->pin_base + bank->pin_base;
+	bank->grange.base = gc->base;
+	bank->grange.npins = bank->nr_pins;
+	bank->grange.gc = &bank->gpio_chip;
+	pinctrl_add_gpio_range(bank->drvdata->pctl_dev, &bank->grange);
+
+	return 0;
+}
+
 static struct samsung_pin_group *samsung_pinctrl_create_groups(
 				struct device *dev,
 				struct samsung_pinctrl_drv_data *drvdata,
@@ -892,6 +907,7 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
 	/* for each pin, the name of the pin is pin-bank name + pin number */
 	for (bank = 0; bank < drvdata->nr_banks; bank++) {
 		pin_bank = &drvdata->pin_banks[bank];
+		pin_bank->id = bank;
 		for (pin = 0; pin < pin_bank->nr_pins; pin++) {
 			sprintf(pin_names, "%s-%d", pin_bank->name, pin);
 			pdesc = pindesc + pin_bank->pin_base + pin;
@@ -911,18 +927,6 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
 		return ret;
 	}
 
-	for (bank = 0; bank < drvdata->nr_banks; ++bank) {
-		pin_bank = &drvdata->pin_banks[bank];
-		pin_bank->grange.name = pin_bank->name;
-		pin_bank->grange.id = bank;
-		pin_bank->grange.pin_base = drvdata->pin_base
-						+ pin_bank->pin_base;
-		pin_bank->grange.base = pin_bank->grange.pin_base;
-		pin_bank->grange.npins = pin_bank->nr_pins;
-		pin_bank->grange.gc = &pin_bank->gpio_chip;
-		pinctrl_add_gpio_range(drvdata->pctl_dev, &pin_bank->grange);
-	}
-
 	return 0;
 }
 
@@ -947,6 +951,7 @@ static const struct gpio_chip samsung_gpiolib_chip = {
 	.direction_input = samsung_gpio_direction_input,
 	.direction_output = samsung_gpio_direction_output,
 	.to_irq = samsung_gpio_to_irq,
+	.add_pin_ranges = samsung_add_pin_ranges,
 	.owner = THIS_MODULE,
 };
 
@@ -963,7 +968,7 @@ static int samsung_gpiolib_register(struct platform_device *pdev,
 		bank->gpio_chip = samsung_gpiolib_chip;
 
 		gc = &bank->gpio_chip;
-		gc->base = bank->grange.base;
+		gc->base = drvdata->pin_base + bank->pin_base;
 		gc->ngpio = bank->nr_pins;
 		gc->parent = &pdev->dev;
 		gc->fwnode = bank->fwnode;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 9af93e3d8d9f..173db20f70d3 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -148,6 +148,7 @@ struct samsung_pin_bank_data {
  * @eint_mask: bit mask of pins which support EINT function.
  * @eint_offset: SoC-specific EINT register or interrupt offset of bank.
  * @name: name to be prefixed for each pin in this pin bank.
+ * @id: id of the bank, propagated to the pin range.
  * @pin_base: starting pin number of the bank.
  * @soc_priv: per-bank private data for SoC-specific code.
  * @of_node: OF node of the bank.
@@ -170,6 +171,7 @@ struct samsung_pin_bank {
 	u32		eint_mask;
 	u32		eint_offset;
 	const char	*name;
+	u32		id;
 
 	u32		pin_base;
 	void		*soc_priv;
-- 
2.42.0

