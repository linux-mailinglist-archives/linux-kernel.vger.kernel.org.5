Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE6B7F1843
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjKTQQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKTQQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:16:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95630E7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:16:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC8FC433C8;
        Mon, 20 Nov 2023 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700496979;
        bh=cp9VBVhfKB1W6Ax326oY4P4qaJJhzvjhHmBuHx1mN3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOZXQtegp1iz8hawwcJUqLwUvss7v0jB4bYt2liRYvbs73NbGkLN7lGl7ot2Hx0xz
         YGfdqVAZ4QNU8a08GLx6DHxUd1nbYkmNjaaXhc2vWfZefNx3cGkVFSNa/PtEk8vkTR
         keCxY8TrkyjVCt3rlhTkyyIubDu9n6eGDrNKZynJYMHvdtbt3O4NTQsHkFauyb9egy
         ErbMrqLb8xiBUhBT8w9+EVdJ7HVtT5vvd6eKJ5fs0FuTCq2P3Zf6XOlyZkZ7oihlHD
         KcgK+2wCpKwRv7BdeQ4Yga3zbBt8LIcClKUQi0lJPgUIK6icBwnLt5t+IJcLlPzBTY
         9gvfh/VboAHxA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r56wm-0001vq-2D;
        Mon, 20 Nov 2023 17:16:28 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/3] USB: dwc3: qcom: simplify wakeup interrupt setup
Date:   Mon, 20 Nov 2023 17:16:07 +0100
Message-ID: <20231120161607.7405-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120161607.7405-1-johan+linaro@kernel.org>
References: <20231120161607.7405-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the IRQF_NO_AUTOEN irq flag when requesting the wakeup interrupts
instead of setting it separately.

No functional change intended.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 82544374110b..fdf6d5d3c2ad 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -546,10 +546,9 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 				pdata ? pdata->hs_phy_irq_index : -1);
 	if (irq > 0) {
 		/* Keep wakeup interrupts disabled until suspend */
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					"qcom_dwc3 HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
@@ -561,10 +560,9 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
 				pdata ? pdata->dp_hs_phy_irq_index : -1);
 	if (irq > 0) {
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					"qcom_dwc3 DP_HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
@@ -576,10 +574,9 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
 				pdata ? pdata->dm_hs_phy_irq_index : -1);
 	if (irq > 0) {
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					"qcom_dwc3 DM_HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
@@ -591,10 +588,9 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
 				pdata ? pdata->ss_phy_irq_index : -1);
 	if (irq > 0) {
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					"qcom_dwc3 SS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
-- 
2.41.0

