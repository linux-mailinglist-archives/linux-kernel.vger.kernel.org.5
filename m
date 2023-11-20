Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0737F11D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjKTLUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjKTLTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:19:50 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105DD173C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:18:40 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c87903d314so17808091fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700479118; x=1701083918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV9ajd1Vn5neabgAa2TZQ+P/1Gh4jYJqAFrZemb2qP0=;
        b=hux3o7DxjrSRfQTe46yFrhg0OqyhEEKbHEMxnFPN3DPhRAoSTyjI0Ry19qTas6fJZ9
         lwaWEKtRxUrjCeo2HmWg7JY4dxPWvDhMkDCtNmoYLKpkG9F219qimmZwI3slnJqWehvM
         RjmfTI3/8tqVeGi3/I9DPQrGi8h0+8kq7XXJWaUqMbK8Db73tflU3I2Fnd+MgdNURBSc
         xv71sirvepTkneNsB3xHjsn17Xasn9VPMqY3lnKyAV5KRB9siHJvQBv+PDPmmfHoMewt
         ddAvqNQ+P88AHXwlM0CRQbfnVo2kqoabNhTPDxWeAC2ekN4+4sj6bj9rYEnkT7Ovs+gK
         k/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479118; x=1701083918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LV9ajd1Vn5neabgAa2TZQ+P/1Gh4jYJqAFrZemb2qP0=;
        b=GWnUaVzDW9zWceG+B5dun5F/dIWfY41+jjvTh/yhoQsjQ00uS7HHasSInZ9lvhaXBU
         uoMa1PFeBqMThl3G7L13U0XwY6n5rodcEzQmBm7BvP0JNliph6haXRDoV3GFV0UrEgoX
         ZcCRMT5r13on3oyUYNwFIXWbXWaTOmtgcTm4H7Na45UfNCz1D59i6o3f7kB9I3GhljSe
         TA40gS9czDa3XmWgHV51ch+xjMVc8S94SfftHjM7/xTIvu++rt5KV+DBSiYoK3z+GPvp
         lr+HzinXlavRPgNxIPIJuKtoL5Sfq9wjmthul3XeMdepuDGaX4715/5oidKE8EkaGqLc
         sFkg==
X-Gm-Message-State: AOJu0YznITBmls4E8ZaDsVFVxvaSd4DEu9ARQ7Tt9nMTMM2cv7hPT5zI
        LrR4QVUcP0KF/WuNnQr/eDRGqA==
X-Google-Smtp-Source: AGHT+IEiQKWoeAHflWfxsYGxW57vdmsVdNEpIhaVkUYjrztJ40uvkrK4CIk91VUscIDSWi9q/5RInA==
X-Received: by 2002:a2e:9b95:0:b0:2c1:9a8b:f67 with SMTP id z21-20020a2e9b95000000b002c19a8b0f67mr3867505lji.1.1700479118250;
        Mon, 20 Nov 2023 03:18:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b0040651505684sm13142676wmo.29.2023.11.20.03.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:18:37 -0800 (PST)
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
Subject: [PATCH v3 6/9] irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset based on register's index
Date:   Mon, 20 Nov 2023 13:18:17 +0200
Message-Id: <20231120111820.87398-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com>
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

There are 2 TITSR registers available on IA55 interrupt controller. A
single macro could be used to access both of them. Add a macro that
retrieves TITSR register offset based on it's index. This macro is
useful in commit that adds suspend/resume support to access both TITSR
registers in a for loop.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index a77ac6e1606f..45b696db220f 100644
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
@@ -200,8 +199,7 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	u32 titseln = hwirq - IRQC_TINT_START;
-	u32 offset;
-	u8 sense;
+	u8 index, sense;
 	u32 reg;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -217,17 +215,17 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	offset = TITSR0;
+	index = 0;
 	if (titseln >= TITSR0_MAX_INT) {
 		titseln -= TITSR0_MAX_INT;
-		offset = TITSR1;
+		index = 1;
 	}
 
 	raw_spin_lock(&priv->lock);
-	reg = readl_relaxed(priv->base + offset);
+	reg = readl_relaxed(priv->base + TITSR(index));
 	reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
 	reg |= sense << (titseln * TITSEL_WIDTH);
-	writel_relaxed(reg, priv->base + offset);
+	writel_relaxed(reg, priv->base + TITSR(index));
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
-- 
2.39.2

