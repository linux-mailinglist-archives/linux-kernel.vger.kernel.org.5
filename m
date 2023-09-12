Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340C079D3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjILObH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjILOa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:30:59 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC88FCC7;
        Tue, 12 Sep 2023 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=d8aTXSfXKUiK1Xyz5/399gXFzKYpAJm1Z7s+7n6AgiA=; b=VW2OT9MEsssDRMkwh3Uc/UV/sU
        ZvJI7PAAq82QQLTuNMbZ4JB2NvSLaDDhCPziIIIXjoZuw5Si5G7cBoMsE6xSHv21w48NpUQnK+0aS
        xlAPsANfObrC1zT09ttft7W+z3JCpckVRiUodnA48hUGcsuU5GRfWlotgo1sSQ/yewjwa4Ld/fYdl
        nImSY9IBb27xYyDp8bkpdUjxhq30ecnHdGpf0m7nyf5FLHMUCl0mrXQXGHsMEw7GBj54hLCAAKRa7
        hNAcKfTXX6fvIWrmTWQ9wqC2+4JOJBdElsYVcng7iofUJJ6jJIG88oT9CmsDCrBpjht7ereCuItgF
        jxnItlew==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qg4Pk-0034i9-1z;
        Tue, 12 Sep 2023 16:30:52 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 12 Sep 2023 16:30:39 +0200
Subject: [PATCH 4/4] spi: qup: Vote for interconnect bandwidth to DRAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-spi-qup-dvfs-v1-4-3e38aa09c2bd@kernkonzept.com>
References: <20230912-spi-qup-dvfs-v1-0-3e38aa09c2bd@kernkonzept.com>
In-Reply-To: <20230912-spi-qup-dvfs-v1-0-3e38aa09c2bd@kernkonzept.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the SPI QUP controller is used together with a DMA engine it needs
to vote for the interconnect path to the DRAM. Otherwise it may be
unable to access the memory quickly enough.

The requested peak bandwidth is dependent on the SPI core/bus clock so
that the bandwidth scales together with the selected SPI speed.

To avoid sending votes too often the bandwidth is always requested when
a transfer starts, but dropped only on runtime suspend. Runtime suspend
should only happen if no transfer is active. After resumption we can
defer the next vote until the first transfer actually happens.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
The bandwidth calculation is taken over from Qualcomm's
downstream/vendor driver [1]. Due to lack of documentation about the
interconnect setup/behavior I cannot say exactly if this is right.
Unfortunately, this is not implemented very consistently downstream...

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/deca0f346089d32941d6d8194ae9605554486413
---
 drivers/spi/spi-qup.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index bf043be3a2a9..e9c186bc530c 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -6,6 +6,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/list.h>
@@ -122,11 +123,14 @@
 #define SPI_DELAY_THRESHOLD		1
 #define SPI_DELAY_RETRY			10
 
+#define SPI_BUS_WIDTH			8
+
 struct spi_qup {
 	void __iomem		*base;
 	struct device		*dev;
 	struct clk		*cclk;	/* core clock */
 	struct clk		*iclk;	/* interface clock */
+	struct icc_path		*icc_path; /* interconnect to RAM */
 	int			irq;
 	spinlock_t		lock;
 
@@ -149,6 +153,8 @@ struct spi_qup {
 	int			mode;
 	struct dma_slave_config	rx_conf;
 	struct dma_slave_config	tx_conf;
+
+	u32			bw_speed_hz;
 };
 
 static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer);
@@ -181,6 +187,23 @@ static inline bool spi_qup_is_valid_state(struct spi_qup *controller)
 	return opstate & QUP_STATE_VALID;
 }
 
+static int spi_qup_vote_bw(struct spi_qup *controller, u32 speed_hz)
+{
+	u32 needed_peak_bw;
+	int ret;
+
+	if (controller->bw_speed_hz == speed_hz)
+		return 0;
+
+	needed_peak_bw = Bps_to_icc(speed_hz * SPI_BUS_WIDTH);
+	ret = icc_set_bw(controller->icc_path, 0, needed_peak_bw);
+	if (ret)
+		return ret;
+
+	controller->bw_speed_hz = speed_hz;
+	return 0;
+}
+
 static int spi_qup_set_state(struct spi_qup *controller, u32 state)
 {
 	unsigned long loop;
@@ -675,6 +698,12 @@ static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 		return -EIO;
 	}
 
+	ret = spi_qup_vote_bw(controller, xfer->speed_hz);
+	if (ret) {
+		dev_err(controller->dev, "fail to vote for ICC bandwidth: %d\n", ret);
+		return -EIO;
+	}
+
 	controller->w_size = DIV_ROUND_UP(xfer->bits_per_word, 8);
 	controller->n_words = xfer->len / controller->w_size;
 
@@ -994,6 +1023,7 @@ static void spi_qup_set_cs(struct spi_device *spi, bool val)
 static int spi_qup_probe(struct platform_device *pdev)
 {
 	struct spi_controller *host;
+	struct icc_path *icc_path;
 	struct clk *iclk, *cclk;
 	struct spi_qup *controller;
 	struct resource *res;
@@ -1019,6 +1049,11 @@ static int spi_qup_probe(struct platform_device *pdev)
 	if (IS_ERR(iclk))
 		return PTR_ERR(iclk);
 
+	icc_path = devm_of_icc_get(dev, NULL);
+	if (IS_ERR(icc_path))
+		return dev_err_probe(dev, PTR_ERR(icc_path),
+				     "failed to get interconnect path\n");
+
 	/* This is optional parameter */
 	if (of_property_read_u32(dev->of_node, "spi-max-frequency", &max_freq))
 		max_freq = SPI_MAX_RATE;
@@ -1070,6 +1105,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	controller->base = base;
 	controller->iclk = iclk;
 	controller->cclk = cclk;
+	controller->icc_path = icc_path;
 	controller->irq = irq;
 
 	ret = spi_qup_init_dma(host, res->start);
@@ -1190,6 +1226,7 @@ static int spi_qup_pm_suspend_runtime(struct device *device)
 	writel_relaxed(config, controller->base + QUP_CONFIG);
 
 	clk_disable_unprepare(controller->cclk);
+	spi_qup_vote_bw(controller, 0);
 	clk_disable_unprepare(controller->iclk);
 
 	return 0;
@@ -1241,6 +1278,7 @@ static int spi_qup_suspend(struct device *device)
 		return ret;
 
 	clk_disable_unprepare(controller->cclk);
+	spi_qup_vote_bw(controller, 0);
 	clk_disable_unprepare(controller->iclk);
 	return 0;
 }

-- 
2.39.2

