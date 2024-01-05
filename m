Return-Path: <linux-kernel+bounces-17894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 616AB8254A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA407B231AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3BC2D7AF;
	Fri,  5 Jan 2024 13:50:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49B24A0F;
	Fri,  5 Jan 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5962dd690d3so92366eaf.0;
        Fri, 05 Jan 2024 05:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704462641; x=1705067441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lI0aY5vn80S9gXjhRUwYbNSINF0K3AxL2pL6R4NKMyY=;
        b=FCvNz/EDNJ8lcAjNqB/Om4BwTVn1b/gQh50FPJDBrWk8J3kk8dfPmj6TwNPJQ5YBex
         5UB+zWE3Dk3t6JYKl91cRJcTZW0MWuKQeg1x2pXy58CCEsjnOKJee4rCP3tavo/uE4Sl
         PIrETspgXKaATZmOM+2XpVs/TtyQhUEpGd3unfC3dxjWKssTYbRr1NMot6oNkoJOe+fc
         zsBZNzsYbpg8QCX4TAmMSxjGSynI64LWOZknmCn9aScrQ+9OZ9mIeUSNTX/MGRugW+ie
         dq3wWsHb+12JKpfEO3SqvyoEF4ZXPBniOBomjHIG7T+Z+MkMXoMteKNzRczyoR5HZSt5
         5gFw==
X-Gm-Message-State: AOJu0YznI3oAXiPazC4HO/aJ8v+AUK+N5zcQ3QpqswHWff3PsindqMxZ
	Br8JLOK81c4bVMUjYiELbkRrSGZ65w3vIgIj/Pw=
X-Google-Smtp-Source: AGHT+IEb6LZYKN7vjVEyMim7bSuCvU//AiL3v/9vbEDI3JALDuFRHrrkP6jTne9WvsPWH3hrj4mFruMLxASlQ/jjh6c=
X-Received: by 2002:a4a:d813:0:b0:598:1e1a:c551 with SMTP id
 f19-20020a4ad813000000b005981e1ac551mr112709oov.1.1704462641256; Fri, 05 Jan
 2024 05:50:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a3658efad8f6247ed8c477717dc2820b72319d0.1704462287.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4a3658efad8f6247ed8c477717dc2820b72319d0.1704462287.git.christophe.jaillet@wanadoo.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Jan 2024 14:50:30 +0100
Message-ID: <CAJZ5v0hqaJ79BUj_hWDmErCVvJdBJ8o9fcHxcZDyP4+C4iDVxQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Save a few bytes of memory when
 registering a cooling device
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, alexis.lothore@bootlin.com, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 2:45=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Some *thermal_cooling_device_register() calls pass a string literal as th=
e
> 'type' parameter.
>
> So kstrdup_const() can be used instead of kfree() to avoid a memory

I guess you mean kstrdup()?

> allocation in such cases.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/thermal/thermal_core.c | 6 +++---
>  include/linux/thermal.h        | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index fa88d8707241..d21225ddbf10 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -846,7 +846,7 @@ static void thermal_release(struct device *dev)
>                             sizeof("cooling_device") - 1)) {
>                 cdev =3D to_cooling_device(dev);
>                 thermal_cooling_device_destroy_sysfs(cdev);
> -               kfree(cdev->type);
> +               kfree_const(cdev->type);
>                 ida_free(&thermal_cdev_ida, cdev->id);
>                 kfree(cdev);
>         }
> @@ -918,7 +918,7 @@ __thermal_cooling_device_register(struct device_node =
*np,
>         cdev->id =3D ret;
>         id =3D ret;
>
> -       cdev->type =3D kstrdup(type ? type : "", GFP_KERNEL);
> +       cdev->type =3D kstrdup_const(type ? type : "", GFP_KERNEL);
>         if (!cdev->type) {
>                 ret =3D -ENOMEM;
>                 goto out_ida_remove;
> @@ -969,7 +969,7 @@ __thermal_cooling_device_register(struct device_node =
*np,
>  out_cooling_dev:
>         thermal_cooling_device_destroy_sysfs(cdev);
>  out_cdev_type:
> -       kfree(cdev->type);
> +       kfree_const(cdev->type);
>  out_ida_remove:
>         ida_free(&thermal_cdev_ida, id);
>  out_kfree_cdev:
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index bf84595a4e86..052c72c0fa17 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -102,7 +102,7 @@ struct thermal_cooling_device_ops {
>
>  struct thermal_cooling_device {
>         int id;
> -       char *type;
> +       const char *type;
>         unsigned long max_state;
>         struct device device;
>         struct device_node *np;
> --
> 2.34.1
>

