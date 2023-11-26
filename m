Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495D47F91ED
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjKZJLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZJLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:11:22 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE41D3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:11:26 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231126091122epoutp0461562eea38e18a1ddb3d6f7184b9ba17~bIUk5p3mM3213732137epoutp046
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:11:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231126091122epoutp0461562eea38e18a1ddb3d6f7184b9ba17~bIUk5p3mM3213732137epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700989882;
        bh=GuiA2IISUqc9VQUQYIOqTFT2qSk66J6Ur4YwPXb8HcM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MSQhllYeRJo7jd27M/gySwJhzWbynt/2Uh5rohoIs2ZoUZPwRNmBdo2MB3tvUUNWM
         F2mCLCB2FcFt0ne+v6IYqMeIS3sIk0aWNprZSXYtShfwoCWA9kLT5XCa9fq+oG5ELO
         /r16Mdfe0Zpq5yvSpzZpSVVOtYwcp3cTiMLySipg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231126091121epcas2p182a52384ebd985e4fcbf017bd32fc0e2~bIUjuzWMo3013430134epcas2p1X;
        Sun, 26 Nov 2023 09:11:21 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SdNHs0PcHz4x9Pv; Sun, 26 Nov
        2023 09:11:21 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.B8.08648.8BB03656; Sun, 26 Nov 2023 18:11:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38~bIUjAro321687416874epcas2p4C;
        Sun, 26 Nov 2023 09:11:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231126091120epsmtrp18ea6c518276c3eff3ec6aca67af2397d~bIUi9YZCq0797007970epsmtrp1T;
        Sun, 26 Nov 2023 09:11:20 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-aa-65630bb896fa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.B7.08755.8BB03656; Sun, 26 Nov 2023 18:11:20 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231126091120epsmtip2230b13d97d9a43a23c54f80b96768f89~bIUiuNZfI1550915509epsmtip2q;
        Sun, 26 Nov 2023 09:11:20 +0000 (GMT)
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     tomasz.figa@gmail.com, krzysztof.kozlowski@linaro.org,
        s.nawrocki@samsung.com, alim.akhtar@samsung.com,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, semen.protsenko@linaro.org,
        Youngmin Nam <youngmin.nam@samsung.com>
Subject: [PATCH v2] pinctrl: samsung: add irq_set_affinity() for non wake up
 external gpio interrupt
