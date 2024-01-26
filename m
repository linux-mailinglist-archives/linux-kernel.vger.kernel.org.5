Return-Path: <linux-kernel+bounces-40267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508B083DD63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056721F219A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752531CF98;
	Fri, 26 Jan 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I5quX/oG"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA061CF8C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282698; cv=none; b=QDH8DtIi9siY4bmvzTv+JL7SFeVP9r3G/R8kUrMOStd5fFKu23SKFJc02yWsRaRxk3Q24OJ3gkoK56fRjI8z/xSEYM0Tk43ThTcSUsVxiyt1RZA1E7bm1KjIUivYHmUqiTx5+Kq5TluzDlL9dXDZJqhiP9kGcn5tzubdiUbUVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282698; c=relaxed/simple;
	bh=lCrZACFRheTRgybLbHLBHBT1Wcn498DFz01Cjya20fk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LGle3RaiVgVm9yydxBQJDCv+o0wHakq0WNIZuOCubnvyRMrHYkdr0gEtAvPsjcc3YReQCFF7hjPqpnBp3srXWX7w5ttDHNM6GLwdbHOygQBo4H9k3To16oJVxt94ipuNuuQBFu4QbajcWVYabgIk7U0VfiTqmA/miZnUSolPjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I5quX/oG; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706282692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lgnke4sUkqUF2pP50eUrQqO/+toTU6ZkY2mCk3wiX/M=;
	b=I5quX/oGzhc+pgrMgx4pRy9+4HXJOwjBwGTQdCMAkq42FB1gw5jMK2DSusevSGdsUNcrqw
	ZzLYiZiG34Xz60A5MQin1gbU/V616IT6k+rln3GYBxdT1h67K9dXBOQHtoK9x/ZlF2oGg0
	vu07KdhJEhwl7dVWBsQPSWuhyjXbW8s=
From: Gang Li <gang.li@linux.dev>
To: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v5 0/7] hugetlb: parallelize hugetlb page init on boot
Date: Fri, 26 Jan 2024 23:24:04 +0800
Message-Id: <20240126152411.1238072-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all, hugetlb init parallelization has now been updated to v5.

This version is tested on next-20240125.

Update Summary:
- Use prep_and_add_allocated_folios in 2M hugetlb parallelization
- Update huge_boot_pages in arch/powerpc/mm/hugetlbpage.c
- Revise struct padata_mt_job comment
- Add 'max_threads' section in cover letter
- Collect more Reviewed-by

# Introduction
Hugetlb initialization during boot takes up a considerable amount of time.
For instance, on a 2TB system, initializing 1,800 1GB huge pages takes 1-2
seconds out of 10 seconds. Initializing 11,776 1GB pages on a 12TB Intel
host takes more than 1 minute[1]. This is a noteworthy figure.

Inspired by [2] and [3], hugetlb initialization can also be accelerated
through parallelization. Kernel already has infrastructure like
padata_do_multithreaded, this patch uses it to achieve effective results
by minimal modifications.

[1] https://lore.kernel.org/all/783f8bac-55b8-5b95-eb6a-11a583675000@google.com/
[2] https://lore.kernel.org/all/20200527173608.2885243-1-daniel.m.jordan@oracle.com/
[3] https://lore.kernel.org/all/20230906112605.2286994-1-usama.arif@bytedance.com/
[4] https://lore.kernel.org/all/76becfc1-e609-e3e8-2966-4053143170b6@google.com/

# max_threads
This patch use `padata_do_multithreaded` like this:

```
job.max_threads	= num_node_state(N_MEMORY) * multiplier;
padata_do_multithreaded(&job);
```

To fully utilize the CPU, the number of parallel threads needs to be
carefully considered. `max_threads = num_node_state(N_MEMORY)` does
not fully utilize the CPU, so we need to multiply it by a multiplier.

Tests below indicate that a multiplier of 2 significantly improves
performance, and although larger values also provide improvements,
the gains are marginal.

  multiplier     1       2       3       4       5
 ------------ ------- ------- ------- ------- -------
  256G 2node   358ms   215ms   157ms   134ms   126ms
  2T   4node   979ms   679ms   543ms   489ms   481ms
  50G  2node   71ms    44ms    37ms    30ms    31ms

Therefore, choosing 2 as the multiplier strikes a good balance between
enhancing parallel processing capabilities and maintaining efficient
resource management.

# Test result
      test case       no patch(ms)   patched(ms)   saved
 ------------------- -------------- ------------- --------
  256c2T(4 node) 1G           4745          2024   57.34%
  128c1T(2 node) 1G           3358          1712   49.02%
     12T         1G          77000         18300   76.23%

  256c2T(4 node) 2M           3336          1051   68.52%
  128c1T(2 node) 2M           1943           716   63.15%

# Change log
Changes in v5:
- Use prep_and_add_allocated_folios in 2M hugetlb parallelization
- Update huge_boot_pages in arch/powerpc/mm/hugetlbpage.c
- Revise struct padata_mt_job comment
- Add 'max_threads' section in cover letter
- Collect more Reviewed-by

Changes in v4:
- https://lore.kernel.org/r/20240118123911.88833-1-gang.li@linux.dev
- Make padata_do_multithreaded dispatch all jobs with a global iterator
- Revise commit message
- Rename some functions
- Collect Tested-by and Reviewed-by

Changes in v3:
- https://lore.kernel.org/all/20240102131249.76622-1-gang.li@linux.dev/
- Select CONFIG_PADATA as we use padata_do_multithreaded
- Fix a race condition in h->next_nid_to_alloc
- Fix local variable initialization issues
- Remove RFC tag

Changes in v2:
- https://lore.kernel.org/all/20231208025240.4744-1-gang.li@linux.dev/
- Reduce complexity with `padata_do_multithreaded`
- Support 1G hugetlb

v1:
- https://lore.kernel.org/all/20231123133036.68540-1-gang.li@linux.dev/
- parallelize 2M hugetlb initialization with workqueue

Gang Li (7):
  hugetlb: code clean for hugetlb_hstate_alloc_pages
  hugetlb: split hugetlb_hstate_alloc_pages
  padata: dispatch works on different nodes
  hugetlb: pass *next_nid_to_alloc directly to
    for_each_node_mask_to_alloc
  hugetlb: have CONFIG_HUGETLBFS select CONFIG_PADATA
  hugetlb: parallelize 2M hugetlb allocation and initialization
  hugetlb: parallelize 1G hugetlb initialization

 arch/powerpc/mm/hugetlbpage.c |   2 +-
 fs/Kconfig                    |   1 +
 include/linux/hugetlb.h       |   2 +-
 include/linux/padata.h        |   2 +
 kernel/padata.c               |  14 +-
 mm/hugetlb.c                  | 234 +++++++++++++++++++++++-----------
 mm/mm_init.c                  |   1 +
 7 files changed, 175 insertions(+), 81 deletions(-)

-- 
2.20.1


