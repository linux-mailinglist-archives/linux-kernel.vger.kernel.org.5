Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2177078CB02
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjH2RTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbjH2RSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC1F11B;
        Tue, 29 Aug 2023 10:18:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99357737980so603872766b.2;
        Tue, 29 Aug 2023 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329467; x=1693934267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBecglGDcBm3dfaewAdojWnpNSqkK3k2Gii0sDddaoQ=;
        b=XP1yHF+4eAQ1aY3Irua4+dW2toI3nREqhZP00I5y08G3PeXlSneut2EIbz1iiUyWwX
         oqwl0IrVqJlXw8D0vWuGDTyrdoLSF6KHTXDXSs31wyV9VuGK6z67UVY/eFMScIvbDQhk
         AWxkHAD+loWSGgfx1VWlfktCTr45eNKchRHG+KW3rJqfn2ABiuXlixsNlfqJH4K8907B
         2EKNWSQDvdUzlI8QOIrwc6gk5do/f2EOzTJFotT0gsVS0O39epzp1vuRXvDvXKa1YeTT
         AMG/Z1T/jQeGfabrDe574rkIXRPRYAaILQZRsmYVFod1hp4cHLYzNWJinQ2hS/f29LhS
         XOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329467; x=1693934267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBecglGDcBm3dfaewAdojWnpNSqkK3k2Gii0sDddaoQ=;
        b=EZz5aVdEPjERFTapA27Oh1e4RcpS0We+fAoyIocRTxrvilr7PfYlwsYicFISqq+l3S
         fhXcTRQ/z+S4UTauGMIFmWWWsSLVWAczDtANSkqmRfA7UZDuaOyx67YEWEVM7MgTJ+1h
         VX3k6Mf1MKTUuiycGgV9DRxY+CUpNR9DVs5Xof7W5ftBUUF3rK+m/pm87uuXmjtYZxJG
         0fDKGeMZvJ1s+YGxPxyhS+NGyVuScziby8yid/AMFwJDNkSRUksMge8RgEt9+3T4hp4D
         cgXp4fQD9WCIy5Ih1hGfLr/xlaufK30EDJqq5hfd8lT0wMJDK41nGj0kkfdVbHb7KxEG
         giNg==
X-Gm-Message-State: AOJu0YxFV3zCyT910i3WF25EBP13AVtZb76zNp2F4FCWraJf+O3c2Boo
        zPIZPQeYyXe4sQYZsN1jh4TTRIda5g==
X-Google-Smtp-Source: AGHT+IGQSIHfyxWScSSaGtZgRmVAcjAeSYpIMFw2Pk7BPF5NMwiuJMreccIL2u+G9vwApRBvVAVtXw==
X-Received: by 2002:a17:906:31d8:b0:9a5:da6c:6518 with SMTP id f24-20020a17090631d800b009a5da6c6518mr497191ejf.37.1693329467128;
        Tue, 29 Aug 2023 10:17:47 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:46 -0700 (PDT)
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
Subject: [PATCH 23/31] ARM: dts: rockchip: Add 2-channel I2S for RK312x
Date:   Tue, 29 Aug 2023 19:16:39 +0200
Message-ID: <20230829171647.187787-24-knaerzche@gmail.com>
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

Both RK3126 and RK3128 have a 2-channel I2S IP block.
Add the respective node for it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk312x.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk312x.dtsi b/arch/arm/boot/dts/rockchip/rk312x.dtsi
index 024d801a9792..ce3f03c3532e 100644
--- a/arch/arm/boot/dts/rockchip/rk312x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk312x.dtsi
@@ -351,6 +351,22 @@ emmc: mmc@1021c000 {
 		status = "disabled";
 	};
 
+	i2s_2ch: i2s@10220000 {
+		compatible = "rockchip,rk3128-i2s", "rockchip,rk3066-i2s";
+		reg = <0x10220000 0x1000>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S_2CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		dmas = <&pdma 0>, <&pdma 1>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s_bus>;
+		rockchip,playback-channels = <2>;
+		rockchip,capture-channels = <2>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	nfc: nand-controller@10500000 {
 		compatible = "rockchip,rk3128-nfc", "rockchip,rk2928-nfc";
 		reg = <0x10500000 0x4000>;
-- 
2.42.0

