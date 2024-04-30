Return-Path: <linux-kernel+bounces-163645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEAF8B6E10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8BD1C22B50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A8194C67;
	Tue, 30 Apr 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFOMiXg2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF712882C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468716; cv=none; b=rNamzs+CBkPlSsfAFtGodB1F00XJUHJeNz9lo/fZmyhAhfp23K2II/8iVOox+wQPEQBTwM9bggfrNeU8NI6dEuI5QeuMnTDS8s5V7OoIX4cNKweEwf75DVIBp76TRutblpX82aPcMzksZBv9nLh3VKZoL14PY5SmnMP5Iuy8TRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468716; c=relaxed/simple;
	bh=vTXAbWPf528CGOPRPHhrK/5DgDKcJ2olcfkLSdAkzsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urMzLDRFO8PJ7n8tKEC3DmJ6EYRicttx2PVvIKwW2nyrmKl9jMS8aYYwUaUDqDJYYWLQKr1cMxWFPoHTxAmBZDcqKIPdksRHuWK43VY5NywxZykm2fMFah+VbmSwV3JfJpYLVGxKtabYZzyKXLEbTb2M4G/EC7+fNV1Pw8iDtnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFOMiXg2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn/5LgqL3qOuQrveZYN9sQdmnsvH18cAdWIQSmCXARQ=;
	b=EFOMiXg2Sm4dJUNeClhlHecgsZxmYHqdMrNzve5axx/5E2p8k0KVHyG8+THO1Cq4aXxHLO
	dCxSWPUcbmP8BcyFWsUgldG+YoGoE3bumSNAIEYuaGWxkyVWMSZHE8gSrKL3gr3PRpEzNK
	JdRXd3DScCCMucRMr8PFloI8Jw9c4p0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-lwomzJ_6O0ynqPs0qAkC9w-1; Tue,
 30 Apr 2024 05:18:29 -0400
X-MC-Unique: lwomzJ_6O0ynqPs0qAkC9w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE7163C02526;
	Tue, 30 Apr 2024 09:18:28 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 21C1B40BAA2;
	Tue, 30 Apr 2024 09:18:25 +0000 (UTC)
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
Subject: [PATCH v2 08/27] context_tracking, rcu: Rename ct_dynticks_nesting_cpu() into ct_nesting_cpu()
Date: Tue, 30 Apr 2024 11:17:12 +0200
Message-ID: <20240430091740.1826862-9-vschneid@redhat.com>
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
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/context_tracking_state.h | 2 +-
 kernel/rcu/tree_stall.h                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 586c1ff22c2e9..fd42d8120ac29 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -80,7 +80,7 @@ static __always_inline long ct_nesting(void)
 	return __this_cpu_read(context_tracking.nesting);
 }
 
-static __always_inline long ct_dynticks_nesting_cpu(int cpu)
+static __always_inline long ct_nesting_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 460efecd077be..d8e5b49e65565 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -516,7 +516,7 @@ static void print_cpu_stall_info(int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       rcu_dynticks_snap(cpu) & 0xffff,
-	       ct_dynticks_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
+	       ct_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       rcuc_starved ? buf : "",
-- 
2.43.0


