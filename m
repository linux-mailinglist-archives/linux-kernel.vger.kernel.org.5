Return-Path: <linux-kernel+bounces-117874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7352988B5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9636BE69FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD41CD10;
	Mon, 25 Mar 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oePNBB8M"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648241C75
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396623; cv=none; b=ABbGoiar0GPcO2auMRcnKWzkDMpA/r/hN6CKJhA9UrPoQ9S3iiaaqtAV2su3mFoS1Ed42ndShOhZ8URV2Oy56ZLuej0FG5PR7rygsNdBUoGtLuOAlOGVCrzR0fO2W+eZMI9W9lxm8+EUtm9e21USYkn086ucam1oWOahq/pAm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396623; c=relaxed/simple;
	bh=vWN8XohjF1v16NaONsUY1Gt8ubP1b/GsLgsncu1sBW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jy+Cqzs+Bh0xbbG3Xg7vypV0F5VLpGB8OoJKYugbHksh9PCulI8oviJ+8ZF8D/dIUQAgQTCA20nXM9aaSCc928Yc4viHO7l01BOINmndwSDKqiSbzsEg3/XHtmQBLDpi712Uab+ctujM3VldmOF2Cx9u2u3vXSWDMPV6l1qlqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oePNBB8M; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c1a50b004so340a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711396618; x=1712001418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLJhanTyYYdfYx8SCY5kJ/vKByOFilWX6UgvBGxwVFs=;
        b=oePNBB8MQMYPsKW/5WHuQZmLxgAa/YZOagIRucRtWK0uP8bl25Wtch3GC4Odg04guf
         xHwSUF5HkJZWVsEYqQHoC5gl5fQLBowrtOpHCUCd56a5c2IAlxI3KW4RLn0H97S7zQEh
         Fch3PreWQlXCon8Ff0Hh/n9iRfZEMBAYq8wONKKFjwJu21evFXzJNZ2JfkNXcrdRmAD7
         jpuaYI98g64Ud0+Bl1qubff67uJTRnoUOhZSXX9YPQ0cQ8W8hRLS7sVrmq7gYo8p1LYp
         AKEL4y6c7Gl0kxDKHbonRmurI6OeNy746pBWypmNCQupiQqMRV2aaB7P4blaKbtO35e+
         VkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396618; x=1712001418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLJhanTyYYdfYx8SCY5kJ/vKByOFilWX6UgvBGxwVFs=;
        b=ZOQMcIHhBAuLJrGw22VZXp7haEYH9y2CzIA57r38sUzoqg/myQRBH8HXc9pX0rfPcU
         5lDlwXgLtueV9DeEFUnRqeWS7xfGhuIr92QLC6rU7YTzzaQG64CYd5ua/mtpz2BEjFXj
         vmEVowB0XG5XuRw3WQqSmttwc2VBIPzeSs9XWWzuB/j0aR9q+kSVKtY/PkIs/sbub3Ux
         kZ0I8TmCkwZjDUpr17UeB4q1sS6LE9HG4s4Va1ZYRrolx7NZFSW+ow0x2ccMYKUTr+Sb
         DyTwILrw7TYr/o7174dZoQ9RH2m5BRBPwEflujlHzyteqQt1bcJT2cApckrsSAaMJRSW
         uGLw==
X-Forwarded-Encrypted: i=1; AJvYcCVCJ0fFGWJWCtAophIqnwvt1EA73bPzK1QoiyUIbUeauSxGTmmmiX7riPo68iOhcxiXmafabc0zvTN4jbHj80oED4p/p7MPUcXc0ShL
X-Gm-Message-State: AOJu0Yyys1ytOcRLl4u24TDoM4dylcGEiS9pfYz6HSJE6AcV3CcOJgRt
	Bw83AThxoKzTrGyu8AGJWfiIrL1ZoBGxZa7hPXP+ngfw7iT1AT11F6/lw8XAFZ3TguPfwkU04O6
	Dbcbh6oH+46Yf+1gdqaRTcoZnHxR1eZCXRjPJ
