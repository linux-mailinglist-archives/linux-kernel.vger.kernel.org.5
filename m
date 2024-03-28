Return-Path: <linux-kernel+bounces-123093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6086589020A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5506B23A34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D31272CA;
	Thu, 28 Mar 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flsy+nfw"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021737E10B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636698; cv=none; b=VbShlrhRn2anDVe7S5BbOFqZl4ZZksdnfaGBDt53GbYSF0WYkW1hFfSW/sqdy61zBF/bOVw4+fo8XxmM49LjtIxMq3TCawDXGmw5OR6yG5zydgFkubOUhsQ7pKRsVQMsIKCWcAx37wO+c/Mf09h7eSbAvjIoMd4dFhBTUrYquig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636698; c=relaxed/simple;
	bh=Je2UAtEY68if5uMZucjTLmJZ569unNwJAEX8q4vFPRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfkV2MQ6IpYAPHMO3+COFNLw4Rmv3e8IFXVtGYOwpGHp/5M8rv+O2DhzANkEvtnQNCbdaz81UTUHmwGK9hruh/cQcvICbpmV4ixXuj7QMa9IqKYqP70jQNbN/vZQty9TxezxWBsgoLP+poCequWehcXwCTn02Nsvin6NLx/yPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flsy+nfw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c3689ad32so12311a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711636695; x=1712241495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBDqCwUo0BszO/p4vM05OTn+yRfN49/fU9/chw4uLSk=;
        b=flsy+nfwkO1ZbK426PFd7YABXbLYkGaaW1V9v6akdpzEsaj61F1qk6RJlJbj1E3f/e
         pjpAxK7JGumtfzg9aiYogJEtRiIrpMhVEDFriaIPxplEfDmAH8YnOGo3ivqJUysWLsoT
         Yvipt4FUyeXFle4lCPKo4zyD0DAggUnhN5O7nEQKD6LF3d6BvY2O7ttL4g6LrMyWApJ1
         sCAZIJL4c5bx6b0ZKZt6J15IxX0o9Bi16uxl6P/5DXPuQ/PimBn+DiQpQBWfAhIRa/Sm
         N7bT6zSJ8qqZ6tOLedR/WHRz4Qv7VP5cvkvuK9efNsj2EtoH3k4aH5Yk8CNusCKnC4QA
         rmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636695; x=1712241495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBDqCwUo0BszO/p4vM05OTn+yRfN49/fU9/chw4uLSk=;
        b=gx+5kGl0txlanZlxxJkBtnqEV7+iT3QJDYbS3czqhfK6DM4vrt1K/0CqW+Wy5+cWDO
         C8HoBc7+EaGXfW/qYeg2Z/pEfC1849In8utO2i/yebh2RqbQ7kuq7qWbibBUpjzrZmbY
         lUQGCHmo5jifI6OY7jKVNf9lRIzhmfn9JQKcxCKsnUqYybzg8+4QMXz4WaJ6ayPy0poS
         vkmKurgIa4pD90mICNzjlqY0KSN281WzzpY+uBdECOV6G/JSh0jeVhGIEipqDtJRWZ9M
         DoCQkR5uPFUgfdWtrPW/ddBPL0+qkkUThVORpsdbo9oE3DkqLi6KwzJo3vYo9hvoYalv
         DE7g==
X-Gm-Message-State: AOJu0YwEJxZ6kciT0bJ1pkSqqm6FJSZ6tUFrdBOtrIAatmUwYlGMb7w+
	1T/Xh2uNr0Z6RUOOQrvRKunvjzeIe3XCNSUy8bGDgxS/SFdJAV0qmT4TvWnASXZ7bGlI2gGt1R5
	TpYj7YUCNQhuA/Jox75hB3orrfsOWJtyvkQJUHVim2YvYoSmf6vuU
