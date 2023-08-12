Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37E77A205
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjHLTpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLTpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:45:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B11709
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:45:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3175f17a7baso2548663f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691869512; x=1692474312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqGzC2rPtSOCIseSAzI0v6TAcmqcvlICgEZd4/z4SME=;
        b=iE2Ry5jpWvaNdC9+3pnYEE7ur4MaY/wJO14uDOB4rW2L+ecLZxcoFlFCARAiRtShiw
         99Pw58zQc2ycvMcfmOchgs3y/8hWnTb6fdZLgKD16Y8JfQavYpt22fzkANJofbX4elyU
         I67kdYcid7Iq6ndFIiN29m0ei7l0Pk8myn2Az1A8UWhqGthmS+fhWlFI7pMW4Ux9sUU4
         Ec9tKhldHtf7krdOv1DzVO3nX8Cm08hD0GT25Jt3Fq9M1d/TapnN1mM9sJqJO/B5TEua
         hXo/ymuqAiUF75ICjLX36orB0LpkNQakKRvRsVbn6cvTXfaieGLal19+CX60jPGGMoMB
         APFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691869512; x=1692474312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqGzC2rPtSOCIseSAzI0v6TAcmqcvlICgEZd4/z4SME=;
        b=VGcyjPMZ1tvS7v42nAYqH+Xh2IYLd1mY1e7rMdtm8E9s/k6I0QUMheR50n84sMjm/l
         OyWNkneEiQvnB+467EeI3TJs7tmjmzVydc3KHvmhIYo0hMmTctE6Ns6B2nAAYJl0Nmfd
         hCEGoKqp8UuQcJITIZlXsOhNQuPlBiKOCm9aFTGeMGtu5N/zn6Y7uXM2WJLu3V23/D7e
         UDKWUcTv07VU5DSBpyvCSTAB/dp8K2bZFFVcUw0G8IegrBgXqKU2fxqvaQvj/AcWpz6G
         3SNBxxGMCgQN9KL80Y3eWXe77JgEcGTtbWBWKos78S9CXwH7vTN18bKC5N+5uK2TVuNB
         DzmA==
X-Gm-Message-State: AOJu0YxCHV6qFW2dPf1jPVJmHBOWCNAUlZsDxCNgeBcKzHl3Xxmy9Ehl
        tDvf+nDJPp0kyQ6u8cce80jWiQ==
X-Google-Smtp-Source: AGHT+IG1/moDx4srSfpMdO9YP5AYBHLtqKQIXqDZzDz59rPAFDLNj1E7YIMDBPo8dBvFHL2icjAANA==
X-Received: by 2002:adf:e30b:0:b0:314:11fe:c72e with SMTP id b11-20020adfe30b000000b0031411fec72emr4127557wrj.46.1691869511943;
        Sat, 12 Aug 2023 12:45:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74c0:22ae:ddb5:1bed])
        by smtp.gmail.com with ESMTPSA id y7-20020a056000108700b003188358e08esm8813765wrw.42.2023.08.12.12.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:45:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 4/4] genirq/irq_sim: shrink code by using cleanup helpers
Date:   Sat, 12 Aug 2023 21:44:57 +0200
Message-Id: <20230812194457.6432-5-brgl@bgdev.pl>
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

Use the new __free helper from linux/cleanup.h to remove all gotos and
simplify the error paths.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/irq_sim.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index a8b013d0c5be..202beb1169c9 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
@@ -170,34 +171,29 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
 struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 					 unsigned int num_irqs)
 {
-	struct irq_sim_work_ctx *work_ctx;
+	struct irq_sim_work_ctx *work_ctx __free(kfree) = NULL;
+	unsigned long *pending __free(bitmap) = NULL;
 
 	work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
 	if (!work_ctx)
-		goto err_out;
+		return ERR_PTR(-ENOMEM);
 
-	work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
-	if (!work_ctx->pending)
-		goto err_free_work_ctx;
+	pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
+	if (!pending)
+		return ERR_PTR(-ENOMEM);
 
 	work_ctx->domain = irq_domain_create_linear(fwnode, num_irqs,
 						    &irq_sim_domain_ops,
 						    work_ctx);
 	if (!work_ctx->domain)
-		goto err_free_bitmap;
+		return ERR_PTR(-ENOMEM);
 
 	work_ctx->irq_count = num_irqs;
 	work_ctx->work = IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
 	INIT_LIST_HEAD(&work_ctx->irqs);
+	work_ctx->pending = no_free_ptr(pending);
 
-	return work_ctx->domain;
-
-err_free_bitmap:
-	bitmap_free(work_ctx->pending);
-err_free_work_ctx:
-	kfree(work_ctx);
-err_out:
-	return ERR_PTR(-ENOMEM);
+	return no_free_ptr(work_ctx)->domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_sim);
 
-- 
2.39.2