X-Google-Smtp-Source: AGHT+IEEovVpf0oepuwhkpM9avNZcmI74a08OoVnLRWfgzWtpVlsKJKZjmEasujTdhOur6vk4jcXRCYWXsOAyA0/og4=
X-Received: by 2002:a05:6402:28a:b0:568:856b:f3c5 with SMTP id
 l10-20020a056402028a00b00568856bf3c5mr622edv.1.1711396617881; Mon, 25 Mar
 2024 12:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iL_Oz58VYNLJ6eB=qgmsgY9juo9xAhaPKKaDqOxrjf+0w@mail.gmail.com>
 <20240325.183800.473265130872711273.syoshida@redhat.com> <CANn89i+VZMvm7YpvPatmQuXeBgh78iFvkFSLYR-KYub4aa6PEg@mail.gmail.com>
 <20240326.024626.67077498140213947.syoshida@redhat.com>
In-Reply-To: <20240326.024626.67077498140213947.syoshida@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Mar 2024 20:56:43 +0100
Message-ID: <CANn89i+uOWhSmgudL+84e-2wow0mNLKe0f_bn5qCVoEUf+dJ=Q@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: Fix uninit-value access in __ip_make_skb()
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 6:46=E2=80=AFPM Shigeru Yoshida <syoshida@redhat.co=
m> wrote:
>
> On Mon, 25 Mar 2024 11:05:33 +0100, Eric Dumazet wrote:
> > On Mon, Mar 25, 2024 at 10:38=E2=80=AFAM Shigeru Yoshida <syoshida@redh=
at.com> wrote:
> >>
> >> On Mon, 25 Mar 2024 10:01:25 +0100, Eric Dumazet wrote:
> >> > On Sun, Mar 24, 2024 at 6:06=E2=80=AFAM Shigeru Yoshida <syoshida@re=
dhat.com> wrote:
> >> >>
> >> >> KMSAN reported uninit-value access in __ip_make_skb() [1].  __ip_ma=
ke_skb()
> >> >> tests HDRINCL to know if the skb has icmphdr. However, HDRINCL can =
cause a
> >> >> race condition. If calling setsockopt(2) with IP_HDRINCL changes HD=
RINCL
> >> >> while __ip_make_skb() is running, the function will access icmphdr =
in the
> >> >> skb even if it is not included. This causes the issue reported by K=
MSAN.
> >> >>
> >> >> Check FLOWI_FLAG_KNOWN_NH on fl4->flowi4_flags instead of testing H=
DRINCL
> >> >> on the socket.
> >> >>
> >> >> [1]
> >> >
> >> > What is the kernel version for this trace ?
> >>
> >> Sorry, I used the following version:
> >>
> >> CPU: 1 PID: 15709 Comm: syz-executor.7 Not tainted 6.8.0-11567-gb3603f=
cb79b1 #25
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.f=
c39 04/01/2014
> >>
> >> >> BUG: KMSAN: uninit-value in __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip=
_output.c:1481
> >> >>  __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
> >> >>  ip_finish_skb include/net/ip.h:243 [inline]
> >> >>  ip_push_pending_frames+0x4c/0x5c0 net/ipv4/ip_output.c:1508
> >> >>  raw_sendmsg+0x2381/0x2690 net/ipv4/raw.c:654
> >> >>  inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
> >> >>  sock_sendmsg_nosec net/socket.c:730 [inline]
> >> >>  __sock_sendmsg+0x274/0x3c0 net/socket.c:745
> >> >>  __sys_sendto+0x62c/0x7b0 net/socket.c:2191
> >> >>  __do_sys_sendto net/socket.c:2203 [inline]
> >> >>  __se_sys_sendto net/socket.c:2199 [inline]
> >> >>  __x64_sys_sendto+0x130/0x200 net/socket.c:2199
> >> >>  do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
> >> >>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> >> >>
> >> >> Uninit was created at:
> >> >>  slab_post_alloc_hook mm/slub.c:3804 [inline]
> >> >>  slab_alloc_node mm/slub.c:3845 [inline]
> >> >>  kmem_cache_alloc_node+0x5f6/0xc50 mm/slub.c:3888
> >> >>  kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:577
> >> >>  __alloc_skb+0x35a/0x7c0 net/core/skbuff.c:668
> >> >>  alloc_skb include/linux/skbuff.h:1318 [inline]
> >> >>  __ip_append_data+0x49ab/0x68c0 net/ipv4/ip_output.c:1128
> >> >>  ip_append_data+0x1e7/0x260 net/ipv4/ip_output.c:1365
> >> >>  raw_sendmsg+0x22b1/0x2690 net/ipv4/raw.c:648
> >> >>  inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
> >> >>  sock_sendmsg_nosec net/socket.c:730 [inline]
> >> >>  __sock_sendmsg+0x274/0x3c0 net/socket.c:745
> >> >>  __sys_sendto+0x62c/0x7b0 net/socket.c:2191
> >> >>  __do_sys_sendto net/socket.c:2203 [inline]
> >> >>  __se_sys_sendto net/socket.c:2199 [inline]
> >> >>  __x64_sys_sendto+0x130/0x200 net/socket.c:2199
> >> >>  do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
> >> >>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> >> >>
> >> >> Fixes: 99e5acae193e ("ipv4: Fix potential uninit variable access bu=
g in __ip_make_skb()")
> >> >> Reported-by: syzkaller <syzkaller@googlegroups.com>
> >> >> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> >> >> ---
> >> >> I think IPv6 has a similar issue. If this patch is accepted, I will=
 send
> >> >> a patch for IPv6.
> >> >> ---
> >> >>  net/ipv4/ip_output.c | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> >> >> index 1fe794967211..39229fd0601a 100644
> >> >> --- a/net/ipv4/ip_output.c
> >> >> +++ b/net/ipv4/ip_output.c
> >> >> @@ -1473,7 +1473,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk=
,
> >> >>                  * by icmp_hdr(skb)->type.
> >> >>                  */
> >> >>                 if (sk->sk_type =3D=3D SOCK_RAW &&
> >> >> -                   !inet_test_bit(HDRINCL, sk))
> >> >> +                   !(fl4->flowi4_flags & FLOWI_FLAG_KNOWN_NH))
> >> >>                         icmp_type =3D fl4->fl4_icmp_type;
> >> >>                 else
> >> >>                         icmp_type =3D icmp_hdr(skb)->type;
> >> >> --
> >> >> 2.44.0
> >> >>
> >> >
> >> > Thanks for your patch.
> >> >
> >> > I do not think this is enough, as far as syzkaller is concerned.
> >> >
> >> > raw_probe_proto_opt() can leave garbage in fl4_icmp_type (and fl4_ic=
mp_code)
> >>
> >> Thank you for your comment. But I don't understand it clearly. What
> >> exactly do you mean by "garbage"?
> >>
> >> raw_probe_proto_opt() immediately returns 0 if fl4->flowi4_proto is
> >> not IPPROTO_ICMP:
> >>
> >> static int raw_probe_proto_opt(struct raw_frag_vec *rfv, struct flowi4=
 *fl4)
