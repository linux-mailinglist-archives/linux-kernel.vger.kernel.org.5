Return-Path: <linux-kernel+bounces-72282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B83DF85B196
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB201F22189
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A024CE00;
	Tue, 20 Feb 2024 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+QUW2nZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12145942;
	Tue, 20 Feb 2024 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400675; cv=none; b=SdxcNUIb4JYNmEAXKi4Y50JnLZhH46Bhg6ywcI5O+X7nD7a5wiYR0qUNIBwp/XEkxdWv/yXUKSZOvEFBSwkW6IqHyiC+FsRvj0vNlkjyQz/UDYsYu27hZkwj+LiPQbopfuka2QcOg8DEcwBD84yMn8TlvY5ek77nft2rINqs2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400675; c=relaxed/simple;
	bh=s0pIo5DSPJMtUCiPNiZk1cDWJiQ2gwkCboeixgJnEIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wm6g5efrg201u+mb24skXUpPK8w8It0lhwiswgrv1h17BMkYW4uo2XNV16PQ5rIcQtKIw0GRIyxwIbMUaHo/i+qb+UDjYaFRatYCkDWz7Kl4CPgpW0dIW6mFlA0Y4C81Xa1WICxzpF8mAKxPKjd60DgeOO7mgFOmCBp6kuXUxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+QUW2nZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708400673; x=1739936673;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=s0pIo5DSPJMtUCiPNiZk1cDWJiQ2gwkCboeixgJnEIo=;
  b=i+QUW2nZdtSaMAHrPQ/xc9/I89aB3HiajWCT9eklj1n0G52/tBh5HK72
   fULmEeBnfMrt5rz86xlHqOtR5dGTW+HyWIeduTpG/PkjLKkwB3w+R5RoA
   /ymjnU9HFzBvE/m5HEx1OnFyRCalFiAxHaPSVoWpmrS8wmkUN9TRbIHyq
   wD5wn9CdnWDCHbmBJn03ZyHh5Nk6aeMEs+k7Zh2n8Dd9xLBtZrsbAjc8t
   44xIWIZvyn0Dve3os4bRkF3HgBi90JPWEh4H9d51pQEAY7BTKRDYIsUnP
   1LSCA8TevBkyAYNIgQmshJ3FhwryywW0Q5xR/7TS3spB8Nuyv0PmJAljZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2363954"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2363954"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 19:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="4949946"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 19:44:28 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: <akpm@linux-foundation.org>,  <osalvador@suse.de>,
  <baolin.wang@linux.alibaba.com>,  <hannes@cmpxchg.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <kernel_team@skhynix.com>,  <stable@vger.kernel.org>
Subject: Re: [PATCH] mm/vmscan: Fix a bug calling wakeup_kswapd() with a
 wrong zone index
In-Reply-To: <20240216111502.79759-1-byungchul@sk.com> (Byungchul Park's
	message of "Fri, 16 Feb 2024 20:15:02 +0900")
References: <20240216111502.79759-1-byungchul@sk.com>
Date: Tue, 20 Feb 2024 11:42:31 +0800
Message-ID: <871q97rec8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

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
>>    rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
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
>>  <TASK>
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
>>  </TASK>
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reported-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Cc: stable@vger.kernel.org
> Fixes: c574bbe917036 ("NUMA balancing: optimize page placement for memory tiering system")
> ---
>  mm/migrate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fbc8586ed735..51ee6865b0f6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2825,6 +2825,14 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
>  			if (managed_zone(pgdat->node_zones + z))
>  				break;
>  		}
> +
> +		/*
> +		 * If there are no managed zones, it should not proceed
> +		 * further.
> +		 */
> +		if (z < 0)
> +			return 0;
> +

I think that it's better to check pgdat->nr_zones directly earlier in
the function.  That is a little easier to be understood.

>  		wakeup_kswapd(pgdat->node_zones + z, 0,
>  			      folio_order(folio), ZONE_MOVABLE);
>  		return 0;

--
Best Regards,
Huang, Ying