X-Google-Smtp-Source: AGHT+IFpCb+hAEMXqJRx+znyNHc29XT0UrNVUxB6VWgzCxHc/S/gsBG3CXhdt+RzMQsIPrDbBmYFcfOf8JEENWeNtM0=
X-Received: by 2002:a50:bb21:0:b0:56c:18df:f9e1 with SMTP id
 y30-20020a50bb21000000b0056c18dff9e1mr142319ede.5.1711636695048; Thu, 28 Mar
 2024 07:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-6-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-6-arnd@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Mar 2024 15:38:03 +0100
Message-ID: <CANn89i+3FuKc1RsYaciNe3uQMZuJBjSmvC_ueuQ=NaFVzEnyuA@mail.gmail.com>
Subject: Re: [PATCH 5/9] ipv4: tcp_output: avoid warning about NET_ADD_STATS
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, "mfreemon@cloudflare.com" <mfreemon@cloudflare.com>, 
	Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:31=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Clang warns about a range check in percpu_add_op() being impossible
> to hit for an u8 variable:
>
> net/ipv4/tcp_output.c:188:3: error: result of comparison of constant -1 w=
ith expression of type 'u8' (aka 'unsigned char') is always false [-Werror,=
-Wtautological-constant-out-of-range-compare]
>                 NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/net/ip.h:291:41: note: expanded from macro 'NET_ADD_STATS'
>  #define NET_ADD_STATS(net, field, adnd) SNMP_ADD_STATS((net)->mib.net_st=
atistics, field, adnd)
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~
> include/net/snmp.h:143:4: note: expanded from macro 'SNMP_ADD_STATS'
>                         this_cpu_add(mib->mibs[field], addend)
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_a=
dd'
>  #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, =
pcp, val)
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=3D=
0 to see all)
> <scratch space>:187:1: note: expanded from here
> this_cpu_add_8
> ^
> arch/x86/include/asm/percpu.h:326:35: note: expanded from macro 'this_cpu=
_add_8'
>  #define this_cpu_add_8(pcp, val)                percpu_add_op(8, volatil=
e, (pcp), val)
>                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~
> arch/x86/include/asm/percpu.h:127:31: note: expanded from macro 'percpu_a=
dd_op'
>                               ((val) =3D=3D 1 || (val) =3D=3D -1)) ?     =
       \
>                                              ~~~~~ ^  ~~
>

This seems like a bug in the macro or the compiler, because val is not
a constant ?

__builtin_constant_p(val) should return false ???

+#define percpu_add_op(size, qual, var, val)                            \
+do {                                                                   \
+       const int pao_ID__ =3D (__builtin_constant_p(val) &&              \
+                             ((val) =3D=3D 1 || (val) =3D=3D -1)) ?       =
     \
+                               (int)(val) : 0;                         \
+       if (0) {                                                        \
+               typeof(var) pao_tmp__;                                  \
+               pao_tmp__ =3D (val);                                      \
+               (void)pao_tmp__;                                        \
+       }                                                               \
+       if (pao_ID__ =3D=3D 1)                                             =
 \
+               percpu_unary_op(size, qual, "inc", var);                \
+       else if (pao_ID__ =3D=3D -1)                                       =
 \
+               percpu_unary_op(size, qual, "dec", var);                \
+       else                                                            \
+               percpu_to_op(size, qual, "add", var, val);              \
+} while (0)
+



> Avoid this warning with a cast to a signed 'int'.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index e3167ad96567..dbe54fceee08 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -183,7 +183,7 @@ static inline void tcp_event_ack_sent(struct sock *sk=
, u32 rcv_nxt)
>
>         if (unlikely(tp->compressed_ack)) {
>                 NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
> -                             tp->compressed_ack);
> +                             (int)tp->compressed_ack);
>                 tp->compressed_ack =3D 0;
>                 if (hrtimer_try_to_cancel(&tp->compressed_ack_timer) =3D=
=3D 1)
>                         __sock_put(sk);
> --
> 2.39.2
>

