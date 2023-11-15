Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795717EC916
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjKOQ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjKOQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:59:30 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E2B18B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:27 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-779fb118fe4so430661585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700067566; x=1700672366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MictaQTnmuvgryOODFf0I7jgiEaNRAnJ9k//p/ysG8=;
        b=ITD1ASAkI+b8tfhI4zCWxM/utvoQOgePsjZ+Z81MQJZ6okrYxscBY/ofAxMzUm3pcw
         Yh6xlLDTQ5agriG8EC8SMa94ukjF8L9oIWPOPgLXikyYcbTH0BdCFi7lG4BVfH0f6cua
         9Q+2vjtVzfuu79FZEhBfamQ9QLJzXEx8tJWk0NFmy1IfX/HO06Q8eU4qgnFJ2tkBW+EZ
         juXYrlZe32mZXJ2PBAgCb+XCmcSchacHKHBmoG5oprh22qK2yyPNyTaURZE7yF7tz71z
         CkGfJVJRhGLWGNzr2aZXSKu/CGz9/RgCHEMSu6tcKK6LlObW0SdSp88/F+x8CrtTiMwE
         wQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067566; x=1700672366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MictaQTnmuvgryOODFf0I7jgiEaNRAnJ9k//p/ysG8=;
        b=e8XCgUat3VTzwLpXENW5itNn0jrsb/T1Q6K2kgFWUzfj1ZRv/A8ImNckjdB7F79i+M
         coOqc7JWuhcOC3n1EPsgciob3REMkh2v55nU1JeFLtGIceX7pkxVCT5Wlm2DLtj8OXTW
         UYpArqGnP8B5uVKfTF2W+gZwbOIhmq8/j/aHPGgicgqGGika7TGFHNmYpv2gTCA2UyeT
         DPpBvFkkrMREumWpvZXkbQmTI2QF+tz2awVtQ1SIRaaxZE1OTJvyxh/yRNVn6H4TkHXv
         BKy1LdbyPR4EDSUoai/T/gu7O3bmAIzkRL5T5PztiEdE+2e4uNxOxz88HvU4+Ab3KXYE
         xfnQ==
X-Gm-Message-State: AOJu0Yxb/PxiGdTy6yZ/4T1+amPNoxBxwCtELqJULLfqtaM/nWvSbJwQ
        EGURG+BI0SJVLAyAxfSMsBx7tw==
X-Google-Smtp-Source: AGHT+IHUtverX4BcpQYQki4gdNw0YWQtAJTVJf5nAbOYCpJCBnzP95b/CzT6OCvayqiRgCEzzB6Y1w==
X-Received: by 2002:a05:620a:3a4c:b0:77b:aaf8:df98 with SMTP id sk12-20020a05620a3a4c00b0077baaf8df98mr4743966qkn.69.1700067566227;
        Wed, 15 Nov 2023 08:59:26 -0800 (PST)
Received: from brgl-uxlite.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a449300b0077772296f9dsm3572219qkp.126.2023.11.15.08.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:59:25 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 3/4] genirq/irq_sim: order headers alphabetically
Date:   Wed, 15 Nov 2023 17:59:14 +0100
Message-Id: <20231115165915.2936349-4-brgl@bgdev.pl>
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

For better readability and maintenance keep headers in alphabetical
order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/irq_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index f5ebb3ba6f9a..b0d50b48dbd1 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,10 +4,10 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
 #include <linux/irq_work.h>
-#include <linux/interrupt.h>
 #include <linux/slab.h>
 
 struct irq_sim_work_ctx {
-- 
2.40.1

