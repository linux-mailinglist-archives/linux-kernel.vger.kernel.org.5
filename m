Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50977A3EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjIQWlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbjIQWkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D274E133;
        Sun, 17 Sep 2023 15:40:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso20885805e9.2;
        Sun, 17 Sep 2023 15:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990440; x=1695595240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxgzRC83NEd59zuKYNAtW33VSR0RcAZP2Du3OW3MEsU=;
        b=GXF4INtM+N8DSHlep15jKUVWIp9r/WKwCl8Fjop4IdKCNs+55zs6CsmZHdh5+vWzax
         2j1MQkQLsFQLAG6+HiIfVqVIhNeuTNlmhUZw7/cvXNlTbunHy2lPjh4dVeh/B1MtiwM+
         aNEItpncQEkmeH5JyWBeN72R1YED3F2puB5a4w/8d0bRxcU6KXhTbXYqUUHqr4lTM6Q1
         2p9exjVZbpjnc4u+G+6MFfJXOSgCm1Eg8D5CfLR6IrGwh2q+jZzwTVQEPpV388wLJVmK
         RZhgdsDXTgLEvqXIrU75R34yLu7b7xdQVnfzgiKqrpQGUVhpXApIbXkCH83igLEY+QdW
         mWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990440; x=1695595240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxgzRC83NEd59zuKYNAtW33VSR0RcAZP2Du3OW3MEsU=;
        b=mJxpvT/3SVLFW4N+UrjAsOBMfLtHXVjSKWzRH40ez5V1D/Xk1gclRyFzL6z/K5DNCy
         DAq8nVPs/IJl4t9YKjHjfnfvQ7c3A3SfacKUO2N6gcvvHKL+YGUcSQ4eVJIc5WiLZ2Pu
         QHuuLLxuWsxi2HrJhQcNIx2MzYwnq7lx0IYShpRr48ryKifEweK0nzua/Het7sRxi0+h
         MoLDL7UZWPxdUB6EiInOp8rfrf6VieicgCRchkM7Cd8FzxSemR92nK7IgW80BsA0/VOe
         SnoowwVH1DdAPnVAb6O3fv08fU9IYH5DgOHrDIjdox3Zv7HxV1+0HKFXlMbHjF0ZsQ54
         vvcQ==
X-Gm-Message-State: AOJu0YyamfmwwYYuMg/ytdXF8puoyP00TVs95bbO5rXbSTXLHgPsPQ/C
        GjUA9C1J/bGRiCSBT8ul6zM=
X-Google-Smtp-Source: AGHT+IFoSWsvTCvogylPfTef05sJwd//OcFKTET+KddTyezT5DcPj/b0Rpvtp0gJKAXf1ocmhph9HQ==
X-Received: by 2002:a7b:ce07:0:b0:401:bdd7:499d with SMTP id m7-20020a7bce07000000b00401bdd7499dmr6467049wmc.25.1694990440181;
        Sun, 17 Sep 2023 15:40:40 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:40 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:40:06 +0200
Subject: [PATCH 10/13] clk: imx: composite-8m: convert compute_dividers to
 void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-10-1d008b3237c0@skidata.com>
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

As the current implementation cannot fail, drop the return value.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/imx/clk-composite-8m.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 27a08c50ac1d..a121f1285110 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -47,13 +47,12 @@ static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk_hw *hw,
 				   divider->flags, PCG_DIV_WIDTH);
 }
 
-static int imx8m_clk_composite_compute_dividers(unsigned long rate,
+static void imx8m_clk_composite_compute_dividers(unsigned long rate,
 						unsigned long parent_rate,
 						int *prediv, int *postdiv)
 {
 	int div1, div2;
 	int error = INT_MAX;
-	int ret = -EINVAL;
 
 	*prediv = 1;
 	*postdiv = 1;
@@ -66,11 +65,9 @@ static int imx8m_clk_composite_compute_dividers(unsigned long rate,
 				*prediv = div1;
 				*postdiv = div2;
 				error = new_error;
-				ret = 0;
 			}
 		}
 	}
-	return ret;
 }
 
 static long imx8m_clk_composite_divider_round_rate(struct clk_hw *hw,
@@ -80,8 +77,8 @@ static long imx8m_clk_composite_divider_round_rate(struct clk_hw *hw,
 	int prediv_value;
 	int div_value;
 
-	imx8m_clk_composite_compute_dividers(rate, *prate,
-						&prediv_value, &div_value);
+	imx8m_clk_composite_compute_dividers(rate, *prate, &prediv_value,
+					     &div_value);
 	rate = DIV_ROUND_UP(*prate, prediv_value);
 
 	return DIV_ROUND_UP(rate, div_value);
@@ -96,13 +93,10 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	unsigned long flags;
 	int prediv_value;
 	int div_value;
-	int ret;
 	u32 orig, val;
 
-	ret = imx8m_clk_composite_compute_dividers(rate, parent_rate,
-						&prediv_value, &div_value);
-	if (ret)
-		return -EINVAL;
+	imx8m_clk_composite_compute_dividers(rate, parent_rate,	&prediv_value,
+					     &div_value);
 
 	spin_lock_irqsave(divider->lock, flags);
 
@@ -118,7 +112,7 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 
 	spin_unlock_irqrestore(divider->lock, flags);
 
-	return ret;
+	return 0;
 }
 
 static int imx8m_divider_determine_rate(struct clk_hw *hw,

-- 
2.34.1

