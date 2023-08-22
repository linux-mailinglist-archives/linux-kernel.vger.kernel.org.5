Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C3678497B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHVSmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHVSmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:42:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F0A8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:42:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ff9b389677so7355892e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692729719; x=1693334519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcKf8TCfmSL/jTvJtJ1dXOWDhnfVF83USQ3Eyo19kik=;
        b=IpUdBzg/DdaYRMpbl13X84cDQiYDpmUCgeXaiBqeMbuJoHM1oXSNizZuih3VSwvYMl
         aZDcfvFa0yOhVkBUIFUaneixc6ZJOUXIfss7UU5ctP6d6wxplb/U69CS6fbvW4JWED1U
         cGtKnSfUOCEe/NmDiPVOE65upZgDhxf2tK9WwygoOomfip5wkdzE8lSCrdiZWcfowj0d
         BoM8ULxp4AnpR74B5yg7idNT4bwx7b7DBgaLziZSk3R5i4B8YZHLUjcGja68LIRiEvMf
         8HqcuccQTe/izpkHLUmtgmGy7DU4obCcA1WIkptReUG/nQjmH/0FpxoTSIlOZchMrU/D
         rcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692729719; x=1693334519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcKf8TCfmSL/jTvJtJ1dXOWDhnfVF83USQ3Eyo19kik=;
        b=BVurvAgiav44D20A4PJ3f3LvAEWy8PwB7KBZ410UyyjM++ZuxsZ/PZOvWHxTSgSZAd
         2bKT0/t9UTXB3cVv2nTOOqzLIHkuOc+CenO55iZcd6dGriSMmcBF6GWPCUe47fVCf2xp
         U9WL9Sbybuqr7xuwYYnmqyUdbPH6qyTFWXIUEN25S3COeLI/ve0ZyEnu3TMvJpyF/Di7
         m/hjQAHnFnvDjzFc9BKchi//FQ62AtLNyzgmtemZmH33a9tv4pGQr0hp2QZ1ZA5Dxcyg
         EInThy1AMB3NotYsZPSorvYVQyw1Vwn9fz+pLsQUX1CGH8hUYg5g8Cgb7hAOsLScIagE
         64rA==
X-Gm-Message-State: AOJu0Ywm8gVIMmr2JfLjVBFjXCnop4VHj4gRka+261GnkxGHNuBwbOEy
        RS2ZaFGzi+tVzA220luLz3qKD/Vznh9xCA==
X-Google-Smtp-Source: AGHT+IFwNeb+x8+h4MA5Q285B17LTQ1gswDV1LNkxSm1vOHyvMZAe4lJw/QPCraL5VibXY/m5vFGcQ==
X-Received: by 2002:a05:6512:1296:b0:4fe:993:2218 with SMTP id u22-20020a056512129600b004fe09932218mr9935537lfs.31.1692729718947;
        Tue, 22 Aug 2023 11:41:58 -0700 (PDT)
Received: from f.. (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id w9-20020a056402070900b00525683f9b2fsm7945317edx.5.2023.08.22.11.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:41:58 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/2] pcpcntr: add group allocation/free
Date:   Tue, 22 Aug 2023 20:41:51 +0200
Message-Id: <20230822184152.2194558-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822184152.2194558-1-mjguzik@gmail.com>
References: <20230822184152.2194558-1-mjguzik@gmail.com>
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
 include/linux/percpu_counter.h | 20 ++++++++---
 lib/percpu_counter.c           | 61 +++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 75b73c83bc9d..518a4088b964 100644
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
2.39.2

