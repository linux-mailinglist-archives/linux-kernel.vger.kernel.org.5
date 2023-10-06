Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD84D7BB873
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjJFNCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjJFNBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:01:19 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7BE191
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:00:54 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231006130043euoutp026fcc57759566ff8244b738caa6580fbb~LhjRDGdQo0812808128euoutp02G
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:00:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231006130043euoutp026fcc57759566ff8244b738caa6580fbb~LhjRDGdQo0812808128euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696597243;
        bh=AOZzdNsiIIIEQWK65sqBy/MBDyGZPZVzaQ8WJ1M1Fmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6twxmSedXgxWZ+cur1+JhVEgwvc8K9hJs3uaoZt52U1oylvmU6wqUEPAqbsdx8lD
         WciZ4JetzExz28Xf/TnO5/FWUts+TBQRAEB67GngN3wDhPToAWFoo9LIgesTCPUFFH
         3oKisOIgXAtPp4fkRkWY2mM6BTlvXp6D2j3si/30=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231006130043eucas1p2b7bdba9576ded243fd11d5b5afad1d5f~LhjQqO_Zh3171131711eucas1p2z;
        Fri,  6 Oct 2023 13:00:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 81.5A.42423.BF400256; Fri,  6
        Oct 2023 14:00:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231006130042eucas1p10679037ebd812183a5edff0b7c1e8b6a~LhjQSIonV3121531215eucas1p1r;
        Fri,  6 Oct 2023 13:00:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231006130042eusmtrp1a1746a9796ef019077cb3211a98852a3~LhjQRnFkb3155531555eusmtrp12;
        Fri,  6 Oct 2023 13:00:42 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-52-652004fb3294
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.AA.25043.AF400256; Fri,  6
        Oct 2023 14:00:42 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006130041eusmtip2d61d013f799ccdcb01385d85e9f977e5~LhjPax9vM2282522825eusmtip2c;
        Fri,  6 Oct 2023 13:00:41 +0000 (GMT)
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
Subject: [PATCH 3/4] pinctrl: samsung: choose GPIO numberspace base
 dynamically
