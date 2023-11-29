Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6378C7FD6AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjK2MZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjK2MZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:25:16 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D47FED7E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=jEObS/HV3KnbOlieZh
        /QleucJWKx0CNHN/jOSzwsRpg=; b=oQL6dXI+6gZ1aQHVYvEjghiPQ4KsT8RutW
        g/sqFKeQ1Q10Wf7wkObC3BHUZX3sjDSQEgph+d4jjLqHeY/9NwxsPf7JJMpjzTq/
        Y2TOLs7Eg0VFgj1zAi8nIkYgQ/yHJoKq1O7o5bh7bpm5pO+KFQOZEXZNBKzIbMuH
        NtlsBhYTQ=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wAnhjmaLWdl6JhZCQ--.40944S2;
        Wed, 29 Nov 2023 20:24:59 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     vkoul@kernel.org
Cc:     kishon@kernel.org, robh@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [phy/marvell] phy-pxa-28nm-usb2: Add error handling
Date:   Wed, 29 Nov 2023 04:24:57 -0800
Message-Id: <20231129122457.33413-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wAnhjmaLWdl6JhZCQ--.40944S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4fAw4xXw4DuF4DZr45Awb_yoWDuFcEgr
        1UJr97Xr4DZwsFy34UKw15Ja429ryfZa4rWFyIqrWFyFZrJ3ZI93yDZFs3A3s8Gw42kr9r
        tw45Zr47Ar13WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKpB-UUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwgA3glc661zDHQAAsz
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error handling to the mv_usb2_phy_28nm_init
function in drivers/phy/marvell/phy-pxa-28nm-usb2.c. The
function previously did not handle the potential failure of
the clk_prepare_enable call, which could result in unexpected
behavior if clock preparation failed.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/phy/marvell/phy-pxa-28nm-usb2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-pxa-28nm-usb2.c b/drivers/phy/marvell/phy-pxa-28nm-usb2.c
index 64afb82cf70e..93fea4f246a2 100644
--- a/drivers/phy/marvell/phy-pxa-28nm-usb2.c
+++ b/drivers/phy/marvell/phy-pxa-28nm-usb2.c
@@ -154,7 +154,11 @@ static int mv_usb2_phy_28nm_init(struct phy *phy)
 	u32 reg;
 	int ret;
 
-	clk_prepare_enable(mv_phy->clk);
+	ret = clk_prepare_enable(mv_phy->clk);
+	if (ret) {
+		dev_err(&phy->dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
 
 	/* PHY_28NM_PLL_REG0 */
 	reg = readl(base + PHY_28NM_PLL_REG0) &
-- 
2.17.1

