Return-Path: <linux-kernel+bounces-69633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC3C858C9E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC9D283645
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E881C14AB2;
	Sat, 17 Feb 2024 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm+Hd5xd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459811CAB
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708132055; cv=none; b=MUGj0XhiXVQlR7vESGezQYtvnAwofBUZQhpJud2VjGz8+MoXqdEVCKWMiudkY+X/QeGyVUvtQr3IKxiRcFQaW1LxZBb5z7OKTKKCwGvo89rKijppmgPFCA0hGMvs96N3RqBD3P7KE2WbIXeFsQNsuCw6679u4th7HvYmDveZdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708132055; c=relaxed/simple;
	bh=mQf5gJJ6NdN2hyEkzBNm8aZYruwyv8J7epPgamkF1Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftst0kZYmJPqJ4bxX5jy7WNNyT3Z7ef+mm6ruhE4KyLhS5nNXYACxjkh0rUGzxHE8+UI82aGxZI6XV65nQ8Fb+8stCkv1IC5mP2q5sUoDeIjpHMN1/1NovDL0xE6jUBVl209l2cqPWUNz9HMxn/JZ0wU+cTw9TGKPFNktGkDv0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm+Hd5xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8523C43394
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 01:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708132054;
	bh=mQf5gJJ6NdN2hyEkzBNm8aZYruwyv8J7epPgamkF1Yk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nm+Hd5xdiDX5wt8uAf1Q4UqpNP1rITuiDActDTj8tFhbw/ViXCo2e7U6Tqb8w8E9p
	 fNLnU6C2YU3T+hPGErx+ZzLaTIbhc6Yj9+hKK3OlRtrkLOzmBI2Din3TWGHGZy+A4I
	 ux46szeki3wD7Uqz5QZR3KZCmgZMwS65kWz4vcJSvw1OANkmUofn9cb8NHObannLAy
	 P9FqYVQDs76iIJEspC7vyAhkWRrxvE0iQ7P12X4JDcn7bQpRbi8kbuyp4jQoNWjrLE
	 3GxTwLKxx+qyx4Ka8oZitBSDVojEtKCkof8bTN2DSQejBWS0cXfH+j4BYjdhcUaIsg
	 BvMCFqB0uQ1fw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5129859c6b3so1388063e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:07:34 -0800 (PST)
X-Gm-Message-State: AOJu0Yya6ybXFmhd/w9HGVQjqYk/npoq2G3tocxvqmhr+1Wx6cm0whyh
	JdR0qqa8WaoSQ+zRxLedSBccCztXypVVdquxrFisQAwVovY0N1XELYFslTnbfgOYB8ak33iQu1z
	HEeEYiCyOo1VJOpkZKz2cpN77W2k=
X-Google-Smtp-Source: AGHT+IEom0NPnE2o3k8T7A/b6db6mij+TMhvFwofksKvsyZJ+d525UXxatwU/JP/zYIqSVRsAGgz7QhehmiLW98YHmA=
X-Received: by 2002:ac2:5e91:0:b0:512:9a29:1a81 with SMTP id
 b17-20020ac25e91000000b005129a291a81mr1405246lfq.14.1708132053196; Fri, 16
 Feb 2024 17:07:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216135517.2002749-1-masahiroy@kernel.org>
In-Reply-To: <20240216135517.2002749-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 17 Feb 2024 10:06:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFNoAUUiGMP95pTi_rSxSi5Z0HJo2kBC472f0koMr2mA@mail.gmail.com>
Message-ID: <CAK7LNARFNoAUUiGMP95pTi_rSxSi5Z0HJo2kBC472f0koMr2mA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove unused *_syscall_64.o variables in Makefile
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+To: Daniel Axtens



Maybe, we should check if the issue fixed by
2f26ed1764b42a8c40d9c48441c73a70d805decf
came back.





On Fri, Feb 16, 2024 at 10:55=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Commit ab1a517d55b0 ("powerpc/syscall: Rename syscall_64.c into
> interrupt.c") missed to update these three lines:
>
>   GCOV_PROFILE_syscall_64.o :=3D n
>   KCOV_INSTRUMENT_syscall_64.o :=3D n
>   UBSAN_SANITIZE_syscall_64.o :=3D n
>
> To restore the original behavior, we could replace them with:
>
>   GCOV_PROFILE_interrupt.o :=3D n
>   KCOV_INSTRUMENT_interrupt.o :=3D n
>   UBSAN_SANITIZE_interrupt.o :=3D n
>
> However, nobody has noticed the functional change in the past three
> years, so they were unneeded.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/powerpc/kernel/Makefile | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 2919433be355..72d1cd6443bc 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -191,9 +191,6 @@ GCOV_PROFILE_kprobes-ftrace.o :=3D n
>  KCOV_INSTRUMENT_kprobes-ftrace.o :=3D n
>  KCSAN_SANITIZE_kprobes-ftrace.o :=3D n
>  UBSAN_SANITIZE_kprobes-ftrace.o :=3D n
> -GCOV_PROFILE_syscall_64.o :=3D n
> -KCOV_INSTRUMENT_syscall_64.o :=3D n
> -UBSAN_SANITIZE_syscall_64.o :=3D n
>  UBSAN_SANITIZE_vdso.o :=3D n
>
>  # Necessary for booting with kcov enabled on book3e machines
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada

