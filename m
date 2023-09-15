Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3147A7A1F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjIOMqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjIOMqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:46:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D02D51;
        Fri, 15 Sep 2023 05:46:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FCjtxX024939;
        Fri, 15 Sep 2023 07:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694781955;
        bh=BRW8EyUjjI/j4vI+qIaQK8OauJ8jbUUuCaWiIex1n10=;
        h=From:To:CC:Subject:Date;
        b=bb2fptpeTtxGKySsY07ibStDdulLhF4a78Hc1m2NH7IR2YBxwcn0FOGzUgmyOQwdW
         4AFHTApmAKgx+wyOfJNMEmtfqEER5ltNeGGi9GVC6ZoYdSXWbjAI+BPPa/LbP4ofVu
         hM5CJ75xWpRHeNbzrSmQfJ6eQKo0JgXKjvWBlb/Q=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FCjtRp100203
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Sep 2023 07:45:55 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 07:45:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 07:45:55 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FCjqOc016962;
        Fri, 15 Sep 2023 07:45:52 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhruva Gole <d-gole@ti.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] spi: spi-cadence-quadspi: Fix missing unwind goto warnings
Date:   Fri, 15 Sep 2023 18:01:04 +0530
Message-ID: <20230915123103.2493640-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the smatch warnings that were recently introduced in the runtime pm
patch [0]:
drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
unwind goto?

[0] https://lore.kernel.org/all/20230829062706.786637-1-d-gole@ti.com/

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309140543.03dMbMM5-lkp@intel.com/
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Link: https://lore.kernel.org/r/20230915123103.2493640-1-d-gole@ti.com

Tested locally using the following cmd:
make -j32 ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu- drivers/spi/spi-cadence-quadspi.o CHECK="smatch -p=kernel" C=1 W=1

 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 4828da4587c5..e04f257c1067 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1879,7 +1879,7 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
-		return ret;
+		goto probe_setup_failed;
 
 	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
-- 
2.34.1

