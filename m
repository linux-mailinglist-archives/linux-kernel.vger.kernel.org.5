Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0597CD7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjJRJa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJRJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:30:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2485EF9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:30:21 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S9QTT53XPzRt5H;
        Wed, 18 Oct 2023 17:26:37 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 17:30:17 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v3 0/7] Some bugfix about kmemleak
Date:   Wed, 18 Oct 2023 18:29:45 +0800
Message-ID: <20231018102952.3339837-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bugfix about kmemleak and the print info of debug mode.

v2->v3: Split __create_object into two function[4] and use kmemleak_lock to
	fix partially freeing unknown object warning[7]. And add a new patch
	to fix an inccorrect use of kmem_cache_free[5].
v1->v2: Split the first patch suggested by Andrew. And fix the format of
	the last two patches suggested by Catalin. Use mutex in patch[3]
	because there are memory allocation with flag GFP_KERNEL.

Liu Shixin (7):
  bootmem: use kmemleak_free_part_phys in put_page_bootmem
  bootmem: use kmemleak_free_part_phys in free_bootmem_page
  mm/kmemleak: fix print format of pointer in pr_debug()
  mm: kmemleak: split __create_object into two functions
  mm: kmemleak: use mem_pool_free() to free object
  mm: kmemleak: add __find_and_remove_object()
  mm/kmemleak: fix partially freeing unknown object warning

 include/linux/bootmem_info.h |   2 +-
 mm/bootmem_info.c            |   2 +-
 mm/kmemleak.c                | 154 +++++++++++++++++++++++------------
 3 files changed, 106 insertions(+), 52 deletions(-)

-- 
2.25.1

