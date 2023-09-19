Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3B7A5CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjISIes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjISIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:34:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA711A;
        Tue, 19 Sep 2023 01:34:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7EEC433C8;
        Tue, 19 Sep 2023 08:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695112467;
        bh=Gd2j5BZkeceRCAPRB3Ed88hy2OH7X0D2yLIWo8KBQt4=;
        h=From:To:Cc:Subject:Date:From;
        b=uqPF0RdFSUuPHVS9uiiuFZK/NONs5bMVKha5RE3q0SLUU0w+qAvrDIqMjUqQmdzL8
         ar/7hr5tE7F5RNzFvjqx6ZOR7L/5gylxJ0cfFf3Q6G80TxwfRUtxdK4l3EINQ46+Qx
         ykMh6tdZLaO+7192I177MDjhLtRLRVHG7TzZwV1G62tRsii/GzaeNhjPSfnobNIGGR
         nihUFbhJTPDE8cwus1Y+9hAXGbdBngDLPA96rsZCF/OfxyZvWe+8FK1MQUNVNRO0p9
         nOxm2ywFG4b8rCaotz49XsGAs+b1EoeOHErYMvbFRAsxLqMJ5pw125LEnRdzIN69am
         a0hvgybCE0j5g==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qiWBs-0006tO-2x;
        Tue, 19 Sep 2023 10:34:40 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH RESEND] spi: zynqmp-gqspi: fix clock imbalance on probe failure
Date:   Tue, 19 Sep 2023 10:34:01 +0200
Message-ID: <20230919083401.26454-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the device is not runtime suspended before explicitly
disabling the clocks on probe failure and on driver unbind to avoid a
clock enable-count imbalance.

Fixes: 9e3a000362ae ("spi: zynqmp: Add pm runtime support")
Cc: stable@vger.kernel.org	# 4.19
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Hi Mark,

This patch ended up sitting in your for-next and for-6.4 branches for a
few releases but was never sent on to Linus as I reported here:

	https://lore.kernel.org/lkml/ZOy0l6sXyYib59ej@finisterre.sirena.org.uk/

Now it appears to have been dropped from linux-next so resending.

Johan


 drivers/spi/spi-zynqmp-gqspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 94d9a33d9af5..9a46b2478f4e 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1340,9 +1340,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 clk_dis_all:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
@@ -1366,11 +1366,15 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
 {
 	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 }
 
 MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
-- 
2.41.0

