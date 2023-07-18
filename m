Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C28757D91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjGRN3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjGRN3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:29:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4034712F;
        Tue, 18 Jul 2023 06:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0B7561584;
        Tue, 18 Jul 2023 13:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2959DC433C7;
        Tue, 18 Jul 2023 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686984;
        bh=ybftpD7g3WllyIW9pg3KLmPM1vfHLNTqTCAzw/a2IB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDNNDLtfsjpkODkDMAy7Aw2aCb/OduEEX8D/AotWmoOwmXpci++Rg7kWJsOAVSFld
         h/pGOhveTb22/3EsQvE8mGrZPLZJpFg3uvLxKxUD79TU8TtChN1kS40G/DVBXYBU4Q
         3QQSq+E44QErxYPu9Z/fHZTAaW9xl5LCJdyCxui4TOIlLOqdMWuA9qPKzYbxgTarPp
         wT3+KtaRVb8mOmI/iTNi6BvEBQHlf9pU6lZZQt1u7r6IGzvDNo8GgCqDPePFpEJ5HG
         8ofugJ/lF3UTzis/Ruf5MaY176tzDH5Oke24hBukLEJ1wJ63FauHo2E+rO+LUPZax2
         c9qcS0tP8EI3w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qLkm1-0005c2-33;
        Tue, 18 Jul 2023 15:29:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 3/8] clk: qcom: dispcc-sm8550: fix runtime PM imbalance on probe errors
Date:   Tue, 18 Jul 2023 15:28:57 +0200
Message-ID: <20230718132902.21430-4-johan+linaro@kernel.org>
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
case regmap initialisation fails.

Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
Cc: stable@vger.kernel.org      # 6.3
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/dispcc-sm8550.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 1e5a11081860..b2fae9001ff2 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -1761,8 +1761,10 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 		return ret;
 
 	regmap = qcom_cc_map(pdev, &disp_cc_sm8550_desc);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto err_put_rpm;
+	}
 
 	clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 	clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
@@ -1777,9 +1779,16 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0));
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8550_desc, regmap);
+	if (ret)
+		goto err_put_rpm;
 
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