Date:   Fri,  6 Oct 2023 14:55:56 +0200
Message-ID: <20231006125557.212681-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231006125557.212681-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87q/WRRSDQ5f5LZ4MG8bm8Xe11vZ
        Lab8Wc5ksenxNVaLzfP/MFpc3jWHzWLG+X1MFhOPTWa2WHvkLrvF4TftrBardv1hdOD22Dnr
        LrvHnWt72Dw2L6n36NuyitHj8ya5ANYoLpuU1JzMstQifbsEroxZW6YyFWxhr/i5uYelgXEx
        WxcjJ4eEgInExGltjF2MXBxCAisYJWYseAXlfGGU2D1vJTOE85lR4nc3Qsu3nrVsEInljBJ7
        5jZCtbQySXx/spUVpIpNwEDiwZtl7CAJEYF2RomeW7fAqpgF9jFJTN54EaxKWCBQomt6AzuI
        zSKgKtF5ZA+QzcHBK2ArsWGKEMQ6eYk9i74zgdicAnYSTc+/s4DYvAKCEidnPgGzmYFqmrfO
        BrtVQuAKh0TTqQlMEM0uEs2710DZwhKvjm9hh7BlJE5P7mGBsPMlZmx+zwKyV0KgQuLuQS8I
        01ri4xlmEJNZQFNi/S59iGJHiWOnLkMV80nceCsIcQCfxKRt05khwrwSHW1Qt6tKHN8ziRnC
        lpZ40nIb6hQPiXdrl7JMYFScheSVWUhemYWwdwEj8ypG8dTS4tz01GLDvNRyveLE3OLSvHS9
        5PzcTYzAdHT63/FPOxjnvvqod4iRiYPxEKMEB7OSCG96g0yqEG9KYmVValF+fFFpTmrxIUZp
        DhYlcV7VFPlUIYH0xJLU7NTUgtQimCwTB6dUA1PjnOsGorZzumdP2uErtCLDxOf9Wf3LhRue
        WrtebFHQEHJUquxLMsgoMg7bc0XImn/21zK7J4dOmqavLp+z/+T7SVOTJZcrnziuZxN8Qsk2
        YpPz95Trd5/xn/vxqCml5Y9H4K2sjRtu7yua3XFFOS0249g9cc59vQFcpj9E3U+WPcl2SDZb
        qKWp9yDMKFpa5oHMzPz7E+/4WFSwcZx+1Gmdt+F2pdVz/bb2NbNvTk0Iexpa6X7eokkvbb6c
        YZ7Pr8rfinxMIjdWulU8f55jGBOZMk8saeXje+92JFjn63O3/rlXk9vzJGz+X3nf8OlbWnbP
        5TuiOOHwHsNVW5376jeveLjYXyZbg+fim+kXXJRYijMSDbWYi4oTAePbnty2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xe7q/WBRSDa4t0LZ4MG8bm8Xe11vZ
        Lab8Wc5ksenxNVaLzfP/MFpc3jWHzWLG+X1MFhOPTWa2WHvkLrvF4TftrBardv1hdOD22Dnr
        LrvHnWt72Dw2L6n36NuyitHj8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2Pz
        WCsjUyV9O5uU1JzMstQifbsEvYxZW6YyFWxhr/i5uYelgXExWxcjJ4eEgInEt561QDYXh5DA
        UkaJKT+3QyWkJQ5/mcIOYQtL/LnWBVXUzCTxdEUTK0iCTcBA4sGbZWBFIgLdjBLfJnKBFDEL
        HGCSWDLrINgkYQF/iW8tR1hAbBYBVYnOI3uAGjg4eAVsJTZMEYJYIC+xZ9F3JhCbU8BOoun5
        d7ByIaCSQzv2gMV5BQQlTs58AhZnBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6RUn
        5haX5qXrJefnbmIExs62Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzpDTKpQrwpiZVVqUX58UWl
        OanFhxhNgc6eyCwlmpwPjN68knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+
        Jg5OqQamjDdfC94sVTviX53/OKT6wsePR45nBJodW2Q0jWn5skrB0L0eKYJ/D85dYXZXYN8U
        xffPfU0Oib2e8rK0Pf+cUND3eX4SvBMn35adZn/epfGHzst1onvEVUsnL28pP2gtWMObNv9X
        7uG4TR/Ufa4bMGg/v7qzw7reyjA5mrVP72vBX6nED4EHTE/IBy37dKfed064UPf+d2YxNXLs
        6UeyJPevvfo2eu+Bz7td0u889BUT+FKY5FBQU2Nr8iKdRSR11o2MpEupb1KbOqIiDLnMOqcf
        /5U6f6eqatx7qZh/U9j1Ot7k3+vzEWbZMdNte0aDnYdIwqM9zS1tz+b4x4gdVb4T+1iMk+vu
        mzjptnVKLMUZiYZazEXFiQBwhs5rJgMAAA==
X-CMS-MailID: 20231006130042eucas1p10679037ebd812183a5edff0b7c1e8b6a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231006130042eucas1p10679037ebd812183a5edff0b7c1e8b6a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231006130042eucas1p10679037ebd812183a5edff0b7c1e8b6a
References: <20231006125557.212681-1-m.majewski2@samsung.com>
        <CGME20231006130042eucas1p10679037ebd812183a5edff0b7c1e8b6a@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting it statically is deprecated and results in a warning while
booting the system:

gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 511a3ac51f76..952aeeebb679 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -968,7 +968,7 @@ static int samsung_gpiolib_register(struct platform_device *pdev,
 		bank->gpio_chip = samsung_gpiolib_chip;
 
 		gc = &bank->gpio_chip;
-		gc->base = drvdata->pin_base + bank->pin_base;
+		gc->base = -1; /* Dynamic allocation */
 		gc->ngpio = bank->nr_pins;
 		gc->parent = &pdev->dev;
 		gc->fwnode = bank->fwnode;
-- 
2.42.0

