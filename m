Return-Path: <linux-kernel+bounces-72346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E612085B246
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDAF1C22266
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A005256B90;
	Tue, 20 Feb 2024 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6Rwf6xi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3929C56B6E;
	Tue, 20 Feb 2024 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407117; cv=none; b=RlYOTtVuPamujDOkpZVlRqGALZ+FkuJ3nKmjXW9XW/i/L1EEAgqcw+6zIPk8glacZGaPoGmXj3Z9WvoTdPp5JyAxseWJ//j+6nmbBc7JhIQvZ6yju3SR1Y6ClKodFP3Yabb74PerCUlhZuPhw8hq5ZeSEGNlJWQ9MCSBEpHEzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407117; c=relaxed/simple;
	bh=SqVTf6G26lQVP2Kos51dRn5WI0uPk9WrsIkm1pz1Gow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZqt+s5xSf8wYn20bAJsmOhLiG9hmEqE+ZT03pPff+JZxhByV/5/pNzf8vElGtWTGnVcrNZlr4bHh157nJxP+FLyHq8QdEPTudyRKCwvdj4fahSE5FVGBUmAmtnl/bbN++di1UMEkYBHGkd+OMqh8nb/HAME16QDq71OWhBY1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6Rwf6xi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708407116; x=1739943116;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SqVTf6G26lQVP2Kos51dRn5WI0uPk9WrsIkm1pz1Gow=;
  b=c6Rwf6xi57KxKO17r0cL2ixv3thBrBFqphA9u6QJDoKk+hZW4cgjJXHC
   aHe0UQjNTJ0k/IHajGeNd6P6u/cVuj+xq5NOFUajRbsNKMk0/pdNQ+SJm
   HFoNhG3TLDAwicNxEmNll36xAfnQTk0YH93A1DeVM8HJ9mcUlnCUXqeWp
   32NIebQUps6sgLB5hMWWx8/isfNZlLp24MIcrfzJow8L/my8MleiQL8dg
   5md5XdCXEhsUUB6smuUK4iTopcMeehKCYdsg+NoeTZp/IwUGrN0W46ZqJ
   1LWQZeJmmh5l//3vgwCqMXooPC/93EK9B0mS7wVrJ/NjZkGMSyiOWsqD+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2636760"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2636760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 21:31:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="4964130"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 21:31:52 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: <akpm@linux-foundation.org>,  <osalvador@suse.de>,
  <baolin.wang@linux.alibaba.com>,  <hannes@cmpxchg.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <kernel_team@skhynix.com>,  <stable@vger.kernel.org>
Subject: Re: [PATCH] mm/vmscan: Fix a bug calling wakeup_kswapd() with a
 wrong zone index
In-Reply-To: <20240220040306.GI65758@system.software.com> (Byungchul Park's
	message of "Tue, 20 Feb 2024 13:03:06 +0900")
References: <20240216111502.79759-1-byungchul@sk.com>
	<871q97rec8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240220040306.GI65758@system.software.com>
Date: Tue, 20 Feb 2024 13:29:56 +0800
Message-ID: <87wmqzpusr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> On Tue, Feb 20, 2024 at 11:42:31AM +0800, Huang, Ying wrote:
>> Byungchul Park <byungchul@sk.com> writes:
>> 
>> > With numa balancing on, when a numa system is running where a numa node
>> > doesn't have its local memory so it has no managed zones, the following
>> > oops has been observed. It's because wakeup_kswapd() is called with a
>> > wrong zone index, -1. Fixed it by checking the index before calling
>> > wakeup_kswapd().
>> >
>> >> BUG: unable to handle page fault for address: 00000000000033f3
>> >> #PF: supervisor read access in kernel mode
>> >> #PF: error_code(0x0000) - not-present page
>> >> PGD 0 P4D 0
>> >> Oops: 0000 [#1] PREEMPT SMP NOPTI
>> >> CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
>> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> >>    rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>> >> RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
>> >> Code: (omitted)
>> >> RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
>> >> RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
>> >> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
>> >> RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
>> >> R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
>> >> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
>> >> FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
>> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >> CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
>> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> >> PKRU: 55555554
>> >> Call Trace:
>> >>  <TASK>
>> >> ? __die
>> >> ? page_fault_oops
>> >> ? __pte_offset_map_lock
>> >> ? exc_page_fault
>> >> ? asm_exc_page_fault
>> >> ? wakeup_kswapd
>> >> migrate_misplaced_page
>> >> __handle_mm_fault
>> >> handle_mm_fault
>> >> do_user_addr_fault
>> >> exc_page_fault
>> >> asm_exc_page_fault
>> >> RIP: 0033:0x55b897ba0808
>> >> Code: (omitted)
>> >> RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
>> >> RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
>> >> RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
>> >> RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
>> >> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
>> >> R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
>> >>  </TASK>
>> >
>> > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> > Reported-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
>> > Cc: stable@vger.kernel.org
>> > Fixes: c574bbe917036 ("NUMA balancing: optimize page placement for memory tiering system")
>> > ---
>> >  mm/migrate.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/mm/migrate.c b/mm/migrate.c
>> > index fbc8586ed735..51ee6865b0f6 100644
>> > --- a/mm/migrate.c
>> > +++ b/mm/migrate.c
>> > @@ -2825,6 +2825,14 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
>> >  			if (managed_zone(pgdat->node_zones + z))
>> >  				break;
>> >  		}
>> > +
>> > +		/*
>> > +		 * If there are no managed zones, it should not proceed
>> > +		 * further.
>> > +		 */
>> > +		if (z < 0)
>> > +			return 0;
>> > +
>> 
>> I think that it's better to check pgdat->nr_zones directly earlier in
>> the function.  That is a little easier to be understood.
>
> No. No matter what the value of ->nr_zones is, the oops is going to
> happen if there are no managed zones by any reason.

Yes.  You are right.  Sorry for noise.

--
Best Regards,
Huang, Ying

> 	Byungchul
>
>> >  		wakeup_kswapd(pgdat->node_zones + z, 0,
>> >  			      folio_order(folio), ZONE_MOVABLE);
>> >  		return 0;
>> 
>> --
>> Best Regards,
>> Huang, Ying

