Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D498680817B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377949AbjLGHIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377922AbjLGHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:08:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1007B10F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:08:21 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso726081a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 23:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701932899; x=1702537699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuAnHZUJssT/ogjytdawjrgSLlqBwwzWO4plVJg60Do=;
        b=jqMXOIHM7NIXqMSoon8Tj4OiojoQsSLX2/6BgPjh+kQEJb2tNRAvMtwr80Zq/+rxar
         zA6zWDMwm1H7uKoO6SUqbKvJuqYEkyqH+cAYLEWSVqMzzHZJXa4SVlI92vPjrOTU+uJd
         54WU0CELrbRUuz6yPC4i1buqDWphqHEKSiZSKy6TVDdraaf6TLx9vIDbvPMioneYPaLh
         lrXYCDqR7roY1d2s05sjVo3lU2onA3bhE4VZnpLGE58FvQVj78oL/nFMbaHbM12Heg0d
         zP21IRcdYVgXyTk89LXgqYxiAzywVARsz0kr7GOzei/VwbT9y9iFYuOPHv547AF4xZZC
         t5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701932899; x=1702537699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuAnHZUJssT/ogjytdawjrgSLlqBwwzWO4plVJg60Do=;
        b=r1jUXhESfiJJSPVvxUDpr6XUcAh3nXhPUPS7DGThcsSLzqTSieNzlgioAPseY/dTM+
         /Yxo/azLZ0N3nXdjTfbQA+R2HDroa/VHgLN7fLIg9DXK82IEjwcjwKH7jNeyGORsERM3
         kokm+4poNmF0cU1Tscav71Vg7lOSYmbg4LEmf4Po8MnBoP2gObLirO0jTIxqDWref+AT
         he2AHm2BayLgnjPik0RTuDik5xJKAjj6kPAdEwJHd4fMif9Vr3XORFe6o5ibD3gv3u4m
         hMg3dS0bpl/OfmJDIhyYcn/5eAUmiS0l9t/rJZxc+tcKOZ+AkXgYFf0cTL51rW/pRHwx
         tIUQ==
X-Gm-Message-State: AOJu0YzVA7IN8e7+uH1OwmX8zhdMAB1MK5w/58tVx6Pt6SD5lel+hdyc
        lKdHQvg8xbgM0Jde5dJ9TtfQvQ==
X-Google-Smtp-Source: AGHT+IEK/F8KEkOlDZ8jP3JRofMjdFI+uwlBNgwbxKm8acFivOfhgfyBJhuNrj6wnLXSiVf/gPl5mQ==
X-Received: by 2002:a05:6402:1ada:b0:54c:4837:8b5e with SMTP id ba26-20020a0564021ada00b0054c48378b5emr1070240edb.44.1701932899557;
        Wed, 06 Dec 2023 23:08:19 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id b41-20020a509f2c000000b0054cb88a353dsm420818edf.14.2023.12.06.23.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 23:08:19 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 07/11] pinctrl: renesas: rzg2l: Add input enable to the Ethernet pins
Date:   Thu,  7 Dec 2023 09:06:56 +0200
Message-Id: <20231207070700.4156557-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Some of the RZ/G3S Ethernet pins (P1_0, P7_0) could be configured with
input enable. Enable this functionality for these pins.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- this patch is new in v2


 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 0c05ccd03eb2..03253b3150e0 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1444,7 +1444,7 @@ static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
 	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)) |
-				      PIN_CFG_OEN,					/* P1 */
+				      PIN_CFG_OEN | PIN_CFG_IEN,			/* P1 */
 	RZG2L_GPIO_PORT_PACK(4, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)),	/* P2 */
 	RZG2L_GPIO_PORT_PACK(4, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
@@ -1455,7 +1455,7 @@ static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(5, 0x22, RZG3S_MPXED_PIN_FUNCS(A)),			/* P6  */
 	RZG2L_GPIO_PORT_PACK(5, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH1)) |
-				      PIN_CFG_OEN,					/* P7 */
+				      PIN_CFG_OEN | PIN_CFG_IEN,			/* P7 */
 	RZG2L_GPIO_PORT_PACK(5, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH1)),	/* P8 */
 	RZG2L_GPIO_PORT_PACK(4, 0x36, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
-- 
2.39.2

