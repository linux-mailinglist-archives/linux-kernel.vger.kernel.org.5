Return-Path: <linux-kernel+bounces-127713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59FE894FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D281C226D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2137B60882;
	Tue,  2 Apr 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuKnZej9"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335A60B95
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053020; cv=none; b=rMCnFCb3CuO8k/8mZ+GO/UzWyO1+AvJTrVaX+SiV8KSK1VH50EBA45bTjX+YfNENU1g0Kiu/2EatnfdwKeI6iol1X6hQKdm41arZs8LXECHmihH2I8v3n7c/RH2Wpu8r1vglg61esNcN+uq8ExKj42+jeL3Oft6iptm0PRzysFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053020; c=relaxed/simple;
	bh=pLXNY53+S33dqOkcoDDSs1PEfMwbT448V5Q0/CS8Jhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE+PVyL+b+3nTqSxuw1hE5bZSHt3b/mKzrjNRCwyGOmYOndQr+QbcjzEGoJKaFNLeJcb44dRztzhqqr/ynGuZW+IAVJkGFguumKf4uehDeo3CdHjbxpevhNCtbtiwGoq27m43JT8NwZi6on/8FgMKmvjxnmbCbaq4j0SG5rz+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuKnZej9; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4785c788ba6so671287137.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712053017; x=1712657817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGZBV8K4LacC6tYCXDam0yYUxzCXbXCExJryqvcvGOY=;
        b=WuKnZej9A3iOJzhtDY95tnwazqe4YU1adASRB0Uxq34nyEBinKyFCOcgTpA7lIUtpz
         Qqs2Z5kW3zU9ot3mPYEPTdFa18wTXPNgrO43a7+Fks4vm7dZcoPdGF4gtzhhxDLdrXgC
         RusjEWFOgZkyAcb6YfTfRntAP2LNNzeKktdT+0Enf76H1XCI/DLeKR8pJ8g2Ph5WN+4u
         BCgj70fR8Inv6OLMSaxnD+kvvIW2DbdMY06ekHavU/9JSJlZxrO/4vBg2EvG90ZfSM8Y
         n/jFtSxlsCUcliXXxGUfaPb8meJFDSeFF5RnK7AmtWKEBwPr52jwK7ew4By49wWc4Mlp
         KByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712053017; x=1712657817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGZBV8K4LacC6tYCXDam0yYUxzCXbXCExJryqvcvGOY=;
        b=WFMecVjG6kUdaUmU2luPAe5/aKBSuaXU1C9tzzzCuU6pd5RILKPXBka+IH3bbPNM74
         c5I2fz1qoeFUbWRfeUYFh2sSjsuk+s2WY6CiLuZQTVWoqJS+JaZfsiA/0ZgPKQjHt7sy
         s8FTVR8WBAuR5YBL4DXdyLlJjRiGbLRSSwP+fewcyzEwjZnW/ao26LL6A4mzKJblLeHI
         tvGESs2VphQNTvt488Nd42EttrwyGp8VJi6T2mtjg/+K1fYwl2cHun6w6x/CptyDrZ+0
         vsB1TK1LHBAEAsNo3kF4SmvJtv1G7Ic9c/u7rc9jr72okMtQovNd7pdd2yI+JUQRaQul
         4ksg==
X-Forwarded-Encrypted: i=1; AJvYcCUta6Ab6i+bBzK7iaqjetMVcdy0BdizoE+K7UzdEkSaTas7TwwSpzxi/G7cy+wZFmkU9ySArsApY1NoZ+oXHvcv9DXWD5hP7BmEwpXS
X-Gm-Message-State: AOJu0YxbR1YG0Hv7Nsl76TOQ3YWFQhhpUd2qAf2M6Y6ThR3zElues0NP
	OxWpDrW7VDS6h33sgnf2QyavoH5t9Q3MxDNELv7GHl7MC6AKgk/wbsa5dXbtSdMcO26xLJh37rB
	jrdBT2OufAYylwXZP8P5vdFVUYto=
X-Google-Smtp-Source: AGHT+IEPai0nVOwJBFlwuKTlSMx6peY/NctoO8iTDzVRmTQScCClgG0SQFlJ0tamm//DJ3OOLxHOYB+MjxmgoQAmvSE=
X-Received: by 2002:a05:6102:3bd7:b0:478:8e59:591c with SMTP id
 a23-20020a0561023bd700b004788e59591cmr1119050vsv.17.1712053015790; Tue, 02
 Apr 2024 03:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327144537.4165578-1-ryan.roberts@arm.com> <20240327144537.4165578-7-ryan.roberts@arm.com>
