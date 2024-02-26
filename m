Return-Path: <linux-kernel+bounces-81162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FBC867288
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CABCB2F290
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F853384;
	Mon, 26 Feb 2024 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2GhjPKz"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288F21A0B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943366; cv=none; b=FBeRcNsQRcXCWAiUgk1yrIuUoFw2tJmHklrpRB08QmLJ64StGMUnXVl0gDvYo8zZYPlVypsUmixtlIyoRm9giVy/zfxx/QD4zDDh2S1nyoTdoprvIx6QUMcJM/eOca8IeLYUZ40qkf/t0UqZr6YWsurHTlhpX+jv2mvchr36IpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943366; c=relaxed/simple;
	bh=j8vs2kYNqidZarWFkHkNVn2iIvZToZdN0qkN5+xNYUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imKVYGOvct9bKa23CQH0juZ8u+dytvxglCev157ncKSjzqHSoZ/W78oCL80tFjmtPkyNCtAHebGmhYkEXjZqtAIHga6h0bdHiHZMLKtNgD+KY+91ZXevN0/CR2G+in/7yUjKo4/Eqjagw3YYNF0vej/vVCSMEratbSG+XGzdNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2GhjPKz; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso15350a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708943362; x=1709548162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9LBZSvHXbFImgyGtsmIfeO7+emcfrVlLTSHoyquOhU=;
        b=V2GhjPKze02j75RwUxXRdFvDaAyVns3p4JoF2SfROBj6oBvTAjQyJmXD7j8EUoiPts
         XDwm38iLP/HiYVPZGypvUXPuXfJQ4a/e/ioAfUNfjeFIr7P27ytyqzPZnl4XteClNEV9
         VYXqK9Nie+OzBF3v9iJPBiAeyX6p0CRoi502zjiBthaGmAFjNn57DmB6uyFff8nPsH9P
         NVLzpuCrmJeqtU6Un+azJzLOwu7ylSc8tcDgTb2o3Mcl6bmz2bSKML9cHsXxAzgy0fu7
         lKaYUSbdJ6JdX+L1k1w0ANUo10e9r7lpX99H9carH7fpBVOa94O9ON4+yJOC2tJnNZ/c
         ByDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708943362; x=1709548162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9LBZSvHXbFImgyGtsmIfeO7+emcfrVlLTSHoyquOhU=;
        b=i5iChnO6RqTRPdT1n7OSZqAHZUXzfRKQuwYrXbypQ/w81rt6xNEyrzrWl7crlXo7eX
         WUSmHb0FTEKvxcL3xKvbqmmsCARmYulLomTWy9m3hkGIQS+t1cTvbT6mSDT46CedZOcF
         /yRtSFaXyM2x7MXLnh4WmA8eXDx6LdzORRMUdAKDrtCLX7tNCDQABwk92WTvTlEJjxZt
         V5VXaYP5VJEdADjPuwhOchNWg5N9dQMbgsQ3LiQ0yBp0vl1FR7pjR68mUrVXznVehEkm
         qLvyuMP0DdSBZuiSlG4NScXCrgBrVgezURdcJoj/3JmhpT/XBVUe6bdNxQtKz3b3RNRJ
         K0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdoEEnGQrUd9nkVNK8XdoW8YQMPQeaz9ZajoUqqzN9cq7ftbeXanj1+RlEfArfyG9uRGJDh/GtuMaublrzJivuH8z7l+LXB2oVsRzJ
X-Gm-Message-State: AOJu0YzFJd49sJC1fFEAuI9QhEGxKQhtZ+w8TGiZyZ3xZJawj7j8Wrr/
	/ZQLiAP+niRttSvFbtVk20IiGvwO3Epc9IpJZG1ZvoxP19qWPmaOk7MlHqSyjqHyYZfKmKTErak
	FbaJxsvAtRG41UjGKi4P41KZq47hi7dmTNPPm
X-Google-Smtp-Source: AGHT+IFKz46PFB51fdJ85PXmyLQGXMahOGGYRTDTtbRxiAG3nY7eMN8+lnfxZ63efS90ND8l5xonPPcns8ila5ukGns=
X-Received: by 2002:a50:a6d7:0:b0:565:4b98:758c with SMTP id
 f23-20020a50a6d7000000b005654b98758cmr279364edc.4.1708943362220; Mon, 26 Feb
 2024 02:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
 <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <bea860f8-a196-4dff-a655-4da920e2ebfa@amperemail.onmicrosoft.com>
 <CANn89i+1uMAL_025rNc3C1Ut-E5S8Nat6KhKEzcFeC1xxcFWaA@mail.gmail.com>
 <c2bd73b6-b21f-4ad8-a176-eec677bc6cf3@amperemail.onmicrosoft.com>
 <CANn89i+Cr1Tbdxqy6fB-sOLca+AHFc-3-0xGktVUsQFFMVsC0A@mail.gmail.com> <bd0a9d66-783d-4936-a5b0-cd4082704137@kernel.org>
