Return-Path: <linux-kernel+bounces-55518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F8584BDA2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D955292762
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614111429A;
	Tue,  6 Feb 2024 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHHhdJTw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507701426F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246034; cv=none; b=D12j/W/W+lp785RMWWubA5kY0aNBKSotB1bvTmi8MeeZOr4tCE8gJb7AtY35dVZzm813EiE1I5BFH9ZvmWCW/O9V6y4TR1Cf7jbDoXM7LpwJ1nFwl/a1CnDCbjq19sbvspYLBn2Mg8CGWz8CQXcClvfL6lHuynjA8DzcMW4lbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246034; c=relaxed/simple;
	bh=daz3lcICgKm4ORgHnwPvFe7sWvQh/KVh8kswKSeKAW0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RNz3z6vUpIibPJsDkQzZis+RU1lCR9NwVUmbsQeewIaHZM6ZCaM4PkT4RuiMMVQRCFflNdB036qed8+7eoRgbLyggKrsmk0yz7/kKRJeIu7K11kBfRLn1zeAphocqHG2xmOU1DSTH/ii6CA1stIu07LvFcE5fw4sZRMNEo3QCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHHhdJTw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XLGveArYXH+nDRK2eZvc/caQl6NFDd9KJm+PgMdFiUY=;
	b=HHHhdJTwKqyyMvQHJ9l7F2bTxNnPejgTj8QH7wNiZrQpHEziwGxtegGtVMln5cvEFYet2R
	9hMmEdAd+7UjB+mRvtBrPzxXKdUJJH53IPOuVi1WkUDp8CJajYKqNH7niAxF5psNgr+Cxq
	vYaTQ9rhADEyZdiD2+c38FgXeBARlVg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-gLlXglagPQe6S18qGbwUog-1; Tue,
 06 Feb 2024 14:00:24 -0500
X-MC-Unique: gLlXglagPQe6S18qGbwUog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB69938212C8;
	Tue,  6 Feb 2024 19:00:23 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 688B4C1596E;
	Tue,  6 Feb 2024 19:00:23 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 5BD34401E140A; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185710.142514323@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:23 -0300
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
Subject: [patch 12/12] x86/cacheinfo.c: check for block interference CPUs
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Change amd_set_l3_disable_slot to check for block interference
cpumask, and avoid the IPI if set.

Also change wbinvd_on_cpu to use smp_call_function_single_fail.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/arch/x86/include/asm/smp.h
===================================================================
--- linux-isolation.orig/arch/x86/include/asm/smp.h
+++ linux-isolation/arch/x86/include/asm/smp.h
@@ -118,7 +118,7 @@ int native_cpu_disable(void);
 void __noreturn hlt_play_dead(void);
 void native_play_dead(void);
 void play_dead_common(void);
-void wbinvd_on_cpu(int cpu);
+int wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
Index: linux-isolation/arch/x86/kernel/cpu/cacheinfo.c
===================================================================
--- linux-isolation.orig/arch/x86/kernel/cpu/cacheinfo.c
+++ linux-isolation/arch/x86/kernel/cpu/cacheinfo.c
@@ -17,6 +17,7 @@
 #include <linux/sysfs.h>
 #include <linux/pci.h>
 #include <linux/stop_machine.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/cpufeature.h>
 #include <asm/cacheinfo.h>
@@ -396,6 +397,7 @@ static void amd_l3_disable_index(struct
 	 *  disable index in all 4 subcaches
 	 */
 	for (i = 0; i < 4; i++) {
+		int ret;
 		u32 reg = idx | (i << 20);
 
 		if (!nb->l3_cache.subcaches[i])
@@ -409,6 +411,7 @@ static void amd_l3_disable_index(struct
 		 * is not sufficient.
 		 */
 		ret = wbinvd_on_cpu(cpu);
+		WARN_ON(ret == -EPERM);
 
 		reg |= BIT(31);
 		pci_write_config_dword(nb->misc, 0x1BC + slot * 4, reg);
@@ -428,7 +431,7 @@ static void amd_l3_disable_index(struct
 static int amd_set_l3_disable_slot(struct amd_northbridge *nb, int cpu,
 			    unsigned slot, unsigned long index)
 {
-	int ret = 0;
+	int idx, ret = 0;
 
 	/*  check if @slot is already used or the index is already disabled */
 	ret = amd_get_l3_disable_slot(nb, slot);
@@ -442,7 +445,15 @@ static int amd_set_l3_disable_slot(struc
 	if (index == amd_get_l3_disable_slot(nb, !slot))
 		return -EEXIST;
 
-	amd_l3_disable_index(nb, cpu, slot, index);
+	ret = 0;
+	idx = block_interf_srcu_read_lock();
+
+	if (block_interf_cpu(cpu))
+		ret = -EPERM;
+	else
+		amd_l3_disable_index(nb, cpu, slot, index);
+
+	block_interf_srcu_read_unlock(idx);
 
 	return 0;
 }
Index: linux-isolation/arch/x86/lib/cache-smp.c
===================================================================
--- linux-isolation.orig/arch/x86/lib/cache-smp.c
+++ linux-isolation/arch/x86/lib/cache-smp.c
@@ -7,9 +7,9 @@ static void __wbinvd(void *dummy)
 	wbinvd();
 }
 
-void wbinvd_on_cpu(int cpu)
+int wbinvd_on_cpu(int cpu)
 {
-	smp_call_function_single(cpu, __wbinvd, NULL, 1);
+	return smp_call_function_single_fail(cpu, __wbinvd, NULL, 1);
 }
 EXPORT_SYMBOL(wbinvd_on_cpu);
 



