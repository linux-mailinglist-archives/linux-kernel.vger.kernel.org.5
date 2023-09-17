Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0742E7A3EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbjIQWlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbjIQWkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E71132;
        Sun, 17 Sep 2023 15:40:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso20885735e9.2;
        Sun, 17 Sep 2023 15:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990439; x=1695595239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AleiAM5uH5i/SE/tlppNUyCKM9rbilwjAbKE5lRIkpU=;
        b=F2jl4/uEJVJY/PDXH50nrxulj5MAz+7wSXtVOPFyXGzsqJECZs5Q89hctxlw94hYWZ
         MxlUIeC8l2uR3EiU03QFDGLSdM2eLjfTyiAVGVFNWK3GI69rPM2mG0wVJF/HnD99xbEZ
         d3ec9t7HZFV2mcnyw5Wm8s0m0yC9zwtLG4CfhmQdGwzGvf7YQPqC7kb0VdZAiBB6lDkU
         IQx3iV8KXp7KDISQTTX9WBqbT7E7PV2NtVebQk0d8xZweJJPRrHb6qMHO3CvuQuuHgM1
         04DCoJ9NvWrgLmM3wsd1sGjznEld1LrRaqIcQ7FgGf0iFlP3H+5iuVhz6SraHCTj/5c9
         pt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990439; x=1695595239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AleiAM5uH5i/SE/tlppNUyCKM9rbilwjAbKE5lRIkpU=;
        b=sd3sGVqmvegE0mA4rFZQYsbizf5tujf4rk+Ap/2hi7RKhXJ2YxhCvjJwYOiRU2r2XK
         +b4Obg5Lpc97+5KDsnE3h0NEeuqu9wsauau5yGrbHJD2Eh+NWGo1K3rcCFia+c6J46sy
         yNOR7dxWpU37AJvE1TMl//wQR9r2xcSnuNZqb3XuefNuPbF0Usw+wN4Bh39BjYbG3W2F
         /+q4PKwM6KyhTTu8AT41KRMry0z3ptTvfWtVq8ucXkVYCSP72UgLxmECzzoI+9r7cpJA
         LcD3F5qesAgmgClQeRlGe6P0MeR+RZCg28CWUpO4nZj3MQGiqswpL5cwntUbOR+bhK0p
         3ICA==
X-Gm-Message-State: AOJu0Yx6p/vGn623zYjnyaGENbCbpWeJolvIyHimrqvs7B1pmBrNZZwV
        42GXvXohhrbgwxLpbRCz7bI=
X-Google-Smtp-Source: AGHT+IEJd0UR3fHRkZLN2P37BaeGbazCGXTOPIKnflpTHUpPxYc7g3MXgPNqS7MyirIdKmPyviqLoQ==
X-Received: by 2002:a7b:c8d6:0:b0:401:c338:ab94 with SMTP id f22-20020a7bc8d6000000b00401c338ab94mr7312693wml.29.1694990439298;
        Sun, 17 Sep 2023 15:40:39 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:38 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:40:05 +0200
Subject: [PATCH 09/13] clk: imx: pll14xx: consider active rate for
 re-config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-9-1d008b3237c0@skidata.com>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
In-Reply-To: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

As the pll14xx might be the parent of multiple child clocks, the active
config is most likely still required by one of them. As the children
have divider, use the LCM of the old and the new rate to target for an
integer multiple of the active rate.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/imx/clk-pll14xx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 0d58d85c375e..803e8b0a7a31 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/lcm.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 
@@ -36,6 +37,7 @@
 
 struct clk_pll14xx {
 	struct clk_hw			hw;
+	unsigned long			rate;
 	void __iomem			*base;
 	enum imx_pll14xx_type		type;
 	const struct imx_pll14xx_rate_table *rate_table;
@@ -235,6 +237,22 @@ static long clk_pll1443x_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_pll14xx *pll = to_clk_pll14xx(hw);
 	struct imx_pll14xx_rate_table t;
 
+	/*
+	 * If the PLL is configured more than once, we have to consider the
+	 * active config for the new rate. As the children have divider, also
+	 * allow multiples of the already configured rate. This is a simple
+	 * approach to enable dynamic re-config via SET_CLK_RATE_PARENT for more
+	 * than one consumer. E.g. on the imx8mp, when video_pll1 is parent of
+	 * media_ldb and media_disp2_pix (always 7:1).
+	 */
+	if (pll->rate) {
+		unsigned long want = rate;
+
+		rate = lcm(pll->rate, rate);
+		pr_debug("%s: old=%ld, want=%ld, new=%ld\n", clk_hw_get_name(hw),
+			 pll->rate, want, rate);
+	}
+
 	imx_pll14xx_calc_settings(pll, rate, *prate, &t);
 
 	return t.rate;
@@ -343,6 +361,8 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw, unsigned long drate,
 	tmp &= ~BYPASS_MASK;
 	writel_relaxed(tmp, pll->base + GNRL_CTL);
 
+	pll->rate = rate->rate;
+
 	return 0;
 }
 

-- 
2.34.1

