Return-Path: <linux-kernel+bounces-123793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B0B890E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679521C23021
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3870548EB;
	Thu, 28 Mar 2024 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMQWgHpE"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3A8F6B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666899; cv=none; b=C/09fEArK+jUxekjnbK2r9s+Hb1QkFbqOTZNkMjCp4eE+PrgTp3ngxK1kIqv6XRGJPsi7mMF2wyOoWqEheAFgkzRyyBYKSFaovIL36EXQ3s83N380royfnWeT8XH5WfwW1YPebXGv48Ll6phip6nsHHRXOW+gh43W/JX10hLCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666899; c=relaxed/simple;
	bh=TKsivGU+pbBggUpaqWi4+K2eNDTC87QeNNtNFbqc9rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKNOkeYHhM2Js9MhUQKvQ4sw3JuQ+kHSQh5Hd77KBCsVrtGoyWEhxw8vZdjVSE11t/4R12fZkony/yOjXTrL6Pp7iQPSu5qJS8YA8/O5OqBj9QLhQYHmImyzk241QGD5krEOFFpLE2nidFM2A343xT9NavouYatxAFHiEHBZv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMQWgHpE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so2250048a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711666895; x=1712271695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA17YR4InWjyg8TEVheIC338xk5MwmSEpPeuNx4GZW0=;
        b=GMQWgHpEIlA6ssVxKsnzAifYz/G4QkGGXeIYxEBjtyM+BLoXGaFydipWM6tuak1fXa
         +janLWgU/mf50mfNdgLL/Uguxs9tuOGwqy9s7UreTGiI/vF4ULNLUTW8y+B7auFu3jPC
         MqogNQE9cHzJXBKhXy51qVds5F4b8iZk2Sek6kdNA1neHlobRQrZCI73hc3V+PGUKWrM
         Gcb3nOm6jhdavuFV4q4ZYx4PFi8FVxnvx19W4KAiSb+fC7FJ7n0gnmsWnUk4h+qOrwJp
         ywVLyZdhzYfDqmnlhRMsbibZbLtO/Hj8mY5W8I3L+ZO6uDmN8R9NOvRAFEna9AA0yXnK
         lsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711666895; x=1712271695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oA17YR4InWjyg8TEVheIC338xk5MwmSEpPeuNx4GZW0=;
        b=lTzykwIhiTWmISriLffqOqRJAQgZlQWb5Ebcrtq72cqA/yen7iP9Kp5SLMT0BWdbh4
         LEAVUiEeU+FTcCnihs/AOFVMtUeGqTt6v7fUWEcj6zjYJkYN9MDNAM9st0SkoxkVLx52
         oqAsmM9PCSJ26Qdz8ka1IPRCCGEiNu6t20DpwEj9I7riCFc6WLDaSw6gp9ZXDtyecJHC
         mEyc874aZNSN+iD+6foLjLRjgGE4W9kAFhCoRO8CKADnMDTH/jeEfpX+U0XmqtWvP3Ma
         0a/VblSBssLYaLLsrHX0V9RTZLgf5vpG19J3E2FIbrN9gQj+lERY977IGK03mRNrPBsq
         gzUg==
X-Gm-Message-State: AOJu0YxjF6cf8K83wMDeYAtHaRCay6OujfRxSY2nzCg7geQEVo/LdbxI
	RYJXv4qVw0F7/lbnYzwbRH84znaDIAmdIYHrLhq7HFhppdhHgUxKSXRynj7/vvpOm8v0QDeGI6A
	7JHJVtpTxQUJ1ZUZCgVHlaT0Emv+zEKmc8zml
X-Google-Smtp-Source: AGHT+IHSDimwfZi+Mu8w7ftuh2TFjJ1pdwWklM9rbYXTjg5wTtqltWADADutdRuEB4qRyX7gMEY0XftN4jstinrasFQ=
X-Received: by 2002:a05:6402:51cd:b0:56a:2b6b:42cd with SMTP id
 r13-20020a05640251cd00b0056a2b6b42cdmr433486edd.3.1711666895187; Thu, 28 Mar
 2024 16:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328140512.4148825-1-arnd@kernel.org> <20240328140512.4148825-10-arnd@kernel.org>
In-Reply-To: <20240328140512.4148825-10-arnd@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 16:01:23 -0700
Message-ID: <CAFhGd8oHht+uMBouT7_AXZt4DMRJi=A7_=fyhZ2Hf_ne+8xE8w@mail.gmail.com>
Subject: Re: [PATCH 09/11] staging: rtl8723bs: convert strncpy to strscpy
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Franziska Naepelt <franziska.naepelt@googlemail.com>, 
	Johannes Berg <johannes.berg@intel.com>, Yang Yingliang <yangyingliang@huawei.com>, 
	Erick Archer <erick.archer@gmx.com>, linux-staging@lists.linux.dev, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 28, 2024 at 7:07=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc-9 complains about a possibly unterminated string in the strncpy() des=
tination:
>
> In function 'rtw_cfg80211_add_monitor_if',
>     inlined from 'cfg80211_rtw_add_virtual_intf' at drivers/staging/rtl87=
23bs/os_dep/ioctl_cfg80211.c:2209:9:
> drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2146:2: error: 'strncpy=
' specified bound 16 equals destination size [-Werror=3Dstringop-truncation=
]
>  2146 |  strncpy(mon_ndev->name, name, IFNAMSIZ);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This one is a false-positive because of the explicit termination in the f=
ollowing
> line, and recent versions of clang and gcc no longer warn about this.
>
> Interestingly, the other strncpy() in this file is missing a termination =
but
> does not produce a warning, possibly because of the type confusion and th=
e
> cast between u8 and char.
>
> Change both strncpy() instances to strscpy(), which avoids the warning as=
 well
> as the possibly missing termination. No additional padding is needed here=
.

Could you also clean up the strncpy present in
drivers/staging/rtl8723bs/os_dep/os_intfs.c so all these are cleaned
up at once?

Maybe we could use the new 2-argument version of strscpy() introduced
in Commit e6584c3964f2f ("string: Allow 2-argument strscpy()") for all
3 of these too.

It looks like:
    strscpy(dest, src);





>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/=
staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 65a450fcdce7..98bc5520e77d 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -884,7 +884,7 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, =
struct net_device *ndev,
>                 goto addkey_end;
>         }
>
> -       strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME=
_LEN);
> +       strscpy(param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
>
>         if (!mac_addr || is_broadcast_ether_addr(mac_addr))
>                 param->u.crypt.set_tx =3D 0; /* for wpa/wpa2 group key */
> @@ -2143,8 +2143,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapt=
er *padapter, char *name, str
>         }
>
>         mon_ndev->type =3D ARPHRD_IEEE80211_RADIOTAP;
> -       strncpy(mon_ndev->name, name, IFNAMSIZ);
> -       mon_ndev->name[IFNAMSIZ - 1] =3D 0;
> +       strscpy(mon_ndev->name, name, IFNAMSIZ);
>         mon_ndev->needs_free_netdev =3D true;
>         mon_ndev->priv_destructor =3D rtw_ndev_destructor;
>
> --
> 2.39.2
>

Thanks
Justin

