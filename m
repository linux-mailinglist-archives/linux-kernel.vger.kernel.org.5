Return-Path: <linux-kernel+bounces-60378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95A85043B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C51F22E28
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8915D3CF57;
	Sat, 10 Feb 2024 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLaly24H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7543AC01
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707564982; cv=none; b=NO4HmhsB8Yajiu74n+TGDjD25v3eqeoCQbILyJjD8Y/UQA4Xtg8Fh1NV8hhYBL7D7pUe09fVqrHhZeeYihZj8vETJ0AxfMj6KiY9ZNHAs53JpqHUl6Z3KypYwnkZhlAXM9KtEvBNPnPGgDeBvK1fhf5k3L6Wp9mzAqyitpERzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707564982; c=relaxed/simple;
	bh=mofvx/4Gu5lY6rezEW+q6OTCAd/T7sEH3BGxSJ30Meg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aG9q3HvZxpDMf6GAwi7aw3Ntf5HZtzxyplIcALYFfBsD0dMXMZ89Em7hSJsdQK7J7j5APwNe+a5KYcTaTE/eiNqIP/gnsX1RuGsDEkedQf+awtjiC1zkFE0UQg5hVpCWrVdghnGONJzEH9qjBjc59wkgYY9BFuiuijvxjiknYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLaly24H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641BDC433C7;
	Sat, 10 Feb 2024 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707564982;
	bh=mofvx/4Gu5lY6rezEW+q6OTCAd/T7sEH3BGxSJ30Meg=;
	h=From:To:Cc:Subject:Date:From;
	b=eLaly24HIsgzoTZ/SX6JRFlF4EusLbDp9ivgIHzCcbK8b02h03T/I7yvYhGw+UZg9
	 vjM3VGwFKd/yGWA9vBmdDdaH7lFBWHrBRicIi4DgZoPuGtvTRhJOFmhVS9LRfJcTNI
	 KWqmn0844+4aenw8yz3xh3Ir0/57DQLURgX4CfE9Bdc+06jKcnJL2QVujb2WfuRV9N
	 l5QByd3tMoFnOcYwOQgtwhWOtffyxg/IMKFdunAo1GbrADy2rqdlBkQxncAlt2rvpT
	 nm9ZHBTjROq9sFO0NudnSJkOUZQ1jnrIxRgfNeXe5MsrY7kyMUy4L8tjaVoLBHq5xO
	 lq5DHK65LxNXQ==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: Alex Shi <alexs@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v5 1/5] sched/topology: Remove duplicate descriptions from TOPOLOGY_SD_FLAGS
Date: Sat, 10 Feb 2024 19:39:19 +0800
Message-ID: <20240210113924.1130448-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

These flags are already documented in include/linux/sched/sd_flags.h.
Also, add missing SD_CLUSTER and keep the comment on SD_ASYM_PACKING
as it is a special case.

Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/topology.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..0b33f7b05d21 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1551,11 +1551,12 @@ static struct cpumask		***sched_domains_numa_masks;
  *
  * These flags are purely descriptive of the topology and do not prescribe
  * behaviour. Behaviour is artificial and mapped in the below sd_init()
- * function:
+ * function. For details, see include/linux/sched/sd_flags.h.
  *
- *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
- *   SD_SHARE_PKG_RESOURCES - describes shared caches
- *   SD_NUMA                - describes NUMA topologies
+ *   SD_SHARE_CPUCAPACITY
+ *   SD_SHARE_PKG_RESOURCES
+ *   SD_CLUSTER
+ *   SD_NUMA
  *
  * Odd one out, which beside describing the topology has a quirk also
  * prescribes the desired behaviour that goes along with it:
-- 
2.43.0


