Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0014D7DECD1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjKBGS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBGS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:18:57 -0400
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Nov 2023 23:18:51 PDT
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1EE4;
        Wed,  1 Nov 2023 23:18:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E10714745F;
        Thu,  2 Nov 2023 06:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1698905560; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding; bh=d6bGpQGMcWTfIFXeJnfNXYglphqaXvj//mewEVDo5i0=;
        b=peJtDkTo1fNDhJPVKfV17W63VXWPpCxUauH1uYj6bxUZ9eoQ6v8ABr/dZwnxQXodj5zU0P
        Rn9NfOkNTc2R8AhjMDeN5IPnDtA9UocjysHowSqFnVjwg6vF+tpC3vfcWL4ykOhqg3fvcL
        HhfeCeu5q+g1BVH5A/CkAV5FO9743knw2OQCpPp7LyFh1/t6xK7zuguuz7QsN+odaXap3w
        gwcNpZ3MwdVnBLWcOd9av3sWQvQEbxHKjEH0MTXTipikcb13fDUc2Wn/2sMHGB1hAXWKNF
        LuVzo1MJInSYfw09bX3PyHDbqbMynCDwLi9uB4mrPf9pA/tHlscCB5ntarjeHQ==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-axg: jethub-jxx add support for EEPROM
Date:   Thu,  2 Nov 2023 09:12:33 +0300
Message-Id: <20231102061233.3113249-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dts node for EEPROM placed on baseboard in JetHub D1+ devices.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 .../amlogic/meson-axg-jethome-jethub-j110-rev-2.dts  | 12 ++++++++++++
 .../amlogic/meson-axg-jethome-jethub-j110-rev-3.dts  | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
index 0062667c4f65..2c684f0ca99a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
@@ -35,3 +35,15 @@ bluetooth {
 		device-wake-gpios = <&gpio GPIOZ_6 GPIO_ACTIVE_HIGH>;
 	};
 };
+
+&i2c_AO {
+	/* EEPROM on base board */
+	eeprompd: eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+		pagesize = <0x20>;
+		label = "eeprompd";
+		address-width = <0x10>;
+		vcc-supply = <&vddao_3v3>;
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dts
index c2d22b00c1cd..c356bd2cc63a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dts
@@ -25,3 +25,15 @@ memory@0 {
 &sd_emmc_b {
 	broken-cd;/* cd-gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;*/
 };
+
+&i2c_AO {
+	/* EEPROM on base board */
+	eeprompd: eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+		pagesize = <0x20>;
+		label = "eeprompd";
+		address-width = <0x10>;
+		vcc-supply = <&vddao_3v3>;
+	};
+};
-- 
2.34.1

