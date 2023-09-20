Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77787A74F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjITHzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjITHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:55:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D45C2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:55:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5033918c09eso1205819e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695196518; x=1695801318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxpXhgDL+WYT4ZjQ7cMsLe1CH/MZvqWCA7Gdeim4PCs=;
        b=MPbd8dIcjKsOFEcJvJt7H7izZQeSXtMJPYD4w3Kg171bYAKiPmyJ8rEa84sB6NwVRx
         Nq27ll6KEdv6k52q3rrwbSgrsN+aHtNalJGiRPgJL1bkbcimYn2NQNKOPkANzViYvX8V
         6TG9c84/YOQA87xHd+0FVF4OoD9cYM5I0XOyZdAFRanuKFZUS1fbX8vFOSe93A/fp5nP
         rnj+so/EBObI4KAFd9fGHga3scTWiC6N9i5eGnxLmg5XsicQHNUidhPB5ma+2ywzN60s
         HTHatbBW0p9Wd01k57HD32QWVl+A3+9+X//tPjAvJ5pEauEkh2ZI0NyTt5YdKvBG4daa
         hrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196518; x=1695801318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxpXhgDL+WYT4ZjQ7cMsLe1CH/MZvqWCA7Gdeim4PCs=;
        b=cseVx8a8lsH71kmzJkodytBdFBknU2X7MUse6Gnc59Zbx4aLl2CT4KmHl8Zmmk3eak
         sCmzu83l+If73S1FCk75xIId+f7hWbZ8i2wqiRhxJ0+73uDPFk9/mXEneNHOQ+YvKgfe
         PJ4ywldr6mXZGCrtHFluBEo5u5v5AfOXxZJbkw+BYKoDl8P4wDaM6oPyOnUjKImXgnI2
         GVYr6OySWG+2LWo34KjGlF86T2eKl+CtfZXTObu9bUHtFVpYmLDePM4+v8PYTJqt/Xcu
         6vYHtDOTsRN1xgChMTj+Hk4boYIjLPnE1zJgNzA3E0Mo8xLTNy/KKFK0w9PkPWyrqDUS
         hZbg==
X-Gm-Message-State: AOJu0YxSaBzWCAlowUlK0/s/nR3lJPgljiygS7BCgJrfqlhgV+m5VS5L
        gcbtasFUBC47OADSGC5kylfXDQ==
X-Google-Smtp-Source: AGHT+IGgi716OSTmXEPCt0gS07zfGFz0XZMiSgl59FvqDlgT7KDpWgU4g/roFPYq3nL1GboCJgyqMA==
X-Received: by 2002:a19:9110:0:b0:502:fd08:69f7 with SMTP id t16-20020a199110000000b00502fd0869f7mr1618424lfd.28.1695196518530;
        Wed, 20 Sep 2023 00:55:18 -0700 (PDT)
Received: from brgl-uxlite.. (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id d9-20020a05640208c900b0051bed21a635sm8481981edz.74.2023.09.20.00.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:55:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 3/4] genirq/irq_sim: order headers alphabetically
Date:   Wed, 20 Sep 2023 09:54:59 +0200
Message-Id: <20230920075500.96260-4-brgl@bgdev.pl>
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
2.39.2

