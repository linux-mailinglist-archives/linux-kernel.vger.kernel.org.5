Return-Path: <linux-kernel+bounces-139742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC58A071B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EA42880E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F6213C3EB;
	Thu, 11 Apr 2024 04:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8pH5eHM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077D13C3CC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809581; cv=none; b=VTl0xqc+i0K5aQEblM4AZSbwlRz3V2atv/cLmmcO4t5RKhE3Qh+5KsIuW2OSjbqBBv9twuD/BNmm1T7ZzAFb5RPPWDmaGiNLHJs+zElXy6jPSZug+nTmF3j1rbwMno6OJlWkvgMtbVEo275n/5hGgdHU1RrJM5jftepItjpvzgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809581; c=relaxed/simple;
	bh=/q7iMqTpyocMLmlNFkIDRC4Xd5ZbNsklJw5oQFTpWPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGt/zpzfT2KJ99E+4KfMdDmCvaeHLL2IIejmvb4sAWtCofPCYYRpVxOKJnaK2nFZ/A64xHeHaXD9JRGmNN/ZsTWabQ92TNMTDPebmMpYtiyz9hqZVSRobKBPFcfbruhEINwA/LdnLnKrQnArbTHkj881LRM2KWf+zBbGy6dp9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8pH5eHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59F8C433A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712809580;
	bh=/q7iMqTpyocMLmlNFkIDRC4Xd5ZbNsklJw5oQFTpWPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X8pH5eHMlWVPFrNOhrDnbUKEEmZ5LlvoQXeBoYdwkVxpTRJHBPL5bVzdEJK1SqV6G
	 rXqJ7KCWS7hUyYFif8fc0PtcIY5qpDSerRooB5v3cV/msT6nOtIKHCz2guFx6uB0Lx
	 Zm25NmNgg0YxdFeYb7WmfthhNlmNRCy6TvkUkU5h23/2OlArg/IHQEJXSbb0tmO8TF
	 WqYOhufWip646naK4IqtzuzDqm0aRh0ry7QfZGMg7r5twKIP7gXw4p0D0h3ziKZ+Km
	 ZGmqJFeMqPItsdc8PnhHNHxnUCBEIMf62ZZLtp5RgYl2vRtry//DIvHC9ScNQT1d5u
	 ZeMeSAvnRa3Kg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56fc155b646so1639047a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:26:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUy2WHuNFRHwS2ZMTypI622ivJehEv6xLEpsjI/3/MQGm8wxPGK68UclxvTo4GP5Z1tCxgmNiJQBv0+5xAhgEdqg9xKdWkTnonwKvfj
X-Gm-Message-State: AOJu0YyefkOD67CDGeZ3YmlQm63OXWIQCzrE8Ok82ezuv9imomxmpWqN
	Dh0Bc0monckELIFhfWB+4gnzrbNInMqmQ87KCJN08YDFi7cbBpo6IuTu5D8mKsWiaM1JZTzE2gF
	XL6vQMr8jdhTsYDaaGoHXnmmCi88=
X-Google-Smtp-Source: AGHT+IE04cGkfb+QSGG8YT32vVk5YJkANcYGQPu0SgZPQFDttnqZPkR3+1b8rvfcbeR84jRHU1tMoVWhykYlfsap4JE=
X-Received: by 2002:a17:906:da04:b0:a51:d239:be0c with SMTP id
 fi4-20020a170906da0400b00a51d239be0cmr2660327ejb.32.1712809579138; Wed, 10
 Apr 2024 21:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411010510.22135-1-yangtiezhu@loongson.cn>
In-Reply-To: <20240411010510.22135-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 11 Apr 2024 12:26:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6bHudfUVE4SWY88mxmLhFok9DS8UyODSZEdUJ816V8Rg@mail.gmail.com>
Message-ID: <CAAhV-H6bHudfUVE4SWY88mxmLhFok9DS8UyODSZEdUJ816V8Rg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Give chance to build under !CONFIG_SMP for LoongArch
To: Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Marc and Arnd,

I remember that you both suggested not introducing NOSMP support for a
modern architecture which brings additional complexity. I wonder if
you still have the same attitude now. I will merge this series only if
you think it is worthy to introduce NOSMP now.

Huacai

On Thu, Apr 11, 2024 at 9:05=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> The changes of irqchip have been merged into the irq/core branch of tip.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3D=
42a7d887664b
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3D=
a64003da0ef8
>
> This version is only related with arch/loongarch and based on 6.9-rc3,
> the first 3 patches with detailed commit message are preparations for
> patch #4.
>
> Tested with the following configs:
> (1) CONFIG_NUMA=3Dn, CONFIG_SMP=3Dn
> (2) CONFIG_NUMA=3Dn, CONFIG_SMP=3Dy
> (3) CONFIG_NUMA=3Dy, CONFIG_SMP=3Dn (not allowed due to NUMA select SMP)
> (4) CONFIG_NUMA=3Dy, CONFIG_SMP=3Dy
>
> Tiezhu Yang (4):
>   LoongArch: Move CONFIG_HAVE_SETUP_PER_CPU_AREA related code to smp.c
>   LoongArch: Refactor get_acpi_id_for_cpu() related code
>   LoongArch: Save and restore PERCPU_BASE_KS for ACPI S3 state
>   LoongArch: Give chance to build under !CONFIG_SMP
>
>  arch/loongarch/Kconfig                |  4 +-
>  arch/loongarch/include/asm/acpi.h     |  8 +++-
>  arch/loongarch/include/asm/smp.h      |  5 +++
>  arch/loongarch/kernel/acpi.c          |  9 +++-
>  arch/loongarch/kernel/irq.c           |  2 +
>  arch/loongarch/kernel/machine_kexec.c |  2 +-
>  arch/loongarch/kernel/numa.c          | 58 --------------------------
>  arch/loongarch/kernel/smp.c           | 59 +++++++++++++++++++++++++++
>  arch/loongarch/power/suspend.c        |  4 +-
>  9 files changed, 87 insertions(+), 64 deletions(-)
>
> --
> 2.42.0
>

