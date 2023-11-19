Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F37F04DD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 09:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjKSIyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 03:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 03:54:53 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC0BE5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 00:54:48 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231119085443epoutp022f23a6f1f3616becbe28c2b1aa5218b6~Y_lCm_Vvm2602726027epoutp02R
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 08:54:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231119085443epoutp022f23a6f1f3616becbe28c2b1aa5218b6~Y_lCm_Vvm2602726027epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700384083;
        bh=aUl24Gac6V4qeYPQFo9QasuwMm4N5iU9VP5YIzb5kFs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sCuuYSSydd5RKckJ43Qr6SeMmEBAD4LV1ReXNhDZMAPdyE5GABAxJLsDA8mBvbPiU
         nXJ9sj8M71m2MM5FLozUfza57FtBjiGW2xAN9wLwh2pqnNj+Tkx8DsOTdTt007AzGU
         YASC24rqoBy+4IJTV3jF8LwadXitnnaMfvOqcwjI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231119085442epcas2p370350440fbfcf488feb10a8e309a2ac4~Y_lBUYAx71040310403epcas2p3y;
        Sun, 19 Nov 2023 08:54:42 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SY4Fs6ncwz4x9Pp; Sun, 19 Nov
        2023 08:54:41 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.9C.10022.15DC9556; Sun, 19 Nov 2023 17:54:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231119085440epcas2p375fa3b2999e1a3ceeff9949136db7e28~Y_k-zOBqs1033410334epcas2p35;
        Sun, 19 Nov 2023 08:54:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231119085440epsmtrp1dbac461351964514c6477a126c1ee07d~Y_k-yeKgU2939629396epsmtrp1h;
        Sun, 19 Nov 2023 08:54:40 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-ba-6559cd5151cd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.0A.18939.05DC9556; Sun, 19 Nov 2023 17:54:40 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231119085440epsmtip2c458c7eef622a9fabea8b8d2e7842d12~Y_k-kPdsJ3102631026epsmtip2t;
        Sun, 19 Nov 2023 08:54:40 +0000 (GMT)
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     tomasz.figa@gmail.com, krzysztof.kozlowski@linaro.org,
        s.nawrocki@samsung.com, alim.akhtar@samsung.com,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, semen.protsenko@linaro.org,
        Youngmin Nam <youngmin.nam@samsung.com>
Subject: [PATCH] pinctrl: samsung: add irq_set_affinity() for non wake up
 external gpio interrupt
