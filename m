Return-Path: <linux-kernel+bounces-93492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB12B873096
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4814F1F222D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483055D486;
	Wed,  6 Mar 2024 08:23:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6945CDE8;
	Wed,  6 Mar 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713389; cv=none; b=QhYN2OibuI4UoCLXRQOSxyQ48bD/gvE4eDvDaUagAWsHztJtwayOkYeNYgtvb8EhA6rvdu+CnViKFXl5+CGLnDW21oi9HTVnz+IIaOoaip63n1gDXmB1D2KeZKXQtcX9r2Zhm83K/CBUa5EzyIrB2Ho3LYX9FYOMEUpbrmj9i1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713389; c=relaxed/simple;
	bh=Y/6fBjZoaBPlXaXY9NgypvZz401Af4r3ftZnTux/eS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFG1iwaHnG/Aod/Ff8Qb2ot/4Egi3YE9zad1k/uuXkUXKscicJMt5YInvT1mo3rQm0rvHaaXXt5c6743ml2jtRAeK4D8aMcsfDpJ+RnENdtnsgJw+X17mJ6hQkpPfBmGAmu5nl+ktIW/mvnD2gz9wulnYi8dZCDVFNDRAZu5cNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AC331FB;
	Wed,  6 Mar 2024 00:23:43 -0800 (PST)
