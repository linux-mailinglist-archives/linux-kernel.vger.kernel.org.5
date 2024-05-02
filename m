Return-Path: <linux-kernel+bounces-167033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1E8BA3AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394691F21660
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BEA1CD00;
	Thu,  2 May 2024 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3g2MfzT"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD951C6A1
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691128; cv=none; b=VyOQzs7sWn2/dt4rRPMKURHk2DMOLg60EEU96itn2wXZ3qTpfg7ZyhzJvPpEV+abq8kIpIoKMuedUXEDUKQpR7XbVYXpwmrGQlg2+0iDu/Cy6ZzresiTeJsDLIie3mTDSQSp5PmNGte02Oy3JiEOB8lPZxkfShxlXtQeP58Sfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691128; c=relaxed/simple;
	bh=jk0QtKmCx1xcqLQWohyJfEK3tFGPf+SdZl3Jr/2ZE7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTXOiHEgLCIVrAzQvXmzqJi9rm5IutX84vKld8/odi5eJ28rdAbdx5qFfUI54v88L3OarMxoofWgioLlHcuyRNRT8+Qi/nTtw2UWeF5+8EFu5qGCPEY19imjBWgS1G9MYmDx1faVQvhFKVbFg+qAFFJVtothW0p++DG5HTxJglk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3g2MfzT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61b68644ab4so82798107b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714691126; x=1715295926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ezx4wmMWJiSJtFNK/efG3+qdlPgKJJwodjHrb/ERaiU=;
        b=k3g2MfzTmBMxIQGpTYhflQ85hi6K5vQNxeeCUQvXh/cSzV8G1IvYSSl3qcPBkrSDz2
         FynyN/iW47n4DrZ3T4azZ2xHIaJr5gsC16rn81PMLz0rw9Ccr9g4v0+wMchoBt3nYmNe
         L5V13RoDt1UBp6X137jH5F74a0vxlensv9QwDdEQHzSgQis0sXh7IwxSKH7MYOOpvM5d
         2CB2nGCbOo3TkMRB2bhX9z4JnAc7ZnjHiGaXG14O5kqTNkDKSvENn9B7DkBAu8dTiiWV
         Q90BeseTMsFvbg6LSUE6zdc2ipBzqOW6XszDeIFXr8aK1yfh0tP8+PVMnPytGdItnBRZ
         ec9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714691126; x=1715295926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezx4wmMWJiSJtFNK/efG3+qdlPgKJJwodjHrb/ERaiU=;
        b=g5F/IA+yDU8TwiwgcaEduqgR5G2W+DpCCmerE7DFujUYbWMQVb3xxikOBHjDfQBCdC
         xn6Q5sXUBBpBch3FEBtT5WyiIXNRKzI7DKCm6rtXPLCaM2FNYIX8SrmS6dvfGZkdsOaO
         RpMKwG5MVvsShQ2aANz7roWvB9n1NXEFN7XCqhcNp1lEdNVjG3VL6AF7A6cNV44xnYwZ
         T+Cn+e/PoF1zo1F32pljiTJFLJ+lV22+wwjHF/AGBWX03c3QCniZ7FjzzgM455BcsTIX
         2NYtOIXfTdBmQhQxf3IBZ8c9XRQbDen/nd+XaQriLsblC+v8BcdUjB7zc2xDQG+4Rseq
         9PKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMony0RZntAp2XHH4Wj0J1L/oanztG+QkZYgfry6/J7BNqj4VOl5o9AMp38cenMt4ldG6PhrAW4eMvpGOh3xZtlIsjriLgMHf3XMn8
X-Gm-Message-State: AOJu0YzvDybgI7TUmkvQQ0GOZCgmeoJ4wrdper0oL0T2UPYC+Y2GDyY2
	L2ehtAl/x+CkWS81wwueeWxyVSoiedH7wrcRztew3/TRMS+ld5WfEoJvygP2/rTMPAR94HlsPu3
	cJkyRbxacW9zCrRg1PXi52cv7f9w=
