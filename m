Return-Path: <linux-kernel+bounces-82729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA458688C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E59C1F2313B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4345337B;
	Tue, 27 Feb 2024 05:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHx7eLz8"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7852F92
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709012954; cv=none; b=C1PuRkZFZReJGcEzNo/fvDszlyYOQmkxfKYOYITKNZIEizdnJawJIlsRgjVe18LOjgr6F8XcjJmh+TXpXJCqeNZPjWzqml37meNBznM9LHM4j2n0ld7qX1ZcX2HHCCbln0Vyu4AZc0XcrjdxPAJ2ippAaUslskG5TGI67kOsR5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709012954; c=relaxed/simple;
	bh=MMmdAPM25fgbVawN9y+wbIsKlWz4iuPJaLJ6mcayEq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLuVKHIWNjMYNtIKM4znfZrUnVtKA0RP3JOn84If4AZwc0gjV/UUwxg8yMFsbSBm1K0QcJViwuI+VjmlHLTz2f3FnQypnZFofliOnsLrKl172c3lsQTac6x9YpDTbsbVdsXRXtBXTcmwP2hJNRpTzSTCOu14BIBVGjPFJ0lEraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHx7eLz8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56619428c41so7143a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709012951; x=1709617751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deoGECJCnFvm1xZVCOoPfcDHKJqlnBIaPn+xka19knA=;
        b=sHx7eLz890KskTbWZ8QhtEVqEDKL7oWs0UGvf7It+KcK5ap1nEjsEg6zY+ykmRqGuP
         IcW6SD4BiTUiK0cudMpm9jYQlvaYLQOIGX4pQOhTrGHYQLhRQQ6MqQlbJXztAuoGS35a
         mS4J6AqkkIfgmLe7O9MCg/xYHLe1Di7CezNZjeee6JsH6zEKQUzW+j+sN8FvPK7rZXdV
         3KU+e1oAabxF5u/09D0iKn8noUpZqnaMpQmTSVxszymj295dALmIoobko+N26eJ7V5D3
         OG/XvbCF0rT55BMpwp5Kt4dWdfqXtQzCcoFnI2W5ISObdQupL9X87OGaqR2tnfhuPWJY
         1n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709012951; x=1709617751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deoGECJCnFvm1xZVCOoPfcDHKJqlnBIaPn+xka19knA=;
        b=TTSNZEgghGebr6wyYgLv8wJeZbmqolMoRixx1ZCRgAp4BvEErZ2tnt3IJBFK6uhaAo
         QwdDtDg0ici0KsUOj0P6OWjdsl7BA49o37QNlPvWJrAEo4BTsRjzeerQ20rrNdd5UiVE
         AKgk+4Jb66wNa97w9BDqTjqjsKPAICwQNF5Yty54bRbwEix0GxZxHSuZ+2WisGjfGyLV
         1YlxYFcY9YLZi0gCno2CCICMvVnWkxpyyU3hGZ4IAyLS0nw8bKJUq9l0P7KTbUIAtKuU
         Z1sQbO9cYqMuQdtke7PhcyI7SRzvk6VFieqxYTKGn37oOB1sTlxvF3JoxAFz+RTYwUL9
         uRmA==
X-Forwarded-Encrypted: i=1; AJvYcCUyDUtduccADjoj4DTX2npcatACUiERYy8c/xZKYzArYxj2vUoAUq1oKM2r+ynCxcXQ+htYkOJWJ3tDaC2Fl3QSMYi52N3IsvVkplEh
X-Gm-Message-State: AOJu0Yw3QP13Q1R3YqwfWILsmOfU3KqaD/FGbVrCRsdXlCid4EIn95u+
	zhIWGrevi6MPI436jwa+epzmg065XccksiC3ioH51IfCv9XTfm2wq1swLIYsv6+46uDwZ1MbuxC
	RLCly6iTd28S8Ptz3CSJuF00x5CB8rq9ysug1
X-Google-Smtp-Source: AGHT+IGTVySsyeyxiQC9jRgtmof65jjj57hxbatY9EMFgIqzeoifzIA+vBbHyM0H5B/jg0+QtbDV8CATwdqUkFk2Z88=
X-Received: by 2002:a50:d490:0:b0:565:733d:2b30 with SMTP id
 s16-20020a50d490000000b00565733d2b30mr155366edi.4.1709012950500; Mon, 26 Feb
 2024 21:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202402271050366715988@zte.com.cn>
