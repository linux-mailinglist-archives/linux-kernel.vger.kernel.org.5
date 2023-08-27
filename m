Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD05F789CBD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjH0JjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjH0JiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:38:20 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647FAFA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:38:18 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id aCDYqs7H09KIfaCDoq3nY7; Sun, 27 Aug 2023 11:38:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693129097;
        bh=piFugZHMLuSIS9b+Rv/FmdqkIddGgweuSK0getmdWiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YJ7XAJ3+B+BiabruVyPjt4PsGR3SEyI6KA0N9ZzKe1O7WTLRY7+zI5tUkCIBTuA5t
         bZlYskYXbE0zGWWPU3nokcAl/cDDfnn3G3xe1ePsfo/Z1U3EjGHWM24bdc2xO0+Gyp
         lKyqco2d0LCAV5ijqFVthSYu3TktErkNQj7GhLqHUJFDaR3dcks7n2k9uk032IOZ0p
         nZMtMcMgJZvQ3N3wg6qAQvg+yrT1pFg6mln7VCkDxfF1+VREHmM8HZErGNYIylbxby
         TBigHzrjqAsU5YdeolnqtnxbT5BJqICZdrm1SBB9bq2spVbUmfRH+7gA8rGANPYxzc
         bbT8mV+3w3fEQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Aug 2023 11:38:17 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/5] clk: imx: imx8: Fix an error handling path in clk_imx_acm_attach_pm_domains()
Date:   Sun, 27 Aug 2023 11:37:52 +0200
Message-Id: <84ba2f52d43887f954d26a784bd576f20587320f.1693126687.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
References: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a dev_pm_domain_attach_by_id() call fails, previously allocated
resources need to be released.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/imx/clk-imx8-acm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index 1e82f72b75c6..87025a6772d0 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -279,8 +279,10 @@ static int clk_imx_acm_attach_pm_domains(struct device *dev,
 
 	for (i = 0; i < dev_pm->num_domains; i++) {
 		dev_pm->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
-		if (IS_ERR(dev_pm->pd_dev[i]))
-			return PTR_ERR(dev_pm->pd_dev[i]);
+		if (IS_ERR(dev_pm->pd_dev[i])) {
+			ret = PTR_ERR(dev_pm->pd_dev[i]);
+			goto detach_pm;
+		}
 
 		dev_pm->pd_dev_link[i] = device_link_add(dev,
 							 dev_pm->pd_dev[i],
-- 
2.34.1

