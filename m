Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3DB77A7A2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjHMPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjHMPti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:49:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBA4E73;
        Sun, 13 Aug 2023 08:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F1CD6308C;
        Sun, 13 Aug 2023 15:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964C5C433CA;
        Sun, 13 Aug 2023 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941778;
        bh=0Ou6Loj81pG8f/0du1T0D4rBXcBBgFyKIYwscWLgxfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCDcYt86lc+mKx7S3RgEKwLghuBEe07On5ViwBJ3c7zIeRzsxlgUKxLc3AfsVCEwp
         xQ06ygvaiACqkWmhlErjn94+gOTNFBYaw/+qhl/mgB8dAoJ7QIdNJZcgbWT80zKR1w
         jvmlg/VQ0/7lbfD7522hSlnCMdkk+/KSDDCFZ/FAmmh5oEpu2riUd9oCgnT3X1jhbL
         XpQennkWiVJQK5xJls0nk/ZNrxLJJayh3MSl8zcR4BzQ56Gc37cTkYRSL8Dz/CO1Sz
         CEeqOvSeb4Zy5OHNZwceEypblcQP79uL7NYwvI7we2JObxIVFKRvb2miPdo5gZ2NzV
         lzkaZFQ43gJMw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 02/54] phy: qcom-snps-femto-v2: keep cfg_ahb_clk enabled during runtime suspend
Date:   Sun, 13 Aug 2023 11:48:41 -0400
Message-Id: <20230813154934.1067569-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrien Thierry <athierry@redhat.com>

[ Upstream commit 45d89a344eb46db9dce851c28e14f5e3c635c251 ]

In the dwc3 core, both system and runtime suspend end up calling
dwc3_suspend_common(). From there, what happens for the PHYs depends on
the USB mode and whether the controller is entering system or runtime
suspend.

HOST mode:
  (1) system suspend on a non-wakeup-capable controller

  The [1] if branch is taken. dwc3_core_exit() is called, which ends up
  calling phy_power_off() and phy_exit(). Those two functions decrease the
  PM runtime count at some point, so they will trigger the PHY runtime
  sleep (assuming the count is right).

  (2) runtime suspend / system suspend on a wakeup-capable controller

  The [1] branch is not taken. dwc3_suspend_common() calls
  phy_pm_runtime_put_sync(). Assuming the ref count is right, the PHY
  runtime suspend op is called.

DEVICE mode:
  dwc3_core_exit() is called on both runtime and system sleep
  unless the controller is already runtime suspended.

OTG mode:
  (1) system suspend : dwc3_core_exit() is called

  (2) runtime suspend : do nothing

In host mode, the code seems to make a distinction between 1) runtime
sleep / system sleep for wakeup-capable controller, and 2) system sleep
for non-wakeup-capable controller, where phy_power_off() and phy_exit()
are only called for the latter. This suggests the PHY is not supposed to
be in a fully powered-off state for runtime sleep and system sleep for
wakeup-capable controller.

Moreover, downstream, cfg_ahb_clk only gets disabled for system suspend.
The clocks are disabled by phy->set_suspend() [2] which is only called
in the system sleep path through dwc3_core_exit() [3].

With that in mind, don't disable the clocks during the femto PHY runtime
suspend callback. The clocks will only be disabled during system suspend
for non-wakeup-capable controllers, through dwc3_core_exit().

[1] https://elixir.bootlin.com/linux/v6.4/source/drivers/usb/dwc3/core.c#L1988
[2] https://git.codelinaro.org/clo/la/kernel/msm-5.4/-/blob/LV.AU.1.2.1.r2-05300-gen3meta.0/drivers/usb/phy/phy-msm-snps-hs.c#L524
[3] https://git.codelinaro.org/clo/la/kernel/msm-5.4/-/blob/LV.AU.1.2.1.r2-05300-gen3meta.0/drivers/usb/dwc3/core.c#L1915

Signed-off-by: Adrien Thierry <athierry@redhat.com>
Link: https://lore.kernel.org/r/20230629144542.14906-2-athierry@redhat.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index 6c237f3cc66db..3335480fc395a 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -165,22 +165,13 @@ static int qcom_snps_hsphy_suspend(struct qcom_snps_hsphy *hsphy)
 					   0, USB2_AUTO_RESUME);
 	}
 
-	clk_disable_unprepare(hsphy->cfg_ahb_clk);
 	return 0;
 }
 
 static int qcom_snps_hsphy_resume(struct qcom_snps_hsphy *hsphy)
 {
-	int ret;
-
 	dev_dbg(&hsphy->phy->dev, "Resume QCOM SNPS PHY, mode\n");
 
-	ret = clk_prepare_enable(hsphy->cfg_ahb_clk);
-	if (ret) {
-		dev_err(&hsphy->phy->dev, "failed to enable cfg ahb clock\n");
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
2.40.1

