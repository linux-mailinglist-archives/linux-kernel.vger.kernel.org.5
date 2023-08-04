Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EDF76F9F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjHDGVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjHDGVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:21:32 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F774E70
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:21:29 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-31-64cc98e6931c
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com
Subject: [RFC 0/2] Reduce TLB flushes under some specific conditions
Date:   Fri,  4 Aug 2023 15:18:48 +0900
Message-Id: <20230804061850.21498-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsXC9ZZnoe6zGWdSDPbuMbSYs34Nm8XX9b+Y
        LZ5+6mOxuLxrDpvFvTX/WS12LN3HZHF910NGi98/gGJzplhZnJw1mcWBy2PBplKPzSu0PBbv
        ecnksenTJHaPEzN+s3jsfGjp8X7fVTaPrb/sPD5vkvN4N/8tWwBXFJdNSmpOZllqkb5dAlfG
        lB0L2Ase8lfMftXA3MC4hruLkZNDQsBE4vnFh4wwdv+3DUwgNpuAusSNGz+ZQWwRATOJg61/
        2LsYuTiYBe4wShze1QhWJCzgInHp12Q2EJtFQFViydvprCA2r4CpxJOP/awQQ+UlVm84wAzS
        LCEwgU1i+tcPzBAJSYmDK26wTGDkXsDIsIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMMyW1f6J
        3sH46ULwIUYBDkYlHt4PB06nCLEmlhVX5h5ilOBgVhLhvfYeKMSbklhZlVqUH19UmpNafIhR
        moNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFRYlPMoaXFsgo9O5dYq6610Gp1+eEV963o
        yd38FOF1e2vC7aLzTjibfy9l6/L47XNpj8Zsx7+Mr6aFZx7/V31uMZuC9t8Dq75NKlkzOY/1
        xq+W1myG1IXHpoZV6Fy+ysvZ4bkk+mp9g2zfj7AH75ZGcmfJfDiwStRSdULoXb9lXBlXsgtz
        1F8rsRRnJBpqMRcVJwIA+5w9QS8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42Lh8rNu1n0240yKwcPPahZz1q9hs/i6/hez
        xdNPfSwWh+eeZLW4vGsOm8W9Nf9ZLXYs3cdkcX3XQ0aL3z+AYnOmWFmcnDWZxYHbY8GmUo/N
        K7Q8Fu95yeSx6dMkdo8TM36zeOx8aOnxft9VNo/FLz4weWz9ZefxeZOcx7v5b9kCuKO4bFJS
        czLLUov07RK4MqbsWMBe8JC/YvarBuYGxjXcXYycHBICJhL93zYwgdhsAuoSN278ZAaxRQTM
        JA62/mHvYuTiYBa4wyhxeFcjWJGwgIvEpV+T2UBsFgFViSVvp7OC2LwCphJPPvazQgyVl1i9
        4QDzBEaOBYwMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQKDZlntn4k7GL9cdj/EKMDBqMTD
        ++HA6RQh1sSy4srcQ4wSHMxKIrzX3gOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQn
        lqRmp6YWpBbBZJk4OKUaGIUDVj3yip1Vq/X1Zprx1P8de8XZCuaacViu33i0diPrcgU59tzO
        y8p5rjPOK8b9+/Xvo6b/Zme5dI2Xh1dt2/ByYmqtFq/iv4NpXqJ7I5P1Vhy76/i6gWm1NwN7
        6V63+ftf3ow+NG9lv8iPwIhpE0+J9BgKxRlWVVmzy/hHMrI1G19w8XV9ocRSnJFoqMVcVJwI
        AKmbY+YWAgAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While I'm working with CXL, I have been facing migraion overhead esp.
TLB shootdown on promotion or demotion between different tiers. Yeah..
most TLB shootdowns on migration through hinting fault can be avoided
thanks to Huang Ying's work, commit 4d4b6d66db ("mm,unmap: avoid
flushing TLB in batch if PTE is inaccessible").

However, it's only for ones using hinting fault. I thought it'd be much
better if we have a general mechanism to reduce # of TLB flushes that
we can apply to any type of migration. I tried it only for tiering
migration for now tho.

I'm suggesting a mechanism to reduce TLB flushes by keeping source and
destination of folios participated in the migrations until all TLB
flushes required are done, only if those folios are not mapped with
write permission PTE entries at all.

I saw the number of TLB full flush reduced over 50% and the performance
a little bit improved but not that big with the workload I tested with,
XSBench. However, I believe that it would help more with other ones or
any real ones. It'd be appreciated to tell me if I'm missing something.

	Byungchul

Byungchul Park (2):
  mm/rmap: Recognize non-writable TLB entries during TLB batch flush
  mm: Defer TLB flush by keeping both src and dst folios at migration

 arch/x86/include/asm/tlbflush.h |   9 +
 arch/x86/mm/tlb.c               |  59 +++++++
 include/linux/mm.h              |  30 ++++
 include/linux/mm_types.h        |  34 ++++
 include/linux/mm_types_task.h   |   4 +-
 include/linux/mmzone.h          |   6 +
 include/linux/sched.h           |   5 +
 init/Kconfig                    |  12 ++
 mm/internal.h                   |  14 ++
 mm/memory.c                     |   9 +-
 mm/migrate.c                    | 287 +++++++++++++++++++++++++++++++-
 mm/mm_init.c                    |   1 +
 mm/page_alloc.c                 |  16 ++
 mm/rmap.c                       | 121 +++++++++++++-
 14 files changed, 595 insertions(+), 12 deletions(-)

-- 
2.17.1

