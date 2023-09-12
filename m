Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB66579C553
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjILEyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjILExd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:53:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C61982
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so13436552a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494363; x=1695099163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TiFKFK+XRL8Y2Qq5YanADGgX/99HgRFoLldxYf1nF8=;
        b=YtZyX6fee1IO+aOnbTokMR4XX16aVgMWzCsyarqP2QKtOW1lWjQ2UdwETjELmUllF/
         Y16oLHPajwBTC08nDH6U0tq1QTpsnt7DDQLImNt+acxjND+nm0Iv4gEVdMbtn3JRQaW+
         JwaYk019jwzZYOD4Y7qulXIZrrOO5mGBxdvBCnkTGBO3U71mYQ5dvAh6GQeudwkKk/Ej
         DDa3dN2Amsbaql4s0iXjxVxtnvY4nt5LY9h9rh8674tIzzdti0NUkjzk/teZnabmZAXQ
         xq4oZadhmfNaMfIdEd5g1952N+HlUibOk9YL4vBa0CjCy1G0vLOs19uVhAD3JczMVpjE
         7p/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494363; x=1695099163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TiFKFK+XRL8Y2Qq5YanADGgX/99HgRFoLldxYf1nF8=;
        b=DqJAjrofJejLVTQ4Fge4zrSykFVD5MPCKtT1roa4qeoUA6VWoMVRB4XuWoSazMncys
         xYxLh14ZiJUB5t+WwKAgvAWLb3ijly4Wh0NnVVQavFFVu1pJRQSAIgZbsi2Vb/WMFW3+
         OMV9kqHDoCbESf0dlZYu9wQae3Ncobxs+tyMV0QSMhP3F691IWNm2+4tbDceN84xppdR
         O6LiK9Daq4KktyejLZnFH8zdMk0lI+eFNJMtqcDmhpMBD3JZDtSl2xG0IutSs9seDgI4
         QGh8G1KwBmY76znH1AM4YGXazqwRtAQgSof63/Xy0yO2G/komCXFqOSs1c+9/oh3ET5o
         GVJw==
X-Gm-Message-State: AOJu0YzpEA1kkC7dEf1shDjMS3rpaVNRv77GS3VKwgpz68xAEN2ehwhx
        JmjFQFY4NSEcb3dxoPMD8/TS2A==
X-Google-Smtp-Source: AGHT+IFx0wElgq/g5yJUbGwsVL7pK9O7R7ug3dBEnT+lubye7E7aMZMoI9sOzNhpCz2dZGVSV2hpdw==
X-Received: by 2002:a05:6402:2899:b0:52a:586a:b19a with SMTP id eg25-20020a056402289900b0052a586ab19amr1381363edb.21.1694494363502;
        Mon, 11 Sep 2023 21:52:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:43 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 13/37] clk: renesas: rzg2l: use FIELD_GET() for PLL register fields
Date:   Tue, 12 Sep 2023 07:51:33 +0300
Message-Id: <20230912045157.177966-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use FIELD_GET() for PLL register fields. This is its purpose.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index d8801f88df8e..50f69bbe1a6e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
@@ -38,14 +39,13 @@
 #define WARN_DEBUG(x)	do { } while (0)
 #endif
 
-#define DIV_RSMASK(v, s, m)	((v >> s) & m)
 #define GET_SHIFT(val)		((val >> 12) & 0xff)
 #define GET_WIDTH(val)		((val >> 8) & 0xf)
 
-#define KDIV(val)		DIV_RSMASK(val, 16, 0xffff)
-#define MDIV(val)		DIV_RSMASK(val, 6, 0x3ff)
-#define PDIV(val)		DIV_RSMASK(val, 0, 0x3f)
-#define SDIV(val)		DIV_RSMASK(val, 0, 0x7)
+#define KDIV(val)		FIELD_GET(GENMASK(31, 16), val)
+#define MDIV(val)		FIELD_GET(GENMASK(15, 6), val)
+#define PDIV(val)		FIELD_GET(GENMASK(5, 0), val)
+#define SDIV(val)		FIELD_GET(GENMASK(2, 0), val)
 
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
-- 
2.39.2

