Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97BE7A0378
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbjINMNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjINMNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:13:16 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFC71FC0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1694693589; x=1697285589;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s3tNlvvUmtI8ptMGyvvsPrGgLl/WPnVCwK8f76krFqY=;
        b=bbmq2LS4zDUab/IAhQWcG6misYXXjdTYHQ9KbY866Kral3cZFU00btdPcNXuHRdY
        Bre+ga0ZSbi+P3675V8EpulNsnMk9GfbUTs0P4IWV7l5rw4Ubr/1qvK/w9J5RkVb
        0sd1gmdQ9u5cpk2O8YgVXQDnpLS/eTmhSwjsKy4sB9Q=;
X-AuditID: ac14000a-6e25770000001e37-a5-6502f8d47b91
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 8D.75.07735.4D8F2056; Thu, 14 Sep 2023 14:13:09 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 14 Sep
 2023 14:13:08 +0200
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
        <heiko@sntech.de>, <mugunthanvnm@ti.com>, <peter.ujfalusi@ti.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>, <nm@ti.com>
Subject: [PATCH] iio: adc: ti_am335x_adc: Make DMAs optional
Date:   Thu, 14 Sep 2023 14:13:00 +0200
Message-ID: <20230914121300.845493-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWyRpKBR/fqD6ZUgz49i/+PXrNaPGhaxWSx
        ZPJ8Vot5R96xWFzeNYfN4uqDcos3P84yWcz6+IPV4v+eHewW3e/UHbg8Nq3qZPPo725h9Vjy
        5hCrx/Zr85g9jt/YzuTxeZNcAFsUl01Kak5mWWqRvl0CV8aTLYcYC05wVVydHdfAeJKji5GT
        Q0LAROJfzxPWLkYuDiGBJUwSredPsEE4Txgldl2fxwRSxSagLnFnwzewKhGBRkaJC5umM4Ik
        mAWyJI6tPgBmCwvYSEzctwPMZhFQlfjUd44VxOYVsJBYceI+C8Q6eYmZl76zQ8QFJU7OfMIC
        MUdeonnrbGYIW0Li4IsXYLYQUPzFpeVwvdPOvWaGsEMltn7ZzjSBUWAWklGzkIyahWTUAkbm
        VYxCuZnJ2alFmdl6BRmVJanJeimpmxhBMSDCwLWDsW+OxyFGJg7GQ4wSHMxKIrxstkypQrwp
        iZVVqUX58UWlOanFhxilOViUxHnv9zAlCgmkJ5akZqemFqQWwWSZODilGhinbmT0TdrOUBZz
        cb3kzuos/iUm9gvnTDpR0RW0uGwO3xlvhYSpYSc0XoUd4mt+/23xcyXZc7dc8gS/bXGevmlG
        8968nYEPVveZJWXk2oa5aGy6EW0isnQ2p7yL8JWFzU8zvbN7aubGKqT43azguXzu9hq/fYvO
        pV5dUDdb21FdaufWlEadDRJKLMUZiYZazEXFiQAEjkT+bwIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMAs are optional. Even if the DMA request is unsuccessfully,
the ADC can still work properly.
Make tiadc_request_dma() not fail if we do not provide dmas &
dma-names properties.

This actually fixes the wrong error handling of the tiadc_request_dma()
result where the probing only failed if -EPROPE_DEFER was returned.

Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/iio/adc/ti_am335x_adc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 8db7a01cb5fb..e14aa9254ab1 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -543,8 +543,11 @@ static int tiadc_request_dma(struct platform_device *pdev,
 	if (IS_ERR(dma->chan)) {
 		int ret = PTR_ERR(dma->chan);
 
+		if (ret != -ENODEV)
+			return dev_err_probe(&pdev->dev, ret,
+					     "RX DMA channel request failed\n");
 		dma->chan = NULL;
-		return ret;
+		return 0;
 	}
 
 	/* RX buffer */
@@ -670,7 +673,7 @@ static int tiadc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 
 	err = tiadc_request_dma(pdev, adc_dev);
-	if (err && err == -EPROBE_DEFER)
+	if (err)
 		goto err_dma;
 
 	return 0;
-- 
2.25.1

