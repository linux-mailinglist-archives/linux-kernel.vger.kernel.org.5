Return-Path: <linux-kernel+bounces-45882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B60AB843780
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2125FB246B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B955E78;
	Wed, 31 Jan 2024 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRMVNJB6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85D55C18
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685378; cv=none; b=TIOGF+F8b4luC372lEaD+Yes9dSrvJea6HzHnLEKC42md/LOAzbsJ6ZEtS1YekL90BhowYya/9XQiq4eu1Bys8KF+QOkEEY/hvbN0i5vfh8b3B8M46dD6e5jt56FfHJjDzH1LU9iBDXuWe9NosoNLncFFD0zH8kruOAJAPOzJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685378; c=relaxed/simple;
	bh=bxaTZPOIsT8/v/Vj4KDp4NSxc016wqx9zKxXiJMGM60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEQk/H8uvjX2RNvBON09RAFnRcOYFLjrK6iqTdUOuJMalpZnAqjZf2fKemPiaWoXKaOWFfiGKAH5A5IZeOw2+v4hRAV1u3rIQTv1tuIkdk1qUtW6OpFoNhBBXOTfMN+e1JbznJ2ArcP1vnugOtTSYT4W1k4RjMfUkfkPcWx1t7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRMVNJB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3EAC43390
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706685377;
	bh=bxaTZPOIsT8/v/Vj4KDp4NSxc016wqx9zKxXiJMGM60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WRMVNJB6gIbwUFbPJsGgU4P0PIVAuXr1sk6RkyldhhlOyx+IJe8tMO8drzB06KIMJ
	 cyUEVpZNeezdTCYRpVO+L1mO3vL6TEEkA29zNQO+bbpXalQ5JFFX1qp84hTIZNxwBB
	 LWMVL0Yorq6OQNG3XE3UoF14X8yF7rxzhDS0hlL89ep5d6xHkD0ZTwK2xsSQf/Nh4x
	 GKn7rByogCFMDR99zsMwkRvgomcibqE77Xe3RUY12K2cy+T36H5bel/++kf6DGiOoi
	 KVpcfAwehQp3DBV7ltJm5csGvpfD5mGkt0zsX0pzOUN2oCxtnuytu4W82xlHG2Mwtp
	 I0SF8HFzBrF9g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51124d43943so537734e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:16:17 -0800 (PST)
X-Gm-Message-State: AOJu0YybLjrW2OynLjv89g03Mmqs5NTNjA9b/15RKSMtc+lavWxGJ8Sk
	M2raBq5kTIeNPRiz/kbqDBstxFcYOJV9dZOZIkWBlvLwzT8rxZzrSxShqi+nU2D/PWshPIppyhf
	hL6+6+o3UxuU3VIiUa6iUYRF25d8=
X-Google-Smtp-Source: AGHT+IHycALSdp58lauizjvlFTDf1HG4M++w1hgV9fGKdapW6+rKH86r7BfPv9mEAudb0KxSAZ4XSk5Y6G2ou6JVXQk=
X-Received: by 2002:a05:6512:449:b0:511:150f:6363 with SMTP id
 y9-20020a056512044900b00511150f6363mr560083lfk.32.1706685375813; Tue, 30 Jan
 2024 23:16:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131065322.1126831-1-maskray@google.com>
In-Reply-To: <20240131065322.1126831-1-maskray@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 31 Jan 2024 08:16:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>
Message-ID: <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
To: Fangrui Song <maskray@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Fangrui,

On Wed, 31 Jan 2024 at 07:53, Fangrui Song <maskray@google.com> wrote:
>
> The constraint "i" seems to be copied from x86 (and with a redundant
> modifier "c"). It works with -fno-PIE but not with -fPIE/-fPIC in GCC's
> aarch64 port.
>
> The constraint "S", which denotes a symbol reference (e.g. function,
> global variable) or label reference, is more appropriate, and has been
> available in GCC since 2012 and in Clang since 7.0.
>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Link: https://maskray.me/blog/2024-01-30-raw-symbol-names-in-inline-assembly
> ---
>  arch/arm64/include/asm/jump_label.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index 48ddc0f45d22..31862b3bb33d 100644
> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -23,9 +23,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
>                  "      .pushsection    __jump_table, \"aw\"    \n\t"
>                  "      .align          3                       \n\t"
>                  "      .long           1b - ., %l[l_yes] - .   \n\t"
> -                "      .quad           %c0 - .                 \n\t"
> +                "      .quad           %0 - .                  \n\t"
>                  "      .popsection                             \n\t"
> -                :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +                :  :  "S"(&((char *)key)[branch]) :  : l_yes);

'key' is not used as a raw symbol name. We should make this

"    .quad   %0 + %1 - ."

and

::  "S"(key), "i"(branch) :: l_yes);

if we want to really clean this up.



>
>         return false;
>  l_yes:
> @@ -40,9 +40,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
>                  "      .pushsection    __jump_table, \"aw\"    \n\t"
>                  "      .align          3                       \n\t"
>                  "      .long           1b - ., %l[l_yes] - .   \n\t"
> -                "      .quad           %c0 - .                 \n\t"
> +                "      .quad           %0 - .                  \n\t"
>                  "      .popsection                             \n\t"
> -                :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +                :  :  "S"(&((char *)key)[branch]) :  : l_yes);
>
>         return false;
>  l_yes:
> --
> 2.43.0.429.g432eaa2c6b-goog
>

