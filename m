Return-Path: <linux-kernel+bounces-96907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5852E8762FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B61A1C20FA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386755E54;
	Fri,  8 Mar 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBO9b0KF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883D55C24
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896715; cv=none; b=ngRUMPDpvXTUuja8dImMJmytp5gdrnU1y32VjG1n2aGTyP6wjzpSt2An7y4X8tadXh/N0huK1L3rISUV/ebD4NFEDNkYZ2/Np1/KcLu3kTAGryW3FY8kAijHP2T3aYb8sijWJT51ffShdAcJhCgoPqB+NL8ty0vqFRo4eG9js9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896715; c=relaxed/simple;
	bh=OAByMeNmAAk1FNUXO+6Y0/uzfVRlSKlYfmwyB+My6c8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJpf+AL5qoNPqnuiA8vsIizMTh0T4PJG0MD+RvwVmbA1BL2yfRVtHazDDQJYbcFAL+LJ4OnBYtng9pFVve2Tu4vO7YH2iPUq7untu0WjY03KIOvW2mmZexBwbdITC+F4LxAJNj/1lYKcrjmd6ZfVBFwBE5ADv8shdh86Up/EKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBO9b0KF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4131b2ff302so1941885e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896712; x=1710501512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WrNScsUIjA5oh3ZPkz3z13Rt1r9Cr+cV8QTumSnjtug=;
        b=cBO9b0KF1mCgGpuOcEclq7rbOi8sKgzRmyqOGNEqf8JSwlDcXJFE5fK7iVLD9U3wFl
         nrSEC0wa9VlLFsrrCzwL2nVMKEbWnpQ5CXbjuXuQ2+n5CXN6N15HWO2ep3jUIzupztEy
         +WVjCIeDhEUAeYYw4Zm28DogPjeZ0GmQlD5oanoRAI+NGGH2fgo7vXC1hhiXWLLE9jlY
         6GUm3IMkUpENVJL8OWR4TM0q5mNE2tODpd/P3D+tVE+n8VSiD+zk1rc4HGXolqn1X6eD
         qKM45LMtEaVIa+Hx5A0fVMb1yCiCHeKgur6W7VBLMj14CJ9NtION6nT6REltMDSw3CRv
         +Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896712; x=1710501512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrNScsUIjA5oh3ZPkz3z13Rt1r9Cr+cV8QTumSnjtug=;
        b=U/eBQKMt0ih8UPXPX8TMYYj5RIyX+u0+kxwR3V7GYaktp2sq7MPBJFudDofn0hqowZ
         vCKqYB4B66Ur0tGodEUSXzjMvd6TaSDa/SnOJXFyt2MzdjDOG722ncbv20UXtAr/c1Br
         G1x833wizkC4W+gpYb7YLd6cDx1IvaRCjlPaW0svalUYhnZs+btc/OPzD/XzNm3cHiAs
         tEBqKXTZ0ubzU+Q1HGctr5EmQAa0B0k+7a9oaS+Czqo4ovuKGHV+V9NyY/bc6pCIVJbp
         nFkprMX+SpsqbAHwN/B4YWgbxidko/jB3vF2FwjfcGagvz5R0SszeLa28y4P9mCf0kvM
         mThw==
X-Gm-Message-State: AOJu0YwGO1dcG9yZQiktn96tmYCcY/JUuipF79gsIfbqzwCAfzgi/3lE
	izF5hncDz9fetMVJXwBoqXVDewmIO5ZQmt6auMCwtb4WscdrnXa2gJcWlOmeahw=
X-Google-Smtp-Source: AGHT+IFzfTiGwms89Sxq46tRz984wFB+udknwyuh3fb/IGN843PF6GJtFGPgD7B3jnmNI3DeEwRo/g==
X-Received: by 2002:a5d:6249:0:b0:33e:1e0:2679 with SMTP id m9-20020a5d6249000000b0033e01e02679mr14624621wrv.47.1709896711591;
        Fri, 08 Mar 2024 03:18:31 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:30 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH -v1 00/13] sched/balancing: Standardize the naming of scheduler load-balancing functions
