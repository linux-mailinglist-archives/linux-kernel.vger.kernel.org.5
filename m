Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2607B77F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbjJDGhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbjJDGht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:37:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4BBB7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:37:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c136ee106so312075766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 23:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1696401461; x=1697006261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rE6XvlSeUckpfUomIWf/ozKzyY+JN+wOSM6QZFHuwo=;
        b=fcVpznuki7i8t50+t0Y7Jji+pu/tEbw8YZxSfI/mx5ZR8C9wz0uS9M74V+j+oFg5kg
         RWnEUDePJYVXxyh/Jsk7reHDB2hoG8Eq+lO21dZX0eVk93WLT7uB69m1Dgj/yGGs2QMr
         GBZ0dOf8CfqX1Jse/fekrOOZdKb8RPmvJpWI1/SDLEpCRcd9jnFO0WeuQK7SAIfMXWuT
         85HWCyvWlo142VpoRyuO8BdWa7kO5Go3AHUdRLIBTUm3+jntIg5EtRN0OmqCChOuyq51
         3wm9mFL9QYGOP0CuTR6esQBSTIQq8HcHbElJGhm6OuUMkvMA31wK8zVb4I4pwv/iw12I
         2p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696401461; x=1697006261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rE6XvlSeUckpfUomIWf/ozKzyY+JN+wOSM6QZFHuwo=;
        b=KViGbNrG0CnM8DfAD8UqLUsjGTwaQDdgp8v+WjTdNAdYxFZ1zYy2tGxa+H3yE7pJuf
         +xIP63kEulSE3Oqo3t7X9wGMAVCeynXddZaLbRmU3BsNWbeesGGZc2opxAey0h+G0ECt
         EAV/bYPvez2xgaIkiH6gFeFLVnV4932RfsN1IkwI4QiQjr7WatVwhg79OR4EjAl1OjlZ
         mnrAA0IRSIBld3TFyDxBnnqTD8Ta/YMfCHc9krILgfOQ4hE9CbngbafkSBnyULWOXsr+
         TyrKvxMGgbYkAhyhZuqxY6Jh2Ck4vxRc6hNtg0VupLRRQ8JgE4NsKmfjP0O1pIky05N3
         I9XQ==
X-Gm-Message-State: AOJu0Yxi454kIwRlFwY+7PadxcZs8hTJOnayZbbLMpLfUfvlpqu3t5aN
        IXHq6xJQYV6xfZ7nnbcXS79NHw==
X-Google-Smtp-Source: AGHT+IHU2z1M0rnNTwOLTwxqBhdkD2ERONtPqMIyQCjhRDJLVt1Cq8Z//jENvytoAOWzoM5XtKEZQA==
X-Received: by 2002:a17:906:5341:b0:9b8:7709:6360 with SMTP id j1-20020a170906534100b009b877096360mr1121607ejo.40.1696401460849;
        Tue, 03 Oct 2023 23:37:40 -0700 (PDT)
Received: from capella.localdomain ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170906ca4e00b009ade1a4f795sm2193507ejb.168.2023.10.03.23.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 23:37:40 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] clk: si5351: allow PLLs to be adjusted without reset
Date:   Wed,  4 Oct 2023 08:35:30 +0200
Message-ID: <20231004063712.3348978-5-alvin@pqrs.dk>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004063712.3348978-1-alvin@pqrs.dk>
References: <20231004063712.3348978-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Introduce a new PLL reset mode flag which controls whether or not to
reset a PLL after adjusting its rate. The mode can be configured through
platform data or device tree.

Since commit 6dc669a22c77 ("clk: si5351: Add PLL soft reset"), the
driver unconditionally resets a PLL whenever its rate is adjusted.
The rationale was that a PLL reset was required to get three outputs
working at the same time. Before this change, the driver never reset the
PLLs.

