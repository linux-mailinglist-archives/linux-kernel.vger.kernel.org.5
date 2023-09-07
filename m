Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09344797991
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbjIGRQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbjIGRQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:16:51 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA91FF5;
        Thu,  7 Sep 2023 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2+9PhsuxDwz9dE+S6gEk9jxLadNKiKHknoMCAQwIgc=;
  b=ec2hSo3RvbTzXAU9Em5Jk0wWXJgPsfJhh1T0sN3SyNEV4dathB1A7cie
   yS6Fkxp45Sac29NV6olxKUtJpxAjKXpN1WdxaxALrxE1tjayd689lkzZK
   K0VEppJHcfKw1TeXxiXGaXpwv2YqDqgS5xrSkiG21UDNui6PGRSaJ8AgW
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.02,234,1688421600"; 
   d="scan'208";a="65324661"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 11:55:30 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     kernel-janitors@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] mmc: atmel-mci: add missing of_node_put
Date:   Thu,  7 Sep 2023 11:55:15 +0200
Message-Id: <20230907095521.14053-6-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230907095521.14053-1-Julia.Lawall@inria.fr>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_child_of_node performs an of_node_get on each
iteration, so a break out of the loop requires an
of_node_put.

This was done using the Coccinelle semantic patch
iterators/for_each_child.cocci

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/mmc/host/atmel-mci.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff -u -p a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -674,8 +674,10 @@ atmci_of_init(struct platform_device *pd
 					      "cd", GPIOD_IN, "cd-gpios");
 		err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].detect_pin);
 		if (err) {
-			if (err != -ENOENT)
+			if (err != -ENOENT) {
+				of_node_put(cnp);
 				return ERR_PTR(err);
+			}
 			pdata->slot[slot_id].detect_pin = NULL;
 		}
 
@@ -687,8 +689,10 @@ atmci_of_init(struct platform_device *pd
 					      "wp", GPIOD_IN, "wp-gpios");
 		err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].wp_pin);
 		if (err) {
-			if (err != -ENOENT)
+			if (err != -ENOENT) {
+				of_node_put(cnp);
 				return ERR_PTR(err);
+			}
 			pdata->slot[slot_id].wp_pin = NULL;
 		}
 	}

