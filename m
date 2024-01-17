Return-Path: <linux-kernel+bounces-29223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AA5830B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F0A1C216F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9D21A13;
	Wed, 17 Jan 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDGzkdlQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB2224EF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509377; cv=none; b=FmGGA9+OYSDPY5HuTaiD96KfH1nux3+Xm/3DcwohaNKfG0KMY6V2v982Wqiw8E5MYtTN2jn6Qh7tOQ72ii8tkYfedvL3p8o64TMEsfy5GQjc63leXDPh10B9dh5QQQ1Z8wfBCc8jbxjrF5wy0DAIzgVsjr0n4hauEJQocF4pAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509377; c=relaxed/simple;
	bh=T/btiksz2pjdc/htwRedVgNxpGRbSjdss4lHcMx0Ds4=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=CloCn1Y6dmOIn9B/gnlIsZySIZvut7UnhuJyMCdsevYx6ozCUnBE0cUG9Q44FDd2QIn5PRdtPyHSer+nnbo8xAaDELRRyg39Pn/mKwnqYQrPMK+3TRfzTDdVf+8vu4O3ab3uShWBRQMAbZBLG/MYVy2Ie/Mak2wJLch1JcpEoW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDGzkdlQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMKTEJCLgRjbNlvIEToGyQAyufjPtT3IoQqw3muUhg4=;
	b=GDGzkdlQtqiQPd72MkC+Si9H1MpKoURC4x+oXk2PuZnUlgcT4uwPjIfe/viMxdG91AZvMx
	jQL5N5z+Oxkdqqd3m2vq4el4hP3ry3HyOjIkOp0x52iznc4sHOi47AG1wn5wKacWKB+vIs
	nVDjUmmRw5cAhnrtyIAPOBdNqF35pyU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-y1ui9Ik_OUyghLE7fiOplw-1; Wed,
 17 Jan 2024 11:36:09 -0500
X-MC-Unique: y1ui9Ik_OUyghLE7fiOplw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11A88383009D;
	Wed, 17 Jan 2024 16:36:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F72D1121306;
	Wed, 17 Jan 2024 16:36:06 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Alex Gladkov <agladkov@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 2/8] rcu/nocb: Prepare to change nocb cpumask from CPU-hotplug protected cpuset caller
Date: Wed, 17 Jan 2024 11:35:05 -0500
Message-Id: <20240117163511.88173-3-longman@redhat.com>
In-Reply-To: <20240117163511.88173-1-longman@redhat.com>
References: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

From: Frederic Weisbecker <frederic@kernel.org>

cpusets is going to use the NOCB (de-)offloading interface while
holding hotplug lock. Therefore pull out the responsibility of protecting
against concurrent CPU-hotplug changes to the callers of
rcu_nocb_cpumask_update().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/rcu/rcutorture.c | 2 ++
 kernel/rcu/tree_nocb.h  | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 228a5488eb5e..e935152346ff 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2139,6 +2139,7 @@ static int rcu_nocb_toggle(void *arg)
 	do {
 		r = torture_random(&rand);
 		cpu = (r >> 1) % (maxcpu + 1);
+		cpus_read_lock();
 		if (r & 0x1) {
 			rcu_nocb_cpumask_update(cpumask_of(cpu), true);
 			atomic_long_inc(&n_nocb_offload);
@@ -2146,6 +2147,7 @@ static int rcu_nocb_toggle(void *arg)
 			rcu_nocb_cpumask_update(cpumask_of(cpu), false);
 			atomic_long_inc(&n_nocb_deoffload);
 		}
+		cpus_read_unlock();
 		toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 60b0a15ed6e2..bbcf6f4152a3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1301,12 +1301,13 @@ int rcu_nocb_cpumask_update(const struct cpumask *cpumask, bool offload)
 	int err_cpu;
 	cpumask_var_t saved_nocb_mask;
 
+	lockdep_assert_cpus_held();
+
 	if (!alloc_cpumask_var(&saved_nocb_mask, GFP_KERNEL))
 		return -ENOMEM;
 
 	cpumask_copy(saved_nocb_mask, rcu_nocb_mask);
 
-	cpus_read_lock();
 	mutex_lock(&rcu_state.barrier_mutex);
 	for_each_cpu(cpu, cpumask) {
 		if (offload) {
@@ -1340,7 +1341,6 @@ int rcu_nocb_cpumask_update(const struct cpumask *cpumask, bool offload)
 	}
 
 	mutex_unlock(&rcu_state.barrier_mutex);
-	cpus_read_unlock();
 
 	free_cpumask_var(saved_nocb_mask);
 
-- 
2.39.3


