Return-Path: <linux-kernel+bounces-54586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC284B135
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B960B2559F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284E12D14B;
	Tue,  6 Feb 2024 09:26:45 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D112D148
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211605; cv=none; b=SiijAt/9wUGLz8b0Bu2CU7qCPdii6RfRetJJVz4Ou+M6tHuG35aR/k7VcrndmoNFyOStBFIoX9U3orAI0jMiyT/1DNqT6cKBDSwWB/ZfDml+FIoZyoQeJMnYbJg34Zm6zwuduaUCr3ycAsJEfBf5NBHCO+XnKztqjYTc4yQJdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211605; c=relaxed/simple;
	bh=CUBYtXR7dZ7ul+I+hlU20jxSKtrjlcfOsGQaeCYKjRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BcTa4IiU5qw0kHHBnRQQJeFEdEcLJ3S0mkFq3BJEQk+JSRgni+0alRltuRnQ8vwi2z4ksmvQV6FjJFrLlD2U+c6IX+MJxy6s3+uO2PefDn1OrKkYX052T9ovXKnKvYpry50Px9kTEdBA+ntmZdoH9UIv+lbWLWVEtN7COzp6Myo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TTd9z0Pk5z1Q8fm;
	Tue,  6 Feb 2024 17:24:39 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 10280140382;
	Tue,  6 Feb 2024 17:26:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 17:26:33 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <willy@infradead.org>,
	<ying.huang@intel.com>, <fengwei.yin@intel.com>,
	<aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>, <hughd@google.com>,
	<david@redhat.com>, <wangkefeng.wang@huawei.com>, <zhangpeng362@huawei.com>
Subject: [PATCH v2] filemap: avoid unnecessary major faults in filemap_fault()
Date: Tue, 6 Feb 2024 17:26:27 +0800
Message-ID: <20240206092627.1421712-1-zhangpeng362@huawei.com>
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

The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
in application, which leading to an unexpected performance issue[1].

This caused by temporarily cleared PTE during a read+clear/modify/write
update of the PTE, eg, do_numa_page()/change_pte_range().

For the data segment of the user-mode program, the global variable area
is a private mapping. After the pagecache is loaded, the private anonymous
page is generated after the COW is triggered. Mlockall can lock COW pages
(anonymous pages), but the original file pages cannot be locked and may
be reclaimed. If the global variable (private anon page) is accessed when
vmf->pte is zeroed in numa fault, a file page fault will be triggered.

At this time, the original private file page may have been reclaimed.
If the page cache is not available at this time, a major fault will be
triggered and the file will be read, causing additional overhead.

Fix this by rechecking the PTE without acquiring PTL in filemap_fault()
before triggering a major fault.

Testing file anonymous page read and write page fault performance in ext4
and ramdisk using will-it-scale[2] on a x86 physical machine. The data
is the average change compared with the mainline after the patch is
applied. The test results are within the range of fluctuation, and there
is no obvious difference. The test results are as follows:
	                 processes processes_idle threads threads_idle
ext4    private file write: -1.14%  -0.08%         -1.87%   0.13%
ext4    shared  file write:  0.14%  -0.53%          2.88%  -0.77%
ext4    private file  read:  0.03%  -0.65%         -0.51%  -0.08%
tmpfs   private file write: -0.34%  -0.11%          0.20%   0.15%
tmpfs   shared  file write:  0.96%   0.10%          2.78%  -0.34%
ramdisk private file write: -1.21%  -0.21%         -1.12%   0.11%
ramdisk private file  read:  0.00%  -0.68%         -0.33%  -0.02%

[1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
[2] https://github.com/antonblanchard/will-it-scale/

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v1->v2:
- Add more test results per Huang, Ying
- Add more comments before check PTE per Huang, Ying, David Hildenbrand
  and Yin Fengwei
- Change pte_offset_map_nolock to pte_offset_map as the ptl lock won't
  be used

RFC->v1:
- Add error handling when ptep == NULL per Huang, Ying and Matthew
  Wilcox
- Check the PTE without acquiring PTL in filemap_fault(), suggested by
  Huang, Ying and Yin Fengwei
- Add pmd_none() check before PTE map
- Update commit message and add performance test information

 mm/filemap.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 142864338ca4..a2c1a98bc771 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3238,6 +3238,40 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 			mapping_locked = true;
 		}
 	} else {
+		if (!pmd_none(*vmf->pmd)) {
+			pte_t *ptep;
+
+			ptep = pte_offset_map(vmf->pmd, vmf->address);
+			if (unlikely(!ptep))
+				return VM_FAULT_NOPAGE;
+			/*
+			 * Recheck PTE as the PTE can be cleared temporarily
+			 * during a read+clear/modify/write update of the PTE,
+			 * eg, do_numa_page()/change_pte_range(). This will
+			 * trigger a major fault, even if we use mlockall,
+			 * which may affect performance.
+			 * We don't hold PTL here as acquiring PTL hurts
+			 * performance. So the check is still racy, but
+			 * the race window seems small enough.
+			 *
+			 * If we lose the race during the check, the page_fault
+			 * will be triggered. Butthe page table entry lock
+			 * still make sure the correctness:
+			 * - If the page cache is not reclaimed, the page_fault
+			 *   will work like the page fault was served already
+			 *   and bail out.
+			 * - If the page cache is reclaimed, the major fault
+			 *   will be triggered, page cache is filled,
+			 *   page_fault also work like the page fault was
+			 *   served already and bail out.
+			 */
+			if (unlikely(!pte_none(ptep_get_lockless(ptep))))
+				ret = VM_FAULT_NOPAGE;
+			pte_unmap(ptep);
+			if (unlikely(ret))
+				return ret;
+		}
+
 		/* No page in the page cache at all */
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
-- 
2.25.1


