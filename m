Return-Path: <linux-kernel+bounces-54213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A2D84AC4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492851C23780
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376386E2AD;
	Tue,  6 Feb 2024 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UId0iQes"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68396A349;
	Tue,  6 Feb 2024 02:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187695; cv=none; b=AEVyVh3rIlJVmpPLR/JPsfwY2j/9GsVCC6Gcr5I4rpdRDI5+xyvG02kizIIXZCODbXRdx+TyEFVzBxu5ye6UGzPSfdQ0P9AgPI4967ohaoODIHpGMlJudKaTHffpaJUmJXjf4vE3pJrX5iZ5ad3SIJ/ic5Ce+WBPu8QraBBIOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187695; c=relaxed/simple;
	bh=g97MafxmWkkbuH7YZJsImN/74WsrR8GMXQUxgb99sNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhocQ0M13U0h84S1SsUrMFdyunDj34dbn0Eicmrz3k1JjJfC9wzUdNyGRsVdkRlmufFC5+v2yfdT7RmQkbcsvpX6Nja+gFUOeXDeQ6MuSr4wP+ISDKYGMq4Sy38YIHXuQCd5oGwN7fhpuf0aL3qhsAErP1d+s9Qehhn85Fm9450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UId0iQes; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fd6c24812so16014955e9.3;
        Mon, 05 Feb 2024 18:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707187692; x=1707792492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irXzmlt0LEedc8/XYXV/+59KeIGKtdiSyDhOcdwVB/g=;
        b=UId0iQes9xOBJmLKHtZTvDZdiERxWe7nHHG1tiwTIkHpvYT8DLKdqpAgWHGAlOHJ+M
         m3J6F9N3NXBo9uEL6ZQnMjFaGCgv1bq4UuOqZlzQshfzE120e5kiykYoMsobn4znayGP
         NibqEDRwZT7KDvPxNnO+/Co+P5+aPGy0bzT5W/9qV6Z5jWn48ZIthLeXqMHgd18a6Q90
         suu2PyfcJ0pMytNeHRMj5ASuKA0F7PJCVJCteqHUYYlN0t+s7HgEXPVzG91+pP7qtvtN
         36RTQmIx5oDahOdzxegrcIVnRflkgs8DAdrAX5FirzGro6ss8egm8eOdBywr0OZodmtD
         CPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187692; x=1707792492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irXzmlt0LEedc8/XYXV/+59KeIGKtdiSyDhOcdwVB/g=;
        b=YIpj13WDR7a7O9o+OyCisNoBTy4+IBBl8wKqCBDgqBY9Fg/D8Y9e3opqgLXP7B4MV2
         16T0YyrZa15Q5SHmWIoSn2/RRsr7RzNHgfA0LUvXIAT+MpMqGUjy9QCl9/ApFOQ+b/C0
         DLomfAxGEqDfkshkTq8iD6DTkXg1IZzjtmPCrozTsXOEnhlh/8PnXO4tsdAWQCFCUrJY
         SalK+HTG4Pou1kvUgbCnG4cQcRqMqT2izwilMeLwEZbjE9O9OdEvkoPSRyT7y/M7umAn
         HiazTVpfrGPAHdc19EBmEdAb+2dbvaaDS4Dm5GiCVuppzazQRd0dAEUGlH6GPWPGF1EP
         xB1Q==
X-Gm-Message-State: AOJu0Yz9C4HCaSEJgSGcsOjysK91wivQ/70QRlUhKlAZqfDACaNseaEU
	slBa5sZaeVXAcBIx1Ivqi4aF6dABTL83wlo6lZKtj3KvMIvZ0jUvmQECJM5f/ab7QPnfKdyqcMe
	VSgmHLQtVCvRh0ZrPyXJ9LgkDwAA=
X-Google-Smtp-Source: AGHT+IEXm0D6L4O87FofR50Q1VNbAUpnlgHe1rmhYrL7Gdie7JbbIXN0qwDPsIGPi4masqcLU8Li6kWn293cpWCqK5o=
X-Received: by 2002:adf:cc8d:0:b0:336:76de:c171 with SMTP id
 p13-20020adfcc8d000000b0033676dec171mr210923wrj.62.1707187691847; Mon, 05 Feb
 2024 18:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rMpt88Gz+149wR9crzApmfUEfpS05sbOgAvOhzh2+Brbg@mail.gmail.com>
 <20240205053819.3cf848f0@rorschach.local.home>
