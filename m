Return-Path: <linux-kernel+bounces-103075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85BB87BAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B895B20401
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176BE6D1CE;
	Thu, 14 Mar 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH3ZkXNd"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E186CDCF;
	Thu, 14 Mar 2024 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409764; cv=none; b=UKa3cz1fzPhLmrxDgKdSP39p0cbExwrMla4bMKA8MV7nUOrxu9vkIRNCu1srD6Mk2sYcGrpYXO95IF3LUEOjVZednVp9Tdy4hvwDK35tLQe17L1cF2ybmxPbVRalstizoXfAa1XhQ6Km2X98JiqgNYO27CP4S704nfjLJ00/acA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409764; c=relaxed/simple;
	bh=6jW8WvoBb9wnl4rF0HP+FMfrhWatOEpXT131Muyel6g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aNECf2cXLREm52uA95Jd3t6gMBzkBlYHLHNgi9i399OalBZOELCONC80MOGizyIH/WKOnhAhGwMQy0x5XTI8H7ngV5J6S10z/zWW6L4czPVIKBSX0OK7D6hS8aYRSRfssG1gGz/vlX7J56CSWfq47GqFjAB064g61Y5ikVG9uIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH3ZkXNd; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d3634a8015so136266e0c.1;
        Thu, 14 Mar 2024 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710409761; x=1711014561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELTnMRNj07Si2m282wRHa22PPeZIfWu9K59oGBotkzg=;
        b=gH3ZkXNdccGfSlXty8ndU4fwt2jwXYnFtDNO+G19UFgAmMsa+ZtCVAqZaVu1iSCktH
         RbZImDR9g5yK/6/xasnmMbuge4EFhDDs+TuOOMiBhnelEzjrjW5nx5D7cTENTU65ZfV0
         SdQr52AoKjSGVcmitIxEc0fK/is9J2SbXgBlWMMl8s8RVw/WeI7rdqBSni4uiqfTt87G
         ICIISQTvUzyrS9U2fp6jrhDItQs40VIUSS/anxdtX2eg3GL6dtIIK0i1zkt8lae3s0M4
         30Kw+FMOqh5RSoZQUwlZ2+R78VnptPs0BPJqz+4rOe7BJDlsCgTaPqbUFiLVOnxuha24
         hM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710409761; x=1711014561;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ELTnMRNj07Si2m282wRHa22PPeZIfWu9K59oGBotkzg=;
        b=CKjFTQuZ56B3Y0+FxpkSiElI+sYMIkM5J/UX2RpZbLdhLyCjdzDGBDk7xukuZYTo7J
         C7Mr6tAaNA0oRPg1B2aaRVrzU4PrdpjbRZidOPdGUbkjHvF0oNjqXltG6G5E0zzvkAjR
         xPB70576qmSR8rlKUnQopdebylkJHa1Ilxt/B5hJOMISFeADkqwqFnDuCHXA0Fglh4ko
         9gtUS4OH2jRVRj+w1si/8hS2N1tVtCVP0VKIh4uIHLl89OTH02eiH6/RQGzkCy+I8mq9
         maSmglqgZDAywYu5ei/uF+91d+PtObue1uns0OUH/TwhYGPzKXsa61SJ/x/7yd9HbB/I
         3q3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJYPSRTMfrV44K2ENrEb58yJ5++gxMshQmQdc7+DLlPnXfBq3g4P7KKfYRoSnRp5AzCqsVH3pnmYmUo9fcwj4xqlXpec0IgP+eivJHNTeMtiFisse8yFLwxELJHmqP2/8oQN2I9w2sl0YqiYr6O29Iv1w52OBV3C6+
X-Gm-Message-State: AOJu0Yw2OBJqmeB21BGQAa5/UKSlsX+1JWiKcUk0AVRs6ql9Lq2bYmCc
	ny1NsNifJblAFurQKXFskA6zaTeCX0+ZQU/GMk4uknni+L90JQgL
