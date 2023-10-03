Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2E7B6E3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbjJCQUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjJCQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:20:38 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D4A9E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:20:35 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77574c2cffdso88032885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1696350034; x=1696954834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74pfqmyEpWzC0JVzEWtyP+utP1T9AK68aLigFiWOG7k=;
        b=SeGWlQDHFSe0SAyTgSkbd9l1j4MbOw6umhkgwSE7gfst9dgZUvulkkW1dckcfwH5WL
         707YwLZrVl36yeIm3Vq1+MC4tceHY1nqXMUnRUp+tkbNqlQcxGaIgpfk9XvBDXti9hCu
         WcgFumdwruYx8Rx0+3nOX9OcW8neCZTubtpyzgVkM1x5iTFsn/ixb3CgSCcQqGZ2b0fs
         es+lohLqFLzMarUICvZ1HEqSiL8wb7EVHARQ6GKuFSaU9XbkwDfcZjZlhn5mtBgRaJ72
         nP8d+H7DQbvVrpZu2p8RanlquuZ9gPcckE0Fg2zQDWEIIiIwrqmFUlyvQxshUc7ANhzR
         mz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350034; x=1696954834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74pfqmyEpWzC0JVzEWtyP+utP1T9AK68aLigFiWOG7k=;
        b=PaKaxcAiqtA/66kwaaworfmBAVpTyTUgKJ5VUcXJtNduS/G8CRT9oXoYphOihueXb0
         wS8++JTpph8pqCPen3xxxO7OMVqGq3C3GuDxuUb4mfaTDC9Xumwbl8JFWiszi1S9dK+K
         D+Tzwi227PZzhvq09LvH7KYUOMsXEMWeohWUgHVVpL+J1lbn9vS+DPYWZQB/FLNOEou7
         xHhn83okJpbSOq/wYSWxFbuz8fPQYoDPQus2qEASWSWuvaen/OnU4cHSdiYrelGfH2Rk
         zEiG4hSzmSmGEZb0QgKGtNZx3EGSVYx/XmqfBps9mNaR9LBSfeZ49wyBHm5NcidI9oKB
         wjUg==
X-Gm-Message-State: AOJu0Yzmo0RYEPv4C+j7Neq5l0AbzYMPsLe6kx/0dBu66bvvSSZR73Y8
        mQRm7yPmq5omkS9obV/vizsWFg==
X-Google-Smtp-Source: AGHT+IHtRRYP0xi4EcqzYyTvcNrVFeQgKflRTd3luTug/5jCAn+dkgbCAWC4JjZKn8Y1qVNAZQ1H4w==
X-Received: by 2002:a05:620a:4553:b0:76e:f73d:65ae with SMTP id u19-20020a05620a455300b0076ef73d65aemr3535399qkp.6.1696350034567;
        Tue, 03 Oct 2023 09:20:34 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id o8-20020a05620a110800b007756c8ce8f5sm574520qkk.59.2023.10.03.09.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:20:33 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] irqchip/stm32-exti: add missing DT IRQ flag translation
Date:   Tue,  3 Oct 2023 12:20:03 -0400
Message-ID: <20231003162003.1649967-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32F4/7 EXTI driver was missing the xlate callback, so IRQ trigger
flags specified in the device tree were being ignored. This was
preventing the RTC alarm interrupt from working, because it must be set
to trigger on the rising edge to function correctly.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/irqchip/irq-stm32-exti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index b5fa76ce5046..cb4b195bc849 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -459,6 +459,7 @@ static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static void stm32_irq_ack(struct irq_data *d)
-- 
2.42.0

