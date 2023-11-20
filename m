Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E54A7F11D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjKTLUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjKTLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:19:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C420D10E5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:18:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40842752c6eso15071375e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700479112; x=1701083912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc8Hzq3Ts2nxCQ0omkudOSRnL/wtmp/FWmIm+F9jowA=;
        b=dGPEuAMdFCV9NlctN9B0xXm/HSlHxfFOfN0H/zW3UBjkyNKFCvhJToet097rFn4HLL
         z8jDAHwbWzJQJuyZA4euL5LrYl/R54C4NuBOdMzxLEG+3cFiZWLB5GihrHuSPA8yUThF
         5spNYyVzf7NnjYLa2CvjqdEVDZnDy07WZ5CM8cEWQhpB/+c13zm/McKXC2GFXoLqJau5
         7o+2SkudWUXZVxQfXaH0vMn7zYDLeZ4F2dD9jaK0vp5TOu8m+A9SYTb10fgqF2ttwq/f
         NkBYu4wv3s7SV02UDS4plxGcDnucAh5HFOvu0/XH5H//Zkfdd3Pmft1m3hcDtSftv1dh
         cEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479112; x=1701083912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gc8Hzq3Ts2nxCQ0omkudOSRnL/wtmp/FWmIm+F9jowA=;
        b=e2MsIQTEKDKpoRTgQFvof/4+sZXJQeA/axT1RjB4jDtzQaSrxth5RKiLHpfZB4dsrG
         +coTxx0iow1ia++Dr1MEfyc4mvhkDFvJq0gqLzyk830KtjPoXhLygJh8IeZ5m7aVEAfV
         HGxFHr+u3xcaEX1Fzp38a5fRDGxA8zH1W7FFr123ekGj62TOl2ZeCb3Xy75JHNOt54xy
         cxQbIyINEa/LNu9Qupx+o6Z+FEju08bWjFPK9yEGQDaJgg0fKK/EfuJfj6iX0Bf/MmGm
         UZdk+MoVZpsu5uevUj6Ka9oHt9ZI0Y3iQ3GJE9o1Cj1boGJTNdYUmvicUZtoiNecURUv
         G/NA==
X-Gm-Message-State: AOJu0YwWhVojWvOFBJCgDyf+FnrNh9W6WATb0uzaFfHC0LZmxr2X12Rn
        itc0cc0Joi4nyxBYwV7j5Xb6vw==
X-Google-Smtp-Source: AGHT+IGR4NGMGQuVNYATIPlT42I33gdkgFm4f8WvykH8Sea8phFSl9bGFJL8tFMSI4OQOpZND0ITug==
X-Received: by 2002:a05:600c:1c96:b0:405:336b:8307 with SMTP id k22-20020a05600c1c9600b00405336b8307mr5941605wms.7.1700479112208;
        Mon, 20 Nov 2023 03:18:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b0040651505684sm13142676wmo.29.2023.11.20.03.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:18:31 -0800 (PST)
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
Subject: [PATCH v3 2/9] irqchip/renesas-rzg2l: Use tabs instead of spaces
Date:   Mon, 20 Nov 2023 13:18:13 +0200
Message-Id: <20231120111820.87398-3-claudiu.beznea.uj@bp.renesas.com>
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

Use tabs instead of spaces in definition of TINT_EXTRACT_HWIRQ()
and TINT_EXTRACT_GPIOINT() macros to align with coding style
requirements described in Documentation/process/coding-style.rst,
"Indentation" chapter.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index fe8d516f3614..cc42cbd05762 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -53,8 +53,8 @@
 #define IITSR_IITSEL_EDGE_BOTH		3
 #define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
 
-#define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
-#define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
+#define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
+#define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
 struct rzg2l_irqc_priv {
 	void __iomem *base;
-- 
2.39.2

