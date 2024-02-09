Return-Path: <linux-kernel+bounces-58986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD284EF6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC641F2272B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B47522A;
	Fri,  9 Feb 2024 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGRxNdh+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CFD5221;
	Fri,  9 Feb 2024 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707449778; cv=none; b=Y8w5OglwM2ks07mpByzbUv0iOAi6GaQ7OXDrrHL0DWy3xpkNFnUVRXVx2LTjbvcWoAWnwwgDPPhH+NRQlP+sZxuHZHt2piXYCsuFnr8AZLP62bK1VaOApqjAeKsY+wOKY7FuY9ywOq52vF7CFY+XM5wjeQBAuhsyT8TL8dvfnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707449778; c=relaxed/simple;
	bh=wnmmjHj1LI3GGqxyQMdLK8lM2sPzTIkJ0DYLJb5Xxn4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fkRQfDN2Xy82yZRJOyCErj8N0SlD5+F3IvcynCP3KOhdlX8M1NTdeyBAnDwCH20Yzb/1YseAtMhWnNNeKYTuN2gcJ6Q++u+t4DqBGQUYcHXOHS3qoCCTE5susELfyzjRfLUr4LKBEYegzqJNYd52gKjTYmGdKYYWyCm400qS8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGRxNdh+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d71cb97937so4937145ad.3;
        Thu, 08 Feb 2024 19:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707449776; x=1708054576; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOvMICqHbaoju4gGMv5HJEQ663Ejredoe1u7kvvhOv8=;
        b=kGRxNdh+BWX5qVpPryfsY2O1zIS2xsPT5NnZlkGCNHPYJOfETE3h3TUgxE/R/VMkfi
         eCcbF5AWUG5kYztIy8pd6w5WuqhebeoRFrITT6MNZ9R+pPSBPipiInHaQsgwoFzPnm0M
         diBSDVRUlVRAVaXluaNY1kgNh/rhydo+nXBJXxtpVMkYJmgJ4SkcvCOJSPBbtepRFU1+
         n+RL3SDTirbzHK+5Rr9vpd3H1Hyu3I9EJUqB2YlHZ4uxooASoPmbaq9AOz8sF1xPgLIo
         RoiRhkwhUYyKsL37BZ2UCa9Y2czeXvZvtXzN7ZGz4C+83MLSuj+LSGk0DUTJnN1H1awa
         imCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707449776; x=1708054576;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jOvMICqHbaoju4gGMv5HJEQ663Ejredoe1u7kvvhOv8=;
        b=hidqbnyE15nCXSmeiwpBUvN72nkH01WKX2XN17XPF6pTEwTVdmETKlM9NzTJbe4Osx
         EqwZ02FjJr05zb8/ylERljqah/pKKWiAdvXJhBgmFPia9Lvv2AbP7cQY22mq8m18LiPi
         V2/cqZkY9tMyTZ57jw9aqAH+KGx0LjDQ9yw+aGPjkHwX76mQ7VoguSwh7FYPXn/O10If
         nXwi2SYF3jrHngCLvxkvXLNNSFJpqGJqK/eM386J1gRA5NHeK+rpHcbkJwZfQOi8+x6i
         J7dKUwXNhaqx+56mute9o5H5NEyAGqHhSaQLRm/VTvHtujq4n+giQPrYN8q4kJyDDDl6
         lmow==
X-Gm-Message-State: AOJu0YzWw4JjWJX/0EU5i4VEAIKAieBwBMCA0k0iCrFi55NhhcnAnOHp
	mYkGfYklkMMAEYaqDLCH1lmDDMUe71nZ35g3VfNazk7lkh9pm+Do
X-Google-Smtp-Source: AGHT+IHdFrXH0nFeT4r0VIM8Ek03n+of3+ergenrguqPpHfVaRkUsdkMotfoKwjHuG7PmWZPn+JCcw==
X-Received: by 2002:a17:902:6503:b0:1d8:f071:5067 with SMTP id b3-20020a170902650300b001d8f0715067mr341574plk.35.1707449775931;
        Thu, 08 Feb 2024 19:36:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWVSVfDEQS9ReM36LvSuofXi4xTJxAg2CkEwnRVAsPg/JSKZ4bUTZGysq63ScL77uYHKfUlVrAeuNd8Rpz2kwcZ3lRcpI47DQ5uPORBCqz3rTemp/ZJM1xbFk8/f4TSc9maOYHW7qC1gkl9Dn+bG6isSvPSkbnDNdvRuMrUp18sbvU4qMpvmwiGny/8tMbAOpkE2cU6rlbQxJVUzcVMEWThSFGG5Z6C4feX6eQXbOLxBLYklnzHsUCJSb7+EXtzzHpwGKUGIMDho4G
