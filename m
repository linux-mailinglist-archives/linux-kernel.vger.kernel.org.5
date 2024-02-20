Return-Path: <linux-kernel+bounces-72304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056B185B1CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7172282B28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF5653E3B;
	Tue, 20 Feb 2024 04:03:20 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7DC52F68;
	Tue, 20 Feb 2024 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401800; cv=none; b=KTzHjWIQw6IZInMT7+tf3pxozRsi6wOwGipaYOMY4TDclEiCyy/bj3zlgg6gCWa76NxF/3w0If2rq5gPxV29ulhVzNiQpArcqTe1+CeXCt1PEBW461RRoeXyK6+Uyb6rheFiP/UptescPdIGKSBaUKufOxwpAlC0zWztVICL1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401800; c=relaxed/simple;
	bh=8Q8ga5qF52jke2YKkP3E6vPsby0Wz8W15NX8pjBlS/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjwsLXZR0qGDMvlRlPykO/9kxcyf7pvOFXbHn9or/O4J3vJMz532EslTo7L7dfEJP8KpPGL1JDPi1MeFejeLsmJk/+w/zVOZwtkAC9BZsa1E8R6FQjdB4EM50ZhOJ4mob/qb5HgjGiIKikSrMuD5tiTzsaLuNWrZ3EXYX700gl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-c0-65d4247f8241
Date: Tue, 20 Feb 2024 13:03:06 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, osalvador@suse.de,
	baolin.wang@linux.alibaba.com, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: Fix a bug calling wakeup_kswapd() with a
 wrong zone index
Message-ID: <20240220040306.GI65758@system.software.com>
References: <20240216111502.79759-1-byungchul@sk.com>
 <871q97rec8.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q97rec8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXC9ZZnkW69ypVUg4k9ZhZz1q9hs/i/9xij
	xepNvhaXd81hs7i35j+rxZlpRRYLNj5itDg5azKLA4fH4TfvmT0W73nJ5LHp0yR2jxMzfrN4
	7Hxo6bH5dLXH501yAexRXDYpqTmZZalF+nYJXBnd0+YxFqyTrdjzexd7A+MT8S5GTg4JAROJ
	jnX72GHsm/3zmEBsFgFViZ5/i9lAbDYBdYkbN34yg9giAhoSnxYuB6rn4mAWOMMosWr2elaQ
	hLBAtMTjd3PBBvEKWEg8n9nDAmILCWRKdE7tYIOIC0qcnPkELM4soCVx499LoGUcQLa0xPJ/
	HCBhTgE7iWPfnoPtEhVQljiw7TgTyC4JgQNsEve+LmCEOFRS4uCKGywTGAVmIRk7C8nYWQhj
	FzAyr2IUyswry03MzDHRy6jMy6zQS87P3cQIDPlltX+idzB+uhB8iFGAg1GJh/dB3OVUIdbE
	suLK3EOMEhzMSiK87k0XUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1I
	LYLJMnFwSjUwrniUetTU7fEdrjiprdVHPH5J1O5omTKFy3Ri5l8Vl3UfexeWaJrv2nrpnmTM
	5Xth823rwrJ1jwgy2QSLHD3UVnUo+sOp+8t8ZO17qxLsXJNO8yh/3ySds6a1+JuB2beK96re
	hz79Y7U8NbuEW0qZ7e57NYF7gnMFkl6LGx1TePuq8Ft2V0iJEktxRqKhFnNRcSIATAjaAXUC
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXC5WfdrFuvciXVYOtbNYs569ewWfzfe4zR
	YvUmX4vDc0+yWlzeNYfN4t6a/6wWZ6YVWSzY+IjR4uSsySwOnB6H37xn9li85yWTx6ZPk9g9
	Tsz4zeKx86Glx+IXH5g8Np+u9vi8SS6AI4rLJiU1J7MstUjfLoEro3vaPMaCdbIVe37vYm9g
	fCLexcjJISFgInGzfx4TiM0ioCrR828xG4jNJqAucePGT2YQW0RAQ+LTwuXsXYxcHMwCZxgl
	Vs1ezwqSEBaIlnj8bi47iM0rYCHxfGYPC4gtJJAp0Tm1gw0iLihxcuYTsDizgJbEjX8vgZZx
	ANnSEsv/cYCEOQXsJI59ew62S1RAWeLAtuNMExh5ZyHpnoWkexZC9wJG5lWMIpl5ZbmJmTmm
	esXZGZV5mRV6yfm5mxiBAbys9s/EHYxfLrsfYhTgYFTi4X0QdzlViDWxrLgy9xCjBAezkgiv
	e9OFVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbG+0+d
	L/44dC2sbstlg89Np1ZVlSoe2lrHbWS3aX3qX+64TKE54ivL702rk3mzrkqml0NXymy+Zbvp
	DL/TTlqbL0umhK9p+3g1+74Xp5v1GQ+euTYT1/+u/DTVYtvKc1f3+Qc2xd+55mW7TMzu1+yA
	grraeRcb6iN5dT2Szp6LP6xaVq2itTpViaU4I9FQi7moOBEAq2C0/1wCAAA=
X-CFilter-Loop: Reflected

On Tue, Feb 20, 2024 at 11:42:31AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > With numa balancing on, when a numa system is running where a numa node
> > doesn't have its local memory so it has no managed zones, the following
> > oops has been observed. It's because wakeup_kswapd() is called with a
> > wrong zone index, -1. Fixed it by checking the index before calling
> > wakeup_kswapd().
> >
> >> BUG: unable to handle page fault for address: 00000000000033f3
> >> #PF: supervisor read access in kernel mode
> >> #PF: error_code(0x0000) - not-present page
> >> PGD 0 P4D 0
> >> Oops: 0000 [#1] PREEMPT SMP NOPTI
> >> CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >>    rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> >> RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> >> Code: (omitted)
> >> RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> >> RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> >> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> >> RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> >> R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> >> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> >> FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> PKRU: 55555554
> >> Call Trace:
> >>  <TASK>
> >> ? __die
> >> ? page_fault_oops
> >> ? __pte_offset_map_lock
> >> ? exc_page_fault
> >> ? asm_exc_page_fault
> >> ? wakeup_kswapd
> >> migrate_misplaced_page
> >> __handle_mm_fault
> >> handle_mm_fault
> >> do_user_addr_fault
> >> exc_page_fault
> >> asm_exc_page_fault
> >> RIP: 0033:0x55b897ba0808
> >> Code: (omitted)
> >> RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
> >> RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
> >> RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
> >> RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
> >> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> >> R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
> >>  </TASK>
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Reported-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> > Cc: stable@vger.kernel.org
> > Fixes: c574bbe917036 ("NUMA balancing: optimize page placement for memory tiering system")
> > ---
> >  mm/migrate.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index fbc8586ed735..51ee6865b0f6 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2825,6 +2825,14 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
> >  			if (managed_zone(pgdat->node_zones + z))
> >  				break;
> >  		}
> > +
> > +		/*
> > +		 * If there are no managed zones, it should not proceed
> > +		 * further.
> > +		 */
> > +		if (z < 0)
> > +			return 0;
> > +
> 
> I think that it's better to check pgdat->nr_zones directly earlier in
> the function.  That is a little easier to be understood.

No. No matter what the value of ->nr_zones is, the oops is going to
happen if there are no managed zones by any reason.

	Byungchul

> >  		wakeup_kswapd(pgdat->node_zones + z, 0,
> >  			      folio_order(folio), ZONE_MOVABLE);
> >  		return 0;
> 
> --
> Best Regards,
> Huang, Ying

