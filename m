Return-Path: <linux-kernel+bounces-20922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B485C828766
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A78286394
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF743984B;
	Tue,  9 Jan 2024 13:50:39 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE4381DF;
	Tue,  9 Jan 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2049e6d7f50so605653fac.0;
        Tue, 09 Jan 2024 05:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808237; x=1705413037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLA556URFDb8bibPiY31DweFoe69ZdKxhfNEj7QeBLY=;
        b=UWCAeJrAatd4SGWMWvLu8ZaAcYs7sO2AMdI3hsu11L9r2iVl+P6BPTsZtgx4UMeXDk
         XtfdP4nZFjFHVZksAGZwakpWHwzWDH+5hg/9CgLdL8dezxv9XBSA7HwpoY1XBCVXAcPj
         /VmjJ8tL1RZGX3rH0G+NRGmItq2AQCoz1UAuWnx4GKs/Rc4GFC2iMHVSAS3F+eCJTbsD
         HQnx+XYdatowCKMn7Tv6iGeY8MsJ06KQlmA3/8AogcCSUQAe7Ca29S9OG5jj5vNPhOKX
         s3NNEUG66gmfKFKxthOWvldrIG2G6TJtZrvAlETJHOTgH0jOi7Mif2q+1VA/lco1qv6K
         1l1A==
X-Gm-Message-State: AOJu0YzMhCIe+RJ64nfVdG5E4s97DgSrEM5EQjV52hzHPM+n8uyDcQMl
	4v/WAbMJ5N2EtvQtzma0WeMwcuWFZLQEIoyB6hk=
X-Google-Smtp-Source: AGHT+IH5ZW9X+DC7JsCboJONIxcpEvQdQl9F/rKQakZmNZGm9OrLswyYsBlllyjDKwZVOGxP8Wt8Y0ngDHijzm3Qnis=
X-Received: by 2002:a05:6871:a68f:b0:204:5a14:c4d6 with SMTP id
 wh15-20020a056871a68f00b002045a14c4d6mr9331340oab.2.1704808236774; Tue, 09
 Jan 2024 05:50:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a3658efad8f6247ed8c477717dc2820b72319d0.1704462287.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4a3658efad8f6247ed8c477717dc2820b72319d0.1704462287.git.christophe.jaillet@wanadoo.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 14:50:24 +0100
Message-ID: <CAJZ5v0jcDzAX=ik_-u+j9DZkhneWkD_Sey_+GcvBhX3D0Tmskg@mail.gmail.com>
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

Applied as 6.8-rc1 material under a different subject and with some
changelog edits.

Thanks!

