Return-Path: <linux-kernel+bounces-121351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DD988E699
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F5A2C4BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F59157A66;
	Wed, 27 Mar 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YIoyDyqR"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13108157A42
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545141; cv=none; b=oP00CqefAYxLfaHGPcw9xHbRBxl6jrC5Vip0Zy7yDh+BC8wmvUaE0BNSOWFrhyBI2szH74F4kjx6XUI9+TJLX0VbvDhLuAxyILmTpnsLBPt/1yqQOCuuyhCbEekqAneEislKU+q+6be945RjqXiHDhw3/UwBq9oeryost4718/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545141; c=relaxed/simple;
	bh=EZD9R7kQPOleNH6dfp89r0J0EVvWnkBrQ3luSyujP4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSh6bflqXaqJ/btdj9mUbBA5RdTgcoJYAqm4gN3H5qUDESSLyfuZmCFYGsI6DFET/Fl12PGEQ1uOMnZJJOJWIH4F5d1Wa3P+HETidaD9JXEX2ygDEaibfcng7JUpz2Cy9hAG6G3qT06iw7P37Il4087sYppyRpvaOgy23NSobQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YIoyDyqR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so9103a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545135; x=1712149935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh0qAZ9DGKUKt/wTT7PZWIc64SA1BHl18Bv9aAtPYd8=;
        b=YIoyDyqROZM5KzgcfOAxrBhJsgvWqGYsSExNrnvgi3SkyrB26dGEJqQlURWJMVPv6v
         KgWM3YTVmBf1uoyUAU0M6AwhHFLqHEHyptqR9vMvTSF/WCjbxGQqCv6/5D4F5Qwo3GkQ
         oZoygEStJ0yC/wBtBj37glD5S8I9ldHZkYJRdeUWSFAQzWllA82pvVvXDOvW0/VJSy/r
         6BVCJ9xgnziX+pRoapNxTfAVrMTqaTthluds/pzkv9/+4XovGauONKGGKQ2KZUlPOMo/
         Gm5OSRdkkIF/Y3uf0xzxSckk99biiQe4NTXVlL73uvu0p59waCkaSaioivfj9QVhAPZQ
         ji2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545135; x=1712149935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lh0qAZ9DGKUKt/wTT7PZWIc64SA1BHl18Bv9aAtPYd8=;
        b=qbIHdAlvnycxM0EshIxoW2BlOG3YnBytl0e85NSBhi/Enu4RWbXZzi8I6aTlD9P//H
         u+JhfMrgBZzjtgDi2Lw73z12c+Wwrei7+TPLhbZd1r+EgVH8d0KYdtC3U+SJuQtifY2J
         R0fa1PAuGnAEYCUrW0ISOXq7/SCqAi/wy/uDmYSNfmbmXrHPq1O4CAwDrM/7DVtq9Pym
         DQCsVCtlIU/vFvqKyzcWABO0cBPnkAok9GsmJ7NcX8CaXbxmFkhMUFNQcQ9sUjAlerlT
         NTA9nCtItbMYItC4p+z0wnLAYmxVEUYnGmWgVFrkKFVykPnkApjdn3rQXy9pmX1SB9/F
         NUIg==
X-Forwarded-Encrypted: i=1; AJvYcCXBOvy7LDIDZNq2JOdamXABMQvd9BaK7J4/3UQ/hAYo9O2IYDBIyyBwZm/n61V2YRdhuG9OOBgNbnpT6nVteHrxU6ZG3WJ3aPzeQO3h
X-Gm-Message-State: AOJu0YznEgxJj5M/iAeL7YwkNWycp086kyrsQogVn0l59HPOJFBNvk5R
	+f0rAc5gbTPbE+zC8QrrJPp5cK3xBWOqTGk8RzqgH3sBwbmE6U4Ha5zJJSDp9vYzTsfF90LECCh
	bvzWajsPp4NP6ghQjdmfzLgYfwti3mNaGWLIK
X-Google-Smtp-Source: AGHT+IEXMaD8KKZ3q3120e6KG9qOf73GrC9gddy36kNW4t7F75Lwbo97LNYeyJwa97KmVaiaP1kaYiovo6xodOGckQE=
X-Received: by 2002:aa7:c0c6:0:b0:56c:5dc:ed7 with SMTP id j6-20020aa7c0c6000000b0056c05dc0ed7mr91414edp.4.1711545135114;
 Wed, 27 Mar 2024 06:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103031409.2504051-1-dapeng1.mi@linux.intel.com> <20240103031409.2504051-4-dapeng1.mi@linux.intel.com>
In-Reply-To: <20240103031409.2504051-4-dapeng1.mi@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 27 Mar 2024 06:11:59 -0700
Message-ID: <CALMp9eRLVJrGORS5RrXefLOiMkhvbSAMgHLcPHM1Y0sLbQ4MmA@mail.gmail.com>
Subject: Re: [kvm-unit-tests Patch v3 03/11] x86: pmu: Add asserts to warn
 inconsistent fixed events and counters
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Zhang Xiong <xiong.y.zhang@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 7:09=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.co=
m> wrote:
>
> Current PMU code deosn't check whether PMU fixed counter number is
> larger than pre-defined fixed events. If so, it would cause memory
> access out of range.
>
> So add assert to warn this invalid case.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  x86/pmu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/x86/pmu.c b/x86/pmu.c
> index a13b8a8398c6..a42fff8d8b36 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -111,8 +111,12 @@ static struct pmu_event* get_counter_event(pmu_count=
er_t *cnt)
>                 for (i =3D 0; i < gp_events_size; i++)
>                         if (gp_events[i].unit_sel =3D=3D (cnt->config & 0=
xffff))
>                                 return &gp_events[i];
> -       } else
> -               return &fixed_events[cnt->ctr - MSR_CORE_PERF_FIXED_CTR0]=
;
> +       } else {
> +               int idx =3D cnt->ctr - MSR_CORE_PERF_FIXED_CTR0;
> +
> +               assert(idx < ARRAY_SIZE(fixed_events));
> +               return &fixed_events[idx];
> +       }
>
>         return (void*)0;
>  }
> @@ -245,6 +249,7 @@ static void check_fixed_counters(void)
>         };
>         int i;
>
> +       assert(pmu.nr_fixed_counters <=3D ARRAY_SIZE(fixed_events));
>         for (i =3D 0; i < pmu.nr_fixed_counters; i++) {
>                 cnt.ctr =3D fixed_events[i].unit_sel;
>                 measure_one(&cnt);
> @@ -266,6 +271,7 @@ static void check_counters_many(void)
>                         gp_events[i % gp_events_size].unit_sel;
>                 n++;
>         }
> +       assert(pmu.nr_fixed_counters <=3D ARRAY_SIZE(fixed_events));

Can we assert this just once, in main()?

>         for (i =3D 0; i < pmu.nr_fixed_counters; i++) {
>                 cnt[n].ctr =3D fixed_events[i].unit_sel;
>                 cnt[n].config =3D EVNTSEL_OS | EVNTSEL_USR;
> --
> 2.34.1
>

