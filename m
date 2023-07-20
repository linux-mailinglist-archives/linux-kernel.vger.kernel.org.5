Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C173475AC09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGTKb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjGTKbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:31:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5945310F1;
        Thu, 20 Jul 2023 03:31:44 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA0483697;
        Thu, 20 Jul 2023 12:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689849045;
        bh=3zg0TxkVcXHwj80fcueaquBqUvRn/uJahEbl2HWcRHo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kpfxg6FZprwwUtPx9ietn1V4s0lFbbWhlMEwizaf+z1blPmYtbwBJT3DnkbVK0Ss/
         Qd0lTD3yCP6aGS3HJnRaQqytNZKDkZfWXd2Ynul8b69Y5XIb7lUxLYLSiWDow4//5N
         rPBWN77RwyJmCIVCxDTA+48fnZT/uayuNmKtwFfo=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 20 Jul 2023 13:30:35 +0300
Subject: [PATCH v2 4/8] media: i2c: ds90ub953: Handle
 V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-fpdlink-additions-v2-4-b91b1eca2ad3@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=3zg0TxkVcXHwj80fcueaquBqUvRn/uJahEbl2HWcRHo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkuQ0FWYffPp2nMhTi2liX/2xEN899/vyaYUJJX
 yU9efkuiHyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLkNBQAKCRD6PaqMvJYe
 9RPAD/47epS1smq6O8YL2r+cKuMGUA+uCmzry2xhn4N/I7X51aKRcgpq22drWpksdA8nKP81kCH
 WASbwl9eJnahZX37OWbDsAvLFJsU9oryaAkDooOp4lizGw/c8AjXlLrjsIt+3mjK+6EFKvmAMjP
 b+lulfsxM08Dbx7vivjtMVR72qed3+YoD/CS11CPK+Miq7FYqMzwWRivgyoPjAcqD5VXqd0uG43
 cSpfrpx0N85dnvpjBwZ4V6cIdyaW61FCjsIPWX2CQsvcVrR5Rkf3xdy1b+s8SHfeuChe818j0Zj
 9yB/QBDVO4ne9sGJHQ3Ke6PFGbcqM/4BQMGrUMqxz+H11WCNGbdsEb/swjUqHriec/fWuzlcVOO
 PKqAIdKWJBgMxINgkMB82cGxLnOLXV9cu3ZkOePqGu6mUMO+k1VKiLHZygPQe30MrdAm3qJblux
 ru3TGTn9ahKlgm7JkqVA+F/ENu3ESZvN3TsTyxCMf/My8CkCk0PUkxkVYR2O00/DxNn1sAnKaPi
 jwJfWbgiEbdxhQ+rpyK2WPwuW9f1eQlHrgaOTMYoVuLtmfFhaaCjJaPnYXPkqbsd2Vrc4rbLlJN
 dJsY6l42GtQ8jF2qXSxWVGMLyM50ErM0xU2KVhhqIyOzajwmLa1RV2Wfw1+JfGU9T94xv1t3K7Z
 qTS8JbfVtaLKXSw==
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
---
 drivers/media/i2c/ds90ub953.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index ad964bd6c7eb..ad479923d2b4 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -138,6 +138,7 @@ struct ub953_data {
 	struct regmap		*regmap;
 
 	u32			num_data_lanes;
+	bool			non_cont_clk;
 
 	struct gpio_chip	gpio_chip;
 
@@ -1139,6 +1140,9 @@ static int ub953_parse_dt(struct ub953_data *priv)
 
 	priv->num_data_lanes = nlanes;
 
+	priv->non_cont_clk = vep.bus.mipi_csi2.flags &
+			     V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK;
+
 	return 0;
 }
 
@@ -1201,7 +1205,7 @@ static int ub953_hw_init(struct ub953_data *priv)
 		return dev_err_probe(dev, ret, "i2c init failed\n");
 
 	ub953_write(priv, UB953_REG_GENERAL_CFG,
-		    UB953_REG_GENERAL_CFG_CONT_CLK |
+		    (priv->non_cont_clk ? 0 : UB953_REG_GENERAL_CFG_CONT_CLK) |
 		    ((priv->num_data_lanes - 1) << UB953_REG_GENERAL_CFG_CSI_LANE_SEL_SHIFT) |
 		    UB953_REG_GENERAL_CFG_CRC_TX_GEN_ENABLE);
 

-- 
2.34.1

