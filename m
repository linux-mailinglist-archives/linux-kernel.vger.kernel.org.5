Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC017EF713
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346188AbjKQRiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346175AbjKQRiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:38:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35FC10EC;
        Fri, 17 Nov 2023 09:38:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649F4C433C7;
        Fri, 17 Nov 2023 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700242689;
        bh=ljA1LE+xModnv/rFyY3a5h9MWPkAGHDKsjJTHgO6Jy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQQoKGq4PKII8w2kZ9Ui7sAHGZegFoJcfpW/GHAyTwpuVMG9tnclFUbHWiSm/0jPS
         jMYGeQiD6IVDGIdocJqgUB3neWjKtoXx/KbOxLWxp5enmdF9uiKhkPKu2c5HP+fekB
         neRi7u3uTuPmobUwtQ6Q0yFjiS50Ho94SI11l2OcVaq8gG3fCLSTWM8i8PUp4azVm+
         zIfUGL5PYZsQAvD5C2KsZJcjrx9Nc1qsg0ggh+NelKSTzJkVHPANNlSlYHTpMww1W7
         UbTRjGgtlFesn2oDP0kRLvHHElGpuilAYHVBdtAp3q0oTwqKEzDoa20KBEmYKMdTvf
         GLm2FKbJ6dhpA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r42nF-0005Vq-0f;
        Fri, 17 Nov 2023 18:38:13 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH 1/3] USB: dwc3: qcom: fix resource leaks on probe deferral
Date:   Fri, 17 Nov 2023 18:36:48 +0100
Message-ID: <20231117173650.21161-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117173650.21161-1-johan+linaro@kernel.org>
References: <20231117173650.21161-1-johan+linaro@kernel.org>
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

The driver needs to deregister and free the newly allocated dwc3 core
platform device on ACPI probe errors (e.g. probe deferral) and on driver
unbind but instead it leaked those resources while erroneously dropping
a reference to the parent platform device which is still in use.

For OF probing the driver takes a reference to the dwc3 core platform
device which has also always been leaked.

Fix the broken ACPI tear down and make sure to drop the dwc3 core
reference for both OF and ACPI.

Fixes: 8fd95da2cfb5 ("usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()")
Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Cc: stable@vger.kernel.org      # 4.18
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lee Jones <lee@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3de43df6bbe8..00c3021b43ce 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -758,6 +758,7 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 	if (!qcom->dwc3) {
 		ret = -ENODEV;
 		dev_err(dev, "failed to get dwc3 platform device\n");
+		of_platform_depopulate(dev);
 	}
 
 node_put:
@@ -899,7 +900,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to register DWC3 Core, err=%d\n", ret);
-		goto depopulate;
+		goto clk_disable;
 	}
 
 	ret = dwc3_qcom_interconnect_init(qcom);
@@ -934,7 +935,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (np)
 		of_platform_depopulate(&pdev->dev);
 	else
-		platform_device_put(pdev);
+		platform_device_del(qcom->dwc3);
+	platform_device_put(qcom->dwc3);
 clk_disable:
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
@@ -957,7 +959,8 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	if (np)
 		of_platform_depopulate(&pdev->dev);
 	else
-		platform_device_put(pdev);
+		platform_device_del(qcom->dwc3);
+	platform_device_put(qcom->dwc3);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
-- 
2.41.0

