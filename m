Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFAE7EF716
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346195AbjKQRiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346177AbjKQRiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:38:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32DE10E0;
        Fri, 17 Nov 2023 09:38:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A93C433C8;
        Fri, 17 Nov 2023 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700242689;
        bh=sDWfI3dfDm/XeUFimA2vIUoCw4maHSxqpQcHwRZvnSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZN2wNnnk3BLjE4zbhrKriuJksBjzbf+xiebRKjnCpC0d3WWBLcvR1uK6QDOAlZ6Xr
         RUxdKJIHybOW+/mYS3foJCR4yhiVV94gDS96rYESDbdeELsnw8vFsxDxHFLxS9LRMH
         qGc+9ZT0p0vgWr8zRYuXpZMudUGCL4tCukmM1wUwRKLovKxQnx1pciCew7XXFAXra4
         QpWvCV8/zcFgkLhPWK57lw2OmZXYmfpYufBRVVtLeIWQTDWfSArgwQW0A9XDaREv64
         vnE0FE80NEGld3vr6D+8EdHkEYobniucaqA6wRuji3j2+5dVe/a6/r4jjJWvAD4Bat
         1hVIuVxe9oHKw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r42nF-0005Vs-0v;
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
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/3] USB: dwc3: qcom: fix software node leak on probe errors
Date:   Fri, 17 Nov 2023 18:36:49 +0100
Message-ID: <20231117173650.21161-3-johan+linaro@kernel.org>
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

Make sure to remove the software node also on (ACPI) probe errors to
avoid leaking the underlying resources.

Note that the software node is only used for ACPI probe so the driver
unbind tear down is updated to match probe.

Fixes: 8dc6e6dd1bee ("usb: dwc3: qcom: Constify the software node")
Cc: stable@vger.kernel.org      # 5.12
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 00c3021b43ce..0703f9b85cda 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -932,10 +932,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 interconnect_exit:
 	dwc3_qcom_interconnect_exit(qcom);
 depopulate:
-	if (np)
+	if (np) {
 		of_platform_depopulate(&pdev->dev);
-	else
+	} else {
+		device_remove_software_node(&qcom->dwc3->dev);
 		platform_device_del(qcom->dwc3);
+	}
 	platform_device_put(qcom->dwc3);
 clk_disable:
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
@@ -955,11 +957,12 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i;
 
-	device_remove_software_node(&qcom->dwc3->dev);
-	if (np)
+	if (np) {
 		of_platform_depopulate(&pdev->dev);
-	else
+	} else {
+		device_remove_software_node(&qcom->dwc3->dev);
 		platform_device_del(qcom->dwc3);
+	}
 	platform_device_put(qcom->dwc3);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
-- 
2.41.0

