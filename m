Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B09802A76
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 04:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjLDDEN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 3 Dec 2023 22:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDDEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 22:04:12 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4E7E5;
        Sun,  3 Dec 2023 19:04:18 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 50E9A24DDB2;
        Mon,  4 Dec 2023 11:04:17 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 11:04:17 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 11:04:15 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: starfive - Fix dev_err_probe return error
Date:   Mon, 4 Dec 2023 11:04:13 +0800
Message-ID: <20231204030413.989243-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dev_err_probe will return 0 instead of proper error code if
driver failed to get irq number. Fix the return code.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-cryp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index 1e3cadcb179b..cd876fb23ade 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -160,7 +160,7 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, starfive_cryp_irq, 0, pdev->name,
 			       (void *)cryp);
 	if (ret)
-		return dev_err_probe(&pdev->dev, irq,
+		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to register interrupt handler\n");
 
 	clk_prepare_enable(cryp->hclk);
-- 
2.34.1

