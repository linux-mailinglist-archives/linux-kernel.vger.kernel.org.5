Return-Path: <linux-kernel+bounces-143750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131158A3CF4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4030F1C2092B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33F446DC;
	Sat, 13 Apr 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9MOQg7w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E6446AF
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713017964; cv=none; b=L6qN8ontVjzJkFzB5+bts/J5kZBCNlQD/CSjxYf3owK9ZXTq/Oiz8Sv8gUHT6yEJjRU5FCnitZWRL224ddZ9j+iJE1cBZzctIIirY95NNjD3yH7oaPvII02INPo1dDD8qDT4gkvvgCWBM9WjYydr8MZjHKS2cRCa5dHYQJYNG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713017964; c=relaxed/simple;
	bh=pI4zqrbDe0xOthfGgbfKKxHvZXDTJNV784x8upizaIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPdqXo9Z4HNit6hZ5nshLOI79f6n1uuDTgFT8HWyJp/68hLwWrh/Vk5OrR2dwt5EqmFxFovJKu3GMvGxwVQRnP34J0X0BOJvneJPUMIvEXkLnAu/6mU1GyJkOFKFfT+50H7diJkcOU2LktRAwrZN3CmKg6zNhe27whnfq3dcv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9MOQg7w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713017961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z72n2c9rvzB7U1Xb9kq/ArIj/cYrcKMMmIL868r1S0Q=;
	b=N9MOQg7wvvVjzLBzK/wKyIzkUVZEuaJDYwRGZXia9I8By41LjvIOV3rtahTlHItV2VaV7X
	tpkWCSTOr0uqCQGGqJaoFjIiAk4i27XX45GcuSWb52TNWckpDoGnB9cbs2ZoyvS4ZKXxrM
	XiImTyq7BguqV6CoiNTTQ3HiEx3KxIk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-rkB8vYFPOx6M8ku4QDbPOA-1; Sat,
 13 Apr 2024 10:19:20 -0400
X-MC-Unique: rkB8vYFPOx6M8ku4QDbPOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E9041C03143;
	Sat, 13 Apr 2024 14:19:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id B2AFA2026D06;
	Sat, 13 Apr 2024 14:19:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 13 Apr 2024 16:17:53 +0200 (CEST)
Date: Sat, 13 Apr 2024 16:17:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: [PATCH] sched/isolation: fix boot crash when maxcpus <
 first-housekeeping-cpu
Message-ID: <20240413141746.GA10008@redhat.com>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <20240411143905.GA19288@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411143905.GA19288@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

housekeeping_setup() checks cpumask_intersects(present, online) to ensure
that the kernel will have at least one housekeeping CPU after smp_init(),
but this doesn't work if the maxcpus= kernel parameter limits the number
of processors available after bootup.

For example, the kernel with "maxcpus=2 nohz_full=0-2" parameters crashes
at boot time on my virtual machine with 4 CPUs.

Change housekeeping_setup() to use cpumask_first_and() and check that the
returned cpu number is valid and less than setup_max_cpus.

Another corner case is "nohz_full=0" on a machine with a single CPU or
with the maxcpus=1 kernel argument. In this case non_housekeeping_mask
is empty and IIUC tick_nohz_full_setup() makes no sense. And indeed, the
kernel hits the WARN_ON(tick_nohz_full_running) in tick_sched_do_timer().

And how should the kernel interpret the "nohz_full=" parameter? I think
it should be silently ignored, but currently cpulist_parse() happily
returns the empty cpumask and this leads to the same problem.

Change housekeeping_setup() to check cpumask_empty(non_housekeeping_mask)
and do nothing in this case.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sched/isolation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 2a262d3ecb3d..5891e715f00d 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -118,6 +118,7 @@ static void __init housekeeping_setup_type(enum hk_type type,
 static int __init housekeeping_setup(char *str, unsigned long flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
+	unsigned int first_cpu;
 	int err = 0;
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
@@ -138,7 +139,8 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
 
-	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
+	first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
+	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
 		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
 		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		if (!housekeeping.flags) {
@@ -147,6 +149,9 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 		}
 	}
 
+	if (cpumask_empty(non_housekeeping_mask))
+		goto free_housekeeping_staging;
+
 	if (!housekeeping.flags) {
 		/* First setup call ("nohz_full=" or "isolcpus=") */
 		enum hk_type type;
-- 
2.25.1.362.g51ebf55



