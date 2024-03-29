Return-Path: <linux-kernel+bounces-125058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A83891F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C764B289459
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D141422D8;
	Fri, 29 Mar 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRpzkkk/"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1F25777
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718506; cv=none; b=nZDOlSD+6odl4fimYoEya/SbdrM8bFhkzIvKoCYnlSshbUzFin//ZuPdAPg1j8nqZlZjvmeZWUP5sgmZrwDoWHs0Q6waIsLuUA3KI9u+QrfSRiIbhMtSxznFod7gtMfCW3Ar2ibmdlY1PVgaePo1eE6nXWl1D7AreJWWzbJUuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718506; c=relaxed/simple;
	bh=RAhOseKWHqjGtVoiQ7a2nR2D+WRBJpAPx8SCmHJSxcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UD+JpT/EuUSjAe8P0EdZMnNsCKCrvYZzbvg7hIS9ZDs3cPVAenWYpSH9w6ZPkHQEOW+wyrdr2jWyT2XhAoeZcuE28xqvwCZX/eGN6MbbL1ppgXUn8BVtbomo3uoFpaYLrGRPz+dtoCnsEs0vJbDh43yvtxjEJjWvSkFvgTfWq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRpzkkk/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c63f4a468so5734a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711718503; x=1712323303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6Qr+2wZkDiWc+QhngmAmneq974QF4QT4bvvKPeEeCI=;
        b=mRpzkkk/qOu1huMf7Y1GSiuMGohxIBM4rnlP2tBZoxrQY2yoJxd3ADqafDnSUdQYOp
         MpzADVyy9tn0zskIXC//tGWfCK/4wBmfYJxQPW5tF4MZY+Nvg3QiZy/rRVelNbg1Uscc
         Llhi1aZ+jZizXWES7IMGcZAtAwbyNiLeOE1lHXespehUyIy4kKpk+5h0+fEIW6wcnarh
         8FbWrhxF9Esm911DWgFBqbpHvgHrAKwIDpbm1WHkr8Q8tB/VXO+5UiKAE0/bHuTBEp92
         XZ69dUpYiANFfyUzMr752lXHxksyRyCwXjB4i382sYGFM1F5G55g4twyKY5pMJ/AoGZ9
         2h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711718503; x=1712323303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6Qr+2wZkDiWc+QhngmAmneq974QF4QT4bvvKPeEeCI=;
        b=i9GrXiZUDJtwHsJ5qLzkWRBG2+i8cIj50efCDvcS88HC9VPiX8k9xX56bmugff2eCm
         SHl0j1Bvt9T/uC4CmVDidFuHr79UNQulV5GmHBJneZl6TZLfHx0dWup7b2dUdZgDR4Qx
         9/81yDHg8ffdlNe76FWs1KNzF0vmXtRtgMXGpc4eltjfuW+ELNkdQW6Z4Uuar4smUT6Z
         5o17fSPkZJvi9gMYN9YEcLUxtOVYyqsroaJ+3FsdWAvUTUppokjx80rLptI8TxxI5+5S
         ndYS1uccqaB3vPNLUYZiGMtQObjfWCLjCGAt6mzLtNVxjcHG3SS8F6l+NB38NXr7HeOz
         Dh0w==
X-Forwarded-Encrypted: i=1; AJvYcCWouiLRsBiwdBc1VCQuIYH0fHCQFWCyJnE/HgANTUp+F5+Fte3fh0spMFXPL/sMavW/6yhtEHhcW2zCaM4I/dhfEN2KKRg1X0gklHS5
X-Gm-Message-State: AOJu0YxzcAJ3uNWYzrCCvYoShgPwIQYukU470+utkiJUQoEOFfxld5ES
	1zWPEk7f0Yh9MXXK0tnJs0anIEbn+HXxRWDPaHBVCWVkGtP+DlAqIqFjloheJX8sJdxkYb0abHq
	OimOEE1K09VLdJEiZEGIGO1VlAyKTtql4klmm
X-Google-Smtp-Source: AGHT+IFyUO0LdXXBQqKbbrkev8q9MSFk85GtCswxxjiFZg14xnRhOn+ConDZ24SXfudvkm8YB3u16z3CQV5DlRSNzKM=
X-Received: by 2002:a05:6402:35d1:b0:56c:63dc:c02b with SMTP id
 z17-20020a05640235d100b0056c63dcc02bmr106182edc.0.1711718502598; Fri, 29 Mar
 2024 06:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329105610.922675-1-dawei.li@shingroup.cn> <20240329105610.922675-2-dawei.li@shingroup.cn>
In-Reply-To: <20240329105610.922675-2-dawei.li@shingroup.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 14:21:28 +0100
Message-ID: <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=gK8Aow@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/iucv: Avoid explicit cpumask var
 allocation on stack
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	ioana.ciornei@nxp.com, wintera@linux.ibm.com, twinkler@linux.ibm.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:57=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn> w=
rote:
>
> For CONFIG_CPUMASK_OFFSTACK=3Dy kernel, explicit allocation of cpumask
> variable on stack is not recommended since it can cause potential stack
> overflow.
>
> Instead, kernel code should always use *cpumask_var API(s) to allocate
> cpumask var in config-neutral way, leaving allocation strategy to
> CONFIG_CPUMASK_OFFSTACK.
>
> Use *cpumask_var API(s) to address it.
>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  net/iucv/iucv.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index a4ab615ca3e3..b51f46ec32f9 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c
> @@ -520,14 +520,19 @@ static void iucv_setmask_mp(void)
>   */
>  static void iucv_setmask_up(void)
>  {
> -       cpumask_t cpumask;
> +       cpumask_var_t cpumask;
>         int cpu;
>
> +       if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> +               return;

This can not be right. iucv_setmask_up() is not supposed to fail.

Since iucv_setmask_up() is only called with iucv_register_mutex held,
you could simply add a 'static' for @cpumask variable.



> +
>         /* Disable all cpu but the first in cpu_irq_cpumask. */
> -       cpumask_copy(&cpumask, &iucv_irq_cpumask);
> -       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), &cpumask);
> -       for_each_cpu(cpu, &cpumask)
> +       cpumask_copy(cpumask, &iucv_irq_cpumask);
> +       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), cpumask);
> +       for_each_cpu(cpu, cpumask)
>                 smp_call_function_single(cpu, iucv_block_cpu, NULL, 1);
> +
> +       free_cpumask_var(cpumask);
>  }