X-Google-Smtp-Source: AGHT+IFGSkKBNp6XDNjvqwCbD6chadtsBwEYrs5a+Y8nrBt+Sp9KboO/Kh9iU9Cj9Irb9hkW+V/cpw==
X-Received: by 2002:a05:6122:e41:b0:4d4:1766:52b7 with SMTP id bj1-20020a0561220e4100b004d4176652b7mr1090751vkb.15.1710409760654;
        Thu, 14 Mar 2024 02:49:20 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id gv13-20020a056214262d00b006904c34d5basm201308qvb.64.2024.03.14.02.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:49:20 -0700 (PDT)
Date: Thu, 14 Mar 2024 05:49:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
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
Message-ID: <65f2c81fc7988_3ee61729465@willemb.c.googlers.com.notmuch>
In-Reply-To: <bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
 <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
 <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
 <65f21d65820fc_3d934129463@willemb.c.googlers.com.notmuch>
 <bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev>
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

Martin KaFai Lau wrote:
> On 3/13/24 2:40 PM, Willem de Bruijn wrote:
> > Abhishek Chauhan (ABC) wrote:
> >>
> >>
> >> On 3/13/2024 2:01 PM, Martin KaFai Lau wrote:
> >>> On 3/13/24 12:36 PM, Willem de Bruijn wrote:
> >>>> Martin KaFai Lau wrote:
> >>>>> On 3/13/24 1:52 AM, Willem de Bruijn wrote:
> >>>>>> Martin KaFai Lau wrote:
> >>>>>>> On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
> >>>>>>>> Bridge driver today has no support to forward the userspace ti=
mestamp
> >>>>>>>> packets and ends up resetting the timestamp. ETF qdisc checks =
the
> >>>>>>>> packet coming from userspace and encounters to be 0 thereby dr=
opping
> >>>>>>>> time sensitive packets. These changes will allow userspace tim=
estamps
> >>>>>>>> packets to be forwarded from the bridge to NIC drivers.
> >>>>>>>>
> >>>>>>>> Setting the same bit (mono_delivery_time) to avoid dropping of=

> >>>>>>>> userspace tstamp packets in the forwarding path.
> >>>>>>>>
> >>>>>>>> Existing functionality of mono_delivery_time remains unaltered=
 here,
> >>>>>>>> instead just extended with userspace tstamp support for bridge=

> >>>>>>>> forwarding path.
> >>>>>>>
> >>>>>>> The patch currently broke the bpf selftest test_tc_dtime:
> >>>>>>> https://github.com/kernel-patches/bpf/actions/runs/8242487344/j=
ob/22541746675
> >>>>>>>
> >>>>>>> In particular, there is a uapi field __sk_buff->tstamp_type whi=
ch currently has
> >>>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "=
delivery" time.
> >>>>>>> BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx=
 timestamp at
> >>>>>>> ingress or a delivery time set by user space).
> >>>>>>>
> >>>>>>> __sk_buff->tstamp_type depends on skb->mono_delivery_time which=
 does not
