Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E4F804FFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjLEKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbjLEKOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:14:17 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFBF1FE4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:13:35 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d048c171d6so36319855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701771214; x=1702376014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdqOzncncpwf4xUIJqsgSmAiTDjCBuNO33Ry7aWo1/g=;
        b=h6MQIfqIP55Eq5E64us3bI+OERQ9eW9LP0J1wPFTMRVtsLalZcfUw944/Z/c0FMTVE
         vGsJSyQyEbSoMqLEWnnY4hWvZWhhmAsnK0CObr+g3nW0GikRrzsoG0i9cCPrW14Zvcty
         t7X3FLzdDOdhInhkkAXwgFV9+epmR/XblBCzPqVkvetIiFPUwqhLpGQ8oBR0IUCK/X6K
         lPKTK1+O3GZiL7OlKDteOBDkogVJcT5BdR+ZZe/pQb7/oZ9yvmY5R/TU7x+vnw+GSu7I
         M1DrJ58UIBLIB37Sm60EizVkLoneeSga/8hVMNBOZNTlLwLHugQ122he0cMu+w9WIYYp
         aIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701771214; x=1702376014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdqOzncncpwf4xUIJqsgSmAiTDjCBuNO33Ry7aWo1/g=;
        b=jV6aaCnZEiitKfD7Qp/AV6+dGVCeqFxPTpefCyNv5VmJ6CZw+iQe2kVCrkwXJlJFo+
         wLdzv7KjywKCJoUCZcTruSEnuH3PJEJp+zKJqx+1po1YrPWYiU/m4gFNh0sXlrjfx6pF
         qoPI4Gqnek77Aos3E/t9ES/fqwpY+CMg2FFZuUM9zZQ7k+CSOFPjhUPL9k2hxDY9wPzA
         N6LSvW9rAW83dNRVXfC4wadHqe6z+1mjNJpo0XpbxDXL6s6lxzeymEyDW8yIqIrN+sqA
         hOssCSBOaYNnRVU8F6tQvIQhy/gD7DIABYKhmbjEZQbovHG1N3u6TfjyEyMu6faVE+6i
         axxw==
X-Gm-Message-State: AOJu0YwI8vQ/KMDuU63Z7AzOlEivT//AapoYJnEXuf5XubtYJiCkhvVX
        QXNMSKB8/ltNhnI8J3OAqAUWdg5kqNs=
X-Google-Smtp-Source: AGHT+IHJsO5FlkGUkT5sQpjwBb/65BDfgK1rwGAd3ckMYS4Bfs3S2Q9x2U0+Ts94N0K0Bh+txm5EFQ==
X-Received: by 2002:a17:903:1250:b0:1cc:5e1b:98b5 with SMTP id u16-20020a170903125000b001cc5e1b98b5mr5763212plh.66.1701771213969;
        Tue, 05 Dec 2023 02:13:33 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:b349:613d:8160:cf11])
        by smtp.gmail.com with ESMTPSA id bh12-20020a170902a98c00b001cfb41589d5sm9803237plb.27.2023.12.05.02.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:13:33 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] irqchip/irq-xtensa-pic: clean up
Date:   Tue,  5 Dec 2023 02:13:07 -0800
Message-Id: <20231205101307.1303186-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- get rid of the cached_irq_mask variable
- make mask/unmask operations atomic
- use BIT() macro instead of bit shifts
- drop .disable and .enable as they are equivalent to the default
  implementations

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/irqchip/irq-xtensa-pic.c | 37 ++++++++++++++++----------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pic.c
index 0c18d1f1e264..ebd1b77c4d11 100644
--- a/drivers/irqchip/irq-xtensa-pic.c
+++ b/drivers/irqchip/irq-xtensa-pic.c
@@ -12,6 +12,7 @@
  * Kevin Chea
  */
 
+#include <linux/bits.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
@@ -19,8 +20,6 @@
 #include <linux/irqchip/xtensa-pic.h>
 #include <linux/of.h>
 
-unsigned int cached_irq_mask;
-
 /*
  * Device Tree IRQ specifier translation function which works with one or
  * two cell bindings. First cell value maps directly to the hwirq number.
@@ -44,34 +43,36 @@ static const struct irq_domain_ops xtensa_irq_domain_ops = {
 
 static void xtensa_irq_mask(struct irq_data *d)
 {
-	cached_irq_mask &= ~(1 << d->hwirq);
-	xtensa_set_sr(cached_irq_mask, intenable);
-}
+	unsigned long flags;
+	u32 irq_mask;
 
-static void xtensa_irq_unmask(struct irq_data *d)
-{
-	cached_irq_mask |= 1 << d->hwirq;
-	xtensa_set_sr(cached_irq_mask, intenable);
+	local_irq_save(flags);
+	irq_mask = xtensa_get_sr(intenable);
+	irq_mask &= ~BIT(d->hwirq);
+	xtensa_set_sr(irq_mask, intenable);
+	local_irq_restore(flags);
 }
 
-static void xtensa_irq_enable(struct irq_data *d)
+static void xtensa_irq_unmask(struct irq_data *d)
 {
-	xtensa_irq_unmask(d);
-}
+	unsigned long flags;
+	u32 irq_mask;
 
-static void xtensa_irq_disable(struct irq_data *d)
-{
-	xtensa_irq_mask(d);
+	local_irq_save(flags);
+	irq_mask = xtensa_get_sr(intenable);
+	irq_mask |= BIT(d->hwirq);
+	xtensa_set_sr(irq_mask, intenable);
+	local_irq_restore(flags);
 }
 
 static void xtensa_irq_ack(struct irq_data *d)
 {
-	xtensa_set_sr(1 << d->hwirq, intclear);
+	xtensa_set_sr(BIT(d->hwirq), intclear);
 }
 
 static int xtensa_irq_retrigger(struct irq_data *d)
 {
-	unsigned int mask = 1u << d->hwirq;
+	unsigned int mask = BIT(d->hwirq);
 
 	if (WARN_ON(mask & ~XCHAL_INTTYPE_MASK_SOFTWARE))
 		return 0;
@@ -81,8 +82,6 @@ static int xtensa_irq_retrigger(struct irq_data *d)
 
 static struct irq_chip xtensa_irq_chip = {
 	.name		= "xtensa",
-	.irq_enable	= xtensa_irq_enable,
-	.irq_disable	= xtensa_irq_disable,
 	.irq_mask	= xtensa_irq_mask,
 	.irq_unmask	= xtensa_irq_unmask,
 	.irq_ack	= xtensa_irq_ack,
-- 
2.39.2

