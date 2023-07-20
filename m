Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF775AC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGTKcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGTKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:31:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82261719;
        Thu, 20 Jul 2023 03:31:46 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 71C1537B1;
        Thu, 20 Jul 2023 12:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689849048;
        bh=Rur1IK4TcPD70743h/tvl3kOfm8iOTDAhEwetSWaWDY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kTWD2/BOqU1mHDUETVmqL8Xqgc+KID6QJZTDOvsZViSS1WlREwDP2O7HQPiZhuBbE
         IqQj6taNn4vL14OwZZ0E8ZBBUjoHMCiGkJ7tunZqd+IkL6P41xgbNwnTFANABWs5eM
         y/syppZugjyabQMHPXi/e/yxxvfa/Fst76OxvvuE=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 20 Jul 2023 13:30:38 +0300
Subject: [PATCH v2 7/8] media: i2c: ds90ub953: Support non-sync mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-fpdlink-additions-v2-7-b91b1eca2ad3@ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
In-Reply-To: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Rur1IK4TcPD70743h/tvl3kOfm8iOTDAhEwetSWaWDY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkuQ0GiP2nZraBbDa6yM3SKZJuVPbC4eCco1Cnr
 ATJOwBF2HGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLkNBgAKCRD6PaqMvJYe
 9X7KD/9AUuDRNnHu+8MdFW0vpJ19RtR8/1MAfDzbJjDy/hW7fD/oBZvcnwVZ4M83XAzbi1uEjg6
 znk7BsFaCw9LYOBd9WvU7mGfbcr6F6TH1ZWwRFMZhZE+ZE+aYTIEGppn0mmkgTXs8yeeJHHPEaw
 K3nvyntN1NyxfotbW2YrhzJ7nxDkvX/3fAE9ST/1jo59TKgkbDVeWyzD9f54zbUPGlqLcnoiiw9
 Q/0+CvBpN9W33nLsoSHR6J5s2pvdObiXFzH7T8+QMUSoDkwaH5MU/qihWbPoAsMRx0TkdeBe9tx
 SyCGlrkCtNHKfFsNZvk8MV1ONk4AeZNflPEfcgrj2O5RANhvTFE5h5ybUdwxvkeW/NmvnAIdgjN
 uqDIj8F63hl1BclVZA1PzhL7gZvtOeUZ/bFs88ja/xF8F5U5ZngplyWmzTPy5PexY7A8Rckm5EQ
 bzUEIX/xhWqC7ESGr2clmY4deyy1UY2k4yx5rmriIflvt14PQdLA+99wPjbXABRRymNPqlygq6u
 lePxsFdB33QicHht0dwss9L0IDYeDOj6qT7k0s22ljX/ap9EJg3M57Xv8dFhpcHZvD76Qqpjx0U
 7VMUgtY0AW3kEDtNhzwCvJ7gcgAxRxDUCyJJwPx3Q7Pq5yshOJJ4U9iSKmKCqzsTsr91tef0KY/
 CFzBb21ty6PiVXQ==
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

Add support for FPD-Link non-sync mode with external clock. The only
thing that needs to be added is the calculation for the clkout.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/i2c/ds90ub953.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index 3a19c6dedd2f..846542e6e20d 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -143,6 +143,7 @@ struct ub953_data {
 
 	struct i2c_client	*client;
 	struct regmap		*regmap;
+	struct clk		*clkin;
 
 	u32			num_data_lanes;
 	bool			non_cont_clk;
@@ -842,15 +843,21 @@ static int ub953_i2c_master_init(struct ub953_data *priv)
 
 static u64 ub953_get_fc_rate(struct ub953_data *priv)
 {
-	if (priv->mode != UB953_MODE_SYNC) {
+	switch (priv->mode) {
+	case UB953_MODE_SYNC:
+		if (priv->hw_data->is_ub971)
+			return priv->plat_data->bc_rate * 160ull;
+		else
+			return priv->plat_data->bc_rate / 2 * 160ull;
+
+	case UB953_MODE_NONSYNC_EXT:
+		/* CLKIN_DIV = 1 always */
+		return clk_get_rate(priv->clkin) * 80ull;
+
+	default:
 		/* Not supported */
 		return 0;
 	}
-
-	if (priv->hw_data->is_ub971)
-		return priv->plat_data->bc_rate * 160ull;
-	else
-		return priv->plat_data->bc_rate / 2 * 160ull;
 }
 
 static unsigned long ub953_calc_clkout_ub953(struct ub953_data *priv,
@@ -1188,9 +1195,15 @@ static int ub953_hw_init(struct ub953_data *priv)
 	dev_dbg(dev, "mode from %s: %#x\n", mode_override ? "reg" : "strap",
 		priv->mode);
 
-	if (priv->mode != UB953_MODE_SYNC)
+	if (priv->mode != UB953_MODE_SYNC &&
+	    priv->mode != UB953_MODE_NONSYNC_EXT)
 		return dev_err_probe(dev, -ENODEV,
-				     "Only synchronous mode supported\n");
+				     "Unsupported mode selected: %d\n",
+				     priv->mode);
+
+	if (priv->mode == UB953_MODE_NONSYNC_EXT && !priv->clkin)
+		return dev_err_probe(dev, -EINVAL,
+				     "clkin required for non-sync ext mode\n");
 
 	ret = ub953_read(priv, UB953_REG_REV_MASK_ID, &v);
 	if (ret)
@@ -1318,6 +1331,11 @@ static int ub953_probe(struct i2c_client *client)
 		goto err_mutex_destroy;
 	}
 
+	priv->clkin = devm_clk_get_optional(dev, "clkin");
+	if (IS_ERR(priv->clkin))
+		return dev_err_probe(dev, PTR_ERR(priv->clkin),
+				     "failed to parse 'clkin'\n");
+
 	ret = ub953_parse_dt(priv);
 	if (ret)
 		goto err_mutex_destroy;

-- 
2.34.1