In-Reply-To: <20240327144537.4165578-7-ryan.roberts@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Apr 2024 23:16:44 +1300
Message-ID: <CAGsJ_4yMOow27WDvN2q=E4HAtDd2PJ=OQ5Pj9DG+6FLWwNuXUw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:46=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any large
> folio that is fully and contiguously mapped in the pageout/cold vm
> range. This change means that large folios will be maintained all the
> way to swap storage. This both improves performance during swap-out, by
> eliding the cost of splitting the folio, and sets us up nicely for
> maintaining the large folio when it is swapped back in (to be covered in
> a separate series).
>
> Folios that are not fully mapped in the target range are still split,
> but note that behavior is changed so that if the split fails for any
> reason (folio locked, shared, etc) we now leave it as is and move to the
> next pte in the range and continue work on the proceeding folios.
> Previously any failure of this sort would cause the entire operation to
> give up and no folios mapped at higher addresses were paged out or made
> cold. Given large folios are becoming more common, this old behavior
> would have likely lead to wasted opportunities.
>
> While we are at it, change the code that clears young from the ptes to
> use ptep_test_and_clear_young(), via the new mkold_ptes() batch helper
> function. This is more efficent than get_and_clear/modify/set,
> especially for contpte mappings on arm64, where the old approach would
> require unfolding/refolding and the new approach can be done in place.
>
> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Hi Ryan,

I'm not entirely certain if this issue is related to this patch, but
I've encountered
the KNIC twice while using the latest mm-unstable kernel. Each time I attem=
pted
to debug it, the issue vanished. I'm posting here to see if you have
any ideas on it :-)

