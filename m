Return-Path: <linux-kernel+bounces-157765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F108B15D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A64A1C214B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F81635D5;
	Wed, 24 Apr 2024 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxnanQmA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A019745CB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996540; cv=none; b=ODfqmQAKcSbFndLPFJakFt3WrINrOG6gEA5QJ36bHRlZDWNqe80nHBIzREmgop707PayGBaOPmdepvl0XQyCpwQH/x0suCETLExkbhyC+1Nn/GKToGnVyt4hroq9/T7CUN2nUcdjYzNyHmLY0E/yzSKIB/8QsAWtTeokXYy7iL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996540; c=relaxed/simple;
	bh=ZZuHd5yizCSiPSTe1KnvRCDEhoAc14yofZTdbze6DW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbetdtkO6jtmb4u1T0bcOc1gOCsj0a/8m90wiBY7ldsTlerQY+4BGEJzI6d0YSfdH9NaLKFokXbEUhI2IHnkHvZldaQsyVzDZxeB3feXD1BEp83FQ+aD5kZsjcdNZwcfJ1lEomSW/qJCs0NoqJzKEQQHOLeXdZSt+uIb2YxGjT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxnanQmA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso2560025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713996537; x=1714601337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r32Cg3+w7m+3nAP4ILki9Fc9/v3OtIVWGhJE/25h+/k=;
        b=vxnanQmAp7j/9taEvyPDYSz1TkDBmB9dMwIDYabH4NkXnYOQuf2nX7FJ2yeJUdj7L+
         NYmlnhv1yjWcJmTL4+lxaQOA9r/YKJ7LI8c6TTnzFl917CH7CIH+5ZBdJ0msRXV7F2/M
         vRj55G8WcRdxvNxCMyLuHrDEacf9iYWQC1tDfltfd1SrrU01+S51IHNnW0GX3cLa/otX
         XbGcsbDE1HWFSctpvbVt8YpgNwvfVUBEGzo7yz2dGseGAkNFHkWzVtq6tbAlPAkRwi37
         8m5ewLxUe1xTlknwc07yvJKbjL2tJkIPcftYg61tJXi6sNrkYZ3s7LulBsBufT5/8Ccp
         CzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713996537; x=1714601337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r32Cg3+w7m+3nAP4ILki9Fc9/v3OtIVWGhJE/25h+/k=;
        b=hZjEMbRf7J+rMo6VgLZdT5Ky6NABTjuLCzdIdmghx+Kqz4GMKahglg9Y+4aqg0LFuh
         E2wEa41UCpX8MUYEiqwcdDT6b3a3BrJ1uXUFGYbD/0slqM2o+BpG2cVob1qKKneBkmYU
         DM5O2odXQLvJmIF61bcqTwnV57WUgwOEHfCLMOA956weGi1N0fmX2fJCHH+bgIAOtEBm
         rJhyd5FNV8Ke7EsZYYPOLkSFFKPBbS0z0rRyyCs3uqxTIIQker38m6594Psp1CNB9tRh
         XoCz3Khxj4vvJOnb/n4szqMoqEVaW2bmMzoD+nmC0MYDshipapsOUA98+wv2FIg+4S+7
         UjUw==
X-Forwarded-Encrypted: i=1; AJvYcCVavIRbWMGN6LxkIqSpfClM9U62ksKY7XPTtWC3HC4NhFg5SuswgA+OkGs3uO69sP3Zi+dk1LeibSmiFclQJyHQCIsOp1I3y3thTx52
X-Gm-Message-State: AOJu0YxiOmfFsNPGyDfkgm8ehozXqvfHADdXbivfiz/KYenBYN+6RmxO
	HnNsIBJK0Py0BqskBaBU+MKnEKXQxOGqs99ipLp+7zs7+2gajnCT9en2YcAMELRzz+xF6L7a76b
	2RqnUnqwXX+1IK3/w0gU7B18EOWymBDHEw6mS
X-Google-Smtp-Source: AGHT+IG5/hEP7lNK14trqIFoR96oQzipOlhqUhIQJ2gnsizakJy44D4hzFt1huchs79ayYsNL9X/7vDCcTnnhzCo/CM=
X-Received: by 2002:a5d:5f4b:0:b0:34b:e97e:20f7 with SMTP id
 cm11-20020a5d5f4b000000b0034be97e20f7mr1470456wrb.59.1713996536422; Wed, 24
 Apr 2024 15:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424165646.1625690-2-dtatulea@nvidia.com> <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
