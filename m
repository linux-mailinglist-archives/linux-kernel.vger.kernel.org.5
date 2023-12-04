Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8C804016
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbjLDUhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjLDUhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:37:24 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD9A1BFB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:35:39 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58d9a4e9464so2021190eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1701722138; x=1702326938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWagGRv/i1MW5G1zwpH94jc78fOBc/tv6/pgOnwcx6k=;
        b=b+vDXRMze/C1r4e24CUeK2VhFvtLtGE/yojAiTPjpqNP0zOjoF5EGSYgkfebMM87Ok
         41+lNvkLHVfg5wYqgC1KSv/uAwiPfJSyj4j7Wd1KK50zRp8lCKOJ1j47MMBI5scT3KD/
         WAQ+MtoH1Wjx5c0IqOD9lgVW3pCnmt35I8R4Rs4bsn7a2x0XWEBGWQ8tfy/5XhRoIA2h
         Hgw2AlUxovbI+3Wt1XQKjrH6EjX5lLQfObCXV0uUrlyzWLCZB4o7LlxBuhU/hwYBVx9f
         g7qKnCxGz68O4qb8h1t+Nz5dGEw3Bn8nkXAHX0vsYyFMLcVKhpQ7D+EgH3/bOuJMjNoC
         YdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722138; x=1702326938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWagGRv/i1MW5G1zwpH94jc78fOBc/tv6/pgOnwcx6k=;
        b=kBLLVQ/0+VJscP7aT3TRBfNtpHBCI2UCcZVzfnN+0Z/rpwNmVsnGGGnLgXR5YB/Zm7
         Mbki3n6GPL5tqsQW/uQlys2zyaFunk/uyC2xNNNUAZe1PN3nwMfI9nanksUzOn8RALKe
         qWpuw1Za3n/dOCoXw6d/dOHHdv6aJfFCEvjPqD+0I4eMR9m3etXLroEUtNRMZ6/goum5
         b5DV/GndkQ4WqGawZYTfdeM4GoED9ymc0FwclZM1IEWS3Rb543A2qgTLe05dl/8BQH2H
         +QlFjApURHP21Mjsa+A6FD7++IZoBWHUd9yruvt231IgWU+F1+jBDBAVgKx+1AFtZuF0
         6Fnw==
X-Gm-Message-State: AOJu0YzPMTC3xM1QaTQtl/ASM95Z//SVuqkEY03newOf2VlHC+QOttwt
        Boz5feoK03dLuc+hzjDRvcAEMSFcCY32PQI3/Tk=
X-Google-Smtp-Source: AGHT+IGpvpasx/jsnz18GATaaZSXxidSk27F4tka23is5+bIfanisW7osRFJz0pud48XSUhXK+w7lw==
X-Received: by 2002:a05:6358:640b:b0:16d:f932:b5f with SMTP id f11-20020a056358640b00b0016df9320b5fmr1254764rwh.30.1701722138274;
        Mon, 04 Dec 2023 12:35:38 -0800 (PST)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id jo23-20020a056214501700b0067ac930d17asm1123469qvb.141.2023.12.04.12.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:35:37 -0800 (PST)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 2/2] pinctrl: stm32: fix GPIO level interrupts
Date:   Mon,  4 Dec 2023 15:33:57 -0500
Message-ID: <20231204203357.2897008-3-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231204203357.2897008-1-ben.wolsieffer@hefring.com>
References: <20231204203357.2897008-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32 doesn't support GPIO level interrupts in hardware, so the
driver tries to emulate them using edge interrupts, by retriggering the
interrupt if necessary based on the pin state after the handler
finishes.

Currently, this functionality does not work because the irqchip uses
handle_edge_irq(), which doesn't run the irq_eoi() or irq_unmask()
callbacks after handling the interrupt. This patch fixes this by using
handle_level_irq() for level interrupts, which causes irq_unmask() to be
called to retrigger the interrupt.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 603f900e88c1..fb9532601cbb 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -348,12 +348,15 @@ static int stm32_gpio_set_type(struct irq_data *d, unsigned int type)
 	case IRQ_TYPE_EDGE_RISING:
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_EDGE_BOTH:
+		irq_set_handler_locked(d, handle_edge_irq);
 		parent_type = type;
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
+		irq_set_handler_locked(d, handle_level_irq);
 		parent_type = IRQ_TYPE_EDGE_RISING;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
+		irq_set_handler_locked(d, handle_level_irq);
 		parent_type = IRQ_TYPE_EDGE_FALLING;
 		break;
 	default:
-- 
2.42.1

