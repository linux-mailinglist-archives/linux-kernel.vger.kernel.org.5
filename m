Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E448B7CDEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbjJRONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344931AbjJROMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:12:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7405411B;
        Wed, 18 Oct 2023 07:12:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FE9C433C8;
        Wed, 18 Oct 2023 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638350;
        bh=SZ/JnfUGBRzyGmQDn/UNvhmvUCg0MK1vMdDoCyu18EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxHnMuKu71DLxgEVB0OcKencH2yuelWkCuwapmF9IStb56KAIhg2EPS4bTYmtMyDa
         hGxG6+vm4JfiC2k0XAc2u72Fh5ffz2Sj8myjMTekWFGI8yVe9Fx1gKtj8HFOkS6UMA
         5fK6fleBHXWb87c16pokx5HB1qLQlnjsvZMdS7UvALLDGisiKUtvO87hxBBZBpWlc2
         h2lbjOQI/1Xo/i6kxTWU3LE/fNdmpX0JjggRgikTKjsk9Jt7DOJGOouMuLyciQ8c1e
         UN3Nh/O1s7jbupV3ki83STVmvHcBux+ouiuNX7xnMV8JBB+7go97PUE28OHqgOT+P/
         JyxQalPd8+thQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, peng.fan@nxp.com,
        alexander.stein@ew.tq-group.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, sherry.sun@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 15/31] arm64: dts: imx93: add the Flex-CAN stop mode by GPR
Date:   Wed, 18 Oct 2023 10:11:32 -0400
Message-Id: <20231018141151.1334501-15-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

[ Upstream commit 23ed2be5404da7cee6a519fa69bf22d0f69da4e4 ]

imx93 A0 chip use the internal q-channel handshake signal in LPCG
and CCM to automatically handle the Flex-CAN stop mode. But this
method meet issue when do the system PM stress test. IC can't fix
it easily. So in the new imx93 A1 chip, IC drop this method, and
involve back the old way，use the GPR method to trigger the Flex-CAN
stop mode signal. Now NXP claim to drop imx93 A0, and only support
imx93 A1. So here add the stop mode through GPR.

This patch also fix a typo for aonmix_ns_gpr.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://lore.kernel.org/all/20230726112458.3524165-1-haibo.chen@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 1d8dd14b65cfa..2a9b89bf52698 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -146,7 +146,7 @@ aips1: bus@44000000 {
 			#size-cells = <1>;
 			ranges;
 
-			anomix_ns_gpr: syscon@44210000 {
+			aonmix_ns_gpr: syscon@44210000 {
 				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
 				reg = <0x44210000 0x1000>;
 			};
@@ -280,6 +280,7 @@ flexcan1: can@443a0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&aonmix_ns_gpr 0x14 0>;
 				status = "disabled";
 			};
 
@@ -532,6 +533,7 @@ flexcan2: can@425b0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&wakeupmix_gpr 0x0c 2>;
 				status = "disabled";
 			};
 
-- 
2.40.1