[   50.444066]
[   50.444495] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   50.444954] WARNING: bad unlock balance detected!
[   50.445443] 6.9.0-rc2-00257-g2d9f63c285db #128 Not tainted
[   50.446233] -------------------------------------
[   50.446684] singlethread/102 is trying to release lock
(ptlock_ptr(ptdesc)) at:
[   50.447635] [<ffffb03155fe302c>]
madvise_cold_or_pageout_pte_range+0x80c/0xea0
[   50.449066] but there are no more locks to release!
[   50.449535]
[   50.449535] other info that might help us debug this:
[   50.450140] 1 lock held by singlethread/102:
[   50.450688]  #0: ffff0000c001f208 (&mm->mmap_lock){++++}-{4:4}, at:
do_madvise.part.0+0x178/0x518
[   50.452321]
[   50.452321] stack backtrace:
[   50.452959] CPU: 3 PID: 102 Comm: singlethread Not tainted
6.9.0-rc2-00257-g2d9f63c285db #128
[   50.453812] Hardware name: linux,dummy-virt (DT)
[   50.454373] Call trace:
[   50.454755]  dump_backtrace+0x9c/0x100
[   50.455246]  show_stack+0x20/0x38
[   50.455667]  dump_stack_lvl+0xec/0x150
[   50.456111]  dump_stack+0x18/0x28
[   50.456533]  print_unlock_imbalance_bug+0x130/0x148
[   50.457014]  lock_release+0x2e0/0x360
[   50.457487]  _raw_spin_unlock+0x2c/0x78
[   50.457997]  madvise_cold_or_pageout_pte_range+0x80c/0xea0
[   50.458635]  walk_pgd_range+0x388/0x7d8
[   50.459168]  __walk_page_range+0x1e0/0x1f0
[   50.459682]  walk_page_range+0x1f0/0x2c8
[   50.460225]  madvise_pageout+0xf8/0x280
[   50.460711]  madvise_vma_behavior+0x310/0x9b8
[   50.461169]  madvise_walk_vmas+0xc0/0x128
[   50.461605]  do_madvise.part.0+0xf8/0x518
[   50.462041]  __arm64_sys_madvise+0x68/0x88
[   50.462529]  invoke_syscall+0x50/0x128
[   50.463001]  el0_svc_common.constprop.0+0x48/0xf8
[   50.463508]  do_el0_svc+0x28/0x40
[   50.464004]  el0_svc+0x50/0x150
[   50.464492]  el0t_64_sync_handler+0x13c/0x158
[   50.465021]  el0t_64_sync+0x1a4/0x1a8
[   50.466959] ------------[ cut here ]------------
[   50.467451] WARNING: CPU: 3 PID: 102 at
kernel/rcu/tree_plugin.h:431 __rcu_read_unlock+0x74/0x218
[   50.468160] Modules linked in:
[   50.468803] CPU: 3 PID: 102 Comm: singlethread Not tainted
6.9.0-rc2-00257-g2d9f63c285db #128
[   50.469658] Hardware name: linux,dummy-virt (DT)
[   50.470293] pstate: a3400005 (NzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=
=3D--)
[   50.470991] pc : __rcu_read_unlock+0x74/0x218
[   50.471594] lr : madvise_cold_or_pageout_pte_range+0x828/0xea0
[   50.472236] sp : ffff800080abb7e0
[   50.472622] pmr_save: 000000e0
[   50.473010] x29: ffff800080abb7e0 x28: 0000ffffa467a000 x27: fffffdffc31=
28c00
[   50.474006] x26: 0010000000000001 x25: 000000000000001b x24: ffff0000c32=
d73d0
[   50.474971] x23: 0060000104a3afc3 x22: ffff0000c2492840 x21: 04000000000=
00001
[   50.475943] x20: ff77fffffffffbff x19: ffff0000c3230000 x18: fffffffffff=
fffff
[   50.477286] x17: 672d37353230302d x16: 3263722d302e392e x15: ffff800100a=
bb227
[   50.478373] x14: 0000000000000001 x13: 38613178302f3461 x12: 3178302b636=
e7973
[   50.479354] x11: fffffffffffe0000 x10: ffffb03159697d08 x9 : ffffb03155f=
e3048
[   50.480265] x8 : 00000000ffffefff x7 : ffffb03159697d08 x6 : 00000000000=
00000
[   50.481154] x5 : 0000000000000001 x4 : ffff800080abbfe0 x3 : 00000000000=
00000
[   50.482035] x2 : ffff4fd055074000 x1 : 00000000ffffffff x0 : 000000003ff=
fffff
[   50.483163] Call trace:
[   50.483599]  __rcu_read_unlock+0x74/0x218
[   50.484152]  madvise_cold_or_pageout_pte_range+0x828/0xea0
[   50.484780]  walk_pgd_range+0x388/0x7d8
[   50.485328]  __walk_page_range+0x1e0/0x1f0
[   50.485725]  walk_page_range+0x1f0/0x2c8
[   50.486117]  madvise_pageout+0xf8/0x280
[   50.486547]  madvise_vma_behavior+0x310/0x9b8
[   50.486975]  madvise_walk_vmas+0xc0/0x128
[   50.487403]  do_madvise.part.0+0xf8/0x518
[   50.487845]  __arm64_sys_madvise+0x68/0x88
[   50.488374]  invoke_syscall+0x50/0x128
[   50.488946]  el0_svc_common.constprop.0+0x48/0xf8
[   50.489732]  do_el0_svc+0x28/0x40
[   50.490210]  el0_svc+0x50/0x150
[   50.490674]  el0t_64_sync_handler+0x13c/0x158
[   50.491257]  el0t_64_sync+0x1a4/0x1a8
[   50.491793] irq event stamp: 3087
[   50.492243] hardirqs last  enabled at (3087): [<ffffb031570d89d8>]
_raw_spin_unlock_irq+0x38/0x90
[   50.492917] hardirqs last disabled at (3086): [<ffffb031570d8acc>]
_raw_spin_lock_irq+0x9c/0xc0
[   50.493742] softirqs last  enabled at (2470): [<ffffb03155c10d94>]
__do_softirq+0x534/0x588
[   50.494567] softirqs last disabled at (2461): [<ffffb03155c17238>]
____do_softirq+0x18/0x30
[   50.495328] ---[ end trace 0000000000000000 ]---
[   50.497110] BUG: sleeping function called from invalid context at
kernel/locking/rwsem.c:1578
[   50.497544] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
102, name: singlethread
[   50.497652] preempt_count: ffffffff, expected: 0
[   50.497728] RCU nest depth: -1, expected: 0
[   50.497851] INFO: lockdep is turned off.
[   50.498023] CPU: 3 PID: 102 Comm: singlethread Tainted: G        W
        6.9.0-rc2-00257-g2d9f63c285db #128