Date:   Sun, 26 Nov 2023 18:46:18 +0900
Message-Id: <20231126094618.2545116-1-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmqe4O7uRUg8ZtFhYP5m1js9j7eiu7
        xZQ/y5ksNj2+xmqxef4fRovLu+awWcw4v4/J4vCbdlaL531A1qpdQInFBz6xO3B77Jx1l93j
        zrU9bB6bl9R79G1ZxejxeZNcAGtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
        kkJeYm6qrZKLT4CuW2YO0GVKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3i
        xNzi0rx0vbzUEitDAwMjU6DChOyMDeu+MBbcFqpYOusZawPjbr4uRk4OCQETifk/L7F0MXJx
        CAnsYJQ4cu8eO4TziVHi6sVWKOcbo8TWZfcYYVrWNz9khUjsZZRo+bEbLCEk8JVR4uC5cBCb
        TUBXYtuJf2BxEYE2RonOvQEgDcwC5xgl7vdMYAZJCAukSUz41sgGYrMIqErcvLGfFcTmFbCX
        +LX9IlCcA2ibvMTiBxIQYUGJkzOfsIDYzEDh5q2zmUFmSgi8ZZc4dauHBeI6F4mftw+xQ9jC
        Eq+Ob4GypSRe9rdB2dkSq39dgrIrJNrv9TBD2MYSs561M4LsZRbQlFi/Sx/iBGWJI7eg1vJJ
        dBz+yw4R5pXoaBOCaFST+DVlAzR4ZCR2L14BNdBD4tnkTeyQ0ImV+Px2NcsERvlZSJ6ZheSZ
        WQh7FzAyr2IUSy0ozk1PTTYqMITHaXJ+7iZGcNrUct7BeGX+P71DjEwcjIcYJTiYlUR4c//E
        pwrxpiRWVqUW5ccXleakFh9iNAWG7kRmKdHkfGDiziuJNzSxNDAxMzM0NzI1MFcS573XOjdF
        SCA9sSQ1OzW1ILUIpo+Jg1Oqgal7y//nt1zrj7h8XN+XbfJp/Z8WCcX/ne36OrNY91YnSlxK
        rYlxylU7nLf6YrPQDgvXRR/ib6ot2t3JP5NHO33pNfOwZSn+0+b1LL/Cb71WZwq/ryFzSkXF
        gidO7rlCzpov3apKM+e+DMvZvk2Zw6+hJyl49SyJtItX5I9MKI7+GbWhb5lkrIjFJQXzvzL3
        1Eo3sare/7H50a82i81eiz81bVe3mqpe4/ZrwdSvF2dyPa3akbPg+FrxkP0PbN5s0WBUXsxQ
        oJ2nn113jM/7y4Fg54LvRhv9DJ7XNahxu0XvurIl/fqOxtfhSxt1uB/ffrjJ8PbhqsjqlFen
        /kuZ9/CqG8R7JCyWdmU8uqxGWomlOCPRUIu5qDgRAFiBgq4kBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSvO4O7uRUg85rkhYP5m1js9j7eiu7
        xZQ/y5ksNj2+xmqxef4fRovLu+awWcw4v4/J4vCbdlaL531A1qpdQInFBz6xO3B77Jx1l93j
        zrU9bB6bl9R79G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8aGdV8YC24LVSyd9Yy1gXE3Xxcj
        J4eEgInE+uaHrF2MXBxCArsZJSbtfc8CkZCRuL3yMiuELSxxv+UIVNFnRon/a46BJdgEdCW2
        nfjHCJIQEehhlNj8agILiMMscIVRYsvipYwgVcICKRLnf5wEG8sioCpx88Z+sG5eAXuJX9sv
        snUxcgCtkJdY/EACIiwocXLmE7ByZqBw89bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PbfYsMAw
        L7Vcrzgxt7g0L10vOT93EyM4nLU0dzBuX/VB7xAjEwfjIUYJDmYlEd7cP/GpQrwpiZVVqUX5
        8UWlOanFhxilOViUxHnFX/SmCAmkJ5akZqemFqQWwWSZODilGpiWtmSu5J6/K+nH9e8/pae+
        flj58NDRbbc+F6eEzzKasqtye6Ti08i1W37PUepaYr9S/cjHL0HqEis5/lV7HL1xbKavY7FH
        U9T0KxcO/5mvddKy29vrQ8DPvPNvVZZNdXL7LHBLcu+knpp3qUz9qz3MJa2SfnTd3aHJuU7C
        ycnzf3MGg71K3uPTxh3Pv9rq2r8xuVghUCCivu7Kzonf5UTO7eff2F+q+6Jxl0Th1l2M5U+X
        T5IRrLH5uvNGG2/N3wfVq+8Wmh601g9aWe/2hf3z5Nr7Gnt7DHNevTl2x6wmPclNfsMZx20T
        frZO2v16Y+EUvqdWKzNfrfgR72C8RWN7eijXsg3yoqofK3rictMOKbEUZyQaajEXFScCAEKe
        zXzWAgAA
X-CMS-MailID: 20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38
References: <CGME20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support affinity setting for non wake up external gpio interrupt,
add irq_set_affinity callback using irq number from pinctrl driver data.

Before this patch, changing the irq affinity of gpio interrupt is not possible:

    # cat /proc/irq/418/smp_affinity
    3ff
    # echo 00f > /proc/irq/418/smp_affinity
    # cat /proc/irq/418/smp_affinity
    3ff
    # cat /proc/interrupts
               CPU0       CPU1       CPU2       CPU3    ...
    418:       3631          0          0          0    ...

With this patch applied, it's possible to change irq affinity of gpio interrupt:

    # cat /proc/irq/418/smp_affinity
    3ff
    # echo 00f > /proc/irq/418/smp_affinity
    # cat /proc/irq/418/smp_affinity
    00f
    # cat /proc/interrupts
               CPU0       CPU1       CPU2       CPU3      ...
    418:       3893        201        181        188      ...

Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 6b58ec84e34b..5d7b788282e9 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -147,6 +147,19 @@ static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
 	return 0;
 }
 
+static int exynos_irq_set_affinity(struct irq_data *irqd,
+				   const struct cpumask *dest, bool force)
+{
+	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
+	struct samsung_pinctrl_drv_data *d = bank->drvdata;
+	struct irq_data *parent = irq_get_irq_data(d->irq);
+
+	if (parent)
+		return parent->chip->irq_set_affinity(parent, dest, force);
+
+	return -EINVAL;
+}
+
 static int exynos_irq_request_resources(struct irq_data *irqd)
 {
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
@@ -212,6 +225,7 @@ static const struct exynos_irq_chip exynos_gpio_irq_chip __initconst = {
 		.irq_mask = exynos_irq_mask,
 		.irq_ack = exynos_irq_ack,
 		.irq_set_type = exynos_irq_set_type,
+		.irq_set_affinity = exynos_irq_set_affinity,
 		.irq_request_resources = exynos_irq_request_resources,
 		.irq_release_resources = exynos_irq_release_resources,
 	},
-- 
2.39.2

