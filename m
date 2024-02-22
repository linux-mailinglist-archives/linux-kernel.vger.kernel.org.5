Return-Path: <linux-kernel+bounces-76076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE985F29F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94041F2257B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BECD19478;
	Thu, 22 Feb 2024 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUbwh1ro"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734BE21A06
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589670; cv=none; b=ZU1SWFuH7XP6f6wYv3QrygVnKIU597Ogd5hfOvEOjJYAGO7MsOqJMLx/VrUCpL6NFZG4V7xof6Yyk7B8tTCULq5Ignitmwv7gyoCTg3/RK/UfS6KDhAAsk1PlG5axrluPfABmBghqEWRysitmsoE44gnWTi5RyxYbHUlqmlOauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589670; c=relaxed/simple;
	bh=EqD816pglUnsi5Oj/BjrpKl6ESqtw1vpOgd1NM0G+0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtiqkPIP5ojVO5tIaejN2ZWUUJ6FzWKZlulRs2yVw63AA4/jTqh5h/ecPA/NZ6emYFyWTTVQkTGHcKk0B22SMJSRekfmH4A9khz0bfR4ZUqv8f7HoGHisY6VQR6GvGg+MPOfqgHhSfKarBE9roIPZgUyiskKx9GOTTkZswcG5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUbwh1ro; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5654a367f53so282a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708589667; x=1709194467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xURSw6KW5lgBMAPfJSy1M5ugizuie720TfwPyi4dy7w=;
        b=DUbwh1royOtkFeGUCM58F8ooKIFHeOB08ZCPfg6u68PjgG8FL+LbEng4MAdLie1+jM
         R6RTX9teZvLo+whHoyF46jGOa2Wv6nrHjhJfxph72NssR/Vz7HR5t5Hins8wTJYVZDld
         VXEPTDcfzHpfL2NXztvK/i8WX98FIXf7Sylph4i66J0e3GZcUP+dJtK/wFvKS+veVsM7
         REEi7G6BIFXKdVtBfPGG8SSc4RoGhkCwJFqci46yE7t/MThyvn5WJGDd9SHEhocdd9KG
         091WneYqaZq80u0u/nuRQlwFuk2YL6WdNSqdvxXZo9FItFAu7JH7fIKwuDxJkNPt0dPj
         MXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589667; x=1709194467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xURSw6KW5lgBMAPfJSy1M5ugizuie720TfwPyi4dy7w=;
        b=kDYYGBHX5JD+wIJPDrE/79cITHZjcAE+TGUGrO4MekMpEXwjOwdJwznW2a1MuCnHNi
         QZ5M6787T1OHQDkBTMaAi/5BubboQBvvy2yiamIey61ICH9rlcXefOVBk8aEu7OIgE1M
         hXYq43J6S9624dAH/pCS8x6aLI8ttQ6/LRWhjVASbt5fcpZ/2dYfiwpR4COVI2vyI8CL
         iAJgKBY5cVhIeREqCiRr2hFr199cyf1+wTIFj33Sdt/dY8IrLomrWNjn4pDAZ/5Y2ts8
         ZqgX+clQcQPxYLNadn8surpndCeurUsJDOGtOTcF2+rv/Z5/worOYdTEj5q8w0CoHBoH
         IRig==
X-Forwarded-Encrypted: i=1; AJvYcCXi1bhureD09WmoOZWel2CDPRrx8nQaicliBt/kMfFzNm1Wg/nFB2SVF72RCevZ68p0SkxVQUemKPcyTFuG9bOiLqeWuX5PYPtBgago
X-Gm-Message-State: AOJu0YyOQbENXdByQ3XVUAnzw+WSBxiZC5aOJtqh7we6mwlXjxFq9+dt
	jYBq8ciBr0IV8m89cztRsZ+QSvgnpGFXILBYvhnV/RaL87tNfFf/kpXGwghAkpYRgFk0nsgRYh9
	gBgKJKAbtOXsGi77DhhfiAoyoxSdRvNxKMfsV
