Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFD977A202
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjHLTpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjHLTpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:45:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E44E172D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:45:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2670633f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691869509; x=1692474309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CULFRDWFN10t8WpABLavFhKN9lFYe5MwzKCycwxtDA0=;
        b=32Wo5/7gD3kHVG2bE7C5Dzqrysadnty+I+hXXbUgh9vb3DgUc7Fg9UpWrFBbT1wRnW
         n/0LkcJfMnKLYCPHu57InOS0ntLiQtnRYgihfe/oUAF9nTiRO+uSK9bwnKOEEVQyhBp9
         IQQ2WGk74NBLakCAWcdHzIy+7qb/JaWl/oSmAkfr0kJSoITs+CvtAsvyZYAH41cHr5WN
         ijC5SH2W7Rmqj9f9t3l/yurmz5MH0+dETzInktolZwdCh6qZ+8B/9hOuBJh8I5wTiJIQ
         f+kqGxF2SBI6mVblj77knt3z918/RnjpcDRhQlDUVP9bjVpZol9ijMzvIU7uZtnZtzKi
         hLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691869509; x=1692474309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CULFRDWFN10t8WpABLavFhKN9lFYe5MwzKCycwxtDA0=;
        b=T3sIz+leW7UxchEx8Erqho1D/dC1RqjO1C/7Q59lREDIdyveBpaCyqnv5X3/iKFrsj
         goog4sXXCucUQ8NLBaK8o13o2nvlrUojXrvesggvBWs9SXKI6bwiI8xx3DJfEVsxSLwl
         Z/xYTdMTDLsK7ge20nx2DBg541xMgbSTB74Qe3yyOEPnugIE/QTdReIxkyqbVcWGW9hT
         xl0vEFEk4qLJqre3ko290+tFD7GQWpn80wpA454EC8NwT1bht5UsjtOyW6NKrPxDYAn8
         tplgHmz/gLlRdld+B36E+GwBljoBKyIpPb5DWCaoAFw+ueU67Ax4RDJQhAQ2lAOIJGjw
         tAnw==
X-Gm-Message-State: AOJu0YwfSNiXYg4OAS2k6vmiQPvfR0x5MpuI+yB282WE7inH04w6ZAeP
        f6tYw0DaxfpWW4vTEuIDyajOlw==
X-Google-Smtp-Source: AGHT+IHad6FvE7qU9k4gHMbWO4EqorXMQ+Q1/KkCguvBXdZ+72TpClVUmgmnQei/pizoCGa+yTJP7A==
X-Received: by 2002:a5d:500f:0:b0:317:759a:8ca8 with SMTP id e15-20020a5d500f000000b00317759a8ca8mr3392769wrt.67.1691869509186;
        Sat, 12 Aug 2023 12:45:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74c0:22ae:ddb5:1bed])
        by smtp.gmail.com with ESMTPSA id y7-20020a056000108700b003188358e08esm8813765wrw.42.2023.08.12.12.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:45:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/4] genirq/irq_sim: dispose of remaining mappings before removing the domain
Date:   Sat, 12 Aug 2023 21:44:54 +0200
Message-Id: <20230812194457.6432-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230812194457.6432-1-brgl@bgdev.pl>
References: <20230812194457.6432-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If the device providing simulated interrupts is unbound (real life
example: gpio-sim is disabled with users that didn't free their irqs)
and removes the simulated domain while interrupts are still requested,
we will hit memory issues when they are eventually freed and the
mappings destroyed in the process.

Specifically we'll access freed memory in __irq_domain_deactivate_irq().

Dispose of all mappings before removing the simulator domain.

Fixes: b19af510e67e ("genirq/irq_sim: Add a simple interrupt simulator framework")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/irq_sim.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd76323ea3fd..2c8a9cc1faa6 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
+#include <linux/list.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
 #include <linux/irq_work.h>
@@ -16,12 +17,14 @@ struct irq_sim_work_ctx {
 	unsigned int		irq_count;
 	unsigned long		*pending;
 	struct irq_domain	*domain;
+	struct list_head	irqs;
 };
 
 struct irq_sim_irq_ctx {
 	int			irqnum;
 	bool			enabled;
 	struct irq_sim_work_ctx	*work_ctx;
+	struct list_head	siblings;
 };
 
 static void irq_sim_irqmask(struct irq_data *data)
@@ -129,6 +132,8 @@ static int irq_sim_domain_map(struct irq_domain *domain,
 	irq_set_handler(virq, handle_simple_irq);
 	irq_modify_status(virq, IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
 	irq_ctx->work_ctx = work_ctx;
+	irq_ctx->irqnum = virq;
+	list_add_tail(&irq_ctx->siblings, &work_ctx->irqs);
 
 	return 0;
 }
@@ -141,6 +146,7 @@ static void irq_sim_domain_unmap(struct irq_domain *domain, unsigned int virq)
 	irqd = irq_domain_get_irq_data(domain, virq);
 	irq_ctx = irq_data_get_irq_chip_data(irqd);
 
+	list_del(&irq_ctx->siblings);
 	irq_set_handler(virq, NULL);
 	irq_domain_reset_irq_data(irqd);
 	kfree(irq_ctx);
@@ -182,6 +188,7 @@ struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 
 	work_ctx->irq_count = num_irqs;
 	work_ctx->work = IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
+	INIT_LIST_HEAD(&work_ctx->irqs);
 
 	return work_ctx->domain;
 
@@ -203,8 +210,13 @@ EXPORT_SYMBOL_GPL(irq_domain_create_sim);
 void irq_domain_remove_sim(struct irq_domain *domain)
 {
 	struct irq_sim_work_ctx *work_ctx = domain->host_data;
+	struct irq_sim_irq_ctx *irq_ctx, *aux;
 
 	irq_work_sync(&work_ctx->work);
+
+	list_for_each_entry_safe(irq_ctx, aux, &work_ctx->irqs, siblings)
+		irq_dispose_mapping(irq_ctx->irqnum);
+
 	bitmap_free(work_ctx->pending);
 	kfree(work_ctx);
 
-- 
2.39.2

