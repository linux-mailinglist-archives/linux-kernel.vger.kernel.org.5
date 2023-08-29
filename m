Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A8D78CCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjH2TbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbjH2Tax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:30:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7031BD;
        Tue, 29 Aug 2023 12:30:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a1de3417acso35693366b.0;
        Tue, 29 Aug 2023 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693337430; x=1693942230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfzC+/2ZWaml8G5FoMVqEV7cfUPth65LiMOYJOwJeN0=;
        b=HGcoUSksrIM1gAk+bZXWkIiBq4C1lZNNwIVqBfVHpOga1xFwHcOdu8WBroWwTsQlOj
         GqAFnHX2xPhae+1YdNbmPdH8ATn8RyRkSgbJsdrQx30SCEOZpalyT3ryBhiWrkJcJf9z
         mplkFokpfo+Cw0cjCTxAR0TtcQ6FzetFQkQU178rrP5/EwKd3+ykdst9M8yAK6C5yDQW
         3H+I3H+7lFPXPeV+bhSd6FfQIc5sr+kioxcA10H8g8GiyJPeOWogaMsSwfbMe1wSkV2H
         /QZ9GkwWWJMpsiimXIt1junJj/iHssZ4giyQmK5jQrV2szjEnHRbQh/la6dccMcK9fXu
         WrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337430; x=1693942230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfzC+/2ZWaml8G5FoMVqEV7cfUPth65LiMOYJOwJeN0=;
        b=Z1pndM/3L0dFmv1NngoGHt7L3DIui/hAatiMmfciP2jnwWRDCrPaITBmdMVapxN2cw
         5bPIyjHDruw5o5JYPWzN8lI0JQYB2xXgDpJ0Dt+Lqgog6YifbjO2AQMr/Uip0i67VWie
         EYodFXAXGIBh2Miny0C2ojHyV9FBJpuDCGHqUiIqGLx4eaSOngkXR808LJHI8KTxBmik
         3Q+xLvXPJvN9rr7mnoEfIASq4Jm08kHEYAIurii/rTzvYVs6TPRbRrNWbr968hKoXSVe
         ztu3Bu1sOhLWa3RihymWeBAMk+OQtyntRNMfxsO8TySMhbVb5KJndi7LC1b4u+4QBMC8
         f5Xg==
X-Gm-Message-State: AOJu0YzoYaqk80O92+sn3CjWN6ogXcyckUVn7jLjaci/oSatxYH8pHQ7
        1+RTVuxlrlCm05d+4mjOsQ==
X-Google-Smtp-Source: AGHT+IGNh4/VCGDQCZHTWgx0EhZ1PtJBqs8JN8DF92lQhMLKLCha86n99pCn/Xj5QM+kGftFnuVypw==
X-Received: by 2002:a17:907:60cf:b0:9a5:aa43:1c7c with SMTP id hv15-20020a17090760cf00b009a5aa431c7cmr5036312ejc.26.1693337430408;
        Tue, 29 Aug 2023 12:30:30 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7d3c8000000b0052544bca116sm5940902edr.13.2023.08.29.12.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:30:30 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 2/3] clk: rockchip: rk3128: Fix hclk_otg gate
Date:   Tue, 29 Aug 2023 21:29:57 +0200
Message-ID: <20230829192958.250248-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829192958.250248-1-knaerzche@gmail.com>
References: <20230829192958.250248-1-knaerzche@gmail.com>
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

