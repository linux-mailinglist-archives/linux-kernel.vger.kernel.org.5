Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEF179CABB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjILI4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjILI4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:56:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A567CAA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:56:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31f737b8b69so4880601f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694508963; x=1695113763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0GSkSsBN1wyMRXDMHKAiDApaGJ4YO7Sk/7sv4md1Ps=;
        b=AxLuEctBWuoOz0QPbt5I6ffnds/54T799jnlbiT7SzW7JS6qbBcaVZJ47hxwcctuFc
         lypQrNhpC+BcxCqM3g1j25Vx6x8jSaWqzHaEPUc2IIWyM9wnIJQwmQqIGzQkcbJR0302
         GPjX4OwXyL49io6wl/El1mAgPei4bq+pruDf+Gf+0I6SHAy/TqvthrPzIUiLZ4Ex+WkJ
         mxY84AmixdbPewKtXwuD3UTxJxNCALr7e0+VaMJhxjE2yScD83u5NAppWSD0lUtTNFLu
         6jtt/oML0RMhoJhzmIhodPxNrffpPBSJSUNhW4WbTcB1OvwWNOCxXJuAYlCD53r4Oe7s
         v+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508963; x=1695113763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0GSkSsBN1wyMRXDMHKAiDApaGJ4YO7Sk/7sv4md1Ps=;
        b=php4qpirTkeJzbMFDNMOBG2xS3uABVN3Fq1BLT5GKi5fAK9JjF5zLiSC8R9UPHAHEx
         HEdaPsRKsRTiZt1lb+23VWykaq0/Pmi+wUCKHmGl90PE0/AnMut4rqCPwph8CipdBiuD
         0o4PJl6CtqgbihTr/So1bNKe2E9DTyxSOWxDBgg2ZdR8gLrRA0IWrD1+nZ9JqLI10J9y
         ChJQlsPnJKTBVzn3wmSdyfKBmdbsCdHFKSKe2QAh2E2qgF6npxkT2oFYOxbltEb3qJUz
         yM2rt51F1mWk8gIzf0pJUNTZ7xEPJKwuOTuPT+damOuPcIVMvPcWdjWHMC4bIr+aXR39
         RnTw==
X-Gm-Message-State: AOJu0YzptXpoxs53Z2TvdtHvD1sPGnT8wYViKiWjlvistgyP8Ee1o85Y
        4pk3nFowX/mNqHjJ+dGPbxwjx89/mf1qiICltAQ=
X-Google-Smtp-Source: AGHT+IGwDIPkFn64tdiDwF/U8wlhvYO6WZMan4vk0QfnDLhTFT7jlM4KVavq6RZ2aUwvI/tB5zvkew==
X-Received: by 2002:adf:e743:0:b0:31f:651f:f850 with SMTP id c3-20020adfe743000000b0031f651ff850mr9470113wrn.36.1694508963002;
        Tue, 12 Sep 2023 01:56:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b00317ddccb0d1sm12310028wro.24.2023.09.12.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:56:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 4/4] genirq/irq_sim: shrink code by using cleanup helpers
Date:   Tue, 12 Sep 2023 10:55:41 +0200
Message-Id: <20230912085541.13682-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912085541.13682-1-brgl@bgdev.pl>
References: <20230912085541.13682-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b0d50b48dbd1..24d10267f582 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
@@ -163,33 +164,28 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
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

