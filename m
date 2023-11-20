Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC887F0C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjKTHBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjKTHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:01:20 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC8D70
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:01:12 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5079f6efd64so5148182e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700463671; x=1701068471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2en4yv4YpXFN3VCi3B3SISp0lZy/QFymnnSLRtY+3pY=;
        b=QTf9lhewJfbzft3XCWSxCFS1TXo0hw638GArgBf5I6Ts0Jc7CBcZlhMPEVQBugIwA4
         SqtYXkjyRQ6bbObhwze5jmBhGRtyD9p0MnzcFwazTKLKD2it6H/PWDXuhdEvpMlBQ4C0
         nui32BEWxaDLa2B6G7eIQAnSZjKwNqWUsxQ+a4J5qWMjQ07gHbOArTTQxX/sEYeF1j5J
         SWaJ00pfZyJv+K7wf78KMmmOF9gJPWUKXayfK1OvpfUhuiN56ohx6EIRvrCl/amDlmF+
         vqXPrbi5n79cDGn5P47VnIgtWNaQjm+sw7xEpL78nPBONkZFal8NQVpvVPamhPVaowYR
         8NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700463671; x=1701068471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2en4yv4YpXFN3VCi3B3SISp0lZy/QFymnnSLRtY+3pY=;
        b=IFiP7t2R0HXv993tFc5xQzb6OBb3WzhUZj/b8qSO5Ivh3BSrhhTXWJNdS79ujogksT
         4guOtCn6l1HVPHmYbz1zZtxojbyZbBQHIeSWWl8AVhFIH4VfNOoet+C48ZPkBjpDjJUA
         DXHBEf4A9ZbOBZIcxImjaBJi2s7wk8lnS6DldT/MRw/NQiKoweWevMEjnCVw/toedXxW
         WPT58+80DcnPZPkIYtrDMhef2LxehCNslhpakT+0CJL/KuoBdASIeo1FdwjSitKE+MJQ
         4JUbcTIcFG0f46jAHh6uMuCEPqLBKJKJOff1mf6bsvcUya2zDNsXGbPhDVn5SgeHL2K/
         B9Fw==
X-Gm-Message-State: AOJu0Yw3ibZNTrLKMvxB+Ov9pcjUMRmrq28WrXk/7NH319wO5p0uU8UA
        7aXwOsPLo2jOW2d18h+8CuS+yg==
X-Google-Smtp-Source: AGHT+IGwg2J8+I0uPjj9+o2L6Muf2cF2j1P+TgbE6Op0BXx+lqxUHN1EuXRuAKc54dfHijcSYIEOVw==
X-Received: by 2002:ac2:599b:0:b0:503:2deb:bbc1 with SMTP id w27-20020ac2599b000000b005032debbbc1mr4294366lfn.22.1700463670849;
        Sun, 19 Nov 2023 23:01:10 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b003316d1a3b05sm8777667wrq.78.2023.11.19.23.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:01:10 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, geert+renesas@glider.be,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de, arnd@arndb.de,
        m.szyprowski@samsung.com, alexandre.torgue@foss.st.com, afd@ti.com,
        broonie@kernel.org, alexander.stein@ew.tq-group.com,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, claudiu.beznea@tuxon.dev,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 05/14] pinctrl: renesas: rzg2l: Move arg in the main function block
Date:   Mon, 20 Nov 2023 09:00:15 +0200
Message-Id: <20231120070024.4079344-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
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

Move arg in the main block of the function as this is used by 3 out of 4
case blocks of switch-case. In this way some lines of code are removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9de350ad7e7d..21ee628363fa 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -842,7 +842,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	enum pin_config_param param;
-	unsigned int i;
+	unsigned int i, arg;
 	u32 cfg, off;
 	int ret;
 	u8 bit;
@@ -865,8 +865,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		param = pinconf_to_config_param(_configs[i]);
 		switch (param) {
 		case PIN_CONFIG_INPUT_ENABLE: {
-			unsigned int arg =
-					pinconf_to_config_argument(_configs[i]);
+			arg = pinconf_to_config_argument(_configs[i]);
 
 			if (!(cfg & PIN_CFG_IEN))
 				return -EINVAL;
@@ -880,9 +879,10 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			break;
 
 		case PIN_CONFIG_DRIVE_STRENGTH: {
-			unsigned int arg = pinconf_to_config_argument(_configs[i]);
 			unsigned int index;
 
+			arg = pinconf_to_config_argument(_configs[i]);
+
 			if (!(cfg & PIN_CFG_IOLH_A) || hwcfg->drive_strength_ua)
 				return -EINVAL;
 
@@ -907,9 +907,10 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			break;
 
 		case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS: {
-			unsigned int arg = pinconf_to_config_argument(_configs[i]);
 			unsigned int index;
 
+			arg = pinconf_to_config_argument(_configs[i]);
+
 			if (!(cfg & PIN_CFG_IOLH_B) || !hwcfg->iolh_groupb_oi[0])
 				return -EINVAL;
 
-- 
2.39.2

