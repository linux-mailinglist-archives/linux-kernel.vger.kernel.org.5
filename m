Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554D4771775
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 02:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjHGAQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 20:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGAQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 20:16:37 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0376DFA;
        Sun,  6 Aug 2023 17:16:34 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Aug 2023 09:16:33 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 6016D231A0F8;
        Mon,  7 Aug 2023 09:16:33 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 7 Aug 2023 09:16:33 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B6E81126DC0;
        Mon,  7 Aug 2023 09:16:32 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] spi: dw: Set default value if reg-io-width isn't specified
Date:   Mon,  7 Aug 2023 09:16:21 +0900
Message-Id: <20230807001621.196776-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the dt-bindings, the default value of reg-io-width is 4.
However, the value becomes zero when reg-io-width isn't specified.

Should set the actual value to dws->reg_io_width, considering it
referenced.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/spi/spi-dw-mmio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index a963bc96c223..7eafc07ef7aa 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -369,7 +369,9 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
 
-	device_property_read_u32(&pdev->dev, "reg-io-width", &dws->reg_io_width);
+	if (device_property_read_u32(&pdev->dev, "reg-io-width",
+				     &dws->reg_io_width))
+		dws->reg_io_width = 4;
 
 	num_cs = 4;
 
-- 
2.25.1