Received: from localhost ([1.146.65.44])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902654d00b001d8cde39e8bsm533560pln.194.2024.02.08.19.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 19:36:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Feb 2024 13:36:08 +1000
Message-Id: <CZ08FF0GBT76.1FZS9YFEMKSOM@wheely>
Cc: <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 2/5] sched/vtime: get rid of generic
 vtime_task_switch() implementation
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik"
 <gor@linux.ibm.com>
X-Mailer: aerc 0.15.2
References: <cover.1707422448.git.agordeev@linux.ibm.com>
 <2baebb95af9772959a0d85d0bd789afdfd2baf94.1707422448.git.agordeev@linux.ibm.com>
In-Reply-To: <2baebb95af9772959a0d85d0bd789afdfd2baf94.1707422448.git.agordeev@linux.ibm.com>

On Fri Feb 9, 2024 at 6:15 AM AEST, Alexander Gordeev wrote:
> The generic vtime_task_switch() implementation gets built only
> if __ARCH_HAS_VTIME_TASK_SWITCH is not defined, but requires an
> architecture to implement arch_vtime_task_switch() callback at
> the same time, which is confusing.
>
> Further, arch_vtime_task_switch() is implemented for 32-bit PowerPC
> architecture only and vtime_task_switch() generic variant is rather
> superfluous.
>
> Simplify the whole vtime_task_switch() wiring by moving the existing
> generic implementation to PowerPC.

I think this could be squashed with patch 3.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/cputime.h | 13 -------------
>  arch/powerpc/kernel/time.c         | 22 ++++++++++++++++++++++
>  kernel/sched/cputime.c             | 13 -------------
>  3 files changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/as=
m/cputime.h
> index 4961fb38e438..aff858ca99c0 100644
> --- a/arch/powerpc/include/asm/cputime.h
> +++ b/arch/powerpc/include/asm/cputime.h
> @@ -32,23 +32,10 @@
>  #ifdef CONFIG_PPC64
>  #define get_accounting(tsk)	(&get_paca()->accounting)
>  #define raw_get_accounting(tsk)	(&local_paca->accounting)
> -static inline void arch_vtime_task_switch(struct task_struct *tsk) { }
> =20
>  #else
>  #define get_accounting(tsk)	(&task_thread_info(tsk)->accounting)
>  #define raw_get_accounting(tsk)	get_accounting(tsk)
> -/*
> - * Called from the context switch with interrupts disabled, to charge al=
l
> - * accumulated times to the current process, and to prepare accounting o=
n
> - * the next process.
> - */
> -static inline void arch_vtime_task_switch(struct task_struct *prev)
> -{
> -	struct cpu_accounting_data *acct =3D get_accounting(current);
> -	struct cpu_accounting_data *acct0 =3D get_accounting(prev);
> -
> -	acct->starttime =3D acct0->starttime;
> -}
>  #endif
> =20
>  /*
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index df20cf201f74..c0fdc6d94fee 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -354,6 +354,28 @@ void vtime_flush(struct task_struct *tsk)
>  	acct->hardirq_time =3D 0;
>  	acct->softirq_time =3D 0;
>  }
> +
> +/*
> + * Called from the context switch with interrupts disabled, to charge al=
l
> + * accumulated times to the current process, and to prepare accounting o=
n
> + * the next process.
> + */
> +void vtime_task_switch(struct task_struct *prev)
> +{
> +	if (is_idle_task(prev))
> +		vtime_account_idle(prev);
> +	else
> +		vtime_account_kernel(prev);
> +
> +	vtime_flush(prev);
> +
> +	if (!IS_ENABLED(CONFIG_PPC64)) {
> +		struct cpu_accounting_data *acct =3D get_accounting(current);
> +		struct cpu_accounting_data *acct0 =3D get_accounting(prev);
> +
> +		acct->starttime =3D acct0->starttime;
> +	}
> +}
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
> =20
>  void __no_kcsan __delay(unsigned long loops)
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index af7952f12e6c..aa48b2ec879d 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -424,19 +424,6 @@ static inline void irqtime_account_process_tick(stru=
ct task_struct *p, int user_
>   */
>  #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> =20
> -# ifndef __ARCH_HAS_VTIME_TASK_SWITCH
> -void vtime_task_switch(struct task_struct *prev)
> -{
> -	if (is_idle_task(prev))
> -		vtime_account_idle(prev);
> -	else
> -		vtime_account_kernel(prev);
> -
> -	vtime_flush(prev);
> -	arch_vtime_task_switch(prev);
> -}
> -# endif
> -
>  void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
>  {
>  	unsigned int pc =3D irq_count() - offset;


