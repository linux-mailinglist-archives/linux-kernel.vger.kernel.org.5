Return-Path: <linux-kernel+bounces-165642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4469C8B8EFF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF86282FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB431B27D;
	Wed,  1 May 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JyE8xHLG"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2853718C08
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584389; cv=none; b=VPHQ3PTaBYHfzf84qQvLExzJFgRWq2UvZ6qc2K56C5hkOLVAhdj0Yeva3W3nqfDl+OFzsbxYjVA6Dt/vwOmDIVYBQT2/aDQWCgSx7CUM6Q9ymGe2gduJJ9IVXXp6iWMyxKF8cTvlU5/kvEz1JSD6v+0QYIPBCXhMIvArAJuz+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584389; c=relaxed/simple;
	bh=vEf49XmcjqN67G4RpIYKjBMMrAp1+oPBWXfTCquUPVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mSYvGKsYylw36/IRL9a25fPBSL09QMhshSyfOoNKg/wLnQGi2HZSqVha13TQ+G2OtJ2C09hXRM01fmnicjks2eOBWx6IMM7x+fPwY2phuDlsNDnhTSDjOP/7Lu5a0GtM7QbxYg8xEGE+o0ASoX/hqOVHfwx9FZsnwl6lpInagl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JyE8xHLG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714584384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3H2isfS8T5ps/+wLdohfpyvRT+Uuu4Hht5kCun0wQ34=;
	b=JyE8xHLGkW5gqwjPybskQtVSStPG8kiLG0DNwI/vpeTbL+/bcRIfHvb+unYcWN9cy1RZcF
	HIIMi3nj1hZfXdL3ZRvdAMZoYmV1LUuszTRbyYgEpC+wsxP/JOC5O/Kn0yYwaA3mxreoz4
	NrXRai342e4YNAp/GUnVgenqHevsAJg=
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
Subject: [PATCH v4 0/8] memcg: reduce memory consumption by memcg stats
Date: Wed,  1 May 2024 10:26:09 -0700
Message-ID: <20240501172617.678560-1-shakeel.butt@linux.dev>
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

Changelog since v3:
Minor changes related to changing macro names and chaning the if
conditions orders.

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


