Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E8278CCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbjH2TbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbjH2Tay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:30:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9572D185;
        Tue, 29 Aug 2023 12:30:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so6328075a12.3;
        Tue, 29 Aug 2023 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693337431; x=1693942231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFpS6puAfr1Vvk5xVzMQk3TJscyGtiLTY36CCDlYgn4=;
        b=jQEu9kqkNg9K1HjYax3q4aud15nBA7Q6/mAvJfXTI2xm76iGAmozhnM+WhGNDm69qV
         KzFwv+Zbat2vdkMU5GGn0uGfmgqa786STGcWuIWFpmq2TYcF6SbyBDik3WDKmcgrUwjJ
         zhSXtvK9H6lhx92dpb7U/Io3tkfFfMf9AfSp75PfUmpf8sdD0/2r3FoARRkeCzQo+nRW
         E+XYwrCNfqS8RNxlc2BfdqR5UwXSFHNJaJ2+sCI9iWVM9ko0tsDXD4VpauxW80DeTlrP
         vUu9ZulrHBSNVWyOjJtlYuGRkn73w2ipgEuzEF3QxWIij2dfSLi6nHLsOB8UIGmIXAem
         7EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337431; x=1693942231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFpS6puAfr1Vvk5xVzMQk3TJscyGtiLTY36CCDlYgn4=;
        b=Te+ZuEyNP6QWBYPXG6ZayURJEFNdrnKFA6eCVDS0VUbre0cIYD/Lx2jsXmIymtay+Q
         blcudnFNdasd3FwY/LcVZogiz7EKo9noomn32258k4ReUlwgU0V6MtNWlokceDrumW3o
         CVfX8JjBCZON0aXBGzLd6DxfYQ9OLb+8aqo7yYtrmUXG1uuSxgxY5xpI+ByIkPC7WMxv
         gGa20IXzrFGALZdjeErot5eTdBP0d7X23fLQDDt3hyNh81ayKUi7pWTvy4R81lQq920u
         JRFrPC2Y+sKV99Ous+zc6Di/QysTYZegTVEKFSIWxTFc5d2HD56+WLvFuMWaxn06Ve2g
         TS0A==
X-Gm-Message-State: AOJu0YxNhP75ugg7Woxoi/Zyt2vuKzdEGpzbeweol2Op8UKlVzss8liM
        Cfp/c6utqxFyhYVa4XJM/w==
X-Google-Smtp-Source: AGHT+IF3soeV+vQd0OW4HUmy2zdE2aptWsopC7QBNqpTZOjsWegWne49TwOnE9EMxuKhbIvdZqAXyA==
X-Received: by 2002:aa7:d699:0:b0:52a:1c3c:2ecc with SMTP id d25-20020aa7d699000000b0052a1c3c2eccmr177588edr.25.1693337431101;
        Tue, 29 Aug 2023 12:30:31 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7d3c8000000b0052544bca116sm5940902edr.13.2023.08.29.12.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:30:30 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 3/3] clk: rockchip: rk3128: Fix SCLK_SDMMC's clock name
Date:   Tue, 29 Aug 2023 21:29:58 +0200
Message-ID: <20230829192958.250248-4-knaerzche@gmail.com>
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

SCLK_SDMMC is the parent for SCLK_SDMMC_DRV and SCLK_SDMMC_SAMPLE, but
used with the (more) correct name sclk_sdmmc. SD card tuning does currently
fail as the parent can't be found under that name
There is no need to suffix the name with '0' since RK312x SoCs do have a
single sdmmc controller - so rename it to the name which is already used
by it's children.

Fixes: f6022e88faca ("clk: rockchip: add clock controller for rk3128")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/clk/rockchip/clk-rk3128.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index 17bacf6dd6e7..75071e0cd321 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -310,7 +310,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(SCLK_MIPI_24M, "clk_mipi_24m", "xin24m", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(2), 15, GFLAGS),
 
-	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc0", mux_mmc_src_p, 0,
+	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc", mux_mmc_src_p, 0,
 			RK2928_CLKSEL_CON(11), 6, 2, MFLAGS, 0, 6, DFLAGS,
 			RK2928_CLKGATE_CON(2), 11, GFLAGS),
 
-- 
2.42.0

