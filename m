Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4507FD64C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjK2MGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjK2MGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:06:52 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 563F610C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=XcvJyms8UCabUgFAD5
        Q++wTaeOfxzMUw/2HahmsKw7w=; b=Fs+iPt63eB79uiYrz7SjpBk2kVq0U5i4em
        a51Q0n4JP9nQ9+06RfVarzHO9KUZqgN5MfmWcTtsId+DskcMOAO6650AESeX5eNP
        LUL/xxh4JkCmrLiCYjdQkJdNfzoRE6PhZH0PWXygbJ7Y/Vc9WxGazZSELF8q8C3i
        5uEu3ghIc=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wBnbzhPKWdlcauGAQ--.39921S2;
        Wed, 29 Nov 2023 20:06:40 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     vkoul@kernel.org
Cc:     kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [phy/marvell] phy-pxa-28nm-hsic: Add error handling
Date:   Wed, 29 Nov 2023 04:06:38 -0800
Message-Id: <20231129120638.33294-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wBnbzhPKWdlcauGAQ--.39921S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur1DZFWUJw1xtF4DGrWfZrb_yoWDtrcEgr
        18CrZ3XF4j9anrK345Gw1rJ3s2kF9avayxWFyIqrWSyFy7X3Za93yDZwsxA3s8Wa12krWD
        Gw45ZrW7Ar13WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKpB-UUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZQY3gl8ZaQ1sNgABsv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add error handling for the clk_prepare_enable call
in the mv_hsic_phy_init function. Previously, the
function did not handle potential failure cases of
clk_prepare_enable, which could result in undefined behavior if
the clock preparation failed.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/phy/marvell/phy-pxa-28nm-hsic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-pxa-28nm-hsic.c b/drivers/phy/marvell/phy-pxa-28nm-hsic.c
index eff6dd6b2dd0..1aa09ebeaa8e 100644
--- a/drivers/phy/marvell/phy-pxa-28nm-hsic.c
+++ b/drivers/phy/marvell/phy-pxa-28nm-hsic.c
@@ -60,7 +60,11 @@ static int mv_hsic_phy_init(struct phy *phy)
 	void __iomem *base = mv_phy->base;
 	int ret;
 
-	clk_prepare_enable(mv_phy->clk);
+	ret = clk_prepare_enable(mv_phy->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
 
 	/* Set reference clock */
 	writel(0x1 << PHY_28NM_HSIC_PLL_SELLPFR_SHIFT |
-- 
2.17.1

