Return-Path: <linux-kernel+bounces-163642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E968B6E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C171C22ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A113BC36;
	Tue, 30 Apr 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQsybZG2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AE129E8A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468708; cv=none; b=lL/r0GlPSasmVLqUnKNMajBSmr5szz6VaL1GHIs61BD+75OCWKvLacSBSqCtCFOdaUwCquVlx+h9lZvT4cLFTXnw1+1ddQs3RF57iNxZ1j8O+QkkEZOjkd1s6VNoEG5tNkgbmhgylT/D8VWZZ+H+z8MeHV+e6arTRmNJRTuWfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468708; c=relaxed/simple;
	bh=FzoCm0SHtCsJ3kYDzu0estuogSzw1EbbPtNv/mWqBJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=he2rArlZg3NQV9hoojxKQjHLrUZ34/AsvH9x3u/u4vgJpvAtrj99sYtTlLC0H7/WhVpMr+gfAQ0uv2VKFDP0JShQ+HFcLXbUvt/9SD6DlOcJlufF3/9DOJ616CLhzxhd3vdJzQgxVoFpXkgnb6ymZx4l4suN0oFQ/9anEYpm4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQsybZG2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+QzE4nMM/IXDmBl/gQfk9o3dUS97Owm1KeM6oa2cDo=;
	b=EQsybZG2rDa0izrEN/3/9SZBOF2khNwhNF2DjkjtAzFcRK8oN3qO1BbjGpMwxM4eD+euqB
	zpouASs6qIUjRu14oGIM9h5uejEGuJF1GQp5uAKgmYTTf8GpnZUhxUyB+QhTMppwunskb1
	gWN5dSVuERLkcFXh4/OUGnemB2kSdYE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-_-Jnpc6RO-moxPY506shMw-1; Tue, 30 Apr 2024 05:18:21 -0400
X-MC-Unique: _-Jnpc6RO-moxPY506shMw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 675681044573;
	Tue, 30 Apr 2024 09:18:20 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D3E67492BC7;
	Tue, 30 Apr 2024 09:18:17 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 05/27] context_tracking, rcu: Rename ct_dynticks_cpu_acquire() into ct_rcu_watching_cpu_acquire()
Date: Tue, 30 Apr 2024 11:17:09 +0200
Message-ID: <20240430091740.1826862-6-vschneid@redhat.com>
In-Reply-To: <20240430091740.1826862-1-vschneid@redhat.com>
References: <20240430091740.1826862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/context_tracking_state.h | 2 +-
 kernel/rcu/tree.c                      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index ad5a06a42b4a0..ad6570ffeff3c 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -68,7 +68,7 @@ static __always_inline int ct_rcu_watching_cpu(int cpu)
 	return atomic_read(&ct->state) & CT_RCU_WATCHING_MASK;
 }
 
-static __always_inline int ct_dynticks_cpu_acquire(int cpu)
+static __always_inline int ct_rcu_watching_cpu_acquire(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e4295d040cc9b..5f6400a97471b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -303,7 +303,7 @@ static void rcu_dynticks_eqs_online(void)
 static int rcu_dynticks_snap(int cpu)
 {
 	smp_mb();  // Fundamental RCU ordering guarantee.
-	return ct_dynticks_cpu_acquire(cpu);
+	return ct_rcu_watching_cpu_acquire(cpu);
 }
 
 /*
-- 
2.43.0


