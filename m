Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93B67D2FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjJWKXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJWKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:22:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9176D5D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:22:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4084de32db5so27102605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1698056574; x=1698661374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z3b5R3aVTqODhp8NQxqeuw9pHs0voRMGZXxgXHi6Uc=;
        b=ZRHh/8fTc+bG5lyErmfv3eNjCjr5VDO8Xod1FwiHOqr8/YDJYHg8+dvRmfSY2CSrud
         UzJ4ElchPZ87xGsoOZfr31KL1QOKvcFejmj/cydrg0hrKMNgVz8qepwb4x7M1W+oZ5sI
         ynqzVVTiUeP2hqeBKfO8DlY/K9r3MZtZyDP3R721G6E+Ub433CMOioLI5pDPOvd3vCvw
         QCJg1bJ/OLBG5vqgZbuwFbkWuD5/vcH4FbGf8SmhwhdYf0RMGa916RJVy9WPbIQVvmF1
         1pp8bvtZieM3HGma12E5EiBOeNFQmJEt9F3uPCG7H1AArM+3g8huU7+gOtLiBv/ADhPC
         pL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698056574; x=1698661374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Z3b5R3aVTqODhp8NQxqeuw9pHs0voRMGZXxgXHi6Uc=;
        b=GcP8bhndGSlCPUOG3BmXj6o52UYhc8l1ZgIhXCxRhNuN4tlykTlk3fWXybf8Ko5Jgi
         ZteUtUwI99QbB+gwx+5Alu1CqdulC2UJ5QdPT//4jAroaW+MkAEhv6bcBjTMnbPDoPwA
         jIEIvvpRsF766w66Wp4/K3nqb6CsN7BCkq2ceTYFv/GmNoAuthQZ+3B4GejGdG/9VeD3
         7TwWjRTWJaNpQNCyS1943Lv8VMhIq6wgdUAtQaiWtrsVBwiguscq9bRMHmUcXlXzeFjq
         u8PM8OOSkTErUlmDEwvx6hvXadarfAGsVc9PL7cLaCKqXMUGeuqsZjYtELJJ3IxBrk2l
         klzg==
X-Gm-Message-State: AOJu0YykE+qC/8KzQuP99RgTpxDxlWu6fDyp0WHJ/lxeKieZOa0K3iyI
        9ffWi7C8phQ+Ir/HrAhSh37Exw==
X-Google-Smtp-Source: AGHT+IFPNP9wFXpWAeNUc8oSbtz4KZ3/HL1DkO3btuCTk2wBwJPnDj961HvE0OE5JIunNgsa235u5w==
X-Received: by 2002:a05:600c:a47:b0:408:3e7a:82ea with SMTP id c7-20020a05600c0a4700b004083e7a82eamr7010065wmq.1.1698056574124;
        Mon, 23 Oct 2023 03:22:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b0040596352951sm13593275wmf.5.2023.10.23.03.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 03:22:53 -0700 (PDT)
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
Subject: [PATCH 3/7] irqchip/renesas-rzg2l: add macros to retrieve TITSR index and associated selector
Date:   Mon, 23 Oct 2023 13:22:19 +0300
Message-Id: <20231023102223.1309614-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add macros to retrieve TITSR register index and associated selector.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index fe8d516f3614..9ce0d6d67486 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -28,8 +28,7 @@
 #define ISCR				0x10
 #define IITSR				0x14
 #define TSCR				0x20
-#define TITSR0				0x24
-#define TITSR1				0x28
+#define TITSR(n)			(0x24 + (n) * 4)
 #define TITSR0_MAX_INT			16
 #define TITSEL_WIDTH			0x2
 #define TSSR(n)				(0x30 + ((n) * 4))
@@ -45,6 +44,8 @@
 #define TITSR_TITSEL_EDGE_FALLING	1
 #define TITSR_TITSEL_LEVEL_HIGH		2
 #define TITSR_TITSEL_LEVEL_LOW		3
+#define TITSR_HWIRQ_TO_INDEX(hwirq)	((hwirq) >> TITSR0_MAX_INT)
+#define TITSR_HWIRQ_TO_SEL(hwirq)	((hwirq) & 0xF)		/* 0xF = TITSR0_MAX_INT - 1*/
 
 #define IITSR_IITSEL(n, sense)		((sense) << ((n) * 2))
 #define IITSR_IITSEL_LEVEL_LOW		0
@@ -185,12 +186,10 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 
 static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 {
+	unsigned int hwirq = irqd_to_hwirq(d) - IRQC_TINT_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-	unsigned int hwirq = irqd_to_hwirq(d);
-	u32 titseln = hwirq - IRQC_TINT_START;
-	u32 offset;
+	u32 index, sel, reg;
 	u8 sense;
-	u32 reg;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -205,17 +204,14 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	offset = TITSR0;
-	if (titseln >= TITSR0_MAX_INT) {
-		titseln -= TITSR0_MAX_INT;
-		offset = TITSR1;
-	}
+	index = TITSR_HWIRQ_TO_INDEX(hwirq);
+	sel = TITSR_HWIRQ_TO_SEL(hwirq);
 
 	raw_spin_lock(&priv->lock);
-	reg = readl_relaxed(priv->base + offset);
-	reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
-	reg |= sense << (titseln * TITSEL_WIDTH);
-	writel_relaxed(reg, priv->base + offset);
+	reg = readl_relaxed(priv->base + TITSR(index));
+	reg &= ~(IRQ_MASK << (sel * TITSEL_WIDTH));
+	reg |= sense << (sel * TITSEL_WIDTH);
+	writel_relaxed(reg, priv->base + TITSR(index));
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
-- 
2.39.2

