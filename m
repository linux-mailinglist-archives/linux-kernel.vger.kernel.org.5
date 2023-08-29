Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A578CAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbjH2RTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbjH2RSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362D5E5B;
        Tue, 29 Aug 2023 10:17:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so45422a12.1;
        Tue, 29 Aug 2023 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329465; x=1693934265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVn9A5G3nnJE19BtxVBvWzOtozFqCP+CXHqAAw8DJNQ=;
        b=b27K62CJiQ+fNyDd0kgfJWF+Ca5wj/0wqhnGz119b5cE+nOb+FyBPPaNzRONJSDjrR
         rXcaWzd5feRR339wfkwB3/8yPB39a9T6o/LPn55vwhhLvUcAuZbo2CfwN3zqDEykQ1N0
         DGeOSoCb9It3jKexuc4G4It/gfPj+uz0wiuC+hWp1KcKKgFD9uTysasqB3QgPYfeSZh7
         D+2ayYgDjIVbn2TKN82W4PVwlwzWdFhJgdnkptvrMMDg+GdJyR3smqzdXi/xbuB/ndB+
         kHsbiAR8Qr7fLZxvz2V1RxKNW+CPI7XJAE7qUHApqXmbMyT6mmLKPKSgQrgngQ0MxuLO
         RD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329465; x=1693934265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVn9A5G3nnJE19BtxVBvWzOtozFqCP+CXHqAAw8DJNQ=;
        b=ILRaNUg9ldmuPE/tjFtCmp7S9FzbPwJKVF/thH96hlJdpU5iJhYvKuW+O+2VzN6bkP
         6A92QGUplpvGzE4IYBYzJ2U70NSv47vT4qd95OdmBf5XMTHMX2NJzd6zsi5j/uA/qqf9
         0Cr7HpBoMzOG9NCJClGUrPJdYeFZQdREmUFsCT2Irhbu7C0OzC2kBypXEulpJOCLUHjQ
         zU0azzFY1xSjPXbKwHMBK5wNPpBekkil9WUxmvu8Dp2F6oyZS5GvPMVP56ImXn3dd7bm
         ilnf/p7AQa4lrSsVD2W8TsCwGyeSMfJksbrG9iEE3cgfmSMB7Nx0imoL1Z6xWvCblaBM
         M2dQ==
X-Gm-Message-State: AOJu0YwthKph8umyRZg8Xu1DDuZwYp6urkqVqWBcDwrQUz0sW+E4RPwp
        Syba/k/OcrYN78ZSIesGRQ==
X-Google-Smtp-Source: AGHT+IGVS1awmweidX6xAv3OC62PyPcHpBoI4b0nE82P4GEfIg0etIKXitlAvzG1CNyrO+3Zg0BtZA==
X-Received: by 2002:a17:907:b609:b0:9a1:b144:30f4 with SMTP id vl9-20020a170907b60900b009a1b14430f4mr3760583ejc.14.1693329465170;
        Tue, 29 Aug 2023 10:17:45 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:44 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 21/31] ARM: dts: rockchip: add power controller for RK312x
Date:   Tue, 29 Aug 2023 19:16:37 +0200
Message-ID: <20230829171647.187787-22-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
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

Add the power controller node and the correspondending qos nodes for
RK312x.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk312x.dtsi | 82 ++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk312x.dtsi b/arch/arm/boot/dts/rockchip/rk312x.dtsi
index 93560c4cd16a..617306a9edf7 100644
--- a/arch/arm/boot/dts/rockchip/rk312x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk312x.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/power/rk3128-power.h>
 
 / {
 	compatible = "rockchip,rk3128";
@@ -133,6 +134,87 @@ smp-sram@0 {
 	pmu: syscon@100a0000 {
 		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
 		reg = <0x100a0000 0x1000>;
+
+		power: power-controller {
+			compatible = "rockchip,rk3128-power-controller";
+			#power-domain-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			power-domain@RK3128_PD_VIO {
+				reg = <RK3128_PD_VIO>;
+				clocks = <&cru ACLK_RGA>,
+					 <&cru ACLK_LCDC0>,
+					 <&cru ACLK_IEP>,
+					 <&cru ACLK_CIF>,
+					 <&cru ACLK_VIO0>,
+					 <&cru ACLK_VIO1>,
+					 <&cru DCLK_VOP>,
+					 <&cru DCLK_EBC>,
+					 <&cru HCLK_RGA>,
+					 <&cru HCLK_VIO>,
+					 <&cru HCLK_EBC>,
+					 <&cru HCLK_LCDC0>,
+					 <&cru HCLK_IEP>,
+					 <&cru HCLK_CIF>,
+					 <&cru HCLK_VIO_H2P>,
+					 <&cru PCLK_MIPI>,
+					 <&cru SCLK_VOP>;
+				pm_qos = <&qos_rga>,
+					 <&qos_iep>,
+					 <&qos_lcdc>,
+					 <&qos_vip>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3128_PD_VIDEO {
+				reg = <RK3128_PD_VIDEO>;
+				clocks = <&cru ACLK_VEPU>,
+					 <&cru ACLK_VDPU>,
+					 <&cru HCLK_VEPU>,
+					 <&cru HCLK_VDPU>,
+					 <&cru SCLK_HEVC_CORE>;
+				pm_qos = <&qos_vpu>;
+				#power-domain-cells = <0>;
+			};
+
+			power-domain@RK3128_PD_GPU {
+				reg = <RK3128_PD_GPU>;
+				clocks = <&cru ACLK_GPU>;
+				pm_qos = <&qos_gpu>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
+	qos_gpu: qos@1012d000 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012d000 0x20>;
+	};
+
+	qos_vpu: qos@1012e000 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012e000 0x20>;
+	};
+
+	qos_rga: qos@1012f000 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f000 0x20>;
+	};
+
+	qos_iep: qos@1012f100 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f100 0x20>;
+	};
+
+	qos_lcdc: qos@1012f180 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f180 0x20>;
+	};
+
+	qos_vip: qos@1012f200 {
+		compatible = "rockchip,rk3128-qos", "syscon";
+		reg = <0x1012f200 0x20>;
 	};
 
 	gic: interrupt-controller@10139000 {
-- 
2.42.0

