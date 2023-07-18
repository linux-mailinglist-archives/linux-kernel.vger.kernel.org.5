Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E6A757DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjGRNaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjGRN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:29:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C227124;
        Tue, 18 Jul 2023 06:29:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BDAC6158D;
        Tue, 18 Jul 2023 13:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACDCC433BA;
        Tue, 18 Jul 2023 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686984;
        bh=YujBf+tSBimSZNEfZhDQx4wRVWWIF1I4fAuUh7MYhGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmIIeasD+VaC2Xfn+NQv1hEgjLN+EocrpSUkbost1LU6y29N7ZAZig7/5AukCFMkA
         RXcIis9R8tIbzePesSTgpwH039Mk7WAoW7hL7ZWg/N26/tDkP/oIQMHHQ4I88Zje21
         NrkuxsG8wplGmK06mjd1s0+C3WyrkEiQOVE9iFWcGABjL8Kao/mxfczHs562zcPc0v
         WH8kXwXFEBisOl//Rch6Ht83H9lIRJdmd8c3soTyHRJPOzheqPtIRl0+9EAqXnAxui
         kH1qbwb5SeWqxGTG+MJCzUQQYfjFDHowtyPaOJ5f7621J23QjI9GuWsKlRy3Vb2uMg
         1DcMSarGXWHgw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qLkm2-0005c5-06;
        Tue, 18 Jul 2023 15:29:54 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/8] clk: qcom: gcc-sc8280xp: fix runtime PM imbalance on probe errors
Date:   Tue, 18 Jul 2023 15:28:58 +0200
Message-ID: <20230718132902.21430-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718132902.21430-1-johan+linaro@kernel.org>
References: <20230718132902.21430-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to decrement the runtime PM usage count before returning in
case RCG dynamic frequency switch initialisation fails.

Fixes: 2a541abd9837 ("clk: qcom: gcc-sc8280xp: Add runtime PM")
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index 1fb6ffac730c..ac6f8c0c1ccb 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7539,8 +7539,8 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
 
 	regmap = qcom_cc_map(pdev, &gcc_sc8280xp_desc);
 	if (IS_ERR(regmap)) {
-		pm_runtime_put(&pdev->dev);
-		return PTR_ERR(regmap);
+		ret = PTR_ERR(regmap);
+		goto err_put_rpm;
 	}
 
 	/*
@@ -7561,11 +7561,19 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
 	if (ret)
-		return ret;
+		goto err_put_rpm;
 
 	ret = qcom_cc_really_probe(pdev, &gcc_sc8280xp_desc, regmap);
+	if (ret)
+		goto err_put_rpm;
+
 	pm_runtime_put(&pdev->dev);
 
+	return 0;
+
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+
 	return ret;
 }
 
-- 
2.41.0

