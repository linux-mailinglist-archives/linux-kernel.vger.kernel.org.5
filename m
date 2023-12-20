Return-Path: <linux-kernel+bounces-6363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C2F8197B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0FB281D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D415AF0;
	Wed, 20 Dec 2023 04:21:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB4156E2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Sw0kD4qwgz1Q65Q;
	Wed, 20 Dec 2023 12:21:24 +0800 (CST)
Received: from kwepemm000003.china.huawei.com (unknown [7.193.23.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 302BA1402DE;
	Wed, 20 Dec 2023 12:21:41 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm000003.china.huawei.com
 (7.193.23.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Dec
 2023 12:21:40 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>,
	<anshuman.khandual@arm.com>
CC: <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Date: Wed, 20 Dec 2023 13:18:52 +0800
Message-ID: <20231220051855.47547-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000003.china.huawei.com (7.193.23.66)

HVO was previously disabled on arm64 [1] due to the lack of necessary
BBM(break-before-make) logic when changing page tables.
This set of patches fix this by adding necessary BBM sequence when
changing page table, and supporting vmemmap page fault handling to
fixup kernel address fault if vmemmap is concurrently accessed.

I have tested this patch set with concurrently accessing the vmemmap
address when do BBM and can recover by vmemmap fault handler. Also
tested under the config of 2/3/4 pgtable levels with 4K/64K page size
and all works well.

V2:
This version mainly changes some naming, and uses more appropriate helper
functions to make the code more clean, according to review comments from
Muchun Song and Kefeng Wang.

[1] commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP")

Nanyong Sun (3):
  mm: HVO: introduce helper function to update and flush pgtable
  arm64: mm: HVO: support BBM of vmemmap pgtable safely
  arm64: mm: Re-enable OPTIMIZE_HUGETLB_VMEMMAP

 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/esr.h |  4 ++
 arch/arm64/include/asm/mmu.h | 20 +++++++++
 arch/arm64/mm/fault.c        | 78 ++++++++++++++++++++++++++++++++++--
 arch/arm64/mm/mmu.c          | 28 +++++++++++++
 mm/hugetlb_vmemmap.c         | 55 +++++++++++++++++++------
 6 files changed, 171 insertions(+), 15 deletions(-)

-- 
2.25.1


