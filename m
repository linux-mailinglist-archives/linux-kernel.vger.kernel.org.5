Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B1478CAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbjH2RSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbjH2RSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F52FC;
        Tue, 29 Aug 2023 10:17:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c353a395cso601427866b.2;
        Tue, 29 Aug 2023 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329450; x=1693934250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfzC+/2ZWaml8G5FoMVqEV7cfUPth65LiMOYJOwJeN0=;
        b=bZLW+p0zlfsLlVcBzVygKS55P0IRebfmfiqzvn+vw5Svt3aaCxEmAf/zNj4HxrSb3q
         CHnOvzQ8j2IRQp89lqASBmTMaDuVAlOqF67lYkaX0qkNbvZhD+R3bJntKXa78jgmITAm
         2DrvIUbAK8VifA3j4MPRrKZMMfmGgMhoQhZgwJDu4rLZXqE1lFOhDFB8kOHL3DWwlndP
         pjs//iT2Q/1C+vivTrj4iPoL6TyQVWojgwxQvJQTyBhgSgxY8mn3U4y6sfBl+JArMVty
         RsUGpKZBYW4fV4MlYjswm92/89GXO5MLr57K3JCxIoAiZqRuS/0xNbUN+CXSFTQEoqz+
         IPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329450; x=1693934250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfzC+/2ZWaml8G5FoMVqEV7cfUPth65LiMOYJOwJeN0=;
        b=V/8+T6zsVoLOvuOkeK+sspJ3UkaKHeg/NMIRTAJjJPjfVduSboZDM5hGHKZQGofpVA
         bUt1W2Uy+eYiQ+5mcHPV3HhGgdiQ1yClhZLbjTZp7OSfhePAiuPssfn+slOzew0kh5d/
         buyjLXouut/BVG+NU11XhicCMgRXTagOY2djEqI5iPleY5XQwHdcnBr3lVRiorC0dKQN
         AUDugjbGDqX43V1SdX2zA3O0JDLBe33Ro4MqrCJ1S4sko9ddpLux0aIQDqEb+w9BKQPR
         DNowv+RaPHMvMh4SbYgDdrRmuBgSmxsbGfK15jAGGm8hULJ60kqvrOKAr19cTqj8Vnz3
         J0Mg==
X-Gm-Message-State: AOJu0Yw9fS2q7w1kWr+ScxYhKSuqS0aAP6aSVZDTspZGj17fz2KUANkc
        A2cd1t9KkcKF7gp/Se6k/A==
X-Google-Smtp-Source: AGHT+IHd4qS1gu6W8/rBDv9L8vXPbe681EHcWWDTg19iW5zGN1XHAmvdeOISpan8OWf8b/vW0vdbkg==
X-Received: by 2002:a17:907:2e02:b0:9a1:f81f:d0d5 with SMTP id ig2-20020a1709072e0200b009a1f81fd0d5mr12345626ejc.54.1693329450187;
        Tue, 29 Aug 2023 10:17:30 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:29 -0700 (PDT)
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
        Finley Xiao <finley.xiao@rock-chips.com>,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 06/31] clk: rockchip: rk3128: Fix hclk_otg gate
Date:   Tue, 29 Aug 2023 19:16:22 +0200
Message-ID: <20230829171647.187787-7-knaerzche@gmail.com>
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

From: Finley Xiao <finley.xiao@rock-chips.com>

HCLK_OTG gate is located in CRU_CLKGATE5_CON, not in CRU_CLKGATE3_CON.
CRU_CLKGATE3_CON bit 13 is already (correctly) defined for ACLK_GPU.

Fixes: f6022e88faca ("clk: rockchip: add clock controller for rk3128")
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
[added commit message]
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/clk/rockchip/clk-rk3128.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index fcacfe758829..17bacf6dd6e7 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -484,7 +484,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(HCLK_I2S_2CH, "hclk_i2s_2ch", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(0, "hclk_usb_peri", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 13, GFLAGS),
 	GATE(HCLK_HOST2, "hclk_host2", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
-	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 13, GFLAGS),
+	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 13, GFLAGS),
 	GATE(0, "hclk_peri_ahb", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 14, GFLAGS),
 	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_peri", 0, RK2928_CLKGATE_CON(10), 9, GFLAGS),
 	GATE(HCLK_TSP, "hclk_tsp", "hclk_peri", 0, RK2928_CLKGATE_CON(10), 12, GFLAGS),
-- 
2.42.0

