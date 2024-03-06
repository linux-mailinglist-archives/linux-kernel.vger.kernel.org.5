Return-Path: <linux-kernel+bounces-93914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD58736D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FA61F240E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F284C126F02;
	Wed,  6 Mar 2024 12:43:51 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF491DA4C;
	Wed,  6 Mar 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729031; cv=none; b=J4SlD1FrpYJQqcrIFfkMC8XJh0APcqTc75z5swoBufM6Ha0VhCld1L//ErKMvpfocrrF4/PViMkgEgFes9TH4eTq0gAOuZqNEfUP2f3xdGnS8EX3lZRAcK3tGHVR/RwOI9L1qkTLrrul2YmP9/TZawYb/S41l0zTjnFWsWnXhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729031; c=relaxed/simple;
	bh=o5CYraV7yOFyyWAXdnfgODZ0zbgO7oV1ojCeLS2bet0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxlYGXZNeevv9yGp2nDd1mT9ubmy7HYL7LgH4dJjhrTsgwx0BCpN0kTEKK1xQuxYB8t2ETqhEdleylBJ1xBDWrSYZbIJ5uCAFrpLwovnLc0cuoGqcOD5FHW5svSmSeQHwjX7uX2lKfAeTib/BIY+m0l/aCsCVQN55qiFeAXz8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c21e709953so82651b6e.0;
        Wed, 06 Mar 2024 04:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729029; x=1710333829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Apz5AiwuERNKhLmawgUaC5BdiOhLZhpn7eFMH23CW+k=;
        b=jKBGlwiRekBOx5VjcocyoqMgPdyngzL8SbCLP9YS/U9xvtSHq0GSB3Qmeo3DYn79LV
         KZvmpF21qncHpNoho+oXiPaByswOxJlgm0pxCAZkTSt052XdXhODH13hJSJfv3l6iXzg
         2NpBN+VpvNvxgYHTOtlivBdQS5IlS5MlGP8qYH4ElpqLcbr+5WErK3qWUWTaLhXv7PJL
         ZECq67t+T/zfXNW7zyWy7ik9gY3Sgqt+XY7CY6VjZBLGj3EAYY6Ptp2Eiubh8G7CZcFG
         4im0d+sN/VT3SR0+6PfQudPWoDvvy/NGJKa5P8Es/32TgXE7WxQCZmSA7RSDooj+wh2z
         xzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTyHKjehM2ItbTeXcns1U+BXUn5xiERgarMWbPQINCZjffm60qxXYBFtx1alriCr8ISb4wGjtVhv0nUE+n43L4yMEwuwPDiLu1LW7BnIiz+oKRKd+/SAwpWT8l6dRKo1+NaJPaTqsLP0TWYijQfDOb15YNrH0LY9gbVihd45lCKA==
X-Gm-Message-State: AOJu0Yy4UMdS6o1jemYPX+kQJj4c2LLOThYyj2BOxG7bkfiyCvVXpIu2
	i9xMhX/EssHqoan8v7p5qLvEinfBZLrRrvUA0kdfGkzJduCHA19YJAqWI2WgyfKoZFmjY7SW7Jv
	IMrtBymmH2qbEoC2zR3OHkVcXSy2NrUd4lks=
X-Google-Smtp-Source: AGHT+IEtD0JYyYF3z4HrzlsLdW9+siTbM2rhQnz1nnhtLIB2Ejo/fU5WK+YxEVcVKSmTDGZ2UUoG2e3ArDorHsHd3RQ=
X-Received: by 2002:a05:6871:3418:b0:221:3a21:5b37 with SMTP id
 nh24-20020a056871341800b002213a215b37mr3725623oac.4.1709729028877; Wed, 06
 Mar 2024 04:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085007.169771-1-herve.codina@bootlin.com>
 <20240306085007.169771-2-herve.codina@bootlin.com> <1fff8742a13c28dd7e1dda47ad2d6fa8e21e421e.camel@gmail.com>
