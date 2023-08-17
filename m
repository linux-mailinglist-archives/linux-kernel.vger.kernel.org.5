Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0377077F1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348761AbjHQIJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348742AbjHQIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:09:05 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E77582701
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:08:58 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-c3-64ddd598cf3a
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Subject: [RFC v2 0/6] Reduce TLB flushes under some specific conditions
Date:   Thu, 17 Aug 2023 17:05:53 +0900
Message-Id: <20230817080559.43200-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsXC9ZZnke6Mq3dTDC4cULWYs34Nm8WLDe2M
        Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsru96yGhxvPcAk8XvH0DZOVOsLE7O
        msziwOuxYFOpx+YVWh6L97xk8ti0qpPNY9OnSeweJ2b8ZvHY+dDSY97JQI/3+66yeWz9Zefx
        eZOcx7v5b9kCeKK4bFJSczLLUov07RK4Mjac+MpY8EesYtHO7awNjB8Fuhg5OSQETCQe7NnF
        DmPv3f6VGcRmE1CXuHHjJ5gtImAmcbD1D1ANFwezwDImibsHzrGCJIQF3CV2LpzK1MXIwcEi
        oCoxraMSJMwrYCrxbdZJqJnyEqs3HGAG6ZUQ2MEm0fnuPlRCUuLgihssExi5FzAyrGIUyswr
        y03MzDHRy6jMy6zQS87P3cQIDMpltX+idzB+uhB8iFGAg1GJh9dh150UIdbEsuLK3EOMEhzM
        SiK8Pby3UoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUw
        Or7sXRjeliNVaW7BvcVq9kmJUuFc2bt5V+pK5WVNezsSZ95vWfCp0fnW1qd5MpIVugwnduTF
        vMsJTA+6tSJ70wWBI7+2JAp+nK6u6x2cOId381PPm/JqPDscp/9zmmHzds3DsxJcKudm1NqU
        JDUxCq6Yk3dgt9se6dsN7vuTf25lXC8nunOrEktxRqKhFnNRcSIA8i1n7UYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsXC5WfdrDvj6t0Ug923JS3mrF/DZvFiQzuj
        xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlc3/WQ0eJ47wEmi98/gLJz
        plhZnJw1mcWBz2PBplKPzSu0PBbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXHvJOBHu/3XWXz
        WPziA5PH1l92Hp83yXm8m/+WLYA3issmJTUnsyy1SN8ugStjw4mvjAV/xCoW7dzO2sD4UaCL
        kZNDQsBEYu/2r8wgNpuAusSNGz/BbBEBM4mDrX/Yuxi5OJgFljFJ3D1wjhUkISzgLrFz4VSm
        LkYODhYBVYlpHZUgYV4BU4lvs06yQ8yUl1i94QDzBEaOBYwMqxhFMvPKchMzc0z1irMzKvMy
        K/SS83M3MQJDbFntn4k7GL9cdj/EKMDBqMTD67DrTooQa2JZcWXuIUYJDmYlEd4e3lspQrwp
        iZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYyOUeK3Sx/q1IRY
        lWc4fz6z8MgE1s1XZ1U28fjO67ooyS0RlzfLagOXP0//w2ufpkfMr+4qf/Z3xt7O+YYzWO71
        bj5YHHZCqfovX0eJWrnXtzJlZheR7E3hjfJL3O+tfphoIhfQ3bXFK+xD23/jz+ueHl2qcW6l
        pe4rlq86lhFbVnrXB07X8VRiKc5INNRiLipOBADFyewTLQIAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While I'm working with CXL memory, I have been facing migraion overhead
esp. TLB shootdown on promotion or demotion between different tiers.
Yeah.. most TLB shootdowns on migration through hinting fault can be
avoided thanks to Huang Ying's work, commit 4d4b6d66db ("mm,unmap: avoid
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

---

Changes from RFC:

	1. Fix a bug triggered when a destination folio at the previous
	   migration becomes a source folio at the next migration,
	   before the folio gets handled properly so that the folio can
	   play with another migration. There was inconsistency in the
	   folio's state. Fixed it.

	2. Split the patch set into more pieces so that the folks can
	   review better. (Feedbacked by Nadav Amit)

	3. Fix a wrong usage of barrier e.g. smp_mb__after_atomic().
	   (Feedbacked by Nadav Amit)

	4. Tried to add sufficient comments to explain the patch set
	   better. (Feedbacked by Nadav Amit)

Byungchul Park (6):
  mm/rmap: Recognize non-writable TLB entries during TLB batch flush
  mm: Defer TLB flush by keeping both src and dst folios at migration
  mm, migrc: Skip TLB flushes at the CPUs that already have been done
  mm, migrc: Ajust __zone_watermark_ok() with the amount of pending
    folios
  mm, migrc: Add a sysctl knob to enable/disable MIGRC mechanism
  mm, migrc: Implement internal allocator to minimize impact onto vm

 arch/x86/include/asm/tlbflush.h |   9 +
 arch/x86/mm/tlb.c               |  67 ++++++
 include/linux/mm.h              |  30 +++
 include/linux/mm_types.h        |  47 ++++
 include/linux/mm_types_task.h   |   4 +-
 include/linux/mmzone.h          |   6 +
 include/linux/sched.h           |   5 +
 init/Kconfig                    |  13 ++
 mm/internal.h                   |  14 ++
 mm/memory.c                     |  17 +-
 mm/migrate.c                    | 381 +++++++++++++++++++++++++++++++-
 mm/mm_init.c                    |   1 +
 mm/page_alloc.c                 |  19 ++
 mm/rmap.c                       | 133 ++++++++++-
 14 files changed, 734 insertions(+), 12 deletions(-)

-- 
2.17.1