Date:   Sun, 19 Nov 2023 18:29:09 +0900
Message-Id: <20231119092909.3018578-1-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTXDfwbGSqwbvXBhYP5m1js9j7eiu7
        xZQ/y5ksNj2+xmqxef4fRovLu+awWcw4v4/J4vCbdlaL531A1qpdQInFBz6xO3B77Jx1l93j
        zrU9bB6bl9R79G1ZxejxeZNcAGtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
        kkJeYm6qrZKLT4CuW2YO0GVKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3i
        xNzi0rx0vbzUEitDAwMjU6DChOyM978yC2aJVnTsOc3awHidv4uRk0NCwETiSssixi5GLg4h
        gR2MEgumHmCDcD4xSizafZEFzln75TlQhgOs5fNmc5BuIYGdjBKvvwpB1HxllFg84yATSIJN
        QFdi24l/jCC2iEAbo0Tn3gCQImaBc4wS93smMIMkhAWSJT7cf8ECMpRFQFXiwZdskDCvgL3E
        9pdPWSF2yUssfiABERaUODnzCQuIzQwUbt46mxlkpITAI3aJjp+LWCDecZE4PPcQE4QtLPHq
        +BZ2CFtK4mV/G5SdLbH61yUou0Ki/V4PM4RtLDHrWTsjyF5mAU2J9bv0IU5QljhyC2otn0TH
        4b/sEGFeiY42IYhGNYlfUzYwQtgyErsXr4Aa6CHx6PAGdkhIxUpsWnWQdQKj/Cwkz8xC8sws
        hL0LGJlXMYqlFhTnpqcWGxUYwyM0OT93EyM4YWq572Cc8faD3iFGJg7GQ4wSHMxKIrzfhCJS
        hXhTEiurUovy44tKc1KLDzGaAgN3IrOUaHI+MGXnlcQbmlgamJiZGZobmRqYK4nz3mudmyIk
        kJ5YkpqdmlqQWgTTx8TBKdXAVOs5d5VEaYXAEf3z69umi015cPTiv5Q7zpnc1/sEtq1oFDTa
        7XlQeKJY0o1bJUdj/sQt1y6t/BCS9InB83R7GQv7Ebf1urUOdiuUJBdFfu7sMJS5LaZSkHj+
        N+P5n3trzIMPOxnmZEe8s2PS9I6offKmUe3Ok7faGyyvfqiq3Oea4XxsdxDn++mlUa0r6m78
        7Fmxg+0ro0NFrlBJTaFpOWfkJk0BSRP22/pv/U8cWTZXx2LxhUMNq1VuH4iRSe96/u9cd7jr
        F82b4TKPTXrC1r8Q4U3xU26/oLnFZlWjw+qlXp5WjXttZntevT79bLDkGm9GiV+Tbx89WisX
        FqM44+fF6Sy749UUP5aq2QcosRRnJBpqMRcVJwIA+8ribyEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvG7A2chUg/57MhYP5m1js9j7eiu7
        xZQ/y5ksNj2+xmqxef4fRovLu+awWcw4v4/J4vCbdlaL531A1qpdQInFBz6xO3B77Jx1l93j
        zrU9bB6bl9R79G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8b7X5kFs0QrOvacZm1gvM7fxcjB
        ISFgIvF5s3kXIxeHkMB2RonDvy6xdjFyAsVlJG6vvAxlC0vcbznCClH0mVHi0uNNTCAJNgFd
        iW0n/jGCJEQEehglNr+awALiMAtcYZTYsngpI0iVsECixOst+9lA1rEIqEo8+JINEuYVsJfY
        /vIpK8QV8hKLH0hAhAUlTs58wgJiMwOFm7fOZp7AyDcLSWoWktQCRqZVjKKpBcW56bnJBYZ6
        xYm5xaV56XrJ+bmbGMEBrBW0g3HZ+r96hxiZOBgPMUpwMCuJ8H4TikgV4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRqYHK/zZ0QoCr89msDU7bvO41PZY9N
        yxRZ+1LObLNYsKJ9+7XDGk+YjLbGfy4prNGa8/hU+/Gmv0GNue+j/py9bVW8KI1dbOH3lp/3
        Mg9eCNaX5durMvHLzRrniEingiuKjHVJD7UDV1TxqnQUvDIp+s9U4F59mOePfknwTMZ1DOKZ
        V5YLvrDNkDrcdUNe2ZSZ53erXvMjyd/PfTLr7qX/b5j8WqRwy83cyV1bxRVPRvDN3XRjY8kr
        b9a9E6xaFNImXuW8o9S9vj3hf+gzsRt9F5Zb/4t9z+iRnHQh8ZzVn7SlxoeV5HRCPlrwzP3d
        6MQT4e16ZKVJQOwThp0ajOfYrzjO/fwlsJ7BhOndBv8wJZbijERDLeai4kQAcY1Q7M8CAAA=
X-CMS-MailID: 20231119085440epcas2p375fa3b2999e1a3ceeff9949136db7e28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231119085440epcas2p375fa3b2999e1a3ceeff9949136db7e28
References: <CGME20231119085440epcas2p375fa3b2999e1a3ceeff9949136db7e28@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support affinity setting for non wake up external gpio interrupt,
we add a new irq_set_affinity callback using irq number which is in pinctrl
driver data.

Before applying this patch, we couldn't change irq affinity of gpio interrupt.
* before
erd9945:/proc/irq/418 # cat smp_affinity
3ff
erd9945:/proc/irq/418 # echo 00f > smp_affinity
erd9945:/proc/irq/418 # cat smp_affinity
3ff
erd9945:/proc/irq/418 # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9
418:       3631          0          0          0          0          0          0          0          0          0      gpg2   0 Edge      19100000.drmdecon

After applying this patch, we can change irq affinity of gpio interrupt as below.
* after
erd9945:/proc/irq/418 # cat smp_affinity
3ff
erd9945:/proc/irq/418 # echo 00f > smp_affinity
erd9945:/proc/irq/418 # cat smp_affinity
00f
erd9945:/proc/irq/418 # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9
418:       3893        201        181        188          0          0          0          0          0          0      gpg2   0 Edge      19100000.drmdecon

Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
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