In-Reply-To: <1fff8742a13c28dd7e1dda47ad2d6fa8e21e421e.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Mar 2024 13:43:37 +0100
Message-ID: <CAJZ5v0gWCo9nDAHkzeD08tTKoE0DE0ocht-Qq4zA7P59y9KeuQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] driver core: Introduce device_link_wait_removal()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 10:17=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Wed, 2024-03-06 at 09:50 +0100, Herve Codina wrote:
> > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > introduces a workqueue to release the consumer and supplier devices use=
d
> > in the devlink.
> > In the job queued, devices are release and in turn, when all the
> > references to these devices are dropped, the release function of the
> > device itself is called.
> >
> > Nothing is present to provide some synchronisation with this workqueue
> > in order to ensure that all ongoing releasing operations are done and
> > so, some other operations can be started safely.
> >
> > For instance, in the following sequence:
> >   1) of_platform_depopulate()
> >   2) of_overlay_remove()
> >
> > During the step 1, devices are released and related devlinks are remove=
d
> > (jobs pushed in the workqueue).
> > During the step 2, OF nodes are destroyed but, without any
> > synchronisation with devlink removal jobs, of_overlay_remove() can rais=
e
> > warnings related to missing of_node_put():
> >   ERROR: memory leak, expected refcount 1 instead of 2
> >
> > Indeed, the missing of_node_put() call is going to be done, too late,
> > from the workqueue job execution.
> >
> > Introduce device_link_wait_removal() to offer a way to synchronize
> > operations waiting for the end of devlink removals (i.e. end of
> > workqueue jobs).
> > Also, as a flushing operation is done on the workqueue, the workqueue
> > used is moved from a system-wide workqueue to a local one.
> >
> > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
>
> With the below addressed:
>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>
> >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> >  include/linux/device.h |  1 +
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index d5f4e4aac09b..48b28c59c592 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
> >  static void __fw_devlink_link_to_consumers(struct device *dev);
> >  static bool fw_devlink_drv_reg_done;
> >  static bool fw_devlink_best_effort;
> > +static struct workqueue_struct *device_link_wq;
> >
> >  /**
> >   * __fwnode_link_add - Create a link between two fwnode_handles.
> > @@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *de=
v)
> >       /*
> >        * It may take a while to complete this work because of the SRCU
> >        * synchronization in device_link_release_fn() and if the consume=
r or
> > -      * supplier devices get deleted when it runs, so put it into the
> > "long"
> > -      * workqueue.
> > +      * supplier devices get deleted when it runs, so put it into the
> > +      * dedicated workqueue.
> >        */
> > -     queue_work(system_long_wq, &link->rm_work);
> > +     queue_work(device_link_wq, &link->rm_work);
> >  }
> >
> > +/**
> > + * device_link_wait_removal - Wait for ongoing devlink removal jobs to
> > terminate
> > + */
> > +void device_link_wait_removal(void)
> > +{
> > +     /*
> > +      * devlink removal jobs are queued in the dedicated work queue.
> > +      * To be sure that all removal jobs are terminated, ensure that a=
ny
> > +      * scheduled work has run to completion.
> > +      */
> > +     flush_workqueue(device_link_wq);
> > +}
> > +EXPORT_SYMBOL_GPL(device_link_wait_removal);
> > +
> >  static struct class devlink_class =3D {
> >       .name =3D "devlink",
> >       .dev_groups =3D devlink_groups,
> > @@ -4099,9 +4114,14 @@ int __init devices_init(void)
> >       sysfs_dev_char_kobj =3D kobject_create_and_add("char", dev_kobj);
> >       if (!sysfs_dev_char_kobj)
> >               goto char_kobj_err;
> > +     device_link_wq =3D alloc_workqueue("device_link_wq", 0, 0);
> > +     if (!device_link_wq)
> > +             goto wq_err;
> >
>
> I can't still agree with this. Why not doing it in devlink_class_init()? =
This is
> devlink specific so it makes complete sense to me.

If you do that in devlink_class_init() and it fails, you essentially
cause the creation of every device link to fail.  IOW, you try to live
without device links and pretend that it is all OK.  That won't get
you very far, especially on systems where DT is used.

Doing it here, if it fails, you prevent the driver model from working
at all (because one of its necessary components is unavailable), which
arguably is a better choice.

