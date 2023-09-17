Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE12C7A3EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbjIQWlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbjIQWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119412C;
        Sun, 17 Sep 2023 15:40:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so42429945e9.1;
        Sun, 17 Sep 2023 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990435; x=1695595235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vxGwRmrE/ZkUF8q8weoGWwIj4Xu+tdZLwyIukopjBs=;
        b=BkNdvDP2hLNDwlr1CAMI/gfvY0qEXyu1ak+Q7zjfYCZ+UJ9jnlqKpnqonYngWhAGuL
         EzjcsISPsK9a4L0oE6kneUNx1/bCmkMsjL17UuZqqHAp3drULOy38j6OvZHE5VvgoynT
         RhDdrwNTknlDaBsuN094DKCSn0GOnCO2dF9/Z1hpA1fD2PSnzr8kSpTHLlNygr8mlKQj
         vAFeWoHWOTZAkDLCqlpNllpAaJJjHeJgPCS3yoNKqpfUPpbicdw3qn821H1aOD9TdpFs
         a1CY6gtFybeSuagYEpm8k+v2tNIgaOglwDHXxGVOZO3RVO2/lUc455zNmdB6zhcHIpnX
         zUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990435; x=1695595235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vxGwRmrE/ZkUF8q8weoGWwIj4Xu+tdZLwyIukopjBs=;
        b=tx064o2+RKXy0Lk+4KCvP7sDvjJKMzDkg1IcfpNane9O4VxwyoV6kNq9ygJ0fRjWtq
         cgVKrNQjaHZtnCiqC+O2VbSFWv2+u4HRG+7Uvtf3h+UFr/hutIhFQmHJge4ZfYE9OwTw
         QPIF1uJ4ufY7jT0jibbVk3xU0lrC50B9bMwGIVKsycP0tUKa4R9Fd5rD47FzYBCs9gRi
         LIijYlKUE+rzZPnfywVeA/74s37sKKMnLQ3TjTCnyZ+73Z3RDElgpnJsQ4M07cIGHQPV
         BxTAW2k1+qHwSy/yFWuZgjyHPmAuIR9ckMr1vP32uHRpB3R8bwhNHqREmKwBpXbTYZLs
         hcnw==
X-Gm-Message-State: AOJu0Yxt6WGYWkDCaRODm2C+pF0zmtIDLL7n0xzLjJsYbjREY0WBdJwX
        c2s4K3SZfeGspYhb0oW1uxY=
X-Google-Smtp-Source: AGHT+IHMevfnk5UWYsKRhfkr5ayQmI3SajW1IKiqEwfVzf1dzHkT1BsOxFv0AQd3YBAb6HwM5sliDw==
X-Received: by 2002:a05:600c:2194:b0:3fe:ef11:d79f with SMTP id e20-20020a05600c219400b003feef11d79fmr6719962wme.36.1694990434661;
        Sun, 17 Sep 2023 15:40:34 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:34 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:40:00 +0200
Subject: [PATCH 04/13] clk: print debug message if parent change is ignored
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-4-1d008b3237c0@skidata.com>
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

Print a debug message if the determination of the best clock rate
suggests a re-config of the parent (which means the actual driver
considers doing so), but the clock is not configured with
CLK_SET_PARENT_RATE.

This should give a good hint for clock config improvement potential.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/clk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 3e222802b712..4954d31899ce 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2241,9 +2241,14 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 		}
 	}
 
-	if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
-	    best_parent_rate != parent->rate)
-		top = clk_calc_new_rates(parent, best_parent_rate);
+	if (parent && best_parent_rate != parent->rate) {
+		if (core->flags & CLK_SET_RATE_PARENT)
+			top = clk_calc_new_rates(parent, best_parent_rate);
+		else
+			pr_debug("%s: ignore parent %s re-config from %lu to %lu\n",
+				 core->name, parent->name, parent->rate,
+				 best_parent_rate);
+	}
 
 out:
 	clk_calc_subtree(core, new_rate, parent, p_index);

-- 
2.34.1

