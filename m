Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7A767D2F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjG2IjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjG2IjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F22733
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690619917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wj6iLXmkjbQ4r1Vww+IqOBjAiKyNj197Tvn6ogknTfo=;
        b=Lh3J3iRkR4iloH2nXn/8R/qZMN9f8TKoLk3cNoEUNi7JcOg5yWRrEvaq9MGvJx/5IyOqSK
        ffjD9TjHPi3sot9H7QhbRumKjYMUIoc/wd/xI0xBppxmnaLk+mrwSu8v1zkH4JWQVEwjvv
        JKfbSz/j+S9kEqmDSgcAA5XAxUNu0g0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-lIv3Tpd_MSGrncRMW8Elig-1; Sat, 29 Jul 2023 04:38:35 -0400
X-MC-Unique: lIv3Tpd_MSGrncRMW8Elig-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a3b8b73cbfso5920053b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690619915; x=1691224715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj6iLXmkjbQ4r1Vww+IqOBjAiKyNj197Tvn6ogknTfo=;
        b=VcL02wXUCmtouDMil/ve+2+mak1+khf46Jyc6N4JMCmXuj9b7fi+ZpdXZxJtwvsx8Z
         NtMjXLh6JtYhUWHEtvVx1CgHNOQwtqsRBUCYX7EefQDyw4s4P+tUIuF1WBwiXjhMo7l2
         WJdgk2kedKCmNUdU0yjJI9OPf99YalY7YSJpsHq+Kluit10fUYP49y4lYXtPNnJIalcq
         z9aTE8PT6B0XOThxotkuvxWpkHQS3CkgvVQFJGYZ1+FNYOTPz3+Z+YnOp4hETDKbHZ46
         V05hmeXuVyBNLS4vtWRNY/5RhNTSFxmAMNNHMs9seg1ktColAVyQp1sov+DCIDc3QMCx
         4Q/A==
X-Gm-Message-State: ABy/qLbP6YT0ynK8593AWg7v9dQrgvgqrz5YpsxKU3OMpzT0GbppqTOm
        mTeFZX5MWAX96k2fYVZWm6AshPg76nSHs2VzPwVrxRYC47bqKd/l0cLNP6d+O+oHuIMeNkzeDcS
        MYyvxz76ZSoAf+o/CdMM24PiG
X-Received: by 2002:a54:4406:0:b0:3a3:9c50:8fed with SMTP id k6-20020a544406000000b003a39c508fedmr4987024oiw.27.1690619914910;
        Sat, 29 Jul 2023 01:38:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGJlpDEFi09nRzGsBj0F5286Z7QuumsI+XAEu/fL0Yu23OB45bAXyvNt8gjOo4AbJDHE1qHag==
X-Received: by 2002:a54:4406:0:b0:3a3:9c50:8fed with SMTP id k6-20020a544406000000b003a39c508fedmr4987013oiw.27.1690619914726;
        Sat, 29 Jul 2023 01:38:34 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:93ca:d713:4eb3:968e:3b54])
        by smtp.gmail.com with ESMTPSA id be24-20020a056808219800b003a3f922207asm2467184oib.1.2023.07.29.01.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 01:38:34 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leobras@redhat.com>
Subject: [RFC PATCH 1/4] Introducing local_lock_n() and local queue & flush
Date:   Sat, 29 Jul 2023 05:37:32 -0300
Message-ID: <20230729083737.38699-3-leobras@redhat.com>
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

Some places in the kernel implement a parallel programming strategy
consisting on local_locks() for most of the work, and some rare remote
operations are scheduled on target cpu. This keeps the overhead low since
cacheline tends to be mostly local (and have no locks in non-RT kernels),
and the few remote operations will be more costly due to scheduling.

On the other hand, for RT workloads this can represent a problem: getting
an important workload scheduled out to deal with some unrelated task is
sure to introduce unexpected deadline misses.

It's interesting, though, that local_lock()s in RT kernels become an
spinlock(), so we can use this locking cost (that is already being paid) in
order to avoid scheduling work on a remote cpu, and updating another cpu's
per_cpu structure from the current cpu, while holding it's spinlock().

In order to do that, it's necessary to introduce a new set of functions to
make it possible to get another cpu's local lock (local_*lock_n*()), and
also the corresponding local_queue_work_on() and local_flush_work()
helpers.

