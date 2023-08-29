Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A88C78CAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbjH2RSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbjH2RSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7972CED;
        Tue, 29 Aug 2023 10:17:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bed101b70so580717466b.3;
        Tue, 29 Aug 2023 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329460; x=1693934260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HORfKlZ4SywXOGQyingnsT/g0xzmPt7r0h5GBjv1Y2o=;
        b=VUixQxnYtqHbxNxKsf0ASLykcCTVDBNkGoP6Rm38KMc6AILysWa8b+lFKAXuD5qslG
         UyjCBLmFLidSKQ0RY7WXdCaq6jbPDDNTkPudF2VqWSQyI8Jia9045Tr7UoVbpy0vadyi
         9I6hOEzja2RK9gkAfFgcBIrsuoCw0g17m2Dt7ih9TXDbMk7/TUdsAaZ/iWM7ntqpdij6
         psUVG0D77RiEOIT04TFhtm/3QirUtJ+5sT5JehV7cPLhkUdT7cql53AtvV0XhVAiaG8R
         +Glt9LWtL2p7QnoIAZznkypP6rY57aC9Sy3a5iDARmcIanhYxdE2wGgn9IpZf9eoxiA8
         aNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329460; x=1693934260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HORfKlZ4SywXOGQyingnsT/g0xzmPt7r0h5GBjv1Y2o=;
        b=AuI3TWzV/iXKjvcWD1vnhfR4JPXTOygCdjqQBJTfANMagKYkzy2WF+LiZOfQ/Txlwl
         8qLxFICxzSJdFu/qiaL+++O6XrhJbVEhghZN5BJRkZiQoRbPgDb1JRCvB+02qpPTfMFe
         LVgpT9eD2Y8oOFd8W3dyrMPeRMMcBMm7a2KUskbey3vSJf/orZ07co0+6Ub/CxRzwSd8
         KniJy0JZNi2oZGgarxYNKIKJdNKEcRxXoRhnT/n3Sj4YSq296Dz9ie9lvBEQ7GGZ1uqC
         1P+wb7WUKJzOghMdKNJPI88hmSV9btGa6FVqjMhtpP3kWx27sWObA76KQLyFr7E74CCI
         ofTA==
X-Gm-Message-State: AOJu0YzW88D8jLCbIbY4CraR8A/t3XLdqxCBM/A6ETYsQkvtKAgs+7X5
        2TMd7XEfBNl/oJ+6OKZRog==
X-Google-Smtp-Source: AGHT+IG2fXAH6X9U8J0RtkYi3Dw+VWCQIj6fcYHWOgIhpDrIwSbMG6tADEykLLjvIrFhPYjoUswF6g==
X-Received: by 2002:a17:907:2cc8:b0:9a5:c9a4:ba1a with SMTP id hg8-20020a1709072cc800b009a5c9a4ba1amr1965327ejc.59.1693329460328;
        Tue, 29 Aug 2023 10:17:40 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:39 -0700 (PDT)
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
Subject: [PATCH 16/31] ARM: dts: rockchip: Add SRAM node for RK312x
Date:   Tue, 29 Aug 2023 19:16:32 +0200
Message-ID: <20230829171647.187787-17-knaerzche@gmail.com>
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

RK312x SoCs have 8KB of SRAM.
Add the respective device tree node for it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk312x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk312x.dtsi b/arch/arm/boot/dts/rockchip/rk312x.dtsi
index 4d3422abf008..7aba97b2c990 100644
--- a/arch/arm/boot/dts/rockchip/rk312x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk312x.dtsi
@@ -77,6 +77,14 @@ xin24m: oscillator {
 		#clock-cells = <0>;
 	};
 
+	imem: sram@10080000 {
+		compatible = "mmio-sram";
+		reg = <0x10080000 0x2000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x10080000 0x2000>;
+	};
+
 	pmu: syscon@100a0000 {
 		compatible = "rockchip,rk3128-pmu", "syscon", "simple-mfd";
 		reg = <0x100a0000 0x1000>;
-- 
2.42.0

