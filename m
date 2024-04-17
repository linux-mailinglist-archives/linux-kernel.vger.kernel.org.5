Return-Path: <linux-kernel+bounces-147900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D87E8A7B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805631C216EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2CF374DB;
	Wed, 17 Apr 2024 03:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k0jmZZgo"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC281DDF8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713325523; cv=none; b=drlldZ8a80TBoBr1zIDBAxuTSjoQELa4QGVnNm93Ju7pd76guQsBcMPukBmGLy9a37AFNrRY7sCLna990Dv4OcYOcCFIwSxp5ZK8y+LfBd4FSp2HVK4Dcw8GbHukuqoWGvwqWkDSv5kHuedzbg1bzOc6Ep1TeumXIT3jh0rYEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713325523; c=relaxed/simple;
	bh=R+HSZOITcIqdGJX6PzNciPpbgxFGu2Vd2nrcJwjaB4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KN1vgy4xh14u6HaKDaBMw36kMsDMhP7ubH7Od/T0KTwgdfwyVNs7LNMcP+UfFKSlb3nCRiMLpAfVO2qw1FDSSiaBg2igSxtlx5yXXhyOm1r9PD7h5MPMPDUG8WD2aLmBJ1X2nae8HXqpmWdznwJ7tG4ilbPhx1sqJRS5NEodyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k0jmZZgo; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <246c1f4d-af13-40fa-b968-fbaf36b8f91f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713325518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTs1mMbb3UbD/rPzKoVGHbF5Tq9Us2waCsXSRwCo1bw=;
	b=k0jmZZgoV2GFZDzw9Bn9vkbsmWpcpDVCPM79jxd+IFH4TfnelpH7t1WJ2o8sZdmjPq7wgR
	xoyZTVuq+QzzDSKrpnBUYR9TyAECAVdfA5AeReGo4SUNNJlGqxnFiAQD8Km2/1ZhIEQ03T
	3gdH8HMCdTvCEKVBp4tXoiZ4S/LFGKs=
Date: Wed, 17 Apr 2024 11:44:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>, Christian Heusel <christian@heusel.eu>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Mark W <instruform@gmail.com>,
 regressions@lists.linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosryahmed@google.com>
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
 <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
 <CAKEwX=NM1y-K1-Yw=CH3cM-8odER1PZBVoWo-rs7_OdjFG_puw@mail.gmail.com>
 <CAKEwX=MWPUf1NMGdn+1AkRdOUf25ifAbPyoP9zppPTx3U3Tv2Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAKEwX=MWPUf1NMGdn+1AkRdOUf25ifAbPyoP9zppPTx3U3Tv2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/4/17 08:22, Nhat Pham wrote:
