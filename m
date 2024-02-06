Return-Path: <linux-kernel+bounces-55524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8E84BDA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A611C25B89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9FE1B285;
	Tue,  6 Feb 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOvT5mEl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18C13AEE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246035; cv=none; b=jkEs+DbVVKaEWGTryQ88zqQLvzs+C2S+/gP6y/WCw1THt9ryQwGnHR2kbdnNG0ERSI1+i/W/6G/0SOmb03Q0YtQr+NRixutJIku2cSjuwrDUI6JPkpOFL6UllEgiTksiUr+Nll2zBpwzGQjYC80bPN9vgp/YwWiTBq6CHvvJ56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246035; c=relaxed/simple;
	bh=uPC2rNLYVTQLQRKU50mz+VRM3plkRRFHphs5ErFIBks=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IxfT36TbQwNLke+D05qkYqw2WFtX43Xl/sCZ6TW5EHpZKYSsulRkhAClkJIRzhWxmqlXnGV+O17NrmLU7yG8VLYH87YH5D64MLCPoYkegwendATXuI3j9dc0G/c6ULAfRtwPk5b5MUeqxXYN70Zn5xQhWLFKWHYe13fgY46Xgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOvT5mEl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zLB3WYtViBcdTkVKTj38aoMTQk2dk2XqSaaUs30i/zM=;
	b=ZOvT5mEl+E+uao5IETJ2aNTqWOBmg6skbOLwPxcQtlczUYjLxIhTgqGI85ybfqUQkJqMFg
	TBE2xcXk3aoJPZ4gepwWwYRBOnALmA818VP+mY9MoUiUxmhcJOOaAGQESF4z9wii0LipNU
	9cgHPvhBKNYefkoYbmVtgaknG3EQY84=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-HcEczxWENVW9MyNafmkoUA-1; Tue, 06 Feb 2024 14:00:25 -0500
X-MC-Unique: HcEczxWENVW9MyNafmkoUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D791185A780;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 05D2C4015465;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 1D5FF401E1111; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185709.876814623@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:13 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 02/12] introduce smp_call_func_single_fail
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Introduce smp_call_func_single_fail, which checks if
the target CPU is tagged as a "block interference" CPU,
and returns an error if so.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/include/linux/smp.h
===================================================================
--- linux-isolation.orig/include/linux/smp.h
+++ linux-isolation/include/linux/smp.h
@@ -50,6 +50,9 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
+int smp_call_function_single_fail(int cpuid, smp_call_func_t func, void *info,
+				  int wait);
+
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
Index: linux-isolation/kernel/smp.c
===================================================================
--- linux-isolation.orig/kernel/smp.c
+++ linux-isolation/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <linux/nmi.h>
 #include <linux/sched/debug.h>
 #include <linux/jump_label.h>
+#include <linux/sched/isolation.h>
 
 #include <trace/events/ipi.h>
 #define CREATE_TRACE_POINTS
@@ -655,6 +656,30 @@ int smp_call_function_single(int cpu, sm
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
+/*
+ * smp_call_function_single_fail - Run a function on a specific CPU,
+ * failing if any target CPU is marked as "no ipi".
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait until function has completed on other CPUs.
+ *
+ * Returns 0 on success, else a negative status code.
+ */
+int smp_call_function_single_fail(int cpu, smp_call_func_t func, void *info,
+			     int wait)
+{
+	int err;
+
+	block_interf_assert_held();
+	if (block_interf_cpu(cpu))
+		return -EPERM;
+
+	err = smp_call_function_single(cpu, func, info, wait);
+
+	return err;
+}
+EXPORT_SYMBOL(smp_call_function_single_fail);
+
 /**
  * smp_call_function_single_async() - Run an asynchronous function on a
  * 			         specific CPU.



