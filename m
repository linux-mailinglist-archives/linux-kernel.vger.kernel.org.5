Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81A37BB86D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjJFNBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjJFNBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:01:11 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA69172B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:00:40 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231006130039euoutp02be79d6e3304abbc7f5d45ec998c01352~LhjNQ0J-G0813508135euoutp02H
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:00:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231006130039euoutp02be79d6e3304abbc7f5d45ec998c01352~LhjNQ0J-G0813508135euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696597239;
        bh=HHwaNMwgorwT9qyUyNc3f5mPDjxlKqnK60SVh708oL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBfY9BMj0TkQo5INau6r7hV2y/CHAUmHMxodmVADkzYj7x6i4lZZJyFhVARVnHCxi
         nkoxVws2/cZjC35bA9MannuUg07xlkHJL8dxyO2sSXnKgbTxUJo2hMPKlWrPLSReJF
         SBWDu2XmgwmgpC6jTo/M8huASjh+i94Tkrm6ogOs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231006130038eucas1p1dc043e5c709b0fbb1ae19524081bc6b8~LhjMsMNFp3118331183eucas1p14;
        Fri,  6 Oct 2023 13:00:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.75.11320.6F400256; Fri,  6
        Oct 2023 14:00:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231006130038eucas1p1c849a21714227a11759681ef909ffd94~LhjMLY7He2199621996eucas1p1n;
        Fri,  6 Oct 2023 13:00:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231006130038eusmtrp1242bf59a026e8a36054e116e1a543efa~LhjMKyUEW3160731607eusmtrp1O;
        Fri,  6 Oct 2023 13:00:38 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-d1-652004f6acd6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.AA.25043.6F400256; Fri,  6
        Oct 2023 14:00:38 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006130037eusmtip24d6f4e51e43a7e697bb3db29e67a5d98~LhjLj-GO81292012920eusmtip2T;
        Fri,  6 Oct 2023 13:00:37 +0000 (GMT)
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
Subject: [PATCH 1/4] pinctrl: samsung: defer pinctrl_enable
Date:   Fri,  6 Oct 2023 14:55:54 +0200
Message-ID: <20231006125557.212681-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231006125557.212681-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7rfWBRSDSZtM7V4MG8bm8Xe11vZ
        Lab8Wc5ksenxNVaLzfP/MFpc3jWHzWLG+X1MFhOPTWa2WHvkLrvF4TftrBardv1hdOD22Dnr
        LrvHnWt72Dw2L6n36NuyitHj8ya5ANYoLpuU1JzMstQifbsEroybB26zF9zmrbjaOJm1gXEL
        dxcjJ4eEgInEihmfGLsYuTiEBFYwSlxetZQNwvnCKHFv0R12COczo8TGt5OYYFqur/kClVjO
        KDHzz0Uop5VJ4tHH5WwgVWwCBhIP3iwDS4gItDNK9Ny6BbaFWWAfk8TkjRdZQaqEBawlHs6/
        BTaXRUBV4vTdLWDdvAK2Eo8XdLFD7JOX2LPoO1gNp4CdRNPz7ywQNYISJ2c+AbOZgWqat85m
        BlkgIXCFQ+L1tUVQx7pITJ9+mhHCFpZ4dXwL1FAZidOTe1gg7HyJGZvfA9kcQHaFxN2DXhCm
        tcTHM8wgJrOApsT6XfoQxY4Spy99ZYOo4JO48VYQ4gA+iUnbpjNDhHklOtqEIKpVJY7vmcQM
        YUtLPGm5DXWWh8SNifeYJjAqzkLyyiwkr8xC2LuAkXkVo3hqaXFuemqxUV5quV5xYm5xaV66
        XnJ+7iZGYEI6/e/4lx2My1991DvEyMTBeIhRgoNZSYQ3vUEmVYg3JbGyKrUoP76oNCe1+BCj
        NAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoFJIvTdqQ+n78eckih5yLA0vDx6edf0Hm/x
        98JnZ/5fbJ5u78B5een74LwTywuEUk82ea+9/Vk5viVYZF6kWet0+frcmwuZ/jmsEfomuUR4
        fsF3eW+L3dMmt7U+2n1H//KbB8dCTmnkzYgz+ue+0WCelW1MYFLaNeHKxtT4d8xR78KPC3j8
        nrTZ3jhJ6tLX3jq7GI1r9nVlvfNiddQ3Fj1d9PBly1qNFi0DX5+1s5ui57+xbEnMZJxvrGZX
        /Wxj977CzFtbGe8eq7B/ED+J8/8H60MmGSs0+D/JW5471JNy/sakPZ/5J985bnFyupnBkbIT
        CquFa7f5uJnwMnW1z1v9x8DdSXSi+sPwHtdSjodKLMUZiYZazEXFiQD3OmDEtwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xe7rfWBRSDU7/EbF4MG8bm8Xe11vZ
        Lab8Wc5ksenxNVaLzfP/MFpc3jWHzWLG+X1MFhOPTWa2WHvkLrvF4TftrBardv1hdOD22Dnr
        LrvHnWt72Dw2L6n36NuyitHj8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2Pz
        WCsjUyV9O5uU1JzMstQifbsEvYybB26zF9zmrbjaOJm1gXELdxcjJ4eEgInE9TVf2LsYuTiE
        BJYySux+PZURIiEtcfjLFHYIW1jiz7UuNhBbSKCZSaKxzw3EZhMwkHjwZhlYjYhAN6PEt4lc
        IIOYBQ4wSSyZdRCsQVjAWuLh/FtMIDaLgKrE6btbwOK8ArYSjxd0QS2Ql9iz6DtYDaeAnUTT
        8+8sEMtsJQ7t2MMEUS8ocXLmE7A4M1B989bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYSK84
        Mbe4NC9dLzk/dxMjMHa2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuFNb5BJFeJNSaysSi3Kjy8q
        zUktPsRoCnT3RGYp0eR8YPTmlcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0
        MXFwSjUwyV9h3FC2+e8uoZ7M9rpTizdt7PWcusDbbIqLt9lkUZ0zwjVivxOCpe9n8pR41/TI
        Mh/k9HNi/F4p8Co1Vr5xrd9SjuC1B+W+Po3RWnQg4VTa74NRb0SvlbycEXGlI7NXrfxN3BLm
        RTMkDnp6Jr+KvLZ1qe2aDqlL+3lCbsydNVX+Wtm/205SVkwvC5cJ9tzuYag70x6srCHc0BUn
        neQqpC7ivXrB9l/lXC/Wsm6o/WJzNuyRfJWLOfv1B1Win83mrHV3mBxl2/G/69W0Rk0OJ0EB
        fsfDy6yXTrM3sFes8DqV7tq26bbYoncXJgWUFn574jjRcMMLrTe7ajTnxAkXzfQ0FnqRf/XH
        RH8X5jQlluKMREMt5qLiRABiEClaJgMAAA==
