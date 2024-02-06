Return-Path: <linux-kernel+bounces-55525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77B84BDA9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41FA3B23738
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DF21B597;
	Tue,  6 Feb 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5z81I8E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD913FE2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246036; cv=none; b=XQVEHOkFRK1L1eniXHnYIOQ6EJjoHhsaTia7xBQpxBIRoCyEdIFoXW7+3uZ974xk/noDtUiO3eK5Jn/8DKo6FhCDu9QyFWXEaH7wZlX84hSlkYVbaxzdBESnw2eYQcwLVY2W7RJ1P0T+ipliPt137DXQsQC5ZZ50VpbUhT5gh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246036; c=relaxed/simple;
	bh=xMRGD+douvn1GyniumMUnx87zYhBacweAJuDukjwzso=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mRNnYJctI6/Ht2p2hZc6vuiMloRVt7uvEdbTAyiqhvBPEsfpU5SMgL1womFV1j1H6RFf7OhfwE2q4sGsI2skN6XDFnyepCpoU3gTtZnDzA/gkraNIwo/GY7Qb2v1GgL/9xR+7oDzgN7L5H7BSRTZXI2EtgYEYKn+rFlTWTtHFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5z81I8E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9S9tPpZAmseeiLZUrI+pVU9cbhqwZZw6DOXomnrNeHc=;
	b=E5z81I8EhMgvdkS3ckqz3BXP+LPGEuQVydiN1DmqKE9GgyNDHuYjGlz+5otWb7KMq+Yfzr
	C/Fd6+qCnN0YpR/iGfGLVXqDh4OWSgR+pDXcJCczbjow7uekZN9TvteqIqOQvYqmYMuN87
	gG5ULneluL3Mk8dmO05F1SzURDgml+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-uBtq7ULgOpq9Vlkm0gw09g-1; Tue, 06 Feb 2024 14:00:26 -0500
X-MC-Unique: uBtq7ULgOpq9Vlkm0gw09g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58E6F8489A6;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B6BA1103A;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 21F57401E1133; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185709.902281455@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:14 -0300
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
Subject: [patch 03/12] Introduce _fail variants of stop_machine functions
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Introduce stop_machine_fail and stop_machine_cpuslocked_fail,
which check if any online CPU in the system is tagged as 
a block interference CPU. 

If so, returns an error.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/include/linux/stop_machine.h
===================================================================
--- linux-isolation.orig/include/linux/stop_machine.h
+++ linux-isolation/include/linux/stop_machine.h
@@ -113,6 +113,9 @@ static inline void print_stop_info(const
  */
 int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
 
+
+int stop_machine_fail(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
+
 /**
  * stop_machine_cpuslocked: freeze the machine on all CPUs and run this function
  * @fn: the function to run
@@ -124,6 +127,9 @@ int stop_machine(cpu_stop_fn_t fn, void
  */
 int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
 
+
+int stop_machine_cpuslocked_fail(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
+
 /**
  * stop_core_cpuslocked: - stop all threads on just one core
  * @cpu: any cpu in the targeted core
Index: linux-isolation/kernel/stop_machine.c
===================================================================
--- linux-isolation.orig/kernel/stop_machine.c
+++ linux-isolation/kernel/stop_machine.c
@@ -22,6 +22,7 @@
 #include <linux/atomic.h>
 #include <linux/nmi.h>
 #include <linux/sched/wake_q.h>
+#include <linux/sched/isolation.h>
 
 /*
  * Structure to determine completion condition and record errors.  May
@@ -619,6 +620,17 @@ int stop_machine_cpuslocked(cpu_stop_fn_
 	return stop_cpus(cpu_online_mask, multi_cpu_stop, &msdata);
 }
 
+int stop_machine_cpuslocked_fail(cpu_stop_fn_t fn, void *data,
+				 const struct cpumask *cpus)
+{
+	block_interf_assert_held();
+
+	if (cpumask_intersects(block_interf_cpumask, cpu_online_mask))
+		return -EPERM;
+
+	return stop_machine_cpuslocked(fn, data, cpus);
+}
+
 int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
 {
 	int ret;
@@ -631,6 +643,19 @@ int stop_machine(cpu_stop_fn_t fn, void
 }
 EXPORT_SYMBOL_GPL(stop_machine);
 
+int stop_machine_fail(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
+{
+	int ret;
+
+	/* No CPUs can come up or down during this. */
+	cpus_read_lock();
+	ret = stop_machine_cpuslocked_fail(fn, data, cpus);
+	cpus_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stop_machine_fail);
+
+
 #ifdef CONFIG_SCHED_SMT
 int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
 {



