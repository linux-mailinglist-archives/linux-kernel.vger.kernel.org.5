Return-Path: <linux-kernel+bounces-116729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51B88AAFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6980DBA1C74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4F1607AB;
	Mon, 25 Mar 2024 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vO/GN2kl"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B06EB7A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357303; cv=none; b=cIxsfmgZgM11pyHJMj3zAhNjL+9zHZQ1j3Xjbxbf3LCqG8KCMMIAxSsgBeD+E6VakvC7cy0W8rbLrfKrWswi9Mgn4ZzdpOrM2wSQh/S42IVyskN9cyFZ2nNc/mi3hPwImDnVzdTsw3182U9X/vbGdTNbb42HsO935GXUcpCMgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357303; c=relaxed/simple;
	bh=eYRrpsXvKASfeDdTPgUF50OyTB85LFx8rQBSFc+QXiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAl6TNqpzoJurLrChfxEsTgV30Ad7lBFaJ4+oSNHPZ3lHAAWGSUPdo4esNVJlvvX1+wK4Ph5xVFMPwWh+bMeTe48XNAxWIl5n5rdvDwY4LXAgQF6AcmnMhlYVrIDYU70OON8Dr54EDiXRATqshYfZ/+OEc1nyjogDHBjFtFGoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vO/GN2kl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so11305a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711357300; x=1711962100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0U8zHEyfyogGOQdIOO4uT4cQv33Uo34l91fEF+ktkk=;
        b=vO/GN2kl5TA5uKZ1/QFdyFr9r5vqhCFxCDAZ2eXZESRV+xG2gfpjP4FzGjoQXQLQD7
         nTZNOFt/yMp4KSOF/FeG4lYK4N6zxiydCwtuHuVgIFdUEzVuv3TaBeXJa23QBxNm72e9
         /5SZN124BoZA9oLgKFxH3jw7J4TbWZPntcaOvKeZ1bWpLf+bK7XpJNpKcolt9knPgdcB
         Cb0uRMAH6Zj8Xa4x0/KS+TTHWJxFSH2QbI9LBQGzwC9hX1Q8LHHXhSRQNGcQdjcuG47P
         pnym2ylSEiAveVS6lrkprcMhKYJrev9IPHlep2GG//JamZVM34zqAfID7UPzB1wa6jgi
         xAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711357300; x=1711962100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0U8zHEyfyogGOQdIOO4uT4cQv33Uo34l91fEF+ktkk=;
        b=dBV9fS4JCY3HzgI/L2djqCmclNZ5+o8erIPVpEOUdLGyq1IPek1xThrv7mH/wPVPuU
         NKatr8hzaEBm/q84f6ss6ef2xFli1ag4CqytIxDMCteI9K6VjnGZBzd+xt1jDF/SBK8+
         J6q2lr6JyDj5xKxP7LhsIpQ3GXzltQy0kc5T9N3LLUW+c77BqdXbZe4FkzV2OtCr6arK
         t5JplrHzak0YWodBB4pRpUGrNJLOX2KO4m5pKDs2ACCavhaBxqUR8E6vG5EjwojeyAV6
         vz6fIltW8dCjhYX004g48tKy7XrCft2bc8p+6puwWf1rPUnp56kkNeLWbuhl4SvXZ7WG
         f4qA==
X-Forwarded-Encrypted: i=1; AJvYcCVSLxEciuM4aIm2C6Jms8qCF4+Hk3xuaTN7F/x1Pgd1YZ+X0IXug7w1zBtSKgiPRKRtxq+mJZubRBCJgwIWuM+kRUXCuwDu2dxw/AK3
X-Gm-Message-State: AOJu0Yyt5F6l7JebkJ7A1rXLcvWZE8MvSOBYsU6jYIBYid3rPCzqa2iN
	XYaPKFvOVNOihK2rWMFl7Mexonnihu4Ws/H3kiYhcj3ka9DKyGnMDx7wujrztmsahJqhaqJOV7l
	VGu1kZnK1W6+568u49D8x1bfLxPi4u8ykJohj
