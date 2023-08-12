Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389CF77A26E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjHLTpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjHLTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:45:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E1A1709
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:45:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-319559fd67dso1960532f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691869510; x=1692474310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m1FhVU2PW8VL4/Q99Z7ioPQ3obrP19JMtvG/2fDn+w=;
        b=s1hLnMvqm74G/xyYSuKPu4JjPsHeCAfstE2crsToeQ4KO9S7Spf1lYC6vKC1ClCgLA
         8txrJyw+UjkqsjGbNPR2lxOiP642jcNKe8K8ibG423NTTw76xWdQL8jvdIwQV/HBHrqr
         2koCXbwZtJwVWqkjUS5g2Ievkla1uLwGFu5NEITNXy7T0DC/3GROu+gKkERFS5hReTjx
         MQTrD+u/MA6Q/1d8Nl6OwhMsdtn4wB36Fp6JgTOA4wJ2l0iRyu8YzVaP4FUUuysC7jFR
         pBZMHZut2vVzRoTdUQNx+1cwThHgSc2iRwS47D++HxbnjhPcKMq/qLFhxiBBrpJYxEjD
         kScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691869510; x=1692474310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0m1FhVU2PW8VL4/Q99Z7ioPQ3obrP19JMtvG/2fDn+w=;
        b=Rf/gtVbnEP9fG80iGRplOVlxbqwwWkRe6XjfIdurZzrzu0rTzQY46YfJ6dnjyjklHK
         +2iYvexUmqjh6fVUa1RUVPU9eeCaaGl7nC6DQG7myWDS8HJtRnuSzuSjYibvkyk1NZcx
         8uyyuNcXJxF/yZT3XPpLOvJVxaeDKhqlLBSv7K8H9HZOAtli3N+8scRSlnskcUSxj+76
         mlCtuXED4W6WSbq6ZXOrjITo8vfFGAcd01L5D4OJr2rOGtvpgig9STyf4qhkHZdPgjD3
         pLlu3m1NqLkzyBFfd80nBtZGw389Sv5DBTqmfq3LiZ9fFC62uztZHoYtBn+dZCsP48dA
         Shkw==
X-Gm-Message-State: AOJu0YzZCq70uFeJEVxLQU4UpQHKR8snnr3iSsXSHeKSVMqcJ/nZzt5u
        UHuwWItXgkWsNlgGlbesfocHoQ==
X-Google-Smtp-Source: AGHT+IG0Fc4YBke8xRxtqmaq32uT1f3XFVbn0a4UCssZJQuEMUz8Nsx5GQ84Og/7YTQCxVODPjZhxQ==
X-Received: by 2002:adf:f041:0:b0:316:efb9:101d with SMTP id t1-20020adff041000000b00316efb9101dmr4575031wro.25.1691869510160;
        Sat, 12 Aug 2023 12:45:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74c0:22ae:ddb5:1bed])
        by smtp.gmail.com with ESMTPSA id y7-20020a056000108700b003188358e08esm8813765wrw.42.2023.08.12.12.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:45:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/4] genirq/irq_sim: order includes alphabetically
Date:   Sat, 12 Aug 2023 21:44:55 +0200
Message-Id: <20230812194457.6432-3-brgl@bgdev.pl>
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

For better maintenance and readability keep the included headers in
alphabetical order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/irq_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 2c8a9cc1faa6..a8b013d0c5be 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,11 +4,11 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
-#include <linux/list.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
 #include <linux/irq_work.h>
-#include <linux/interrupt.h>
+#include <linux/list.h>
 #include <linux/slab.h>
 
 struct irq_sim_work_ctx {
-- 
2.39.2

