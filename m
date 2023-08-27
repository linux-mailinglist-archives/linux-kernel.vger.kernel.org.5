Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6878A290
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjH0WR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjH0WRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:17:01 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EE7127;
        Sun, 27 Aug 2023 15:16:58 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E92D8FF804;
        Sun, 27 Aug 2023 22:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693174617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIrssUFHb/fsBM0yYCwVRgwSBV5otAGYvYhv5InKtoo=;
        b=Y9YMzG76crayhCiu70bc2wCVQCzI27l0nyA4QPaCRhEFsWHZeH3uOqj+JfhPq7dNGPwle+
        JaJDqBCMMRvSGsVOUtyn9FvsMJZNfFWI7GlYFkphl8LjRKTicx3w3Cnf4iYI+aqR9+tMgT
        felY8uA+qq4mWO6FhWrQHYk5wTYFmvU+tmLBW+JtF+vbFqg60kNNzq4tgc6Exy16rzNrUD
        suZZ7yPbMDSx52GAewfhNQ+W/Ms1F1VdFVoCVIWyMgoRwnPQ3c+8Swa/8XIuLnvP+LBgna
        q2TQwtvoC7sj7gGM3/BySKVVSSS6vlGyEwnIGVMmDq/Md23xkTPItNAjq3mELA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] rtc: twl: remove unnecessary messages
Date:   Mon, 28 Aug 2023 00:16:41 +0200
Message-ID: <20230827221643.544259-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230827221643.544259-1-alexandre.belloni@bootlin.com>
References: <20230827221643.544259-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The RTC core already prints a message when the RTC is registered and when
registering fails, it is not necessary to have more in the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-twl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index f8f0d774a06e..13f8ce08243c 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -555,7 +555,6 @@ static int twl_rtc_probe(struct platform_device *pdev)
 			REG_INT_MSK_STS_A);
 	}
 
-	dev_info(&pdev->dev, "Enabling TWL-RTC\n");
 	ret = twl_rtc_write_u8(twl_rtc, BIT_RTC_CTRL_REG_STOP_RTC_M,
 			       REG_RTC_CTRL_REG);
 	if (ret < 0)
@@ -577,11 +576,8 @@ static int twl_rtc_probe(struct platform_device *pdev)
 
 	twl_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 					&twl_rtc_ops, THIS_MODULE);
-	if (IS_ERR(twl_rtc->rtc)) {
-		dev_err(&pdev->dev, "can't register RTC device, err %ld\n",
-			PTR_ERR(twl_rtc->rtc));
+	if (IS_ERR(twl_rtc->rtc))
 		return PTR_ERR(twl_rtc->rtc);
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					twl_rtc_interrupt,
-- 
2.41.0

