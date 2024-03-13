Return-Path: <linux-kernel+bounces-102541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C67C87B39C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC2A1F239C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F4C5732C;
	Wed, 13 Mar 2024 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBddbGWk"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076335644B;
	Wed, 13 Mar 2024 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366057; cv=none; b=itdyQQiqqDvFisrAbPpSXu2jimS/O1udUvj/69PsNoleGEmFEQQ7YQXZcY1mfDmugMR4vmc1ks6ZOwr+ECBrEenIzNrpgW12LAnx9fyJp6QtxGeIHcP8uI53n3KFeX7G+mcmApCw/slhh9aHKrW6GiO/MaZTEIth+/zbarob8xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366057; c=relaxed/simple;
	bh=jmtv9H/MbiEJsGq9f9v+asktBlTPMeS47zlitXAp+mo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cMFKMrDwuNV8Ljh6QlSQeYxSr4XvtBSUyx9gq4ImDm7Hp+gRXpTCBhu+lbzVKVPg+alJTwKmUI4Y8hOF53rGaFAUrwOyIFv3ZScgeot15keNDa4emIs9j5MPJB+P2UAN19SDDCMy2t3XWvT33cnJ78mzJdkZLLUq+9KhZOoCKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBddbGWk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690bff9d4a6so2807546d6.1;
        Wed, 13 Mar 2024 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710366055; x=1710970855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjgOlGKHLboNutuB13p3BONiRe4A49OXADwQ0rCYxH0=;
        b=lBddbGWkgZc83xw2Tk95d83fIto8L56AOUdrJLAbjNDqVWArgj5SG2DKKqHOgKsozm
         v6NH3p8Kx1RoVRCUVJabeN5qszBMmXYpZLO+GIRHjWUkE7JkjT9ZtDC67d9SYqIUVaqU
         eYBcjC6P6+18+yPHXmcH0SG3BWGcMRUwyuFsucJXvGv0JBV3xH8fVd+i5MxjPcRt5BvE
         EIBv2MezLAJav6yroBGgqtCeZAjFAQQb9F1Bkkj5i8ffBGzGLBTEimIWfcg9k1pXuQFF
         SZj6HmpcfO3a2gfYy4Zt24dHYrzxbZmuhdgEdxx0QVZkCnpQzMQJ2pvcqHGQqNYvm/Fl
         LETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366055; x=1710970855;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjgOlGKHLboNutuB13p3BONiRe4A49OXADwQ0rCYxH0=;
        b=kZ7joBeHaSXPiJOAseNP04p9BNb3QgQfHifRF/YSbQligz7g6i2QIaMf3V2vTsYaon
         s9aOGUAGe4KTJehsl/amdt0hKbxPlKkrY3C3K5Z+zM0bzbkilKmRG8CCij5b3nLX7jXI
         3aVJ94+mM0tBrqNmREs1R98elJGhu4eLd7lvzkmn4omkQRQp8Jb3y57tzmEZknNuXFXe
         yZmeMxJZrp3gmSqZ9qINyA0kYzSIkqRPXNichnK7A+q98rEaziJwDqEd1vjhZQ4ttCX8
         o/IDuxBoB5fDs/usraAWih7R69EFF3HOKbuKAxgJTed3Fex8biLDvzKk5VXlFMKW/Ck2
         lU1w==
X-Forwarded-Encrypted: i=1; AJvYcCWzjLKNkqULu1yudue8O4dhC6mjmgfh8Lg+F1LslcQXXHYeWqrBWdanGrn5EF83KSkq8mmBpwlxasS8VZvdwNlNrBH6m2Glbt1EONVPSJZ/4owm/0V3VygIWSMks43hq51V3O7OqDOHNPnVeLxuZBvslPvaHlw/LJi/
X-Gm-Message-State: AOJu0YzPhYduQnSXMz5tmQzM1eMvSrJy0MJ0T0sqEx3+P+dnrTrg0c2Y
	NsOVzXxtM0HGQknr0O5jlr81IOSWY9dXvX7uilt4wUV4jMMneqV0
X-Google-Smtp-Source: AGHT+IGhbTdZ8YXD3KrN/cytPxJiS2Roe9dYrrwwYDOwDU+fBDxc2caxFwvDhO7gIxZsLXrPrXRLZQ==
X-Received: by 2002:ad4:4089:0:b0:690:baa3:d411 with SMTP id l9-20020ad44089000000b00690baa3d411mr1356641qvp.28.1710366054808;
        Wed, 13 Mar 2024 14:40:54 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id r11-20020a0562140c8b00b0069102f97e08sm54734qvr.97.2024.03.13.14.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:40:53 -0700 (PDT)
