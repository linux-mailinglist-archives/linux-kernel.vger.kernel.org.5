Return-Path: <linux-kernel+bounces-163637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E978B6E06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BA41C2203F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8CB128370;
	Tue, 30 Apr 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KytLniRy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C0127E0D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468694; cv=none; b=ectfDMaJXO2zT3AywQXOe5aeWigB89jTZ9/A/AEX+jofr8PXAWtiEHQfsVW+oXtp+dBpYKizHy/4I7Ea2wAt2yAkEKNeKfSmScdd9aCPeShpsNV2wH4AjjbPy0FKfgcGmdopOUXpQv7KLJtZKBa/mAWp43suoGMP4lw5oDuSN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468694; c=relaxed/simple;
	bh=CflsUhdE5gVm4q7Vv027HqevPncCvK68PbZgk0w1H8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/cxDSgsH4YBsvBVXMC93h6oSUwGQeWx39Y1D0AFlXi5q4MWtSawncjCkFpoUazf51rSQSJmHRjWtsTddOsQMx2AiJIKXxtemCC1NEKamPx0G8JzoRtoPShm/jDGuXLRRIH6pfFhV2cipkPUjZ+4+/Ejj3mj9Qzk5QYCfQz+ooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KytLniRy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZyRQlA2vUNkh7XDLdi0016i0jQLRod1uXo1kUv9Rb8c=;
	b=KytLniRyGsY/I3sSu0hO6ZCtKexEUSL+/vm3FepaD4XfQXrupl6pf/zLRttzwC6ImY7ZTP
	2b4PGJS6rIy28/jVUN9RIzcS6LbKsUp5aNiS2zEmqNfIJLhncccXewhzQnSOJPzGZMGcXR
	VoGImsiZRQxUy/N3uX+n+t74aWpFeCE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-WIHwQzuVPCqX5OV6Evrw0w-1; Tue,
 30 Apr 2024 05:18:05 -0400
X-MC-Unique: WIHwQzuVPCqX5OV6Evrw0w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA0763806738;
	Tue, 30 Apr 2024 09:18:04 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AC3840BAA2;
	Tue, 30 Apr 2024 09:18:01 +0000 (UTC)
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
Subject: [PATCH v2 00/27] context_tracking, rcu: Spring cleaning renaming
Date: Tue, 30 Apr 2024 11:17:04 +0200
Message-ID: <20240430091740.1826862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hi folks,

This is v2 of [1], where I've now gone through the rabbit hole of renaming /just
a few/ more things.

I've done one patch per symbol for my own sanity, a lot of these probably
deserve to be squashed together (e.g. all of the nmi_nesting into one).

All patches are pure renaming, with the exception of:
- patch 14/27, which also lifts a negation out of a function and straps it to its
  callsites.
- patch 27/27, which renames a trace event and flips the tracepoint strings passed
  to it  

At the end of the renaming exercise, the remaining RCU references to "dyntick"
are:
- Comments in core RCU code:
  kernel/rcu/:
  tree.c:354:56: * We inform the RCU core by emulating a zero-duration dyntick-idle period.
  tree.c:769:10: * is in dynticks idle mode, which is an extended quiescent state.
  tree.c:784:54: * by virtue of being in or having passed through an dynticks idle state since
  tree.c:799:44:	 * If the CPU passed through or entered a dynticks idle phase with
  tree.c:1983:14:		/* Collect dyntick-idle snapshots. */
  tree.c:1986:13:		/* Handle dyntick-idle and offline CPUs. */
  tree.c:2680:54: * Otherwise, invoke the specified function to check dyntick state for
  tree.c:2740:16: * CPUs are in dyntick-idle mode.
  tree_plugin.h:863:4: * dyntick-idle quiescent state visible to other CPUs, which will in
  tree_nocb.h:55:19: * about entering dyntick-idle mode.
  tree.h:208:8:	/* 3) dynticks interface. */
  tree.h:209:46:	int  watching_snap;		/* Per-GP tracking for dynticks. */
  Kconfig:11:4:	# Dynticks-idle tracking

- Stale documentation in RCU/Design/Data-Structures/Data-Structures.rst
  referencing fields that have been moved out of RCU after
  904e600e60f4 ("rcu/context_tracking: Move dynticks_nesting to context tracking")

The series is based on rcu/next at:
  b93b7b4635f1 ("ftrace: Asynchronous grace period for register_ftrace_direct()")

It's also available as a git tree at:
  https://gitlab.com/vschneid/linux.git -b redhat/isolirq/defer/v3-rcu-v2

Cheers,
Valentin

[1]: https://lore.kernel.org/lkml/20240327112902.1184822-1-vschneid@redhat.com/

