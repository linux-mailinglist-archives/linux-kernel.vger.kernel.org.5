Return-Path: <linux-kernel+bounces-14381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325DE821C54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5798282932
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6B6FBED;
	Tue,  2 Jan 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nUUoJdqW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3035FBE5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704201194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=daO+8Vo0jNlvzwLRDw/Wt7KlxBb2Rk5joGViCE+fZW4=;
	b=nUUoJdqW8b8LoXHm6jHb9AQoY7w7usMJmtiAEiG2xDm2XoFPm+hkRBm6Jl/cdjHsWd+4Nr
	kezQIcH7hHdzuHg5+e9JelcznloIelv+/ZeX/+J885tGp/WhFMipVKmKMQiLZVYg0eD2hM
	gsnUdbwcikV11Key7utkhN+Cmo9mvXs=
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
Subject: [PATCH v3 0/7] hugetlb: parallelize hugetlb page init on boot
Date: Tue,  2 Jan 2024 21:12:42 +0800
Message-Id: <20240102131249.76622-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all, hugetlb init parallelization has now been updated to v3.

This series is tested on next-20240102 and can not be applied to v6.7-rc8.

Update Summary:
- Select CONFIG_PADATA as we use padata_do_multithreaded
- Fix a race condition in h->next_nid_to_alloc
- Fix local variable initialization issues
- Remove RFC tag

Thanks to the testing by David Rientjes, we now know that this patch reduce
hugetlb 1G initialization time from 77s to 18.3s on a 12T machine[4].

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

# Test result
        test          no patch(ms)   patched(ms)   saved   
 ------------------- -------------- ------------- -------- 
  256c2t(4 node) 1G           4745          2024   57.34%
  128c1t(2 node) 1G           3358          1712   49.02%
      12t        1G          77000         18300   76.23%

  256c2t(4 node) 2M           3336          1051   68.52%
  128c1t(2 node) 2M           1943           716   63.15%

# Change log
Changes in v3:
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

 fs/Kconfig              |   1 +
 include/linux/hugetlb.h |   2 +-
 include/linux/padata.h  |   3 +
 kernel/padata.c         |   8 +-
 mm/hugetlb.c            | 224 +++++++++++++++++++++++++++-------------
 mm/mm_init.c            |   1 +
 6 files changed, 163 insertions(+), 76 deletions(-)

-- 
2.20.1


