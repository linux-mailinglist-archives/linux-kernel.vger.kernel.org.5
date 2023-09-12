Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D979C527
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjILExb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjILEwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:52:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A1CE6C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so5123342a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494345; x=1695099145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWV9f2XGMGZ1osmL6Dmo7EcLISauRJpn6Qrd8fgNooo=;
        b=IDY/MvQXmCwdQaxZowq326AODqP5jDcnKI50MylXYv2f6wVY5NyQTSNmuwblNtfmbV
         62qM1t9v27sUyQp630EYuOcRkbMqCo+/4EIKZzig43rAecnBkDjwxkZba7KlmCrZLdQW
         u1aHFpQN+KXxyASj1iZHsSMMtc4yhIDpEc05uwxMsqEC32R8gTBepFoxdxG880tooVjH
         J64jwhkmXyk8zFUd9E5PwV0g62KPFiF/WdAhz1RZlBfqzbnVybxE/TGMAfylq1IqP/sY
         h6sX4GIKW2jaCwuMQx9/eBeoenEx13FLAAucb5kyV4l8USOhPNTwdQnTnhjz+eW/LrQI
         ySMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494345; x=1695099145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWV9f2XGMGZ1osmL6Dmo7EcLISauRJpn6Qrd8fgNooo=;
        b=saMDbzcgB+SVYHN/6fDQ3qVD/1m68pBavRCtMhC5urptXjYzfHGtLALHPVCO1ZLJm5
         gwfKbLr9iAhyaUSIW/CWO+8vBx6zKvQB8UHMFFJ8fb4Av8nrN8FKwFggKQBNaKweIEV2
         YR9i7f6m+3nEHIPLb7pRrXjy4sFBJyKmdpJ2hCWZ/citUSsmhQiUzOoqSTQk1XJVn90R
         iUz0yWMxTN8zU2AiuMRtGxtISx1/T5t+gtZUEZhm4TZqqKvxskHijcVx6INC5CTqG5rI
         ooU4mEup5xmiLchB/MqFnQKlP3YggGYTi9LdOulMVh9LhsorvXz+MDDxPByx3hbvHjUa
         OfLw==
X-Gm-Message-State: AOJu0Yw5IqZ2eOUcPTocvFQZdGXw3x+G7Fcr5isDhK4hmu7nI9bKk6i8
        BKutijZaB8AsGT05X5B+YOdgtg==
X-Google-Smtp-Source: AGHT+IEXMvJ54B9tDieb/iBxe6vR9tpU1fSuBhk/VIriKpr9bHjIDviE+4AXLRRYhM0H6Kg7n9NlkA==
X-Received: by 2002:aa7:d28a:0:b0:522:d801:7d07 with SMTP id w10-20020aa7d28a000000b00522d8017d07mr1984738edq.10.1694494345199;
        Mon, 11 Sep 2023 21:52:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:24 -0700 (PDT)
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
Subject: [PATCH 04/37] soc: renesas: identify RZ/G3S SoC
Date:   Tue, 12 Sep 2023 07:51:24 +0300
Message-Id: <20230912045157.177966-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add support to identify the RZ/G3S (R9A08G045) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig       |  6 ++++++
 drivers/soc/renesas/renesas-soc.c | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 5a75ab64d1ed..631b17c627a8 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -319,6 +319,12 @@ config ARCH_R9A07G054
 	help
 	  This enables support for the Renesas RZ/V2L SoC variants.
 
+config ARCH_R9A08G045
+	bool "ARM64 Platform support for RZ/G3S"
+	select ARCH_RZG2L
+	help
+	  This enables support for the Renesas RZ/G3S SoC variants.
+
 config ARCH_R9A09G011
 	bool "ARM64 Platform support for RZ/V2M"
 	select PM
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 42af7c09f743..1598b66ffb51 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -72,6 +72,10 @@ static const struct renesas_family fam_rzg2ul __initconst __maybe_unused = {
 	.name	= "RZ/G2UL",
 };
 
+static const struct renesas_family fam_rzg3s __initconst __maybe_unused = {
+	.name	= "RZ/G3S",
+};
+
 static const struct renesas_family fam_rzv2l __initconst __maybe_unused = {
 	.name	= "RZ/V2L",
 };
@@ -170,6 +174,11 @@ static const struct renesas_soc soc_rz_g2ul __initconst __maybe_unused = {
 	.id     = 0x8450447,
 };
 
+static const struct renesas_soc soc_rz_g3s __initconst __maybe_unused = {
+	.family = &fam_rzg3s,
+	.id	= 0x85e0447,
+};
+
 static const struct renesas_soc soc_rz_v2l __initconst __maybe_unused = {
 	.family = &fam_rzv2l,
 	.id     = 0x8447447,
@@ -386,6 +395,9 @@ static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
 #ifdef CONFIG_ARCH_R9A07G054
 	{ .compatible = "renesas,r9a07g054",	.data = &soc_rz_v2l },
 #endif
+#ifdef CONFIG_ARCH_R9A08G045
+	{ .compatible = "renesas,r9a08g045",	.data = &soc_rz_g3s },
+#endif
 #ifdef CONFIG_ARCH_R9A09G011
 	{ .compatible = "renesas,r9a09g011",	.data = &soc_rz_v2m },
 #endif
@@ -429,6 +441,7 @@ static const struct of_device_id renesas_ids[] __initconst = {
 	{ .compatible = "renesas,r9a07g043-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g044-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g054-sysc",	.data = &id_rzg2l },
+	{ .compatible = "renesas,r9a08g045-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a09g011-sys",	.data = &id_rzv2m },
 	{ .compatible = "renesas,prr",			.data = &id_prr },
 	{ /* sentinel */ }
-- 
2.39.2

