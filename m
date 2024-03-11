Return-Path: <linux-kernel+bounces-99270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF98785B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A061F222B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97315788B;
	Mon, 11 Mar 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="j/q/31gH"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B656B84
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175619; cv=none; b=ZPk88ik0sN4kqsu2BhC5AioMmkH7PZwiydBDEEB0YcH+gdZH0fq6sgnOkVxGLNfIOVcr8sWDZLCJjglFbpU1guJ5jM0NBKOZHVNx42UDMbeKLesSfnh06ti0FwaNED/VqzcSEmHmsXx4Wnjhy8dmzO+DY537brIy9so7rsqeqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175619; c=relaxed/simple;
	bh=uG0XdE33GnOjaXgw0sEgfD6qMLI1cOfcn+gbSJbqKvs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMUUAVz5i/ncWvnvfPZ6tKEeMmVADB3jBBT7wA6oqhxATmlTq8FKgPdPUOvCHMnYBczInq8hQ7tQiAVzZYCOawua5bPI7H4xVp9MlSviqLBGeAP8KiBps0Novji9Gh04CdurzclqsuXzvfNDzjFmBU0+BmYOaC8zkfl5DqxbsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=j/q/31gH; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78863dc4247so91038685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175616; x=1710780416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cK/ZqVdlnureqUddSXvrvjnokezl2c4iuxNaHlbvXOk=;
        b=j/q/31gHIaFViDLSBz8X5TdFp8y/fs+HWhdHNK5zThNLm6yMOfvGs31ViTHpgsgbOh
         qE5EXDLQH27ltiNQw9JfOoQfD3ywoNWjLFyaF4z6HpWT38O/d5SdkViur1Xom1h9eHT7
         0Lq3PGasRrdsKHUQVw+INHtLpHVdMcyxi3LxTDJussbYrp9yoC7GDKj/EnbM3h88r1VD
         RK5GnF9DQmqv2YHT8A/jE91DBWUWm9YgklL0w1hB6kYSlA4vFlFkZrC2DT+IOM6chxC3
         IBNBMcTz1ZvcjW/8KQyBO89y1TmBiXJMVl/3vDXstI+JlnFTNh3ML0kS5H7SV1LnIoDS
         L1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175616; x=1710780416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK/ZqVdlnureqUddSXvrvjnokezl2c4iuxNaHlbvXOk=;
        b=bjWCGpDAZrw1GEajhqem+EvKaWj4w9KzaF0KzXhq19khShRZaeg5sOlxppForz/SBO
         M+Pv3dWZeGHDZTihVZPYRyBndsc+YYIrzS9MZ+g/qvd4Vnk2PPbE3dqTv7CaZXusr/VP
         ddVNXrX/+lRXfeItza3HCKkrM8zLYLaJE5s0MBp3VUd1jaO5UIsa35E/Mnru7uUrdz4g
         M/vMz1O4uiuAeNYJ78oUolvwH2o/P96DyevxjMv1SWP8Ge4YkIrEPIAxaYDH6CnNHal2
         I8bX9b/nn9bKCEmXGuNaqjCORi67qbXs/z8yOxGENitTL69we0REJzVUXfHZzMTGMox2
         67Kw==
X-Gm-Message-State: AOJu0Yz//QB3SsdA/zkqREjlYS7T6nkXfIYalnNRQOBik/esglVugXNl
	eZk3rx2QmNjAxUSIOZzAh51a2RQL7tAC/JG8yfDlxQKEywop+nvOP+yGlRWrVDn8nMkd2+ytVmo
	HExc=
X-Google-Smtp-Source: AGHT+IEp6VoHaP5KrWImU0EWHAjL+QS9WD2gq+SL5008BAWJX/vKvEeMCLb5ZMa54jxJQaXt/mOFWQ==
X-Received: by 2002:ae9:e701:0:b0:788:c09:ce3 with SMTP id m1-20020ae9e701000000b007880c090ce3mr7062849qka.46.1710175616304;
        Mon, 11 Mar 2024 09:46:56 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:55 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	x86@kernel.org,
	bp@alien8.de,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	dianders@chromium.org,
	dietmar.eggemann@arm.com,
	eric.devolder@oracle.com,
	hca@linux.ibm.com,
	hch@infradead.org,
	hpa@zytor.com,
	jacob.jun.pan@linux.intel.com,
	jgg@ziepe.ca,
	jpoimboe@kernel.org,
	jroedel@suse.de,
	juri.lelli@redhat.com,
	kent.overstreet@linux.dev,
	kinseyho@google.com,
	kirill.shutemov@linux.intel.com,
	lstoakes@gmail.com,
	luto@kernel.org,
	mgorman@suse.de,
	mic@digikod.net,
	michael.christie@oracle.com,
	mingo@redhat.com,
	mjguzik@gmail.com,
	mst@redhat.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	pmladek@suse.com,
	rick.p.edgecombe@intel.com,
	rostedt@goodmis.org,
	surenb@google.com,
	tglx@linutronix.de,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	pasha.tatashin@soleen.com