[   50.498166] Hardware name: linux,dummy-virt (DT)
[   50.498221] Call trace:
[   50.498260]  dump_backtrace+0x9c/0x100
[   50.498378]  show_stack+0x20/0x38
[   50.498487]  dump_stack_lvl+0xec/0x150
[   50.498574]  dump_stack+0x18/0x28
[   50.498659]  __might_resched+0x158/0x278
[   50.498741]  __might_sleep+0x50/0xa0
[   50.498849]  down_write+0x30/0x1a8
[   50.498950]  split_huge_page_to_list_to_order+0x3c8/0x1130
[   50.499052]  madvise_cold_or_pageout_pte_range+0x84c/0xea0
[   50.499138]  walk_pgd_range+0x388/0x7d8
[   50.499224]  __walk_page_range+0x1e0/0x1f0
[   50.499334]  walk_page_range+0x1f0/0x2c8
[   50.499458]  madvise_pageout+0xf8/0x280
[   50.499554]  madvise_vma_behavior+0x310/0x9b8
[   50.499657]  madvise_walk_vmas+0xc0/0x128
[   50.499739]  do_madvise.part.0+0xf8/0x518
[   50.499851]  __arm64_sys_madvise+0x68/0x88
[   50.499953]  invoke_syscall+0x50/0x128
[   50.500037]  el0_svc_common.constprop.0+0x48/0xf8
[   50.500121]  do_el0_svc+0x28/0x40
[   50.500203]  el0_svc+0x50/0x150
[   50.500322]  el0t_64_sync_handler+0x13c/0x158
[   50.500422]  el0t_64_sync+0x1a4/0x1a8
[   50.501378] BUG: scheduling while atomic: singlethread/102/0x00000000
[   50.517641] INFO: lockdep is turned off.
[   50.518206] Modules linked in:
[   50.521135] CPU: 2 PID: 102 Comm: singlethread Tainted: G        W
        6.9.0-rc2-00257-g2d9f63c285db #128
[   50.522026] Hardware name: linux,dummy-virt (DT)
[   50.522623] Call trace:
[   50.522993]  dump_backtrace+0x9c/0x100
[   50.523527]  show_stack+0x20/0x38
[   50.523950]  dump_stack_lvl+0xec/0x150
[   50.524405]  dump_stack+0x18/0x28
[   50.524849]  __schedule_bug+0x80/0xe0
[   50.525309]  __schedule+0xb1c/0xc00
[   50.525750]  schedule+0x58/0x170
[   50.526227]  schedule_preempt_disabled+0x2c/0x50
[   50.526762]  rwsem_down_write_slowpath+0x1ac/0x718
[   50.527342]  down_write+0xf8/0x1a8
[   50.527857]  split_huge_page_to_list_to_order+0x3c8/0x1130
[   50.528437]  madvise_cold_or_pageout_pte_range+0x84c/0xea0
[   50.529012]  walk_pgd_range+0x388/0x7d8
[   50.529442]  __walk_page_range+0x1e0/0x1f0
[   50.529896]  walk_page_range+0x1f0/0x2c8
[   50.530342]  madvise_pageout+0xf8/0x280
[   50.530878]  madvise_vma_behavior+0x310/0x9b8
[   50.531395]  madvise_walk_vmas+0xc0/0x128
[   50.531849]  do_madvise.part.0+0xf8/0x518
[   50.532330]  __arm64_sys_madvise+0x68/0x88
[   50.532829]  invoke_syscall+0x50/0x128
[   50.533374]  el0_svc_common.constprop.0+0x48/0xf8
[   50.533992]  do_el0_svc+0x28/0x40
[   50.534498]  el0_svc+0x50/0x150
[   50.535029]  el0t_64_sync_handler+0x13c/0x158
[   50.535588]  el0t_64_sync+0x1a4/0x1a8



