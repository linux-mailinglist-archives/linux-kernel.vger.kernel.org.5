Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A780A961
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573994AbjLHQjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjLHQi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:38:59 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B1122
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:39:06 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d1e1edb10bso20978855ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702053545; x=1702658345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qClH/dmb4dd8NvoxQgSGLWHH5ynl+Vk8/w8MUfygRqg=;
        b=IMUZoIISm2MZissrFi7PNBi+HMRD9lahgMEK0g1Jb9qDhMXH6ySO/1JozMJY5j4Ii7
         ycMNEid+YOQs5H+7D6ndio0BRyKjizOSIsEX006HxMCv/SPvxZQEez4nWROJH5DWsrbn
         35LJ5cqN3ygpzXyCzlAB/cjob3MBZSQU/e4Fk3qzDiIyUfLpZlHv3RmNHI5lC7Nkq3WD
         Nvw5JB3PqCzpya6gD3UGjlvu9iwvNtaMpDn2LW0OES63g9pM/XIcs6bvVpdxL9JzPIji
         HqUblo8COINBxexZcrjs+pwEv+wh9aXyxhwJppI5hFHZwsWmHpQOojierjV3/Yrm99JA
         BpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053545; x=1702658345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qClH/dmb4dd8NvoxQgSGLWHH5ynl+Vk8/w8MUfygRqg=;
        b=kv8rNl3/FpLz7d+23YXmIdDCPKKm6/gMJ+8ScsljudZrgXp3vyuicndmDFVxV3/LdA
         Bsjk/hporOb1E7CulyMvbwnEMDRyVABaD1cGMsS7+6wJKVNQVjGaxpg5zefU8kLncuGP
         bB5LeH+ZwjXp1WnqRrEs6JgI9UE2uoiYy38NXnhGeFXtbgrQLlhfQkFta7mNsVTVURmL
         283te1iUSJcycxXXD8Z90v9Wb4ssiAxj/2mg0Uht6OZAWKEWL4B+YFlV2g/6r7sDvnxT
         PRn1iZGO5sV+mSGnStDD1c1hBKFvmIGts9+F9dJ0SyZ9a9YEOV73nbUAG3V4tHlusHOC
         Bq4g==
X-Gm-Message-State: AOJu0YzhXXAwG0ecdy3besbP+EzTkgpzFuONOZlQDHcQAloTf7otysJg
        bCM8/crn+z9wZofN2rQWzsDsw+SH5z0=
X-Google-Smtp-Source: AGHT+IGwcQK1ysRvz5vz30yww9DIQpt0mFoDDye9l9lu24ozOhLSvHylyQogBovTOYkgay5ZitWBfA==
X-Received: by 2002:a17:903:11c8:b0:1d0:68a:4a46 with SMTP id q8-20020a17090311c800b001d0068a4a46mr356970plh.3.1702053545322;
        Fri, 08 Dec 2023 08:39:05 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:8e03:ae0e:87b9:6e6b])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b001cfb99d8b82sm1896960plg.136.2023.12.08.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:39:05 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] irqchip/irq-xtensa-pic: clean up
Date:   Fri,  8 Dec 2023 08:38:57 -0800
Message-Id: <20231208163857.82644-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- get rid of the cached_irq_mask variable
- use BIT() macro instead of bit shifts
- drop .disable and .enable as they are equivalent to the default
  implementations

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- drop saving/restoring IRQ flags in .mask and .unmask

 drivers/irqchip/irq-xtensa-pic.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pic.c
index 0c18d1f1e264..f9d6fce4da33 100644
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
@@ -44,34 +43,30 @@ static const struct irq_domain_ops xtensa_irq_domain_ops = {
 
 static void xtensa_irq_mask(struct irq_data *d)
 {
-	cached_irq_mask &= ~(1 << d->hwirq);
-	xtensa_set_sr(cached_irq_mask, intenable);
-}
+	u32 irq_mask;
 
-static void xtensa_irq_unmask(struct irq_data *d)
-{
-	cached_irq_mask |= 1 << d->hwirq;
-	xtensa_set_sr(cached_irq_mask, intenable);
+	irq_mask = xtensa_get_sr(intenable);
+	irq_mask &= ~BIT(d->hwirq);
+	xtensa_set_sr(irq_mask, intenable);
 }
 
-static void xtensa_irq_enable(struct irq_data *d)
+static void xtensa_irq_unmask(struct irq_data *d)
 {
-	xtensa_irq_unmask(d);
-}
+	u32 irq_mask;
 
-static void xtensa_irq_disable(struct irq_data *d)
-{
-	xtensa_irq_mask(d);
+	irq_mask = xtensa_get_sr(intenable);
+	irq_mask |= BIT(d->hwirq);
+	xtensa_set_sr(irq_mask, intenable);
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
@@ -81,8 +76,6 @@ static int xtensa_irq_retrigger(struct irq_data *d)
 
 static struct irq_chip xtensa_irq_chip = {
 	.name		= "xtensa",
-	.irq_enable	= xtensa_irq_enable,
-	.irq_disable	= xtensa_irq_disable,
 	.irq_mask	= xtensa_irq_mask,
 	.irq_unmask	= xtensa_irq_unmask,
 	.irq_ack	= xtensa_irq_ack,
-- 
2.39.2

