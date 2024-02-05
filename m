Return-Path: <linux-kernel+bounces-52728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7812849BF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB301C23D8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5AB210F4;
	Mon,  5 Feb 2024 13:36:28 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647A20DCB;
	Mon,  5 Feb 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140188; cv=none; b=nhn6VfD+lkVRTHWus+JbLPfnQow14LLnf0M1tGUxMvsp9yLVT20EGcxDRZowp49eTl+XrSFa5vvcC4OS2csfnxoh0/683XpNLvG7BtNQheeAKKLgPJOcgm5hlNmjwf2IDRRZaYAYdu8IS1R1Fa2D7ZDwlw7Br9jd75PLUpLRTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140188; c=relaxed/simple;
	bh=aWoMaNlzaJDv/ljO+qtLZkeuWq/BPLJs1ZsHopQyI4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzmlC259C7mIK8veBd6p1DhHPbPF8l/S0FcchNycz96jiul7EbPpGH2DD4WHLObVu0D48uJt3qoTVXv/XtBpmvwQvVdHlZ+WD5UZ/mFgIvUH015vYwNWPzmJbxkexVlioIWR+A4XXWCFDeMSx/GN/4osJY+mgXOxBRWNZKaXGm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bfc3c3edf9so325213b6e.0;
        Mon, 05 Feb 2024 05:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140185; x=1707744985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zOd2d06/qani2Bq9JBIEEAI5oCa8GVG90uGxagtjkI=;
        b=CBrQJ/JDU/xj8FJ0zIMsKNBEK9Gwar2r19G77/qVnLES11j3W9x7Ll6RcYJpJpzjKT
         uKxbCqO9GEmxOLWx+vlmXHxSAOwdDTEYcOJzN2+jcn4yED/aXzvCtPeeB+zDNjEAY4tt
         tiRCuakcK6xE4Ss2PQaDwJyrbKHVR7iGBLqYsnKM5tmFnlzbQWP5BIwWRIo5AOO29nQ4
         kk/CduYnTkoj1vNNewLmehx2qBS3KE5O3vV6t8qEhS782FNVwt0Y+burogVf0KmYknpu
         /cIZiSL0uZ47h1bxI5ckDCVyEIXIdaBbhi5/JzHwmQEq8gv2OBIGaaIgxOFZ79gfZO6P
         MyhA==
X-Forwarded-Encrypted: i=0; AJvYcCVlO6R1ldJLZIXKVssbbYMKHnBhZCxJIygya8X4oNgBkJ9CxqxQGBvL7bj9EZeiI8j2WhSSDsl5MhqmPBRqqTbMR5+Cb5WyChCWyHc/hP8yYP3nJ8XmtkO98tIwbpjmzUwzV6OUqnCG/1nYurVUXhs5SIu9Pecu1wTsOryPZy6H1/VdITc=
X-Gm-Message-State: AOJu0Yzc7jGMrkiKqv7Y5Q+Wc3GS3gGQ8YMbYjpoDhnwxFjYAnMwTcih
	ubalv/0IOACCLGK/hbTyY8YTzBqhnvKb8kt6T9wnmgSpqRY6zzW25Qr2ytvP+TCG7LmFV9tXGld
	i2cpY0rcZpeFOhfyFrWwd5jQPEYpfhXnt
X-Google-Smtp-Source: AGHT+IHDlPkVUSvuyNyulXB5xUezGAuo6Js1Pwmhybl8CNhD5JNvI1gQHAvj+kybs1zNaESiQVLS6N9dP9OFSomQlSo=
X-Received: by 2002:a05:6870:51c7:b0:219:15e9:f1d4 with SMTP id
 b7-20020a05687051c700b0021915e9f1d4mr9616562oaj.2.1707140185402; Mon, 05 Feb
 2024 05:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-fix-device-links-overlays-v1-0-f9fd1404c8e2@analog.com>
 <20240202-fix-device-links-overlays-v1-1-f9fd1404c8e2@analog.com>
 <CAJZ5v0g5JbstLhCaXcY1kawP8etB5Z4TBuGXHz8_wsrXm3CaQA@mail.gmail.com> <c4a6f0aba84c328dc31d7ec40fe3d4c2b35c6c14.camel@gmail.com>
