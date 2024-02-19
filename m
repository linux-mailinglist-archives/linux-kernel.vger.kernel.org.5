Return-Path: <linux-kernel+bounces-70775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2253D859C39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821A4B219E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D244F20311;
	Mon, 19 Feb 2024 06:31:54 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33CCC8D6;
	Mon, 19 Feb 2024 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324314; cv=none; b=X2Z73egUxlRtdn2O43tNy25egKHcj7048mfOH2yw2Nv7JZAcQNMj6AsAg8RlnG1cex2PpK0oY7NW5qBDWJdcqBXiuhRKJjEVoIXR949iNPGSavu0DXbvmrrgWRQZebMbsZdUL5Nc3n5GV3OsXPJVAeHbrfsPSIVntbzDmgGNeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324314; c=relaxed/simple;
	bh=91NOP5Yp+kybDII8B13JhN5jlngmLDDGZh5KNhSRyKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkImWsbhD67dSAhU6ojSNuPq/Zdt2D55U7CPmtaflnGPWGLmDwFY1pAwYgDlBLmgegv62KWfnBLfwgdv+vgSj65OzrkfXJ9ywMFGUju97QQtTy6cm47Qc0Wp3R21P2DVT1xS4AZSBBitSWsGmfwFz+dM04ZgLcQgdXUEgdQJgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-01-65d2f5d0f14a
Date: Mon, 19 Feb 2024 15:31:39 +0900
From: Byungchul Park <byungchul@sk.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, ying.huang@intel.com, osalvador@suse.de,
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: Fix a bug calling wakeup_kswapd() with a
 wrong zone index
Message-ID: <20240219063139.GC65758@system.software.com>
References: <20240216111502.79759-1-byungchul@sk.com>
 <517e58d4-7537-4d9f-8893-0130c65c3fdb@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <517e58d4-7537-4d9f-8893-0130c65c3fdb@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsXC9ZZnoe6Fr5dSDd6vNLSYs34Nm8X/vccY
	LVZv8rW4vGsOm8W9Nf9ZLc5MK7JYsPERo8XJWZNZHDg8Dr95z+yxeM9LJo9Nnyaxe5yY8ZvF
	Y+dDS4/Np6s9Pm+SC2CP4rJJSc3JLEst0rdL4Mp40nyJteC5ckXnvXVsDYybZLoYOTkkBEwk
	9hz6x9jFyAFm33mmDGKyCKhKXNzmC1LBJqAucePGT2aQsIiAvkTvXLAws8BBRolDL2xAbGGB
	aInH7+ayg9i8AhYST3Y+ZAaxhQQKJI5OvgEVF5Q4OfMJC0SvusSfeZfARjILSEss/8cBEZaX
	aN46G6yVU8BV4tjqp0wgtqiAssSBbceBbC6gG4+wSUz8cJkJ4nhJiYMrbrBMYBSchWTFLCQr
	ZiGsmIVkxQJGllWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgbGxrPZP9A7GTxeCDzEKcDAq8fBm
	iFxKFWJNLCuuzD3EKMHBrCTC6950IVWINyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTE
	ktTs1NSC1CKYLBMHp1QDo0nLiwqb983M88o1+Rdu/pKtqzmVf96Uq19unbRZEvJVx2W7rom/
	u0PrA5M9i4Vd4wq7TobOm7OCa+3GOsX+YyaFi85ur7nq8SKwZ8Hn2t1fzCM6y3SE+2tbrqfn
	1KXky1ncrYmsjJP/nqPsmKP/82762uWJ8tn8L6wzD579zb3n5rXjpjZhSizFGYmGWsxFxYkA
	mpFoV4kCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXC5WfdrHvh66VUg96XKhZz1q9hs/i/9xij
	xepNvhaH555ktbi8aw6bxb01/1ktzkwrsliw8RGjxclZk1kcOD0Ov3nP7LF4z0smj02fJrF7
	nJjxm8Vj50NLj8UvPjB5bD5d7fF5k1wARxSXTUpqTmZZapG+XQJXxpPmS6wFz5UrOu+tY2tg
	3CTTxcjBISFgInHnmTKIySKgKnFxm28XIycHm4C6xI0bP5lBwiIC+hK9c8HCzAIHGSUOvbAB
	sYUFoiUev5vLDmLzClhIPNn5kBnEFhIokDg6+QZUXFDi5MwnLBC96hJ/5l0CG8ksIC2x/B8H
	RFheonnrbLBWTgFXiWOrnzKB2KICyhIHth1nmsDINwvJpFlIJs1CmDQLyaQFjCyrGEUy88py
	EzNzTPWKszMq8zIr9JLzczcxAgN9We2fiTsYv1x2P8QowMGoxMObIXIpVYg1say4MvcQowQH
	s5IIr3vThVQh3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkG
	xkTt/r2ffZq/fAgscyqd4eIywZjz2ed8VTGLu1e9d58XvR14Od9SayvnMt0JwUcyrwbocUld
	vHSy49Pp2pLVs9lFPn7NTvz+K6jz/SrRZCvD9oPt81feXu9nOG2RZMgPu9rkbRc28D23CtaM
	2mG1plyRc9qU8rfb++QluOvCzsk5Fi/LUrt9VomlOCPRUIu5qDgRACBOvv5wAgAA