In-Reply-To: <20240205053819.3cf848f0@rorschach.local.home>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Tue, 6 Feb 2024 10:47:55 +0800
Message-ID: <CAJNi4rN+hRg0UxhNus727t7f_D5XPMOyCdpJM2WoZH4yfw8kmQ@mail.gmail.com>
Subject: Re: Question about the ipi_raise filter usage and output
To: Steven Rostedt <rostedt@goodmis.org>
Cc: nico@fluxnic.net, Mark Rutland <mark.rutland@arm.com>, mhiramat@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Mon, Feb 5, 2024 at 6:38=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Mon, 5 Feb 2024 17:57:29 +0800
> richard clark <richard.xnu.clark@gmail.com> wrote:
>
> > I try to write below:
> > echo 'target_cpus =3D=3D 11 && reason =3D=3D "Function call interrupts"=
' >
> > events/ipi/ipi_raise/filter
>
> You mean when it is sent only to CPU 11? Not when the event is
> happening on CPU 11. Like the above example, the event was triggered on
> CPU 10, but the mask was for all the other CPUs.
>
> If you are looking for just CPU 11, you can do:
>
>   echo 'target_cpus =3D=3D 0x800 && reason =3D=3D "Function call interrup=
ts"'
>

Seems both 'target_cpus =3D=3D 0x800 && reason =3D=3D "Function call
interrupts"' and 'target_cpus & 0x800 && reason =3D=3D "Function call
interrupts"' don't work:

# cat events/ipi/ipi_raise/enable
1
# cat events/ipi/ipi_raise/filter
target_cpus =3D=3D 0x800 && reason =3D=3D "Function call interrupts"

The kernel module code snippet:

void ipi_func_run_cpu(void *info)
{
        pr_info("remote function runs on cpu[%d].\n", smp_processor_id());
}
static int __init ipi_send_init(void)
{
        int target =3D (smp_processor_id() + 1) % nr_cpu_ids;
        int ret =3D smp_call_function_single(target, ipi_func_run_cpu,
NULL, true);
        pr_info("ipi cpu[%d --> %d] ret =3D %d\n", smp_processor_id(),
target, ret);
        return 0;
}
..
module_init(ipi_send_init);
module_exit(ipi_send_exit);

$ sudo taskset -c 10 insmod ipi_send.ko
$ dmesg
..
[84931.864273] remote function runs on cpu[11].
[84931.864282] ipi cpu[10 --> 11] ret =3D 0

The 'cat trace' will output the below message with 'reason =3D=3D
"Function call interrupts"' filter:
..
            sudo-5726    [007] dn.h1.. 84302.833545: ipi_raise:
target_mask=3D00000000,00000001 (Function call interrupts)
            sudo-5726    [007] dn.h2.. 84302.837544: ipi_raise:
target_mask=3D00000000,00000001 (Function call interrupts)
          insmod-5727    [011] dn.h1.. 84302.841545: ipi_raise:
target_mask=3D00000000,00000001 (Function call interrupts)
          insmod-5727    [010] ....1.. 84302.843966: ipi_raise:
target_mask=3D00000000,00000bff (Function call interrupts)
          insmod-5727    [010] ....1.. 84302.843975: ipi_raise:
target_mask=3D00000000,00000bff (Function call interrupts)
          insmod-5727    [010] ....1.. 84302.844184: ipi_raise:
target_mask=3D00000000,00000800 (Function call interrupts)
..

I find that 'target_cpus =3D=3D 0xfff && reason =3D=3D "Function call
interrupts"' doesn't have output in the buffer, but 'target_cpus &
0xfff && reason =3D=3D "Function call interrupts"' does. I also tried to
use 'target_cpus & 0xf00 && reason =3D=3D "Function call interrupts"' in
my case, the trace buffer has nothing after the kmod inserted.

Any comments?

>
>
> -- Steve

