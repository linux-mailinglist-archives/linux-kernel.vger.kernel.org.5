Return-Path: <linux-kernel+bounces-116785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CF788A3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDAA2E3295
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DE8181BBC;
	Mon, 25 Mar 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9LCoRgZ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B568199E8A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361149; cv=none; b=g9/8Zll0KTYP62/g3Z4YF5Wp+s5N5FzluxO3AzfJHxhucXDUiIWU5+4eKG8InDitT5B+MmiT2VsLBdBStG2AdbGP85ReDoEG2C6UxJ4L0TPbJeQommrFPpyxfTMGmgGr4o03hy1I4nqk9zsB57TNtQEGaNaudTlSOrS3BgpKjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361149; c=relaxed/simple;
	bh=+jhV52bal85mD3CXpudud6EoSW66gCmXp4eqojLaj9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trjPE8+kglE1vXoLExVRYEEZv3BUWWzeHzuQokGjRY/sWV4dg36sGF6eFp7PBwUoGGir8AU/SagFmIR6lu2+nPYL0OlIcsGaV7ZXQzGEmqzlJ8JgiSXt7kR8VX8Z+BEHLEL3DR8awh3Vkz48Cfez+BetO37cE7D4HbRePx7GJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9LCoRgZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c1a50b004so2551a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711361145; x=1711965945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoiT2n6Yi3d00YcHBvfYpjh1CDZ627EZJhhUjywg0l0=;
        b=d9LCoRgZReFtfie4FC0lmridNgs6RYKsco5RAMuuKlGhc0KA3Lvd13h+NG8rHhPmPs
         Gny36mXasKRYnk6P5d8+3FqmkQm3pXCrGHLZ3/ERCCaKuSaXbAigGrXjS1d3FF3LFr0c
         uGgvosmeMlYvaLvrP180CpYXO1NfRzzuJhSiguL4oD/PYIKw36d4gpOKXzsY7hXD8x+a
         LvJuW7R52/GQqPjriXdSd2GhXfhf6kKlVE7eH1Ym3S3de99b/2DjW5rW4/NwC2+ZabPU
         BHAgHYzzN7CcfXY8nJhQfabATPz4zjEkZNcS364Mkl1BI7eY4mQvsvg/ktUo8g/V7Jzk
         ebEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361145; x=1711965945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoiT2n6Yi3d00YcHBvfYpjh1CDZ627EZJhhUjywg0l0=;
        b=O08iP4YDzw8F+3vHCeLeh2U14V5cq2soly1J8046vOoUeEriG012ePqAcmzqBuRtMP
         lhxzGBBwt/+fTZLkbpOzN2LPacvLo8QUw5HuqFgrNDpB/qa5b55YsW6ru4RZzyPoYz+s
         4NmEjKJuErBfHsOQBqLtMXcGmdONa0XhWkUEMCWmtN3ndNhOa0OsmkNo0+iC6cEFB2/G
         TjG7q9Ewu6/EiaMtKx1fdRBZ0QI2NChYOvWbYhx/bmhhtzJ+5X90TXu535aKll798BkC
         s5LFQSiHsUFzS2hE57eejYLAz+HAKSBjAhlRmFLjpCf7jZ14C90ZhVUeHiYxN8l2F/Nf
         aHiA==
X-Forwarded-Encrypted: i=1; AJvYcCXYn3s2gFBGHUPKfM7g8QqvBIvKinaNT545hwRXQDCzr/rFCw6IFqE+GSMxkNcnprDgFXY7D9AVu9OYQUdpr3onh0Om14KWXrCMG+Ij
X-Gm-Message-State: AOJu0YzR/6afM/DqdRLmuAmd6gyhCQkG5pCaI+JrkLQlZ2rbHZpUsF6u
	/mRZ0mrv7b0qF7SaRSAwQXFnjkCx1FvWka7x2GLG+zF4PMWxsedmwehzVL9Zk3041RNAAFTrqKU
	lYoHIR3AEFSwZ6S+tQq3jeM/fxGSd9n8uddqk
X-Google-Smtp-Source: AGHT+IH3z0zRq03nVuaQDRwAJwU6dTgc9PGIzVceNPR7LTN/Ml6pDakMuvc7evYIuEtT/XesUJ5MCranpHjm0FIgT4k=
X-Received: by 2002:aa7:da8b:0:b0:568:7767:14fd with SMTP id
 q11-20020aa7da8b000000b00568776714fdmr659526eds.7.1711361144563; Mon, 25 Mar
 2024 03:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324050554.1609460-1-syoshida@redhat.com> <CANn89iL_Oz58VYNLJ6eB=qgmsgY9juo9xAhaPKKaDqOxrjf+0w@mail.gmail.com>
 <20240325.183800.473265130872711273.syoshida@redhat.com>
