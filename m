Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CBE79C2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbjILCbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbjILCb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:31:27 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189610489D;
        Mon, 11 Sep 2023 18:56:25 -0700 (PDT)
Received: from p200300ccff36fa001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff36:fa00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qfpAE-003crY-3O; Tue, 12 Sep 2023 00:13:50 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qfpAD-006ECq-2M;
        Tue, 12 Sep 2023 00:13:49 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lee@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        mturquette@baylibre.com, sboyd@kernel.org, andreas@kemnade.info,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 3/5] mfd: twl-core: Add a clock subdevice for the TWL6032
Date:   Tue, 12 Sep 2023 00:13:44 +0200
Message-Id: <20230911221346.1484543-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911221346.1484543-1-andreas@kemnade.info>
References: <20230911221346.1484543-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock device needs no separate devicetree node, so add it as
a platform device. Other devices in the family also have controllable
clocks, but due to the lack of testing, just add it for the TWL6032
now.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/twl-core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index ce01a87f8dc39..234500b2e53fc 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -31,6 +31,8 @@
 #include <linux/regulator/machine.h>
 
 #include <linux/i2c.h>
+
+#include <linux/mfd/core.h>
 #include <linux/mfd/twl.h>
 
 /* Register descriptions for audio */
@@ -690,6 +692,10 @@ static struct of_dev_auxdata twl_auxdata_lookup[] = {
 	{ /* sentinel */ },
 };
 
+static const struct mfd_cell twl6032_cells[] = {
+	{ .name = "twl6032-clk" },
+};
+
 /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
 static int
 twl_probe(struct i2c_client *client)
@@ -836,6 +842,16 @@ twl_probe(struct i2c_client *client)
 				 TWL4030_DCDC_GLOBAL_CFG);
 	}
 
+	if (id->driver_data == (TWL6030_CLASS | TWL6032_SUBCLASS)) {
+		status = devm_mfd_add_devices(&client->dev,
+					      PLATFORM_DEVID_NONE,
+					      twl6032_cells,
+					      ARRAY_SIZE(twl6032_cells),
+					      NULL, 0, NULL);
+		if (status < 0)
+			goto free;
+	}
+
 	status = of_platform_populate(node, NULL, twl_auxdata_lookup,
 				      &client->dev);
 
-- 
2.39.2

