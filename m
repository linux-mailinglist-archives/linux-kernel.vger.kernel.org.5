Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C844783491
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjHUU26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjHUU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:28:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB0B139
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:28:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c93638322so775153266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692649732; x=1693254532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcR7quqcdfLIpDV/BrSlU217Tc1djQCifnGeh+jON88=;
        b=HaTnWJYE97VIyQjGgW8oXxjKuiWkeUDWXj46fGZH1mL4dDpwmq7tmfpX5SktuZoiP5
         hUtFQbd9VD/uRaVPfssMjRXUDKkjwj2A6IZCCObm/PzrXt7RdvIk2/Cx4n+EwScduqvq
         5zdLlfCcmOL+WnnWtVzhfdFeWiK/jVpRbHz0NrJBS3m51vhUAsJ9GDYSkLvN5V35GGPk
         LknmQ4pZAN4UBzap1Q9GHexrXPs5Msp2Y7p+LDXQgxRUj4sz/RO9X+apujJZ7Kp0PLnR
         DMtpZchQSUEMIRLKVAZZ2I3YyabBIp1fK5tZvPcgOUQXZ8aW3aduoK0roeYwuO9Ki75r
         nQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692649732; x=1693254532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcR7quqcdfLIpDV/BrSlU217Tc1djQCifnGeh+jON88=;
        b=Dh4CzQ2nZGbW03dVurvFK9ENCLnQn/peoK3gkTNbQm7uy2XopyhziG95nHB/+z/rts
         +MYr2VnUOKg7iNUpht8rHNdPvY6SGpT/31/54sDYLKjCPgPg4v+H1oYROqvQc/K4+O2P
         9DCz2fqwFyfEPpq/V6WSAG6qvhPj6VsAXXeD5F7mA5S9gAJ7OsPzJ+Ts/90H1BPHdXIB
         83u5nARx2hCKI2tRW5UQNlPTyq0xmnd1TbOK7iZz+h33vJn4TV/f5kUi3ci5IkQo/h8W
         rkgP1thzRR+FeRF64WtDMTu6IdWLTIZ8XrGrgQVAh51gXPgeNHzRVC9CATGYjTq8Ly/m
         j2Bg==
X-Gm-Message-State: AOJu0YzL+6CIIRABHmAgQhF79H1N3nQVR9DAWVEqwmjAAOGkVZSqDzUM
        PmRr+1MA963REzFGiN4Pj/btl3suOBUygQ==
X-Google-Smtp-Source: AGHT+IEEFRgYy+w0a0gW6U6MQsAvYVD8DCQhrRJusGPWmQcAHJH5nXLue/UF1odPjC5zuNn88lHHTw==
X-Received: by 2002:a17:907:6d9a:b0:99b:cadd:c2ee with SMTP id sb26-20020a1709076d9a00b0099bcaddc2eemr8773312ejc.29.1692649732008;
        Mon, 21 Aug 2023 13:28:52 -0700 (PDT)
Received: from f.. (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id k26-20020a1709062a5a00b00997cce73cc7sm7084450eje.29.2023.08.21.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 13:28:51 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] pcpcntr: add group allocation/free
Date:   Mon, 21 Aug 2023 22:28:28 +0200
Message-Id: <20230821202829.2163744-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821202829.2163744-1-mjguzik@gmail.com>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
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
 include/linux/percpu_counter.h | 19 ++++++++---
 lib/percpu_counter.c           | 61 ++++++++++++++++++++++++----------
 2 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 75b73c83bc9d..ff5850b07124 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -30,17 +30,26 @@ struct percpu_counter {
 
 extern int percpu_counter_batch;
 
-int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
-			  struct lock_class_key *key);
+int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
+			  struct lock_class_key *key, u32 count);
 
-#define percpu_counter_init(fbc, value, gfp)				\
+#define percpu_counter_init_many(fbc, value, gfp, count)		\
 	({								\
 		static struct lock_class_key __key;			\
 									\
-		__percpu_counter_init(fbc, value, gfp, &__key);		\
+		__percpu_counter_init_many(fbc, value, gfp, &__key, count);\
 	})
 