X-CFilter-Loop: Reflected

On Mon, Feb 19, 2024 at 02:25:11PM +0800, Baolin Wang wrote:
> 
> 
> On 2024/2/16 19:15, Byungchul Park wrote:
> > With numa balancing on, when a numa system is running where a numa node
> > doesn't have its local memory so it has no managed zones, the following
> > oops has been observed. It's because wakeup_kswapd() is called with a
> > wrong zone index, -1. Fixed it by checking the index before calling
> > wakeup_kswapd().
> > 
> > > BUG: unable to handle page fault for address: 00000000000033f3
> > > #PF: supervisor read access in kernel mode
> > > #PF: error_code(0x0000) - not-present page
> > > PGD 0 P4D 0
> > > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > >     rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> > > Code: (omitted)
> > > RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> > > RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> > > RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> > > R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> > > R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> > > FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > PKRU: 55555554
> > > Call Trace:
> > >   <TASK>
> > > ? __die
> > > ? page_fault_oops
> > > ? __pte_offset_map_lock
> > > ? exc_page_fault
> > > ? asm_exc_page_fault
> > > ? wakeup_kswapd
> > > migrate_misplaced_page
> > > __handle_mm_fault
> > > handle_mm_fault
> > > do_user_addr_fault
> > > exc_page_fault
> > > asm_exc_page_fault
> > > RIP: 0033:0x55b897ba0808
> > > Code: (omitted)
> > > RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
> > > RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
> > > RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
> > > RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
> > > R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> > > R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
> > >   </TASK>
> > 
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Reported-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> > Cc: stable@vger.kernel.org
> > Fixes: c574bbe917036 ("NUMA balancing: optimize page placement for memory tiering system")
> 
> This means that there is no memory on the target node？ if so, we can add a
> check at the beginning to avoid calling unnecessary
> migrate_misplaced_folio().

Right. However, the check is necessary no matter where it comes from.
FYI, the fix is going on in another thread:

https://lore.kernel.org/lkml/20240216114045.24828-1-byungchul@sk.com/
https://lore.kernel.org/lkml/20240219041920.1183-1-byungchul@sk.com/

	Byungchul

> diff --git a/mm/memory.c b/mm/memory.c
> index e95503d7544e..a64a1aac463f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5182,7 +5182,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>         else
>                 last_cpupid = folio_last_cpupid(folio);
>         target_nid = numa_migrate_prep(folio, vma, vmf->address, nid,
> &flags);
> -       if (target_nid == NUMA_NO_NODE) {
> +       if (target_nid == NUMA_NO_NODE || !node_state(target_nid, N_MEMORY))
> {
>                 folio_put(folio);
>                 goto out_map;
>         }
> 
> (similar changes for do_huge_pmd_numa_page())
> 
> > ---
> >   mm/migrate.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index fbc8586ed735..51ee6865b0f6 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2825,6 +2825,14 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
> >   			if (managed_zone(pgdat->node_zones + z))
> >   				break;
> >   		}
> > +
> > +		/*
> > +		 * If there are no managed zones, it should not proceed
> > +		 * further.
> > +		 */
> > +		if (z < 0)
> > +			return 0;
> > +
> >   		wakeup_kswapd(pgdat->node_zones + z, 0,
> >   			      folio_order(folio), ZONE_MOVABLE);
> >   		return 0;

