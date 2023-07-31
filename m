Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37716769779
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjGaNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjGaNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:25:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55C11705;
        Mon, 31 Jul 2023 06:25:33 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4410B161B;
        Mon, 31 Jul 2023 15:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690809865;
        bh=7gviuas7ZdfyKY61RCEJgVKIgwoEQqbPhjAh+fvyoHg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lnLKgyueyyt0wIeTtf7cyTLqbs5x3uD0tqI4wLgj3uJRzonup6lVL7U8Kgd7e/hmp
         VCrbocenR6LaBqVW/GcJuDWttdel/V56XcQQLb8llA4wqrajTFix6imyo3Q+T4xjrW
         lETmMk/sn+PsQ21M4JLzMK9E/kBzxsriAF8UczlU=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Mon, 31 Jul 2023 16:24:39 +0300
Subject: [PATCH v3 5/9] media: i2c: ds90ub953: Handle
 V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-fpdlink-additions-v3-5-8acfc49c215a@ideasonboard.com>
References: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
In-Reply-To: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=7gviuas7ZdfyKY61RCEJgVKIgwoEQqbPhjAh+fvyoHg=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkx7Y/2je2n13dRhzw0CZVjFF7LOM6jin5bGyXe
 6/95HEULI6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMe2PwAKCRD6PaqMvJYe
 9Q2IEACoHYI6jATHmSR12nv53A+HOov/6c3yLoyjmtJcYhecyaxp0yIoR/d5c/jBWAusoebN8ky
 CrzKEb3Rj57bTQD1dbUodA4xIeEn3Qy/tJfKa9QpvqWEnpu8w1nxUfCRMI/DploxJrk7aEKusmZ
 t5PKlFJsX2/aCOKuK6u1BmB+UUD+6BshXr5FVYRxd79N2bUVnm2xeTpn+tsDrg2d3PwOPW2pNG1
 tiWUzS1BNTstlj3vDXEGQJH5nJd/Yxl/RdYdSIMpUSX8cpVbybEf0WllH97DfEnZ1nrgquaiAkU
 wdFRhVq1Pp9p0FGeFKBNrANhcNxK/uBtgaT7uA7TriRNHvAw20HSiEAJTi2FSO074vAwHNPOpGp
 C/5cNXsC8YJ2fxZM85mhA1DvVSw2X2y4PoI6dodEGnnRAG2tzkpjqEmyUYosyIDcWCAff2Pejon
 XKDQlrqvLnExRCPPKKpJKJL1MPPr8GgFu8JVnQuWYDW8PgjoB5ybnTrsLmNoNhAWNFRHt7bWal+
 ZN9cE72gSK5RDXm5Re9dR3ycr0jOLRHLvHu7hgtaOtOcobn7kpp2CJvdfcDjcM9ZIkZQvMLz2wd
 9kvZvZna9cWy6VXsr6U7n+KqDv53fSYziCvDWT0OF4miDEp1MgPxveVOm3c2chM2WG3asJU9wts
 x8Y0x3PBoZFHUEg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK flag to configure the CSI-2 RX
continuous/non-continuous clock register.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ds90ub953.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index 1032c8633809..eedbca986928 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -138,6 +138,7 @@ struct ub953_data {
 	struct regmap		*regmap;
 
 	u32			num_data_lanes;
+	bool			non_continous_clk;
 
 	struct gpio_chip	gpio_chip;
 
@@ -1140,6 +1141,9 @@ static int ub953_parse_dt(struct ub953_data *priv)
 
 	priv->num_data_lanes = nlanes;
 
+	priv->non_continous_clk = vep.bus.mipi_csi2.flags &
+				  V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK;
+
 	return 0;
 }
 
@@ -1202,7 +1206,7 @@ static int ub953_hw_init(struct ub953_data *priv)
 		return dev_err_probe(dev, ret, "i2c init failed\n");
 
 	ub953_write(priv, UB953_REG_GENERAL_CFG,
-		    UB953_REG_GENERAL_CFG_CONT_CLK |
+		    (priv->non_continous_clk ? 0 : UB953_REG_GENERAL_CFG_CONT_CLK) |
 		    ((priv->num_data_lanes - 1) << UB953_REG_GENERAL_CFG_CSI_LANE_SEL_SHIFT) |
 		    UB953_REG_GENERAL_CFG_CRC_TX_GEN_ENABLE);
 

-- 
2.34.1

