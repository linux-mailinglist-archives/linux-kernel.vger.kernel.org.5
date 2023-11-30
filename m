Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E847D7FE794
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjK3DQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3DQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:16:02 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 431121A6;
        Wed, 29 Nov 2023 19:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=UfjhIxyGPgUBRRrgHE
        ZRqAC26KRpErr7rMhG9xIdpcU=; b=ZFFG9NCDo5w5m5kc8Nih7jn82lb8VyQ7c1
        /b8/AW+icz0K+aVbmvLFOU0UzoFafKs3cQwOuHJRuSowCYMRSPDtE0cQ4d3AhaDd
        3FOE+UTr31EiBB10Hnmd3BGECauHcIxz4V1tsVWTapYwatC7zpn4CQtOFATqOsJ7
        tTjhORLiI=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wDH13_P_WdlBXH7AQ--.52667S2;
        Thu, 30 Nov 2023 11:13:21 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, pabeni@redhat.com, heiko@sntech.de,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [net/ethernet] arc_emac: Add error handling in emac_rockchip_probe
Date:   Wed, 29 Nov 2023 19:13:18 -0800
Message-Id: <20231130031318.35850-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDH13_P_WdlBXH7AQ--.52667S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWfKw13KF1fuw1UKryUWrg_yoW8Gw43pw
        4DCr9xCw1kWw17Za97GayrAF4Yq3W5KFWjgF9rGa1fua45AFyUXry0qa45ur1UJr42kFya
        kr4UA34fZan8X37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zieOJ7UUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgU4gletj6IPXAAAsJ
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

This patch introduces error handling for the of_match_node call within
the emac_rockchip_probe. Previously, there was no check for the return
value of of_match_node, which could result in improper behavior if the
device tree match was unsuccessful.

Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. Addressing them now can prevent potential
debugging efforts in the future, which could be quite resource-intensive.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/net/ethernet/arc/emac_rockchip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index 493d6356c8ca..f6f1390b77f6 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -134,6 +134,11 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 	}
 
 	match = of_match_node(emac_rockchip_dt_ids, dev->of_node);
+	if (!match) {
+		dev_err(dev, "No matching device found\n");
+		return -ENODEV;
+	}
+
 	priv->soc_data = match->data;
 
 	priv->emac.clk = devm_clk_get(dev, "hclk");
-- 
2.17.1

