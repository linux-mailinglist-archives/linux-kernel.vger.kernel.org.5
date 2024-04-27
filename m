Return-Path: <linux-kernel+bounces-160819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D938D8B4348
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF401C22827
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C5628DD5;
	Sat, 27 Apr 2024 00:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vA7Uc4ka"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF4325778
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178265; cv=none; b=UgGzz76o3T+0iydCZyIIDQjTd/PP9qyRHNG4pltnQgbWWHMe7iaW7dw5NkKavopkbF8zLTzrqkeyMKDu8eP/nzDN4Z7G57xtKnRHcEQ067vQ4tHi43fNM961cjsUTT4ITW0Ju6sOARyuze4lMTGeGep0WvX+FstTMa2dhVPZZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178265; c=relaxed/simple;
	bh=rj1GLtQS6DQwxX9KbDMMu1V4mPtoT6FkkGxBrZEknzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSD3gsIzI9oDLmJm+dl5CoM67yc4FhMykdOKgs4lZwj4+tGg8i2rSPQaTlb0q++zchAHR6q586snglLBDeEeHRtzvOFGFexLc603aZnMfsXTmvUVIMUyoobZcfOrTN7MljzB8CatSFpmJIJcN6MrY84PqJCqwsEt5GmI5l1dQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vA7Uc4ka; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714178261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WYNfEx046+Zg1e0ZE5FIHgcHeAK6n8iKSeECtiaoy+Y=;
	b=vA7Uc4kaEXk9cYZ+SWIllP0RBW+mMmq3NAYFFagkEPY87n1OK/eBY/5h9xW4/AgF51AaoL
	q41t1JNMl6wMgbfsY9LQtM8+pqXdiURuIL/wpLHTrX1/8v6eI6TMMjo42G9mP4lwitWQB0
	R3b0v0CiiLLNFbp8ecY+uvP3fm4kcqw=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] memcg: reduce memory consumption by memcg stats
Date: Fri, 26 Apr 2024 17:37:26 -0700
Message-ID: <20240427003733.3898961-1-shakeel.butt@linux.dev>
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

The main change from the v1 is the indirection approach used in this
patchset instead of rearranging the members of node_stat_item.

Shakeel Butt (7):
  memcg: reduce memory size of mem_cgroup_events_index
  memcg: dynamically allocate lruvec_stats
  memcg: reduce memory for the lruvec and memcg stats
  memcg: cleanup __mod_memcg_lruvec_state
  memcg: pr_warn_once for unexpected events and stats
  memcg: use proper type for mod_memcg_state
  mm: cleanup WORKINGSET_NODES in workingset

 include/linux/memcontrol.h |  75 ++----------
 mm/memcontrol.c            | 245 ++++++++++++++++++++++++++++++++-----
 mm/workingset.c            |   7 +-
 3 files changed, 230 insertions(+), 97 deletions(-)

-- 
2.43.0


