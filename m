Return-Path: <linux-kernel+bounces-86037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51F86BED0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7DB1C23D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B293376E4;
	Thu, 29 Feb 2024 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCMWisb7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB536AFF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172901; cv=none; b=cNVUIHJZ1OWavto36r5/pODRS7+3aHSTrlztUbI6TmJlQ3PtfkRWvBT8y+RLDvEpKN2AvprT1iMVrZOBPbdhy6qRrIo2ku46cNuMK7tUPmIo9jMAmBvfsX52cpWS/KZ1z12j+yXICEhBX4MFZh8CXqanR42QcYiGVY5nCSx5z1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172901; c=relaxed/simple;
	bh=sakExV8Zhp5Sh/q1+gBQuscarUS25o1Em4K3tkAC4hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uiwa4v5PoZ9gg6b9+1iKDu1urNRutxQTCMbPYZVAMZ20aDsOr6Eo6042FW3XD1thQjPpFN2gZAZiZCdBJ0lsxi3W2VfI4Z7/LW/E2+S7qNvtoMPnr5cVQIs2FRpAZWlXNlwwaYUl5r9Xj81Ubgf81vhkYz0erT5PUWrKJzuV7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCMWisb7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709172898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XKfDwEYq77yh2Tx7xxyUZeYeDXKbwbjelgL1h1OpUk=;
	b=iCMWisb7YdMJFW1meLGylIuuQDACZaR+KNXB233LUevdoF3ej/6KaWAOUgjH3sp0vQB/p3
	HA1rZC6UWl1bhN30G9ozPbw+t1jqGvaDO4y6B5TEZVSEacz9BV1sh7nJqMYqfqzjW1dIPw
	7QQ2wmrvW0vfbuUbIjsYouK2ce2bFN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-hYHPAaMkPg2jcoflFBPneA-1; Wed, 28 Feb 2024 21:14:54 -0500
X-MC-Unique: hYHPAaMkPg2jcoflFBPneA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E47AA85A588;
	Thu, 29 Feb 2024 02:14:53 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5AE30492BFA;
	Thu, 29 Feb 2024 02:14:52 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Cestmir Kalina <ckalina@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] cgroup/cpuset: Exclude isolated CPUs from housekeeping CPU masks
Date: Wed, 28 Feb 2024 21:14:14 -0500
Message-Id: <20240229021414.508972-3-longman@redhat.com>
In-Reply-To: <20240229021414.508972-1-longman@redhat.com>
References: <20240229021414.508972-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Call the newly introduced housekeeping_exlude_isolcpus() function to
exclude isolated CPUs from the selected housekeeping CPU masks. This
is in addition to the exclusion of isolated CPUs from the workqueue
unbound CPU mask.

Right now only HK_TYPE_TIMER and HK_TYPE_RCU CPU masks are updated,
but more may be added in the future when appropriate.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ba36c073304a..d2541af71c22 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -214,6 +214,11 @@ static cpumask_var_t	isolated_cpus;
 /* List of remote partition root children */
 static struct list_head remote_children;
 
+/*
+ * The set of housekeeping flags to be updated for CPU isolation
+ */
+#define	HOUSEKEEPING_FLAGS	(BIT(HK_TYPE_TIMER) | BIT(HK_TYPE_RCU))
+
 /*
  * Partition root states:
  *
@@ -1505,7 +1510,15 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
-static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+/**
+ * update_isolation_cpumasks - Update external isolation CPU masks
+ * @isolcpus_updated - @true if isolation CPU masks update needed
+ *
+ * The following external CPU masks will be updated if necessary:
+ * - workqueue unbound cpumask
+ * - housekeeping cpumasks
+ */
+static void update_isolation_cpumasks(bool isolcpus_updated)
 {
 	int ret;
 
@@ -1515,7 +1528,10 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
 		return;
 
 	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
+	if (WARN_ON_ONCE(ret < 0))
+		return;
+	ret = housekeeping_exlude_isolcpus(isolated_cpus, HOUSEKEEPING_FLAGS);
+	WARN_ON_ONCE((ret < 0) && (ret != -EOPNOTSUPP));
 }
 
 /**
@@ -1609,7 +1625,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 		parent->child_ecpus_count--;
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1645,7 +1661,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 		cs->prs_err = PERR_INVCPUS;
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1697,7 +1713,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 	if (deleting)
 		isolcpus_updated += partition_xcpus_del(prs, NULL, tmp->delmask);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -2067,7 +2083,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive(cs, new_prs);
@@ -3131,7 +3147,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (new_xcpus_state)
 		partition_xcpus_newstate(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(new_xcpus_state);
+	update_isolation_cpumasks(new_xcpus_state);
 
 	/* Force update if switching back to member */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs ? HIER_CHECKALL : 0);
-- 
2.39.3


