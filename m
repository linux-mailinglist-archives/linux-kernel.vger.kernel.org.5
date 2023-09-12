Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3904279C5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjILE4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjILEzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:55:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDBE2693
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so6661129a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494387; x=1695099187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhCaDIua2ELjKm61B/fNI293TcxyRj4KFS/PJUnGxg8=;
        b=nApQrTbZ/DMwak6rFd4XKQAztVtiBNGkZBzbnVUf/gHARkT2LE9n14w3WtQNUKGNOy
         2hLYzJwged2Ca8xXirfdv1657tS8ivzyWvazuO2SfK+x/HBC8FU2pGFWMxS3G/Y36pa9
         0FSsHCh8MNW8c+Iu52qkVj6Fum4qW7nf1dI6vCx8MJozrsjgaF9KxZe0VogtwLrmHgw4
         sDdDDU0bPGoOeOd1h4HX/13E4bci441pIxr+F4C00oy0Mpy8z6mLFpubZbb9BTmbrZ9P
         aHcKHGcHMilMY9Gh5R0c6AkmPW+gRtShsga57bhPVMIcRXYxjUKqpQP7AKwQuWMZ02D5
         DYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494387; x=1695099187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhCaDIua2ELjKm61B/fNI293TcxyRj4KFS/PJUnGxg8=;
        b=GKYHMYlvWYhJ9kQVGthxxX2IC0HKo8MiiFBAiEHSXSeTrWZumbpTNXtluTAHRs5EjQ
         oQLZ5BikpUljZxX0XDO9z6EpiNw8QKqPI9iGeiTJm8jdw0DI0S/yi6k5CkzYfycgKOtp
         xudYkPEz5TyUL2AXabIcL617DPu0okRQOS9unJcE5VfEA6JrXsDng8exfnoJ3mLpdZEI
         HHvEjR5Kcy9SPR0Z8BlZSWh1XvDUbOj0PrRbZ2Vft+2/MWnl1BhSh7RZPuiO4WhR0GoD
         1TtFYfhdQ2LwXhuQkotrG9BzSXgn4BP4Vi7bqdUGwzp2f+RxpwqtBPUolclSg3nv/mDy
         IR1A==
X-Gm-Message-State: AOJu0YxrTP5q1Z21gInATU5oAe/2oaDXfMY96vmzVCCQktX98nPLig0W
        twqWTrLbNkr1drzpsJdt5Fe8bQ==
X-Google-Smtp-Source: AGHT+IHtDAyGWwsTihwqYWIWjYGcMH84Kzvqf+B4fLDDAmKoCa48e1lUhWY9yaNrMxhEuORomBRuuw==
X-Received: by 2002:aa7:dd01:0:b0:523:1053:9b50 with SMTP id i1-20020aa7dd01000000b0052310539b50mr10347895edv.20.1694494387802;
        Mon, 11 Sep 2023 21:53:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:07 -0700 (PDT)
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
Subject: [PATCH 25/37] pinctrl: renesas: rzg2l: adapt function number for RZ/G3S
Date:   Tue, 12 Sep 2023 07:51:45 +0300
Message-Id: <20230912045157.177966-26-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On RZ/G3S PFC register allow setting 8 functions for individual ports
(function1 to function8). For function1 register need to be configured
with 0, for function8 register need to be configured with 7.
We cannot use zero based addressing when requesting functions from
different code places as documentation (RZG3S_pinfunction_List_r1.0.xlsx)
states explicitly that function0 has different meaning.

For this add a new member to struct rzg2l_hwcfg that will keep the
offset that need to be substracted before applying a value to PFC register.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 8bdf065aa85b..80cacac7ec95 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -136,9 +136,11 @@ struct rzg2l_register_offsets {
 /**
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
+ * @func_base: base number for port function (see register PFC)
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
+	u8 func_base;
 };
 
 struct rzg2l_dedicated_configs {
@@ -221,6 +223,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int group_selector)
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct pinctrl_pin_desc *pin_desc;
 	unsigned int i, *psel_val, *pin_data;
 	struct function_desc *func;
@@ -247,9 +250,9 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 
 		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n", port,
-			pin, off, psel_val[i]);
+			pin, off, psel_val[i] - hwcfg->func_base);
 
-		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i]);
+		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i] - hwcfg->func_base);
 	}
 
 	return 0;
-- 
2.39.2

