Return-Path: <linux-kernel+bounces-119197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B95E88C570
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA752E78CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8DA13C3EE;
	Tue, 26 Mar 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D6AyFlaB"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA65763E6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464150; cv=none; b=m7020haf0oSj8BFMlobo26x9Own5q0pNXGN9NB3eCfyXCGimAUcADhntC3vChx/rfkALZq9b88zNej4LAEWzsVDFlOY+GJnsKTS6iy0B6sCn8gU4geBRVd2fWFJewrls3XCbvTTnnv+SeoZezvQ8bqV60YKEOQ7QucBGTVQiOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464150; c=relaxed/simple;
	bh=Z9x5S4PkGOdl4yO3ClpiUCR763MSTtKyxzVbTgvHKMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ncc7sigQNTSunmIDI6pa+L4avmBRBWj6ERSCOgrIiNso8KDAgwY6i3ykGxw4ad0NqHZuGLKqKZ4UYpla/0Z8VGMaB2Iu2fyrSJPg8vI0m+PcWoralVe1QjOgHqD3054NeIUmPgpQRa3wg1V3iQTq9OscRW+UodyBu3Ntb46c5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D6AyFlaB; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711464145; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iiM3NASvxs+xLqV7JDEjrBkpd9lxiS97pLbAzXvZAhk=;
	b=D6AyFlaB71eRFOdwRu3z9J5GzOX3mKCcA7UHG40MfGxEVdefCVh80guSrs/E+eV7aFT1AZchrOFBX3CGB/8VxVRyfBnyj034tJf5ChDC6ytmfgblf6KpHab6PvztmFcymUAIPTyx0rIiTgDhmL5wkferNp1YEAppPNWulHidldw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3Lk3Wa_1711464143;
Received: from 192.168.0.106(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3Lk3Wa_1711464143)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 22:42:24 +0800
Message-ID: <df9a644c-a007-46ac-98e3-61d4014fcfff@linux.alibaba.com>
Date: Tue, 26 Mar 2024 22:42:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm/migrate: split source folio if it is on deferred
 split list
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Yang Shi <shy828301@gmail.com>,
 Huang Ying <ying.huang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, "Yin, Fengwei" <fengwei.yin@intel.com>,
 SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org
References: <20240322193304.522496-1-zi.yan@sent.com>
 <1ecde325-097b-49e9-9f1f-d93edbc8e1f1@linux.alibaba.com>
 <8DAC0D9E-9B0D-4035-9211-2190C6F8284A@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <8DAC0D9E-9B0D-4035-9211-2190C6F8284A@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/26 21:26, Zi Yan wrote:
