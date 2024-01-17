Return-Path: <linux-kernel+bounces-28672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266F38301AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B960D1F26615
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F541DA4F;
	Wed, 17 Jan 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMSwTiSE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815BC1DA35
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481753; cv=none; b=Xf4ygtRxRRuCzCKz+AzGGpyt/Ty74iejZ1T0v5EFlI13sW9G9DzoOikD059vEca6neruZFx3RR7PHpyWj3uTtrv3MfEk1YISNpiwwfcOL3de5nVSOsF/neyofNGyip17HMBhiEER6h58XKhHwXpjU257vcgedJPuUQdwZeOfZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481753; c=relaxed/simple;
	bh=ltCPr/DlS2muB/OH0aa1wXxHVPnZQoXrm0LhWbnST9w=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=Olj09pofKJ97o7aJNy0WuIbpZMIfKcZQ+ne97RBTEwEEre+vGhODaznLx+7aWVG0ioMCrtT7ATWjrcyT5KDglSp6k4UwNVU5N0NdqS/YxeW9aO/2SBcfp9lyFAOkL2ApqoV767V2w0sowDudO7sBAIdeK9xEjU0BBnepUXFKAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMSwTiSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4614CC433F1;
	Wed, 17 Jan 2024 08:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705481753;
	bh=ltCPr/DlS2muB/OH0aa1wXxHVPnZQoXrm0LhWbnST9w=;
	h=From:To:Cc:Subject:Date:From;
	b=vMSwTiSEvzAl1CTb6V949eMaLgh8Mqx/PvR7YhXQmiXztNpNLZv2S9kn75gPDn9ls
	 v9L/XOqAMq6i7DfrLzzpyJ0wB3E2SqonhTNtkzJSkfLfE4ECPZJ+72KMVMRSa2YoJ5
	 CCU4GNeUO3v9tusdhlaBos4Qx9hLW1YSFk/zjvIS5oQTSTjgVb/wA29Syraf4qc2+I
	 cn5aGwqlPJjmwW98hBBBnAF8kjcOYE32KS64dTOeAKnb2MOb45lRRcnKfpKr2syAKI
	 W9ujdwgFhUj4KdqsvyQWAvugWLQmnAbI3DGxqYLotUOCHHdP3A0AkWNQQwJ5yByzQT
	 c+7+JDxWLiEUg==
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
	linux-kernel@vger.kernel.org
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 1/5] sched/fair: add SD_CLUSTER in comments
Date: Wed, 17 Jan 2024 16:57:11 +0800
Message-ID: <20240117085715.2614671-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

The SD_CLUSTER omitted in following TOPOLOGY_SD_FLAGS explaination, add
it to fill the absent.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..c342c52b1f34 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
  * function:
  *
  *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
+ *   SD_CLUSTER		    - describes Cluster topologies
  *   SD_SHARE_PKG_RESOURCES - describes shared caches
  *   SD_NUMA                - describes NUMA topologies
  *
-- 
2.43.0


