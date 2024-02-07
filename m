Return-Path: <linux-kernel+bounces-56896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F12184D0F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E101C24DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C183CDC;
	Wed,  7 Feb 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z+yFOxzq"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84ED8289A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329517; cv=none; b=Rbic7K50VanqDIizXNDXEVpKPKIHPJ+//IBLLoQt8BX5TyId0TMOLHCbn8XNEhDf63s19tLxb12JxUl2lVDiaCss3JtvDLzJjgPKFLgFJcvNQ+53q/7WDvUnaABZdh9BTxDoxJdoPquT8xViI67XuB/PqSKlsy16ZtCVoHV7V8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329517; c=relaxed/simple;
	bh=qR8GKpuuZaW4F6S0+Bd8OP3wU4IAuXpMl7pvAL9xLUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyKaR8IY2jcEbjv+tUQMfQtbPEF9dYJ5ViiesgneJWSAHqVF0gi8EzjgiOB5Xe0gqsBOMyuiuQho3SIJ25bxysYm0onbNrUrj1RcM3ZXAfGvg9/pSmVvoNpw85ofgQHTP7s90pXlkhD8Pc7tjGpPOIGwrbcr1AFEazd349odsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Z+yFOxzq; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6e4a55a71so910160276.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 10:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707329511; x=1707934311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsW74Q1+T1mksmXsIbj29+DJwVSribZJe7h8Y37ezZ8=;
        b=Z+yFOxzqvXorHX722BXwXXLCwnw/qrHzV68HOTRTlo81VM2v8Ffr6bB4dsy7i0gnd8
         Xb+J18XdDHvcRcjbyrCEphK1WW7sbsq+bV6r8hOFFPzu9wSphgG4yqOf0xJ0y3M1djwl
         qVEJnlOMI+tE3FYIfv64GE2XI8O8bLzZ/ddw9HQBwRL/M/AdbXxICSy5qLjRbXQGrL98
         vYzsbUWkBf+hw8VLP+y1QLeRkQHx7z3LaoMnHgc02/CmagTxhnS60NO/bl/GAHuyyT9f
         LWrnN+ZH5zphyPU9wviRUQZ+uZHiyPuwJ7d7wxzkJYbBmeGGm6T+YElIIvHWcgdZdsWG
         7Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329511; x=1707934311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsW74Q1+T1mksmXsIbj29+DJwVSribZJe7h8Y37ezZ8=;
        b=oi2FqkXHtlEeJ9j+JGRyotsuKUSVaMDF8BWk5fA/zlcH6oYG3EjiYm9X2+KT3jtq7K
         Xe/GMDXuw2S3rjBtwjMxSeTkyg2fVv82Cz3GNZQxgZQY1jkSGRI8dQQRjpM6NCaSM6Ch
         +x+GA3CuZY1DLGBCgtbKLPGmso2zCpD5vKXBcEhILbce8OE6TuLq/Kg333hCb8U9Njzf
         lIyPQWrDE0mnFxQYtfaVtyPEdrnde6AJ/uUdn006sVzZuzmHUvfCKO8ezjQaNP52VpN1
         gbJECy5v9n5p0fY0+qb9dmJS6Nf27feNeOQlwHV2JB+9APX6nHV0zMi8Beb4o9SNb2SY
         G/ww==
X-Gm-Message-State: AOJu0YyQGwbStiE9x5yFx8f9lLsodHp26Mt14oTT3hfYQibqkUwaeFy0
	2r2ju4RYdZOzRGxyX1tn0FU3ci7ySeOKs+lWHkQUMFBqaUD9qeiNGnO6HEZ15Dk=
X-Google-Smtp-Source: AGHT+IGqZ0PdGpZMTBV9zF8UO5NAGQRLPRdqGQhiGhIPGCtJUZIMcIORIqQV5b1hc7bjtFSOILoTUA==
X-Received: by 2002:a25:9304:0:b0:dc6:ae82:ed36 with SMTP id f4-20020a259304000000b00dc6ae82ed36mr5929066ybo.40.1707329510906;
        Wed, 07 Feb 2024 10:11:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcQ5OWT4CCOH/PP3Db4QUMkXA+yDlW1mbkX17EfCnXO5gK8WOP/Xozf7ihPYcix4koure7BaQW5jT+ar6hA8rU17AbGDtV9covzDt1yNLSG1P4laJoHR0ntUhk99ZUWbfKqm1YcNQqULJ7eQVL29wLgObNrVDkiLAvQdf+eFAwVvHPODwymRFSbyhAkiecQm7NU/yWYul68ExHWOfZVCb2tfBlPnAHZtfglgzEMwc35w1Oc+/TSnmVvH1MHnuSKrc8LZwgCDwwCYsb6KDShzTJWPNbkQVMLbcYNjFafFVuFJ0WiN631bsWhNTiTBkQKnUF/lsOjBbj8vrqDVTrB7EJhC2Rb2k+J2fxVJDrRj7AfQ==
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id f6-20020a5b0c06000000b00dc6da5dbe1csm292874ybq.39.2024.02.07.10.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 10:11:50 -0800 (PST)
Message-ID: <22d7dcc9-a14a-4e96-bfee-dd358af0afd5@sifive.com>
Date: Wed, 7 Feb 2024 12:11:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: timer-riscv: Clear timer interrupt on
 timer initialization
Content-Language: en-US
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: atishp@rivosinc.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>,
 stable@vger.kernel.org
References: <20240129072625.2837771-1-leyfoon.tan@starfivetech.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240129072625.2837771-1-leyfoon.tan@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-29 1:26 AM, Ley Foon Tan wrote:
> In the RISC-V specification, the stimecmp register doesn't have a default
> value. To prevent the timer interrupt from being triggered during timer
> initialization, clear the timer interrupt by writing stimecmp with a
> maximum value.
> 
> Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> 
> ---
> v2:
> Resolved comments from Anup.
> - Moved riscv_clock_event_stop() to riscv_timer_starting_cpu().
> - Added Fixes tag
> ---
>  drivers/clocksource/timer-riscv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index e66dcbd66566..672669eb7281 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -116,6 +116,9 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>  		ce->rating = 450;
>  	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
>  
> +	/* Clear timer interrupt */
> +	riscv_clock_event_stop();

This change breaks boot on Unmatched. The bug is that the above call to
clockevents_config_and_register() sets the timer (see below), but the timer
interrupt never fires due to the added call to riscv_clock_event_stop(). You
need to move this line earlier in the function.

Here's the stack trace from the initial call to riscv_clock_next_event():
riscv_clock_next_event+0x12/0x3c
clockevents_program_event+0x9c/0x1c6
tick_setup_periodic+0x82/0x9e
tick_setup_device+0xa0/0xbe
tick_check_new_device+0x96/0xc6
clockevents_register_device+0xbe/0x128
clockevents_config_and_register+0x20/0x30
riscv_timer_starting_cpu+0xa2/0xec
cpuhp_invoke_callback+0x160/0x61e
cpuhp_issue_call+0x140/0x16e
__cpuhp_setup_state_cpuslocked+0x186/0x2b0
__cpuhp_setup_state+0x3a/0x60
riscv_timer_init_common+0xea/0x184
riscv_timer_init_dt+0xbe/0xc2
timer_probe+0x70/0xdc
time_init+0x74/0xa0
start_kernel+0x194/0x35e

Regards,
Samuel

> +
>  	enable_percpu_irq(riscv_clock_event_irq,
>  			  irq_get_trigger_type(riscv_clock_event_irq));
>  	return 0;


