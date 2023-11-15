Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B397EC90B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjKOQ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjKOQ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:59:29 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D89018D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:26 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b3f55e1bbbso4547328b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700067565; x=1700672365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhF5NthBM2Es9ERveXoYfwPd/Rxqijhgw0U1wdCYWbU=;
        b=GTG4fRsAFv8ACdLcIDpv2n+804xHtGxAN7wuJlz5KAQKiyureyQt8NAhzsU9DAmRc1
         NrQz/Ix3NTIWjeOOzUg3OUM5hZTFEjuo7GbN6ZzD1lNBH7FdXvbCAY3cW/nsgWbdd8pT
         Ylciofg1TpNn5BJehsLWDaW6yTnMDUJQ3XB1trpWTjmR2KRpeZAl78EcIhGNgMEQNzQT
         uFKAt32yFY5QsHXI/pFXips+gY3A+1GBQft/VyYL2iU+rYKhXbIsaByoXeCaBpbP57+t
         JRbIx2U43oH4zDE2/+y/SAjSk57davXDBZ4tCf+7qgNVYjeLuU8iLo4B0ymbYw+ajGAF
         crdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067565; x=1700672365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhF5NthBM2Es9ERveXoYfwPd/Rxqijhgw0U1wdCYWbU=;
        b=wwRY6QXstdZRIts4NWq+ZenqfrJ97+6rH5n8OpFvDW1fQAzoohzU/3+pzRBEswBeGS
         L7qKEWAshgJUkzPNKPSgYc9/PfrqHNeXO+Oiuy0z76F/4h5yTaqCxen9163ipEu/9M3P
         G0fxc5CU1kPw0S5lgGAPbpSq/GsOn2L179VvSFN5Mwna+B48EUbvAaUp1l7KfPEmwbk/
         MTgI8AKRDd7Psq5sfnHcJw1Dt52EFaG9KO5T7c9G6a2YTcIPSC8OL05hPKqBVV5lftHZ
         BFFfnUqn/kHqXoIwTtGpegNw8GzqAs8apuEpNwU+zQCBFjt9T6rWpVUlE1Sh/aP8IHXZ
         qDjg==
X-Gm-Message-State: AOJu0YyVJKOsGQ1DCCNT1erhj8tjOnL4JGSncSr4zArFR0LKNGdlmIda
        /omG/eQXn1SQi6LD/kjnSpzKpA==
X-Google-Smtp-Source: AGHT+IE6foZp5XdAD/Rgm80MlH1SwWmYqtWHM6CmQv1ZafK6rdE48VDqQlV2ersrr3HiL+DMAWSMZg==
X-Received: by 2002:a05:6808:23c6:b0:3a8:5133:482d with SMTP id bq6-20020a05680823c600b003a85133482dmr16934237oib.35.1700067565428;
        Wed, 15 Nov 2023 08:59:25 -0800 (PST)
Received: from brgl-uxlite.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a449300b0077772296f9dsm3572219qkp.126.2023.11.15.08.59.24
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
Subject: [RESEND PATCH v2 2/4] genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
Date:   Wed, 15 Nov 2023 17:59:13 +0100
Message-Id: <20231115165915.2936349-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231115165915.2936349-1-brgl@bgdev.pl>
References: <20231115165915.2936349-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The irqnum field is unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/irq_sim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd76323ea3fd..f5ebb3ba6f9a 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -19,7 +19,6 @@ struct irq_sim_work_ctx {
 };
 
 struct irq_sim_irq_ctx {
-	int			irqnum;
 	bool			enabled;
 	struct irq_sim_work_ctx	*work_ctx;
 };
-- 
2.40.1