Date: Wed, 13 Mar 2024 17:40:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kernel@quicinc.com, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 bpf <bpf@vger.kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>
Message-ID: <65f21d65820fc_3d934129463@willemb.c.googlers.com.notmuch>
In-Reply-To: <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
 <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
 <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Abhishek Chauhan (ABC) wrote:
> =

> =

> On 3/13/2024 2:01 PM, Martin KaFai Lau wrote:
> > On 3/13/24 12:36 PM, Willem de Bruijn wrote:
> >> Martin KaFai Lau wrote:
> >>> On 3/13/24 1:52 AM, Willem de Bruijn wrote:
> >>>> Martin KaFai Lau wrote:
> >>>>> On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
> >>>>>> Bridge driver today has no support to forward the userspace time=
stamp
> >>>>>> packets and ends up resetting the timestamp. ETF qdisc checks th=
e
> >>>>>> packet coming from userspace and encounters to be 0 thereby drop=
ping
> >>>>>> time sensitive packets. These changes will allow userspace times=
tamps
> >>>>>> packets to be forwarded from the bridge to NIC drivers.
> >>>>>>
> >>>>>> Setting the same bit (mono_delivery_time) to avoid dropping of
> >>>>>> userspace tstamp packets in the forwarding path.
> >>>>>>
> >>>>>> Existing functionality of mono_delivery_time remains unaltered h=
ere,
> >>>>>> instead just extended with userspace tstamp support for bridge
> >>>>>> forwarding path.
> >>>>>
> >>>>> The patch currently broke the bpf selftest test_tc_dtime:
> >>>>> https://github.com/kernel-patches/bpf/actions/runs/8242487344/job=
/22541746675
> >>>>>
> >>>>> In particular, there is a uapi field __sk_buff->tstamp_type which=
 currently has
> >>>>> BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "de=
livery" time.
> >>>>> BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx t=
imestamp at
> >>>>> ingress or a delivery time set by user space).
> >>>>>
> >>>>> __sk_buff->tstamp_type depends on skb->mono_delivery_time which d=
oes not
> >>>>> necessarily mean mono after this patch. I thought about fixing it=
 on the bpf
> >>>>> side such that reading __sk_buff->tstamp_type only returns
> >>>>> BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time is =
set and skb->sk
> >>>>> is IPPROTO_TCP. However, it won't work because of bpf_skb_set_tst=
amp().
> >>>>>
> >>>>> There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp,
> >>>>> BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb->=
tstamp and the
> >>>>> skb->mono_delivery_time. The expectation is this could change skb=
->tstamp in the
> >>>>> ingress skb and redirect to egress sch_fq. It could also set a mo=
no time to
> >>>>> skb->tstamp where the udp sk->sk_clockid may not be necessary in =
mono and then
> >>>>> bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tstam=
p,
> >>>>> BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tstamp=
_type expects
> >>>>> BPF_SKB_TSTAMP_DELIVERY_MONO also.
> >>>>>
> >>>>> I ran out of idea to solve this uapi breakage.
> >>>>>
> >>>>> I am afraid it may need to go back to v1 idea and use another bit=

> >>>>> (user_delivery_time) in the skb.
> >>>>
> >>>> Is the only conflict when bpf_skb_set_tstamp is called for an skb =
from
> >>>> a socket with sk_clockid set (and thus SO_TXTIME called)?
> >>>
> >>> Right, because skb->mono_delivery_time does not mean skb->tstamp is=
 mono now and
> >>> its interpretation depends on skb->sk->sk_clockid.
> >>>
> >>>> Interpreting skb->tstamp as mono if skb->mono_delivery_time is set=
 and
> >>>> skb->sk is NULL is fine. This is the ingress to egress redirect ca=
se.
> >>>
> >>> skb->sk =3D=3D NULL is fine. I tried something like this in
> >>> bpf_convert_tstamp_type_read() for reading __sk_buff->tstamp_type:
> >>>
> >>> __sk_buff->tstamp_type is BPF_SKB_TSTAMP_DELIVERY_MONO when:
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0skb->mono_delivery_time =3D=3D 1 &&
> >>> =C2=A0=C2=A0=C2=A0=C2=A0(!skb->sk ||
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 !sk_fullsock(skb->sk) /* tcp tw or req sk =
*/ ||
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 skb->sk->sk_protocol =3D=3D IPPROTO_TCP)
> >>>
> >>> Not a small bpf instruction addition to bpf_convert_tstamp_type_rea=
d() but doable.
> >>>
> >>>>
> >>>> I don't see an immediate use for this BPF function on egress where=
 it
> >>>> would overwrite an SO_TXTIME timestamp and now skb->tstamp is mono=
,
> >>>> but skb->sk !=3D NULL and skb->sk->sk_clockid !=3D CLOCK_MONOTONIC=
.
> >>>
> >>> The bpf prog may act as a traffic shaper that limits the bandwidth =
usage of all
> >>> outgoing packets (tcp/udp/...) by setting the mono EDT in skb->tsta=
mp before
> >>> sending to the sch_fq.
> >>>
> >>> I currently also don't have a use case for skb->sk->sk_clockid !=3D=

