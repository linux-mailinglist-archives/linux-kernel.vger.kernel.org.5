Return-Path: <linux-kernel+bounces-38997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A08F83C986
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC0128FAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF05B136666;
	Thu, 25 Jan 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSNBgbcc"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1F136656
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202393; cv=none; b=Zx8cZj5x14ZmkgQgAepgA8SuP/ALrr0ih1j7+xmz7fCeBFGfCFxviU/SIjA7YMuNtsbHOY75fxiDd7I26R2eYJ5lAnMDNl0oL9LPPEhg5VQpMR39ULU9OG68e9YqeWiFn6m8K1qiEOfl4G9WxB3bDoqKVbMogp7yLWvCmDjJF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202393; c=relaxed/simple;
	bh=xVyULNb3Cfb0rdlY8TVGBBsJ1jh041nclrY15zOIcO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VH+0PcPs2SGvh/BBh26wcdeOEmqLsFyHQAzB9kUKwibUp4elpupZw8y7FoGgKjyi3Tv5elIxcUrIS6fbBuEPduv7d6AwzpetDlelMJQ6sDFsdbMu2wXOf3MLXGKH/tLcvvfTS1WVf/7nDUtVjtOZhoqh1JBYMMpjT8ELytBdplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSNBgbcc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d731314e67so27931505ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202391; x=1706807191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7ULhUvShPSc1BpxVQbOKodunqA+7MWslDMB998tXaIg=;
        b=VSNBgbccVWu1ZZ9fqjoh+UloDO/xfznN0vdJGsTtZI3zIVZJJixFhUusHslYBSMuzL
         6TnmRqjrThwMSnhtgsVyy3aSdQ0fUmPsd6ZwUfmJk2LWQTVDZb7hh91c4Q4YpZDaARlA
         oHFzGSrExPPkiLbNrZ76Jk+ebZOsxtCCVhnSvbaYJUu3zmiHkH7qK1VjmuIDHsw5xrdV
         SX9/UvQOw7uk/jay3vApvwjA6NetYEIzovnZH7uxjOMhbJFpwee5U209QpzqFpp7jqsQ
         erDVSw/+s4CidSHxOdVzQBc3t7Fwx1xbU/cdtN9BrVuq3+llTc4UwScfrx1HZ9JBUY9H
         +fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202391; x=1706807191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ULhUvShPSc1BpxVQbOKodunqA+7MWslDMB998tXaIg=;
        b=FOh76TeEXKLOQPZEyVp5c0ha25Ar0zqF9sTo7i7qxNcka50PCyg3qtDppvb+AX7d14
         YZY246C0PXjifACMgdFTOZI7zWBxQooAi1XarMpRR3B4NGr5OU5EZ1K18azaYd34Q3wo
         xxE0LytmYLTMWk1K2Me5EZmyF1r2mBnEDXWahDWAE+gYzd5B//bGKDUTGtp9OQEJM1YW
         8hRdE0jgcEvZpchRip6KLH+NR2wJGAGtA6jPvUB9vX4HlAy1w2LIOY2VSn6Lx3k/Kms9
         e76oLd/pNOJt3ZUXzsWFj/LI+HBDZfHxLWK2pplH2levNkjxqVoLxEWIeuHpL4lDq9zH
         9/qw==
X-Gm-Message-State: AOJu0YyKG1FV9PulXvra7OtklRFJxLlW4uAgWY1v4WJuh88ywdLjaxiX
	I9OS+P51L+tMWKMJdlWnUixJrvE3JcGZh/RNmjqINpiNCHwzsB81
X-Google-Smtp-Source: AGHT+IEAutta4S0TN7TxJDOd1UH6Dw7V2tx8METRsbTxtsDUIXI6bu9DIaZ2M8RlOA3hY/mgJ+zxhA==
X-Received: by 2002:a17:902:cec1:b0:1d7:5600:659e with SMTP id d1-20020a170902cec100b001d75600659emr1310702plg.33.1706202390557;
        Thu, 25 Jan 2024 09:06:30 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902e90600b001d720956b8esm10409989pld.77.2024.01.25.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:06:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: [PATCHSET v3 wq/for-6.9] workqueue: Implement system-wide max_active for unbound workqueues
