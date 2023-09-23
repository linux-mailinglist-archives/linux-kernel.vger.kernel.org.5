Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB87AC4E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjIWTmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIWTmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:42:08 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77860AB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:41:59 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RtKK05YBczDJ;
        Sat, 23 Sep 2023 21:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1695498116; bh=kFsKirDvyE7bdimLhfZJhpSM+ljGh33ev81Eebpilkw=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=S8EWylnI32XiWoR2ljwjjzelXKDlOubs3XTeFwGSX3ztDdWvxTh5fULLKkZruaI1y
         8o8XD0JbSWC3/IgcpPK+oBLru+W4F7sPgoorM5lYqlxWlRmiS3S9ROuXlHlYyQxB2v
         wI6SyL+T8YznI+IzoFyKz0+FLEA+b8YrA6XuGO0udfJDfbsBtw2qhhjwnyv+YW1kSE
         xcgSJGCTZCA7+iyFRHIyArziN+ITt9By1XkJDQ+5lshxWWEwbx79xh+B6D+3pSWWk6
         sLc16FfYwZO2Q0DcjHxO+XgROmY31FW2IrSrdw9JZlwFKj2OjO3p4slfXXkVMNXvyv
         Cu9GtZW2690kA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sat, 23 Sep 2023 21:41:56 +0200
Message-Id: <a1d8233f153bdd9f18661f33497dcff95bf217fc.1695497666.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1695497666.git.mirq-linux@rere.qmqm.pl>
References: <cover.1695497666.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/3] usb: chipidea: tegra: Consistently use dev_err_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all error exits from probe() to dev_err_probe().

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 8e78bf643e25..2cc305803217 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -293,14 +293,12 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	usb->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);
 	if (IS_ERR(usb->phy))
 		return dev_err_probe(&pdev->dev, PTR_ERR(usb->phy),
-				     "failed to get PHY\n");
+				     "failed to get PHY");
 
 	usb->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(usb->clk)) {
-		err = PTR_ERR(usb->clk);
-		dev_err(&pdev->dev, "failed to get clock: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(usb->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(usb->clk),
+				     "failed to get clock");
 
 	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
 	if (err)
@@ -316,7 +314,7 @@ static int tegra_usb_probe(struct platform_device *pdev)
 
 	err = tegra_usb_reset_controller(&pdev->dev);
 	if (err) {
-		dev_err(&pdev->dev, "failed to reset controller: %d\n", err);
+		dev_err_probe(&pdev->dev, err, "failed to reset controller");
 		goto fail_power_off;
 	}
 
@@ -347,8 +345,8 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	usb->dev = ci_hdrc_add_device(&pdev->dev, pdev->resource,
 				      pdev->num_resources, &usb->data);
 	if (IS_ERR(usb->dev)) {
-		err = PTR_ERR(usb->dev);
-		dev_err(&pdev->dev, "failed to add HDRC device: %d\n", err);
+		err = dev_err_probe(&pdev->dev, PTR_ERR(usb->dev),
+				    "failed to add HDRC device");
 		goto phy_shutdown;
 	}
 
-- 
2.39.2

