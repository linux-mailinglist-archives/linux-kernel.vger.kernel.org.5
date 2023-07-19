Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1E0759489
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGSLoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjGSLoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:44:10 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218AEC7;
        Wed, 19 Jul 2023 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MSdPB9oiEpbaOVi+tO3RL5bqf6DBFI0pi7P36ku9dg4=; b=WNX3eKxTXMeqw3xHrBFpCXoTLe
        C4KhmHF9gM4h6SB+Z5XPfSxi6Sj/wFjvEbIe2Gv1U+InxysNlX02c0HcIfl25ECgcMP7GGr7YRwsn
        20H0stYVgajGpgVaCwtpbtEJr8kPxhvNzmkxktBBzacarpY47wjDKMM3N8vEjRWXDJWYyHxK81hXo
        9+Di+m0fGkVxWBbikM6Sfakmo7+1ib7vJ8q9cSdNurI1NC2/Twqlc9dBpL2xk2VFbDGUyg4yobsoz
        o/s83WPxvGM4JOB4gxUsHTjhgZf4C0xJ3yfyDsm19mVvVqW/ovqo0ZoGmPaobDg1nWL+2v1BdwxJz
        FMDgqXaw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:56038 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1qM5b1-00DcDD-1o;
        Wed, 19 Jul 2023 13:43:55 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, S.Riedmueller@phytec.de,
        S.Mueller-Klieser@phytec.de, upstream@phytec.de
Subject: [PATCH v2 2/3] ARM: dts: imx6: pfla02: Rely on PMIC reboot/reset handler
Date:   Wed, 19 Jul 2023 13:43:27 +0200
Message-Id: <20230719114328.2239818-2-andrej.picej@norik.com>
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
the phyFLEX SoM properly. Thus disable the internal i.MX6 watchdog to
prevent unexpected PMIC settings after reset.

NOTE: This patch should not be backported as it might break existing
uses and fixes in bootloaders.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - this is a substitute patch with a proper fix.
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi
index 80adb2a02cc9..65fd7b4a6f27 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi
@@ -464,3 +464,11 @@ &usdhc3 {
 	vmmc-supply = <&vdd_sd0_reg>;
 	status = "disabled";
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