-void percpu_counter_destroy(struct percpu_counter *fbc);
+
+#define percpu_counter_init(fbc, value, gfp)				\
+	percpu_counter_init_many(fbc, value, gfp, 1)
+
+void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 count);
+static inline void percpu_counter_destroy(struct percpu_counter *fbc)
+{
+	percpu_counter_destroy_many(fbc, 1);
+}
+
 void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
 			      s32 batch);
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 5004463c4f9f..2a33cf23df55 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -151,48 +151,73 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
 }
 EXPORT_SYMBOL(__percpu_counter_sum);
 
-int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
-			  struct lock_class_key *key)
+int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
+			  struct lock_class_key *key, u32 count)
 {
 	unsigned long flags __maybe_unused;
+	s32 __percpu *counters;
+	u32 i;
 
-	raw_spin_lock_init(&fbc->lock);
-	lockdep_set_class(&fbc->lock, key);
-	fbc->count = amount;
-	fbc->counters = alloc_percpu_gfp(s32, gfp);
-	if (!fbc->counters)
+	counters = __alloc_percpu_gfp(sizeof(*counters) * count,
+				      sizeof(*counters), gfp);
+	if (!counters) {
+		fbc[0].counters = NULL;
 		return -ENOMEM;
+	}
 
-	debug_percpu_counter_activate(fbc);
+	for (i = 0; i < count; i++) {
+		raw_spin_lock_init(&fbc[i].lock);
+		lockdep_set_class(&fbc[i].lock, key);
+#ifdef CONFIG_HOTPLUG_CPU
+		INIT_LIST_HEAD(&fbc[i].list);
+#endif
+		fbc[i].count = amount;
+		fbc[i].counters = &counters[i];
+
+		debug_percpu_counter_activate(&fbc[i]);
+	}
 
 #ifdef CONFIG_HOTPLUG_CPU
-	INIT_LIST_HEAD(&fbc->list);
 	spin_lock_irqsave(&percpu_counters_lock, flags);
-	list_add(&fbc->list, &percpu_counters);
+	for (i = 0; i < count; i++) {
+		list_add(&fbc[i].list, &percpu_counters);
+	}
 	spin_unlock_irqrestore(&percpu_counters_lock, flags);
 #endif
 	return 0;
 }
-EXPORT_SYMBOL(__percpu_counter_init);
+EXPORT_SYMBOL(__percpu_counter_init_many);
 
-void percpu_counter_destroy(struct percpu_counter *fbc)
+void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 count)
 {
 	unsigned long flags __maybe_unused;
+	u32 i;
 
-	if (!fbc->counters)
+	if (WARN_ON_ONCE(!fbc))
 		return;
 
-	debug_percpu_counter_deactivate(fbc);
+	if (!fbc[0].counters)
+		return;
+
+	for (i = 0; i < count; i++) {
+		debug_percpu_counter_deactivate(&fbc[i]);
+	}
 
 #ifdef CONFIG_HOTPLUG_CPU
 	spin_lock_irqsave(&percpu_counters_lock, flags);
-	list_del(&fbc->list);
+	for (i = 0; i < count; i++) {
+		list_del(&fbc[i].list);
+	}
 	spin_unlock_irqrestore(&percpu_counters_lock, flags);
 #endif
-	free_percpu(fbc->counters);
-	fbc->counters = NULL;
+
+	free_percpu(fbc[0].counters);
+
+	for (i = 0; i < count; i++) {
+		fbc[i].counters = NULL;
+	}
 }
-EXPORT_SYMBOL(percpu_counter_destroy);
+EXPORT_SYMBOL(percpu_counter_destroy_many);
 
 int percpu_counter_batch __read_mostly = 32;
 EXPORT_SYMBOL(percpu_counter_batch);
-- 
2.39.2

