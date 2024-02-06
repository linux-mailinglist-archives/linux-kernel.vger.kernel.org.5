Return-Path: <linux-kernel+bounces-55522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D7484BDA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1762B23947
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A5B1AACD;
	Tue,  6 Feb 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHgV8i8r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9C14274
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246035; cv=none; b=lpHa0/i1cUfojKM/RTX473fbw+4VeRRgQJ1SRMGFkkdcOdoK3XX7BICjP79ugnz/f2pcyf4aqW0v21ImXGA+YHMV4kef84PpwtwVDwNYNjQ4R6m/MozvJPdMMq84ijk/uoDUVJ34S7l84264j9ThY+dYUrlfjccpaUk7gRjtsHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246035; c=relaxed/simple;
	bh=i8Przs01+5+AauKouVnKvrVBH6MR9m6+MAbeEFlDNtM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=W79KgsjKXqHg4fCMA8DC/f1gw9ghhJniTzyiK5IzJuUmlG1sbXjfhyEQFj3HyQZlepVk5jL8Iv5NCE62sN3cpPpqOYx1sQwVH6xGMntbLkxbiojGpHcRxLw73mXxqcVyY3k9SrAZt0rEuu2NHzCpNAzu3zaibwfq7LYEFsg+ioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHgV8i8r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qlDKbMqWBelqVSfNEbh2M7kUdtgo3q7n46OC/sINoRo=;
	b=NHgV8i8rTEYOTCdK32YWg8f+MEB06M6kXWudEVkG+ozuOT8SV3G25niScsYCci2/1fY4Fr
	NOG0vnHAMoh0kMSACqXjuBuI1vKN5HiC0Iw3KR84Qlix2tJjsbtr9jSvCDSSlzdabk/XX5
	NEhLplmu6anV8IYIVq/yGtGvs8v4JCA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-mjveR6rZPGOLWpW7CJvbBg-1; Tue,
 06 Feb 2024 14:00:26 -0500
X-MC-Unique: mjveR6rZPGOLWpW7CJvbBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54F0638212C8;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D117C0FDCB;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 3F6B0401E1311; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185710.037579553@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:19 -0300
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
Subject: [patch 08/12] arm64 kernel/topology: use smp_call_function_single_fail
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Convert cpu_read_constcnt from smp_call_function_single
to smp_call_func_single_fail, which will fail in case
the target CPU is tagged as block interference CPU.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/arch/arm64/kernel/topology.c
===================================================================
--- linux-isolation.orig/arch/arm64/kernel/topology.c
+++ linux-isolation/arch/arm64/kernel/topology.c
@@ -17,6 +17,7 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -280,6 +281,8 @@ static void cpu_read_constcnt(void *val)
 static inline
 int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
 {
+	int ret, idx;
+
 	/*
 	 * Abort call on counterless CPU or when interrupts are
 	 * disabled - can lead to deadlock in smp sync call.
@@ -290,7 +293,11 @@ int counters_read_on_cpu(int cpu, smp_ca
 	if (WARN_ON_ONCE(irqs_disabled()))
 		return -EPERM;
 
-	smp_call_function_single(cpu, func, val, 1);
+	idx = block_interf_srcu_read_lock();
+	ret = smp_call_function_single_fail(cpu, func, val, 1);
+	block_interf_srcu_read_unlock(idx);
+	if (ret)
+		return ret;
 
 	return 0;
 }



