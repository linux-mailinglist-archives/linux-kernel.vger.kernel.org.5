Return-Path: <linux-kernel+bounces-86234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AB586C285
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4D62846ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0945949;
	Thu, 29 Feb 2024 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ2Px/DE"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2644C67;
	Thu, 29 Feb 2024 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191837; cv=none; b=S1unKXtLxeX3tzl/1czwSPr/cg10KPfO1G2zC48AhoPOhFRAUofLQbFrTD9o4aYQtYGC36VKFu1kH4Y12EpbQPNEXwE7EF2VACwUohAwrQxVhm7mn4r3XwQ42ygPUfOP2gVPhcCFC6+x8td2c00eHemALpRPAZ6X0FnW2jtqJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191837; c=relaxed/simple;
	bh=tEkNMsql6n7EmLjiIafb3HPwIpQRV25IrRm3wpHTFQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZEVxtTXST3huBClXegGDakScqQo1DDm/WaPRyhPvOJ8o1cBjaatGKU7lZXO5+1W9bO+dcJ7nlF367hIlaFO9HSf9XMyYVzf5MoSteX+fkG6J0b9tUlNM7iyJ/ipUkjmqeJx8nOkWL5F7kO8vckAS6ReW5fh8EC4a0kwAGJkyXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZ2Px/DE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5648d92919dso1044823a12.1;
        Wed, 28 Feb 2024 23:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709191834; x=1709796634; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKPf0LgfDBQdcT2AOOktC0F3XZfRUjBLP/Wgrh2tUeI=;
        b=XZ2Px/DEgNFeQNhVQM4RxnmW5aCL4w5gVzwlGT7E/e9Rip7LlrHokJ8vUbKEw5IknO
         VPclmq7At+L3osgjNAtBqOWie4xwXi8VJ4ZEV+vusgC2wH/Uq4iIA0TEniHAgElYVHar
         n8YelzC3gxABhtO/tqZXhsmGxzo00vvWLS1/a3S9u8yjCzuZkl1eprpf7gqhaDbPq/Z0
         Pxa8yZNeJm4XHVWF9/tW/fAfbaFmWYbr7+8f/dQURSfWuXN2xHqyCiVyOvA8tbiLwH/l
         vwRqt89iX/NzXy1U+ONrwrJKGmOQdiGKdnYR6UDmW/QOTtg6AcJUEjX9MXMdAWneK8Bf
         +Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709191834; x=1709796634;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKPf0LgfDBQdcT2AOOktC0F3XZfRUjBLP/Wgrh2tUeI=;
        b=VaKfX6FDZL88N29aD6VYu6z+yL2RGiZAFKcGUbQ2clZsTD+iqFk7EbSZl+q0y9sj9D
         Wo7qZDodAN+zl1NbHr4K5QtbpPDUiHT9nJ03FjTzmFTs6k9q8MG+g5+EVkWrhkNsA9bd
         9mEaTRO4oEqEsxbuymSXU0FO4iIiy/Grs31x6y8O62fTH8n0B6JBEL7/+HvwXVIjUad3
         9e4Q9n1IqwvhxDwXHzK98C1JtXwSx/CmSNDy3YhJB9puJHWKfhXfumLMYLqmlYRBAD+j
         mOXhw4aZOWSIOceDM5keriRnRcAGKIIhSxm6M287bczpc7f1Y0TOzjTgIcMWPxlHb0Ml
         4lVg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ7BzjeK3aTSDr++TIH4PNIaS7ew1/GQTWBsR7rn62qACwyQavGUqOMsGSklG0gfQmuIloZeujM4EiAsVoVHzDt0kTBgVJRv68gOruVW3GFAHjBZGPC/EfEQjw2rQFFUgoJA2UxB0nieFVsTETmXqJysTyHef14p0lXPYK4d7P1jW1aFtIU+Zr
X-Gm-Message-State: AOJu0YzFtUrWJLWy7dR4xC8DxTZlxEclD/AxcETF73q/YUn/httHHczh
	N53+nKvkKqFvPDav9uZ+dxjAqtllz6laM2eAnGn17idY23r4YMoTw/cpCFZKPwW1R4+9j+bV2tX
	p6W7XwACg7jDU6vjuvDangWAxh2Q=
X-Google-Smtp-Source: AGHT+IHoCqstq7TdVZ88Dk/71bmmKf5b9RkwknQU02aYiHxGF6OjB2trJyj9jkf88TO2KWMcDdIIMvUH+yEss8vkXFE=
X-Received: by 2002:a17:906:e20b:b0:a44:fb7:d42 with SMTP id
 gf11-20020a170906e20b00b00a440fb70d42mr774752ejb.2.1709191834050; Wed, 28 Feb
 2024 23:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229052813.GA23899@didi-ThinkCentre-M920t-N000>
In-Reply-To: <20240229052813.GA23899@didi-ThinkCentre-M920t-N000>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 29 Feb 2024 15:29:56 +0800
Message-ID: <CAL+tcoAhvFhXdr1WQU8mv_6ZX5nOoNpbOLAB6=C+DB-qXQ11Ew@mail.gmail.com>
Subject: Re: [PATCH] tcp: Add skb addr and sock addr to arguments of
 tracepoint tcp_probe.
To: edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:33=E2=80=AFPM fuyuanli <fuyuanli@didiglobal.com> =
wrote:
>
> It is useful to expose skb addr and sock addr to user in tracepoint
> tcp_probe, so that we can get more information while monitoring
> receiving of tcp data, by ebpf or other ways.
>
> For example, we need to identify a packet by seq and end_seq when
> calculate transmit latency between lay 2 and lay 4 by ebpf, but which is
> not available in tcp_probe, so we can only use kprobe hooking
> tcp_rcv_esatblised to get them. But we can use tcp_probe directly if skb
> addr and sock addr are available, which is more efficient.
>
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>

Please target 'net-next' in the title of your v2 patch.

> ---
>  include/trace/events/tcp.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 7b1ddffa3dfc..096c15f64b92 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -258,6 +258,8 @@ TRACE_EVENT(tcp_probe,
>                 __field(__u32, srtt)
>                 __field(__u32, rcv_wnd)
>                 __field(__u64, sock_cookie)
> +               __field(const void *, skbaddr)
> +               __field(const void *, skaddr)
>         ),
>
>         TP_fast_assign(
> @@ -285,6 +287,9 @@ TRACE_EVENT(tcp_probe,
>                 __entry->ssthresh =3D tcp_current_ssthresh(sk);
>                 __entry->srtt =3D tp->srtt_us >> 3;
>                 __entry->sock_cookie =3D sock_gen_cookie(sk);
> +
> +               __entry->skbaddr =3D skb;
> +               __entry->skaddr =3D sk;
>         ),
>
>         TP_printk("family=3D%s src=3D%pISpc dest=3D%pISpc mark=3D%#x data=
_len=3D%d snd_nxt=3D%#x snd_una=3D%#x snd_cwnd=3D%u ssthresh=3D%u snd_wnd=
=3D%u srtt=3D%u rcv_wnd=3D%u sock_cookie=3D%llx",

If they are useful, at least you should printk those two addresses
like what trace_kfree_skb() does.

May I ask how it could be useful if there is no more function printing
such information in the receive path?

Thanks,
Jason
> --
> 2.17.1
>
>

