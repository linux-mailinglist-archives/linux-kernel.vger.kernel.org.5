Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322A9767D31
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjG2Ijd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjG2IjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC8448C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690619922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMopzQPIrgY6C9bjYkGrv8CSEJs16BIQJryaMHu6prw=;
        b=cJMaSYnwkbA2xCi73XGWqg1AUVDpVpk+uvz87p6LcVs24iBZPZf0nEg7WRhh5INIMSQsp6
        EPWO+8gYvzkPnStIyTqx86GjIunR83tj9AS8P/oXT9R39H8703YGBh64iZcWFT8c4JUbGz
        bjywCWPvumJMdWOlQS3O3If0/58gOAY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-SoX0zxJdOXSRFHExcnszMw-1; Sat, 29 Jul 2023 04:38:41 -0400
X-MC-Unique: SoX0zxJdOXSRFHExcnszMw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a5a7e981ddso5438478b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690619920; x=1691224720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMopzQPIrgY6C9bjYkGrv8CSEJs16BIQJryaMHu6prw=;
        b=E7DdzocmCanoFh8xyQ7lfRq6PTpzJOMwob2yhI/fH6/fovmm2JgC0y0Xyb6GCL/zMD
         n7g2XOYdvzAthyYWC4S7hcPNQW0FoTb2U7dVS9fczMZ5Xo5uo33YiDHActWTVnk+4WaA
         YYDfHpN/2BtWy4oj/pFElWaE9rBcOytOZ/Otp8BnIg2j+0grgl1dJ857AAUo++hCfCHw
         s0zekJMnDY/ypRlfQ3MuuR4XqtkOoNY/MyQj8iz8b0BBZoNDDlg8B2nsagAd7WKGF0Ds
         bPnTy6oTN65Af6uadMdtVFj4mBq6G934VdDvDKQ+ZDBjAzRTR2MrEcSpcadyPaZL4M6S
         d97w==
X-Gm-Message-State: ABy/qLa8UyHpAMkVzf3Ex+74YtjfZq+QmjMW1ejeeACuf03GTWNYSmuT
        8i/It2U7dd7klPKcRstmbNHVG7USYK0i1mt9MyJP/jwhGbRFqLN2jLiAqtHShQdWV5UGX2BA0bc
        B0VAyPQgDq7pK2oHpT/GbAAM1
X-Received: by 2002:a05:6808:138c:b0:3a5:98b4:c139 with SMTP id c12-20020a056808138c00b003a598b4c139mr6261452oiw.20.1690619920282;
        Sat, 29 Jul 2023 01:38:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEH5b27Ayet4VNcR1aftjuqWvQlRQfSXupw28ms9fmuNADQMu4IwIHNRnkpakCGJQDp6PAAdw==
X-Received: by 2002:a05:6808:138c:b0:3a5:98b4:c139 with SMTP id c12-20020a056808138c00b003a598b4c139mr6261449oiw.20.1690619920040;
        Sat, 29 Jul 2023 01:38:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:93ca:d713:4eb3:968e:3b54])
        by smtp.gmail.com with ESMTPSA id be24-20020a056808219800b003a3f922207asm2467184oib.1.2023.07.29.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 01:38:39 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leobras@redhat.com>
Subject: [RFC PATCH 4/4] slub: apply new local_schedule_work_on() interface
Date:   Sat, 29 Jul 2023 05:37:35 -0300
Message-ID: <20230729083737.38699-6-leobras@redhat.com>
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
 mm/slub.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e3b5d5c0eb3a..feb4a502d9a8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2733,13 +2733,14 @@ static inline void unfreeze_partials_cpu(struct kmem_cache *s,
 
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 
-static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
+static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c,
+			      int cpu)
 {
 	unsigned long flags;
 	struct slab *slab;
 	void *freelist;
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_irqsave_n(&s->cpu_slab->lock, flags, cpu);
 
 	slab = c->slab;
 	freelist = c->freelist;
@@ -2748,7 +2749,7 @@ static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 	c->freelist = NULL;
 	c->tid = next_tid(c->tid);
 
-	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+	local_unlock_irqrestore_n(&s->cpu_slab->lock, flags, cpu);
 
 	if (slab) {
 		deactivate_slab(s, slab, freelist);
@@ -2790,14 +2791,16 @@ static void flush_cpu_slab(struct work_struct *w)
 	struct kmem_cache *s;
 	struct kmem_cache_cpu *c;
 	struct slub_flush_work *sfw;
+	int cpu;
 
+	cpu = w->data.counter;
 	sfw = container_of(w, struct slub_flush_work, work);
 
 	s = sfw->s;
-	c = this_cpu_ptr(s->cpu_slab);
+	c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	if (c->slab)
-		flush_slab(s, c);
+		flush_slab(s, c, cpu);
 
 	unfreeze_partials(s);
 }
@@ -2829,14 +2832,14 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
 		INIT_WORK(&sfw->work, flush_cpu_slab);
 		sfw->skip = false;
 		sfw->s = s;
-		queue_work_on(cpu, flushwq, &sfw->work);
+		local_queue_work_on(cpu, flushwq, &sfw->work);
 	}
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
 		if (sfw->skip)
 			continue;
-		flush_work(&sfw->work);
+		local_flush_work(&sfw->work);
 	}
 
 	mutex_unlock(&flush_lock);
-- 
2.41.0

