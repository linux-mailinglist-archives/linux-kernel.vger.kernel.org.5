Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678F47FD81F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjK2NaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjK2NaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:30:10 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F236A8;
        Wed, 29 Nov 2023 05:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=JmdW2UbTrTOnM62ANw
        uP4zK8vG4e8luOaqLCxOa+6iE=; b=lCt70qak/pKxGklw11WVuUaz8mDHx0oBkJ
        ITlE86LnkPfuf9V+QHYKWn6+FS7HHy6m9KaWQYPc0BAoOizXwFAy6ecjzfG6MYvD
        +sexrsV0sNZWil+pRJh8+/RefVIBy55LoAnJM6woHtqC1EwGXkeUO9hSjb0FsIZs
        nBV3nd+IA=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wDXnx3FPGdlfoIgBQ--.49480S2;
        Wed, 29 Nov 2023 21:29:43 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     claudiu.beznea@tuxon.dev
Cc:     sre@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [power/reset] at91-sama5d2: Add error handling in at91_shdwc_probe
Date:   Wed, 29 Nov 2023 05:29:39 -0800
Message-Id: <20231129132939.34047-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDXnx3FPGdlfoIgBQ--.49480S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4xCw15uF4UWFW3WFWruFg_yoWkGFc_Xw
        47AFWIya47KF1v9FnavwnIvrZ7CrnrXryDXF18tr93uryDWw4DtrsFvr4DXFs5Xa4UCrs8
        tF4DtF4rZF1xXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMGYLJUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZQs3gl8ZaQ8awgABsi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error handling to the at91_shdwc_probe function
in drivers/power/reset/at91-sama5d2_shdwc.c. The function
previously did not handle the case where of_match_node could fail,
potentially leading to unexpected behavior if the device tree match
was unsuccessful.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index e76b102b57b1..2ac566c83aec 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -353,6 +353,11 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 		return PTR_ERR(at91_shdwc->shdwc_base);
 
 	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
+	if (!match) {
+		dev_err(&pdev->dev, "No matching device found\n");
+		return -ENODEV;
+	}
+
 	at91_shdwc->rcfg = match->data;
 
 	at91_shdwc->sclk = devm_clk_get(&pdev->dev, NULL);
-- 
2.17.1

