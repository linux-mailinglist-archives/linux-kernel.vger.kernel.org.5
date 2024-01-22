Return-Path: <linux-kernel+bounces-33045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982A08363C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B09B2F62D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8033D544;
	Mon, 22 Jan 2024 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZsupBBYv"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3283CF7E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927377; cv=none; b=GjwqrNUupvSNf1BW/Yrsd+Ax5gsx1uOmhFZIKhC3JgeohK2tSuAfkcD8AZEPNgnxmbCdqhE5F7amG603DFp7eSLIx4Y7vjoyXYATsMhaBR2mjnqMfEZ0I0tTw6NbtvyP+anQZxPZs9QVyIrXwbYgSqm17FpMmCac5b+Ki6mlXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927377; c=relaxed/simple;
	bh=fGUJHqKDbHbau/baYI1WJnLw0RqVDU52GxAaio5Tj4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOyDM8g45xvsbkwoiCaXUwuEmh/NTgEW4C2Uvdg4fB4wHy6LfOqL2yK8VkMaK2k4p4/xcJOaea1Y+hv+u973eMy8jfpZGDBB7upsmhFOBIgHn215l9MGh9TE/sEk4l7YjQKwkmp+/3ItIUEESJHWscxNkJgT7sO36cnZcI56mg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZsupBBYv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-339261a6ec2so1742383f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705927373; x=1706532173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcMpSzqjutwlYPIEdiYUpdYZXwsHBg8m+KC9MOwgURk=;
        b=ZsupBBYvENiuYr+21KQ1yRv22pSfhiL7e1geqUl1lKekMj/Wrkqmw+nuKzlCg0nvV6
         zwLRE6uoLMi/1QZ9qYRCj4iDEaqF49ltX7TtwMOSHh05yMjxxVhixpcOLi+hHGFz+x26
         Fxt8TM0gpZlm94XjnSmqnphQ+P4ZdOOexwehMnD57l+Ms7JJuzH2HdIiCiKkxzZi9V8K
         TtCK6vdMv5vfohZ5MiEv6ae9wy2kE0iOqvEKV++OA6acJ18VCAtQe4wDTaUE6R9+XI2O
         AJ4mTDLol2gdG3LHMfHCvdbE26JF24QcX5jVHRXRA9vCQajRMOML8W3FHybaX9lS0+ZC
         o+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705927373; x=1706532173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcMpSzqjutwlYPIEdiYUpdYZXwsHBg8m+KC9MOwgURk=;
        b=AFenLOctWCu7vT7LdvX+0D348x7+skb7osLgXsvETm0UC4MouHE3TXeQ1OlKNYGvOM
         uHC44Z/VysfcGdP6NBQmweZVEeY818IIvV0kfD0nEuFL+wGX9G/pilX2i9ik+/t9UCBS
         CIh9s+wWozkWaQdrqajlq4W8z7EoDTjFY7/Sc6dnvf/PMEzfgvp5KdRMauWV02fx764/
         bTkAgLesxrL8qeTmJZqXjdCwGPnBVYad+uL6q+BpTVC9a0QtXQom4T7bvP/DVS0B4Mc+
         sT5Y4NYVgm83kJ0fK0OvC7sj0IMXMN5KZ7yd4rWnIP+VFoLrMaLd7t7E6rabh1VZFZUt
         cjSA==
X-Gm-Message-State: AOJu0YxVEm6uVk+E2FdKvqtksrhX53KA/EDTZvwJ8vW8EoYyQ9uPfcQM
	i1NPlfRLQg/AIo/efBFio4Dh6eZI+x+LPpN6JZVrwH/o8czBf9S5Wtv3c/xkrhA=
X-Google-Smtp-Source: AGHT+IH22P6MqrwZ/7q699Gv8A2fIErhhA67HcT8Go3fyXfYSzeWRuON27J3QBW6iiyxcJTPhmH4Ng==
X-Received: by 2002:a5d:4e46:0:b0:337:bfc8:588 with SMTP id r6-20020a5d4e46000000b00337bfc80588mr2231237wrt.125.1705927373588;
        Mon, 22 Jan 2024 04:42:53 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:92a0:6172:d229:1898])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d5110000000b0033763a9ea2dsm4671771wrt.63.2024.01.22.04.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:42:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 4/4] genirq/irq_sim: shrink code by using cleanup helpers
Date: Mon, 22 Jan 2024 13:42:43 +0100
Message-Id: <20240122124243.44002-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122124243.44002-1-brgl@bgdev.pl>
References: <20240122124243.44002-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