> >> {
> >>         int err;
> >>
> >>         if (fl4->flowi4_proto !=3D IPPROTO_ICMP)
> >>                 return 0;
> >>
> >> In this case, the function doesn't set fl4_icmp_type. Do you mean this
> >> case?
> >
> > There are multiple ways to return early from this function.
> >
> > In all of them, fl4->fl4_icmp_type is left uninitialized, so syzbot
> > will find ways to trigger a related bug,
> > if you assume later that fl4->fl4_icmp_type contains valid (initialized=
) data.
>
> Thank you for your reply. I see your point.
>
> fl4->fl4_icmp_type is part of flowi_uli union in flowi4 structure, and
> flowi4_init_output() initializes fl4_dport and fl4_sport to zero.
>
> I thought this also initializes fl4_icmp_type and fl4_icmp_code. Do
> you think we should initialize fl4_icmp_type and fl4_icmp_code
> explicitly, otherwise am I misunderstanding?

Yes, I am precisely saying this : do not rely on some union layout,
without mentioning it in the changelog
or even better in a comment.

If you want to avoid clearing these fields, please add a
BUILD_BUG_ON() to make sure
a unrelated future change in include/net/flow.h does not break a
hidden assumption.

(ie : clearing fl4_dport and fl4_sport also clears fl4_icmp_type and
fl4_icmp_code.)

