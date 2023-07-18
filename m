Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21313757D95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjGRN35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGRN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:29:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D0D19F;
        Tue, 18 Jul 2023 06:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03BC361591;
        Tue, 18 Jul 2023 13:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EBEC433B9;
        Tue, 18 Jul 2023 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686984;
        bh=ecVYnAz0cWZ3OaKV2gjx4miXZSzU9O9arS/8lcFdJBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QST1OR2s6blNS/2Z6esD3ottRlgKKnvm6dcfBikoR9Vjx+4tINQvUT60oAcSE/YmJ
         R3c3XF6/Ie0aFXBIk9b2mGFsYdGWWzQEdrU343AGJPRxW0NdqxI9Eyxv+u8TtETtCb
         GKNvs2S3o0nRl9b6oOqaBso9mwIHsOvPtnCBl5JStVbo4BmY0yQtM1LSbSjdz/kpDE
         mTvavJIpgzpRo1RBqHPqVaj5UIXsXqa4RF64c/xwOhdEeLqUOvA2WpGolCywQ3Jad/
         QfpY9lS5LhFq0WNFpQGPAuXbf3iqB3lkKEVjxvRFlWJw8KA17p5fjT+z/x9/mUFzGP
         NSxTPRuuBE9pQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qLkm2-0005c8-0K;
        Tue, 18 Jul 2023 15:29:54 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH 5/8] clk: qcom: lpasscc-sc7280: fix missing resume during probe
Date:   Tue, 18 Jul 2023 15:28:59 +0200
Message-ID: <20230718132902.21430-6-johan+linaro@kernel.org>
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

Drivers that enable runtime PM must make sure that the controller is
runtime resumed before accessing its registers to prevent the power
domain from being disabled.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
Cc: stable@vger.kernel.org      # 5.16
Cc: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/lpasscc-sc7280.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index 0df2b29e95e3..e6b815aec46a 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -118,9 +118,13 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 	ret = pm_clk_add(&pdev->dev, "iface");
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to acquire iface clock\n");
-		goto destroy_pm_clk;
+		goto err_destroy_pm_clk;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		goto err_destroy_pm_clk;
+
 	if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
 		lpass_regmap_config.name = "qdsp6ss";
 		lpass_regmap_config.max_register = 0x3f;
@@ -128,7 +132,7 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 
 		ret = qcom_cc_probe_by_index(pdev, 0, desc);
 		if (ret)
-			goto destroy_pm_clk;
+			goto err_put_rpm;
 	}
 
 	lpass_regmap_config.name = "top_cc";
@@ -137,11 +141,15 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 
 	ret = qcom_cc_probe_by_index(pdev, 1, desc);
 	if (ret)
-		goto destroy_pm_clk;
+		goto err_put_rpm;
+
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
 
-destroy_pm_clk:
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+err_destroy_pm_clk:
 	pm_clk_destroy(&pdev->dev);
 
 	return ret;
-- 
2.41.0

