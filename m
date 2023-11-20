Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289B07F11F5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjKTL2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjKTL1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:27:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B047170D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:18:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so12259225e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700479116; x=1701083916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx4aN/zGGPbPx5wuHBwZqoZnjcfUFGnzIbzLn9y7CFM=;
        b=A5lX2XkttnakvOALBo9HgEMO/99tfIMdnWeKfg0aarUCsl1vg4QtB/K3GXZ4Eihxbs
         FJEEZGHTGECduu3sL63UqbAZ33Gp88XgBzSLa4N3WpFSmtKeUX72NTISinjAPnF/pOCx
         bRc5nlxZJ9lZKkipMFdLzo8vfSrmeYcNBbmbqD261Xfa3+k7+kS93Eoum3QHH1YOSIza
         DcSwgdqTXhRfGE+yh8ksTGujHQKs3LfYomnVU2+HQiWc2RUX80siP6PPRd+4auzIpLFF
         U8Y4wC9lsmP5fgCglaAc/kBVdL1P6m07pbiVVUZO4N/y8XfZGpv3NnxIxSzu65xLxWcp
         LhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479116; x=1701083916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx4aN/zGGPbPx5wuHBwZqoZnjcfUFGnzIbzLn9y7CFM=;
        b=s8nNwW3+NXzA0EcCbbjH6tMXsKukHDQAVzBioK4GiXUj7l9KhLtLsaotLDsnEE1N/n
         wNL7aZx9iap+Rk0Z0Pl3VY+Cbb6GvVu6XbeFPFDykLSiF69lDWh8W+2GT53+hOOQKbvk
         efUo8ISgPqDxt00YkRdNUlVHYHRkV0HwTrr40v/2cS9NKUBMlMyHbLBJnLknEaUo9jGg
         5aoXuTaQlvXn4+nTIYAw25WDk99HKr08p8Vw+laET9mEiBzkeEfi7TCucDUeKEjqQXB2
         Eo7T1IhUUTs0nS65+C0i8/rW1UxY1U0zYxaVxwxRHnjLH1tyBYg7Ebzp01RS0OJxbAIB
         GHIA==
X-Gm-Message-State: AOJu0YzXLamVAZSvYN5YZqoN3KQ2aTLRzMZ402A6mpIT8NsZ5ZdPuq5A
        pcXhl4yq+rWmXw70vPWYTjPoqg==
X-Google-Smtp-Source: AGHT+IG4q9+CFKWWh1PtV4CMYsm0ublGYiA2GT1Ip89ZJtr+DG+TrKWQY2HA9TpUNmUJDiG8Qb2AvQ==
X-Received: by 2002:a05:600c:a07:b0:409:703c:b9b1 with SMTP id z7-20020a05600c0a0700b00409703cb9b1mr6455336wmp.40.1700479116562;
        Mon, 20 Nov 2023 03:18:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b0040651505684sm13142676wmo.29.2023.11.20.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:18:36 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 5/9] irqchip/renesas-rzg2l: Implement restriction when writing ISCR register
Date:   Mon, 20 Nov 2023 13:18:16 +0200
Message-Id: <20231120111820.87398-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The RZ/G2L manual (chapter "IRQ Status Control Register (ISCR)") describes
the operation to clear interrupts through the ISCR register as follows:

[Write operation]
When "Falling-edge detection", "Rising-edge detection" or
"Falling/Rising-edge detection" is set in IITSR:
- In case ISTAT is 1
	0: IRQn interrupt detection status is cleared.
	1: Invalid to write.
- In case ISTAT is 0
	Invalid to write.

When “Low-level detection” is set in IITSR.:
	Invalid to write.

Take the interrupt type into account when clearing interrupts through
the ISCR register to avoid writing the ISCR when interrupt type is
level.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index d666912adc74..a77ac6e1606f 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -78,11 +78,17 @@ static void rzg2l_irq_eoi(struct irq_data *d)
 	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	u32 bit = BIT(hw_irq);
-	u32 reg;
+	u32 iitsr, iscr;
 
-	reg = readl_relaxed(priv->base + ISCR);
-	if (reg & bit)
-		writel_relaxed(reg & ~bit, priv->base + ISCR);
+	iscr = readl_relaxed(priv->base + ISCR);
+	iitsr = readl_relaxed(priv->base + IITSR);
+
+	/*
+	 * ISCR can only be cleared if the type is falling-edge, rising-edge or
+	 * falling/rising-edge.
+	 */
+	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq)))
+		writel_relaxed(iscr & ~bit, priv->base + ISCR);
 }
 
 static void rzg2l_tint_eoi(struct irq_data *d)
-- 
2.39.2

