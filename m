Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA157AD96D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjIYNoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjIYNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:44:45 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4036CB3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1695649476; x=1698241476;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=28PpxXcCjpk33cV4lxB4KctRi94rZLugQvUovFs5/Zg=;
        b=RZdzW+L50N9vktvglf7SBGehYNm1n+MOPrad16TEKaDVISlVbmLlUlsIjd2RL6mn
        ozwb60qknI0kQRSAfXuCgayeHfw5Kr0y47qDrdoW2ArG9B8UaTqRZqZIgksEZxoh
        mjLkNgkGVrWiyFzJRtdC62uzCDNoM7w8qeasmJbnCFE=;
X-AuditID: ac14000a-6d65670000001e37-4d-65118ec4a100
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id FB.51.07735.4CE81156; Mon, 25 Sep 2023 15:44:36 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 25 Sep
 2023 15:44:36 +0200
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
        <heiko@sntech.de>, <peter.ujfalusi@ti.com>, <mugunthanvnm@ti.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <upstream@lists.phytec.de>
Subject: [PATCH v2] iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()
Date:   Mon, 25 Sep 2023 15:44:27 +0200
Message-ID: <20230925134427.214556-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWyRpKBR/dIn2Cqwd1LfBb/H71mtXjQtIrJ
        Ysnk+awW8468Y7G4vGsOm8XVB+UWb36cZbKY9fEHq8X/PTvYLbrfqTtweWxa1cnm0d/dwuqx
        5M0hVo/t1+Yxexy/sZ3J4/MmuQC2KC6blNSczLLUIn27BK6MRe/kC25wVjx79YG1gfE3excj
        J4eEgInEg5bTzF2MXBxCAkuYJG4u7mCEcJ4wSiyd+4UJpIpNQF3izoZvrCC2iEAjo8Td22Dd
        zAJZEju2nmIEsYUFoiQmbroNVs8ioCpx/MoZFhCbV8BCYtWGm6wQ2+QlZl76zg4RF5Q4OfMJ
        C8QceYnmrbOZIWwJiYMvXoDZQkDxF5eWs8D0Tjv3mhnCDpXY+mU70wRGgVlIRs1CMmoWklEL
        GJlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgTFgAgD1w7GvjkehxiZOBgPMUpwMCuJ8P56xpcq
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPd+D1OikEB6YklqdmpqQWoRTJaJg1OqgbGbzevf1/Bv
        2V/lHBZMMbBf9ddUrSmkPe6YVJXRjE1cZ9bkzJxz4H7I1ytn/vkxpezpq1ngJi5zcs0eBucC
        hamLQ5a4tu44dYJjZ5gQq0O5VfZXma8dW3m4D7vdeKVUy7nR5f62pk/K0+6b3ZW5UuueuU1u
        gmSE1TNmx4V6VqIymXY6KrsmcCixFGckGmoxFxUnAgDtYSE7bwIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix wrong handling of a DMA request where the probing only failed
if -EPROPE_DEFER was returned. Instead, let us fail if a non -ENODEV
value is returned. This makes DMAs explicitly optional. Even if the
DMA request is unsuccessfully, the ADC can still work properly.
We do also handle the defer probe case by making use of dev_err_probe().

Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v2:
  - Update description
  - Drop line break after Fixes tag
  - Move decision about optional DMA into probe/caller
---
 drivers/iio/adc/ti_am335x_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 8db7a01cb5fb..5f8795986995 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -670,8 +670,10 @@ static int tiadc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 
 	err = tiadc_request_dma(pdev, adc_dev);
-	if (err && err == -EPROBE_DEFER)
+	if (err && err != -ENODEV) {
+		dev_err_probe(&pdev->dev, err, "DMA request failed\n");
 		goto err_dma;
+	}
 
 	return 0;
 
-- 
2.34.1

