Return-Path: <linux-kernel+bounces-101016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F787A0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFD61F22352
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41178B67D;
	Wed, 13 Mar 2024 01:29:33 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC350B652
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293372; cv=none; b=i90FSQ/L4GRQeOMGUx7WBvvPqNfVd1c1pzqEUPA1KRTn9qATUL3WdBAmCvVMYw0Hw7k4jYDWepIDwh/xC4mbWOqpvrGzYEss4Hqrgfpv8IPTV+ZQGhXpD2vVW/CtRGzzOMm8chMJmpve9FwFYyXDB2I1xDmb/qH7MGM3z/CISGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293372; c=relaxed/simple;
	bh=UJlpHkjPoNvC6jxkYpAzHDrDK0oNnOtTFuq6EhLz/48=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XLfysyIZssQs5AK9r4l4dZmzJ3wG3KqrP4PYIDSq6e/oBEY36V1yhb2HDlctgNIyeHisy33Ba0S07T4SWLS/f+fZZ95TXgCJVdDJ8W6kvVdFZ5wLjyL/qJ3ehBqcQ/bjQxD8L1YsQtaZB01JA3Ytbt0E9lzwXcIc9eWimLS5l1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TvXt75qYSzXj3j;
	Wed, 13 Mar 2024 09:26:55 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C9FF18007B;
	Wed, 13 Mar 2024 09:29:21 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 09:29:20 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <willy@infradead.org>,
	<ying.huang@intel.com>, <fengwei.yin@intel.com>, <david@redhat.com>,
	<aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>, <hughd@google.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<zhangpeng362@huawei.com>
Subject: [PATCH] filemap: replace pte_offset_map() with pte_offset_map_nolock()
Date: Wed, 13 Mar 2024 09:29:13 +0800
Message-ID: <20240313012913.2395414-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)

From: ZhangPeng <zhangpeng362@huawei.com>

The vmf->ptl in filemap_fault_recheck_pte_none() is still set from
handle_pte_fault(). But at the same time, we did a pte_unmap(vmf->pte).
After a pte_unmap(vmf->pte) unmap and rcu_read_unlock(), the page table
may be racily changed and vmf->ptl maybe fails to protect the actual
page table.
Fix this by replacing pte_offset_map() with pte_offset_map_nolock().

Fixes: 58f327f2ce80 ("filemap: avoid unnecessary major faults in filemap_fault()")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/filemap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 31ab455c4537..222adac7c9c5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3207,7 +3207,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
 		return 0;
 
-	ptep = pte_offset_map(vmf->pmd, vmf->address);
+	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
+				     &vmf->ptl);
 	if (unlikely(!ptep))
 		return VM_FAULT_NOPAGE;
 
-- 
2.25.1


