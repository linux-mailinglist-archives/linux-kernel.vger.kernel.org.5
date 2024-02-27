Return-Path: <linux-kernel+bounces-82750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40DE868916
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416371F24965
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAE553391;
	Tue, 27 Feb 2024 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mACDuYgs"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED028366;
	Tue, 27 Feb 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015959; cv=none; b=heuePHfkWSx126dg9SVtGlszB4zQ4nyON5l37Jri4v4XC2rpZczz1ZuzCZLWc1Ovd5zSU2DDUCyuOG+29eP6Bli2RtCq3hcSBmwOFew/puQjHQZbBpfQEkyVgjF28wDxPyLNS7Dw52ez1Eu8LOchsSAcWIp00MjdeWL3fvvAoKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015959; c=relaxed/simple;
	bh=TpNm43UZalOh5CHEZxpB1myqjdM6GwK0aB5cvWnf9j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4Il0qefrINhp8BLcSAb+Okyza0RSESgg+5XDG36Nw7dITxDbOdqKsgYDJ0WHnF69Ga0Mw1ei+Gh8Y/LUcCCkSbjquOyZLR/pClEXRlio6giiJ7/KgfngEt/F+VE2R3xZIRESFwo83CMOL2g6PULwF7M+UM8rBJB8EaO1xjfO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mACDuYgs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4395b7bfe5so99732166b.0;
        Mon, 26 Feb 2024 22:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709015956; x=1709620756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeKhwBEW4l3tPZAIKnepBwuS085ALdBkSGDT8/kB2nM=;
        b=mACDuYgsyZUagMZvC3i2BarvkoajedpqTZdHi9DOPLwVdszTQPdOJ9Qm9sNcytdZzB
         xMG6YVrVWtEI8s6UJxS5MP9/uYDOnaDo+9RFTufYOmLFZhj2yLpkvxfg2U4ksWYSCyWV
         yYbMVfMxh3NnyY+CVUICKz7Zn/68mH0Ztmk+Xvx7KRlbiuk3Tj7tVQAi5sR+75V6cJwI
         MUhj49Q6oqFhx/MqCpbDia+uQVIKxI/GpRmU8ciAr4fNNhNZ6eHHiYZE/XKBfn/a3GUq
         HlkEkt5ZELLM6XcS9CjLKImATkskbYiUUNKrNLBG97uM6C9/yTNJUYLMucWhYNDVpAMJ
         rNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709015956; x=1709620756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeKhwBEW4l3tPZAIKnepBwuS085ALdBkSGDT8/kB2nM=;
        b=sCPz1RDFCy/vZFa7AR3P0ZltGHTiaqf0yPrsvYw/vFZVDt8fnDM+BNfFAzmYmPceLa
         O2ubd2MX4n8SXwGif6AnT8Nh23i0FEF4mzP621XsJ93pTBCgamqvzMVVrfHD+KDowCX0
         7/ehrTg3ca1KSddD+5d4PtlunVgJBgdRrvuDHBkJbdKSABTWxzspBE6bTmadIgEpqg1f
         t/46mCjoFwjcPBV+ZfNgpGRwsTpn1l5jFMcYpTVm+bXh0mGsjRbaaJK8pCExdMSRT149
         5r558fc0CH5po7kK7cbFG13QUgj5lC8tJyaK2yYU2xBccmbgYlGhb9lOLCvikGsjdKYd
         zBXg==
X-Forwarded-Encrypted: i=1; AJvYcCWDKv6aaHUBsXTvKPIFcZ+u0PcxT+D7h4qy9eSvxd1IAsfcK1y1KMmfy4RVnftPHCMgGlCTqTrdp34eNgchiafmj623BK3MLDNgwiMwl0QI2ExnKG7GHbYBO2L9JxAEHjzUtAk2OcRaKPgYP4DpyHd+fnevoyelQsKl1AmeJ5vj+drWYVh+jF9M
X-Gm-Message-State: AOJu0Yy/Rr0mmnOPE2Vu2GPyiCADRKgGlM79ajx+BTetYh7b23y2xRIj
	KaQGeS2l50Z0TWUkbFrHSYDBXkI0UpffdzikW5d/Ly056qXCawUUI0XdJYg6peQAP1OZr93SqLA
	e1Qt5GN50OmQ5ZYzKNCIZIW4XUW0=
X-Google-Smtp-Source: AGHT+IHN1QUtTaBkDh60yky4tJwi5Htl8PaJXfavM7yPRCg/hL/daSBc0cvs6PEmbTXUpBAwTZbCcN9cEda7+zl+Fos=
X-Received: by 2002:a17:906:f0c5:b0:a43:9e1f:240e with SMTP id
 dk5-20020a170906f0c500b00a439e1f240emr785440ejb.60.1709015956229; Mon, 26 Feb
 2024 22:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202402271050366715988@zte.com.cn> <CANn89iL-y9e_VFpdw=sZtRnKRu_tnUwqHuFQTJvJsv-nz1xPDw@mail.gmail.com>
In-Reply-To: <CANn89iL-y9e_VFpdw=sZtRnKRu_tnUwqHuFQTJvJsv-nz1xPDw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Feb 2024 14:38:38 +0800
Message-ID: <CAL+tcoDCq=ER65e7fHgLYZd9=XCnaHFLyGt4inXyKznB3S465Q@mail.gmail.com>
Subject: Re: [PATCH] net/ipv4: add tracepoint for icmp_send
To: Eric Dumazet <edumazet@google.com>
Cc: xu.xin16@zte.com.cn, davem@davemloft.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, yang.yang29@zte.com.cn, he.peilin@zte.com.cn, 
	liu.chun2@zte.com.cn, jiang.xuexin@zte.com.cn, zhang.yunkai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 1:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Feb 27, 2024 at 3:50=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
