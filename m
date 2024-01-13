Return-Path: <linux-kernel+bounces-25218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05F882CA96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E629E1C22410
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEAD10A32;
	Sat, 13 Jan 2024 08:48:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF563C3
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TBsQD2LV9z1FJ3B;
	Sat, 13 Jan 2024 16:44:04 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id DC46A1404F7;
	Sat, 13 Jan 2024 16:48:13 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Jan
 2024 16:48:12 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>,
	<anshuman.khandual@arm.com>
CC: <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Date: Sat, 13 Jan 2024 17:44:33 +0800
Message-ID: <20240113094436.2506396-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)

HVO was previously disabled on arm64 [1] due to the lack of necessary
BBM(break-before-make) logic when changing page tables.
This set of patches fix this by adding necessary BBM sequence when
changing page table, and supporting vmemmap page fault handling to
fixup kernel address translation fault if vmemmap is concurrently accessed.

I have tested this patch set with concurrently accessing the vmemmap
address when do BBM and can recover by vmemmap fault handler. Also
tested under the config of 2/3/4 pgtable levels with 4K/64K page size
and all works well.

V3:
Cleanup:
Move the declarations of helper function in proper head file.

V2:
This version mainly changes some naming, and uses more appropriate helper
functions to make the code more clean, according to review comments from
Muchun Song and Kefeng Wang.

[1] commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP")

Nanyong Sun (3):
  mm: HVO: introduce helper function to update and flush pgtable
  arm64: mm: HVO: support BBM of vmemmap pgtable safely
  arm64: mm: Re-enable OPTIMIZE_HUGETLB_VMEMMAP

 arch/arm64/Kconfig                |  1 +
 arch/arm64/include/asm/esr.h      |  4 ++
 arch/arm64/include/asm/pgtable.h  |  8 ++++
 arch/arm64/include/asm/tlbflush.h | 16 +++++++
 arch/arm64/mm/fault.c             | 78 +++++++++++++++++++++++++++++--
 arch/arm64/mm/mmu.c               | 28 +++++++++++
 mm/hugetlb_vmemmap.c              | 55 +++++++++++++++++-----
 7 files changed, 175 insertions(+), 15 deletions(-)

-- 
2.25.1


