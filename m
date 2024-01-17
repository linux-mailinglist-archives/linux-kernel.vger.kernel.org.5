Return-Path: <linux-kernel+bounces-29229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF831830B43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843E01F2BDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28232420F;
	Wed, 17 Jan 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpEFYwjn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCB2375A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509383; cv=none; b=ReFMOaPLnoMOej1LcwX6rp5lLSr/pgsdSk3mpxyH2yw9ih7/5RkVc1bkCb1f6jKufGAdJrocvMyaN4AdRFLcO+otg8Kp0sMQTGai2l1cS1AuiT7bHfefTpTm9GMe4cMwevLmWEpjaiO1UN2o0F9PtFSxvKB3yEOJocBfhcD3heY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509383; c=relaxed/simple;
	bh=i0Ofa11RRO77lr53R6C5icaSmSfpdwG1dq7E5sm7z1M=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=YwkDFLH40gRonH5avFztsi7C8P9xNIu5C7bTnVlfUilo1NcB7d0BSNaM7fqPEQPoP4D+/Ju39BHqY51sghRj8dzOihrf5+eBnpGs8GYXHOspsN5Xqt8kMX0DhXcY6b5p3oGGcjVDz5cH2lL/FwrgctCExdbGWNlue+leQMK/SSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpEFYwjn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KotaQECG6rJbRoU9m6xm3uHY0VUggl9xjizYviPB8yA=;
	b=RpEFYwjntHyPknbmLTLp8ZS0AFhAaDTmNElOsLQQzr+hE7AQMM9Fh1YcpSJHBfVrHEzy91
	0GlE35nz/vti2HRixr4UcQYoM0bgZUPRy9UQP9AXXSsfTFSdthOJtyBDqH6Dh/OBOAKcsE
	PGPvCRNe6rwf3YBqRAl5PECheu1Am7s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-P98TlzovNymX4FjnA35Hcg-1; Wed, 17 Jan 2024 11:36:18 -0500
X-MC-Unique: P98TlzovNymX4FjnA35Hcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FDC4185A7A8;
	Wed, 17 Jan 2024 16:36:16 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D1B9F1121306;
	Wed, 17 Jan 2024 16:36:14 +0000 (UTC)
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
Subject: [RFC PATCH 7/8] cgroup/cpuset: Document the new cpuset.cpus.isolation_full control file
Date: Wed, 17 Jan 2024 11:35:10 -0500
Message-Id: <20240117163511.88173-8-longman@redhat.com>
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

Document the new cpuset.cpus.isolation_full control file. Currently only
the rcu_nocbs flag is supported, but more will be added in the future.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 17e6e9565156..bbd066838f93 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2352,6 +2352,30 @@ Cpuset Interface Files
 	isolated partitions. It will be empty if no isolated partition
 	is created.
 
+  cpuset.cpus.isolation_full
+	A read multiple values and write single value file which exists
+	on root cgroup only.
+
+	This file shows the state of full CPU isolation mode for isolated
+	CPUs in isolated partitions.  It shows either "0' if full CPU
+	isolation mode is disabled, or "1" followed by a comma-separated
+	list of additional CPU isolation flags that are enabled.
+	The currently supported CPU isolation flag is:
+
+	  rcu_nocbs
+		RCU no-callback CPU mode, which prevents such CPUs'
+		callbacks from being invoked in softirq context.
+		Invocation of such CPUs' RCU callbacks will instead be
+		offloaded to "rcuox/N" kthreads created for that purpose.
+		It is similar in functionality to the "rcu_nocbs"
+		boot command line option, but for dynamically created
+		isolated CPUs in isolated partitions.  This flag can
+		only be enabled if such a "rcu_nocbs" option is present
+		in the boot command line of the running kernel.
+
+	Full CPU isolation mode is enabled by writing a non-zero value
+	to this file and disabled by writing a zero value to it.
+
   cpuset.cpus.partition
 	A read-write single value file which exists on non-root
 	cpuset-enabled cgroups.  This flag is owned by the parent cgroup
-- 
2.39.3