> >>>>>>> necessarily mean mono after this patch. I thought about fixing =
it on the bpf
> >>>>>>> side such that reading __sk_buff->tstamp_type only returns
> >>>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time i=
s set and skb->sk
> >>>>>>> is IPPROTO_TCP. However, it won't work because of bpf_skb_set_t=
stamp().
> >>>>>>>
> >>>>>>> There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp,
> >>>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb=
->tstamp and the
> >>>>>>> skb->mono_delivery_time. The expectation is this could change s=
kb->tstamp in the
> >>>>>>> ingress skb and redirect to egress sch_fq. It could also set a =
mono time to
> >>>>>>> skb->tstamp where the udp sk->sk_clockid may not be necessary i=
n mono and then
> >>>>>>> bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tst=
amp,
> >>>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tsta=
mp_type expects
> >>>>>>> BPF_SKB_TSTAMP_DELIVERY_MONO also.
> >>>>>>>
> >>>>>>> I ran out of idea to solve this uapi breakage.
> >>>>>>>
> >>>>>>> I am afraid it may need to go back to v1 idea and use another b=
it
> >>>>>>> (user_delivery_time) in the skb.
> >>>>>>
> >>>>>> Is the only conflict when bpf_skb_set_tstamp is called for an sk=
b from
> >>>>>> a socket with sk_clockid set (and thus SO_TXTIME called)?
> >>>>>
> >>>>> Right, because skb->mono_delivery_time does not mean skb->tstamp =
is mono now and
> >>>>> its interpretation depends on skb->sk->sk_clockid.
> >>>>>
> >>>>>> Interpreting skb->tstamp as mono if skb->mono_delivery_time is s=
et and
> >>>>>> skb->sk is NULL is fine. This is the ingress to egress redirect =
case.
> >>>>>
> >>>>> skb->sk =3D=3D NULL is fine. I tried something like this in
> >>>>> bpf_convert_tstamp_type_read() for reading __sk_buff->tstamp_type=
:
> >>>>>
> >>>>> __sk_buff->tstamp_type is BPF_SKB_TSTAMP_DELIVERY_MONO when:
> >>>>>
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0skb->mono_delivery_time =3D=3D 1 &&
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0(!skb->sk ||
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 !sk_fullsock(skb->sk) /* tcp tw or req =
sk */ ||
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 skb->sk->sk_protocol =3D=3D IPPROTO_TCP=
)
> >>>>>
> >>>>> Not a small bpf instruction addition to bpf_convert_tstamp_type_r=
ead() but doable.
> >>>>>
> >>>>>>
> >>>>>> I don't see an immediate use for this BPF function on egress whe=
re it
> >>>>>> would overwrite an SO_TXTIME timestamp and now skb->tstamp is mo=
no,
> >>>>>> but skb->sk !=3D NULL and skb->sk->sk_clockid !=3D CLOCK_MONOTON=
IC.
> >>>>>
> >>>>> The bpf prog may act as a traffic shaper that limits the bandwidt=
h usage of all
> >>>>> outgoing packets (tcp/udp/...) by setting the mono EDT in skb->ts=
tamp before
> >>>>> sending to the sch_fq.
> >>>>>
> >>>>> I currently also don't have a use case for skb->sk->sk_clockid !=3D=

> >>>>> CLOCK_MONOTONIC. However, it is something that bpf_skb_set_tstamp=
() can do now
> >>>>> before queuing to sch_fq.
> >>>>>
> >>>>> The container (in netns + veth) may use other sk_clockid/qdisc (e=
g. sch_etf)
> >>>>> setup and the non mono skb->tstamp is not cleared now during dev_=
forward_skb()
> >>>>> between the veth pair.
> >>>>>
> >>>>>>
> >>>>>> Perhaps bpf_skb_set_tstamp() can just fail if another delivery t=
ime is
> >>>>>> already explicitly programmed?
> >>>>>
> >>>>> This will change the existing bpf_skb_set_tstamp() behavior, so p=
robably not
> >>>>> acceptable.
> >>>>>
> >>>>>>
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->sk &&
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock_flag(sk, SOCK_TXTIME) &&
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->sk->sk_clockid !=3D CLOCK_M=
ONOTONIC
> >>>>>
> >>>>>> Either that, or unset SOCK_TXTIME to make sk_clockid undefined a=
nd
> >>>>>> fall back on interpreting as monotonic.
> >>>>>
> >>>>> Change sk->sk_flags in tc bpf prog? hmm... I am not sure this wil=
l work well also.
> >>>>>
> >>>>> sock_valbool_flag(SOCK_TXTIME) should require a lock_sock() to ma=
ke changes. The
> >>>>> tc bpf prog cannot take the lock_sock, so bpf_skb_set_tstamp() cu=
rrently only
> >>>>> changes skb and does not change skb->sk.
> >>>>>
> >>>>> I think changing sock_valbool_flag(SOCK_TXTIME) will also have a =
new user space
> >>>>> visible side effect. The sendmsg for cmsg with SCM_TXTIME will st=
art failing
> >>>>> from looking at __sock_cmsg_send().
> >>>>>
> >>>>> There may be a short period of disconnect between what is in sk->=
sk_flags and
> >>>>> what is set in skb->tstamp. e.g. what if user space does setsocko=
pt(SO_TXTIME)
> >>>>> again after skb->tstamp is set by bpf. This could be considered a=
 small glitch
