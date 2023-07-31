Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C8576977A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjGaNZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjGaNZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:25:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCD210DF;
        Mon, 31 Jul 2023 06:25:28 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6AA1512B1;
        Mon, 31 Jul 2023 15:24:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690809862;
        bh=jk9Ujzd2lrsBddUBKSdxUek/7PziJpvcJYWomQe7MS8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=jAjqlB7t9qfFOc3nn888kZkpFWLALxNbScyhDNrnl+pTMpVq2glddNpFaV+8b5VjR
         q+GfLNjOrERjSCVzC3rMaAO93HhT9/ipq6/gzzzzas5SeR/pGuAbgqCvc9poHxCJpZ
         PpIRV3P+yoIsAHVqX5xrF1+uZQCPaKRHGLUpmiOE=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Mon, 31 Jul 2023 16:24:36 +0300
Subject: [PATCH v3 2/9] media: i2c: ds90ub960: Configure CSI-2 continuous
 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-fpdlink-additions-v3-2-8acfc49c215a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1670;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=jk9Ujzd2lrsBddUBKSdxUek/7PziJpvcJYWomQe7MS8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkx7Y+jWa/YwmVNqzpIhD3XZCrcIlqRcEy+cc54
 Wnvg9w4sSyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMe2PgAKCRD6PaqMvJYe
 9WyCD/951gROsLfMIsbSUx85DbnAM6Yzhpvo2j4XW8ddS67Fr8QHId1E7c3toNHr6FxrOdhCScK
 jGA7hRJpL4QrJtVDgv0MyJTZ7gg5anAAFjqWICsV+/aZg8UDSksOj0RxF2q+4DzolN5UQAG9XiQ
 74fwRezwjaVtv0z4kx3vEdmQ94z8mvw2IGsJI44iy+Wnsx1vszZUU8khuTInQMpcEtYd5SUNM+P
 VLXAwVWaviXOcOsY1nvRaS8pW0HPUYPv2r5y/hBoRbHrdaO0/1UvvBbrxss+TZqK7jnm3VqG9Rj
 88n9+HvSzMi5MEtL1v5xrUwDeyaf4+cTEYQSEKvQ4d478IDHhwVIJwBQHNB+7E0vBxf8M6MSZI8
 /oV3tuRIlUgkgSLVA0KpdUEzeM9PoNwBp0H6eQHvy0DSdIkA0K5911D72EV051+48RJ/kVpnz5f
 iOdj1C28UZJ2qcXjwes/NcGeGJgsPREwgHL2421IucSWwYeQ/K5Uoc3yEi6L6fMTsUildoBgqBd
 C8TGf7j2uNf+szo/yMGCNlyQXGOTMEa8IdnrLKf08wJ0pRqZLDw/p8nU1XzTWwb3d5xGoy9NSwV
 A74ytl/yrHfMSdzrycKJY59LsjvtuubYJR9PXI8a7tYWLVNlQgNeHlgUytiRwUzrczVXZNIhoMc
 MrJPc9UNVeY0Nhw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'clock-noncontinuous' from DT to configure the
continuous/non-continuous clock setting for the TX ports.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ds90ub960.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index 4833b39b9178..b840c9160bf2 100644
--- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -149,6 +149,7 @@
 
 #define UB960_TR_CSI_CTL			0x33
 #define UB960_TR_CSI_CTL_CSI_CAL_EN		BIT(6)
+#define UB960_TR_CSI_CTL_CSI_CONTS_CLOCK	BIT(1)
 #define UB960_TR_CSI_CTL_CSI_ENABLE		BIT(0)
 
 #define UB960_TR_CSI_CTL2			0x34
@@ -485,6 +486,7 @@ struct ub960_txport {
 	u8                      nport;	/* TX port number, and index in priv->txport[] */
 
 	u32 num_data_lanes;
+	bool non_continous_clk;
 };
 
 struct ub960_data {
@@ -1133,6 +1135,9 @@ static int ub960_parse_dt_txport(struct ub960_data *priv,
 		goto err_free_txport;
 	}
 
+	txport->non_continous_clk = vep.bus.mipi_csi2.flags &
+				    V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK;
+
 	txport->num_data_lanes = vep.bus.mipi_csi2.num_data_lanes;
 
 	if (vep.nr_of_link_frequencies != 1) {
@@ -1744,6 +1749,9 @@ static void ub960_init_tx_port(struct ub960_data *priv,
 
 	csi_ctl |= (4 - txport->num_data_lanes) << 4;
 
+	if (!txport->non_continous_clk)
+		csi_ctl |= UB960_TR_CSI_CTL_CSI_CONTS_CLOCK;
+
 	ub960_txport_write(priv, nport, UB960_TR_CSI_CTL, csi_ctl);
 }
 

-- 
2.34.1

