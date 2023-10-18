Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4447CDEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbjJRONV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344918AbjJROMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:12:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AED137;
        Wed, 18 Oct 2023 07:12:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D57C433C9;
        Wed, 18 Oct 2023 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638356;
        bh=JWEf90H0pNK8AbCNDAoueXopIud5IbmnlbfDPhWUca8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2Q4ehWB7BiYfpahWyJAJXl2DvDD7qPyM5BnKVSIllqj0/HCCKtTdX/vcsFb8Dnav
         hiwHnm2uNHppKlNnPlswtGgp+1j+JjSzDuCzvWEJjDiDfNL4pvVn9JkyKeKQ3u0QY4
         mwpIdA0zRvZR1FnFTHhu814UkQm3VY+Gfoy8c9PM4hxQvjrjYPp0HYCZiHodYM8VPB
         krQS638mL24BLi9W+03CcY3kvwM2sK1EAXgzvwPnitIpb1ovBDPnGgqu0UNr6CPGCb
         G8aEMn8fYOLheE/3w//aqaUI7q7uwm40s8/6VKE1FAjwwlYBafUcSnheVkq75bcVHp
         NQLUlqwAnw3yA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, wg@grandegger.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mailhol.vincent@wanadoo.fr,
        socketcan@hartkopp.net, ruanjinjie@huawei.com,
        u.kleine-koenig@pengutronix.de, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 16/31] can: flexcan: remove the auto stop mode for IMX93
Date:   Wed, 18 Oct 2023 10:11:33 -0400
Message-Id: <20231018141151.1334501-16-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

[ Upstream commit 63ead535570f13d0e06fda3f2d020c8f5394e998 ]

IMX93 A0 chip involve the internal q-channel handshake in LPCG and
CCM to automatically handle the Flex-CAN IPG STOP signal. Only after
FLEX-CAN enter stop mode then can support the self-wakeup feature.
But meet issue when do the continue system PM stress test. When config
the CAN as wakeup source, the first time after system suspend, any data
on CAN bus can wakeup the system, this is as expect. But the second time
when system suspend, data on CAN bus can't wakeup the system. If continue
this test, we find in odd time system enter suspend, CAN can wakeup the
system, but in even number system enter suspend, CAN can't wakeup the
system. IC find a bug in the auto stop mode logic, and can't fix it easily.
So for the new imx93 A1, IC drop the auto stop mode and involve the
GPR to support stop mode (used before). IC define a bit in GPR which can
trigger the IPG STOP signal to Flex-CAN, let it go into stop mode.
And NXP claim to drop IMX93 A0, and only support IMX93 A1. So this patch
remove the auto stop mode, and add flag FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR
to imx93.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://lore.kernel.org/all/20230726112458.3524165-2-haibo.chen@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan/flexcan-core.c | 46 ++++++++------------------
 drivers/net/can/flexcan/flexcan.h      |  2 --
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ff0fc18baf133..d8be69f4a0c3f 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -348,7 +348,7 @@ static struct flexcan_devtype_data fsl_imx8mp_devtype_data = {
 static struct flexcan_devtype_data fsl_imx93_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
-		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_AUTO_STOP_MODE |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR |
 		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
@@ -544,11 +544,6 @@ static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR) {
 		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 				   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
-	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE) {
-		/* For the auto stop mode, software do nothing, hardware will cover
-		 * all the operation automatically after system go into low power mode.
-		 */
-		return 0;
 	}
 
 	return flexcan_low_power_enter_ack(priv);
@@ -574,12 +569,6 @@ static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
 	reg_mcr &= ~FLEXCAN_MCR_SLF_WAK;
 	priv->write(reg_mcr, &regs->mcr);
 
-	/* For the auto stop mode, hardware will exist stop mode
-	 * automatically after system go out of low power mode.
-	 */
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-		return 0;
-
 	return flexcan_low_power_exit_ack(priv);
 }
 
@@ -1994,13 +1983,18 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 		ret = flexcan_setup_stop_mode_scfw(pdev);
 	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR)
 		ret = flexcan_setup_stop_mode_gpr(pdev);
-	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-		ret = 0;
 	else
 		/* return 0 directly if doesn't support stop mode feature */
 		return 0;
 
-	if (ret)
+	/* If ret is -EINVAL, this means SoC claim to support stop mode, but
+	 * dts file lack the stop mode property definition. For this case,
+	 * directly return 0, this will skip the wakeup capable setting and
+	 * will not block the driver probe.
+	 */
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
 		return ret;
 
 	device_set_wakeup_capable(&pdev->dev, true);
@@ -2320,16 +2314,8 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		if (device_may_wakeup(device)) {
+		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, true);
-			/* For auto stop mode, need to keep the clock on before
-			 * system go into low power mode. After system go into
-			 * low power mode, hardware will config the flexcan into
-			 * stop mode, and gate off the clock automatically.
-			 */
-			if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-				return 0;
-		}
 
 		err = pm_runtime_force_suspend(device);
 		if (err)
@@ -2347,15 +2333,9 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		/* For the wakeup in auto stop mode, no need to gate on the
-		 * clock here, hardware will do this automatically.
-		 */
-		if (!(device_may_wakeup(device) &&
-		      priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)) {
-			err = pm_runtime_force_resume(device);
-			if (err)
-				return err;
-		}
+		err = pm_runtime_force_resume(device);
+		if (err)
+			return err;
 
 		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, false);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 91402977780b2..025c3417031f4 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -68,8 +68,6 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
 /* Device supports RX via FIFO */
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
-/* auto enter stop mode to support wakeup */
-#define FLEXCAN_QUIRK_AUTO_STOP_MODE BIT(17)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
-- 
2.40.1

