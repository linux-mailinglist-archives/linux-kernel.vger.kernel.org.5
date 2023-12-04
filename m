Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F3F804024
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346102AbjLDUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376279AbjLDUiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:38:07 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643773858
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:35:38 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-58d12b53293so3344483eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1701722137; x=1702326937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMsMKq+fG5BsTJ38ktkUAvKvU/juEXAO2vxB2M78m9A=;
        b=puPA9UAsbsiGjJK4bD5uzqiISC5Auxb/XPKl1W3DkM+OI2MEPNYPbYb6zYzUgicyHa
         fYIz0J+O0rl1J5qJmJCGa3H5bZAvcGJl8H2AJV7RKvoEKaaU02LFgn0oAwhDe8y7ny6C
         j0tDqK30HXoVNVZF/lbgHrz4Gv4X6hUAG5msxB5qymDLxOtZaYCwIMYltH9lzss6m4le
         w1J047+L3fsRt8fuLnwmoQpjcu3oq9Pw44dQXZu64JrF/KqZhbZeRvoK/pbshm1qaU0B
         gjKBrv9RN83aC8jPuNWH+buofCIhbegY0E1vH9uYgWX2hgYz7HW/SUNcTlv/IEExHGbc
         MyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722137; x=1702326937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMsMKq+fG5BsTJ38ktkUAvKvU/juEXAO2vxB2M78m9A=;
        b=j2J2nb2wTFRHgopa6c4NtkgER31Q1qzkT/7PJSO4vTKF9IfkdhfNmy4ajM5630fSZi
         /xQ7gYUGYaiO2UlMsdeF54htd/G3DAeehkq1IQb6wZDIeBTLUJvGjDYUtE2Ne01zNZfK
         z6hk0DEymvHY9Wz5JylWWZ0Gnw30uKnRtctE2X2an9rQhR/jShSKKImClwJuCDeuc9Ml
         UHF1p0nlF1S8KcwehKOlTovNRws+Nzr8nXt/n5ZsuOjak1VT3mGl6IB33IVii72c/R4k
         F6sFGo7ZxTdN9+sIE98uiBwdiE8fG9Qma09GohgLcFQmMhLFi+k+GCKM7ClS7vaA+yiZ
         bdig==
X-Gm-Message-State: AOJu0Yw83SCOGIfoGraBOuJf035CMiKXZF71HG6LYLeetDyi5k6bxux4
        /j6eb+EgCl95AVt9I+vAZFJyaQvtjj0O885/im8=
X-Google-Smtp-Source: AGHT+IF2Gj+iJqDa8aGY27lxy9gezYaVc/7geGOoCzfX8J7QXvpmy9rY5js/M1Vlkz5tRc2LBUEwAg==
X-Received: by 2002:a05:6871:281:b0:1fa:f230:4c58 with SMTP id i1-20020a056871028100b001faf2304c58mr5820598oae.59.1701722136896;
        Mon, 04 Dec 2023 12:35:36 -0800 (PST)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id jo23-20020a056214501700b0067ac930d17asm1123469qvb.141.2023.12.04.12.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:35:35 -0800 (PST)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 1/2] irqchip/stm32-exti: support retriggering on STM32 MCUs
Date:   Mon,  4 Dec 2023 15:33:56 -0500
Message-ID: <20231204203357.2897008-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231204203357.2897008-1-ben.wolsieffer@hefring.com>
References: <20231204203357.2897008-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXTI retriggering support was missing on STM32 MCUs. Retriggering is
required to emulate GPIO level interrupts using edge interrupts in the
STM32 pinctrl driver.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/irqchip/irq-stm32-exti.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 971240e2e31b..6b3f54457812 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -328,6 +328,18 @@ static void stm32_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int stm32_irq_retrigger(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
+
+	irq_reg_writel(gc, mask, stm32_bank->swier_ofst);
+
+	return 0;
+}
+
 static int stm32_exti_set_type(struct irq_data *d,
 			       unsigned int type, u32 *rtsr, u32 *ftsr)
 {
@@ -856,6 +868,7 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 		gc->chip_types->chip.irq_ack = stm32_irq_ack;
 		gc->chip_types->chip.irq_mask = irq_gc_mask_clr_bit;
 		gc->chip_types->chip.irq_unmask = irq_gc_mask_set_bit;
+		gc->chip_types->chip.irq_retrigger = stm32_irq_retrigger;
 		gc->chip_types->chip.irq_set_type = stm32_irq_set_type;
 		gc->chip_types->chip.irq_set_wake = irq_gc_set_wake;
 		gc->suspend = stm32_irq_suspend;
-- 
2.42.1

