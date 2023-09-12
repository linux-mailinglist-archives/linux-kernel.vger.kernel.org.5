Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94D879C5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjILE4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjILEze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:55:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D912704
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so11175554a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494394; x=1695099194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOt8MObi3EwEd8MaojWICeVg9Wc3NR34oiCfGNrign4=;
        b=EEmXfhVLWIBOmRS67+zlhPLXu9K+BH7pdL5wWZoBTHEu256lJQt/22C5vb0xfgLcx7
         BvP49C/8icz0iZzOIcL+f1e1iNlIaHCCt48+K9mHf1nnuac49qieAU8YAzwrIM44+F7K
         Cr0c324763W8HDgogG1AYhIfBclnF/BwmEMKRnKJsfubeuuUpAqX7CAd+cbKlYT0RrlQ
         ajQ/nkQvtY4BMmhWgTyv3+b2CfGW8g/Apkop7/y4ck3hT3c0VIOOjnJUe+QEWvaBYrpX
         BSXjAPs7foYb4V/P1CaVVhuTVoISg2atWnKUaz71FoOxXXBPsN4697+hHG01dUkJTG5c
         WXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494394; x=1695099194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOt8MObi3EwEd8MaojWICeVg9Wc3NR34oiCfGNrign4=;
        b=dyrXcWqKKTLGj+U8Cl+nTsJloKxAVDinhNe6jTYe5sL0S600q6wI5TF7jmF04LuV/E
         ZGRpBK0szP9l+UtDVLO5fs3Op5TlOq2s7sA9S6OKeGfzdEMXAKZXs2STpvepT7eu1jGB
         bAHuZ3sgbKbZXPReFearIV1t54T7MWBXfwmtu4bD52yr7qs7EX8/4AxM0aoIn60ju0Ki
         m7bkQfTFbE+vQc6Uk0ZlAVlNhixrrXZddL+mFzQbJIR2e9lo8cGyeZhhK+MzptBmJ/a/
         rNU+re8AH5B1x6Tb7VlwL7fs8DbwlAj9Baq6pL5eY8VKtBoG7tuiqkTv+NP0fzwZNIEz
         w0rg==
X-Gm-Message-State: AOJu0YynMRNJlxdhf1y5MFW0SfTJVIKwyOo0MUCRdgPkv4mphl4bu1UB
        v6ovIVWjWkeIJTpnHbHk1WqZ1w==
X-Google-Smtp-Source: AGHT+IGioaNZKByYaWoJquYAY/wrS8yDc8WG3m1FB5QI2yVls9/T86vMdDqrUMMLswER2NynSKXSJQ==
X-Received: by 2002:a05:6402:f83:b0:52f:a763:aab4 with SMTP id eh3-20020a0564020f8300b0052fa763aab4mr621610edb.5.1694494393949;
        Mon, 11 Sep 2023 21:53:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:13 -0700 (PDT)
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
Subject: [PATCH 28/37] pinctrl: renesas: rzg2l: make struct rzg2l_pinctrl_data::dedicated_pins constant
Date:   Tue, 12 Sep 2023 07:51:48 +0300
Message-Id: <20230912045157.177966-29-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

struct rzg2l_pinctrl_data::dedicated_pins is constant thus mark it so.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index d90ff5ea356d..cf2092d9229d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -181,7 +181,7 @@ struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u32 *port_pin_configs;
 	unsigned int n_ports;
-	struct rzg2l_dedicated_configs *dedicated_pins;
+	const struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
 	const struct rzg2l_hwcfg *hwcfg;
@@ -1330,7 +1330,7 @@ static const u32 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static struct {
+static const struct {
 	struct rzg2l_dedicated_configs common[35];
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
 } rzg2l_dedicated_pins = {
-- 
2.39.2