X-Google-Smtp-Source: AGHT+IEhNRpSD3V4Kd1YDoiUYxCZDYN7V/CdJM76FoVbz+kC3zNa50XoyMT4GOhawNfJSBTFli8Jmw5zYJiKSvrelgs=
X-Received: by 2002:a50:f615:0:b0:563:c0e0:667c with SMTP id
 c21-20020a50f615000000b00563c0e0667cmr391120edn.0.1708589666422; Thu, 22 Feb
 2024 00:14:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000043b1310611e388aa@google.com> <20240221131546.GE15988@breakpoint.cc>
In-Reply-To: <20240221131546.GE15988@breakpoint.cc>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Feb 2024 09:14:15 +0100
Message-ID: <CANn89iK_D+v2J7Ftg1W6-zn7KSZajwWVzfetSdrBPM6f_Zg80A@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in mpls_gso_segment
To: Florian Westphal <fw@strlen.de>
Cc: syzbot <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>, 
	davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:15=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> syzbot <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com> wrote:
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1536462c180=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/adbf5d8e38d7/d=
isk-49344462.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/0f8e3fb78410/vmli=
nux-49344462.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/682f4814bf23=
/bzImage-49344462.xz
> >
> > The issue was bisected to:
> >
> > commit 219eee9c0d16f1b754a8b85275854ab17df0850a
> > Author: Florian Westphal <fw@strlen.de>
> > Date:   Fri Feb 16 11:36:57 2024 +0000
> >
> >     net: skbuff: add overflow debug check to pull/push helpers
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13262752=
180000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D10a62752=
180000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17262752180=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com
> > Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/pus=
h helpers")
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 pskb_may_pull_=
reason include/linux/skbuff.h:2723 [inline]
> > WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 pskb_may_pull =
include/linux/skbuff.h:2739 [inline]
> > WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 mpls_gso_segme=
nt+0x773/0xaa0 net/mpls/mpls_gso.c:34
>
> Two possible solutions:
>
> 1.)
>
> diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
> index 533d082f0701..43801b78dd64 100644
> --- a/net/mpls/mpls_gso.c
> +++ b/net/mpls/mpls_gso.c
> @@ -25,12 +25,13 @@ static struct sk_buff *mpls_gso_segment(struct sk_buf=
f *skb,
>         netdev_features_t mpls_features;
>         u16 mac_len =3D skb->mac_len;
>         __be16 mpls_protocol;
> -       unsigned int mpls_hlen;
> +       int mpls_hlen;
>
>         skb_reset_network_header(skb);
>         mpls_hlen =3D skb_inner_network_header(skb) - skb_network_header(=
skb);
> -       if (unlikely(!mpls_hlen || mpls_hlen % MPLS_HLEN))
> +       if (unlikely(mpls_hlen <=3D 0 || mpls_hlen % MPLS_HLEN))
>                 goto out;
> +
>         if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
>                 goto out;

I guess we should try this, or perhaps understand why
skb->encapsulation might not be set,
or why skb_inner_network_header(skb) is not set at this point.

>
> (or a variation thereof).
>
> 2) revert the pskb_may_pull_reason change added in 219eee9c0d16f1b754a8 t=
o
> make it tolerant to "negative" (huge) may-pull requests again.
>
> With above repro, skb_inner_network_header() yields 0, skb_network_header=
()
> returns 108, so we "pskb_may_pull(skb, -108)))" which now triggers
> DEBUG_NET_WARN_ON_ONCE() check.
>
> Before blamed commit, this would make pskb_may_pull hit:
>
>         if (unlikely(len > skb->len))
>                 return SKB_DROP_REASON_PKT_TOO_SMALL;
>
> and mpls_gso_segment takes the 'goto out' label.
>
> So question is really if we should fix this in mpls_gso (and possible oth=
ers
> that try to pull negative numbers...) or if we should legalize this, eith=
er by
> adding explicit if (unlikely(len > INT_MAX)) test to pskb_may_pull_reason=
 or
> by adding a comment that negative 'len' numbers are expected to be caught=
 by
> the check vs. skb->len.
>
> Opinions?

Lets live without 2) for a while, try to fix callers ?