> On 26 Mar 2024, at 2:19, Baolin Wang wrote:
> 
>> On 2024/3/23 03:33, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> If the source folio is on deferred split list, it is likely some subpages
>>> are not used. Split it before migration to avoid migrating unused subpages.
>>>
>>> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
>>> did not check if a THP is on deferred split list before migration, thus,
>>> the destination THP is never put on deferred split list even if the source
>>> THP might be. The opportunity of reclaiming free pages in a partially
>>> mapped THP during deferred list scanning is lost, but no other harmful
>>> consequence is present[1].
>>>
>>>   From v4:
>>> 1. Simplify _deferred_list check without locking and do not count as
>>>      migration failures. (per Matthew Wilcox)
>>>
>>>   From v3:
>>> 1. Guarded deferred list code behind CONFIG_TRANSPARENT_HUGEPAGE to avoid
>>>      compilation error (per SeongJae Park).
>>>
>>>   From v2:
>>> 1. Split the source folio instead of migrating it (per Matthew Wilcox)[2].
>>>
>>>   From v1:
>>> 1. Used dst to get correct deferred split list after migration
>>>      (per Ryan Roberts).
>>>
>>> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/
>>> [2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.org/
>>>
>>> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>    mm/migrate.c | 23 +++++++++++++++++++++++
>>>    1 file changed, 23 insertions(+)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index ab9856f5931b..6bd9319624a3 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1652,6 +1652,29 @@ static int migrate_pages_batch(struct list_head *from,
>>>     			cond_resched();
>>>   +			/*
>>> +			 * The rare folio on the deferred split list should
>>> +			 * be split now. It should not count as a failure.
>>> +			 * Only check it without removing it from the list.
>>> +			 * Since the folio can be on deferred_split_scan()
>>> +			 * local list and removing it can cause the local list
>>> +			 * corruption. Folio split process below can handle it
>>> +			 * with the help of folio_ref_freeze().
>>> +			 *
>>> +			 * nr_pages > 2 is needed to avoid checking order-1
>>> +			 * page cache folios. They exist, in contrast to
>>> +			 * non-existent order-1 anonymous folios, and do not
>>> +			 * use _deferred_list.
>>> +			 */
>>> +			if (nr_pages > 2 &&
>>> +			   !list_empty(&folio->_deferred_list)) {
>>> +				if (try_split_folio(folio, from) == 0) {
>>
>> IMO, we should move the split folios into the 'split_folios' list instead of the 'from' list, otherwise there might be unhandled folios remaining in the from list.
> 
> Can you elaborate on the actual situation you are thinking about? Thanks.

Sure.

Suppose there is only one large folio in the from list that needs to be 
migrated, and this large folio is in the _deferred_list, which means it 
needs to be split. Your patch will re-add the split base pages back into 
the 'from' list. However, please see the list_for_each_entry_safe macro:

#define list_for_each_entry_safe(pos, n, head, member)			\
	for (pos = list_first_entry(head, typeof(*pos), member),	\
		n = list_next_entry(pos, member);			\
	     !list_entry_is_head(pos, head, member); 			\
	     pos = n, n = list_next_entry(n, member))

It will terminate the iteration early because the next entry 'n' taken 
out in advance is already the head, leading to the remaining split base 
pages still in the from list. This can cause the following crash when I 
did some migration testing:

[  412.576943] ------------[ cut here ]------------
[  412.576947] kernel BUG at mm/migrate.c:2634!
[  412.577132] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  412.577201] CPU: 59 PID: 9581 Comm: numa01 Kdump: loaded Tainted: G 
          E      6.9.0-rc1+ #69
.......
[  412.578651] Call Trace:
[  412.578692]  <TASK>
[  412.578730]  ? die+0x33/0x90
[  412.578770]  ? do_trap+0xdf/0x110
[  412.578815]  ? migrate_misplaced_folio+0x1f2/0x2b0
[  412.578875]  ? do_error_trap+0x65/0x80
[  412.578922]  ? migrate_misplaced_folio+0x1f2/0x2b0
[  412.578977]  ? exc_invalid_op+0x4e/0x70
[  412.579048]  ? migrate_misplaced_folio+0x1f2/0x2b0
[  412.579131]  ? asm_exc_invalid_op+0x16/0x20
[  412.579182]  ? migrate_misplaced_folio+0x1f2/0x2b0
[  412.579255]  do_numa_page+0x205/0x5b0
[  412.579305]  __handle_mm_fault+0x2b0/0x6c0
[  412.579354]  handle_mm_fault+0x105/0x270
[  412.579404]  do_user_addr_fault+0x214/0x6b0
[  412.579453]  exc_page_fault+0x64/0x140
[  412.579509]  asm_exc_page_fault+0x22/0x30

2583 int migrate_misplaced_folio(struct folio *folio, struct 
vm_area_struct *vma,
2584                             int node)
2585 {
		......

2628         if (nr_succeeded) {
2629                 count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
2630                 if (!node_is_toptier(folio_nid(folio)) && 
node_is_toptier(node))
2631                         mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
2632                                             nr_succeeded);
2633         }
2634         BUG_ON(!list_empty(&migratepages));
2635         return isolated;
2636
2637 out:

After changing as below, the system crash issue is gone.

+++ b/mm/migrate.c
@@ -1668,7 +1668,7 @@ static int migrate_pages_batch(struct list_head *from,
                          */
                         if (nr_pages > 2 &&
                            !list_empty(&folio->_deferred_list)) {
-                               if (try_split_folio(folio, from) == 0) {
+                               if (try_split_folio(folio, split_folios) 
== 0) {
                                         stats->nr_thp_split += is_thp;
                                         stats->nr_split++;
                                         continue;