Valentin Schneider (27):
  treewide: context_tracking: Rename CONTEXT_* into CT_STATE_*
  context_tracking, rcu: Rename RCU_DYNTICKS_IDX into CT_RCU_WATCHING
  context_tracking, rcu: Rename ct_dynticks() into ct_rcu_watching()
  context_tracking, rcu: Rename ct_dynticks_cpu() into
    ct_rcu_watching_cpu()
  context_tracking, rcu: Rename ct_dynticks_cpu_acquire() into
    ct_rcu_watching_cpu_acquire()
  context_tracking, rcu: Rename struct context_tracking
    .dynticks_nesting into .nesting
  context_tracking, rcu: Rename ct_dynticks_nesting() into ct_nesting()
  context_tracking, rcu: Rename ct_dynticks_nesting_cpu() into
    ct_nesting_cpu()
  context_tracking, rcu: Rename struct context_tracking
    .dynticks_nmi_nesting into .nmi_nesting
  context_tracking, rcu: Rename ct_dynticks_nmi_nesting() into
    ct_nmi_nesting()
  context_tracking, rcu: Rename ct_dynticks_nmi_nesting_cpu() into
    ct_nmi_nesting_cpu()
  context_tracking, rcu: Rename DYNTICK_IRQ_NONIDLE into
    CT_NESTING_IRQ_NONIDLE
  context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*()
  context_tracking, rcu: Rename rcu_dynticks_curr_cpu_in_eqs() into
    rcu_watching_curr_cpu()
  rcu: Rename rcu_dynticks_eqs_online() into rcu_watching_eqs_online()
  rcu: Rename rcu_dynticks_snap() into rcu_watching_snap()
  rcu: Rename rcu_dynticks_in_eqs() into rcu_watching_in_eqs()
  rcu: Rename rcu_dynticks_in_eqs_since() into
    rcu_watching_changed_since()
  rcu: Rename rcu_dynticks_zero_in_eqs() into rcu_watching_zero_in_eqs()
  rcu: Rename struct rcu_data .dynticks_snap into .watching_snap
  rcu: Rename struct rcu_data .exp_dynticks_snap into .exp_watching_snap
  rcu: Rename dyntick_save_progress_counter() into
    eqs_save_progress_counter()
  rcu: Rename rcu_implicit_dynticks_qs() into rcu_implicit_eqs()
  rcu: Rename rcu_momentary_dyntick_idle() into rcu_momentary_eqs()
  context_tracking, rcu: Rename stray ->dynticks comments
  rcu: Update stray documentation references to rcu_dynticks_eqs_{enter,
    exit}()
  context_tracking, rcu: Rename rcu_dyntick trace event into
    rcu_watching

 .../Data-Structures/Data-Structures.rst       |  28 ++--
 .../Tree-RCU-Memory-Ordering.rst              |   8 +-
 .../Memory-Ordering/TreeRCU-dyntick.svg       |   8 +-
 .../Design/Memory-Ordering/TreeRCU-gp-fqs.svg |   8 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg |   8 +-
 .../Memory-Ordering/TreeRCU-hotplug.svg       |   4 +-
 arch/Kconfig                                  |   2 +-
 arch/arm64/kernel/entry-common.c              |   2 +-
 arch/powerpc/include/asm/interrupt.h          |   6 +-
 arch/powerpc/kernel/interrupt.c               |   6 +-
 arch/powerpc/kernel/syscall.c                 |   2 +-
 arch/x86/entry/common.c                       |   2 +-
 include/linux/context_tracking.h              |  32 +++--
 include/linux/context_tracking_state.h        |  58 ++++----
 include/linux/entry-common.h                  |   2 +-
 include/linux/rcutiny.h                       |   2 +-
 include/linux/rcutree.h                       |   2 +-
 include/trace/events/rcu.h                    |  18 +--
 kernel/context_tracking.c                     | 132 +++++++++---------
 kernel/entry/common.c                         |   2 +-
 kernel/rcu/rcu.h                              |   4 +-
 kernel/rcu/rcutorture.c                       |   4 +-
 kernel/rcu/tasks.h                            |   2 +-
 kernel/rcu/tree.c                             | 104 +++++++-------
 kernel/rcu/tree.h                             |   4 +-
 kernel/rcu/tree_exp.h                         |   8 +-
 kernel/rcu/tree_nocb.h                        |   2 +-
 kernel/rcu/tree_plugin.h                      |   6 +-
 kernel/rcu/tree_stall.h                       |   6 +-
 kernel/sched/core.c                           |   4 +-
 kernel/stop_machine.c                         |   2 +-
 kernel/trace/trace_osnoise.c                  |   4 +-
 32 files changed, 243 insertions(+), 239 deletions(-)

--
2.43.0


