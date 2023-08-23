Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50642784FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjHWFGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjHWFGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:06:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8456AE5B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:06:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso689667766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692767176; x=1693371976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JRcXwzRi0jQB1TLzrEg7BfGVcbae4iTaoFsakUigOI=;
        b=ohUoxhT73ZTR4FOXW3n8KDmTPiUTiFYOtoJO19cnC62PnujQwIJjk04iHc3hG3cvX4
         LcMnHxtwfbLBGmTt34u8g0jzz4jZ8yuQ9lUPSoqq+b+ob+vUFne5Ma4yxQhVwQSnItYY
         TmMzHCyb3oM+uF1g5uULBY71M8RCA6pElrs8DAtqHOYIeTFsd2Cm+xPN0BZGI/A69pMA
         SEpSyqnm8MbSdOdQpVYqzFhEAzCLb85q7LeCRH+xqLtBatSswuhxxNqrOaKmh/Uq1TLS
         FgYlSXUrmYwtY0IhveXfbO6t3owUxAb2UvPQY6uUUiBxrD4m2sZ0NQBGum5jb7Km5WD7
         t2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692767176; x=1693371976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JRcXwzRi0jQB1TLzrEg7BfGVcbae4iTaoFsakUigOI=;
        b=lelePtP1n0JpL/D6PMmGn4Miz9felB9Rv0IS8npGQiWAEUGu4QiYGgl9f5fhILkGx6
         3CYm45JP7x/odICH21wwMOKjKf9ulmnWg1Gy/c9frvWlC5cBgfSk5rZ9NzFqSJGtuk0p
         /Ht+vzljmS/AfEK5uNc+lmoTZpPzquusv9PUi32ACNR1+qlW/w+S9UAYLdngMliyyTKI
         BOQGVRlAiTKILi1RCBX0Kko9F0rpcXgNbfhM2s07ylPlwEXRjxAwu5m/hrfU3FWtV39J
         EU/VDMXIOkoSoFyCYg+uZBU6ajQn/ckKHr1aJYik/qsL52otMeqwgKBAfi+t4IN+XXS6
         GWwQ==
X-Gm-Message-State: AOJu0YzyP7xr8ubCbB7QkvYX8WztrdLG3XwmagYX5+6Ri4poKHqi2DEX
        COPz521guPJKPp3mZw41mmKQ/yqwHYMApw==
X-Google-Smtp-Source: AGHT+IFWux01B2Oa+XeckE2+Vyuwk0P4V6dysyQJzM5m7Vf7TaVfAA7TF1kKC1SWOti4CX3UZqAF0g==
X-Received: by 2002:a17:907:7754:b0:9a1:9284:115 with SMTP id kx20-20020a170907775400b009a192840115mr6015550ejc.67.1692767176002;
        Tue, 22 Aug 2023 22:06:16 -0700 (PDT)
Received: from f.. (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906b29000b0099ddc81903asm9267401ejz.221.2023.08.22.22.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 22:06:15 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com,
        vegard.nossum@oracle.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 1/2] pcpcntr: add group allocation/free
Date:   Wed, 23 Aug 2023 07:06:08 +0200
Message-Id: <20230823050609.2228718-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823050609.2228718-1-mjguzik@gmail.com>
References: <20230823050609.2228718-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocations and frees are globally serialized on the pcpu lock (and the
CPU hotplug lock if enabled, which is the case on Debian).

At least one frequent consumer allocates 4 back-to-back counters (and
frees them in the same manner), exacerbating the problem.

While this does not fully remedy scalability issues, it is a step
towards that goal and provides immediate relief.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/percpu_counter.h | 39 ++++++++++++++++++----
 lib/percpu_counter.c           | 61 +++++++++++++++++++++++-----------
 2 files changed, 74 insertions(+), 26 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 75b73c83bc9d..f1e7c987e3d3 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -30,17 +30,27 @@ struct percpu_counter {
 
 extern int percpu_counter_batch;
 
-int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
-			  struct lock_class_key *key);
+int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
+			  u32 nr_counters, struct lock_class_key *key);
 
-#define percpu_counter_init(fbc, value, gfp)				\
+#define percpu_counter_init_many(fbc, value, gfp, nr_counters)		\
 	({								\
 		static struct lock_class_key __key;			\
 									\
-		__percpu_counter_init(fbc, value, gfp, &__key);		\
+		__percpu_counter_init_many(fbc, value, gfp, nr_counters,\
+					   &__key);			\
 	})
 