> >>>>> for some amount of skb(s) until the user space settled on setsock=
opt(SO_TXTIME).
> >>>>>
> >>>>> I think all this is crying for another bit in skb to mean user_de=
livery_time
> >>>>> (skb->tstamp depends on skb->sk->sk_clockid) while mono_delivery_=
time is the
> >>>>> mono time either set by kernel-tcp or bpf.
> >>>>
> >>>> It does sound like the approach with least side effects.
> >>>>
> >>>> If we're going to increase to two bits per skb, it's perhaps
> >>>> better to just encode the (selected supported) CLOCK_ type, rather=

> >>>> than only supporting clockid through skb->sk->sk_clockid.
> >>>
> >>> Good idea. May be starting with mono and tai (Abishek's use case?),=
 only forward these two clocks and reset the skb->tstamp for others.
> >>>
> >>>>
> >>>> This BPF function is the analogue to SO_TXTIME. It is clearly
> >>>> extensible to additional BPF_SKB_TSTAMP_DELIVERY_.. types. To
> >>>> work with sch_etf, say.
> >>>
> >>> Yes, if there are bits in skb to describe the clock in the skb->tst=
amp, BPF_SKB_TSTAMP_DELIVERY_ can be extended to match it. It will be eas=
ier if the values in the skb bits is the same as the BPF_SKB_TSTAMP_DELIV=
ERY_*.
> >>>
> >>> The bpf_convert_tstamp_*() and the bpf_skb_set_tstamp helper will n=
eed changes to include the consideration of these two bits. I think we ha=
ve mostly settled with the approach (thanks for the discussion!). Abhishe=
k, not sure how much can be reused from this patch for the two bits appor=
ach, do you want to revert the current patch first and then start from cl=
ean?
> >>>
> >> Yes , I think since we have concluded the two bit .(Thanks for discu=
ssion again, Martin and Willem)
> >>
> >> Here is what i will do from myside
> >> 1. Revert the v4 patch :-  net: Re-use and set mono_delivery_time bi=
t for userspace tstamp packets
> >> 2. Keep mono_delivery_time as ease
> >> 3. Add user_delivery_time as a new bitfield
> >> 4. Add BPF_SKB_TSTAMP_DELIVERY_TAI in the bpf.h for etf support
> >> 5. do not reset the time if either mono_delivery_time or user_delive=
ry_time is set.
> >>
> >> Let me know if i have covered all the design details or add if i mis=
sed anything.
> > =

> > Thanks for revising this.
> > =

> > No need to add the BPF part here.
> > =

> > I was mistaken that we can encode the clock_id in two skb bits.
> > SO_TXTIME allows essentially all CLOCK_...
> =

> The two bits could potentially only encode the delivery time that is al=
lowed to =

> be forwarded without reset. 0 could mean refering back to sk_clockid an=
d don't =

> forward. The final consumer of the forwarded skb->tstamp is the qdisc w=
hich =

> currently only has mono and tai.

So the followinng meaning of bit pair
{ skb->mono_delivery_time, skb->user_delivery_time } ?
 =

- { 0, 0 } legacy skb->tstamp: realtime on rx
- { 1, 0 } skb->tstamp is mono: existing behavior of mono_delivery_time b=
it
- { 0, 1 } skb->tstamp is tai: analogous to mono case
- { 1, 1 } skb->tstamp defined by skb->sk->sk_clockid

> The concern is more on future extension to =

> allow more clock type to be forwarded?

Right. Not because I have an immediate use for them. Only because
SO_TXTIME already allows configuring other values for sk_clockid.
  =

> I don't have a use case for having BPF_SKB_TSTAMP_DELIVERY_TAI but curi=
ous on =

> how other clock types are used now.
> =

> Thanks.
> =

> > =

> > So indeed we will need a user_delivery_time bit and use that to look
> > at sk_clockid.
> =