In-Reply-To: <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 24 Apr 2024 15:08:42 -0700
Message-ID: <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, "edumazet@google.com" <edumazet@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, Jianbo Liu <jianbol@nvidia.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:25=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Wed, 2024-04-24 at 19:56 +0300, Dragos Tatulea wrote:
> > The patch referenced in the fixes tag introduced the skb_frag_unref API=
.
> This is wrong actually. Only skb_frag_ref was introduced. Sorry for the
> confusion.
>
> > This API still has a dark corner: when skb->pp_recycled is false and a
> > fragment being referenced is backed by a page_pool page, skb_frag_unref
> > can leak the page out of the page_pool, like in the following example:
> >
> >  BUG: Bad page state in process swapper/4  pfn:103423
> >  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x103423000=
 pfn:0x103423
> >  flags: 0x200000000000000(node=3D0|zone=3D2)
> >  page_type: 0xffffffff()
> >  raw: 0200000000000000 dead000000000040 ffff888106f38000 00000000000000=
00
> >  raw: 0000000103423000 0000000000000041 00000000ffffffff 00000000000000=
00
> >  page dumped because: page_pool leak
> >  Modules linked in: act_mirred act_csum act_pedit act_gact cls_flower
> >  act_ct nf_flow_table sch_ingress xt_conntrack xt_MASQUERADE
> >  nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat
> >  br_netfilter overlay rpcrdma rdma_ucm ib_iser libiscsi
> >  scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx5_ib
> >  ib_uverbs ib_core zram zsmalloc mlx5_core fuse CPU: 4 PID: 0 Comm:
> >  swapper/4 Not tainted 6.9.0-rc4+ #2
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-=
gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> >  Call Trace:
> >   <IRQ>
> >   dump_stack_lvl+0x53/0x70
> >   bad_page+0x6f/0xf0
> >   free_unref_page_prepare+0x271/0x420
> >   free_unref_page+0x38/0x120
> >   ___pskb_trim+0x261/0x390
> >   skb_segment+0xf60/0x1040
> >   tcp_gso_segment+0xe8/0x4e0
> >   inet_gso_segment+0x155/0x3d0
> >   skb_mac_gso_segment+0x99/0x100
> >   __skb_gso_segment+0xb4/0x160
> >   ? netif_skb_features+0x95/0x2f0
> >   validate_xmit_skb+0x16c/0x330
> >   validate_xmit_skb_list+0x4c/0x70
> >   sch_direct_xmit+0x23e/0x350
> >   __dev_queue_xmit+0x334/0xbc0
> >   tcf_mirred_to_dev+0x2a5/0x3e0 [act_mirred]
> >   tcf_mirred_act+0xd7/0x4b0 [act_mirred]
> >   ? tcf_pedit_act+0x6f/0x540 [act_pedit]
> >   tcf_action_exec+0x82/0x170
> >   fl_classify+0x1ee/0x200 [cls_flower]
> >   ? tcf_mirred_to_dev+0x2a5/0x3e0 [act_mirred]
> >   ? mlx5e_completion_event+0x39/0x40 [mlx5_core]
> >   ? mlx5_eq_comp_int+0x1d7/0x1f0 [mlx5_core]
> >   tcf_classify+0x26a/0x470
> >   tc_run+0xa2/0x120
> >   ? handle_irq_event+0x53/0x80
> >   ? kvm_clock_get_cycles+0x11/0x20
> >   __netif_receive_skb_core.constprop.0+0x932/0xee0
> >   __netif_receive_skb_list_core+0xfe/0x1f0
> >   netif_receive_skb_list_internal+0x1b5/0x2b0
> >   napi_gro_complete.constprop.0+0xee/0x120
> >   dev_gro_receive+0x3f4/0x710
> >   napi_gro_receive+0x7d/0x220
> >   mlx5e_handle_rx_cqe_mpwrq+0x10d/0x1d0 [mlx5_core]
> >   mlx5e_poll_rx_cq+0x8b/0x6f0 [mlx5_core]
> >   mlx5e_napi_poll+0xdc/0x6c0 [mlx5_core]
> >   __napi_poll+0x25/0x1b0
> >   net_rx_action+0x2c1/0x330
> >   __do_softirq+0xcb/0x28c
> >   irq_exit_rcu+0x69/0x90
> >   common_interrupt+0x85/0xa0
> >   </IRQ>
> >   <TASK>
> >   asm_common_interrupt+0x26/0x40
> >  RIP: 0010:default_idle+0x17/0x20
> >  Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff ff ff cc cc cc cc f3 0f 1=
e
> >  fa 8b 05 76 3f 0a 01 85 c0 7e 07 0f 00 2d 1d 74 41 00 fb f4 <fa> c3 0f
> >  1f 80 00 00 00 00 f3 0f 1e fa 65 48 8b 35 04 b3 42 7e f0
> >  RSP: 0018:ffff88810087bed8 EFLAGS: 00000246
> >  RAX: 0000000000000000 RBX: ffff8881008415c0 RCX: 000000e116d359fb
> >  RDX: 0000000000000000 RSI: ffffffff8223e1d1 RDI: 000000000003f214
> >  RBP: 0000000000000004 R08: 000000000003f214 R09: 000000e116d359fb
> >  R10: 000000e116d359fb R11: 000000000005dfee R12: 0000000000000004
> >  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >   default_idle_call+0x3d/0xf0
> >   do_idle+0x1ce/0x1e0
> >   cpu_startup_entry+0x29/0x30
> >   start_secondary+0x109/0x130
> >   common_startup_64+0x129/0x138
> >   </TASK>
> >
> > How it happens:
> > -> skb_segment
> >   -> clone skb into nskb
> >   -> call __pskb_trim(nskb)
> >     -> call pskb_expand_head(nskb) because nskb is cloned
> >       -> call skb_release_data(nskb) because nskb is cloned
> >         -> nskb->pp_recycle =3D 0
> >     -> skb_unref(nskb->frag[i], nskb)
> >       -> nskb->pp_recycle is false, frag is page_pool page
> >       -> Fragment is released via put_page(frag page), hence leaking
> >          from the page_pool.
> >
> > Something tells me that this is not be the only issue of this kind...
> >
> > The patch itself contains a suggested fix for this specific bug: it
> > forces the unref in ___pskb_trim to recycle to the page_pool. If the
> > page is not a page_pool page, it will be dereferenced as a regular page=
.
> >
> > The alternative would be to save the skb->pp_recycled flag before
> > pskb_expand_head and use it later during the unref.
> >
>
> One more interesting point is the comment in skb_release_data [1] and it'=
s
> commit message [2] from Ilias. Looking at the commit message
>

