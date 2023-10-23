Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301417D2FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjJWKXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjJWKW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:22:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B98E188
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:22:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c50b7c36so4237312e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1698056572; x=1698661372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbHBU/qjptH7973ShNtrvZ+jIeyRnDw/f4+sWGsFAeg=;
        b=AI3ov+zzvFAXzySkRgCZkteWyvTit8xY84xqFQJ1eFGYd4IKtPCufAKWZrNf14HP4X
         a0cf5oth+qwvLm02pEacyyNCSZHxGd2Va6FZ/Xn8zvNc+uccX6UG81+5FO2bMz3ha8Wi
         pxKIjD+3zB0WzW7MmvJMCZuclL7Pp6ta2vQCty7L35CM73K+5kzfIK35UDlHuG5a17Oo
         jAbFb3UUwYoeBqG/9dmavZkXtPAlDNHTD/tlOR/ufG0VNRGrYPYny55B+CG6LNsDXNBW
         fVcHwv//Uj+rPdizK+0RX8kd3kvf0iKWHPaudXKahrdFoeYwOBzpshq37Hg7b9obTzEu
         2EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698056572; x=1698661372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbHBU/qjptH7973ShNtrvZ+jIeyRnDw/f4+sWGsFAeg=;
        b=JsTGpJAFl+FjyD3wsIhxsr2jDFTWrVSR1/7H4Fv1HkvFWQO8SGon06Qx8BUE8WKa+L
         pgI7DKKL3mtZCAdlXfBL16AwfBHJvwS2SFz4b82TMFTr2gCeT2txoy2inNla4xatNKYw
         VyX5ju2Kq6cuH/5sWjlhMApdTtBdLQKZq5dA9HPsSZqgVeJwWYd0jFs6x0qCct5d50bu
         iq3UAFeYXp/WkCNVSwq/Db48sEGDuAiCDwdg4YcvqbxucFh2Eihtssi1ki8LXlbXVIPe
         wxMuzJTGLTnW1Jfyvbb/uSeDPhDrT+QTaFty3XSjOXFoFxl7ik+wzBbL0IBOzcLoxqtO
         e6Gw==
X-Gm-Message-State: AOJu0YwzLOuCZSnzTKesG3Gm51Gd/3sTiKiOL1Ha89DdYYlao9VBXOpE
        Q6XOlsqEHTYeYBwQiL/jn1cG/Q==
X-Google-Smtp-Source: AGHT+IG+A8PxhX3r2zNXyOFC/Pv2bjvaEKWAWClyOzEZkebxv/h7AmSVTYIlQq521dqF7Ya8MRjrzQ==
X-Received: by 2002:a19:650f:0:b0:507:984b:f174 with SMTP id z15-20020a19650f000000b00507984bf174mr4919458lfb.48.1698056572469;
        Mon, 23 Oct 2023 03:22:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b0040596352951sm13593275wmf.5.2023.10.23.03.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 03:22:52 -0700 (PDT)
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
Subject: [PATCH 2/7] clk: renesas: r9a08g045: add IA55 pclk and its reset
Date:   Mon, 23 Oct 2023 13:22:18 +0300
Message-Id: <20231023102223.1309614-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add IA55 pclk and its reset.

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

