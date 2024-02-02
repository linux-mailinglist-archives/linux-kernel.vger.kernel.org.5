Return-Path: <linux-kernel+bounces-49439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D013846A59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CDA1F25CE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EE818635;
	Fri,  2 Feb 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0f7NL+i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DF1862A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861443; cv=none; b=ojkVLnnyUGGW1pxDEfGSDWBVWJBToKJOxWwy41FSlT3RJrQZfw5rAzYA8/TvUWlelNu1EgYIVz7P6hxoITaREN2+LVO4CXnJjtBZdipM2XjHoILPARMO/N96j2ZtDGuEiFVqqiDB+1hSJKol9PAnI5O/kOZ0B2ln3T2WOiF/N3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861443; c=relaxed/simple;
	bh=MD21gr1pgcIMWXHaCJV480KvwOiiueatQdLrRHxxvMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+zuOv9jkTkMKC5idfBTM7L0Ewwt5HasB6FPZ242vGHdpPRhz1GZtkHv2LiS8Y/uV0t9uUD1E3YFFyWn4WKXUgTU8unWWqlnzK7KdG2bhhgJ9YWardjPC8GQl7j6cVf80VZMOv/7G95bsbDLXB8Scq5a5tuTeFvWliq1flcVHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0f7NL+i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706861440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KUBTSSnCMRH6RPlY32VRu5gXb8g/6xAYOWnkQ3qaCZ8=;
	b=H0f7NL+if2Z/wWDkt57s8+U/fVXpCl0OFUcmTfHYXpnbPmNtBr79AD9plCokqzeqg3Q27X
	4V3iOYo8WLCfMT7ZNqzSouR7tY8/IcGpFUrfQndBFUAIevkOTGdJzOnTGN41FCuZmEcKvS
	uo8rygcCDMewqh02OTejfAdw93xtCoQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-XOImpI0tNd2Xi7e2dHIDLA-1; Fri, 02 Feb 2024 03:10:37 -0500
X-MC-Unique: XOImpI0tNd2Xi7e2dHIDLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1E5A8352A2;
	Fri,  2 Feb 2024 08:10:36 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 38CD0C2590D;
	Fri,  2 Feb 2024 08:10:34 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH v2 0/5] sched/fair: Defer CFS throttle to user entry
Date: Fri,  2 Feb 2024 09:09:15 +0100
Message-ID: <20240202080920.3337862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi folks,

Problem statement
=================

CFS tasks can end up throttled while holding locks that other, non-throttled
tasks are blocking on.

For !PREEMPT_RT, this can be a source of latency due to the throttling causing a
resource acquisition denial.

For PREEMPT_RT, this is worse and can lead to a deadlock:
o A CFS task p0 gets throttled while holding read_lock(&lock)
o A task p1 blocks on write_lock(&lock), making further readers enter the
  slowpath
o A ktimers or ksoftirqd task blocks on read_lock(&lock)

If the cfs_bandwidth.period_timer to replenish p0's runtime is enqueued on
the same CPU as one where ktimers/ksoftirqd is blocked on read_lock(&lock),
this creates a circular dependency.

This has been observed to happen with:
o fs/eventpoll.c::ep->lock
o net/netlink/af_netlink.c::nl_table_lock (after hand-fixing the above)
but can trigger with any rwlock that can be acquired in both process and
softirq contexts.

The linux-rt tree has had
  1ea50f9636f0 ("softirq: Use a dedicated thread for timer wakeups.")
which helped this scenario for non-rwlock locks by ensuring the throttled
task would get PI'd to FIFO1 (ktimers' default priority). Unfortunately,
rwlocks cannot sanely do PI as they allow multiple readers.

Proposed approach
=================

Peter mentioned [1] that there have been discussions on changing /when/ the
throttling happens: rather than have it be done immediately upon updating
the runtime statistics and realizing the cfs_rq has depleted its quota, we wait
for the task to be about to return to userspace: if it's in userspace, it can't
hold any in-kernel lock.

I submitted an initial jab at this [2] and Ben Segall added his own version to
the conversation [3]. This series contains Ben's patch plus my additions. The
main change here is updating the .h_nr_running counts throughout the cfs_rq
hierachies to improve the picture given to load_balance().

The main thing that remains doing for this series is making the second cfs_rq
tree an actual RB tree (it's just a plain list ATM).

This also doesn't touch rq.nr_running yet, I'm not entirely sure whether we want
to expose this outside of CFS, but it is another field that's used by load balance.

Testing
=======

Tested on QEMU via:

  mount -t cgroup -o cpu none /root/cpu

  mkdir /root/cpu/cg0
  echo 10000 >  /root/cpu/cg0/cpu.cfs_period_us
  echo 1000 > /root/cpu/cg0/cpu.cfs_quota_us

  mkdir /root/cpu/cg0/cg00
  mkdir /root/cpu/cg0/cg01

  mkdir /root/cpu/cg0/cg00/cg000
  mkdir /root/cpu/cg0/cg00/cg001

  spawn() {
      while true; do cat /sys/devices/system/cpu/smt/active &>/dev/null; done &
      PID=$!
      echo "Starting PID${PID}"
      echo $PID > $1
  }

  spawn cpu/cg0/tasks
  spawn cpu/cg0/tasks
  spawn cpu/cg0/tasks
  spawn cpu/cg0/tasks

  spawn cpu/cg0/cg01/tasks

  spawn cpu/cg0/cg00/cg000/tasks
  spawn cpu/cg0/cg00/cg001/tasks

  sleep 120

  kill $(jobs -p)  

Links
=====
  
[1]: https://lore.kernel.org/all/20231031160120.GE15024@noisy.programming.kicks-ass.net/
[2]: http://lore.kernel.org/r/20231130161245.3894682-1-vschneid@redhat.com
[3]: http://lore.kernel.org/r/xm26edfxpock.fsf@bsegall-linux.svl.corp.google.com

Benjamin Segall (1):
  sched/fair: Only throttle CFS tasks on return to userspace

Valentin Schneider (4):
  sched: Note schedule() invocations at return-to-user with SM_USER
  sched/fair: Delete cfs_rq_throttled_loose(), use
    cfs_rq->throttle_pending instead
  sched/fair: Track count of tasks running in userspace
  sched/fair: Assert user/kernel/total nr invariants

 include/linux/sched.h |   7 +
 kernel/entry/common.c |   2 +-
 kernel/entry/kvm.c    |   2 +-
 kernel/sched/core.c   |  45 ++++-
 kernel/sched/debug.c  |  28 +++
 kernel/sched/fair.c   | 399 ++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  |   5 +
 7 files changed, 466 insertions(+), 22 deletions(-)

--
2.43.0


