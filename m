Return-Path: <linux-kernel+bounces-29927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B39183154D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA38288647
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508EC13FE0;
	Thu, 18 Jan 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUOSOcoJ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BFF125D1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568411; cv=none; b=ZW8UO66RP2R77TZYi1OQ0iZdja79LhK3C0gL2ZX5CqyfL7l8wLAMJzosFO4abjQ0DAfRcSX/FWO/oIYZ79pJaNcTPluzW2A/ygWJF51nlzLPYC68siM9d8r5HosqZ/S5wXECgIk28+kmB0G+iXxeQYfjBdQGS6C5kKh7ZTIiSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568411; c=relaxed/simple;
	bh=Ee++RzyWaZqKpEGaQJTEGJGLJXGhyrNxNX86PnHxRO8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=kfqt2GZxHu2f0SvJnpMfFu4l4nmIZOGQV46+UsFXeVGxdBHJWTstwnrnBiaSfbrQWu66oXMo+D6hVB79im9ajXz6BazADJKONnIPAMAYCJf6W01xwFY6NARoKMmCg6dBa5KLqbm4nvzITX2KjwyXQggcY2b9j2rQT3uMWeTbS3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUOSOcoJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso3800a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705568408; x=1706173208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOizo9qlxqmuV1ASAUNV3HnBSGfcb5fdtsTh+nwhzCM=;
        b=MUOSOcoJ48KrICayXSo6MFJB4+njCsi7WsFDp7IgzmLD+C0A7EjZgcLZ44RnrgqFLK
         +9tT+l+JECtt+HT1MQvU1nurZMwMxT5DRt75YRiJrPa6QZtzuG9IaAsxILCcBh9tpSVa
         DdyQ+5IG3mQ8R+e5rSBg0+RWRwdDBQgJxkUHamesAyIKaEEizWm8M8PVTcWBl5uR+d8s
         CJx5ETps4iBaLjPyN+spZw9AK5LmtQrPHBlrAwo9/ic1NWBhbUHO1qRLgkz7DXpb1qwt
         fCuVqQtWoyrZG63yUsQSXEFaoaDIbQhAsv1o8shveRvQ+/AeU5FTSHigJezb7EjnIGSU
         rYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705568408; x=1706173208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOizo9qlxqmuV1ASAUNV3HnBSGfcb5fdtsTh+nwhzCM=;
        b=UE1DaQdAbav3zqK23hvrR5I3HISwXL0VKWaRIOJk14z5yCytFT8L/G8WF4rqNZajUJ
         X4WqUmLa4mxCdSkTDvRgVNaq7xzjEQ0FuFAN24CzbXT7Vp49MiLX0n/9vWLmoZfCYxDv
         sfJ8Hor8fzwXXYPEk2Rl5MgFFKiHDNPBYw3bViHIbHQ9TyPqtBRVlv1s2jhgIk0kBUUE
         fLieqdhTIFl+bUw8P4MOH8mh7TX7S8aqwwQlnJ820/DH/77TQ7Ub8lhd28WvA1JjTxjz
         H9skA14Mzb3EU13iu1ie+MZmtbEMSu7ykjhv/CP79fV/XV+VnUq5L9ndb9wU5OqJYdqV
         qb+Q==
X-Gm-Message-State: AOJu0YxSLBeyLMit3YpyiAUR8vUS8J7SqTWJjhghX3zn9dJQ+go8+D1l
	O5IIhojwxckMAWBwjQxJ1OI+03rNPwJv9pssPW+Upxv6PsMjX2dbzsO4Y0Oem3b7XPb5lcDPlo1
	TxzwwNiA9MdGuxrK106pwTH5J95Oa3AkvPBLg
X-Google-Smtp-Source: AGHT+IHlq5ITUQeKYYyo1QmMJ1zERrctH4pLBQAY898y5D8PZPaM6oKYzMw/nmN/gpjkGXB8ejUbkWVAROn8RJqfL4Q=
X-Received: by 2002:a05:6402:1750:b0:559:b9be:4143 with SMTP id
 v16-20020a056402175000b00559b9be4143mr25269edx.6.1705568408058; Thu, 18 Jan
 2024 01:00:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 09:59:54 +0100
Message-ID: <CANn89iLUxP_YGLD1mrCmAr9qSg7wPWDjWPhJHNa_X4QVyNWqBQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Taehee Yoo <ap420073@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 6:21=E2=80=AFPM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> idev->mc_ifc_count can be written over without proper locking.
>
> Originally found by syzbot [1], fix this issue by encapsulating calls
> to mld_ifc_stop_work() (and mld_gq_stop_work() for good measure) with
> mutex_lock() and mutex_unlock() accordingly as these functions
> should only be called with mc_lock per their declarations.
>
> [1]
> BUG: KCSAN: data-race in ipv6_mc_down / mld_ifc_work
>
> Fixes: 2d9a93b4902b ("mld: convert from timer to delayed work")
> Reported-by: syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/000000000000994e09060ebcdffb@google.com=
/
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  net/ipv6/mcast.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index b75d3c9d41bb..bc6e0a0bad3c 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -2722,8 +2722,12 @@ void ipv6_mc_down(struct inet6_dev *idev)
>         synchronize_net();
>         mld_query_stop_work(idev);
>         mld_report_stop_work(idev);
> +
> +       mutex_lock(&idev->mc_lock);
>         mld_ifc_stop_work(idev);
>         mld_gq_stop_work(idev);
> +       mutex_unlock(&idev->mc_lock);
> +
>         mld_dad_stop_work(idev);
>  }
>

Thanks for the fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>

I would also add some lockdep_assert_held() to make sure assumptions are me=
t.
Trading a comment for a runtime check is better.

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b75d3c9d41bb5005af2d4e10fab58f157e9ea4fa..b256362d3b5d5111f649ebfee4f=
1557d8c063d92
100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1047,36 +1047,36 @@ bool ipv6_chk_mcast_addr(struct net_device
*dev, const struct in6_addr *group,
        return rv;
 }

-/* called with mc_lock */
 static void mld_gq_start_work(struct inet6_dev *idev)
 {
        unsigned long tv =3D get_random_u32_below(idev->mc_maxdelay);

+       lockdep_assert_held(&idev->mc_lock);
        idev->mc_gq_running =3D 1;
        if (!mod_delayed_work(mld_wq, &idev->mc_gq_work, tv + 2))
                in6_dev_hold(idev);
 }

-/* called with mc_lock */
 static void mld_gq_stop_work(struct inet6_dev *idev)
 {
+       lockdep_assert_held(&idev->mc_lock);
        idev->mc_gq_running =3D 0;
        if (cancel_delayed_work(&idev->mc_gq_work))
                __in6_dev_put(idev);
 }

-/* called with mc_lock */
 static void mld_ifc_start_work(struct inet6_dev *idev, unsigned long delay=
)
 {
        unsigned long tv =3D get_random_u32_below(delay);

+       lockdep_assert_held(&idev->mc_lock);
        if (!mod_delayed_work(mld_wq, &idev->mc_ifc_work, tv + 2))
                in6_dev_hold(idev);
 }

-/* called with mc_lock */
 static void mld_ifc_stop_work(struct inet6_dev *idev)
 {
+       lockdep_assert_held(&idev->mc_lock);
        idev->mc_ifc_count =3D 0;
        if (cancel_delayed_work(&idev->mc_ifc_work))
                __in6_dev_put(idev);

