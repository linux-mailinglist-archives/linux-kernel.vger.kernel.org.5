Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D377AEDC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjIZNLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjIZNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:11:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7889C127;
        Tue, 26 Sep 2023 06:11:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QDBNcp105109;
        Tue, 26 Sep 2023 08:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695733883;
        bh=ebZF1O13WAp+405gFWGsAvB8HlRo5Q6+vLZ6sLpiBy8=;
        h=From:To:CC:Subject:Date;
        b=XgmKW3nUUT3Ksyh2yvr0R17cxyCHthrF5yMZMdYrfxqsYcjB9plVHPwxkLDDGiuyK
         QNteaAG5UqGtYL+ob3CiacZPvdWw2C7x8aMAINXRH087gxFF+hmQXT+NF1gkn8Xm4F
         1ysLacnldGAWH85WfQwid800CsR8RKA4Mo+e3UEU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QDBNfe014547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 08:11:23 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 08:11:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 08:11:21 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QDBJQk092098;
        Tue, 26 Sep 2023 08:11:19 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhruva Gole <d-gole@ti.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH V3] spi: spi-cadence-quadspi: Fix missing unwind goto warnings
Date:   Tue, 26 Sep 2023 18:39:27 +0530
Message-ID: <20230926130926.314751-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following smatch warnings were recently introduced:

drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
unwind goto?

Fix these warnings by releasing dma channel and adding a goto fail probe.

Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/5e21c351-cd08-443e-8509-aecf242a4da9@kadam.mountain/
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

*NOTE:* Please base on top of origin: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
branch: for-next

Link to v2:
https://lore.kernel.org/r/20230919074658.41666-1-d-gole@ti.com

Link to V1:
https://lore.kernel.org/all/20230915123103.2493640-1-d-gole@ti.com/

Changelog in v3:
* Rebased and removed mixing of links from commit message

Changelog in v2:
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

base-commit: b643e6268c8f466ebb08a594b8ec8a1e2fd275a2
-- 
2.34.1