> On Tue, Apr 16, 2024 at 4:29 PM Nhat Pham <nphamcs@gmail.com> wrote:
>>
>> On Tue, Apr 16, 2024 at 3:14 PM Nhat Pham <nphamcs@gmail.com> wrote:
>>>
>>> On Tue, Apr 16, 2024 at 5:19 AM Christian Heusel <christian@heusel.eu> wrote:
>>>>
>>>> Hello everyone,
>>>
>>> Thanks for the report, Christian! Looking at it now.
>>>
>>>>
>>>> while rebuilding a few packages in Arch Linux we have recently come
>>>> across a regression in the linux kernel which was made visible by a test
>>>> failure in libguestfs[0], where the booted kernel showed a Call Trace
>>>> like the following one:
>>>>
>>>> [  218.738568] CPU: 0 PID: 167 Comm: guestfsd Not tainted 6.7.0-rc4-1-mainline-00158-gb5ba474f3f51 #1 bf39861cf50acae7a79c534e25532f28afe4e593^M
>>>
>>> Is this one of the kernel versions that was broken? That looks a bit
>>> odd, as zswap shrinker landed on 6.8...
>>
>> Ah ignore this - I understand the versioning now...
>>
>>>
>>>> [  218.739007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.3-1-1 04/01/2014^M
>>>> [  218.739787] RIP: 0010:memcg_page_state+0x9/0x30^M
>>>> [  218.740299] Code: 0d b8 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 <48> 8b 87 00 06 00 00 48 63 f6 31 d2 48 8b 04 f0 48 85 c0 48 0f 48^M
>>>> [  218.740727] RSP: 0018:ffffb5fa808dfc10 EFLAGS: 00000202^M
>>>> [  218.740862] RAX: 0000000000000000 RBX: ffffb5fa808dfce0 RCX: 0000000000000002^M
>>>> [  218.741016] RDX: 0000000000000001 RSI: 0000000000000033 RDI: 0000000000000000^M
>>>> [  218.741168] RBP: 0000000000000000 R08: ffff976681ff8000 R09: 0000000000000000^M
>>>> [  218.741322] R10: 0000000000000001 R11: ffff9766833f9d00 R12: ffff9766ffffe780^M
>>>> [  218.742167] R13: 0000000000000000 R14: ffff976680cc1800 R15: ffff976682204d80^M
>>>> [  218.742376] FS:  00007f1479d9f540(0000) GS:ffff9766fbc00000(0000) knlGS:0000000000000000^M
>>>> [  218.742569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
>>>> [  218.743256] CR2: 0000000000000600 CR3: 0000000103606000 CR4: 0000000000750ef0^M
>>>> [  218.743494] PKRU: 55555554^M
>>>> [  218.743593] Call Trace:^M
>>>> [  218.743733]  <TASK>^M
>>>> [  218.743847]  ? __die+0x23/0x70^M
>>>> [  218.743957]  ? page_fault_oops+0x171/0x4e0^M
>>>> [  218.744056]  ? free_unref_page+0xf6/0x180^M
>>>> [  218.744458]  ? exc_page_fault+0x7f/0x180^M
>>>> [  218.744551]  ? asm_exc_page_fault+0x26/0x30^M
>>>> [  218.744684]  ? memcg_page_state+0x9/0x30^M
>>>> [  218.744779]  zswap_shrinker_count+0x9d/0x110^M
>>>> [  218.744896]  do_shrink_slab+0x3a/0x360^M
>>>> [  218.744990]  shrink_slab+0xc7/0x3c0^M
>>>> [  218.745609]  drop_slab+0x85/0x140^M
>>>> [  218.745691]  drop_caches_sysctl_handler+0x7e/0xd0^M
>>>> [  218.745799]  proc_sys_call_handler+0x1c0/0x2e0^M
>>>> [  218.745912]  vfs_write+0x23d/0x400^M
>>>> [  218.745998]  ksys_write+0x6f/0xf0^M
>>>> [  218.746080]  do_syscall_64+0x64/0xe0^M
>>>> [  218.746169]  ? exit_to_user_mode_prepare+0x132/0x1f0^M
>>>> [  218.746873]  entry_SYSCALL_64_after_hwframe+0x6e/0x76^M
>>>>
> 
> Actually, inspecting the code a bit more - can memcg be null here?
> 
> Specifically, if mem_cgroup_disabled() is true, can we see null memcg
> here? Looks like in this case, mem_cgroup_iter() can return null, and
> the first iteration of drop_slab_node() can have null memcg if it's
> returned by mem_cgroup_iter().
> 
> shrink_slab() will still proceed and call do_shrink_slab() if the
> memcg is null - provided that mem_cgroup_disabled() holds:
> 
> if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>       return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
> 

Ah, I think your analysis is very right, here memcg is NULL but memcg_page_state
won't check.

> Inside zswap_shrink_count(), all the memcg accessors in this area seem
> to always check for null memcg (mem_cgroup_lruvec,
> mem_cgroup_zswap_writeback_enabled), *except* memcg_page_state, which
> is the one line that fail.
> 
> If this is all to it, we can simply add a null check or
> mem_cgroup_disabled() check here, and use pool stats instead?

Both look ok to me. The VM could only set sc->memcg to NULL when memcg
disabled, right?

Thanks.

