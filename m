Return-Path: <linux-kernel+bounces-163385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75D8B6A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C466AB22315
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD501179BE;
	Tue, 30 Apr 2024 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m35tfVAE"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860A2F2B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457186; cv=none; b=Fe7pOrSlqhhoKzdok/YT8NcgQ1lofpmrAxqD5NQXSh1vT8+3ogxFV+TJHUk3h3wWQCM6ZnZdMlAJ2UL+IHeN5+dlpCsSrtjoGxSukJcMWD761S5hBY083lhGcI/hC/LCJNDz6RdLO3CTaRafYIzJrMb3EmhPqCduqrpuUPANU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457186; c=relaxed/simple;
	bh=n/R8IpJB3FeRMW4e+6liO7Ln35uKGLJqrIK6tK5jH9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAY6RgLo5ILv8J299pmfw7jvU7vbaxhVQ4Hso09UX8FAw04e07pK1S9NZeYKyhiql8FlPnIeMPgI0MH/JaIe4A+vx46lGmVHlHtLavhlS5hv+nW7efZbYuR4mzOt44YByMmbdGdYf/pxKZ6GcTLHrPLLWrpnDbD1UpbU5nRJAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m35tfVAE; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714457181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PXNo4uDkvXkGowWyfavQ/wvT4lCKFMctusOOMGZYPL4=;
	b=m35tfVAE4Y0Uh5X9Q0T/7eI9OEwXIlToUjoo3IBcXMIkxE3yPu/M+V8skCMNcqs6iYCxEp
	0BmG/cM3LDSnVSL5TJXLj0XVVgYDmXKj1NVjT9DGumiEowCHm1RpRAWuMDWohGcG8Ga1xt
	8bJtEsJrWTU89Y6mKsUuaGo8/IGKckM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	"T . J . Mercier" <tjmercier@google.com>
Cc: kernel-team@meta.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] memcg: reduce memory consumption by memcg stats
Date: Mon, 29 Apr 2024 23:06:04 -0700
Message-ID: <20240430060612.2171650-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Most of the memory overhead of a memcg object is due to memcg stats
maintained by the kernel. Since stats updates happen in performance
critical codepaths, the stats are maintained per-cpu and numa specific
stats are maintained per-node * per-cpu. This drastically increase the
overhead on large machines i.e. large of CPUs and multiple numa nodes.
This patch series tries to reduce the overhead by at least not
allocating the memory for stats which are not memcg specific.

Changelog since v2:
Using WARN_ONCE() instead of pr_warn_once() and some changes commit log
changes. Also included a patch from Roman.

Changelog since v1:
The main change from the v1 is the indirection approach used in this
patchset instead of rearranging the members of node_stat_item.


Roman Gushchin (1):
  mm: memcg: account memory used for memcg vmstats and lruvec stats

Shakeel Butt (7):
  memcg: reduce memory size of mem_cgroup_events_index
  memcg: dynamically allocate lruvec_stats
  memcg: reduce memory for the lruvec and memcg stats
  memcg: cleanup __mod_memcg_lruvec_state
  mm: cleanup WORKINGSET_NODES in workingset
  memcg: warn for unexpected events and stats
  memcg: use proper type for mod_memcg_state

 include/linux/memcontrol.h |  75 ++----------
 mm/memcontrol.c            | 244 +++++++++++++++++++++++++++++++------
 mm/workingset.c            |   7 +-
 3 files changed, 222 insertions(+), 104 deletions(-)

-- 
2.43.0


