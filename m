Return-Path: <linux-kernel+bounces-133445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107B089A3CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F213285E48
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0959E171E5C;
	Fri,  5 Apr 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDue60zv"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BF1DFEB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339974; cv=none; b=LQWJCm33MMT8wZkr0gIEoE1uJgFZvYm0JRS+RORADYILPFfyHm48XSHGNkEipTPKvNXCkbfrgsMMKtJIrb2NyhhfbVP6BCow3eLHMyHrrNQnenDvpV4TV+WgOUYgKRtQK06hSvINkm65FDwHQi8J2TRALaZjmbKEJtWsHmPg4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339974; c=relaxed/simple;
	bh=6FY+uqad71xmy84qBV6KoRXQxD4P2v/1hfdxprBJWrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ir2zWLRFfLNiIefiS6dXizDA8w8gpowVZ8+xWwDIwOowvEPAIV03n0EqXiSFAD9QGNvaRMHDzQGRbgCqXdvbD8KhWjsOmzeMmj7sLD0zrujDSc485jvh0z+wFlEOxc7mYOAaJZpPZoCjTbxmfhF8YOf9ifd74QYd51IEUAl737M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDue60zv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51aac16b6eso40326266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712339970; x=1712944770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxQtwbSHbxkYXoMg2wRUHnRYLyYbVqO8UKCdJttIqfc=;
        b=NDue60zvOjxRarGa8m32PETfbf23W4V0Uuu43xJEYjhIRhvcRwULPQhIC6JaW2fLMt
         jWhwIgV4If9kbxgkXd2uf7GlBk81ein+5cLWHExhxHeEL1gaPIZeBlPF4i8Gos1HP9AX
         2w5c3aM3NGDQSX5K+PPU19vpV9l0j8h+ypgZYMLGKK7stGEicAUTfnP5ECdJyWSH24go
         W7Xve0QxxvM9szafci11mMqzRUW9HeqwcTLkici3x43Mbz67nTLoyiSPcw2p3nppOJsT
         huMS6Ls5jYNRzHYpll7ZnrxwbsgB3CsZ08Lf8jwCP38vVTct0dABC7JW5pf9sQZSQ96B
         eL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712339970; x=1712944770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxQtwbSHbxkYXoMg2wRUHnRYLyYbVqO8UKCdJttIqfc=;
        b=COki/p3+/ERljWGC5lnJ26MbltRbW5B7RPEPBfPOv96hNa9Vis+um3itc+syBKuSPy
         MQzHMFsd0K4j0vT5llqEb1+D60mQbsVjYJycjY7gZgyL45S1ck7Oid9BwfCXnezcROA2
         mHI5V8KQjDBJxB662gTh0TftwljGmCFB4C1srDpqmMzEycSWZ0487gLmozoHCf8MHcxV
         8+5aZzScyb4iDF73UP785eJRaLi27bdxD9rTRSHrxzJDRrkgdRFwnhLLIxF3K/egt2IH
         NEzqUH2i1CwKKiPhKlC2gErxr3xNnAqjFqLiTTN7DQ2O693hzAgfTNAjHg2yZCkhKCdK
         Ft0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOhtxNkszqAK7l3GmDLwnAz2ul54lQN3dkyQ1gVfukDUfhA0pSF2jUBJ3tyO15T5NYj2g1niCHFM/3B6Z845YLsc35u2kncJtiGrLh
X-Gm-Message-State: AOJu0YxtuOIZ5QcEmpNRTQ4JOgS7eD2jrfTh4oyT7mo3c0BnlUV6l8M/
	2jAhku6l8YVvOZTljt5+pcMjxaMTbr0ftAd1tTkKVaibIog+5bATNWtXwMS6Ye+JPfIBJI1YjRv
	d70au8+pfCSQku8a2cPNScgyHIkM=
X-Google-Smtp-Source: AGHT+IH4r9q9rrjrKyAJ7QfGnmsE9QleqStJZC2e963aF+0dladLufCglT2YNtAWewZ6AchQx+vhek+cVD39oOWcTvo=
X-Received: by 2002:a50:cd97:0:b0:565:f7c7:f23c with SMTP id
 p23-20020a50cd97000000b00565f7c7f23cmr2035660edi.3.1712339969335; Fri, 05 Apr
 2024 10:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403182951.724488-1-adrian.larumbe@collabora.com>