X-CMS-MailID: 20231006130038eucas1p1c849a21714227a11759681ef909ffd94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231006130038eucas1p1c849a21714227a11759681ef909ffd94
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231006130038eucas1p1c849a21714227a11759681ef909ffd94
References: <20231006125557.212681-1-m.majewski2@samsung.com>
        <CGME20231006130038eucas1p1c849a21714227a11759681ef909ffd94@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pinctrl_register function immediately enables the pinctrl subsystem,
which is unpreferable in general, since drivers might be unable to
handle calls immediately. Hence devm_pinctrl_register_and_init, which
does not call pinctrl_enable, is preferred.

In case of our driver using the old function does not seem to be
problematic for now, but will become an issue when we postpone parts of
pinctrl initialization in a future commit, and it is a good idea to move
off a deprecated-ish function anyway.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index e54847040b4a..e496af72a587 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -904,11 +904,11 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	drvdata->pctl_dev = devm_pinctrl_register(&pdev->dev, ctrldesc,
-						  drvdata);
-	if (IS_ERR(drvdata->pctl_dev)) {
+	ret = devm_pinctrl_register_and_init(&pdev->dev, ctrldesc, drvdata,
+					     &drvdata->pctl_dev);
+	if (ret) {
 		dev_err(&pdev->dev, "could not register pinctrl driver\n");
-		return PTR_ERR(drvdata->pctl_dev);
+		return ret;
 	}
 
 	for (bank = 0; bank < drvdata->nr_banks; ++bank) {
@@ -1176,6 +1176,10 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister;
 
+	ret = pinctrl_enable(drvdata->pctl_dev);
+	if (ret)
+		goto err_unregister;
+
 	platform_set_drvdata(pdev, drvdata);
 
 	return 0;
-- 
2.42.0

