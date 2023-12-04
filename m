Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51078038EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjLDPf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344234AbjLDPfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:35:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB4CC0;
        Mon,  4 Dec 2023 07:35:57 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54ca43031d1so1425163a12.0;
        Mon, 04 Dec 2023 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701704156; x=1702308956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4KCr8eFfVtiTY0UwfeXIsAJIrQ2O8jUkXkezbt/EUU=;
        b=QnNgzbddLLjyktLgphLLvjk42PM2nwm2m+j79L7lNQwKBZcsS01h8DS5VZILeuwsTD
         gQ6GnkYMFWLopYbDFQy6gycAfRe9v7mBncCeKZC0gUhX8DuU+cBSTPedDID/s7t935FK
         Q3DLzgiTQfjsnTU6LaKMIrCVBB/YNaEiFBa7dN69qVcBsxbzDopWKtGj+dIxceb5TbdG
         NWPGZG5iB1TOhR9CZF5dfsKKgFmO871v//XQhbW27XdJXPjPWIZYlWYw+ml1lp66kN5x
         W2ggwNRy2Gt009Ru7Ax6MgUb/IZBGygi+ZCk30FZLvIzYKQrxasz5iUsK828SNTgXU2q
         eI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704156; x=1702308956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4KCr8eFfVtiTY0UwfeXIsAJIrQ2O8jUkXkezbt/EUU=;
        b=cdee4szXkk5SRfMXK6sIlO6L0ZMsnbqrkYy1dbfp0BZoDqOYcOWvKE/H/BG0JLJjyL
         /UbQL58RSCg76gaPwBZrtOk6qzEDA6bjuETeIlGecmqYm1fgtAlpHtAz11rUUy0B7Axy
         2WsOnhp4asYJMatk/6jSJi4gA6SHssQFDlHuxGvDkzquiEMj62q/+IxbTW5IqsCvIFIn
         7oGXA5VHFgqZR1NjqP+4g9o2Ciu0lB1nHHqwoV5y6lpg2hhjtOUap+L1T33UiQI+J12w
         wJ+kDLNQQLem6kx0t2itH3lIMBcuxPIwyQHL1nkIEe0knkxattYan4vtpoXntEB3b3s2
         naWw==
X-Gm-Message-State: AOJu0Yzhl1UaC0EiUEYK0cbjap+ux+WqaYSmWw3QqwCV/bTwR8XqbeH3
        itOoNb5KlMO35x0WGQKY7g==
X-Google-Smtp-Source: AGHT+IFsgq+IPGY1SqpjKBG4HvTIebHZNY6WdDwKfgZJbPVxuvps5zNljdKoL3nUYUk0d7D8Ekvfgg==
X-Received: by 2002:a50:954c:0:b0:54b:2894:d198 with SMTP id v12-20020a50954c000000b0054b2894d198mr3329077eda.4.1701704156091;
        Mon, 04 Dec 2023 07:35:56 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:55ff:210b:5393:c9d7])
        by smtp.gmail.com with ESMTPSA id h20-20020a05640250d400b0054c77ac01f4sm693194edb.51.2023.12.04.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:35:55 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 2/3] ARM: dts: rockchip: Add GPU node for RK3128
Date:   Mon,  4 Dec 2023 16:35:46 +0100
Message-ID: <20231204153547.97877-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204153547.97877-1-knaerzche@gmail.com>
References: <20231204153547.97877-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3128 SoCs have Mali400 MP2 GPU.
Add the respective device tree node and the correspondending opp-table.

The frequencies and voltages of the opp-table have been taken from
downstream kernel.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 0676d8b22a1e..414b690f96e4 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -101,6 +101,27 @@ opp-1200000000 {
 		};
 	};
 
+	gpu_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <975000 975000 1250000>;
+		};
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1050000 1050000 1250000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1150000 1150000 1250000>;
+		};
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <1250000 1250000 1250000>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
@@ -131,6 +152,29 @@ smp-sram@0 {
 		};
 	};
 
+	gpu: gpu@10090000 {
+		compatible = "rockchip,rk3128-mali", "arm,mali-400";
+		reg = <0x10090000 0x10000>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "gp",
+				  "gpmmu",
+				  "pp0",
+				  "ppmmu0",
+				  "pp1",
+				  "ppmmu1";
+		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
+		clock-names = "bus", "core";
+		operating-points-v2 = <&gpu_opp_table>;
+		resets = <&cru SRST_GPU>;
+		power-domains = <&power RK3128_PD_GPU>;
+		status = "disabled";
+	};
+
 	pmu: syscon@100a0000 {
 		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
 		reg = <0x100a0000 0x1000>;
-- 
2.43.0

