Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691CA7EC918
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjKOQ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjKOQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:59:30 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E27818D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:27 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b3f6dd612cso4109249b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700067567; x=1700672367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcMpSzqjutwlYPIEdiYUpdYZXwsHBg8m+KC9MOwgURk=;
        b=syUI3lLmIJYQIcCtOAY/f2hzhpR8GXokxDW4Gc8wgIM67VeC6RQBqJDlr50ghh0TNn
         veGyOclukrJqKxj+4beCV7Owv0DRKm1amImBL7CwxfYWLShikJSFYWVBzSnVItc61caT
         p17JX/GbWTj1VF125mgzdZQ0xGVzKSbfT+MqsDrUH5uJjYRwcowGKKITs5oevCvL9wpe
         QPlRcaD8uxMJ1NoEXJNU73wWeQyJ8aR1OgNctA7bwcP4Cqh1obeUsUFnNm3aCJkT1o5j
         YCSSjxurdYfr2WtXtfA91Qyy8NlQPpq2Pe9/weq9eKnAoUThh1AH0CV/IBmd9gnrXOf0
         KFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067567; x=1700672367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcMpSzqjutwlYPIEdiYUpdYZXwsHBg8m+KC9MOwgURk=;
        b=CRg44im37taW/BA5g7ekI3Za3a7OKuoqEDxMgRkZivGhbD0OGVOjxqSBDmQrmyW2da
         w+LkyvxOt3WKXCsdHBE1m7plGVwlZtrefVJYjjt+Xsc/ZFfnSvXlADmiQAfyfKSOq0xK
         yDsv9wk99iwcahnYQ3PKibiN2Jl7Hu6baVK3NOYu6kzoZKwm98bRBVk6rTM6FRsZTGxc
         lDn+N+8tGSULGZ3x0W2ZP/2Y9uSMfx6yy7jsfpdUcnVAfkvjQf9JinaMZcrRl246PCg/
         DH9ygMqTvGhoL7T0jWtQ1rKkMvUPLVVJt0OLjJeWSk2lqW2Pbbv8w8xIBMdk+pQnBpUK
         NADw==
X-Gm-Message-State: AOJu0YziR4/B7WXdpN/T4waKoS+NEEBx3oq1FoJl1Tg2adBXLZi0+TSM
        8qWI0ROlZFjZ33BemXuZKOaupQ==
X-Google-Smtp-Source: AGHT+IFiVYijihuiLI/wGZ7+Q7kE2IwHAKQwrq2XLh7SyeBYYXbFOAEhWE38PE7jQ16/mnbobB8S8A==
X-Received: by 2002:aca:231a:0:b0:3ae:1358:fafc with SMTP id e26-20020aca231a000000b003ae1358fafcmr13854932oie.58.1700067566916;
        Wed, 15 Nov 2023 08:59:26 -0800 (PST)
Received: from brgl-uxlite.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a449300b0077772296f9dsm3572219qkp.126.2023.11.15.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:59:26 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 4/4] genirq/irq_sim: shrink code by using cleanup helpers
Date:   Wed, 15 Nov 2023 17:59:15 +0100
Message-Id: <20231115165915.2936349-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231115165915.2936349-1-brgl@bgdev.pl>
References: <20231115165915.2936349-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1

