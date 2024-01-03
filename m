Return-Path: <linux-kernel+bounces-15543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92335822DE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DBC1F243DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCE119BBF;
	Wed,  3 Jan 2024 12:57:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADDA199A9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC06214BF;
	Wed,  3 Jan 2024 04:57:43 -0800 (PST)
Received: from e126645.nice.arm.com (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B88B3F64C;
	Wed,  3 Jan 2024 04:56:55 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 1/2] sched/topology: Annotate RCU pointers properly
Date: Wed,  3 Jan 2024 13:56:47 +0100
Message-Id: <20240103125648.194516-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103125648.194516-1-pierre.gondois@arm.com>
References: <20240103125648.194516-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup RCU-related spare errors by annotating RCU pointers.

sched_domains_numa_distance:
  error: incompatible types in comparison expression
  (different address spaces):
      int [noderef] __rcu *
      int *

sched_domains_numa_masks:
  error: incompatible types in comparison expression
  (different address spaces):
      struct cpumask **[noderef] __rcu *
      struct cpumask ***

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..0342a4f41f09 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1542,8 +1542,8 @@ static int			sched_domains_numa_levels;
 static int			sched_domains_curr_level;
 
 int				sched_max_numa_distance;
-static int			*sched_domains_numa_distance;
-static struct cpumask		***sched_domains_numa_masks;
+static int			__rcu *sched_domains_numa_distance;
+static struct cpumask		** __rcu *sched_domains_numa_masks;
 #endif
 
 /*
-- 
2.25.1


