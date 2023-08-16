Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1040577E431
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbjHPOxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbjHPOxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:53:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB022715
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:53:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1qWHtm-0001Ft-4f; Wed, 16 Aug 2023 16:53:26 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1qWHtj-00140M-QO; Wed, 16 Aug 2023 16:53:23 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1qWHti-00DG1Q-Ph; Wed, 16 Aug 2023 16:53:22 +0200
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     valentin.caron@foss.st.com,
        Alain Volmat <alain.volmat@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, robh+dt@kernel.org,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Subject: [PATCH] spi: stm32: fix accidential revert to byte-sized transfer splitting
Date:   Wed, 16 Aug 2023 16:52:37 +0200
Message-Id: <20230816145237.3159817-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6f486556abe35 ("spi: stm32: renaming of spi_master into
spi_controller") included an accidential reverted of a change added in
commit 1e4929112507f ("spi: stm32: split large transfers based on word
size instead of bytes").

This breaks large SPI transfers with word sizes > 8 bits, which are
e.g. common when driving MIPI DBI displays.

Fix this by using `spi_split_transfers_maxwords()` instead of
`spi_split_transfers_maxsize()`.

Fixes: 6f486556abe35 ("spi: stm32: renaming of spi_master into spi_controller")
Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 drivers/spi/spi-stm32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 6d10fa4ab7839..7ddf9db776b06 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1001,9 +1001,9 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 	if (spi->cfg->set_number_of_data) {
 		int ret;
 
-		ret = spi_split_transfers_maxsize(ctrl, msg,
-						  STM32H7_SPI_TSIZE_MAX,
-						  GFP_KERNEL | GFP_DMA);
+		ret = spi_split_transfers_maxwords(ctrl, msg,
+						   STM32H7_SPI_TSIZE_MAX,
+						   GFP_KERNEL | GFP_DMA);
 		if (ret)
 			return ret;
 	}

base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
-- 
2.39.2