> >
> > From: xu xin <xu.xin16@zte.com.cn>
> >
> > Introduce a tracepoint for icmp_send, which can help users to get more
> > detail information conveniently when icmp abnormal events happen.
> >
> > 1. Giving an usecase example:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > When an application experiences packet loss due to an unreachable UDP
> > destination port, the kernel will send an exception message through the
> > icmp_send function. By adding a trace point for icmp_send, developers o=
r
> > system administrators can obtain the detailed information easily about =
the
> > UDP packet loss, including the type, code, source address, destination
> > address, source port, and destination port. This facilitates the
> > trouble-shooting of packet loss issues especially for those complicated
> > network-service applications.
> >
> > 2. Operation Instructions:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > Switch to the tracing directory.
> >         cd /sys/kernel/debug/tracing
> > Filter for destination port unreachable.
> >         echo "type=3D=3D3 && code=3D=3D3" > events/icmp/icmp_send/filte=
r
> > Enable trace event.
> >         echo 1 > events/icmp/icmp_send/enable
> >
> > 3. Result View:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  udp_client_erro-11370   [002] ...s.12   124.728002:  icmp_send:
> > icmp_send: type=3D3, code=3D3.From 127.0.0.1:41895 to 127.0.0.1:6666 ul=
en=3D23
> > skbaddr=3D00000000589b167a
> >
> > Signed-off-by: He Peilin <he.peilin@zte.com.cn>
> > Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> > Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> > Cc: Yang Yang <yang.yang29@zte.com.cn>
> > Cc: Liu Chun <liu.chun2@zte.com.cn>
> > Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> > ---
> >  include/trace/events/icmp.h | 57 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  net/ipv4/icmp.c             |  4 ++++
> >  2 files changed, 61 insertions(+)
> >  create mode 100644 include/trace/events/icmp.h
> >
> > diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> > new file mode 100644
> > index 000000000000..3d9af5769bc3
> > --- /dev/null
> > +++ b/include/trace/events/icmp.h
> > @@ -0,0 +1,57 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM icmp
> > +
> > +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_ICMP_H
> > +
> > +#include <linux/icmp.h>
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(icmp_send,
> > +
> > +               TP_PROTO(const struct sk_buff *skb, int type, int code)=
,
> > +
> > +               TP_ARGS(skb, type, code),
> > +
> > +               TP_STRUCT__entry(
> > +                               __field(__u16, sport)
> > +                               __field(__u16, dport)
> > +                               __field(unsigned short, ulen)
> > +                               __field(const void *, skbaddr)
> > +                               __field(int, type)
> > +                               __field(int, code)
> > +                               __array(__u8, saddr, 4)
> > +                               __array(__u8, daddr, 4)
> > +               ),
> > +
> > +               TP_fast_assign(
> > +                               // Get UDP header
> > +                               struct udphdr *uh =3D udp_hdr(skb);
> > +                               struct iphdr *iph =3D ip_hdr(skb);
> > +                               __be32 *p32;
> > +
> > +                               __entry->sport =3D ntohs(uh->source);
> > +                               __entry->dport =3D ntohs(uh->dest);
> > +                               __entry->ulen =3D ntohs(uh->len);
> > +                               __entry->skbaddr =3D skb;
> > +                               __entry->type =3D type;
> > +                               __entry->code =3D code;
> > +
> > +                               p32 =3D (__be32 *) __entry->saddr;
> > +                               *p32 =3D iph->saddr;
> > +
> > +                               p32 =3D (__be32 *) __entry->daddr;
> > +                               *p32 =3D  iph->daddr;
> > +               ),
> > +
>
> FYI, ICMP can be generated for many other protocols than UDP.
>
> > +               TP_printk("icmp_send: type=3D%d, code=3D%d. From %pI4:%=
u to %pI4:%u ulen=3D%d skbaddr=3D%p",
> > +                       __entry->type, __entry->code,
> > +                       __entry->saddr, __entry->sport, __entry->daddr,
> > +                       __entry->dport, __entry->ulen, __entry->skbaddr=
)
> > +);
> > +
> > +#endif /* _TRACE_ICMP_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index e63a3bf99617..437bdb7e2650 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -92,6 +92,8 @@
> >  #include <net/inet_common.h>
> >  #include <net/ip_fib.h>
> >  #include <net/l3mdev.h>
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/icmp.h>
> >
> >  /*
> >   *     Build xmit assembly blocks
> > @@ -599,6 +601,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, =
int code, __be32 info,
> >         struct net *net;
> >         struct sock *sk;
> >
> > +       trace_icmp_send(skb_in, type, code);
>
> I think you missed many sanity checks between lines 622 and 676
[...]
>
> Honestly, a kprobe BPF based solution would be less risky, and less
> maintenance for us.
>

I agreed. I wonder if we can remove some trace_* at the very beginning
of its caller function since they can be easily replaced with bpf
tools and then we make less effort to maintain them, say,
trace_tcp_probe(), trace_tcp_rcv_space_adjust, etc.

Thanks,
Jason

