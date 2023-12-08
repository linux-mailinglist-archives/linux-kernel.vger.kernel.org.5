Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B651580A401
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjLHM4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHM4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:56:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F1410FC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:56:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3053AC433C7;
        Fri,  8 Dec 2023 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702040217;
        bh=OSuX71e1jZxpO9PhB7QCT9A4hWvPxJ7NxD/Rhqsq+SI=;
        h=From:To:Cc:Subject:Date:From;
        b=BGURX3CkaHSVViOG1V5VQDRQ5+esvsuA8SRZodR/7mOYi2OmZY0YTIIig2EWe/08v
         v3E1n4bWGqpOHyGi+5jzU6i0m8N4hrKNGX8/jgWPEa4q29TEe55s8Af8NLKvRDtRl6
         IuMR2bB3F4SBgvhR2Blk++JH+Fb3W+lZTx5IJ6yyEGeYqJmsoJqfXVq5eICwi6k4vG
         pzC1qMsDRT+WibmV/PD/CXvAXQwbGsCpEL6yZCBgZDimbODte05HFFP7mdLr9a2vl7
         KwhTMc3b6xr1XVFMZYfcKGYgexXgGXNwj/hoORjPg4L+JNDDXutQVx0SMl+7q5dkFN
         iW8SpZ/UMaNkA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rBaQM-0002gi-2N;
        Fri, 08 Dec 2023 13:57:47 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] soc: qcom: pmic_glink: disable UCSI on sc8280xp
Date:   Fri,  8 Dec 2023 13:57:30 +0100
Message-ID: <20231208125730.10323-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
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

Enabling UCSI on sc8280xp and the Lenovo ThinkPad X13s in particular
results in a number of errors and timeouts during boot:

[    9.012421] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-95)
[   14.047379] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: timeout waiting for UCSI sync write response
[   14.050708] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-110)
[   20.192382] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: timeout waiting for UCSI sync write response
[   20.192542] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-110)

Disable UCSI on sc8280xp until this has been resolved.

Fixes: 4db09e7b967b ("soc: qcom: pmic_glink: enable UCSI by default)
Link: https://lore.kernel.org/r/ZXL5jvDHr-MuxMoz@hovoldconsulting.com
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soc/qcom/pmic_glink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 71d8901a9389..511aa40842a1 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -342,6 +342,7 @@ static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT
 
 static const struct of_device_id pmic_glink_of_match[] = {
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = &pmic_glink_sc8180x_client_mask },
+	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &pmic_glink_sc8180x_client_mask },
 	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_sm8450_client_mask },
 	{}
 };
-- 
2.41.0

