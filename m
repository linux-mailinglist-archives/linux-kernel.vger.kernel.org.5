Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA7767D32
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjG2Ijh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjG2Ij2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47FD3AB3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690619919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXaw8xh9/uqiELcQ6XYGjWI9gHB6EvF8rWATqtNVPNw=;
        b=ExDxyVtKLWF9bepxhJd1qIXwHC/jx5doc9PuUWieDZY6mQOG2B9g4sFbGAQgyWcZoFK3M7
        QXNpdmWPFDrJropbD0gH+bqQsi1Ds4TsQ+vTRRzEghZDid4FKmDhNCAmziEUXsJurSunMF
        CKCEzzMsIqbOttVdr7pIVIVCA0zevCA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-Gqqt_6UAMWqMonAAkokKVg-1; Sat, 29 Jul 2023 04:38:37 -0400
X-MC-Unique: Gqqt_6UAMWqMonAAkokKVg-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-565893ef956so4083244eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690619916; x=1691224716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXaw8xh9/uqiELcQ6XYGjWI9gHB6EvF8rWATqtNVPNw=;
        b=e2S7o2XR//N+WuJ1DMkedl0QG6FMqB86odNkzMtkcooJ32hw3XebzBMdZlmyw0nqD3
         BPJKsa2gaXaQzoIX2cIW8Y4PoKNvbkZzWy72+OHsF2HyUfv/goKDV/Oi0PJCiHSbLBrA
         tza/GZ7dA1zFvljtqYFklBGJvi6tYIeBgIMLVM6fKTQaHSYrMlAsdhfEJUeY+tqnx17m
         kIuaMiRxmwM+sf4V8Kb41uyAHTIL8SegFh01Pan9DvgFJod+ALXzo8MBCdyfcNs9ktQW
         I/hSwBbf6SojzRpV1kwUZ/WIBjyYrfgK+AoG6UwuQYuNe++nEAd9APypxaGhhqolcvBD
         Ckww==
X-Gm-Message-State: ABy/qLZ2dZ+ka12E/T5avVqvoG6NiGyxYVQWmMlEZO8/FLaXwHdrMcil
        MkRv3b6L/BsUo/QDxECe9yrswMY4K4Y82GnDtnAOn+0uP/Fex1sx95zHi6vnrOWZJ8xcI8iJT1e
        uT2GxmrsUy6E0KyO0/ICpflkCaB/Za2Rn
X-Received: by 2002:a05:6808:309b:b0:3a5:ae6b:135e with SMTP id bl27-20020a056808309b00b003a5ae6b135emr5655239oib.53.1690619916684;
        Sat, 29 Jul 2023 01:38:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFmxI05UVL41BW0bFY5niMhRBlN3Ug2o75+FrvPm/cfGRczsrKhvhswW5Oyitt0V1cDN7u7Ug==
X-Received: by 2002:a05:6808:309b:b0:3a5:ae6b:135e with SMTP id bl27-20020a056808309b00b003a5ae6b135emr5655230oib.53.1690619916470;
        Sat, 29 Jul 2023 01:38:36 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:93ca:d713:4eb3:968e:3b54])
        by smtp.gmail.com with ESMTPSA id be24-20020a056808219800b003a3f922207asm2467184oib.1.2023.07.29.01.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 01:38:36 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leobras@redhat.com>
Subject: [RFC PATCH 2/4] swap: apply new local_schedule_work_on() interface
Date:   Sat, 29 Jul 2023 05:37:33 -0300
Message-ID: <20230729083737.38699-4-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230729083737.38699-2-leobras@redhat.com>
References: <20230729083737.38699-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the new local_*lock_n*() and local_schedule_work_on() interface
to improve performance & latency on PREEMTP_RT kernels.

For functions that may be scheduled in a different cpu, replace
local_*lock*() by local_lock_n*(), and replace schedule_work_on() by
local_schedule_work_on(). The same happens for flush_work() and
local_flush_work().

This should bring no relevant performance impact on non-RT kernels:
For functions that may be scheduled in a different cpu, the local_*lock's
this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/swap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..a79f2091eae5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -760,11 +760,11 @@ void lru_add_drain(void)
  * the same cpu. It shouldn't be a problem in !SMP case since
  * the core is only one and the locks will disable preemption.
  */
-static void lru_add_and_bh_lrus_drain(void)
+static void lru_add_and_bh_lrus_drain(int cpu)
 {
-	local_lock(&cpu_fbatches.lock);
-	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&cpu_fbatches.lock);
+	local_lock_n(&cpu_fbatches.lock, cpu);
+	lru_add_drain_cpu(cpu);
+	local_unlock_n(&cpu_fbatches.lock, cpu);
 	invalidate_bh_lrus_cpu();
 	mlock_drain_local();
 }
@@ -782,9 +782,9 @@ void lru_add_drain_cpu_zone(struct zone *zone)
 
 static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
 
-static void lru_add_drain_per_cpu(struct work_struct *dummy)
+static void lru_add_drain_per_cpu(struct work_struct *w)
 {
-	lru_add_and_bh_lrus_drain();
+	lru_add_and_bh_lrus_drain(w->data.counter);
 }
 
 static bool cpu_needs_drain(unsigned int cpu)
@@ -888,13 +888,13 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 
 		if (cpu_needs_drain(cpu)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
-			queue_work_on(cpu, mm_percpu_wq, work);
+			local_queue_work_on(cpu, mm_percpu_wq, work);
 			__cpumask_set_cpu(cpu, &has_work);
 		}
 	}
 
 	for_each_cpu(cpu, &has_work)
-		flush_work(&per_cpu(lru_add_drain_work, cpu));
+		local_flush_work(&per_cpu(lru_add_drain_work, cpu));
 
 done:
 	mutex_unlock(&lock);
@@ -941,7 +941,7 @@ void lru_cache_disable(void)
 #ifdef CONFIG_SMP
 	__lru_add_drain_all(true);
 #else
-	lru_add_and_bh_lrus_drain();
+	lru_add_and_bh_lrus_drain(smp_processor_id());
 #endif
 }
 
-- 
2.41.0

