Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471C87A5B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjISHvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjISHvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:51:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CEB10F;
        Tue, 19 Sep 2023 00:51:15 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J7p8tc095988;
        Tue, 19 Sep 2023 02:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695109868;
        bh=91XuODQwmCtWYnSSTBcS0qNvMDSn/h7K7GVyq9zfEiU=;
        h=From:To:CC:Subject:Date;
        b=qzW3RWcW3FjrPcM1BJydKl9zeSQ/ogpyni2zDGyhsk6wweqPQPTYI8k8wkN6a4dlo
         SQDG6c2LNVMjfkyIQds0gTSrkTOw1j1vnptliYROq+LjLcWDoZ5bFjU9rQ/SlXfWzK
         0/eL4v4zuwGhfjzNeY3oA9wTO2BdL/bDaQ24SrVc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J7p8rU127667
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 02:51:08 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 02:51:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 02:51:07 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J7p5Sg116649;
        Tue, 19 Sep 2023 02:51:06 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhruva Gole <d-gole@ti.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH V2] spi: spi-cadence-quadspi: Fix missing unwind goto warnings
Date:   Tue, 19 Sep 2023 13:16:59 +0530
Message-ID: <20230919074658.41666-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following smatch warnings [0] were recently introduced:

drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
unwind goto?

Fix these warnings by releasing dma channel and adding a goto fail probe.

[0] https://lore.kernel.org/all/5e21c351-cd08-443e-8509-aecf242a4da9@kadam.mountain/

Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309140543.03dMbMM5-lkp@intel.com/
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Link to V1:
https://lore.kernel.org/all/20230915123103.2493640-1-d-gole@ti.com/

Changelog:
* added dma_release_channel
* added a fixes tag.

 drivers/spi/spi-cadence-quadspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 4828da4587c5..3d7bf62da11c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1878,8 +1878,11 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_pm_runtime_enable(dev);
-	if (ret)
-		return ret;
+	if (ret) {
+		if (cqspi->rx_chan)
+			dma_release_channel(cqspi->rx_chan);
+		goto probe_setup_failed;
+	}
 
 	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);

base-commit: 21f252cd29f08892d48739fd7513ad79c1cff96a
-- 
2.34.1

