Return-Path: <linux-kernel+bounces-63405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B89D852EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714CB285699
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762DE383B4;
	Tue, 13 Feb 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K6wyJoAZ"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9F37711
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822851; cv=none; b=FY4naBZA3YPUFqRXxRcJgVUlnuPtzSXE6e/MHQRTU9h+EMxiRMkdFx1RF/pF7IaPvxywNwsNritJEyMjdQw7L8jEe+mZL8aep8vJZh7fl/8z3FsKF7IDSuaWDXpmWP9TNVb8w3i0ITxHcZ4zz8hE6n8AxQhXktotOabRKZbgyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822851; c=relaxed/simple;
	bh=d6/hUbDiaSKbaKZPPqsgtYI6MyO67KcFseD9Tax9SNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e9VM0N4qQvPEi1G9c9zmIYx0DlSFON9f/CbAw5KjESS64KEtmvPpx6XOtMTZxqTsOyyxda8Q3/g6qFWEbH/5UFTkXk10v8pf1cR3AlJGkkKj60QO0CaoM4DfRJbFw5Awypi1gNEJjJFYdpSaEDmFOXqU+0tJypUa48M3dwZhZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K6wyJoAZ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707822848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+0w6vgAkx480UaKM14cyn/7okLKV9MHO3nKluWgIkY=;
	b=K6wyJoAZJmiAzz8+5pYM3XytCKwKH7mDSv+DR8+IWYQXu64yniCYgylUCM1PW/LdkJ+TWB
	NapD8/7k+iGm2K5CRO8w6/sOqUjGsvTCxz0YMU4U5TIqeUNCDkNoX510dFoS4Y+6Dmeq/e
	lo6UmME7aGnRqdGCGovmp/a6yGx/yD8=
From: Gang Li <gang.li@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Jane Chu <jane.chu@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Gang Li <gang.li@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Gang Li <ligang.bdlg@bytedance.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 2/2] hugetlb: process multiple lists in gather_bootmem_prealloc_parallel
Date: Tue, 13 Feb 2024 19:13:47 +0800
Message-Id: <20240213111347.3189206-3-gang.li@linux.dev>
In-Reply-To: <20240213111347.3189206-1-gang.li@linux.dev>
References: <20240213111347.3189206-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

gather_bootmem_prealloc_node currently only process one list in
huge_boot_pages array. So gather_bootmem_prealloc expects
padata_do_multithreaded to run num_node_state(N_MEMORY) instances of
gather_bootmem_prealloc_node to process all lists in huge_boot_pages.

This works well in current padata_do_multithreaded implementation.
It guarantees that size/min_chunk <= thread num <= max_threads.

```
/* Ensure at least one thread when size < min_chunk. */
nworks = max(job->size / max(job->min_chunk, job->align), 1ul);
nworks = min(nworks, job->max_threads);

ps.nworks      = padata_work_alloc_mt(nworks, &ps, &works);
```

However, the comment of padata_do_multithreaded API only promises a
maximum value for the number of threads and does not specify a
minimum value. Which may pass multiple nodes to
gather_bootmem_prealloc_node and only one node will be processed.

To avoid potential errors, introduce gather_bootmem_prealloc_parallel
to handle the case where the number of threads does not meet the
requirement of max_threads.

Fixes: 0306f03dcbd7 ("hugetlb: parallelize 1G hugetlb initialization")
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 mm/hugetlb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 25069ca6ec248..2799a7ea098c1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3414,10 +3414,8 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
  */
-static void __init gather_bootmem_prealloc_node(unsigned long start, unsigned long end, void *arg)
-
+static void __init gather_bootmem_prealloc_node(unsigned long nid)
 {
-	int nid = start;
 	LIST_HEAD(folio_list);
 	struct huge_bootmem_page *m;
 	struct hstate *h = NULL, *prev_h = NULL;
@@ -3455,10 +3453,19 @@ static void __init gather_bootmem_prealloc_node(unsigned long start, unsigned lo
 	prep_and_add_bootmem_folios(h, &folio_list);
 }
 
+static void __init gather_bootmem_prealloc_parallel(unsigned long start,
+						    unsigned long end, void *arg)
+{
+	int nid;
+
+	for (nid = start; nid < end; nid++)
+		gather_bootmem_prealloc_node(nid);
+}
+
 static void __init gather_bootmem_prealloc(void)
 {
 	struct padata_mt_job job = {
-		.thread_fn	= gather_bootmem_prealloc_node,
+		.thread_fn	= gather_bootmem_prealloc_parallel,
 		.fn_arg		= NULL,
 		.start		= 0,
 		.size		= num_node_state(N_MEMORY),
-- 
2.20.1


