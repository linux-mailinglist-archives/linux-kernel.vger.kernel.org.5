Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB89C780A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376397AbjHRKjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359754AbjHRKjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:39:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4412C;
        Fri, 18 Aug 2023 03:39:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37IAcv6o001606;
        Fri, 18 Aug 2023 05:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692355137;
        bh=bhiTI+o1ui9xfbiWkP/wF1u+vUAqkUzyNne6IpUTyBI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Nb9xsZAw8KSpAs0hB12Ra5AWKN1cSvscDA+y1VGovZFquWJpytHBxyWsdkK/+ygVe
         ROcT2tzLYOHyfudH5726uVmH4MslZH4LOlydl5GIZWUjWDuaqM6wQVltbaNe4VvKSX
         gJVPuWm3LsSuDTX/ePyMnU/i6gUdPQsPKk6o3qcg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37IAcvxQ057294
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Aug 2023 05:38:57 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Aug 2023 05:38:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Aug 2023 05:38:57 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37IAcZ5b001102;
        Fri, 18 Aug 2023 05:38:53 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        William Qiu <william.qiu@starfivetech.com>,
        Brad Larson <blarson@amd.com>,
        Pratyush Yadav <ptyadav@amazon.de>
Subject: [RFT/PATCH 2/2] spi: spi-cadence-quadspi: add runtime pm support
Date:   Fri, 18 Aug 2023 16:07:50 +0530
Message-ID: <20230818103750.516309-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818103750.516309-1-d-gole@ti.com>
References: <20230818103750.516309-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime pm support to cadence-qspi driver, this allows the driver to
suspend whenever it's is not actively being used thus reducing active
power consumed by the system.

Also, with the use of devm_pm_runtime_enable we no longer need the
fallback probe_pm_failed that used to pm_runtime_disable

Co-developed-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Cc: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: William Qiu <william.qiu@starfivetech.com>
Cc: Brad Larson <blarson@amd.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>

 drivers/spi/spi-cadence-quadspi.c | 38 +++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b50db71ac4cc..8b6c2822037e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -116,6 +116,9 @@ struct cqspi_driver_platdata {
 #define CQSPI_TIMEOUT_MS			500
 #define CQSPI_READ_TIMEOUT_MS			10
 
+/* Runtime_pm autosuspend delay */
+#define CQSPI_AUTOSUSPEND_TIMEOUT		2000
+
 #define CQSPI_DUMMY_CLKS_PER_BYTE		8
 #define CQSPI_DUMMY_BYTES_MAX			4
 #define CQSPI_DUMMY_CLKS_MAX			31
@@ -1407,8 +1410,16 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	int ret;
+	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	struct device *dev = &cqspi->pdev->dev;
+
+	pm_runtime_resume_and_get(dev);
 
 	ret = cqspi_mem_process(mem, op);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
@@ -1753,10 +1764,10 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENXIO;
 
-	pm_runtime_enable(dev);
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
-		goto probe_pm_failed;
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+
 
 	ret = clk_prepare_enable(cqspi->clk);
 	if (ret) {
@@ -1862,21 +1873,29 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_get_noresume(dev);
+
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
 		goto probe_setup_failed;
 	}
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
 probe_reset_failed:
 	clk_disable_unprepare(cqspi->clk);
 probe_clk_failed:
-	pm_runtime_put_sync(dev);
-probe_pm_failed:
-	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -1928,7 +1947,8 @@ static int cqspi_resume(struct device *dev)
 	return spi_controller_resume(host);
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend, cqspi_resume);
+static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend,
+				 cqspi_resume, NULL);
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
@@ -2012,7 +2032,7 @@ static struct platform_driver cqspi_platform_driver = {
 	.remove_new = cqspi_remove,
 	.driver = {
 		.name = CQSPI_NAME,
-		.pm = &cqspi_dev_pm_ops,
+		.pm = pm_ptr(&cqspi_dev_pm_ops),
 		.of_match_table = cqspi_dt_ids,
 	},
 };
-- 
2.34.1

