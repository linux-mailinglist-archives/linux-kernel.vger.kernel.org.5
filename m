Return-Path: <linux-kernel+bounces-155674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA03C8AF57A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A0C1F24D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944A113DDA4;
	Tue, 23 Apr 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hhPWfmTr"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9113D8B0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893182; cv=none; b=XH5ge44YETU26avRe22Zm6XAUs+x/i27NIF+i70fVxPC+DD42y38Y3S0Y5+KKqIm6bre7e4NO2utu4GDcipK7uW3D62NLy+0PDPDyf+sTLBpyuUbUreiPFGB7nFcxlYn5rTzS2MD+OL5Eot5Jr3GYJHL43nLaxBr7HHgjTrVccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893182; c=relaxed/simple;
	bh=y/gWDRg5azMor/2Aofxe6N4fri0YGxkZz2pXkN9ffwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tg22SE/Wd9SI0YuviDtQ8DdtLDSUonpptlTJulXf9qqmIA/Flf/uiLvGY7wTmK9ytgSVjUm1ze8zYlBJrTT+YJ7dBYKE+m42EwTCWHja4SInfGYishNcUgPKrb4YAoALizzZIubKrK0FhXTDck/IQiap6pCJCqf2HYU7OXefajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=hhPWfmTr; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5193363d255so7902447e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1713893179; x=1714497979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wSZEGJVi5OGysNr5Q/Szri9RMljTd9jL++xzWo19os=;
        b=hhPWfmTrdLmwQ+mNgHGLcmO0qZwLEMcU3OZR228YDS5sQbWNJx8KKAZ1/XAsDx+QP6
         FRnl8Kwh7e/DPDTfhbpirfaBGkSiWuiUU+6QqzJeQgNpXXzQECKg6bGPoWb4xxVjrRtZ
         xY+4uw5zrj8r4qkv5PBSfK00+TO6wucF01c0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713893179; x=1714497979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wSZEGJVi5OGysNr5Q/Szri9RMljTd9jL++xzWo19os=;
        b=G3reFnjsn2mxxY/emgdqMGZ+KYCEzNUaC9fjsEaww3TzunGJDtXn7FYFSOFaz3j52X
         9fG74JIGx6CDGgTqErZxgR1csX0U/A0y7MRvSF0ZLOD86W4VyKvlxMAs6zlfWqAGNVao
         M4MjlJ670jZm5A3GqbD4HM3QUy6nJKHkCA1THyn2iHGfnvhQHqENG5GRHbRvBnzQz6Tb
         I4SFYHAhBa2BKjfTeZv2+G4csjQ/+bwVZ9bw9hTgBoib/iQaIu/45Ka+Z9ghmZoouz0g
         XNvNkOt3VW7NAWRmdfg8YVXgIszLVRTed7noTE+MIZIUpp7NTqh8oy7LiTQ+NoxoRPbF
         CzGw==
X-Gm-Message-State: AOJu0Yy9M8XXsTTrvQm3AMedZuvnXA5Z/MOYbSauegCvoxyN39mj9rX+
	CESNvdLoxXDwCDAZHNl0fqdDNUTz/rX2YEx59QtSeC6wyQNmH843AXWvwlNPCw2GNUrUvVQ6H9e
	H/FJYyYW0kZEJW4jRVJ06QsBS5fVWVNA00eqxRnIExAu7x/W82fM6tQ==
X-Google-Smtp-Source: AGHT+IFTjidO0k5EKPLIvs7WXJ7O7CNHELrOpC1ZJHG/CmlX8aqmFH/VYBuhcZc+PhjgSlzjogvyqemcBD41ZPsrb/0=
X-Received: by 2002:a2e:9546:0:b0:2dd:74d3:7ca8 with SMTP id
 t6-20020a2e9546000000b002dd74d37ca8mr5055038ljh.27.1713893179140; Tue, 23 Apr
 2024 10:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407090558.3395-1-jiangshanlai@gmail.com> <20240407090558.3395-12-jiangshanlai@gmail.com>
In-Reply-To: <20240407090558.3395-12-jiangshanlai@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 23 Apr 2024 13:26:06 -0400
Message-ID: <CAEXW_YTin=EgjoypCD=eYh-NLRwxbhdr+B-jBO5TpC4qcef2_Q@mail.gmail.com>
Subject: Re: [PATCH V2 11/11] x86/rcu: Add THUNK rcu_read_unlock_special_thunk
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Lai,

On Sun, Apr 7, 2024 at 5:07=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.co=
m> wrote:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> Add rcu_read_unlock_special_thunk(), so that the inlined rcu_read_unlock(=
)
> doesn't need any code to save the caller-saved registers.
>
> Make rcu_read_unlock() only two instructions in the slow path at the
> caller site.
>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/entry/thunk.S             | 5 +++++
>  arch/x86/include/asm/rcu_preempt.h | 4 +++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/thunk.S b/arch/x86/entry/thunk.S
> index 119ebdc3d362..10c60369a67c 100644
> --- a/arch/x86/entry/thunk.S
> +++ b/arch/x86/entry/thunk.S
> @@ -13,3 +13,8 @@ THUNK preempt_schedule_thunk, preempt_schedule
>  THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
>  EXPORT_SYMBOL(preempt_schedule_thunk)
>  EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
> +
> +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +THUNK rcu_read_unlock_special_thunk, rcu_read_unlock_special
> +EXPORT_SYMBOL_GPL(rcu_read_unlock_special_thunk)
> +#endif /* #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT */
> diff --git a/arch/x86/include/asm/rcu_preempt.h b/arch/x86/include/asm/rc=
u_preempt.h
> index cb25ebe038a5..acdd73b74c05 100644
> --- a/arch/x86/include/asm/rcu_preempt.h
> +++ b/arch/x86/include/asm/rcu_preempt.h
> @@ -97,9 +97,11 @@ static __always_inline bool pcpu_rcu_preempt_count_dec=
_and_test(void)
>                                __percpu_arg([var]));
>  }
>
> +extern asmlinkage void rcu_read_unlock_special_thunk(void);
> +
>  #define pcpu_rcu_read_unlock_special()                                  =
       \
>  do {                                                                    =
       \
> -       rcu_read_unlock_special();

Instead, can you not use __no_caller_saved_registers attribute for
definition of rcu_read_unlock_special() or does that not work for what
you're trying to do here?

Thanks,

 - Joel

