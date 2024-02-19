Return-Path: <linux-kernel+bounces-70770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B96859C02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA80CB217CB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF9D200DC;
	Mon, 19 Feb 2024 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I1wonQdM"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8BB208AB;
	Mon, 19 Feb 2024 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323924; cv=none; b=tEmUuBrV+NC0VPXQw0+7QAayMbFYeQ/FTHa+Pgdly6e7OwBobDjsakPj2lW158sGCfIm1IfU1eyzEHr5FmMJOdW6fRykYgu2PbnLQez0fzZUt82o4qBUNHqKc/WhwVDcW5RcixZDywN6XPA1Gf8ZMScAm3iuU1A95PcJdY3p0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323924; c=relaxed/simple;
	bh=GBkGqeSssY3rfVMDHVjeTpOYP6tWApp6ypuA7MLMGAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4gVWsmuHOgavHdRPcLLFVa558NlZFcnm1KwWWMPyTpwbg3zKTXgdbRxQlipZVq+fk1U723pv6U0fSekrjXBHxX2eTvInzJAWAjoipn6k7itnzWjSMt7mfWUt5rN0+3++2gySalIVEIRKzupQON6lppoW0AbbJuh7I3UztZ90wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I1wonQdM; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708323913; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4e6PzOjHu2rxoIzo+Hqu3hM9J0NeXmb2Cc/9pG/uG3s=;
	b=I1wonQdM+h64ocDGSmTO1GQcV2LMtDll0GwTLexJ6Cz+OO5jid6iV0o42xKP3EPERS4rd3cxDNBbN5tkQtTWSzFRC6uw8ZEdDnL+aX7IHOTLo+NlRCtUC41lNCOmORJ2EQ/yDxw6LLZ3JL4+QoS/2po6w3iWS7onIVXxY+Oa61U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W0p1Nty_1708323912;
Received: from 30.97.56.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0p1Nty_1708323912)
          by smtp.aliyun-inc.com;
          Mon, 19 Feb 2024 14:25:12 +0800
Message-ID: <517e58d4-7537-4d9f-8893-0130c65c3fdb@linux.alibaba.com>
Date: Mon, 19 Feb 2024 14:25:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmscan: Fix a bug calling wakeup_kswapd() with a wrong
 zone index
To: Byungchul Park <byungchul@sk.com>, akpm@linux-foundation.org,
 ying.huang@intel.com, osalvador@suse.de, hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, stable@vger.kernel.org
References: <20240216111502.79759-1-byungchul@sk.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240216111502.79759-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/16 19:15, Byungchul Park wrote:
> With numa balancing on, when a numa system is running where a numa node
> doesn't have its local memory so it has no managed zones, the following
> oops has been observed. It's because wakeup_kswapd() is called with a
> wrong zone index, -1. Fixed it by checking the index before calling
> wakeup_kswapd().
> 
>> BUG: unable to handle page fault for address: 00000000000033f3
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> PGD 0 P4D 0
>> Oops: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>     rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>> RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
>> Code: (omitted)
>> RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
>> RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
>> RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
>> R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
>> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
>> FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> PKRU: 55555554
>> Call Trace:
>>   <TASK>
>> ? __die
>> ? page_fault_oops
>> ? __pte_offset_map_lock
>> ? exc_page_fault
>> ? asm_exc_page_fault
>> ? wakeup_kswapd
>> migrate_misplaced_page
>> __handle_mm_fault
>> handle_mm_fault
>> do_user_addr_fault
>> exc_page_fault
>> asm_exc_page_fault
>> RIP: 0033:0x55b897ba0808
>> Code: (omitted)
>> RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
>> RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
>> RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
>> RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
>> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
>> R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
>>   </TASK>
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reported-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Cc: stable@vger.kernel.org
> Fixes: c574bbe917036 ("NUMA balancing: optimize page placement for memory tiering system")

This means that there is no memory on the target node？ if so, we can add 
a check at the beginning to avoid calling unnecessary 
migrate_misplaced_folio().

diff --git a/mm/memory.c b/mm/memory.c
index e95503d7544e..a64a1aac463f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5182,7 +5182,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
         else
                 last_cpupid = folio_last_cpupid(folio);
         target_nid = numa_migrate_prep(folio, vma, vmf->address, nid, 
&flags);
-       if (target_nid == NUMA_NO_NODE) {
+       if (target_nid == NUMA_NO_NODE || !node_state(target_nid, 
N_MEMORY)) {
                 folio_put(folio);
                 goto out_map;
         }

(similar changes for do_huge_pmd_numa_page())

> ---
>   mm/migrate.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fbc8586ed735..51ee6865b0f6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2825,6 +2825,14 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
>   			if (managed_zone(pgdat->node_zones + z))
>   				break;
>   		}
> +
> +		/*
> +		 * If there are no managed zones, it should not proceed
> +		 * further.
> +		 */
> +		if (z < 0)
> +			return 0;
> +
>   		wakeup_kswapd(pgdat->node_zones + z, 0,
>   			      folio_order(folio), ZONE_MOVABLE);
>   		return 0;