In-Reply-To: <20240403182951.724488-1-adrian.larumbe@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 5 Apr 2024 10:59:17 -0700
Message-ID: <CAF6AEGsWtJs2xcZx59P9_maxn1RqCO6-4GwEp2fL31bZtTyuoA@mail.gmail.com>
Subject: Re: [PATCH] drm/sysfs: Add drm class-wide attribute to get active
 device clients
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Hans de Goede <hdegoede@redhat.com>, kernel@collabora.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Christopher Healy <healych@amazon.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:37=E2=80=AFAM Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
>
> Up to this day, all fdinfo-based GPU profilers must traverse the entire
> /proc directory structure to find open DRM clients with fdinfo file
> descriptors. This is inefficient and time-consuming.
>
> This patch adds a new device class attribute that will install a sysfs fi=
le
> per DRM device, which can be queried by profilers to get a list of PIDs f=
or
> their open clients. This file isn't human-readable, and it's meant to be
> queried only by GPU profilers like gputop and nvtop.
>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Christopher Healy <healych@amazon.com>
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

It does seem like a good idea.. idk if there is some precedent to
prefer binary vs ascii in sysfs, but having a way to avoid walking
_all_ processes is a good idea.

BR,
-R

> ---
>  drivers/gpu/drm/drm_internal.h       |  2 +-
>  drivers/gpu/drm/drm_privacy_screen.c |  2 +-
>  drivers/gpu/drm/drm_sysfs.c          | 89 ++++++++++++++++++++++------
>  3 files changed, 74 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_interna=
l.h
> index 2215baef9a3e..9a399b03d11c 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -145,7 +145,7 @@ bool drm_master_internal_acquire(struct drm_device *d=
ev);
>  void drm_master_internal_release(struct drm_device *dev);
>
>  /* drm_sysfs.c */
> -extern struct class *drm_class;
> +extern struct class drm_class;
>
>  int drm_sysfs_init(void);
>  void drm_sysfs_destroy(void);
> diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_p=
rivacy_screen.c
> index 6cc39e30781f..2fbd24ba5818 100644
> --- a/drivers/gpu/drm/drm_privacy_screen.c
> +++ b/drivers/gpu/drm/drm_privacy_screen.c
> @@ -401,7 +401,7 @@ struct drm_privacy_screen *drm_privacy_screen_registe=
r(
>         mutex_init(&priv->lock);
>         BLOCKING_INIT_NOTIFIER_HEAD(&priv->notifier_head);
>
> -       priv->dev.class =3D drm_class;
> +       priv->dev.class =3D &drm_class;
>         priv->dev.type =3D &drm_privacy_screen_type;
>         priv->dev.parent =3D parent;
>         priv->dev.release =3D drm_privacy_screen_device_release;
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index a953f69a34b6..56ca9e22c720 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -58,8 +58,6 @@ static struct device_type drm_sysfs_device_connector =
=3D {
>         .name =3D "drm_connector",
>  };
>
> -struct class *drm_class;
> -
>  #ifdef CONFIG_ACPI
>  static bool drm_connector_acpi_bus_match(struct device *dev)
>  {
> @@ -128,6 +126,62 @@ static const struct component_ops typec_connector_op=
s =3D {
>
>  static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
>
> +static ssize_t clients_show(struct device *cd, struct device_attribute *=
attr, char *buf)
> +{
> +       struct drm_minor *minor =3D cd->driver_data;
> +       struct drm_device *ddev =3D minor->dev;
> +       struct drm_file *priv;
> +       ssize_t offset =3D 0;
> +       void *pid_buf;
> +
> +       if (minor->type !=3D DRM_MINOR_RENDER)
> +               return 0;
> +
> +       pid_buf =3D kvmalloc(PAGE_SIZE, GFP_KERNEL);
> +       if (!pid_buf)
> +               return 0;
> +
> +       mutex_lock(&ddev->filelist_mutex);
> +       list_for_each_entry_reverse(priv, &ddev->filelist, lhead) {
> +               struct pid *pid;
> +
> +               if (drm_WARN_ON(ddev, (PAGE_SIZE - offset) < sizeof(pid_t=
)))
> +                       break;
> +
> +               rcu_read_lock();
> +               pid =3D rcu_dereference(priv->pid);
> +               (*(pid_t *)(pid_buf + offset)) =3D pid_vnr(pid);
> +               rcu_read_unlock();
> +
> +               offset +=3D sizeof(pid_t);
> +       }
> +       mutex_unlock(&ddev->filelist_mutex);
> +
> +       if (offset < PAGE_SIZE)
> +               (*(pid_t *)(pid_buf + offset)) =3D 0;
> +
> +       memcpy(buf, pid_buf, offset);
> +
> +       kvfree(pid_buf);
> +
> +       return offset;
> +
> +}
> +static DEVICE_ATTR_RO(clients);
> +
> +static struct attribute *drm_device_attrs[] =3D {
> +       &dev_attr_clients.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(drm_device);
> +
> +struct class drm_class =3D {
> +       .name           =3D "drm",
> +       .dev_groups     =3D drm_device_groups,
> +};
> +
> +static bool drm_class_initialised;
> +
>  /**
>   * drm_sysfs_init - initialize sysfs helpers
>   *
> @@ -142,18 +196,19 @@ int drm_sysfs_init(void)
>  {
>         int err;
>
> -       drm_class =3D class_create("drm");
> -       if (IS_ERR(drm_class))
> -               return PTR_ERR(drm_class);
> +       err =3D class_register(&drm_class);
> +       if (err)
> +               return err;
>
> -       err =3D class_create_file(drm_class, &class_attr_version.attr);
> +       err =3D class_create_file(&drm_class, &class_attr_version.attr);
>         if (err) {
> -               class_destroy(drm_class);
> -               drm_class =3D NULL;
> +               class_destroy(&drm_class);
>                 return err;
>         }
>
> -       drm_class->devnode =3D drm_devnode;
> +       drm_class.devnode =3D drm_devnode;
> +
> +       drm_class_initialised =3D true;
>
>         drm_sysfs_acpi_register();
>         return 0;
> @@ -166,12 +221,12 @@ int drm_sysfs_init(void)
>   */
>  void drm_sysfs_destroy(void)
>  {
> -       if (IS_ERR_OR_NULL(drm_class))
> +       if (!drm_class_initialised)
>                 return;
>         drm_sysfs_acpi_unregister();
> -       class_remove_file(drm_class, &class_attr_version.attr);
> -       class_destroy(drm_class);
> -       drm_class =3D NULL;
> +       class_remove_file(&drm_class, &class_attr_version.attr);
> +       class_destroy(&drm_class);
> +       drm_class_initialised =3D false;
>  }
>
>  static void drm_sysfs_release(struct device *dev)
> @@ -372,7 +427,7 @@ int drm_sysfs_connector_add(struct drm_connector *con=
nector)
>                 return -ENOMEM;
>
>         device_initialize(kdev);
> -       kdev->class =3D drm_class;
> +       kdev->class =3D &drm_class;
>         kdev->type =3D &drm_sysfs_device_connector;
>         kdev->parent =3D dev->primary->kdev;
>         kdev->groups =3D connector_dev_groups;
> @@ -550,7 +605,7 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor=
 *minor)
>                         minor_str =3D "card%d";
>
>                 kdev->devt =3D MKDEV(DRM_MAJOR, minor->index);
> -               kdev->class =3D drm_class;
> +               kdev->class =3D &drm_class;
>                 kdev->type =3D &drm_sysfs_device_minor;
>         }
>
> @@ -579,10 +634,10 @@ struct device *drm_sysfs_minor_alloc(struct drm_min=
or *minor)
>   */
>  int drm_class_device_register(struct device *dev)
>  {
> -       if (!drm_class || IS_ERR(drm_class))
> +       if (!drm_class_initialised)
>                 return -ENOENT;
>
> -       dev->class =3D drm_class;
> +       dev->class =3D &drm_class;
>         return device_register(dev);
>  }
>  EXPORT_SYMBOL_GPL(drm_class_device_register);
>
> base-commit: 45c734fdd43db14444025910b4c59dd2b8be714a
> --
> 2.44.0
>

