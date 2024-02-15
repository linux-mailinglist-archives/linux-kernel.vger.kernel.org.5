Return-Path: <linux-kernel+bounces-67583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28604856DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FAA1F271C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1728C13959E;
	Thu, 15 Feb 2024 19:30:46 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E913699A;
	Thu, 15 Feb 2024 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025445; cv=none; b=nOVp9t9pnq/vMxh3y6sb9HUQZZ+BQt1flDhNzoi9ghfql0GZgi5ziX/xemGPRN317W0GSWztANE6myaUlbQKAFTaqrV9Qka2zOO74aWkuhmgGSpMEe6cA7fCbS9LBBp+PCkqLZcrBLdue9YbuxxQPj/ecVyuMmAL2VR3+3YGFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025445; c=relaxed/simple;
	bh=oCv4f4ACVuvSOw45WLUA2xxK4k32v0l+qhRxfxHiIp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0/r7P5WsOSkOnOZ+Ifhe9xuj1iyItpFo3JXRmd6AZXm9o4ANDY3kcJMgOp8QTaJpEpx61dEQqDuJzWpFT+cogyUHsq4GQXWtO95tAnwfv2qznvg4nmFnpuEwjYbZUgMaCu+y7o0IzXUQvjoRnb4e49acEFX0lfyDEpGuVDivCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e2b466d213so195771a34.0;
        Thu, 15 Feb 2024 11:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025443; x=1708630243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAGm+/vBtwzeK+oDxlR+J5tNXXqT73qA5onO/IgiQLo=;
        b=j37edpGaQMoFS/PVy7P0HZsMj1C8mNfiAEaEsEWl3ndA5UEcrIZV5iRLOPfZXAvu0S
         nwqqsH5CW0MDy2DVCeObjLY71ufMTjRF32hxw243CAPHpF383tD/c+Zdh8fy4hzFgx/e
         5ABN5f9TYwwUc99Uap9MYtFweV6Go4ROUIRUFGvTfHYCW7x5ZLxeqeth9rTrlsOj3E0j
         nJMZfdU1oZBNt7En4fhIe9oSz2LeB1TXLTUkBFMavS2LK/nIxaeXJMkNSGfo5Wd8V2We
         xsfNEIR2iLxoHUUKIXpyYrPfL4RyLAr62DlWVI7oUJg6K3WocPFyuOd/Y1D8T8HMPrVQ
         4XjA==
X-Forwarded-Encrypted: i=1; AJvYcCVBNB3eDd+gnCpls3K7t9fA8MbX9/GzJloA4kc+KtnSHUW/pGZBSSTjwdMVY//R4aEjhRuaElYPo70cNiEly4OfPwuJiN/ibeSrktTZTHNXDtYGpjSd1wQxqlzOSTq3/29daGSqKN+Ytw==
X-Gm-Message-State: AOJu0YzjHphfVu6kEASKs9f+KuuzmMi2qGY4o8MOKIViPpxIhkXk756P
	DUf5TJHx9pOnuVJgpzGqpn1J59sD99Y5nQ6vHr+ycCuhmV2BNLYdwaMjywylr41dAAHY8j3Mz2y
	AgwUJCAS7lJdDyywN/PC9Zw2LbRw=
X-Google-Smtp-Source: AGHT+IFUnS7ARXKLLgJpaySewqZ0U2GEw+Oxi13AQvXeRwm/mPoSx4tZ6/cxwvJnis/483fpzCG15PZokiWEdxsJraQ=
X-Received: by 2002:a4a:3803:0:b0:59a:bfb:f556 with SMTP id
 c3-20020a4a3803000000b0059a0bfbf556mr213211ooa.0.1708025443280; Thu, 15 Feb
 2024 11:30:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213004158.3623-1-W_Armin@gmx.de>
In-Reply-To: <20240213004158.3623-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Feb 2024 20:30:32 +0100
Message-ID: <CAJZ5v0jJZ5U0F66wKD9-aEuHyUnVFm6rxqi87QU1PXFvTsJ_ag@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor_idle: Fix memory leak in acpi_processor_power_exit()
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:42=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> After unregistering the CPU idle device, the memory associated with
> it is not freed, leading to a memory leak:
>
> unreferenced object 0xffff896282f6c000 (size 1024):
>   comm "swapper/0", pid 1, jiffies 4294893170
>   hex dump (first 32 bytes):
>     00 00 00 00 0b 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 8836a742):
>     [<ffffffff993495ed>] kmalloc_trace+0x29d/0x340
>     [<ffffffff9972f3b3>] acpi_processor_power_init+0xf3/0x1c0
>     [<ffffffff9972d263>] __acpi_processor_start+0xd3/0xf0
>     [<ffffffff9972d2bc>] acpi_processor_start+0x2c/0x50
>     [<ffffffff99805872>] really_probe+0xe2/0x480
>     [<ffffffff99805c98>] __driver_probe_device+0x78/0x160
>     [<ffffffff99805daf>] driver_probe_device+0x1f/0x90
>     [<ffffffff9980601e>] __driver_attach+0xce/0x1c0
>     [<ffffffff99803170>] bus_for_each_dev+0x70/0xc0
>     [<ffffffff99804822>] bus_add_driver+0x112/0x210
>     [<ffffffff99807245>] driver_register+0x55/0x100
>     [<ffffffff9aee4acb>] acpi_processor_driver_init+0x3b/0xc0
>     [<ffffffff990012d1>] do_one_initcall+0x41/0x300
>     [<ffffffff9ae7c4b0>] kernel_init_freeable+0x320/0x470
>     [<ffffffff99b231f6>] kernel_init+0x16/0x1b0
>     [<ffffffff99042e6d>] ret_from_fork+0x2d/0x50
>
> Fix this by freeing the CPU idle device after unregistering it.
>
> Fixes: 3d339dcbb56d ("cpuidle / ACPI : move cpuidle_device field out of t=
he acpi_processor_power structure")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/processor_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 55437f5e0c3a..bd6a7857ce05 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1430,6 +1430,8 @@ int acpi_processor_power_exit(struct acpi_processor=
 *pr)
>                 acpi_processor_registered--;
>                 if (acpi_processor_registered =3D=3D 0)
>                         cpuidle_unregister_driver(&acpi_idle_driver);
> +
> +               kfree(dev);
>         }
>
>         pr->flags.power_setup_done =3D 0;
> --

Applied as 6.9 material, thanks!

