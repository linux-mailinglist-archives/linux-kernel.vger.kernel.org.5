Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345DA759488
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGSLoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGSLoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:44:10 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FDFD3;
        Wed, 19 Jul 2023 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=25qOFGwl4u5Fl3P3TnP8f7cSLj7dX/d3+BVvY9wImlA=; b=qzlp175sRYu6+KoahiLjhlbjNe
        wVUM9JyTvLBZT4kgY5LOPCpYioW2Ah5gY6Gw4xgzHjKsDA/b8Ec77KC2DdMRY52EHnWda4OIvz5yR
        mAMzNq55MkVEnamyttJOVukjFQuoUhCK2/+H+0B7Hhx2reqqHyUlKgxYCzDorM7h4+zaS5fJ0x3LK
        oZJyNuuaBpJCleKSCIQ53t1Y8thhOYBTqOzxs22RSSOAoExXs4H20M80GQ3I6Boy6gKfMa04mJEaZ
        IrP1D6zUuR2GwBMdTQzPwDRjNxadoYG6KkCwzAxRtQyONJ3Ujg+Kss6m/7Ims2v07hZY7uc+YWCW2
        eZZBosTA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:56038 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1qM5b1-00DcDD-29;
        Wed, 19 Jul 2023 13:43:55 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, S.Riedmueller@phytec.de,
        S.Mueller-Klieser@phytec.de, upstream@phytec.de
Subject: [PATCH v2 3/3] ARM: dts: imx6: phycore: Rely on PMIC reboot/reset handler
Date:   Wed, 19 Jul 2023 13:43:28 +0200
Message-Id: <20230719114328.2239818-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719114328.2239818-1-andrej.picej@norik.com>
References: <20230719114328.2239818-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the missing signal connection between i.MX6 WDOG_B pin and the
PMICs external reset, the internal i.MX6 watchdog is not able to reset
the phyCORE i.MX6 SoM properly. Thus disable the internal i.MX6 watchdog
to prevent unexpected PMIC settings after reset.

NOTE: This patch should not be backported as it might break existing
uses and fixes in bootloaders.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - new patch
 - i.MX6 phyCOREs have the same problem as phyFLEX devices.
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
index 28a805384668..86b4269e0e01 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi
@@ -309,3 +309,11 @@ MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
 		>;
 	};
 };
+
+&wdog1 {
+	/*
+	 * Rely on PMIC reboot handler. Internal i.MX6 watchdog, that is also
+	 * used for reboot, does not reset all external PMIC voltages on reset.
+	 */
+	status = "disabled";
+};
-- 
2.25.1