X-Google-Smtp-Source: AGHT+IHjZWBVSec7G2zPAVUAhhvRdzBCCiWDLXHQKLDQEXWgwQ/huHlw6Hm5HhVgKDCb7tBv2P6F90dUezNKzNHq2qU=
X-Received: by 2002:a81:ff0d:0:b0:60a:17a2:5627 with SMTP id
 k13-20020a81ff0d000000b0060a17a25627mr847104ywn.50.1714691125648; Thu, 02 May
 2024 16:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-2-21cnbao@gmail.com>
 <87y19f2lq3.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yPQyQpWvB2KmuOh2vyUQA0A6hNHsypEC9Gptp9XtuDgg@mail.gmail.com>
 <87jzkz2g3t.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wm4SfkyTBHpU46EPTFvhq8e54F3KRkKj6gTBcnOjCw1g@mail.gmail.com>
 <87bk6b2elo.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4zH4RHhZembtXOqzBDL75MA5NiEjMHx7eCN-a1ifnKTBw@mail.gmail.com>
 <877cgy2ifu.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yim-PQW0JBjZD8dpGBG3FQm=xZb1V51+Nr37nJEwEPzA@mail.gmail.com>
 <87ttk20zns.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xigDba15o9K84z9nR_ZW1nXsUWa0LRNmUAfDdxcqsddw@mail.gmail.com>
 <87jzkw25hl.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wTsJe2yK3k+Tif6obgL9LUUuqXEBxhqMSZSFZpbvrzmA@mail.gmail.com>
 <CAGsJ_4ymv-tmpmH0s1D5+GF13UOPv5UdRFrLOxVE5X+xNUHveg@mail.gmail.com>
 <87le5bxd6n.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wtpkGrfAP23+LgUuUi0BDqS3jjdGu6Y2JDbwTskgA3yQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wtpkGrfAP23+LgUuUi0BDqS3jjdGu6Y2JDbwTskgA3yQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 3 May 2024 11:05:13 +1200
Message-ID: <CAGsJ_4yyvmAwCjXN4Y2m9+i2WuXF2fVv6G_4HB3uuER+2wkfJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched swap_free()
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[snip]

> >
> > My idea is something as below.  It's only build tested.
> >
> > static void cluster_swap_free_nr(struct swap_info_struct *sis,
> >                                  unsigned long offset, int nr_pages)
> > {
> >         struct swap_cluster_info *ci;
> >         DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
> >         int i, nr;
> >
> >         ci = lock_cluster_or_swap_info(sis, offset);
> >         while (nr_pages) {
> >                 nr = min(BITS_PER_LONG, nr_pages);
> >                 for (i = 0; i < nr; i++) {
> >                         if (!__swap_entry_free_locked(sis, offset + i, 1))
> >                                 bitmap_set(to_free, i, 1);
> >                 }
> >                 if (!bitmap_empty(to_free, BITS_PER_LONG)) {
> >                         unlock_cluster_or_swap_info(sis, ci);
> >                         for_each_set_bit(i, to_free, BITS_PER_LONG)
> >                                 free_swap_slot(swp_entry(sis->type, offset + i));
> >                         if (nr == nr_pages)
> >                                 return;
> >                         bitmap_clear(to_free, 0, BITS_PER_LONG);
> >                         ci = lock_cluster_or_swap_info(sis, offset);
> >                 }
> >                 offset += nr;
> >                 nr_pages -= nr;
> >         }
> >         unlock_cluster_or_swap_info(sis, ci);
> > }
> >
> > void swap_free_nr(swp_entry_t entry, int nr_pages)
> > {
> >         int nr;
> >         struct swap_info_struct *sis;
> >         unsigned long offset = swp_offset(entry);
> >
> >         sis = _swap_info_get(entry);
> >         if (!sis)
> >                 return;
> >
> >         while (nr_pages >= 0) {

this should be "while (nr_pages) " exactly like
"cluster_swap_free_nr", otherwise, we get

[  383.652632] EXT4-fs (vda): error count since last fsck: 85
[  383.653453] EXT4-fs (vda): initial error at time 1709536044:
mb_free_blocks:1937: block 704527
[  383.654947] EXT4-fs (vda): last error at time 1714689579:
ext4_mb_generate_buddy:1213
[  398.564002] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [a.out:104]
[  398.564679] Modules linked in:
[  398.565239] irq event stamp: 0
[  398.565648] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  398.566888] hardirqs last disabled at (0): [<ffff8000800ade2c>]
copy_process+0x654/0x19a8
[  398.568255] softirqs last  enabled at (0): [<ffff8000800ade2c>]
copy_process+0x654/0x19a8
[  398.568813] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  398.569481] CPU: 1 PID: 104 Comm: a.out Not tainted
6.9.0-rc4-g3c9251435c61-dirty #216
[  398.570076] Hardware name: linux,dummy-virt (DT)
[  398.570600] pstate: 01401005 (nzcv daif +PAN -UAO -TCO +DIT +SSBS BTYPE=--)
[  398.571148] pc : lock_acquire+0x3c/0x88
[  398.571636] lr : lock_acquire+0x3c/0x88
[  398.572075] sp : ffff800086f13af0
[  398.572484] x29: ffff800086f13af0 x28: 0000000000000000 x27: ffff0000c1096800
[  398.573349] x26: 0000000000000001 x25: ffff8000803e4d60 x24: 0000000000000000
[  398.574139] x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000000
[  398.574915] x20: 0000000000000000 x19: ffff0000c3eb0918 x18: 0000000000000000
[  398.576009] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  398.576895] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  398.577732] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000814cf7a0
[  398.578668] x8 : ffff800086f13ab8 x7 : 0000000000000000 x6 : ffff8000803e4d60
[  398.579705] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800082f39008
[  398.580528] x2 : 0000000000000003 x1 : 0000000000000002 x0 : 0000000000000001
[  398.581387] Call trace:
[  398.581740]  lock_acquire+0x3c/0x88
[  398.582159]  _raw_spin_lock+0x50/0x70
[  398.582556]  swap_free_nr+0x98/0x2a0
[  398.582946]  do_swap_page+0x568/0xd00
[  398.583337]  __handle_mm_fault+0x76c/0x16d0
[  398.583853]  handle_mm_fault+0x7c/0x3c8
[  398.584276]  do_page_fault+0x188/0x698
[  398.584731]  do_translation_fault+0xb4/0xd8
[  398.585142]  do_mem_abort+0x4c/0xa8
[  398.585541]  el0_da+0x58/0x128
[  398.585923]  el0t_64_sync_handler+0xe4/0x158
[  398.586355]  el0t_64_sync+0x1a4/0x1a8
[  398.651930] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [a.out:103]
[  398.652819] Modules linked in:
[  398.653682] irq event stamp: 0
[  398.654213] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  398.654714] hardirqs last disabled at (0): [<ffff8000800ade2c>]
copy_process+0x654/0x19a8
[  398.655242] softirqs last  enabled at (0): [<ffff8000800ade2c>]
copy_process+0x654/0x19a8
[  398.655835] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  398.656657] CPU: 2 PID: 103 Comm: a.out Tainted: G             L
 6.9.0-rc4-g3c9251435c61-dirty #216