Commit b26ff127c52c ("clk: si5351: Apply PLL soft reset before enabling
the outputs") subsequently introduced an option to reset the PLL when
enabling a clock output that sourced it. Here, the rationale was that
this is required to get a deterministic phase relationship between
multiple output clocks.

This clearly shows that it is useful to reset the PLLs in applications
where multiple clock outputs are used. However, the Si5351 also allows
for glitch-free rate adjustment of its PLLs if one avoids resetting the
PLL. In our audio application where a single Si5351 clock output is used
to supply a runtime adjustable bit clock, this unconditional PLL reset
behaviour introduces unwanted glitches in the clock output.

It would appear that the problem being solved in the former commit
may be solved by using the optional device tree property introduced in
the latter commit, obviating the need for an unconditional PLL reset
after rate adjustment. But it's not OK to break the default behaviour of
the driver, and it cannot be assumed that all device trees are using the
property introduced in the latter commit. Hence, the new behaviour is
made opt-in.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Cc: Jacob Siverskog <jacob@teenage.engineering>
Cc: Sergej Sawazki <sergej@taudac.com>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/clk/clk-si5351.c             | 47 ++++++++++++++++++++++++++--
 include/linux/platform_data/si5351.h |  2 ++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 00fb9b09e030..95d7afb8cfc6 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -506,6 +506,8 @@ static int si5351_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct si5351_hw_data *hwdata =
 		container_of(hw, struct si5351_hw_data, hw);
+	struct si5351_platform_data *pdata =
+		hwdata->drvdata->client->dev.platform_data;
 	u8 reg = (hwdata->num == 0) ? SI5351_PLLA_PARAMETERS :
 		SI5351_PLLB_PARAMETERS;
 
@@ -518,9 +520,10 @@ static int si5351_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 		(hwdata->params.p2 == 0) ? SI5351_CLK_INTEGER_MODE : 0);
 
 	/* Do a pll soft reset on the affected pll */
-	si5351_reg_write(hwdata->drvdata, SI5351_PLL_RESET,
-			 hwdata->num == 0 ? SI5351_PLL_RESET_A :
-					    SI5351_PLL_RESET_B);
+	if (pdata->pll_reset[hwdata->num])
+		si5351_reg_write(hwdata->drvdata, SI5351_PLL_RESET,
+				 hwdata->num == 0 ? SI5351_PLL_RESET_A :
+						    SI5351_PLL_RESET_B);
 
 	dev_dbg(&hwdata->drvdata->client->dev,
 		"%s - %s: p1 = %lu, p2 = %lu, p3 = %lu, parent_rate = %lu, rate = %lu\n",
@@ -1222,6 +1225,44 @@ static int si5351_dt_parse(struct i2c_client *client,
 		}
 	}
 
+	/*
+	 * Parse PLL reset mode. For compatibility with older device trees, the
+	 * default is to always reset a PLL after setting its rate.
+	 */
+	pdata->pll_reset[0] = true;
+	pdata->pll_reset[1] = true;
+
+	of_property_for_each_u32(np, "silabs,pll-reset-mode", prop, p, num) {
+		if (num >= 2) {
+			dev_err(&client->dev,
+				"invalid pll %d on pll-reset-mode prop\n", num);
+			return -EINVAL;
+		}
+
+		p = of_prop_next_u32(prop, p, &val);
+		if (!p) {
+			dev_err(&client->dev,
+				"missing pll-reset-mode for pll %d\n", num);
+			return -EINVAL;
+		}
+
+		switch (val) {
+		case 0:
+			/* Reset PLL whenever its rate is adjusted */
+			pdata->pll_reset[num] = true;
+			break;
+		case 1:
+			/* Don't reset PLL whenever its rate is adjusted */
+			pdata->pll_reset[num] = false;
+			break;
+		default:
+			dev_err(&client->dev,
+				"invalid pll-reset-mode %d for pll %d\n", val,
+				num);
+			return -EINVAL;
+		}
+	}
+
 	/* per clkout properties */
 	for_each_child_of_node(np, child) {
 		if (of_property_read_u32(child, "reg", &num)) {
diff --git a/include/linux/platform_data/si5351.h b/include/linux/platform_data/si5351.h
index c71a2dd66143..5f412a615532 100644
--- a/include/linux/platform_data/si5351.h
+++ b/include/linux/platform_data/si5351.h
@@ -105,10 +105,12 @@ struct si5351_clkout_config {
  * @clk_xtal: xtal input clock
  * @clk_clkin: clkin input clock
  * @pll_src: array of pll source clock setting
+ * @pll_reset: array indicating if plls should be reset after setting the rate
  * @clkout: array of clkout configuration
  */
 struct si5351_platform_data {
 	enum si5351_pll_src pll_src[2];
+	bool pll_reset[2];
 	struct si5351_clkout_config clkout[8];
 };
 
-- 
2.42.0

