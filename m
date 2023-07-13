Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66151751D38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjGMJa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjGMJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:30:24 -0400
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 02:30:20 PDT
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BD221FC7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:30:20 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 7907E5E927;
        Thu, 13 Jul 2023 11:20:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1689240054;
        bh=S16vix2PCMZJ04EOz/eaypi8vCJykAo9q+IFd6bxo/0=;
        h=From:To:CC:Subject:Date:From;
        b=YOx/GGo5500mkC9YY33XlkwGMkeZPNzyssyh5uEzdqbpOenaeSd2IsGXFj6gRVG6e
         G5LqJFrjEPcyIiezE/50R/hFEEoA90Actyz0y7psCgoyHo3Cbccj+hvPzCi3rtBgOq
         qC4+v6POmEV+PEPOoaDVroWCgBBN+Z/MZDlmMYW0bRVXyz3AhHE1QAwsp10GnoIx/1
         JgHFlARSYqMVaw4GiyQkXwOp/5imiekLRlfyi7tEGHNc0h2XNpvNqnsPp6RZsMcUvS
         gQBFOxqBYjq98QKVJ9RVvLb9KJamIUBNxbtR+rFH3MVodJkaYzkuFgiU1sOBEWbEBv
         /QpIDWQaaNULg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 13 Jul 2023 11:20:51 +0200
Received: from localhost.localdomain (172.16.51.5) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16 via Frontend Transport; Thu, 13 Jul 2023 11:20:50 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "Support Opensource" <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Date:   Thu, 13 Jul 2023 11:03:28 +0200
Message-ID: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the use of IRQ optional to make the DA9061/62 usable
for designs that don't have the IRQ pin connected, because the regulator
is usable without IRQ.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@intel.com/
---
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Rebase on current next 20230209
    - Add Reviewed-by and Acked-by tags
V3: - Rebase on current next 20230307
v4: - Rebase on current next 20230309
    - Fix a missing variable change reported by kernel test robot
v5: - Rebase on current next 20230713
    - Add Marek's Reviewed-by tag
---
 drivers/regulator/da9062-regulator.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index c28b061eef02..1d354db0c1bd 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -924,7 +924,7 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	struct da9062_regulator *regl;
 	struct regulator_config config = { };
 	const struct da9062_regulator_info *rinfo;
-	int irq, n, ret;
+	int n, ret;
 	int max_regulators;
 
 	switch (chip->chip_type) {
@@ -1012,12 +1012,11 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	}
 
 	/* LDOs overcurrent event support */
-	irq = platform_get_irq_byname(pdev, "LDO_LIM");
-	if (irq < 0)
-		return irq;
-	regulators->irq_ldo_lim = irq;
+	regulators->irq_ldo_lim = platform_get_irq_byname_optional(pdev, "LDO_LIM");
+	if (regulators->irq_ldo_lim < 0)
+		return 0;
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq,
+	ret = devm_request_threaded_irq(&pdev->dev, regulators->irq_ldo_lim,
 					NULL, da9062_ldo_lim_event,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					"LDO_LIM", regulators);
-- 
2.11.0

