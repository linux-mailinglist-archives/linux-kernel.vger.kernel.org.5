Return-Path: <linux-kernel+bounces-76661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D9485FAB2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DFB283373
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F11474C1;
	Thu, 22 Feb 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n3lcoALj"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8881474B3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610687; cv=none; b=DAVsXy/gUOSg0a7uLXeycPYGdNcWuJN9KvbCPLc4b5NrN4+wwhGPCNNwt1WukLJNze+DFCCTSY+DW3H9gzz2Gu3AEuT5M1IYmFpxaY2K+dhW8OkqlAdJtT7/19arX9vTNDwLHJuQuUghiFbjETmOavJQ+a+fhjVH9sxmrOpdr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610687; c=relaxed/simple;
	bh=oa2OZFr65MJTMncK2x8+Hd+WOPG54W/4LW7RmU3u+RE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dLmsMcPWud/kE1ELHeBPDk7HAZ6l5Fev2ZQA+gfx8EUDG5og+17qIclxf155aUFPN+h8wiEVR05wTbgsUVmm+jOWHRdMYx0QLzs3JTF59aUVvUKKtpFsVkQRC4QrqNs6xX2DZO7ySPRM8e0kNTRcQtXiIAzTMZ6KLE0Kf0Hjrpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n3lcoALj; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708610682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B0gB3dnFjS7/hmQUqLE92LRaTlx9ED9y/zOkYWN8jYI=;
	b=n3lcoALjtwDDsGsHEnhCKu9TSJhGuUQEVQuQfil8mAgq/3q+rsyWIfsq9eKnyq9pgtWkRB
	kCXfFWkgwJiYqwdl8oDnucfdtJwax5nhPjJXQ8qMNfECotCEMDnEM2yfu49+nyz9RM7aN5
	WsGpp6l7B3yc/FlByIC7K1kW3yCplyY=
From: Gang Li <gang.li@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Jane Chu <jane.chu@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v6 0/8] hugetlb: parallelize hugetlb page init on boot
Date: Thu, 22 Feb 2024 22:04:13 +0800
Message-Id: <20240222140422.393911-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all, hugetlb init parallelization has now been updated to v6.

This version is tested on mm/mm-stable.

Since the release of v5, there have been some scattered discussions, they have
primarily centered around two issues. Both of these issues have now been
resolved, leading to the release of v6.

Two updates in v6
-----------------
- Fix a Kconfig warning
  hugetlb parallelization depends on PADATA, and PADATA depends on SMP. When SMP
  is not selected, selecting PADATA will cause a warning: "WARNING: unmet direct
  dependencies detected for PADATA". So HUGETLBFS can only select PADATA when
  SMP is set.

  padata.c will not be compiled if !SMP, but padata_do_multithreaded is still
  used in this series for hugetlb parallel init. So it is necessary to implement
  a serial version in padata.h.

- Fix a potential bug in gather_bootmem_prealloc_node
  padata_do_multithreaded implementation guarantees that each
  gather_bootmem_prealloc_node task handles one node. However, the API described
  in padata_do_multithreaded comment indicates that padata_do_multithreaded also
  can assign multiple nodes to a gather_bootmem_prealloc_node task.

  To avoid potential bug from future changes in padata_do_multithreaded,
  gather_bootmem_prealloc_parallel is introduced to wrap the
  gather_bootmem_prealloc_node.

  More details in: https://lore.kernel.org/r/20240213111347.3189206-3-gang.li@linux.dev

Introduction
------------
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

max_threads
-----------
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

Test result
-----------
      test case       no patch(ms)   patched(ms)   saved
 ------------------- -------------- ------------- --------
  256c2T(4 node) 1G           4745          2024   57.34%
  128c1T(2 node) 1G           3358          1712   49.02%
     12T         1G          77000         18300   76.23%

  256c2T(4 node) 2M           3336          1051   68.52%
  128c1T(2 node) 2M           1943           716   63.15%

Change log
----------
Changes in v6:
- Fix a Kconfig warning
- Fix a potential bug in gather_bootmem_prealloc_node

Changes in v5:
- https://lore.kernel.org/lkml/20240126152411.1238072-1-gang.li@linux.dev/
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

Gang Li (8):
  hugetlb: code clean for hugetlb_hstate_alloc_pages
  hugetlb: split hugetlb_hstate_alloc_pages
  hugetlb: pass *next_nid_to_alloc directly to
    for_each_node_mask_to_alloc
  padata: dispatch works on different nodes
  padata: downgrade padata_do_multithreaded to serial execution for
    non-SMP
  hugetlb: have CONFIG_HUGETLBFS select CONFIG_PADATA
  hugetlb: parallelize 2M hugetlb allocation and initialization
  hugetlb: parallelize 1G hugetlb initialization

 arch/powerpc/mm/hugetlbpage.c |   2 +-
 fs/Kconfig                    |   1 +
 include/linux/hugetlb.h       |   2 +-
 include/linux/padata.h        |  14 +-
 kernel/padata.c               |  14 +-
 mm/hugetlb.c                  | 241 +++++++++++++++++++++++-----------
 mm/mm_init.c                  |   1 +
 7 files changed, 190 insertions(+), 85 deletions(-)

-- 
2.20.1


