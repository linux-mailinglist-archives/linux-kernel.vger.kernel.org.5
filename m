Return-Path: <linux-kernel+bounces-56743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091784CE77
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14EC284381
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9380050;
	Wed,  7 Feb 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="DZd1Ehl7"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4F811F3
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321498; cv=none; b=pfmtswi9tzwE6F4micTyWn8Jk27fwBfoT9zPuAAxgu8Er/oM4ARpLLDfymBidvAukeSARdkvkjlnXtYg14/a7xYGpmx8SBX5RbaVPeETI6wYnI9Psv07hyyqDCKYiMMQYUGtS/hA6FL6+pKhNB0f/gP2sGRXO2v7t19SNXV1wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321498; c=relaxed/simple;
	bh=Qye+zuX3oCWPut5vgJD+q4hUJcHXW8C5VACBs8eHm0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq42C1CR7IEZngHZvArKbv7nK3yOuV2mJeIYWRw+N0Z14WAHWBbq4n+vwVpdDUTqNBVa+xo6q/xRfJLBy//6s/5T/t+evx2uerenofjXFt6YE8vVWdgSjjovGiDHQfwsiUz2dOnjLotXxTyCCy0P/z11obmNW8354TN3lTKmSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=DZd1Ehl7; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-363c7d490d1so1759065ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1707321495; x=1707926295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThW4UOydoSx884aXPLxWcHCPZYcLHmO6NwU0Jp/gx9M=;
        b=DZd1Ehl757sQTrcLgpMaNaPMsbbjFcz1JwySOu5c6Qwip36+h0dG0b8BD76rUrRt9p
         gQ1KI7lxrBtwDyIUT+D1Nvdq6Otf275Rr49KTnW+6aOZ0zDTl1ZMcveLu2Pm/LRI8bH5
         VHNxGve10y8gFK51hTx1hLfuGU8u9TgTZwVyl758ApKLun38jOrTnbT804bXWhpjPOtB
         QZO5QcTFoQkgP9V6Eojv1Qel18qXjoFaCL9wkm9EKTnEmdy50hPBAORnTcgXRnslJ3Dl
         RB7A7VvVM4YNKNCg5xphFmAaxzUUechkgx8ugV/pOcY9WwMFHE3bSm/GpvcuidKKZ4zs
         5n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707321495; x=1707926295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThW4UOydoSx884aXPLxWcHCPZYcLHmO6NwU0Jp/gx9M=;
        b=nORd2AbPzg1svhrwZ6ltbNvCjMT5G4RXU5MceWk6yuPRJeJEBEd9LRwZXgsDfYJTyC
         rbDVUjH90sb0cmKoC6Y8ODB4Zni0fDfq7CxZErnNeJOUAwCw94e0wskLfo0uNEk/jymp
         qtGfwu9mXLsJBcs6hqP1FeFkDWEq9TAU7+H5ceFiiBng9B+Xw1rJ9RX0NJPeS54ffalU
         lYJQ3cJRJzPPkiQ4W4ExRSNC020AmzpjliFiMr8vjFp0Rk49pcazbKBNTo1quTo5z3nH
         10IYE0V3Qx4/Jg0mRXhvQREeOLh2wExxeQdlLu1FStjsEqJ9EmLJPsnTGXbrSL7hXIHw
         hUrA==
X-Forwarded-Encrypted: i=1; AJvYcCUJylm5n2yVrdLssshGvxbILHiM4EbTLhFgGYtwsIcxV2psQhgqV55//7JrSwNW+hiWPPwOLoRHAnk0ZyTmnO07EjGpwyuEgVpZ0B1u
X-Gm-Message-State: AOJu0Yw8lnxX9n4ywzLxvc7c2f3kUZt+NH7nVA1dcdf3xogegl80egRq
	P6zA/of0/pCvOP33fc8p5EMf8ttLiYkykZhA3GJ13cDbjth9MXFUm6wJNOHi/X5WyMCCUeCemEc
	/S/7Xqgj5pGuhBeLvBlPB/gQp5puvlUgr1lC+RA==
X-Google-Smtp-Source: AGHT+IFCMccHnOQccdE1uuYts0EwIbRXGd1LC1MRLGFWoBZRBmKBJLB8KbPbNhmf/iNYEURqw+cqufs3Yf929+3A1QM=
X-Received: by 2002:a92:de4d:0:b0:363:c63a:7975 with SMTP id
 e13-20020a92de4d000000b00363c63a7975mr5867115ilr.24.1707321495246; Wed, 07
 Feb 2024 07:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129072625.2837771-1-leyfoon.tan@starfivetech.com>
In-Reply-To: <20240129072625.2837771-1-leyfoon.tan@starfivetech.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 7 Feb 2024 21:28:02 +0530
Message-ID: <CAAhSdy2Hp9GeXFBYVNSCGDNaHjYQjCgj+kPQtOaGz6RQecoDbw@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource: timer-riscv: Clear timer interrupt on
 timer initialization
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, atishp@rivosinc.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ley Foon Tan <lftan.linux@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 1:12=E2=80=AFPM Ley Foon Tan
<leyfoon.tan@starfivetech.com> wrote:
>
> In the RISC-V specification, the stimecmp register doesn't have a default
> value. To prevent the timer interrupt from being triggered during timer
> initialization, clear the timer interrupt by writing stimecmp with a
> maximum value.
>
> Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index e66dcbd66566..672669eb7281 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -116,6 +116,9 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>                 ce->rating =3D 450;
>         clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffff=
ff);
>
> +       /* Clear timer interrupt */
> +       riscv_clock_event_stop();
> +
>         enable_percpu_irq(riscv_clock_event_irq,
>                           irq_get_trigger_type(riscv_clock_event_irq));
>         return 0;
> --
> 2.43.0
>
>

