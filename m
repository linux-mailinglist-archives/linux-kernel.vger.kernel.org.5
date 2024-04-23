Return-Path: <linux-kernel+bounces-154527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62358ADD20
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E18B22247
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6852208BC;
	Tue, 23 Apr 2024 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OvsiSo2V"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFA1C2AD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849831; cv=none; b=dKm8osVSCojrfnetg1j4zbZX8gSIifP0YX2LGsgPlKrSXkReHiXmUfr6Yg04NBEVXYq8BWxwSYJf5029KB/9Ivx75BcqJebVA2P7p5yxEzb3WuVFg0q7tp0RsPXwQMo2fMy0oa+x/25UKEeEXsykNAwwAYXKo2Trw2QKH1cH3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849831; c=relaxed/simple;
	bh=99EfjvqpzFog+KcyejWyS1acNRGTXkB7Y1R/IpDMIK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecUBIyRPZawdOFD8l3jNdqX0kzi6e+KMNb4B4gfEHtkwRbPdrjemV7yjRY6JZTvIj27GCL/g4lmTH3alE0TGZKJAFcnc3k02zxyRsTFtldXjSb77h4PKrVQj135j7o2J2TetAjB8LIrrra+7uFeFdsy6k8qxxXvjGQCV+3nzCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OvsiSo2V; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713849827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wZMRsMyHQHXjFKrcDnWCD1NMGczgsTlPNC9ZrGXAJ8=;
	b=OvsiSo2VciEz80V+ECLlsVWhu9VrKAZMMiT5JyhaIJpiJCaRlCFNPBSSnIM/oQ0A13NJ6j
	Q0M6ktSc75eUe/FEsbEGO8Xw0LzcxsIBnDqZmgTIXd3X28/O0v+b8GHm92PPzMRnAkJ0U6
	/BuPKk6hpDPgJz/MbeeRSvhhJ5MUOLI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] memcg: restrict __mod_memcg_lruvec_state to memcg stats
Date: Mon, 22 Apr 2024 22:23:43 -0700
Message-ID: <20240423052343.811563-1-shakeel.butt@linux.dev>
In-Reply-To: <20240423051826.791934-1-shakeel.butt@linux.dev>
References: <20240423051826.791934-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently __mod_memcg_lruvec_state takes enum node_stat_item as a
parameter and enum node_stat_item contains both memcg and non-memcg
stats but __mod_memcg_lruvec_state can only handle the memcg stats, so
simply only call __mod_memcg_lruvec_state for memcg stats.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4e991e913393..531b6ff711c7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -860,8 +860,6 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 		case NR_ANON_MAPPED:
 		case NR_FILE_MAPPED:
 		case NR_ANON_THPS:
-		case NR_SHMEM_PMDMAPPED:
-		case NR_FILE_PMDMAPPED:
 			if (WARN_ON_ONCE(!in_task()))
 				pr_warn("stat item index: %d\n", idx);
 			break;
@@ -899,7 +897,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
 
 	/* Update memcg and lruvec */
-	if (!mem_cgroup_disabled())
+	if (!mem_cgroup_disabled() && idx < NR_VM_NODE_MEMCG_STAT_ITEMS)
 		__mod_memcg_lruvec_state(lruvec, idx, val);
 }
 
-- 
2.43.0


