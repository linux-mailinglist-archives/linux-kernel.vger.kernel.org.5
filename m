Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457D87F11F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjKTL2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjKTL1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:27:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F0E10D3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:18:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40853c639abso15051905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700479111; x=1701083911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3zrIDT5N9p6eJitAm1oJTITcoW+HOP0VmG8nkt3FV0=;
        b=Wd8lqIVaCz4zOdau+zWarXenNTr0tUgyzonJJQ849gD475OpVKsomkngmvhBQuCN+Z
         ZL6CvCaK50rKULg6/fJwMU0vxQ/VzI5lEykagt7oCSfdpi9KxyOVZThKK0tITcp/WYkH
         7RpFQqqZZ2NK1KQTkVljw6v6nX1NUOKryPZmg8XQJ2vVAiD0vQxLZTP11b2itz9o0CN4
         gJwlYQ/PFGPHO3M/L14hCvDszgDeGkh3CD8JLrUpTqNwr8KV2XYN4MyIdMHPzBbWxdb1
         L6MB9fYoMWn4doMIBAa7/9axCfCcZADr0FQXIr9d5RvjZepveFk3yjMpccU6WNiMckyO
         IYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479111; x=1701083911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3zrIDT5N9p6eJitAm1oJTITcoW+HOP0VmG8nkt3FV0=;
        b=Fl1jeWcxWLL8i5w1TDesHSCD8KqJt54iQcNTaw93/mKVZyt4EuyqtwdgNC3Kh9BIs2
         E1ug4LE2CYaRu3nRJY7iyfTmpSj2+RD1dMpGnSVNA21tZr2jVvY1MJvq1D1uSxLWkkkS
         9QpCKtTlDgVHOwMD8vQ1MhwzKYKtAb4C5GmxpwBBPesMFWD02RTDjGjiuIT1UpL7wqEh
         P7nCImjDWPUNoeAsketXERVDZ0AeQqiXnc8qp3FLMwFmMTuCyMnwOn2YpUArwGJ+VzmH
         5ZGDLCR1/0NAn0jZNHVyCIrtVvsGuthsFHYnF44g0oew24/ZUyykRU3fgPUBrSoKcvqP
         qN8A==
X-Gm-Message-State: AOJu0Ywq/kZIZsFZhecbwgSMUt1hfXkrnorV9G2x/6oCfC1ykv/FWBea
        OAvja/BweONHqwSbAsCspjET9g==
X-Google-Smtp-Source: AGHT+IG7MVqf/6hNKYkRXglolSsIpyxst5mObigjMOwk+LzWWRY5k4ezPeeB8D9kioAMd9xaHO5xCw==
X-Received: by 2002:a05:600c:510d:b0:408:3bbd:4a82 with SMTP id o13-20020a05600c510d00b004083bbd4a82mr4666391wms.15.1700479110864;
        Mon, 20 Nov 2023 03:18:30 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b0040651505684sm13142676wmo.29.2023.11.20.03.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:18:30 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 1/9] clk: renesas: r9a08g045: Add IA55 pclk and its reset
Date:   Mon, 20 Nov 2023 13:18:12 +0200
Message-Id: <20231120111820.87398-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

IA55 interrupt controller is available on RZ/G3S SoC. Add IA55 pclk and
its reset.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 4394cb241d99..ea3beca8b4e0 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -188,6 +188,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 
 static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("gic_gicclk",		R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0),
+	DEF_MOD("ia55_pclk",		R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0),
 	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
 	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
 	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
@@ -209,6 +210,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
+	DEF_RST(R9A08G045_IA55_RESETN, 0x818, 0),
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
@@ -220,6 +222,7 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 
 static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_GIC600_GICCLK,
+	MOD_CLK_BASE + R9A08G045_IA55_PCLK,
 	MOD_CLK_BASE + R9A08G045_IA55_CLK,
 	MOD_CLK_BASE + R9A08G045_DMAC_ACLK,
 };
-- 
2.39.2