Date: Fri,  8 Mar 2024 12:18:06 +0100
Message-Id: <20240308111819.1101550-1-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Over the years we've grown a colorful zoo of scheduler
load-balancing function names - both following random,
idiosyncratic patterns, and gaining historic misnomers
that are not accurate anymore.

We have 'newidle_balance()' to rebalance newly idle tasks,
but 'balance_domains()' to rebalance domains. We have
a find_idlest_cpu() function whose purpose is not to find
the idlest CPU anymore, and a find_busiest_queue() function
whose purpose is not to find the busiest runqueue anymore.

Fix most of the misnomers and organize the functions along the
sched_balance_*() namespace:

  scheduler_tick()		=> sched_tick()
  run_rebalance_domains()	=> sched_balance_softirq()
  trigger_load_balance()	=> sched_balance_trigger()
  rebalance_domains()		=> sched_balance_domains()
  load_balance()		=> sched_balance_rq()
  newidle_balance()		=> sched_balance_newidle()
  find_busiest_queue()		=> sched_balance_find_src_rq()
  find_busiest_group()		=> sched_balance_find_src_group()
  find_idlest_group_cpu()	=> sched_balance_find_dst_group_cpu()
  find_idlest_group()		=> sched_balance_find_dst_group()
  find_idlest_cpu()		=> sched_balance_find_dst_cpu()
  update_blocked_averages()	=> sched_balance_update_blocked_averages()

I think the visual improvement of left vs. right column
demonstrates the goal nicely.

While the function names got a bit longer, another advantage of
the common prefix, beyond readability, is that now a:

  git grep sched_balance_

.. will show most of the balancing code nicely.

( I have a few more patches that standardize the NOHZ balancing
  code along the nohz_balance_*() nomenclature as well. )

Thanks,

    Ingo

==================>
Ingo Molnar (13):
  sched/balancing: Rename run_rebalance_domains() => sched_balance_softirq()
  sched/balancing: Rename scheduler_tick() => sched_tick()
  sched/balancing: Rename trigger_load_balance() => sched_balance_trigger()
  sched/balancing: Rename rebalance_domains() => sched_balance_domains()
  sched/balancing: Rename load_balance() => sched_balance_rq()
  sched/balancing: Rename find_busiest_queue() => find_src_rq()
  sched/balancing: Rename find_src_rq() => sched_balance_find_src_rq()
  sched/balancing: Rename find_busiest_group() => sched_balance_find_src_group()
  sched/balancing: Rename update_blocked_averages() => sched_balance_update_blocked_averages()
  sched/balancing: Rename newidle_balance() => sched_balance_newidle()
  sched/balancing: Rename find_idlest_group_cpu() => sched_balance_find_dst_group_cpu()
  sched/balancing: Rename find_idlest_group() => sched_balance_find_dst_group()
  sched/balancing: Rename find_idlest_cpu() => sched_balance_find_dst_cpu()

 Documentation/scheduler/sched-domains.rst                       | 12 ++--
 Documentation/scheduler/sched-stats.rst                         | 32 +++++------
 Documentation/translations/zh_CN/scheduler/sched-domains.rst    | 10 ++--
 Documentation/translations/zh_CN/scheduler/sched-stats.rst      | 30 +++++-----
 arch/arm/kernel/topology.c                                      |  2 +-
 include/linux/sched.h                                           |  2 +-
 include/linux/sched/topology.h                                  |  2 +-
 kernel/sched/core.c                                             |  6 +-
 kernel/sched/fair.c                                             | 88 ++++++++++++++---------------
 kernel/sched/loadavg.c                                          |  2 +-
 kernel/sched/pelt.c                                             |  2 +-
 kernel/sched/sched.h                                            |  4 +-
 kernel/time/timer.c                                             |  2 +-
 kernel/workqueue.c                                              |  2 +-
 .../selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc      |  2 +-
 15 files changed, 99 insertions(+), 99 deletions(-)

-- 
2.40.1