[  398.657705] Hardware name: linux,dummy-virt (DT)
[  398.658273] pstate: 01401005 (nzcv daif +PAN -UAO -TCO +DIT +SSBS BTYPE=--)
[  398.658743] pc : queued_spin_lock_slowpath+0x5c/0x528
[  398.659146] lr : do_raw_spin_lock+0xc8/0x120
[  398.659575] sp : ffff800086d03a60
[  398.659946] x29: ffff800086d03a60 x28: 0000000000000120 x27: 0800000103050003
[  398.661238] x26: ffff0000c27d5d40 x25: fffffdffc0000000 x24: ffff800082270d08
[  398.662431] x23: ffff800083f73a31 x22: ffff800086d03d48 x21: 0000ffff9bf70000
[  398.663358] x20: ffff800082f39008 x19: ffff0000c27d5d40 x18: 0000000000000000
[  398.664353] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  398.665825] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  398.666715] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000801420f8
[  398.667528] x8 : ffff800086d03a48 x7 : 0000000000000000 x6 : ffff8000803abef0
[  398.668548] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800082f39008
[  398.670018] x2 : ffff80012ac81000 x1 : 0000000000000000 x0 : 0000000000000001
[  398.670831] Call trace:
[  398.671136]  queued_spin_lock_slowpath+0x5c/0x528
[  398.671604]  do_raw_spin_lock+0xc8/0x120
[  398.672144]  _raw_spin_lock+0x58/0x70
[  398.672860]  __pte_offset_map_lock+0x98/0x210
[  398.673695]  filemap_map_pages+0x10c/0x7f8
[  398.674495]  __handle_mm_fault+0x11e4/0x16d0
[  398.674926]  handle_mm_fault+0x7c/0x3c8
[  398.675336]  do_page_fault+0x100/0x698
[  398.675863]  do_translation_fault+0xb4/0xd8
[  398.676425]  do_mem_abort+0x4c/0xa8
[  398.677225]  el0_ia+0x80/0x188
[  398.678004]  el0t_64_sync_handler+0x100/0x158
[  398.678778]  el0t_64_sync+0x1a4/0x1a8
[  422.563920] watchdog: BUG: soft lockup - CPU#1 stuck for 48s! [a.out:104]
[  422.564528] Modules linked in:
[  422.564991] irq event stamp: 0



> >                 nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> >                 cluster_swap_free_nr(sis, offset, nr);
> >                 offset += nr;
> >                 nr_pages -= nr;
> >         }
> > }
> > --
> > Best Regards,
> > Huang, Ying
>

Thanks
Barry

