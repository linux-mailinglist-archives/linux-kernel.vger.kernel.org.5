Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6977FFB10
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376337AbjK3TTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376347AbjK3TTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:19:39 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78816D48;
        Thu, 30 Nov 2023 11:19:45 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b845ba9ba9so817070b6e.3;
        Thu, 30 Nov 2023 11:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371985; x=1701976785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLPu8OP7Gtghj9r8oEl3tmBH6570M0xe/cb33bW7tew=;
        b=EDS8OnsIiVq428xHZsYAJwPqcun9XqIqgUrwmFS8sUaCJ4Rx1SK/Gwek1g6sA+AHfl
         DlOlI8G4GptOvKWNXvusoDEIrrPQAGAo5RP40UVzV2nKg3F8k331bMHiSkrMm53sPgik
         ykbEb2qEanQeLsAL3cCD3p6Kqcf/SV6KnpnDmrOEHdYHw5Gg92OGifJozfod0M0UJxM0
         bJo+tsEfX2O8kfW6gzbwGnw1KSvn99ID6/g3dqI8Tc7wZkk1DeqTrio2OHnLBLNuogCI
         CjxOGCEzQJgOAZpTeNOR1jVqwtEbhnsLztX+owMVKgSOgocAk2B/Tvh1KgTICdLhocWI
         /kBA==
X-Gm-Message-State: AOJu0Yz7RqG5a1vUqePUlJtNQpjmHk45gr7OXTkZTu0nwqPtJ9Z3A3DW
        kB/3ok2KX4Vvk3sWokgjlw==
X-Google-Smtp-Source: AGHT+IEFWohfzI3yeZknlX72nM9i+BGcCcB5vlsaw2vWJJdFsrighCpFKuV9DN0V1TVWaXWkf4QqKA==
X-Received: by 2002:a05:6808:1507:b0:3b8:3f9f:4c73 with SMTP id u7-20020a056808150700b003b83f9f4c73mr636290oiw.26.1701371984728;
        Thu, 30 Nov 2023 11:19:44 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x19-20020a056808145300b003b6caf2accfsm274659oiv.22.2023.11.30.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:19:43 -0800 (PST)
Received: (nullmailer pid 2435276 invoked by uid 1000);
        Thu, 30 Nov 2023 19:19:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3399-gru: Fix PCI node addresses
Date:   Thu, 30 Nov 2023 13:18:29 -0600
Message-ID: <20231130191830.2424361-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3399-gru PCI node addresses are wrong.

In rk3399-gru-scarlet, the bus number in the address should be 0. This is
because bus number assignment is dynamic and not known up front. For FDT,
the bus number is simply ignored.

In rk3399-gru-chromebook, the addresses are simply invalid. The first
"reg" entry must be the configuration space for the device. The entry
should be all 0s except for device/slot and function numbers. The existing
64-bit memory space (0x83000000) entries are not valid because they must
have the BAR address in the lower byte of the first cell.

Warnings for these are enabled by adding the missing 'device_type = "pci"'
for the root port node.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi  | 3 +--
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi             | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 5c1929d41cc0..cacbad35cfc8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -509,8 +509,7 @@ wacky_spi_audio: spi2@0 {
 &pci_rootport {
 	mvl_wifi: wifi@0,0 {
 		compatible = "pci1b4b,2b42";
-		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
-		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
+		reg = <0x0000 0x0 0x0 0x0 0x0>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
index 853e88455e75..9e4b12ed62cb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
@@ -34,8 +34,8 @@ &mipi_panel {
 &pci_rootport {
 	wifi@0,0 {
 		compatible = "qcom,ath10k";
-		reg = <0x00010000 0x0 0x00000000 0x0 0x00000000>,
-		      <0x03010010 0x0 0x00000000 0x0 0x00200000>;
+		reg = <0x00000000 0x0 0x00000000 0x0 0x00000000>,
+		      <0x03000010 0x0 0x00000000 0x0 0x00200000>;
 		qcom,ath10k-calibration-variant = "GO_DUMO";
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index c9bf1d5c3a42..789fd0dcc88b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -489,6 +489,7 @@ pci_rootport: pcie@0,0 {
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
+		device_type = "pci";
 	};
 };
 
-- 
2.42.0