Received: from [10.57.68.241] (unknown [10.57.68.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 044B93F762;
	Wed,  6 Mar 2024 00:23:04 -0800 (PST)
Message-ID: <50e0ebda-b1e9-4bfa-9877-967e6b8cd4c2@arm.com>
Date: Wed, 6 Mar 2024 08:23:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
Content-Language: en-GB
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
 <20240306021950.GA801254@cmpxchg.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240306021950.GA801254@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2024 02:19, Johannes Weiner wrote:
> Hi Ryan,
> 
> On Tue, Mar 05, 2024 at 03:13:49PM +0000, Ryan Roberts wrote:
>> There was previously a theoretical window where swapoff() could run and
>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>> running in another thread. This could cause, amongst other bad
>> possibilities, swap_page_trans_huge_swapped() (called by
>> free_swap_and_cache()) to access the freed memory for swap_map.
>>
>> This is a theoretical problem and I haven't been able to provoke it from
>> a test case. But there has been agreement based on code review that this
>> is possible (see link below).
>>
>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>> the swap entry was valid. This wasn't present in get_swap_device() so
>> I've added it. I couldn't find any existing get_swap_device() call sites
>> where this extra check would cause any false alarms.
> 
> Unfortunately, I found one, testing current mm-everything:
> 
> [  189.420777] get_swap_device: Unused swap offset entry 000641ae
> [  189.426648] ------------[ cut here ]------------
> [  189.431290] WARNING: CPU: 3 PID: 369 at mm/swapfile.c:1301 get_swap_device+0x2da/0x3f0
> [  189.439242] CPU: 3 PID: 369 Comm: cachish Not tainted 6.8.0-rc5-00527-g19d98776f227-dirty #30
> [  189.447791] Hardware name: Micro-Star International Co., Ltd. MS-7B98/Z390-A PRO (MS-7B98), BIOS 1.80 12/25/2019
> [  189.457998] RIP: 0010:get_swap_device+0x2da/0x3f0
> [  189.462721] Code: a8 03 75 2a 65 48 ff 08 e9 36 ff ff ff 4c 89 e9 48 c7 c2 40 fd 91 83 48 c7 c6 c0 f9 91 83 48 c7 c7 60 ee 91 83 e8 26 2f af ff <0f> 0b eb af 4c 8d 6b 08 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48
> [  189.481497] RSP: 0000:ffffc90000cff8a8 EFLAGS: 00010282
> [  189.486760] RAX: 0000000000000032 RBX: ffff8881262eee00 RCX: 0000000000000000
> [  189.493909] RDX: 0000000000000001 RSI: ffffffff83a1e620 RDI: 0000000000000001
> [  189.501054] RBP: 1ffff9200019ff15 R08: 0000000000000001 R09: fffff5200019fee1
> [  189.508202] R10: ffffc90000cff70f R11: 0000000000000001 R12: ffffc900018d51ae
> [  189.515346] R13: 00000000000641ae R14: 0000000000000000 R15: 00000000000641af
> [  189.522494] FS:  00007f7120263680(0000) GS:ffff88841c380000(0000) knlGS:0000000000000000
> [  189.530591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  189.536373] CR2: 00007f6e659a2ea3 CR3: 0000000046860004 CR4: 00000000003706f0
> [  189.543516] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  189.550661] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  189.557811] Call Trace:
> [  189.560276]  <TASK>
> [  189.562393]  ? __warn+0xc4/0x250
> [  189.565647]  ? get_swap_device+0x2da/0x3f0
> [  189.569761]  ? report_bug+0x348/0x440
> [  189.573444]  ? handle_bug+0x6d/0x90
> [  189.576951]  ? exc_invalid_op+0x13/0x40
> [  189.580810]  ? asm_exc_invalid_op+0x16/0x20
> [  189.585019]  ? get_swap_device+0x2da/0x3f0
> [  189.589142]  ? get_swap_device+0x2da/0x3f0
> [  189.593255]  ? __pfx_get_swap_device+0x10/0x10
> [  189.597717]  __read_swap_cache_async+0x9f/0x630
> [  189.602281]  ? __pfx___read_swap_cache_async+0x10/0x10
> [  189.607439]  ? __mod_memcg_lruvec_state+0x238/0x4f0
> [  189.612344]  ? __pfx_swp_swap_info+0x10/0x10
> [  189.616652]  swap_cluster_readahead+0x2cd/0x510
> [  189.621206]  ? __pfx_swap_cluster_readahead+0x10/0x10
> [  189.626279]  ? swap_cache_get_folio+0xcd/0x360
> [  189.630760]  ? __count_memcg_events+0x10a/0x370
> [  189.635318]  shmem_swapin_folio+0x2f2/0xc60
> [  189.639525]  ? __pfx__raw_spin_lock+0x10/0x10
> [  189.643908]  ? __pte_offset_map+0x19/0x1d0
> [  189.648024]  shmem_get_folio_gfp+0x307/0xe30
> [  189.652323]  ? __schedule+0x9f0/0x1fe0
> [  189.656096]  ? __pfx_shmem_get_folio_gfp+0x10/0x10
> [  189.660923]  ? filemap_map_pages+0x999/0xe60
> [  189.665211]  shmem_fault+0x1d9/0x810
> [  189.668834]  ? __pfx_shmem_fault+0x10/0x10
> [  189.672954]  ? __pfx_filemap_map_pages+0x10/0x10
> [  189.677590]  __do_fault+0xed/0x390
> [  189.681012]  __handle_mm_fault+0x1ba1/0x2e80
> [  189.685297]  ? __pfx___handle_mm_fault+0x10/0x10
> [  189.689933]  ? __pfx_down_read_trylock+0x10/0x10
> [  189.694570]  ? __pfx_hrtimer_nanosleep+0x10/0x10
> [  189.699215]  handle_mm_fault+0xe0/0x560
> [  189.703074]  ? __pfx_restore_fpregs_from_fpstate+0x10/0x10
> [  189.708620]  do_user_addr_fault+0x2ba/0x9d0
> [  189.712828]  exc_page_fault+0x54/0x90
> [  189.716508]  asm_exc_page_fault+0x22/0x30
> [  189.720535] RIP: 0033:0x5640dc2d72b5
> [  189.724131] Code: 98 48 ba 00 00 00 00 03 00 00 00 48 89 d6 48 2b 75 a0 ba 00 00 00 00 48 f7 f6 48 89 d1 48 89 ca 48 8b 45 a0 48 01 d0 48 01 d8 <0f> b6 00 bf e8 03 00 00 e8 1e fe ff ff 48 83 45 a8 01 48 8d 45 d0
> [  189.742922] RSP: 002b:00007ffc227e3f60 EFLAGS: 00010206
> [  189.748165] RAX: 00007f6e659a2ea3 RBX: 00007f6e2007e000 RCX: 0000000045924ea3
> [  189.755311] RDX: 0000000045924ea3 RSI: 0000000300000000 RDI: 00007f71202586a0
> [  189.762483] RBP: 00007ffc227e3fe0 R08: 00007f7120258074 R09: 00007f71202580a0
> [  189.769633] R10: 0000000000019458 R11: 00000000008aa400 R12: 0000000000000000
> [  189.776781] R13: 00007ffc227e4128 R14: 00007f712029d000 R15: 00005640dc2d9dd8
> [  189.783928]  </TASK>
> [  189.786126] ---[ end trace 0000000000000000 ]---
> [  285.827888] get_swap_device: Unused swap offset entry 0018403f
> [  320.699306] get_swap_device: Unused swap offset entry 000b001b
> [  354.031339] get_swap_device: Unused swap offset entry 000681a9
> [  364.958435] get_swap_device: Unused swap offset entry 001f4055
> [  364.976235] get_swap_device: Unused swap offset entry 001f4057
> [  365.530174] get_swap_device: Unused swap offset entry 000d415c
> [  394.223792] get_swap_device: Unused swap offset entry 001540d0
> [  394.317299] get_swap_device: Unused swap offset entry 000341d9
> [  394.341727] get_swap_device: Unused swap offset entry 0006c07e
> [  396.062365] get_swap_device: Unused swap offset entry 000541a4
> [  396.068262] get_swap_device: Unused swap offset entry 000541a7
> [  402.629551] get_swap_device: Unused swap offset entry 00294021
> [  436.740622] get_swap_device: Unused swap offset entry 00334155
> [  436.758527] get_swap_device: Unused swap offset entry 001b417c
> 
> swap_cluster_readahead() calls __read_swap_cache_async() on a range of
> made-up swap entries around the faulting slot. The device and the
> range (si->max) are valid, but the specific entry might not be in
> use. __read_swap_cache_async() instead relies on swapcache_prepare()
> returning -ENOENT to catch this and skip gracefully.

Sorry this got in your way, but thanks for the report! Clearly I didn't review
the call sites thoroughly enough. I'll move the extra check to
free_swap_and_cache(), retest and hopefully repost later today.

> 
> Confirmed that reverting the patch makes the warnings go away.