In-Reply-To: <bd0a9d66-783d-4936-a5b0-cd4082704137@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Feb 2024 11:29:07 +0100
Message-ID: <CANn89iKJtLZFjY_kYhV5NcgKiAkhi_stftvai1dCwQLMOLea6g@mail.gmail.com>
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: aleksander.lobakin@intel.com, 
	Shijie Huang <shijie@amperemail.onmicrosoft.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org, 
	patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org, 
	ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:18=E2=80=AFAM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
> On 24/02/2024 20.07, Eric Dumazet wrote:
> > On Tue, Feb 20, 2024 at 9:37=E2=80=AFAM Shijie Huang
> > <shijie@amperemail.onmicrosoft.com> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/2/20 16:17, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Tue, Feb 20, 2024 at 7:26=E2=80=AFAM Shijie Huang
> >>> <shijie@amperemail.onmicrosoft.com> wrote:
> >>>>
> >>>> =E5=9C=A8 2024/2/20 13:32, Eric Dumazet =E5=86=99=E9=81=93:
> >>>>> On Tue, Feb 20, 2024 at 3:18=E2=80=AFAM Huang Shijie
> >>>>> <shijie@os.amperecomputing.com> wrote:
> >>>>>> The current code passes NUMA_NO_NODE to __alloc_skb(), we found
> >>>>>> it may creates fclone SKB in remote NUMA node.
> >>>>> This is intended (WAI)
> >>>> Okay. thanks a lot.
> >>>>
> >>>> It seems I should fix the issue in other code, not the networking.
> >>>>
> >>>>> What about the NUMA policies of the current thread ?
> >>>> We use "numactl -m 0" for memcached, the NUMA policy should allocate
> >>>> fclone in
> >>>>
> >>>> node 0, but we can see many fclones were allocated in node 1.
> >>>>
> >>>> We have enough memory to allocate these fclones in node 0.
> >>>>
> >>>>> Has NUMA_NO_NODE behavior changed recently?
> >>>> I guess not.
> >>>>> What means : "it may creates" ? Please be more specific.
> >>>> When we use the memcached for testing in NUMA, there are maybe 20% ~=
 30%
> >>>> fclones were allocated in
> >>>>
> >>>> remote NUMA node.
> >>> Interesting, how was it measured exactly ?
> >>
> >> I created a private patch to record the status for each fclone allocat=
ion.
> >>
> >>
> >>> Are you using SLUB or SLAB ?
> >>
> >> I think I use SLUB. (CONFIG_SLUB=3Dy,
> >> CONFIG_SLAB_MERGE_DEFAULT=3Dy,CONFIG_SLUB_CPU_PARTIAL=3Dy)
> >>
> >
> > A similar issue comes from tx_action() calling __napi_kfree_skb() on
> > arbitrary skbs
> > including ones that were allocated on a different NUMA node.
> >
> > This pollutes per-cpu caches with not optimally placed sk_buff :/
> >
> > Although this should not impact fclones, __napi_kfree_skb() only ?
> >
> > commit 15fad714be86eab13e7568fecaf475b2a9730d3e
> > Author: Jesper Dangaard Brouer <brouer@redhat.com>
> > Date:   Mon Feb 8 13:15:04 2016 +0100
> >
> >      net: bulk free SKBs that were delay free'ed due to IRQ context
> >
> > What about :
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index c588808be77f563c429eb4a2eaee5c8062d99582..63165138c6f690e14520f11=
e32dc16f2845abad4
> > 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5162,11 +5162,7 @@ static __latent_entropy void
> > net_tx_action(struct softirq_action *h)
> >                                  trace_kfree_skb(skb, net_tx_action,
> >                                                  get_kfree_skb_cb(skb)-=
>reason);
> >
> > -                       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE)
> > -                               __kfree_skb(skb);
> > -                       else
> > -                               __napi_kfree_skb(skb,
> > -                                                get_kfree_skb_cb(skb)-=
>reason);
>
> Yes, I think it makes sense to avoid calling __napi_kfree_skb here.
> The __napi_kfree_skb call will cache SKB slub-allocation (but "release"
> data) on a per CPU napi_alloc_cache (see code napi_skb_cache_put()).
> In net_tx_action() there is a chance this could originate from another
> CPU or even NUMA node.  I notice this is only for SKBs on the
> softnet_data->completion_queue, which have a high chance of being cache
> cold.  My patch 15fad714be86e only made sense when we bulk freed these
> SKBs, but after Olek's changes to cache freed SKBs, then this shouldn't
> be calling __napi_kfree_skb() (previously named __kfree_skb_defer).
>
> I support this RFC patch from Eric.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Note that this should not matter for most NIC, because their drivers
perform TX completion from NAPI context, we do not hit this path.

It seems that switching to SLUB instead of SLAB has increased the chances
of getting memory from another node.

We probably need to investigate.