In-Reply-To: <202402271050366715988@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 06:48:58 +0100
Message-ID: <CANn89iL-y9e_VFpdw=sZtRnKRu_tnUwqHuFQTJvJsv-nz1xPDw@mail.gmail.com>
Subject: Re: [PATCH] net/ipv4: add tracepoint for icmp_send
To: xu.xin16@zte.com.cn
Cc: davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	yang.yang29@zte.com.cn, he.peilin@zte.com.cn, liu.chun2@zte.com.cn, 
	jiang.xuexin@zte.com.cn, zhang.yunkai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 3:50=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: xu xin <xu.xin16@zte.com.cn>
>
> Introduce a tracepoint for icmp_send, which can help users to get more
> detail information conveniently when icmp abnormal events happen.
>
> 1. Giving an usecase example:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> When an application experiences packet loss due to an unreachable UDP
> destination port, the kernel will send an exception message through the
> icmp_send function. By adding a trace point for icmp_send, developers or
> system administrators can obtain the detailed information easily about th=
e
> UDP packet loss, including the type, code, source address, destination
> address, source port, and destination port. This facilitates the
> trouble-shooting of packet loss issues especially for those complicated
> network-service applications.
>
> 2. Operation Instructions:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> Switch to the tracing directory.
>         cd /sys/kernel/debug/tracing
> Filter for destination port unreachable.
>         echo "type=3D=3D3 && code=3D=3D3" > events/icmp/icmp_send/filter
> Enable trace event.
>         echo 1 > events/icmp/icmp_send/enable
>
> 3. Result View:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  udp_client_erro-11370   [002] ...s.12   124.728002:  icmp_send:
> icmp_send: type=3D3, code=3D3.From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=
=3D23
> skbaddr=3D00000000589b167a
>
> Signed-off-by: He Peilin <he.peilin@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> ---
>  include/trace/events/icmp.h | 57 +++++++++++++++++++++++++++++++++++++++=
++++++
>  net/ipv4/icmp.c             |  4 ++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 include/trace/events/icmp.h
>
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> new file mode 100644
> index 000000000000..3d9af5769bc3
> --- /dev/null
> +++ b/include/trace/events/icmp.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM icmp
> +
> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_ICMP_H
> +
> +#include <linux/icmp.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(icmp_send,
> +
> +               TP_PROTO(const struct sk_buff *skb, int type, int code),
> +
> +               TP_ARGS(skb, type, code),
> +
> +               TP_STRUCT__entry(
> +                               __field(__u16, sport)
> +                               __field(__u16, dport)
> +                               __field(unsigned short, ulen)
> +                               __field(const void *, skbaddr)
> +                               __field(int, type)
> +                               __field(int, code)
> +                               __array(__u8, saddr, 4)
> +                               __array(__u8, daddr, 4)
> +               ),
> +
> +               TP_fast_assign(
> +                               // Get UDP header
> +                               struct udphdr *uh =3D udp_hdr(skb);
> +                               struct iphdr *iph =3D ip_hdr(skb);
> +                               __be32 *p32;
> +
> +                               __entry->sport =3D ntohs(uh->source);
> +                               __entry->dport =3D ntohs(uh->dest);
> +                               __entry->ulen =3D ntohs(uh->len);
> +                               __entry->skbaddr =3D skb;
> +                               __entry->type =3D type;
> +                               __entry->code =3D code;
> +
> +                               p32 =3D (__be32 *) __entry->saddr;
> +                               *p32 =3D iph->saddr;
> +
> +                               p32 =3D (__be32 *) __entry->daddr;
> +                               *p32 =3D  iph->daddr;
> +               ),
> +

FYI, ICMP can be generated for many other protocols than UDP.

> +               TP_printk("icmp_send: type=3D%d, code=3D%d. From %pI4:%u =
to %pI4:%u ulen=3D%d skbaddr=3D%p",
> +                       __entry->type, __entry->code,
> +                       __entry->saddr, __entry->sport, __entry->daddr,
> +                       __entry->dport, __entry->ulen, __entry->skbaddr)
> +);
> +
> +#endif /* _TRACE_ICMP_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index e63a3bf99617..437bdb7e2650 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -92,6 +92,8 @@
>  #include <net/inet_common.h>
>  #include <net/ip_fib.h>
>  #include <net/l3mdev.h>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/icmp.h>
>
>  /*
>   *     Build xmit assembly blocks
> @@ -599,6 +601,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, in=
t code, __be32 info,
>         struct net *net;
>         struct sock *sk;
>
> +       trace_icmp_send(skb_in, type, code);

I think you missed many sanity checks between lines 622 and 676

Honestly, a kprobe BPF based solution would be less risky, and less
maintenance for us.

