Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82902757DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjGRNaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjGRN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:29:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFDF189;
        Tue, 18 Jul 2023 06:29:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C77061597;
        Tue, 18 Jul 2023 13:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DBEC433BC;
        Tue, 18 Jul 2023 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686984;
        bh=TWOyAxfNhR4md46HxCIq50axByCSHW3XcE6ta0uMwtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfHQkFwQfi8YLq8YSNNy7VDMP3T+yg5w9ohrxjGP//LfylrsN+lthlU2Hh2P1KjMA
         BANpdbpwXY5bLliAYJZm+8duVGx6quRWFzEOFNnxUqkxI/CCey3sCpsolTNo9bxxNr
         b+fLTE3fb9wbqs53vDk7Dp+UFSCeyLBqmwm6MH2sarUsP+iW6QKxa1F0hWASFYW1ZL
         Gq08MG0/Oqfc4vuISwo5IFyoxBoJTZwKJ7QvjWlQn2U0tBpSyWFRNxy7kbqBxtgoI1
         qrFjHyqEL/R/qb7ps+OtKjkKRXF3/FalLIkFl+ZPlejFHgBSRbtr1jbBO0Py7pxbCZ
         qckg15REayTWg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qLkm2-0005cF-0r;
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
Subject: [PATCH 7/8] clk: qcom: mss-sc7180: fix missing resume during probe
Date:   Tue, 18 Jul 2023 15:29:01 +0200
Message-ID: <20230718132902.21430-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718132902.21430-1-johan+linaro@kernel.org>
References: <20230718132902.21430-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Fixes: 8def929c4097 ("clk: qcom: Add modem clock controller driver for SC7180")
Cc: stable@vger.kernel.org      # 5.7
Cc: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/mss-sc7180.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/mss-sc7180.c b/drivers/clk/qcom/mss-sc7180.c
index 5a1407440662..d106bc65470e 100644
--- a/drivers/clk/qcom/mss-sc7180.c
+++ b/drivers/clk/qcom/mss-sc7180.c
@@ -87,11 +87,22 @@ static int mss_sc7180_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = qcom_cc_probe(pdev, &mss_sc7180_desc);
 	if (ret < 0)
-		return ret;
+		goto err_put_rpm;
+
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
+
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+
+	return ret;
 }
 
 static const struct dev_pm_ops mss_sc7180_pm_ops = {
-- 
2.41.0

