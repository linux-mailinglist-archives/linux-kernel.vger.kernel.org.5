Return-Path: <linux-kernel+bounces-112429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF58879B0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8983FB211E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCCC53361;
	Sat, 23 Mar 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfEYtPkZ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07450271
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214282; cv=none; b=autJOvH/rD+/635QpqPBIwwY/PdGBVYCJy3cddMLd5tkrtu3JYUh9NuJe0MPcgW1sed+wpkKRD/PjLmjKZ0iPtFBPCDLJhp9vavW9Qjw1IbuIwTEhR3rP1sZHoqN03bAsjiagVk2diJ70v8SIXCcnnXd5gbmeF59JvelzWmYThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214282; c=relaxed/simple;
	bh=GuUcBOImiQ2U5OVw7528NFI+bxb2T4QS1pPs6TqcPIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0veAaAjiTKCXe+Nxb1UPvAZKiUezv8inpMEjXHpVCcQiJAPOzL3C2GjcVhnMcQcwvOqc1+gfQOE8fxhZ2/BgEp8xlkF6MWSfhJAt+Bu6Nj+MtNpfQvWjM4FvlskUv2p5g/UaabPxaKmpQw/vLwgntFK+tBwwUWvFZC79I+lk3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfEYtPkZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d6c8d741e8so6808831fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711214279; x=1711819079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYVAh7hTkOlkJB45bkKBR7ZViFX7JGh8G+wzMSJ83Gw=;
        b=WfEYtPkZS/1Aoz+jx+gfP6l6QhbPz80TqCNZ16NE0iFeVqlwj0zcadXHsncnV0rcoV
         imd2V8dObzHQPUXy9uCqL9bQU7GYSXU2E0UaKvHl9HiDJwWfKEI8wFqKNswQtzcCcyMX
         H5vWNAapywjhkZurH1J68Ene0WI/WJ6ibnbX/mdCo3puENNteLs9oJ6OgDlMTkn6i0jc
         KIFz+twHLzOpBe2KZl0EJVGgji9VmGcbHqStd+trEndjODWFVK+8OwToWteyhyAHAXVZ
         jDT3i00YGO5/MmQsICXgQsCktKXtNPMTVl3RlvAsYS+p/FQDnVCxIiIF51zCqeoQ6RJn
         xEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711214279; x=1711819079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYVAh7hTkOlkJB45bkKBR7ZViFX7JGh8G+wzMSJ83Gw=;
        b=e6z2V+OxUcJNtSXd+eZK0c8uOLkbVpXnAe7wYisZXz/q4ikUPH4ttMDk+aiHPFGwUk
         Q8ElF9YqwHceHI47RKScWa4ZAGyRxUqkTnS23jltMweBo3mZV5RoYcrMuLlnT+SCP/pc
         R/PCqnfet2UFNufRwM1UeJeqBB46O+tPtsf1o3TqJhQEyjnDPTS2hncrQeyv+FC8XMit
         tQ84J5UMm8fmzoPBkHV+Q64tvMKCWRXygYyoufIwFqMW7dvOk4Uhl12YPnjt1xiuXTh4
         J6QWSX+QEQM5Adlgdw6EG1z6uxJZ/4kqOa5UaerIgcEujdpmAPxt4jLvzueR5onHdPu1
         8tMg==
X-Gm-Message-State: AOJu0Yw+OAGYrSwhFMnpBZoFwtJX01s6YTDHlQWYaoy4C+pe1tMmUxBx
	FpayLDyc7NQw3JvlrRpRFrlq2fvAg/71iiTbf24Ds9QqCigCtc5j9dcd5VPsT+XsgUmAMq8MRkX
	tTqXF4qJ6kpC3GH+VD/ogO3yMNtw=
X-Google-Smtp-Source: AGHT+IH4JZ5ThzZb5LPjqxTJLwvCs59t5LXxZZo8OQAzTCRi4gXK/JPnsoPuHpX0VPPX6c80+9HAmC9sCnpm8S+ECn4=
X-Received: by 2002:a2e:8545:0:b0:2d4:6a24:bb00 with SMTP id
 u5-20020a2e8545000000b002d46a24bb00mr1583851ljj.53.1711214278900; Sat, 23 Mar
 2024 10:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <20240322165233.71698-14-brgerst@gmail.com>
In-Reply-To: <20240322165233.71698-14-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 23 Mar 2024 18:17:57 +0100
Message-ID: <CAFULd4bcaO+3=KPz3wLGcVmHaAB_MdML+7THk3OTr6gPHfHwog@mail.gmail.com>
Subject: Re: [PATCH v4 13/16] percpu: Remove PER_CPU_FIRST_SECTION
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:53=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> x86-64 was the last user.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  include/asm-generic/vmlinux.lds.h |  1 -
>  include/linux/percpu-defs.h       | 12 ------------
>  2 files changed, 13 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 9752eb420ffa..74f169772778 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -1033,7 +1033,6 @@
>   */
>  #define PERCPU_INPUT(cacheline)                                         =
       \
>         __per_cpu_start =3D .;                                           =
 \
> -       *(.data..percpu..first)                                         \
>         . =3D ALIGN(PAGE_SIZE);                                          =
 \
>         *(.data..percpu..page_aligned)                                  \
>         . =3D ALIGN(cacheline);                                          =
 \
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index ec3573119923..b9ddee91e6c7 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -26,13 +26,11 @@
>  #define PER_CPU_SHARED_ALIGNED_SECTION "..shared_aligned"
>  #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
>  #endif
> -#define PER_CPU_FIRST_SECTION "..first"
>
>  #else
>
>  #define PER_CPU_SHARED_ALIGNED_SECTION ""
>  #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
> -#define PER_CPU_FIRST_SECTION ""
>
>  #endif
>
> @@ -114,16 +112,6 @@
>  #define DEFINE_PER_CPU(type, name)                                     \
>         DEFINE_PER_CPU_SECTION(type, name, "")
>
> -/*
> - * Declaration/definition used for per-CPU variables that must come firs=
t in
> - * the set of variables.
> - */
> -#define DECLARE_PER_CPU_FIRST(type, name)                              \
> -       DECLARE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
> -
> -#define DEFINE_PER_CPU_FIRST(type, name)                               \
> -       DEFINE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
> -
>  /*
>   * Declaration/definition used for per-CPU variables that must be cachel=
ine
>   * aligned under SMP conditions so that, whilst a particular instance of=
 the
> --
> 2.44.0
>