>  include/linux/pgtable.h | 30 ++++++++++++++
>  mm/internal.h           | 12 +++++-
>  mm/madvise.c            | 88 ++++++++++++++++++++++++-----------------
>  mm/memory.c             |  4 +-
>  4 files changed, 93 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8185939df1e8..391f56a1b188 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -361,6 +361,36 @@ static inline int ptep_test_and_clear_young(struct v=
m_area_struct *vma,
>  }
>  #endif
>
> +#ifndef mkold_ptes
> +/**
> + * mkold_ptes - Mark PTEs that map consecutive pages of the same folio a=
s old.
> + * @vma: VMA the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to mark old.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a si=
mple
> + * loop over ptep_test_and_clear_young().
> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For e=
xample,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecut=
ive
> + * pages that belong to the same folio.  The PTEs are all in the same PM=
D.
> + */
> +static inline void mkold_ptes(struct vm_area_struct *vma, unsigned long =
addr,
> +               pte_t *ptep, unsigned int nr)
> +{
> +       for (;;) {
> +               ptep_test_and_clear_young(vma, addr, ptep);
> +               if (--nr =3D=3D 0)
> +                       break;
> +               ptep++;
> +               addr +=3D PAGE_SIZE;
> +       }
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONL=
EAF_PMD_YOUNG)
>  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> diff --git a/mm/internal.h b/mm/internal.h
> index eadb79c3a357..efee8e4cd2af 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -130,6 +130,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t p=
te, fpb_t flags)
>   * @flags: Flags to modify the PTE batch semantics.
>   * @any_writable: Optional pointer to indicate whether any entry except =
the
>   *               first one is writable.
> + * @any_young: Optional pointer to indicate whether any entry except the
> + *               first one is young.
>   *
>   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>   * pages of the same large folio.
> @@ -145,16 +147,18 @@ static inline pte_t __pte_batch_clear_ignored(pte_t=
 pte, fpb_t flags)
