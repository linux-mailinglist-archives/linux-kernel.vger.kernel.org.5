Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3177A3EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbjIQWlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbjIQWkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D512B;
        Sun, 17 Sep 2023 15:40:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401f68602a8so43049755e9.3;
        Sun, 17 Sep 2023 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990438; x=1695595238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHjjAyqptO8IMOlepeu6XUuPt7GkOQwtq9aZ8x05FNg=;
        b=fb+XARL7GHZKTJ98jveBVuggR07aMYJzdA5ocCm6o02ErWQjlQDE1CBShE3P3LoxZu
         4lX3/PewNS6/YmljvSfFF3EmMBBO30P0BTc3NS0TuEgCu4kEDjM/pO3AiuSOIu5dkyoo
         Sdb7jU2e2y64jf4G1yJHgap8G6aYOErY4viRdLPBhfBn017inFLb2HxQ0LVnRjT6qq8c
         42D9C7IKJaCKPJWN1xwmxEgX44+m2dF5WDj11gFUbbhBsnRo9rgU1YyD0bKrpxp37M0L
         2Uevy9U5RHzaHUC/Y1wQKiwZpMlOnCAJ4T+n/3Scpz1275nTXz36JRHX+IXflrMlcDPA
         ZhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990438; x=1695595238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHjjAyqptO8IMOlepeu6XUuPt7GkOQwtq9aZ8x05FNg=;
        b=WVw8FCnrueyJR+4Yrun3q+9GKNvicO93eL69NcJIXoO3kHIgycMmHBeh3iMPSS6+5O
         3GIQ/9P3BdRdoywP5OEa5yXILQkhN3jjmv9wHlq3X/8znVMAlpsAhl/rb2HZuxFvLaMa
         Ka/ffVS7kTop05HqaoEwHxPzH13FiZjz8EkhCDNmv2Ybo/O7sZwQ25BNV+u3BxmjsT+o
         ruNDPQ4s6iOg2OSVklhcY+NgYDifuqamBRok47kQ3AuUJLPJhwHhC+7UNr61X3gk5hKA
         s9NyzIR4t9La8Cpy+TYEvPBwVip2CQ4uicoNVWJxwsrciSREarHHPG2OYW/A5jHLH4Gm
         FLyg==
X-Gm-Message-State: AOJu0Yygut5BIMrvDJDrIYiw5sCcvVAxzx6CmN/2Q0pGdoEQ2E8EPXrt
        TAYxuZOGgzt0NAf+LFRO04Q=
X-Google-Smtp-Source: AGHT+IFLk9i3F2eGbtKSIJ4+EO4UrKuGZHKBpH4MGvrG0hpgnN6SI7Pfgpa0h7Kabz110ICpPDUFwA==
X-Received: by 2002:adf:ce09:0:b0:31f:e74e:8265 with SMTP id p9-20020adfce09000000b0031fe74e8265mr6156359wrn.56.1694990438311;
        Sun, 17 Sep 2023 15:40:38 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:38 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:40:04 +0200
Subject: [PATCH 08/13] clk: divider: stop early if an optimal divider is
 found
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-8-1d008b3237c0@skidata.com>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
In-Reply-To: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

During finding the best divider, the current implementation asks the
parent for the best rate for all its available dividers. If there are a
lot of supported divider values and the maximum divider is far from the
target rate, this can lead to many iterations. Depending on the parent,
the process of calculating the best fitting rate can be quite complex.

Therefore, return early if an optimal divider has been found.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/clk-divider.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a2c2b5203b0a..61b40dfb4e6f 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -332,6 +332,15 @@ static int clk_divider_bestdiv(struct clk_hw *hw, struct clk_hw *parent,
 			bestdiv = i;
 			best = now;
 			*best_parent_rate = parent_rate;
+			if (now == rate)
+				/*
+				 * Calculating fitting PLL parameters, which
+				 * might be done in parent's round_rate, can be
+				 * time-consuming. Therefore, the lowest parent
+				 * rate which gives us the exact required rate
+				 * is already optimal.
+				 */
+				return i;
 		}
 	}
 

-- 
2.34.1

