Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6947E7805
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345801AbjKJDdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjKJDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:33:53 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B9E4682
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:33:50 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SRPSZ0PHHzMmkl;
        Fri, 10 Nov 2023 11:29:18 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 11:33:47 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/7] mm: remove page idle and young wrapper
Date:   Fri, 10 Nov 2023 11:33:17 +0800
Message-ID: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use folio idle and young functions instead of page ones,
then remove all page idle and young wrapper.

v2:
- remove useless PageTail && PageSlab check 
- collect Gregory Price's work, see patch3

Kefeng Wang (7):
  fs/proc/page: remove unneeded PageTail && PageSlab check
  fs/proc/page: use a folio in stable_page_flags()
  fs/proc/page: respect folio head-page flag placement
  mm: huge_memory: use more folio api in __split_huge_page_tail()
  mm: task_mmu: use a folio in smaps_account()
  mm: task_mmu: use a folio in clear_refs_pte_range()
  page_idle: kill page idle and young wrapper

 fs/proc/page.c            | 41 ++++++++++++++++++---------------------
 fs/proc/task_mmu.c        | 28 +++++++++++++-------------
 include/linux/page_idle.h | 25 ------------------------
 mm/huge_memory.c          | 12 ++++++------
 4 files changed, 40 insertions(+), 66 deletions(-)

-- 
2.27.0

