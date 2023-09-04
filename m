Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C8A7911DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352401AbjIDHPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352387AbjIDHPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:15:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6312E;
        Mon,  4 Sep 2023 00:14:59 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d7eed15ad69so953299276.1;
        Mon, 04 Sep 2023 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693811698; x=1694416498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asIRh9YewMccFyepghcfx0oKFSEdE7jjQF3+1szicrk=;
        b=XJL9GAJdw0GeEh+M5mdA3J2Z9y6j3fnDsdM69Uvc6N23fcYUDMRNwVlPcCaVWfe6aU
         HvRq3GnUcU89qV/Sn4P2bg5BIJ1ttUSKMe12fxziHPYx4nh2HUdJCUzKBVOdXlH1xu/4
         BFmZcnIhdU4doOw8jG0lbqSEmHDtrEGc9XjB+9sXer8/2fnuTFkBPpUXn08tso4po9xt
         S6qhM30FjYCnI6JFgZNRPjkJ5TIFquXJpKeMVdSO7x2uiPtcNh3QEg1VX6Kgowdkeg2T
         pEe8rt1hWEvhpsfEMoVNuhHZ/ufOW5eJB6h1btqG3cwdw6tl9ApfbFTgL9XUiIWUphDE
         M7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693811698; x=1694416498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asIRh9YewMccFyepghcfx0oKFSEdE7jjQF3+1szicrk=;
        b=NtZKfSvDl5CgEdmN8Y1j394HKMpohyX5tq2aQHQMUngEWJmRS3bTntQuRHGcLdIUDo
         MjVRwpb3vlbgz0Nzb/ET0mnLQSirEBV3KfjVp4tHbNMVjg1TFVtb06zgwZQAJEPsnNz1
         pNp2rQW5S4/G8Ubuc5P1rFm7QJQQ81swAAI394OhPDCCpnVg3Yy89a21XhRszaQOUND7
         O3PXurZBpeDSaq0hqPCFnrs4avbvjYDzz9FM+bWdNIhW5CU4KfYNWSp5uLNA6yp49nvi
         zBOceaxtL3ItVbNeJcsyGLex95XwBILRHyyXNP5QxHk4WclCm+gMyE1GMO1LuwbmFmdL
         gsOQ==
X-Gm-Message-State: AOJu0YyrFc5YYNRAT9NGGbQ6FmpyZKfcQtEll44aWE3dF8WwnWqjob+P
        s1rZkJi9AjbYHCoHhxAoLUcSnN90sWZpXw==
X-Google-Smtp-Source: AGHT+IEHXRYa+aKRNqfEoyrjE5xNeCre35og6i/DAu09DwlkGOEbJYhYwr+bPi6bXOYddUN4g4+NdA==
X-Received: by 2002:a25:d481:0:b0:d1a:65c9:d98f with SMTP id m123-20020a25d481000000b00d1a65c9d98fmr10888578ybf.56.1693811698529;
        Mon, 04 Sep 2023 00:14:58 -0700 (PDT)
Received: from PLK-D0032.dom2.local ([157.25.98.166])
        by smtp.gmail.com with ESMTPSA id 82-20020a251955000000b00d74b144004bsm2207565ybz.12.2023.09.04.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:14:58 -0700 (PDT)
From:   Tomasz Rostanski <tomasz.rostanski@gmail.com>
X-Google-Original-From: Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>
Cc:     stable@vger.kernel.org, Sean Anderson <sean.anderson@seco.com>,
        Robert Hancock <robert.hancock@calian.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] usb: dwc3: Get clocks individually
Date:   Mon,  4 Sep 2023 09:14:23 +0200
Message-ID: <20230904071432.32309-2-tomasz.rostanski@thalesgroup.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904071432.32309-1-tomasz.rostanski@thalesgroup.com>
References: <20230904071432.32309-1-tomasz.rostanski@thalesgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

Instead of grabbing all clocks in bulk, grab them individually. This will
allow us to get the frequency or otherwise deal with discrete clocks. This
may break some platforms if they use a clock which doesn't use one of the
documented names.

Reviewed-by: Robert Hancock <robert.hancock@calian.com>
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Link: https://lore.kernel.org/r/20220127200636.1456175-3-sean.anderson@seco.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c | 64 ++++++++++++++++++++++++++++++++---------
 drivers/usb/dwc3/core.h | 10 ++++---
 2 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7908c151b95d..9635c915e2f7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -753,6 +753,38 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_clk_enable(struct dwc3 *dwc)
+{
+	int ret;
+
+	ret = clk_prepare_enable(dwc->bus_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dwc->ref_clk);
+	if (ret)
+		goto disable_bus_clk;
+
+	ret = clk_prepare_enable(dwc->susp_clk);
+	if (ret)
+		goto disable_ref_clk;
+
+	return 0;
+
+disable_ref_clk:
+	clk_disable_unprepare(dwc->ref_clk);
+disable_bus_clk:
+	clk_disable_unprepare(dwc->bus_clk);
+	return ret;
+}
+
+static void dwc3_clk_disable(struct dwc3 *dwc)
+{
+	clk_disable_unprepare(dwc->susp_clk);
+	clk_disable_unprepare(dwc->ref_clk);
+	clk_disable_unprepare(dwc->bus_clk);
+}
+
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
 	dwc3_event_buffers_cleanup(dwc);
@@ -767,7 +799,7 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
 }
 
@@ -1614,25 +1646,31 @@ static int dwc3_probe(struct platform_device *pdev)
 		return PTR_ERR(dwc->reset);
 
 	if (dev->of_node) {
-		ret = devm_clk_bulk_get_all(dev, &dwc->clks);
-		if (ret == -EPROBE_DEFER)
-			return ret;
 		/*
 		 * Clocks are optional, but new DT platforms should support all
 		 * clocks as required by the DT-binding.
 		 */
-		if (ret < 0)
-			dwc->num_clks = 0;
-		else
-			dwc->num_clks = ret;
-
+		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
+		if (IS_ERR(dwc->bus_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+					     "could not get bus clock\n");
+
+		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
+		if (IS_ERR(dwc->ref_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+					     "could not get ref clock\n");
+
+		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
+		if (IS_ERR(dwc->susp_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+					     "could not get suspend clock\n");
 	}
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
+	ret = dwc3_clk_enable(dwc);
 	if (ret)
 		goto assert_reset;
 
@@ -1723,7 +1761,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 	pm_runtime_put_noidle(dev);
 disable_clks:
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc->num_clks, dwc->clks);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
@@ -1773,7 +1811,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
+	ret = dwc3_clk_enable(dwc);
 	if (ret)
 		goto assert_reset;
 
@@ -1784,7 +1822,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	return 0;
 
 disable_clks:
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 968608bd98e3..1e5ef1c512fb 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -967,8 +967,9 @@ struct dwc3_scratchpad_array {
  * @eps: endpoint array
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
- * @clks: array of clocks
- * @num_clks: number of clocks
+ * @bus_clk: clock for accessing the registers
+ * @ref_clk: reference clock
+ * @susp_clk: clock used when the SS phy is in low power (S3) state
  * @reset: reset control
  * @regs: base address for our registers
  * @regs_size: address space size
@@ -1127,8 +1128,9 @@ struct dwc3 {
 	struct usb_gadget	*gadget;
 	struct usb_gadget_driver *gadget_driver;
 
-	struct clk_bulk_data	*clks;
-	int			num_clks;
+	struct clk		*bus_clk;
+	struct clk		*ref_clk;
+	struct clk		*susp_clk;
 
 	struct reset_control	*reset;
 
-- 
2.41.0

