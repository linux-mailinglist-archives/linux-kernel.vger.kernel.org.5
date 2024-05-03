Return-Path: <linux-kernel+bounces-168168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F178BB4AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8AEB23EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C6158A1B;
	Fri,  3 May 2024 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Stl6nC4P"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628C1EEFC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767537; cv=none; b=WfGtnaaK9g2WRRTUOFGFEwDbmVwKADkb/ZDjTcnzzwWV+LUdKp2JNFDPzRIpmcsTzmOWcOlI3ZRmM606UE5TLRSyJxUALSAF2j92zjdvjMrCBweINHkxy+skRlDxDQU4gMLNtunWUYT9bXdgZG3GMNziNALpGqI9DntS8NdUSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767537; c=relaxed/simple;
	bh=yPsEkE9UBURZMaSpqjXYyhSUcV9YQkoQwODCLagkODU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T39G1vhzfk+HO/DzHYntocuCi4LkF+Xo2gvkj5efhIZu1P9a3eeHoL9S0iYPdloNyuvChqV6LJKCWDbpcdtoiG6gZswqnUz62M6D64vO0JMPOcTWu3K5YPIQQ0yMgFWTAoqApm+XC7xFtZMlpgVY03b+fO4PWjNaP1XcOPglZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Stl6nC4P; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714767533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=whyY/54/aEMpx5QqbHo4KZGYlopTSjkO3yuzR2BqPnE=;
	b=Stl6nC4P9JH81jEBtgJ1Uvd5DPebTaJnXE7rBafCY38mdOljymNTKUjrmUxa4tp58PccsH
	MR66i0b4iWBhMDLzs8Zx9xx7+s8xepnYaXcBE6JCXODevtgXP17pViEliibT0R6q8gCbh3
	36ik/R6520s/hx1dDplKeb8282QNg1M=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Frank van der Linden <fvdl@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@getcruise.com>
Subject: [PATCH v1 0/4] Page counters optimizations
Date: Fri,  3 May 2024 13:18:31 -0700
Message-ID: <20240503201835.2969707-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Roman Gushchin <roman.gushchin@getcruise.com>

This patchset reorganizes page_counter structures which helps to make
memory cgroup and hugetlb cgroup structures smaller (20%-35%) and
more cache-effective. It also eliminates useless tracking of protected
memory usage when it's not needed.

include/linux/hugetlb.h        |   4 +-
 include/linux/hugetlb_cgroup.h |   9 +---
 include/linux/memcontrol.h     |  15 ++----
 include/linux/page_counter.h   |  88 +++++++++++++++++++++++++-------
 mm/hugetlb.c                   |  14 +++--
 mm/hugetlb_cgroup.c            | 150 ++++++++++++++++++++----------------------------------
 mm/memcontrol.c                | 351 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------
 mm/page_counter.c              |  76 ++++++++++++++++++----------
 8 files changed, 340 insertions(+), 367 deletions(-)


Roman Gushchin (4):
  mm: memcg: convert enum res_type to mem_counter_type
  mm: memcg: merge multiple page_counters into a single structure
  mm: memcg: don't call propagate_protected_usage() needlessly
  mm: page_counters: initialize usage using ATOMIC_LONG_INIT() macro

 include/linux/hugetlb.h        |   4 +-
 include/linux/hugetlb_cgroup.h |   9 +-
 include/linux/memcontrol.h     |  15 +-
 include/linux/page_counter.h   |  88 +++++++--
 mm/hugetlb.c                   |  14 +-
 mm/hugetlb_cgroup.c            | 150 +++++---------
 mm/memcontrol.c                | 351 ++++++++++++++-------------------
 mm/page_counter.c              |  76 ++++---
 8 files changed, 340 insertions(+), 367 deletions(-)

-- 
2.43.2


