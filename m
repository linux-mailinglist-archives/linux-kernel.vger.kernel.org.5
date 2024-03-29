Return-Path: <linux-kernel+bounces-124044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C74F89117F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D182922BB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41593D980;
	Fri, 29 Mar 2024 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INIavxLJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3B3BBE8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678199; cv=none; b=L2XRKicWq09y33hc7fCcYj+arZwRJh4BydrTYrt1aZD6P/cvZo1DTLFdhJQVEAYA2L0gUbPYeJ+t5659Szftevw6kHxXMol54zsDNPcfI38Oq9TEYrDW8hyyHRJYXpH6oQbzf2QpaZBIRMHtwAB7nVfEComx1NLfAM3o7puTtEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678199; c=relaxed/simple;
	bh=O9z1sL+vMCRFfB3bDOcyTXkEgXLhwYxZh+K+xvS9TS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVnsM2nn2b+cs2RqnyjjC3b7/JkHpQ6Wj7QUC4TVYbwdSQfFWDUh6ovDLQL+Z1/s35B/vhe3wdRM9DXOCcXa5R+MD2ytZCEV/sqpX9Ib6kAcW8aP53TAwKCzfbHammodMhTRr1TBzZvHQZVVPbrZKdVi8rsmEzrqKfr6HCB1uxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INIavxLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C346C433F1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711678198;
	bh=O9z1sL+vMCRFfB3bDOcyTXkEgXLhwYxZh+K+xvS9TS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=INIavxLJvHbcdDLbeoKPveLdoWzghwsDneAUpUr9dyM1TKpI7HuK7KM2i6p07734g
	 NFm1FnGq2DHgjRMnetNg6vhN6SP2FNQI9SyJTpxkSDDxgbcgDSW1iMxTaQDtbq/OJU
	 43SoAUDvCDWouiS/lpqXBvpBQwyMT4stQjyQrUSn7iUC5m+sSlKdZpT1f+dh+ctwwA
	 s1mxmsSRx9TrR8jtwyvZCMbNr924Hjv10kBvOWP+UrC5RyYOb/c/Cm11AMSFMT5bgC
	 JHkWUtwfpsESRGMnvEV9yCXnr7Ww3TeUgjzQ7h6L8UokfqLaC6ynyt5rAzF6h8XUO1
	 JHvzwtrdONtDw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56bc5a3aeb9so1983073a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:09:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmqzPcUL9T3gzwAX8GGkptzNXry1hqFUeP9v2bt1psjYe74225e0vGKAninrlS7w0v3TQjgvimsXET9v1vm0ugyueQKgCQCfNkeTDq
X-Gm-Message-State: AOJu0Yy7fN4AxMHmRBePgsvsJvbxusA6sslZJMXwSieDfq8gAgaucHVE
	+Mji9IXMrw1eGr2G7fzZpyXeYr1a1E/ALNqShXap4aHQdaXxh0IbsjpEgFKZ+pHWGDyhLvsQu0f
	Yub/Sa7I97782CvfpMtzdahAJITw=
X-Google-Smtp-Source: AGHT+IG9rmDhNQYwWcZ7V3SaBxvNkaVyG+uqNJJE+QXlkueXnQNuNBl2I8rYQB7X8F8Rd9iwdY+MGAuO+ZQOzIW1/RQ=
X-Received: by 2002:a17:907:d87:b0:a47:52b7:3822 with SMTP id
 go7-20020a1709070d8700b00a4752b73822mr718148ejc.47.1711678197111; Thu, 28 Mar
 2024 19:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327171807.27741-1-xry111@xry111.site>
In-Reply-To: <20240327171807.27741-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 29 Mar 2024 10:09:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H77h3gE_tDKiFYhDC4NbB9ain=sGCemeJ54y8aqvvmrMw@mail.gmail.com>
Message-ID: <CAAhV-H77h3gE_tDKiFYhDC4NbB9ain=sGCemeJ54y8aqvvmrMw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Select ARCH_HAS_FAST_MULTIPLIER
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued for loongarch-next, thanks.

Huacai

On Thu, Mar 28, 2024 at 1:18=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> LA464 and LA664 can do 32-bit/64-bit integer multiplication with a
> latency of 4 cycles and a throughput of 2 ops per cycle.  It's
> comparable to mainstream x86 and arm64 cores, so select
> ARCH_HAS_FAST_MULTIPLIER like them.
>
> It speeds up __sw_hweight32 in lib/hweight.c for about 14% on LA464 and
> 11% on LA664, and __sw_hweight64 for about 30% on LA464 and 33% on
> LA664.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 5a769bb92d7c..d52a95195e7f 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -16,6 +16,7 @@ config LOONGARCH
>         select ARCH_HAS_ACPI_TABLE_UPGRADE      if ACPI
>         select ARCH_HAS_CPU_FINALIZE_INIT
>         select ARCH_HAS_CURRENT_STACK_POINTER
> +       select ARCH_HAS_FAST_MULTIPLIER
>         select ARCH_HAS_FORTIFY_SOURCE
>         select ARCH_HAS_KCOV
>         select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
> --
> 2.44.0
>

