Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB07A0EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjINUb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjINUbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:31:24 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ABF2704
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:31:20 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gszUqMvFz7mcCgszeqSuie; Thu, 14 Sep 2023 22:31:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694723478;
        bh=vDMwGPoL7IUwKLZSj66ABJwQcRH7iJ6OhehhdBpzoGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=H53P1VIqYoTjl1GsFVQAtp1OUqAcTgfxyzCQIi7cOILeyUZmPhDyWJhgyBfbLcBp1
         Ytg/siSE+/4EFWOce4lK2PyDFezrBpi2Y403yLVvLp1XBhT+9W2cr+jitk4DWtiqml
         Ww737IvD6ByWQupws/gWtCOkh4TqrHIWKsP+0Yp0qBJHd624z/ESKvMjFwkE29XY6i
         IIEO6CUPSk2FdJXq0YBaIWrD6i2/Z9VlX7nqZo8qrrR6ojDVItnZ7K2DAR//iSheYo
         MY7ePLJMSK5fxMknV83WAokoDP6yHtaUeQAp58i3pkBi3talLLPHzitWCMYxN3G23u
         esTHVNSH3ybLw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Sep 2023 22:31:18 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 1/5] clk: imx: imx8: Fix an error handling path in clk_imx_acm_attach_pm_domains()
Date:   Thu, 14 Sep 2023 22:31:02 +0200
Message-Id: <ced98eb9416ded902f3896ba58fee72991864e26.1694722339.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
References: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a dev_pm_domain_attach_by_id() call fails, previously allocated
resources need to be released.

Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
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