> >>> CLOCK_MONOTONIC. However, it is something that bpf_skb_set_tstamp()=
 can do now
> >>> before queuing to sch_fq.
> >>>
> >>> The container (in netns + veth) may use other sk_clockid/qdisc (e.g=
 sch_etf)
> >>> setup and the non mono skb->tstamp is not cleared now during dev_fo=
rward_skb()
> >>> between the veth pair.
> >>>
> >>>>
> >>>> Perhaps bpf_skb_set_tstamp() can just fail if another delivery tim=
e is
> >>>> already explicitly programmed?
> >>>
> >>> This will change the existing bpf_skb_set_tstamp() behavior, so pro=
bably not
> >>> acceptable.
> >>>
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->sk &&
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock_flag(sk, SOCK_TXTIME) &&
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->sk->sk_clockid !=3D CLOCK_MONO=
TONIC
> >>>
> >>>> Either that, or unset SOCK_TXTIME to make sk_clockid undefined and=

> >>>> fall back on interpreting as monotonic.
> >>>
> >>> Change sk->sk_flags in tc bpf prog? hmm... I am not sure this will =
work well also.
> >>>
> >>> sock_valbool_flag(SOCK_TXTIME) should require a lock_sock() to make=
 changes. The
> >>> tc bpf prog cannot take the lock_sock, so bpf_skb_set_tstamp() curr=
ently only
> >>> changes skb and does not change skb->sk.
> >>>
> >>> I think changing sock_valbool_flag(SOCK_TXTIME) will also have a ne=
w user space
> >>> visible side effect. The sendmsg for cmsg with SCM_TXTIME will star=
t failing
> >>> from looking at __sock_cmsg_send().
> >>>
> >>> There may be a short period of disconnect between what is in sk->sk=
_flags and
> >>> what is set in skb->tstamp. e.g. what if user space does setsockopt=
(SO_TXTIME)
> >>> again after skb->tstamp is set by bpf. This could be considered a s=
mall glitch
> >>> for some amount of skb(s) until the user space settled on setsockop=
t(SO_TXTIME).
> >>>
> >>> I think all this is crying for another bit in skb to mean user_deli=
very_time
> >>> (skb->tstamp depends on skb->sk->sk_clockid) while mono_delivery_ti=
me is the
> >>> mono time either set by kernel-tcp or bpf.
> >>
> >> It does sound like the approach with least side effects.
> >>
> >> If we're going to increase to two bits per skb, it's perhaps
> >> better to just encode the (selected supported) CLOCK_ type, rather
> >> than only supporting clockid through skb->sk->sk_clockid.
> > =

> > Good idea. May be starting with mono and tai (Abishek's use case?), o=
nly forward these two clocks and reset the skb->tstamp for others.
> > =

> >>
> >> This BPF function is the analogue to SO_TXTIME. It is clearly
> >> extensible to additional BPF_SKB_TSTAMP_DELIVERY_.. types. To
> >> work with sch_etf, say.
> > =

> > Yes, if there are bits in skb to describe the clock in the skb->tstam=
p, BPF_SKB_TSTAMP_DELIVERY_ can be extended to match it. It will be easie=
r if the values in the skb bits is the same as the BPF_SKB_TSTAMP_DELIVER=
Y_*.
> > =

> > The bpf_convert_tstamp_*() and the bpf_skb_set_tstamp helper will nee=
d changes to include the consideration of these two bits. I think we have=
 mostly settled with the approach (thanks for the discussion!). Abhishek,=
 not sure how much can be reused from this patch for the two bits apporac=
h, do you want to revert the current patch first and then start from clea=
n?
> > =

> Yes , I think since we have concluded the two bit .(Thanks for discussi=
on again, Martin and Willem)
> =

> Here is what i will do from myside
> 1. Revert the v4 patch :-  net: Re-use and set mono_delivery_time bit f=
or userspace tstamp packets =

> 2. Keep mono_delivery_time as ease =

> 3. Add user_delivery_time as a new bitfield =

> 4. Add BPF_SKB_TSTAMP_DELIVERY_TAI in the bpf.h for etf support
> 5. do not reset the time if either mono_delivery_time or user_delivery_=
time is set. =

> =

> Let me know if i have covered all the design details or add if i missed=
 anything. =


Thanks for revising this.

No need to add the BPF part here.

I was mistaken that we can encode the clock_id in two skb bits.
SO_TXTIME allows essentially all CLOCK_...

So indeed we will need a user_delivery_time bit and use that to look
at sk_clockid.=