In-Reply-To: <20240325.183800.473265130872711273.syoshida@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Mar 2024 11:05:33 +0100
Message-ID: <CANn89i+VZMvm7YpvPatmQuXeBgh78iFvkFSLYR-KYub4aa6PEg@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: Fix uninit-value access in __ip_make_skb()
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:38=E2=80=AFAM Shigeru Yoshida <syoshida@redhat.c=
om> wrote:
>
> On Mon, 25 Mar 2024 10:01:25 +0100, Eric Dumazet wrote:
> > On Sun, Mar 24, 2024 at 6:06=E2=80=AFAM Shigeru Yoshida <syoshida@redha=
t.com> wrote:
> >>
> >> KMSAN reported uninit-value access in __ip_make_skb() [1].  __ip_make_=
skb()
> >> tests HDRINCL to know if the skb has icmphdr. However, HDRINCL can cau=
se a
> >> race condition. If calling setsockopt(2) with IP_HDRINCL changes HDRIN=
CL
> >> while __ip_make_skb() is running, the function will access icmphdr in =
the
> >> skb even if it is not included. This causes the issue reported by KMSA=
N.
> >>
> >> Check FLOWI_FLAG_KNOWN_NH on fl4->flowi4_flags instead of testing HDRI=
NCL
> >> on the socket.
> >>
> >> [1]
> >
> > What is the kernel version for this trace ?
>
> Sorry, I used the following version:
>
> CPU: 1 PID: 15709 Comm: syz-executor.7 Not tainted 6.8.0-11567-gb3603fcb7=
9b1 #25
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39=
 04/01/2014
>
> >> BUG: KMSAN: uninit-value in __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_ou=
tput.c:1481
> >>  __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
> >>  ip_finish_skb include/net/ip.h:243 [inline]
> >>  ip_push_pending_frames+0x4c/0x5c0 net/ipv4/ip_output.c:1508
> >>  raw_sendmsg+0x2381/0x2690 net/ipv4/raw.c:654
> >>  inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
> >>  sock_sendmsg_nosec net/socket.c:730 [inline]
> >>  __sock_sendmsg+0x274/0x3c0 net/socket.c:745
> >>  __sys_sendto+0x62c/0x7b0 net/socket.c:2191
> >>  __do_sys_sendto net/socket.c:2203 [inline]
> >>  __se_sys_sendto net/socket.c:2199 [inline]
> >>  __x64_sys_sendto+0x130/0x200 net/socket.c:2199
> >>  do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
> >>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> >>
> >> Uninit was created at:
> >>  slab_post_alloc_hook mm/slub.c:3804 [inline]
> >>  slab_alloc_node mm/slub.c:3845 [inline]
> >>  kmem_cache_alloc_node+0x5f6/0xc50 mm/slub.c:3888
> >>  kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:577
> >>  __alloc_skb+0x35a/0x7c0 net/core/skbuff.c:668
> >>  alloc_skb include/linux/skbuff.h:1318 [inline]
> >>  __ip_append_data+0x49ab/0x68c0 net/ipv4/ip_output.c:1128
> >>  ip_append_data+0x1e7/0x260 net/ipv4/ip_output.c:1365
> >>  raw_sendmsg+0x22b1/0x2690 net/ipv4/raw.c:648
> >>  inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
> >>  sock_sendmsg_nosec net/socket.c:730 [inline]
> >>  __sock_sendmsg+0x274/0x3c0 net/socket.c:745
> >>  __sys_sendto+0x62c/0x7b0 net/socket.c:2191
> >>  __do_sys_sendto net/socket.c:2203 [inline]
> >>  __se_sys_sendto net/socket.c:2199 [inline]
> >>  __x64_sys_sendto+0x130/0x200 net/socket.c:2199
> >>  do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
> >>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> >>
> >> Fixes: 99e5acae193e ("ipv4: Fix potential uninit variable access bug i=
n __ip_make_skb()")
> >> Reported-by: syzkaller <syzkaller@googlegroups.com>
> >> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> >> ---
> >> I think IPv6 has a similar issue. If this patch is accepted, I will se=
nd
> >> a patch for IPv6.
> >> ---
> >>  net/ipv4/ip_output.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> >> index 1fe794967211..39229fd0601a 100644
> >> --- a/net/ipv4/ip_output.c
> >> +++ b/net/ipv4/ip_output.c
> >> @@ -1473,7 +1473,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
> >>                  * by icmp_hdr(skb)->type.
> >>                  */
> >>                 if (sk->sk_type =3D=3D SOCK_RAW &&
> >> -                   !inet_test_bit(HDRINCL, sk))
> >> +                   !(fl4->flowi4_flags & FLOWI_FLAG_KNOWN_NH))
> >>                         icmp_type =3D fl4->fl4_icmp_type;
> >>                 else
> >>                         icmp_type =3D icmp_hdr(skb)->type;
> >> --
> >> 2.44.0
> >>
> >
> > Thanks for your patch.
> >
> > I do not think this is enough, as far as syzkaller is concerned.
> >
> > raw_probe_proto_opt() can leave garbage in fl4_icmp_type (and fl4_icmp_=
code)
>
> Thank you for your comment. But I don't understand it clearly. What
> exactly do you mean by "garbage"?
>
> raw_probe_proto_opt() immediately returns 0 if fl4->flowi4_proto is
> not IPPROTO_ICMP:
>
> static int raw_probe_proto_opt(struct raw_frag_vec *rfv, struct flowi4 *f=
l4)
> {
>         int err;
>
>         if (fl4->flowi4_proto !=3D IPPROTO_ICMP)
>                 return 0;
>
> In this case, the function doesn't set fl4_icmp_type. Do you mean this
> case?

There are multiple ways to return early from this function.

In all of them, fl4->fl4_icmp_type is left uninitialized, so syzbot
will find ways to trigger a related bug,
if you assume later that fl4->fl4_icmp_type contains valid (initialized) da=
ta.

