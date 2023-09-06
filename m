Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CC8793357
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjIFBXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjIFBXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:23:43 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B513CCEA;
        Tue,  5 Sep 2023 18:23:37 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6515d44b562so19038796d6.3;
        Tue, 05 Sep 2023 18:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693963417; x=1694568217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RapfmVejinWEGSWwAMyr8+8Hm8y5i5je9CAT5StOZ74=;
        b=nTH5GBGj8KYtNhEn3eY0m953tVKHBOC0oC8CCm4b29oh2iPvNB0VwzSVws0sDsX8A5
         K+KWmynw0O+Q7pxWimdBy0sOQ/bWHvmE8WYXd2LM48hQjDn0jUDWoZIh9GZ+1gZL7Zn3
         qsomsmuRUfLaMtONztpOrLScoWiQbdfngBqH5YS5h5l4SpSRfvCcjC22dkiZHxC8Bsuu
         N+I/8ibaOHcXRiCQ11sgxwSwz96tOonqO3SD7bOJx3iftIddIlYnoC9iQqczuCwZX8y2
         AA53yzvBQED55Spu3sNFNJZTL7of9/wKQspHfWp+KjgY3dLL+DtVs3rxGxPTiyxgxMaK
         zxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693963417; x=1694568217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RapfmVejinWEGSWwAMyr8+8Hm8y5i5je9CAT5StOZ74=;
        b=eCHrviMldiDrDUP6L6JuwkwS2hq8s4Y1UZSU8FhcMka0DB84A1jiJ26hnM6jk+1XKZ
         CblIj8TnvVHH8TItWoLsxqvYTGBDnT7KgZtshSOhBxVJ/9hY/DjxIbLc955nsDuzXHzs
         ewxNmw68Zhtc1MOxNPFnPEGxqM9JtGMfgeJ/Bw9vBb64MJJ8wnZvYOt6rQnuDwLrcWEW
         VtZcVpr8p//7VS1pi66TGao0YMbDx0VWbesrNtu/HMLrTV407UrIJGNx+O1Xuu+NRMG5
         uzNHf1dmhXf3hfl5OtL718E8cErF0IVIe4PLVUdMQ6fAxcD7XOLvTkG5OXOE7YtBP6BI
         XJwQ==
X-Gm-Message-State: AOJu0YzBNYdx3RpLEZdyVW4H/xcVwX06qzIw1hrRXIzpZwcm+xthRHys
        rSlxRCBHYfEZlz6CcGJoTzo=
X-Google-Smtp-Source: AGHT+IGbLiVoXNQNH8QyFJrTt8supNUMGFKkdBCP1NrhvTCDaGevlKEOdtzrg0ZBfgvJuoVn9ZR+Iw==
X-Received: by 2002:a0c:b21c:0:b0:63c:66ec:e03c with SMTP id x28-20020a0cb21c000000b0063c66ece03cmr14794383qvd.27.1693963416745;
        Tue, 05 Sep 2023 18:23:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-107-15-246-199.nc.res.rr.com. [107.15.246.199])
        by smtp.gmail.com with ESMTPSA id r18-20020a0cb292000000b0064f5daff23fsm4995609qve.15.2023.09.05.18.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 18:23:36 -0700 (PDT)
From:   John Clark <inindev@gmail.com>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     "Thomas McKahan" <tmckahan@singleboardsolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, John Clark <inindev@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Add NanoPC T6 PCIe e-key support
Date:   Wed,  6 Sep 2023 01:23:05 +0000
Message-Id: <20230906012305.7113-1-inindev@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

before
~~~~
0000:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0002:20:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0002:21:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
0004:40:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0004:41:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)

after
~~~
0000:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0002:20:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0002:21:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
0003:30:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0003:31:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE 802.11ac PCIe Wireless Network Adapter
0004:40:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
0004:41:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)

Signed-off-by: John Clark <inindev@gmail.com>
---
 .../boot/dts/rockchip/rk3588-nanopc-t6.dts    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index 0bd80e515754..97af4f912828 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -137,6 +137,18 @@ vbus5v0_typec: vbus5v0-typec-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_m2_1_pwren>;
+		regulator-name = "vcc3v3_pcie2x1l0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -421,6 +433,14 @@ &pcie2x1l0 {
 	status = "okay";
 };
 
+&pcie2x1l1 {
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_1_rst>;
+	status = "okay";
+};
+
 &pcie2x1l2 {
 	reset-gpios = <&gpio4 RK_PA4 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc_3v3_pcie20>;
@@ -467,6 +487,10 @@ pcie2_0_rst: pcie2-0-rst {
 			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
+		pcie2_1_rst: pcie2-1-rst {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		pcie2_2_rst: pcie2-2-rst {
 			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
@@ -474,6 +498,10 @@ pcie2_2_rst: pcie2-2-rst {
 		pcie_m2_0_pwren: pcie-m20-pwren {
 			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		pcie_m2_1_pwren: pcie-m21-pwren {
+			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	usb {
-- 
2.40.1

