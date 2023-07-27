Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E58C764590
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjG0Fek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjG0Fec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:34:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B635B0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:33:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-56345ab18b0so294317a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436014; x=1691040814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6pPVVuf+iHSKHYY4ZFtCS4Q+L5PHxVLLeO9zsDmxdk=;
        b=I40E/Tu+tyrDTZMYc1cPYstrlmBQV6lwHdF/Wtzl6QsK+ppLtgCOOz0mQUFVkkA0/K
         Pma5M1Mr+XEtJn3bjdcSfgKI6wHMkOMB4ftatqfkjaBo1w5uV02nzkOJk2vq4x7G9IA/
         aNWz0J5TfQFmLb7nSVOOk1gKSocVUnBWfxx77HC0LVsw9fbj/JJJmt8O6hz4XEcHgtc3
         oGwrCDLHPZfd525go0ZfPDjM2AXs97ZkvraDqTOQdKml1FRv7jUY2Z4oMte7u4UPZWOX
         2fvSeBRdKtdhO7ap8JuHbz4LqYV/wVEYjkKhrYafuwp9XtNRnajUgcz3iileulOXZutu
         /2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436014; x=1691040814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6pPVVuf+iHSKHYY4ZFtCS4Q+L5PHxVLLeO9zsDmxdk=;
        b=ZWLVoz+6NKAiho1NHbADmwsU1yWtyZwhlGeU3NUxSqIF0ZPsp9GA7FQRbjge8WtfjL
         rL+6R27SBJS1ro5oEGZLWomlX/D15pUCXkHHchrlZuG5AqDy+mSPzSGch6q/ynIKqf+T
         PXAw3DpgSGYAgsgqfqFaKXUQgotY+5kjkQ1KtwFme9EglGH5oYDnwxCbvOyTKK02pIZu
         WRR4Xno0+s0yHRg/xuJINIOxqqzAoTMVKvfCO3Ff3EB1vkXVVUgGDl8KfPM3d0EaF8e8
         eFdJnNWznf5REQFwvwQrRkEDtIl9QScfpsx9B03psXeaqL+L/cDHO13Lk6rVQWp+8sZq
         hHqg==
X-Gm-Message-State: ABy/qLaFEB17PhhwJunpuvaQCCBiqGR2NSe+Nde7QhIoF7TJnxjm+zBU
        3qtf4vFYUdjXuRy03EA9mAF2zQ==
X-Google-Smtp-Source: APBJJlFm4mKsFff1Zkdn3PV2aA3+Ga6uV0BMrrpjW7y5ICZ5ZDzSKC4ZKS3AGNq3/3HADGo0vTK/7w==
X-Received: by 2002:a17:902:c94e:b0:1b6:7f96:42ca with SMTP id i14-20020a170902c94e00b001b67f9642camr3754606pla.66.1690436014261;
        Wed, 26 Jul 2023 22:33:34 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:33:33 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 09/42] clk: at91: clk-i2s-mux: add support for parent_hw
Date:   Thu, 27 Jul 2023 08:31:23 +0300
Message-Id: <20230727053156.13587-10-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parent_hw in i2s mux clock driver.
With this parent-child relation is described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-i2s-mux were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/clk-i2s-mux.c | 7 +++++--
 drivers/clk/at91/dt-compat.c   | 2 +-
 drivers/clk/at91/pmc.h         | 2 +-
 drivers/clk/at91/sama5d2.c     | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/clk-i2s-mux.c b/drivers/clk/at91/clk-i2s-mux.c
index fe6ce172b8b0..f1981b8ee18d 100644
--- a/drivers/clk/at91/clk-i2s-mux.c
+++ b/drivers/clk/at91/clk-i2s-mux.c
@@ -50,7 +50,7 @@ static const struct clk_ops clk_i2s_mux_ops = {
 
 struct clk_hw * __init
 at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
-			  const char * const *parent_names,
+			  const char * const *parent_names, struct clk_hw **parent_hws,
 			  unsigned int num_parents, u8 bus_id)
 {
 	struct clk_init_data init = {};
@@ -63,7 +63,10 @@ at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &clk_i2s_mux_ops;
-	init.parent_names = parent_names;
+	if (parent_hws)
+		init.parent_hws = (const struct clk_hw **)parent_hws;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
 	i2s_ck->hw.init = &init;
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 8540234e9d89..f0498d9c269c 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -239,7 +239,7 @@ static void __init of_sama5d2_clk_i2s_mux_setup(struct device_node *np)
 			continue;
 
 		hw = at91_clk_i2s_mux_register(regmap_sfr, i2s_mux_np->name,
-					       parent_names, 2, bus_id);
+					       parent_names, NULL, 2, bus_id);
 		if (IS_ERR(hw))
 			continue;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 1604b44f2945..e1fd87aebd27 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -154,7 +154,7 @@ at91_clk_register_h32mx(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
-			  const char * const *parent_names,
+			  const char * const *parent_names, struct clk_hw **parent_hws,
 			  unsigned int num_parents, u8 bus_id);
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 8c7ff0108b41..f5d6c7a96cf2 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -372,7 +372,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		parent_names[0] = "i2s0_clk";
 		parent_names[1] = "i2s0_gclk";
 		hw = at91_clk_i2s_mux_register(regmap_sfr, "i2s0_muxclk",
-					       parent_names, 2, 0);
+					       parent_names, NULL, 2, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -381,7 +381,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		parent_names[0] = "i2s1_clk";
 		parent_names[1] = "i2s1_gclk";
 		hw = at91_clk_i2s_mux_register(regmap_sfr, "i2s1_muxclk",
-					       parent_names, 2, 1);
+					       parent_names, NULL, 2, 1);
 		if (IS_ERR(hw))
 			goto err_free;
 
-- 
2.39.2