X-Google-Smtp-Source: AGHT+IGa/Ko03ejeQdFa+Xu1zx1GHiVeAq2qvsjwjtu947OrnW8lDTqKAdvl+qWaesjor/Pc2kbQmzbSe2Red9HDdt8=
X-Received: by 2002:a05:6402:358c:b0:56b:fc63:5551 with SMTP id
 y12-20020a056402358c00b0056bfc635551mr185208edc.3.1711357299530; Mon, 25 Mar
 2024 02:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324050554.1609460-1-syoshida@redhat.com>
In-Reply-To: <20240324050554.1609460-1-syoshida@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Mar 2024 10:01:25 +0100
Message-ID: <CANn89iL_Oz58VYNLJ6eB=qgmsgY9juo9xAhaPKKaDqOxrjf+0w@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: Fix uninit-value access in __ip_make_skb()
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 6:06=E2=80=AFAM Shigeru Yoshida <syoshida@redhat.co=
m> wrote:
>
> KMSAN reported uninit-value access in __ip_make_skb() [1].  __ip_make_skb=
()
> tests HDRINCL to know if the skb has icmphdr. However, HDRINCL can cause =
a
> race condition. If calling setsockopt(2) with IP_HDRINCL changes HDRINCL
> while __ip_make_skb() is running, the function will access icmphdr in the
> skb even if it is not included. This causes the issue reported by KMSAN.
>
> Check FLOWI_FLAG_KNOWN_NH on fl4->flowi4_flags instead of testing HDRINCL
> on the socket.
>
> [1]

What is the kernel version for this trace ?

> BUG: KMSAN: uninit-value in __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_outpu=
t.c:1481
>  __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
>  ip_finish_skb include/net/ip.h:243 [inline]
>  ip_push_pending_frames+0x4c/0x5c0 net/ipv4/ip_output.c:1508
>  raw_sendmsg+0x2381/0x2690 net/ipv4/raw.c:654
>  inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x274/0x3c0 net/socket.c:745
>  __sys_sendto+0x62c/0x7b0 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x130/0x200 net/socket.c:2199
>  do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3804 [inline]
>  slab_alloc_node mm/slub.c:3845 [inline]
>  kmem_cache_alloc_node+0x5f6/0xc50 mm/slub.c:3888
>  kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:577
>  __alloc_skb+0x35a/0x7c0 net/core/skbuff.c:668
>  alloc_skb include/linux/skbuff.h:1318 [inline]
>  __ip_append_data+0x49ab/0x68c0 net/ipv4/ip_output.c:1128
>  ip_append_data+0x1e7/0x260 net/ipv4/ip_output.c:1365
>  raw_sendmsg+0x22b1/0x2690 net/ipv4/raw.c:648
>  inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x274/0x3c0 net/socket.c:745
>  __sys_sendto+0x62c/0x7b0 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x130/0x200 net/socket.c:2199
>  do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> Fixes: 99e5acae193e ("ipv4: Fix potential uninit variable access bug in _=
_ip_make_skb()")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
> I think IPv6 has a similar issue. If this patch is accepted, I will send
> a patch for IPv6.
> ---
>  net/ipv4/ip_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 1fe794967211..39229fd0601a 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1473,7 +1473,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>                  * by icmp_hdr(skb)->type.
>                  */
>                 if (sk->sk_type =3D=3D SOCK_RAW &&
> -                   !inet_test_bit(HDRINCL, sk))
> +                   !(fl4->flowi4_flags & FLOWI_FLAG_KNOWN_NH))
>                         icmp_type =3D fl4->fl4_icmp_type;
>                 else
>                         icmp_type =3D icmp_hdr(skb)->type;
> --
> 2.44.0
>

Thanks for your patch.

I do not think this is enough, as far as syzkaller is concerned.

raw_probe_proto_opt() can leave garbage in fl4_icmp_type (and fl4_icmp_code=
)