-void percpu_counter_destroy(struct percpu_counter *fbc);
+
+#define percpu_counter_init(fbc, value, gfp)				\
+	percpu_counter_init_many(fbc, value, gfp, 1)
+
+void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 nr_counters);
+static inline void percpu_counter_destroy(struct percpu_counter *fbc)
+{
+	percpu_counter_destroy_many(fbc, 1);
+}
+
 void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
 			      s32 batch);
@@ -116,11 +126,26 @@ struct percpu_counter {
 	s64 count;
 };
 
+static inline int percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
+				           gfp_t gfp, u32 nr_counters)
+{
+	u32 i;
+
+	for (i = 0; i < nr_counters; i++)
+		fbc[i].count = amount;
+
+	return 0;
+}
+
 static inline int percpu_counter_init(struct percpu_counter *fbc, s64 amount,
 				      gfp_t gfp)
 {
-	fbc->count = amount;
-	return 0;
+	return percpu_counter_init_many(fbc, amount, gfp, 1);
+}
+
+static inline void percpu_counter_destroy_many(struct percpu_counter *fbc,
+					       u32 nr_counters)
+{
 }
 
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 5004463c4f9f..9338b27f1cdd 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -151,48 +151,71 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
 }
 EXPORT_SYMBOL(__percpu_counter_sum);
 
-int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
-			  struct lock_class_key *key)
+int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
+			  u32 nr_counters, struct lock_class_key *key)
 {
 	unsigned long flags __maybe_unused;
-
-	raw_spin_lock_init(&fbc->lock);
-	lockdep_set_class(&fbc->lock, key);
-	fbc->count = amount;
-	fbc->counters = alloc_percpu_gfp(s32, gfp);
-	if (!fbc->counters)
+	size_t counter_size;
+	s32 __percpu *counters;
+	u32 i;
+
+	counter_size = ALIGN(sizeof(*counters), __alignof__(*counters));
+	counters = __alloc_percpu_gfp(nr_counters * counter_size,
+				      __alignof__(*counters), gfp);
+	if (!counters) {
+		fbc[0].counters = NULL;
 		return -ENOMEM;
+	}
 
-	debug_percpu_counter_activate(fbc);
+	for (i = 0; i < nr_counters; i++) {
+		raw_spin_lock_init(&fbc[i].lock);
+		lockdep_set_class(&fbc[i].lock, key);
+#ifdef CONFIG_HOTPLUG_CPU
+		INIT_LIST_HEAD(&fbc[i].list);
+#endif
+		fbc[i].count = amount;
+		fbc[i].counters = (void *)counters + (i * counter_size);
+
+		debug_percpu_counter_activate(&fbc[i]);
+	}
 
 #ifdef CONFIG_HOTPLUG_CPU
-	INIT_LIST_HEAD(&fbc->list);
 	spin_lock_irqsave(&percpu_counters_lock, flags);
-	list_add(&fbc->list, &percpu_counters);
+	for (i = 0; i < nr_counters; i++)
+		list_add(&fbc[i].list, &percpu_counters);
 	spin_unlock_irqrestore(&percpu_counters_lock, flags);
 #endif
 	return 0;
 }
-EXPORT_SYMBOL(__percpu_counter_init);
+EXPORT_SYMBOL(__percpu_counter_init_many);
 
-void percpu_counter_destroy(struct percpu_counter *fbc)
+void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 nr_counters)
 {
 	unsigned long flags __maybe_unused;
+	u32 i;
+
+	if (WARN_ON_ONCE(!fbc))
+		return;
 
-	if (!fbc->counters)
+	if (!fbc[0].counters)
 		return;
 
-	debug_percpu_counter_deactivate(fbc);
+	for (i = 0; i < nr_counters; i++)
+		debug_percpu_counter_deactivate(&fbc[i]);
 
 #ifdef CONFIG_HOTPLUG_CPU
 	spin_lock_irqsave(&percpu_counters_lock, flags);
-	list_del(&fbc->list);
+	for (i = 0; i < nr_counters; i++)
+		list_del(&fbc[i].list);
 	spin_unlock_irqrestore(&percpu_counters_lock, flags);
 #endif
-	free_percpu(fbc->counters);
-	fbc->counters = NULL;
+
+	free_percpu(fbc[0].counters);
+
+	for (i = 0; i < nr_counters; i++)
+		fbc[i].counters = NULL;
 }
-EXPORT_SYMBOL(percpu_counter_destroy);
+EXPORT_SYMBOL(percpu_counter_destroy_many);
 
 int percpu_counter_batch __read_mostly = 32;
 EXPORT_SYMBOL(percpu_counter_batch);
-- 
2.41.0