Sorry for the bug. I don't think this is the right fix to be honest
though. As you mention this is only 1 such instance of a general
underlying issue.

The underlying issue is that before the fixes commit, skb_frag_ref()
grabbed a regular page ref. After the fixes commit, skb_frag_ref()
grabs a page-pool ref. The unref path always dropped a regular page
ref, thanks to this commit as you point out:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D2cc3aeb5ecccec0d266813172fcd82b4b5fa5803

AFAICT the correct fix is to actually revert commit 2cc3aeb5eccc
("skbuff: Fix a potential race while recycling page_pool packets").
The reason is that now that skb_frag_ref() can grab page-pool refs, we
don't need to make sure there is only 1 SKB that triggers the recycle
path anymore. All the skb and its clones can obtain page-pool refs,
and in the unref path we drop the page-pool refs. page_pool_put_page()
detects correctly that the last page-pool ref is put and recycles the
page only then.

I'm unable to repro this issue. Do you need to do anything special? Or
is 1 flow that hits skb_segment() good enough?

Reverting commit 2cc3aeb5eccc ("skbuff: Fix a potential race while
recycling page_pool packets") shows no regressions for me. Is it
possible to try that out? If that doesn't work, I think I prefer
reverting a580ea994fd3 ("net: mirror skb frag ref/unref helpers")
rather than merging this fix to make sure we removed the underlying
cause of the issue.

> [1] https://elixir.bootlin.com/linux/v6.9-rc5/source/net/core/skbuff.c#L1=
137
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D2cc3aeb5ecccec0d266813172fcd82b4b5fa5803
>
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Co-developed-by: Jianbo Liu <jianbol@nvidia.com>
> > Fixes: a580ea994fd3 ("net: mirror skb frag ref/unref helpers")
> > Cc: Mina Almasry <almasrymina@google.com>
> > ---
> >  net/core/skbuff.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 37c858dc11a6..ab75b4f876ce 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -2634,7 +2634,7 @@ int ___pskb_trim(struct sk_buff *skb, unsigned in=
t len)
> >               skb_shinfo(skb)->nr_frags =3D i;
> >
> >               for (; i < nfrags; i++)
> > -                     skb_frag_unref(skb, i);
> > +                     __skb_frag_unref(&skb_shinfo(skb)->frags[i], true=
);
> >
> >               if (skb_has_frag_list(skb))
> >                       skb_drop_fraglist(skb);
>


--=20
Thanks,
Mina

