Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A8879061D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 10:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351832AbjIBIWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 04:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIBIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 04:22:35 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94F5DCC;
        Sat,  2 Sep 2023 01:22:32 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,222,1688396400"; 
   d="scan'208";a="174781788"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2023 17:22:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 633964006186;
        Sat,  2 Sep 2023 17:22:29 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] pinctrl: cy8c95x0: Simplify probe()
Date:   Sat,  2 Sep 2023 09:22:25 +0100
Message-Id: <20230902082225.8777-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simpilfy probe() by replacing device_get_match_data() and id lookup for
retrieving match data by i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 58ca6fac7849..fae80b52a6fc 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1346,9 +1346,7 @@ static int cy8c95x0_probe(struct i2c_client *client)
 	chip->dev = &client->dev;
 
 	/* Set the device type */
-	chip->driver_data = (unsigned long)device_get_match_data(&client->dev);
-	if (!chip->driver_data)
-		chip->driver_data = i2c_match_id(cy8c95x0_id, client)->driver_data;
+	chip->driver_data = (uintptr_t)i2c_get_match_data(client);
 	if (!chip->driver_data)
 		return -ENODEV;
 
-- 
2.25.1