Subject: [RFC 13/14] task_stack.h: Add stack_not_used() support for dynamic stack
Date: Mon, 11 Mar 2024 16:46:37 +0000
Message-ID: <20240311164638.2015063-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DEBUG_STACK_USAGE is enabled by default on most architectures.

Its purpose is to determine and print the maximum stack depth on
thread exit.

The way it works, is it starts from the buttom of the stack and
searches the first non-zero word in the stack. With dynamic stack it
does not work very well, as it means it faults every pages in every
stack.

Instead, add a specific version of stack_not_used() for dynamic stacks
where instead of starting from the buttom of the stack, we start from
the last page mapped in the stack.

In addition to not doing uncessary page faulting, this search is
optimized by skipping search through zero pages.

Also, because dynamic stack does not end with MAGIC_NUMBER, there is
no need to skeep the buttom most word in the stack.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/Kconfig                     |  1 -
 include/linux/sched/task_stack.h | 38 +++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index da3df347b069..759b2bb7edb6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1266,7 +1266,6 @@ config DYNAMIC_STACK
 	depends on HAVE_ARCH_DYNAMIC_STACK
 	depends on VMAP_STACK
 	depends on !KASAN
-	depends on !DEBUG_STACK_USAGE
 	depends on !STACK_GROWSUP
 	help
 	  Dynamic kernel stacks allow to save memory on machines with a lot of
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 396d5418ae32..c5fb679b31ee 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/magic.h>
 #include <linux/refcount.h>
+#include <linux/vmalloc.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
@@ -109,6 +110,21 @@ static inline void dynamic_stack(struct task_struct *tsk)
 
 static inline void set_task_stack_end_magic(struct task_struct *tsk) {}
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static inline unsigned long stack_not_used(struct task_struct *p)
+{
+	struct vm_struct *vm_area = p->stack_vm_area;
+	unsigned long alloc_size = vm_area->nr_pages << PAGE_SHIFT;
+	unsigned long stack = (unsigned long)p->stack;
+	unsigned long *n = (unsigned long *)(stack + THREAD_SIZE - alloc_size);
+
+	while (!*n)
+		n++;
+
+	return (unsigned long)n - stack;
+}
+#endif /* CONFIG_DEBUG_STACK_USAGE */
+
 #else /* !CONFIG_DYNAMIC_STACK */
 
 #define task_stack_end_corrupted(task) \
@@ -123,17 +139,6 @@ static inline bool dynamic_stack_fault(struct task_struct *tsk,
 	return false;
 }
 
-#endif /* CONFIG_DYNAMIC_STACK */
-
-static inline int object_is_on_stack(const void *obj)
-{
-	void *stack = task_stack_page(current);
-
-	return (obj >= stack) && (obj < (stack + THREAD_SIZE));
-}
-
-extern void thread_stack_cache_init(void);
-
 #ifdef CONFIG_DEBUG_STACK_USAGE
 #ifdef CONFIG_STACK_GROWSUP
 static inline unsigned long stack_not_used(struct task_struct *p)
@@ -160,6 +165,17 @@ static inline unsigned long stack_not_used(struct task_struct *p)
 #endif /* CONFIG_STACK_GROWSUP */
 #endif /* CONFIG_DEBUG_STACK_USAGE */
 
+#endif /* CONFIG_DYNAMIC_STACK */
+
+static inline int object_is_on_stack(const void *obj)
+{
+	void *stack = task_stack_page(current);
+
+	return (obj >= stack) && (obj < (stack + THREAD_SIZE));
+}
+
+extern void thread_stack_cache_init(void);
+
 static inline int kstack_end(void *addr)
 {
 	/* Reliable end of stack detection:
-- 
2.44.0.278.ge034bb2e1d-goog


