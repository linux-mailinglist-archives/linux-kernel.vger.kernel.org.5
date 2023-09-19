Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2827A61EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjISMAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:00:05 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972F1E3;
        Tue, 19 Sep 2023 04:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=7Gt4TKjLSJcXOSLnXDaTB2+6o7ALKK+hltx0sbV1x1k=; b=pMDkiW9exbVAQG4r2+8jAeOpkh
        d20oAnv9G45lYOiYcJHFKl3l1Fs1RKNNNZ+5/iBHEnRWxhJtHEe7+uyx1sB6p4DldiJ2n8XAxXzg6
        37kVueDxjq/Wm8IsJxz5j36P8GM7E3vy7dIdMPIxNynUqi+YD8eLR8Ew3fiubq847I/2w7QlF9iqF
        KfluCoEnHsYdEpwNCHb1Im8+jEjodiSGnWy9yWBFLNIbh/HspBCqx/rAns+e3stYK1RySc2E9yXDb
        Rz1bNzn7d1hLHBZIjo9+zzfq8PQ+y8wqi9INOUY+fwd+ioKT7sww9r+driM5UN3MajdA3+3kXEcXx
        BsVbYx2w==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qiZOW-004b4T-28;
        Tue, 19 Sep 2023 13:59:56 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 19 Sep 2023 13:59:49 +0200
Subject: [PATCH v2 2/4] spi: qup: Parse OPP table for DVFS support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-spi-qup-dvfs-v2-2-1bac2e9ab8db@kernkonzept.com>
References: <20230919-spi-qup-dvfs-v2-0-1bac2e9ab8db@kernkonzept.com>
In-Reply-To: <20230919-spi-qup-dvfs-v2-0-1bac2e9ab8db@kernkonzept.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the OPP table from the device tree and use dev_pm_opp_set_rate()
instead of clk_set_rate() to allow making performance state for power
domains specified in the OPP table.

This is needed to guarantee correct behavior of the clock, especially
with the higher clock/SPI bus frequencies.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/spi/spi-qup.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 4b6f6b25219b..bf043be3a2a9 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 #include <linux/dmaengine.h>
@@ -667,7 +668,7 @@ static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 		return -EIO;
 	}
 
-	ret = clk_set_rate(controller->cclk, xfer->speed_hz);
+	ret = dev_pm_opp_set_rate(controller->dev, xfer->speed_hz);
 	if (ret) {
 		dev_err(controller->dev, "fail to set frequency %d",
 			xfer->speed_hz);
@@ -1027,6 +1028,15 @@ static int spi_qup_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	ret = devm_pm_opp_set_clkname(dev, "core");
+	if (ret)
+		return ret;
+
+	/* OPP table is optional */
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "invalid OPP table\n");
+
 	host = spi_alloc_host(dev, sizeof(struct spi_qup));
 	if (!host) {
 		dev_err(dev, "cannot allocate host\n");

-- 
2.39.2