Date: Thu, 25 Jan 2024 07:05:53 -1000
Message-ID: <20240125170628.2017784-1-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v3. Changes from v2
(http://lkml.kernel.org/r/20240113002911.406791-1-tj@kernel.org):

- Per-node max_active is now pre-computed and stored in
  wq_node_nr_active->max. It also calculates max_active based on the
  intersection of online CPUs and the workqueue's effective CPUs to
  distribute CPUs fairly on workqueues with a cpumask which is not balanced
  across nodes. (Lai)

- wq_dump.py is updated to print out per-node nr/max_active counters.

- wq->node_nr_active is now a flex array. (Lai)

v1(http://lkml.kernel.org/r/20231220072529.1036099-1-tj@kernel.org) -> v2:

- wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

- __queue_work() is updated to alwyas delay the work item if there already
  are inactive work items on the pwq. This prevents work item reordering
  inside the pwq when max_active is increased thus maintaining execution
  order for ordered workqueues. This issue was noticed by Lai.

- In 0008-workqueue-Introduce-struct-wq_node_nr_active.patch, Lai pointed
  out that pwq_tryinc_nr_active() incorrectly dropped pwq->max_active check.
  Restored. As the next patch replaces the max_active enforcement mechanism,
  this doesn't change the end result.

- 0010-workqueue-Reimplement-ordered-workqueue-using-shared.patch was broken
  and could reorder work items in ordered workqueues leading to severe perf
  regressions and hangs with certain workloads. Dropped.

A pool_workqueue (pwq) represents the connection between a workqueue and a
worker_pool. One of the roles that a pwq plays is enforcement of the
max_active concurrency limit. Before 636b927eba5b ("workqueue: Make unbound
workqueues to use per-cpu pool_workqueues"), there was one pwq per each CPU
for per-cpu workqueues and per each NUMA node for unbound workqueues, which
was a natural result of per-cpu workqueues being served by per-cpu pools and
unbound by per-NUMA pools.

In terms of max_active enforcement, this was, while not perfect, workable.
For per-cpu workqueues, it was fine. For unbound, it wasn't great in that
NUMA machines would get max_active that's multiplied by the number of nodes
but didn't cause huge problems because NUMA machines are relatively rare and
the node count is usually pretty low.

However, cache layouts are more complex now and sharing a worker pool across
a whole node didn't really work well for unbound workqueues. Thus, a series
of commits culminating on 8639ecebc9b1 ("workqueue: Make unbound workqueues
to use per-cpu pool_workqueues") implemented more flexible affinity
mechanism for unbound workqueues which enables using e.g. last-level-cache
aligned pools. In the process, 636b927eba5b ("workqueue: Make unbound
workqueues to use per-cpu pool_workqueues") made unbound workqueues use
per-cpu pwqs like per-cpu workqueues.

While the change was necessary to enable more flexible affinity scopes, this
came with the side effect of blowing up the effective max_active for unbound
workqueues. Before, the effective max_active for unbound workqueues was
multiplied by the number of nodes. After, by the number of CPUs.

636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu
pool_workqueues") claims that this should generally be okay. It is okay for
users which self-regulates concurrency level which are the vast majority;
however, there are enough use cases which actually depend on max_active to
prevent the level of concurrency from going bonkers including several IO
handling workqueues that can issue a work item for each in-flight IO. With
targeted benchmarks, the misbehavior can easily be exposed as reported in
http://lkml.kernel.org/r/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3.

Unfortunately, there is no way to express what these use cases need using
per-cpu max_active. A CPU may issue most of in-flight IOs, so we don't want
to set max_active too low but as soon as we increase max_active a bit, we
can end up with unreasonable number of in-flight work items when many CPUs
issue IOs at the same time. ie. The acceptable lowest max_active is higher
than the acceptable highest max_active.

Ideally, max_active for an unbound workqueue should be system-wide so that
the users can regulate the total level of concurrency regardless of node and
cache layout. The reasons workqueue hasn't implemented that yet are:

- One max_active enforcement decouples from pool boundaires, chaining
  execution after a work item finishes requires inter-pool operations which
  would require lock dancing, which is nasty.

- Sharing a single nr_active count across the whole system can be pretty
  expensive on NUMA machines.

- Per-pwq enforcement had been more or less okay while we were using
  per-node pools.

It looks like we no longer can avoid decoupling max_active enforcement from
pool boundaries. This patchset implements system-wide nr_active mechanism
with the following design characteristics:

- To avoid sharing a single counter across multiple nodes, the configured
  max_active is split across nodes according to the proportion of online
  CPUs per node. e.g. A node with twice more online CPUs will get twice
  higher portion of max_active.

- Workqueue used to be able to process a chain of interdependent work items
  which is as long as max_active. We can't do this anymore as max_active is
  distributed across the nodes. Instead, a new parameter min_active is
  introduced which determines the minimum level of concurrency within a node
  regardless of how max_active distribution comes out to be.

  It is set to the smaller of max_active and WQ_DFL_MIN_ACTIVE which is 8.
  This can lead to higher effective max_weight than configured and also
  deadlocks if a workqueue was depending on being able to handle chains of
  interdependent work items that are longer than 8.

  I believe these should be fine given that the number of CPUs in each NUMA
  node is usually higher than 8 and work item chain longer than 8 is pretty
  unlikely. However, if these assumptions turn out to be wrong, we'll need
  to add an interface to adjust min_active.

- Each unbound wq has an array of struct wq_node_nr_active which tracks
  per-node nr_active. When its pwq wants to run a work item, it has to
  obtain the matching node's nr_active. If over the node's max_active, the
  pwq is queued on wq_node_nr_active->pending_pwqs. As work items finish,
  the completion path round-robins the pending pwqs activating the first
  inactive work item of each, which involves some pool lock dancing and
  kicking other pools. It's not the simplest code but doesn't look too bad.

This patchset includes the following patches:

 0001-workqueue-Move-pwq-max_active-to-wq-max_active.patch
 0002-workqueue-Factor-out-pwq_is_empty.patch
 0003-workqueue-Replace-pwq_activate_inactive_work-with-__.patch
 0004-workqueue-Move-nr_active-handling-into-helpers.patch
 0005-workqueue-Make-wq_adjust_max_active-round-robin-pwqs.patch
 0006-workqueue-RCU-protect-wq-dfl_pwq-and-implement-acces.patch
 0007-workqueue-Move-pwq_dec_nr_in_flight-to-the-end-of-wo.patch
 0008-workqueue-Introduce-struct-wq_node_nr_active.patch
 0009-workqueue-Implement-system-wide-nr_active-enforcemen.patch
 0010-tools-workqueue-wq_dump.py-Add-node_nr-max_active-du.patch

This pachset is also available in the following git branch.

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git unbound-system-wide-max_active-v3

diffstat follows. Thanks.

 include/linux/workqueue.h  |   35 +++
 kernel/workqueue.c         |  749 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 tools/workqueue/wq_dump.py |   41 +++
 3 files changed, 691 insertions(+), 134 deletions(-)

--
tejun