>   */
>  static inline int folio_pte_batch(struct folio *folio, unsigned long add=
r,
>                 pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> -               bool *any_writable)
> +               bool *any_writable, bool *any_young)
>  {
>         unsigned long folio_end_pfn =3D folio_pfn(folio) + folio_nr_pages=
(folio);
>         const pte_t *end_ptep =3D start_ptep + max_nr;
>         pte_t expected_pte, *ptep;
> -       bool writable;
> +       bool writable, young;
>         int nr;
>
>         if (any_writable)
>                 *any_writable =3D false;
> +       if (any_young)
> +               *any_young =3D false;
>
>         VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>         VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
> @@ -168,6 +172,8 @@ static inline int folio_pte_batch(struct folio *folio=
, unsigned long addr,
>                 pte =3D ptep_get(ptep);
>                 if (any_writable)
>                         writable =3D !!pte_write(pte);
> +               if (any_young)
> +                       young =3D !!pte_young(pte);
>                 pte =3D __pte_batch_clear_ignored(pte, flags);
>
>                 if (!pte_same(pte, expected_pte))
> @@ -183,6 +189,8 @@ static inline int folio_pte_batch(struct folio *folio=
, unsigned long addr,
>
>                 if (any_writable)
>                         *any_writable |=3D writable;
> +               if (any_young)
> +                       *any_young |=3D young;
>
>                 nr =3D pte_batch_hint(ptep, pte);
>                 expected_pte =3D pte_advance_pfn(expected_pte, nr);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 070bedb4996e..bd00b83e7c50 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>         LIST_HEAD(folio_list);
>         bool pageout_anon_only_filter;
>         unsigned int batch_count =3D 0;
> +       int nr;
>
>         if (fatal_signal_pending(current))
>                 return -EINTR;
> @@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>                 return 0;
>         flush_tlb_batched_pending(mm);
>         arch_enter_lazy_mmu_mode();
> -       for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
> +       for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
> +               nr =3D 1;
>                 ptent =3D ptep_get(pte);
>
>                 if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
> @@ -447,55 +449,67 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
>                         continue;
>
>                 /*
> -                * Creating a THP page is expensive so split it only if w=
e
> -                * are sure it's worth. Split it if we are only owner.
> +                * If we encounter a large folio, only split it if it is =
not
> +                * fully mapped within the range we are operating on. Oth=
erwise
> +                * leave it as is so that it can be swapped out whole. If=
 we
> +                * fail to split a folio, leave it in place and advance t=
o the
> +                * next pte in the range.
>                  */
>                 if (folio_test_large(folio)) {
> -                       int err;
> -
> -                       if (folio_likely_mapped_shared(folio))
> -                               break;
> -                       if (pageout_anon_only_filter && !folio_test_anon(=
folio))
> -                               break;
> -                       if (!folio_trylock(folio))
> -                               break;
> -                       folio_get(folio);
> -                       arch_leave_lazy_mmu_mode();
> -                       pte_unmap_unlock(start_pte, ptl);
> -                       start_pte =3D NULL;
> -                       err =3D split_folio(folio);
> -                       folio_unlock(folio);
> -                       folio_put(folio);
> -                       if (err)
> -                               break;
> -                       start_pte =3D pte =3D
> -                               pte_offset_map_lock(mm, pmd, addr, &ptl);
> -                       if (!start_pte)
> -                               break;
> -                       arch_enter_lazy_mmu_mode();
> -                       pte--;
> -                       addr -=3D PAGE_SIZE;
> -                       continue;
> +                       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY |
> +                                               FPB_IGNORE_SOFT_DIRTY;
> +                       int max_nr =3D (end - addr) / PAGE_SIZE;
> +                       bool any_young;
> +
> +                       nr =3D folio_pte_batch(folio, addr, pte, ptent, m=
ax_nr,
> +                                            fpb_flags, NULL, &any_young)=
;
> +                       if (any_young)
> +                               ptent =3D pte_mkyoung(ptent);
> +
> +                       if (nr < folio_nr_pages(folio)) {
> +                               int err;
> +
> +                               if (folio_likely_mapped_shared(folio))
> +                                       continue;
> +                               if (pageout_anon_only_filter && !folio_te=
st_anon(folio))
> +                                       continue;
> +                               if (!folio_trylock(folio))
> +                                       continue;
> +                               folio_get(folio);
> +                               arch_leave_lazy_mmu_mode();
> +                               pte_unmap_unlock(start_pte, ptl);
> +                               start_pte =3D NULL;
> +                               err =3D split_folio(folio);
> +                               folio_unlock(folio);
> +                               folio_put(folio);
> +                               if (err)
> +                                       continue;
> +                               start_pte =3D pte =3D
> +                                       pte_offset_map_lock(mm, pmd, addr=
, &ptl);
> +                               if (!start_pte)
> +                                       break;
> +                               arch_enter_lazy_mmu_mode();
> +                               nr =3D 0;
> +                               continue;
> +                       }
>                 }
>
>                 /*
>                  * Do not interfere with other mappings of this folio and
> -                * non-LRU folio.
> +                * non-LRU folio. If we have a large folio at this point,=
 we
> +                * know it is fully mapped so if its mapcount is the same=
 as its
> +                * number of pages, it must be exclusive.
>                  */
> -               if (!folio_test_lru(folio) || folio_mapcount(folio) !=3D =
1)
> +               if (!folio_test_lru(folio) ||
> +                   folio_mapcount(folio) !=3D folio_nr_pages(folio))
>                         continue;
>
>                 if (pageout_anon_only_filter && !folio_test_anon(folio))
>                         continue;
>
> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> -
>                 if (!pageout && pte_young(ptent)) {
> -                       ptent =3D ptep_get_and_clear_full(mm, addr, pte,
> -                                                       tlb->fullmm);
> -                       ptent =3D pte_mkold(ptent);
> -                       set_pte_at(mm, addr, pte, ptent);
> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> +                       mkold_ptes(vma, addr, pte, nr);
> +                       tlb_remove_tlb_entries(tlb, pte, nr, addr);
>                 }
>
>                 /*
> diff --git a/mm/memory.c b/mm/memory.c
> index 9d844582ba38..b5b48f4cf2af 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -989,7 +989,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, str=
uct vm_area_struct *src_vma
>                         flags |=3D FPB_IGNORE_SOFT_DIRTY;
>
>                 nr =3D folio_pte_batch(folio, addr, src_pte, pte, max_nr,=
 flags,
> -                                    &any_writable);
> +                                    &any_writable, NULL);
>                 folio_ref_add(folio, nr);
>                 if (folio_test_anon(folio)) {
>                         if (unlikely(folio_try_dup_anon_rmap_ptes(folio, =
page,
> @@ -1553,7 +1553,7 @@ static inline int zap_present_ptes(struct mmu_gathe=
r *tlb,
>          */
>         if (unlikely(folio_test_large(folio) && max_nr !=3D 1)) {
>                 nr =3D folio_pte_batch(folio, addr, pte, ptent, max_nr, f=
pb_flags,
> -                                    NULL);
> +                                    NULL, NULL);
>
>                 zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent,=
 nr,
>                                        addr, details, rss, force_flush,
> --
> 2.25.1
>

