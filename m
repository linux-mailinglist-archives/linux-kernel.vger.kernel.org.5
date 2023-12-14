Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA318128A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443263AbjLNHBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjLNHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:01:20 -0500
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B18B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:01:26 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SrN5f142zz29fnb;
        Thu, 14 Dec 2023 14:40:38 +0800 (CST)
Received: from kwepemm000003.china.huawei.com (unknown [7.193.23.66])
        by mail.maildlp.com (Postfix) with ESMTPS id 5BBC4140134;
        Thu, 14 Dec 2023 14:41:46 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm000003.china.huawei.com
 (7.193.23.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 14:41:45 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mike.kravetz@oracle.com>, <muchun.song@linux.dev>,
        <akpm@linux-foundation.org>, <anshuman.khandual@arm.com>
CC:     <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 0/3] A Solution to Re-enable hugetlb vmemmap optimize on Arm
Date:   Thu, 14 Dec 2023 15:39:09 +0800
Message-ID: <20231214073912.1938330-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HVO was previously disabled on arm64 [1] due to the lack of necessary
BBM(break-before-make) logic when changing page tables.
This set of patches fix this by adding necessary BBM sequence when
changing page table, and supporting vmemmap page fault handling to
fixup kernel address fault if vmemmap is concurrently accessed.

[1] commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP")

Nanyong Sun (3):
  mm: HVO: introduce helper function to update and flush pgtable
  arm64: mm: HVO: support BBM of vmemmap pgtable safely
  arm64: mm: Re-enable OPTIMIZE_HUGETLB_VMEMMAP

 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/esr.h |  4 ++
 arch/arm64/include/asm/mmu.h | 20 ++++++++
 arch/arm64/mm/fault.c        | 94 ++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c          | 28 +++++++++++
 mm/hugetlb_vmemmap.c         | 55 ++++++++++++++++-----
 6 files changed, 190 insertions(+), 12 deletions(-)

-- 
2.25.1

