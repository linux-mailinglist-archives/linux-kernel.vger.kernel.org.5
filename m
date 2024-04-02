Return-Path: <linux-kernel+bounces-127862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6AD8951D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71F6B2684B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4875764CF9;
	Tue,  2 Apr 2024 11:29:34 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B40914CB4A;
	Tue,  2 Apr 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057373; cv=none; b=LnzZ1vAF0DdhMI6HxJ+CmsRHhi4kSTOS+AaIRvBZlSHTmGbVJcfF24gHDVIM7Z1jYPriUzYEJF+iV2HagMFvnebvXoPds7rSIsAcH/LgwivIbSB6lg3JShPAA40GidRfwGPbdFAI+H75docvY3t6i2/Qq/BvXHDwlIJfT9bvmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057373; c=relaxed/simple;
	bh=IDwFw33UJOLLRNA0nIg6tMumyxRK6Hn6ZouhIx51qYk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bUZ/71FAeCePRnS5Se4Wx1UY6lXb1HUGhrks79Iz11V3Ytz4yvnKpOXHIXBH2i7fQMwuS9BKIbq2vF5/jiw2IjyRkJl+1ANCQnMkoRzgkd2IpG9urrh3Gwn57WQiTIrc2vvS6HWOb2iyFWXFfnSVtdLF/RiQeWGIYBkoHpNKazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 9F92B18097DE94;
	Tue,  2 Apr 2024 19:29:28 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 19:29:28 +0800
Date: Tue, 2 Apr 2024 19:29:22 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: Tio Zhang <tiozhang@didiglobal.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <rostedt@goodmis.org>, <bsingharora@gmail.com>,
	<corbet@lwn.net>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <tiozhang@didiglobal.com>,
	<zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>, <fuyuanli@didiglobal.com>
Subject: [PATCH 3/3] delayacct/taskstats: make soft_delay available in
 taskstats
Message-ID: <20240402112922.GA18945@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsingharora@gmail.com, corbet@lwn.net,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net,
	fuyuanli@didiglobal.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402112700.GA18519@didi-ThinkCentre-M930t-N000>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

Also update a new version of tools/accounting/getdelays.c.

	# ./getdelays -t 4600 -d
	print delayacct stats ON
	TGID	4600
	
	CPU             count     real total  virtual total    delay total  delay average
                 	3973    10700014780    10698803222   312345815813         78.617ms
	IO              count    delay total  delay average
                    	0              0              0.000ms
	SWAP            count    delay total  delay average
                    	0              0              0.000ms
	RECLAIM         count    delay total  delay average
                    	0              0              0.000ms
	THRASHING       count    delay total  delay average
                    	0              0              0.000ms
	COMPACT         count    delay total  delay average
                    	0              0              0.000ms
	WPCOPY          count    delay total  delay average
                   	40         266859             0.007ms
	IRQ             count    delay total  delay average
                	13450    17756373906          1.320ms
	SOFTIRQ         count    delay total  delay average

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 Documentation/accounting/delay-accounting.rst | 5 ++++-
 include/uapi/linux/taskstats.h                | 6 +++++-
 kernel/delayacct.c                            | 3 +++
 tools/accounting/getdelays.c                  | 8 +++++++-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index f61c01fc376e..babff410a39d 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -17,6 +17,7 @@ e) thrashing
 f) direct compact
 g) write-protect copy
 h) IRQ/SOFTIRQ
+i) SOFTIRQ
 
 and makes these statistics available to userspace through
 the taskstats interface.
@@ -50,7 +51,7 @@ this structure. See
 for a description of the fields pertaining to delay accounting.
 It will generally be in the form of counters returning the cumulative
 delay seen for cpu, sync block I/O, swapin, memory reclaim, thrash page
-cache, direct compact, write-protect copy, IRQ/SOFTIRQ etc.
+cache, direct compact, write-protect copy, IRQ/SOFTIRQ, SOFTIRQ etc.
 
 Taking the difference of two successive readings of a given
 counter (say cpu_delay_total) for a task will give the delay
@@ -123,6 +124,8 @@ Get sum of delays, since system boot, for all pids with tgid 5::
                        0              0          0.000ms
 	IRQ             count    delay total  delay average
                        0              0          0.000ms
+	SOFTIRQ         count    delay total  delay average
+                       0              0          0.000ms
 
 Get IO accounting for pid 1, it works only with -p::
 
diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index b50b2eb257a0..5412c4d6734d 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	14
+#define TASKSTATS_VERSION	15
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -202,6 +202,10 @@ struct taskstats {
 	/* v14: Delay waiting for IRQ/SOFTIRQ */
 	__u64    irq_count;
 	__u64    irq_delay_total;
+
+	/* v15: Delay waiting for SOFTIRQ */
+	__u64    soft_count;
+	__u64    soft_delay_total;
 };
 
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 8517f1c1df88..39d9430d723f 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -181,6 +181,8 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->wpcopy_delay_total = (tmp < d->wpcopy_delay_total) ? 0 : tmp;
 	tmp = d->irq_delay_total + tsk->delays->irq_delay;
 	d->irq_delay_total = (tmp < d->irq_delay_total) ? 0 : tmp;
+	tmp = d->soft_delay_total + tsk->delays->soft_delay;
+	d->soft_delay_total = (tmp < d->soft_delay_total) ? 0 : tmp;
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
 	d->freepages_count += tsk->delays->freepages_count;
@@ -188,6 +190,7 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->compact_count += tsk->delays->compact_count;
 	d->wpcopy_count += tsk->delays->wpcopy_count;
 	d->irq_count += tsk->delays->irq_count;
+	d->soft_count += tsk->delays->soft_count;
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 1334214546d7..6e4e032e93c4 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -210,6 +210,8 @@ static void print_delayacct(struct taskstats *t)
 	       "WPCOPY   %12s%15s%15s\n"
 	       "      %15llu%15llu%15.3fms\n"
 	       "IRQ   %15s%15s%15s\n"
+	       "      %15llu%15llu%15.3fms\n"
+	       "SOFTIRQ  %12s%15s%15s\n"
 	       "      %15llu%15llu%15.3fms\n",
 	       "count", "real total", "virtual total",
 	       "delay total", "delay average",
@@ -245,7 +247,11 @@ static void print_delayacct(struct taskstats *t)
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->irq_count,
 	       (unsigned long long)t->irq_delay_total,
-	       average_ms((double)t->irq_delay_total, t->irq_count));
+	       average_ms((double)t->irq_delay_total, t->irq_count),
+	       "count", "delay total", "delay average",
+	       (unsigned long long)t->soft_count,
+	       (unsigned long long)t->soft_delay_total,
+	       average_ms((double)t->soft_delay_total, t->soft_count));
 }
 
 static void task_context_switch_counts(struct taskstats *t)
-- 
2.17.1