In-Reply-To: <c4a6f0aba84c328dc31d7ec40fe3d4c2b35c6c14.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Feb 2024 14:36:14 +0100
Message-ID: <CAJZ5v0jURM178QrfPLARasSF-KOKaAc_kd_eXc0w2=tVwwEPiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver: core: add dedicated workqueue for devlink removal
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, nuno.sa@analog.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 9:29=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Fri, 2024-02-02 at 16:59 +0100, Rafael J. Wysocki wrote:
> > On Fri, Feb 2, 2024 at 1:18=E2=80=AFPM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > >
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >
> > > Let's use a dedicated queue for devlinks since releasing a link happe=
ns
> > > asynchronously but some code paths, like DT overlays, have some
> > > expectations regarding the of_node when being removed (the refcount m=
ust
> > > be 1). Given how devlinks are released that cannot be assured. Hence,=
 add a
> > > dedicated queue so that it's easy to sync against devlinks removal.
> >
> > Thanks for following my suggestion!
> >
> > > While at it, make sure to explicitly include <linux/workqueue.h>.
> > >
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > >  drivers/base/core.c    | 33 +++++++++++++++++++++++++++++----
> > >  include/linux/fwnode.h |  1 +
> > >  2 files changed, 30 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 14d46af40f9a..06e7766b5227 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -31,6 +31,7 @@
> > >  #include <linux/swiotlb.h>
> > >  #include <linux/sysfs.h>
> > >  #include <linux/dma-map-ops.h> /* for dma_default_coherent */
> > > +#include <linux/workqueue.h>
> > >
> > >  #include "base.h"
> > >  #include "physical_location.h"
> > > @@ -44,6 +45,7 @@ static bool fw_devlink_is_permissive(void);
> > >  static void __fw_devlink_link_to_consumers(struct device *dev);
> > >  static bool fw_devlink_drv_reg_done;
> > >  static bool fw_devlink_best_effort;
> > > +static struct workqueue_struct *devlink_release_queue __ro_after_ini=
t;
> > >
> > >  /**
> > >   * __fwnode_link_add - Create a link between two fwnode_handles.
> > > @@ -235,6 +237,11 @@ static void __fw_devlink_pickup_dangling_consume=
rs(struct
> > > fwnode_handle *fwnode,
> > >                 __fw_devlink_pickup_dangling_consumers(child, new_sup=
);
> > >  }
> > >
> > > +void fwnode_links_flush_queue(void)
> > > +{
> > > +       flush_workqueue(devlink_release_queue);
> > > +}
> > > +
> > >  static DEFINE_MUTEX(device_links_lock);
> > >  DEFINE_STATIC_SRCU(device_links_srcu);
> > >
> > > @@ -531,9 +538,10 @@ static void devlink_dev_release(struct device *d=
ev)
> > >          * It may take a while to complete this work because of the S=
RCU
> > >          * synchronization in device_link_release_fn() and if the con=
sumer or
> > >          * supplier devices get deleted when it runs, so put it into =
the "long"
> > > -        * workqueue.
> > > +        * devlink workqueue.
> > > +        *
> > >          */
> > > -       queue_work(system_long_wq, &link->rm_work);
> > > +       queue_work(devlink_release_queue, &link->rm_work);
> > >  }
> > >
> > >  static struct class devlink_class =3D {
> > > @@ -636,10 +644,27 @@ static int __init devlink_class_init(void)
> > >                 return ret;
> > >
> > >         ret =3D class_interface_register(&devlink_class_intf);
> > > -       if (ret)
> > > +       if (ret) {
> > > +               class_unregister(&devlink_class);
> > > +               return ret;
> > > +       }
> > > +
> > > +       /*
> > > +        * Using a dedicated queue for devlinks since releasing a lin=
k happens
> > > +        * asynchronously but some code paths, like DT overlays, have=
 some
> > > +        * expectations regarding the of_node when being removed (the=
 refcount
> > > +        * must be 1). Given how devlinks are released that cannot be=
 assured.
> > > +        * Hence, add a dedicated queue so that it's easy to sync aga=
inst
> > > +        * devlinks removal.
> > > +        */
> > > +       devlink_release_queue =3D alloc_workqueue("devlink_release", =
0, 0);
> > > +       if (!devlink_release_queue) {
> > > +               class_interface_unregister(&devlink_class_intf);
> > >                 class_unregister(&devlink_class);
> >
> > This is a bit drastic.
> >
> > I think that device links can still work if devlink_release_queue is
> > NULL, just devlink_dev_release() needs to check it and release
> > synchronously if it is NULL.
> >
>
> Agreed, I'll do that way. It will always synchronously remove the links (=
which is
> different than before) but I guess that failing in allocating the queue i=
s rather
> unlikely.

Right.

