Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42F9758760
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGRVkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGRVkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:40:12 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39929198D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:40:11 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id LsQRqvLQEm389LsQRqb5o4; Tue, 18 Jul 2023 23:40:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689716409;
        bh=LyjzMXYuyWxw4amNKCCB8oKlHHFUSzGDu6JLZTk+Yvg=;
        h=From:To:Cc:Subject:Date;
        b=e0XBrvaag8BjFsVvA7S/ji74YYT8t9NJTOuIQvKemhdLTIoGO7wFkKE4X0Q/zCbtS
         Qj3pxge5jplvnbWc7VE+t5mDaA7dEJgWnw2VCC6VSKpaR63EVDxI38ELROa4QzqRzR
         XR1M1/sphqXX0Wi633UsCUcULod3L3iAGjNBO3/9nKe+gDO+QuR0KTKjOosJOXBKkO
         GZSwky+XeN/cQt8bwfSOWZ6C92dDfU0goYmV+yFOkTE/5fV79SzMhHkGgUK/DtlN1l
         2o9GEz2RypMa9qd3NHJiCo7kmzHeMWyJ2dw0k5brbQxscbgiLSPDtwhhfMQDVYZ5i4
         AyvxO1yAKcgDQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 Jul 2023 23:40:09 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: typec: nb7vpq904m: Add an error handling path in nb7vpq904m_probe()
Date:   Tue, 18 Jul 2023 23:40:05 +0200
Message-Id: <9118954765821ea9f1179883602b4eca63e91749.1689716381.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error in the nb7vpq904m_probe() probe function, some resources
need to be freed, as already done in the remove function.

Add the missing error handling path and adjust code accordingly.

Fixes: 88d8f3ac9c67 ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This changes the order with some devm_ allocated resources. I hope this is
fine. At least it is consistent with the remove function.
---
 drivers/usb/typec/mux/nb7vpq904m.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index 80e580d50129..4d1122d95013 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -463,16 +463,18 @@ static int nb7vpq904m_probe(struct i2c_client *client)
 
 	ret = nb7vpq904m_register_bridge(nb7);
 	if (ret)
-		return ret;
+		goto err_disable_gpio;
 
 	sw_desc.drvdata = nb7;
 	sw_desc.fwnode = dev->fwnode;
 	sw_desc.set = nb7vpq904m_sw_set;
 
 	nb7->sw = typec_switch_register(dev, &sw_desc);
-	if (IS_ERR(nb7->sw))
-		return dev_err_probe(dev, PTR_ERR(nb7->sw),
-				     "Error registering typec switch\n");
+	if (IS_ERR(nb7->sw)) {
+		ret = dev_err_probe(dev, PTR_ERR(nb7->sw),
+				    "Error registering typec switch\n");
+		goto err_disable_gpio;
+	}
 
 	retimer_desc.drvdata = nb7;
 	retimer_desc.fwnode = dev->fwnode;
@@ -480,12 +482,21 @@ static int nb7vpq904m_probe(struct i2c_client *client)
 
 	nb7->retimer = typec_retimer_register(dev, &retimer_desc);
 	if (IS_ERR(nb7->retimer)) {
-		typec_switch_unregister(nb7->sw);
-		return dev_err_probe(dev, PTR_ERR(nb7->retimer),
-				     "Error registering typec retimer\n");
+		ret = dev_err_probe(dev, PTR_ERR(nb7->retimer),
+				    "Error registering typec retimer\n");
+		goto err_switch_unregister;
 	}
 
 	return 0;
+
+err_switch_unregister:
+	typec_switch_unregister(nb7->sw);
+
+err_disable_gpio:
+	gpiod_set_value(nb7->enable_gpio, 0);
+	regulator_disable(nb7->vcc_supply);
+
+	return ret;
 }
 
 static void nb7vpq904m_remove(struct i2c_client *client)
-- 
2.34.1

