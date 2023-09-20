Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598997A74F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjITHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjITHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:55:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7497
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:55:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so1344742a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695196519; x=1695801319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+hhScSa68yGcwdNh6Yw39YhA0WpD2wyeMxz+ezDQj8=;
        b=SuO+tIgyu2ompYirr2AZN/z6fLFdTDh3SDXLOiwIVojIpx1WVcEKuwZG1g9pcQ/YzO
         rQdptQNrNQ0qD7IKVhrekQMxmdR8XeDzllJszz8EWF9SaibBLcltyZE9IrMhJY+a2zsh
         fsxL/raG2VCTTSqvH2Ls0kDv1S9D0Pv0wZVcDV3HhovjU6cfWLutwVwKDpvu4DsCrSiq
         DpEOSEwsu4skiZlEa85c89SQREaTPoPoBFw/pBGNgjMoZ8lcWRAx06ZkFqfQNzubGKEn
         ukkSdPhI4uwkB3mVs8sXnWi6rzRVYgzNGfq7gQ11LGLGmfcDRV9KcOaz7+FjhJbh///O
         11zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196519; x=1695801319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+hhScSa68yGcwdNh6Yw39YhA0WpD2wyeMxz+ezDQj8=;
        b=LYjQhxsp3QBDzLSbKYiyXLuOFPCphLcETSgHDNFBNB+hgHhwgKlCc3hO+I53IWA7w5
         hyGB/R7p78rKMcvVtKkyh0Yo65LgipFXvexP2nbtjHa8mgnNeeT09CBvJFWpQJH3/q7i
         HTRRXx1jRyJMglId2gTv2a1iRuJD1rIfcRV9v27MFDsVHi36ElEAWqmxipaTD8XcTRaa
         8g/dHKZS7fk9ADzuT3s7f4viiLyiRNDnzDEIZ7B+8Ty1bfi8mEXot//UlUjyxNO+hmNu
         +kZpteIQ2LX/9PcORlWGQibmQrGtxIMAHclJoQ8dcuC4WyxgpObWeXBT2y5jXCNEL5VR
         tmhw==
X-Gm-Message-State: AOJu0YxPaN9xfh7ggKXKYGS5FSwGs5XfiIMao58S6lmoZlskBNFWThab
        52sIZvXqMLcuCYtZwV6zqQ07cQ==
X-Google-Smtp-Source: AGHT+IGT/coOXP4Dw0eIT751zWvicwOSP0GLnyBBKNWIYK+3BTZBYpJ89H66fmPvz4TzD+JFPx1ZLg==
X-Received: by 2002:a05:6402:2803:b0:532:7daa:e50e with SMTP id h3-20020a056402280300b005327daae50emr6306611ede.6.1695196519343;
        Wed, 20 Sep 2023 00:55:19 -0700 (PDT)
Received: from brgl-uxlite.. (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id d9-20020a05640208c900b0051bed21a635sm8481981edz.74.2023.09.20.00.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:55:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 4/4] genirq/irq_sim: shrink code by using cleanup helpers
Date:   Wed, 20 Sep 2023 09:55:00 +0200
Message-Id: <20230920075500.96260-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920075500.96260-1-brgl@bgdev.pl>
References: <20230920075500.96260-1-brgl@bgdev.pl>
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
 kernel/irq/irq_sim.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index b0d50b48dbd1..82b7b5051249 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
@@ -163,33 +164,27 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
 struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 					 unsigned int num_irqs)
 {
-	struct irq_sim_work_ctx *work_ctx;
-
-	work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
+	struct irq_sim_work_ctx *work_ctx __free(kfree) =
+				kmalloc(sizeof(*work_ctx), GFP_KERNEL);
 	if (!work_ctx)
-		goto err_out;
+		return ERR_PTR(-ENOMEM);
 
-	work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
-	if (!work_ctx->pending)
-		goto err_free_work_ctx;
+	unsigned long *pending __free(bitmap) = bitmap_zalloc(num_irqs,
+							      GFP_KERNEL);
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

