Return-Path: <linux-kernel+bounces-55905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C05984C33D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB39287FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F48F134A4;
	Wed,  7 Feb 2024 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lczDQgnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554B12E74
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277450; cv=none; b=DHc1T0fK7sLWmJsFcYHpOBV2MIyGK9WlNymvOEUFcI5LZiq38CU/6zyAcU3V/6UmuY7x2YeaXFDsD3jGKDx3vFvu9JANSdVquKbLmVAdnw2atjmy8uA+dtgogN7NsI1LYH1OFJpvfl1bvGz/imyyDPyBlngxh+w4ddhDR+G/FLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277450; c=relaxed/simple;
	bh=7vUiNV5G3nvvwfoetaYLt/ii5ihVPI2ja1/aLjEI590=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qscFHHmNAiJYDHZJuwlcOZ9/OqzWfoampphDLhvL73eVTOt/ipFlF/urBdT8DbWPmjqZfe97RNDVXBn+ZwDC4NPvAzpzhCDlrw2NFIrhyrnwW2KEXJaRWcLvuNJ8cQ3l0AoB6W9uBRjOkG/yyjmfPjaTJQjqHXyl593/r+dhDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lczDQgnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B701C433C7;
	Wed,  7 Feb 2024 03:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707277450;
	bh=7vUiNV5G3nvvwfoetaYLt/ii5ihVPI2ja1/aLjEI590=;
	h=From:To:Cc:Subject:Date:From;
	b=lczDQgnfgJOCY4MK/ePzFHE6JOGKVK8GTmB6IaxhfwXYjnpCndTNp392dkhjX8MaK
	 TddRliBpzoeVAdGAUV4lEhA0WsAgm6z1stDQWyrY3JgjK9aEmpomLCi9zOToOsBuGo
	 ygqCFnhLcXEG4V8YR7+ScGCyPzCtfz7Sprl9026ckxNUagfUv0aW5hj5HvJrDzvjEM
	 9bQMEJN7Zl5thJCqnPvCtyxGS43vu30Ue4JKOtyJgnkWtOlSfQ5swhfesApv80T/VO
	 5V3T7k58nNF7Eqc5II3Ka/UIq2lEND0ZdEaIrlgAXr6689pIN7UX4chlgGeswf3tfT
	 Nkj+2BSao0WoA==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	ricardo.neri-calderon@linux.intel.com,
	yangyicong@hisilicon.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v4 1/4] sched/topology: Remove duplicate descriptions from TOPOLOGY_SD_FLAGS
Date: Wed,  7 Feb 2024 11:47:01 +0800
Message-ID: <20240207034704.935774-1-alexs@kernel.org>
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
Also add missing SD_CLUSTER and keep the comment on SD_ASYM_PACKING
as it is a special case.

Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
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


