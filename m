Return-Path: <linux-kernel+bounces-109102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AA88814A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BECD2846DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452F952F72;
	Wed, 20 Mar 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ1LsM5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C4524AA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948672; cv=none; b=Yxfk9X13b/8oZ9UsG2ImawQ8Ygyn6YwgnNB6pt9J1ldBRulCsnB05L9RPD67NXmfrDv6rM5miPnzMmCkxFi8ch8jqU2cDZjq5wnD6wTuupA3ZYrtZH9AMEjtrn02jjYt+tL8YcJwPjlvTgksrKnS4HmkcTs7ycql/UabMdz5zTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948672; c=relaxed/simple;
	bh=DuChraJXAL4NIGvlfbTG7149olXv38OG7LqUQoDJ9co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0ByqnjN+0Ew/6NVY8n+TLL/4aDHIrZZbv4RW98kv0HsoLRFVXVkfo63SVMKjtaNio5zzePRahl7+iYBAmZcdUTrYuiv2mViV8cuhR1WTzg/QxwntkHmgsxYmGbwfEuIlbyPewRY/E7RHKVcZ7XwaL/CPT8XUisX+CrwkGddHWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ1LsM5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6D3C433A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948671;
	bh=DuChraJXAL4NIGvlfbTG7149olXv38OG7LqUQoDJ9co=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BJ1LsM5UzFFYVovh1Z0/3+jEsCK9ZPdkvzH9TpRNLL3csInnK8WTg0ZuM3Y9xQjTS
	 w3+fNMRXHMxYFFl12DnI2Zcil/QDbQq0ao3wxAfsYaOgPiDQQLh3NqmBMWOVoYbvc7
	 AXCo2lgLs1ep8NnYtUUGSswAMQxjr/P6Qkn1c1BWfNa/ClTQg/hbzGvFgSAzxn5E7s
	 yaUC/OH0K/nbuDZRSS5sOgpRh5x6THj2se3KAQ/2X6GPmfWR/PyvzofljLGGWVP4v6
	 ZdNbcOOeCfFAYPdLnM9wsPIhLyReCtoUkC0DeLYcwE5dy92g33BKJd7AyizmyOpDxQ
	 3kJEp3lqEqpwg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513e89d0816so4502184e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:31:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLlYIrlwvQCDMViIWr0a8JsteFc9ZcOcDWfwj0Qjy4w58FBvdDvu11YXGFWUX2MXSbvvEnf58C9bUtJzb0dyqMxsIv3m+uIvHMntTf
X-Gm-Message-State: AOJu0YxuZswtjVzFf1YOJ/a9ox2BDcZqfPTa4lJcLfy4bgQxZvwk6uzY
	sIatD1T64USbNhVWoIPJKUnI1Tgxv3QLDvhkZqPMzdNlbdZwhdRKMEi8mZlXATurxzGnPvKopVB
	xrh/ZhXbQ7dOGuXZ+V6p9X7HGNQ4=
X-Google-Smtp-Source: AGHT+IHpVMN4a/tsjdabqhh3Y03hBwjAUOGLftrCJVaAlZXS0+qkSbae5dVhJzD/K3GABzVmuGFGKP5r5Ng1+14FS1s=
X-Received: by 2002:a19:ca04:0:b0:513:d640:ff15 with SMTP id
 a4-20020a19ca04000000b00513d640ff15mr3930070lfg.28.1710948669647; Wed, 20 Mar
 2024 08:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204122003.53795-1-masahiroy@kernel.org>
In-Reply-To: <20240204122003.53795-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 21 Mar 2024 00:30:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNASH+vfoXhTtPWqwHYgkhUaLfemB+xPfo=SM-rbg2rrhnQ@mail.gmail.com>
Message-ID: <CAK7LNASH+vfoXhTtPWqwHYgkhUaLfemB+xPfo=SM-rbg2rrhnQ@mail.gmail.com>
Subject: Re: [PATCH] x86: select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y
To: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?


On Sun, Feb 4, 2024 at 9:20=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> It took me some time to understand the purpose of the tricky code at
> the end of arch/x86/Kconfig.debug.
>
> Without it, the following would be shown:
>
>   WARNING: unmet direct dependencies detected for FRAME_POINTER
>
> because commit 81d387190039 ("x86/kconfig: Consolidate unwinders into
> multiple choice selection") removed 'select ARCH_WANT_FRAME_POINTERS'.
>
> The correct and more straightforward approach should have been to move
> it where 'select FRAME_POINTER' is located.
>
> Several architectures properly handle the conditional selection of
> ARCH_WANT_FRAME_POINTERS. For example, 'config UNWINDER_FRAME_POINTER'
> in arch/arm/Kconfig.debug.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/x86/Kconfig.debug | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index c5d614d28a75..74777a97e394 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -248,6 +248,7 @@ config UNWINDER_ORC
>
>  config UNWINDER_FRAME_POINTER
>         bool "Frame pointer unwinder"
> +       select ARCH_WANT_FRAME_POINTERS
>         select FRAME_POINTER
>         help
>           This option enables the frame pointer unwinder for unwinding ke=
rnel
> @@ -271,7 +272,3 @@ config UNWINDER_GUESS
>           overhead.
>
>  endchoice
> -
> -config FRAME_POINTER
> -       depends on !UNWINDER_ORC && !UNWINDER_GUESS
> -       bool
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada

