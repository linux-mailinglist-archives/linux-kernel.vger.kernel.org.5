Return-Path: <linux-kernel+bounces-120559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F6088D959
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD552947E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE235881;
	Wed, 27 Mar 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M1AY9JwD"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7CB376E1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529026; cv=none; b=Zn5LoBrEi9W3GX8+Y0uxuVGWW/6e+imBUArmh1PRP9+KnfIaYIAyLMyX8Iz+5RzOGlBY2tSbcX3qR5+Rr57ntyRSnkCmdd4tzDGMdzhjPXXND/RVYZkeszUZkIP/o5K7BzQPCY9G/8q8WqKo19hUbLjbuJbz97zDNBBJSZFF+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529026; c=relaxed/simple;
	bh=tiOBYI4uQ/tfAymgid6wgWcwD+Wap/TYidDqRJDu9us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiJ5iXxreGnT+0Jo3OeX4uZ5kXt1xwEmqeO4KeJIGBA3EBnTVQ06cn3ffFV9hNPbp44Wil9kfUh6jSXWcCdqdptrfnjMiWSySFlBPo3DROCuRBp3giHKWqmmDUgFgskaTO4mCa2FOfD/UoC8KHd/ID1Sqt0/WjiqXeVdIcETkkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M1AY9JwD; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a492093073so283362eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711529022; x=1712133822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3qO0JEdl7yey5VJivO7+ugI6ufutpwhPOlblQnG63I=;
        b=M1AY9JwD4T7PWp5CvKn3MMQ0XPxvYzZRPjDP9VpVTeEGDb/XAS9iyJpFmOXLst+QsG
         kjeDvuSt4Crv788Ojgmau/14Vwb4hzUHb1KFDEpmgI9BR4f7AobCr8dBRDn3Z1SzKZqN
         pjoDbJfOBZW0PTvlxlmyaJjGKO5vmyMVitZXG/ck3sYNgVLaFPlY57ypDClIFSkOpR/s
         wpKiwajoVpDXhWVdY447ZGKxNeN88UXmvOBioEQmTCeMJqZhN9aoFNaFJxpQDWvNzA1W
         q5TD+eGb3tyjwujqRCy1+/kxUQrRLhKjWFI3gy7xoGGcdIg587pSZZFItzANXW5F+q4D
         GSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529022; x=1712133822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3qO0JEdl7yey5VJivO7+ugI6ufutpwhPOlblQnG63I=;
        b=eWJnVCDIoJIU0ZuNybaBGTu2qGnRE91uLfZKEDIS6vCho+HqIiouuYO64HnWuj9CFC
         W6BFQ3xxq0bXnA36W1ISkRdRfgp4xVoy141b0MNR/g5QvqI0flEH2qRkIu/r4umtfSAO
         Vc+pmUz5XSsfry/0UkOeOlDiNTYH7zKqJSqVKQd6zRdo7Opw48uWafN+ntIL5rQvNWNo
         fKnW7/97ZaZXAPIR7rBgTLEExjxRj3yExRStFv9JmwG8vVFUZbJWC4nlREdl1GbDEZtP
         Xz4AU/Y3our1EuLQhBsREZF47I0qqBHqhN3f9dBD0/gPOWbTHOr/PtgDo9406BuiIDPU
         hTxg==
X-Forwarded-Encrypted: i=1; AJvYcCWU94gs5EVXeu1wZ0qucDnwpyjhOiH4dHL6lTNcUPoGjUscO4tG1XF/xbGUvsxtcnbLkNv7YFzhAcdFV7CiP9oMRdNdwBzq3kRlSs+e
X-Gm-Message-State: AOJu0YyYSZgoC0H3e1HWfwPJE/CRUuYxeJia9ntifN8Fc4o4EDbQj9VS
	Wdr0TAzNFso2HyFE1sHh0nzJQALYqfuKGX5Mg2kKeZiNqopkaAGNSNl4njk3C0MAcBY4e6fOh4P
	XwUidEE3rkf93qVqaV89mhzxlcoPUY1sjQFqZ1Q==
X-Google-Smtp-Source: AGHT+IGkPnqj9OAHDB4ILzxWBgIirYzZWguS0X+Pc8OG1EelaK0HdCGJm3in13IBnzJdHiWHjq/npy//nSX6h+p9k0g=
X-Received: by 2002:a05:6870:9713:b0:22a:7541:d9d6 with SMTP id
 n19-20020a056870971300b0022a7541d9d6mr1132397oaq.3.1711529022761; Wed, 27 Mar
 2024 01:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327061258.2370291-1-sorear@fastmail.com>
In-Reply-To: <20240327061258.2370291-1-sorear@fastmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 27 Mar 2024 16:43:31 +0800
Message-ID: <CAEEQ3w=yNEktgUucmKuUvqfwDYYztVX+jofi5Q7hG-yQWcLbTA@mail.gmail.com>
Subject: Re: [External] [PATCH] riscv: process: Fix kernel gp leakage
To: "Stefan O'Rear" <sorear@fastmail.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Wed, Mar 27, 2024 at 2:14=E2=80=AFPM Stefan O'Rear <sorear@fastmail.com>=
 wrote:
>
> childregs represents the registers which are active for the new thread
> in user context. For a kernel thread, childregs->gp is never used since
> the kernel gp is not touched by switch_to. For a user mode helper, the
> gp value can be observed in user space after execve or possibly by other
> means.
>
> Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
> Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
> ---
>  arch/riscv/kernel/process.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 92922dbd5b5c..51042f48da17 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -27,8 +27,6 @@
>  #include <asm/vector.h>
>  #include <asm/cpufeature.h>
>
> -register unsigned long gp_in_global __asm__("gp");
> -
>  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER=
_TASK)
>  #include <linux/stackprotector.h>
>  unsigned long __stack_chk_guard __read_mostly;
> @@ -207,7 +205,6 @@ int copy_thread(struct task_struct *p, const struct k=
ernel_clone_args *args)
>         if (unlikely(args->fn)) {
>                 /* Kernel thread */
>                 memset(childregs, 0, sizeof(struct pt_regs));
> -               childregs->gp =3D gp_in_global;
>                 /* Supervisor/Machine, irqs on: */
>                 childregs->status =3D SR_PP | SR_PIE;
>
> --
> 2.40.1
>
>
Can you help express in more detail what the problem was before fixing it?

Thanks,
Yunhui