On non-RT kernels, every local*_n*() works the exactly same as the non-n
functions (the extra parameter is ignored), and both local_queue_work_on()
and local_flush_work() call their non-local versions.

For RT kernels, though, local_*lock_n*() will use the extra cpu parameter
to select the correct per-cpu structure to work on, and acquire the
spinlock for that cpu.

local_queue_work_on() will just call the requested function in the current
cpu: since the local_locks() are spinlocks() we are safe.

local_flush_work() then becomes a no-op since no work is actually scheduled
on a remote cpu.

Some minimal code rework is needed in order to make this mechanism work:
The calls for local_*lock*() on the functions that are currently scheduled
on remote cpus need to be replaced my local_*lock_n*(), so in RT kernels
they can reference a different cpu.

This should have almost no impact on non-RT kernels: few this_cpu_ptr()
will become per_cpu_ptr(,smp_processor_id()).

On RT kernels, this should improve performance and reduces latency by
removing scheduling noise.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/local_lock.h          | 18 ++++++++++
 include/linux/local_lock_internal.h | 52 +++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index e55010fa7329..f1fa1e8e3fbc 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,4 +51,22 @@
 #define local_unlock_irqrestore(lock, flags)			\
 	__local_unlock_irqrestore(lock, flags)
 
+#define local_lock_n(lock, cpu)					\
+	__local_lock_n(lock, cpu)
+
+#define local_unlock_n(lock, cpu)				\
+	__local_unlock_n(lock, cpu)
+
+#define local_lock_irqsave_n(lock, flags, cpu)			\
+	__local_lock_irqsave_n(lock, flags, cpu)
+
+#define local_unlock_irqrestore_n(lock, flags, cpu)		\
+	__local_unlock_irqrestore_n(lock, flags, cpu)
+
+#define local_queue_work_on(cpu, wq, work)			\
+	__local_queue_work_on(cpu, wq, work)
+
+#define local_flush_work(work)					\
+	__local_flush_work(work)
+
 #endif
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 975e33b793a7..df064149fff8 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -98,6 +98,25 @@ do {								\
 		local_irq_restore(flags);			\
 	} while (0)
 
+#define __local_lock_n(lock, cpu)	__local_lock(lock)
+#define __local_unlock_n(lock, cpu)	__local_unlock(lock)
+
+#define __local_lock_irqsave_n(lock, flags, cpu)		\
+	__local_lock_irqsave(lock, flags)
+
+#define __local_unlock_irqrestore_n(lock, flags, cpu)		\
+	__local_unlock_irqrestore(lock, flags)
+
+#define __local_queue_work_on(cpu, wq, work)			\
+	do {							\
+		typeof(cpu) __cpu = cpu;			\
+		typeof(work) __work = work;			\
+		__work->data.counter = __cpu;			\
+		queue_work_on(__cpu, wq, __work);		\
+	} while (0)
+
+#define __local_flush_work(work)	flush_work(work)
+
 #else /* !CONFIG_PREEMPT_RT */
 
 /*
@@ -138,4 +157,37 @@ typedef spinlock_t local_lock_t;
 
 #define __local_unlock_irqrestore(lock, flags)	__local_unlock(lock)
 
+#define __local_lock_n(__lock, cpu)				\
+	do {							\
+		migrate_disable();				\
+		spin_lock(per_cpu_ptr((__lock)), cpu);		\
+	} while (0)
+
+#define __local_unlock_n(__lock, cpu)				\
+	do {							\
+		spin_unlock(per_cpu_ptr((__lock)), cpu);	\
+		migrate_enable();				\
+	} while (0)
+
+#define __local_lock_irqsave_n(lock, flags, cpu)		\
+	do {							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		__local_lock_n(lock, cpu);			\
+	} while (0)
+
+#define __local_unlock_irqrestore_n(lock, flags, cpu)		\
+	__local_unlock_n(lock, cpu)
+
+#define __local_queue_work_on(cpu, wq, work)			\
+	do {							\
+		typeof(cpu) __cpu = cpu;			\
+		typeof(work) __work = work;			\
+		__work->data = (typeof(__work->data))__cpu;	\
+		__work->func(__work);				\
+	} while (0)
+
+#define __local_flush_work(work)				\
+	do {} while (0)
+
 #endif /* CONFIG_PREEMPT_RT */
-- 
2.41.0

