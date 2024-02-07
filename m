Return-Path: <linux-kernel+bounces-56098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC684C5F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12196B2603F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE69200AC;
	Wed,  7 Feb 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NjUHusV0"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D5200A4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293211; cv=none; b=IDdYlHvzGYzvXC4Yec2RKaFCFxjzVjrzp3oc3Kt3qCNn5og+cFCOcFszuJROrejj36/6wYSDLDEsrYOk7wY+nmLpZS7/+aCly9GVzNIW+Kzc6oPTOhmNcG8RIRMLaBw3+0kzrKssa+kTzdf2vMLaWPclwDHJJdMlf3Mul+qF2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293211; c=relaxed/simple;
	bh=vnwmRJ6tBjLRHo3O5Gvn5N07+JIg65jCen2q5SE9ORg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qj2YmVN8EFId0uCLeSbrs+EEeSoN1fMfOjv78F6ZSw1Z69grmkSZKKSgXFUT8y8qD/wH4bFyctMQUv9yjKcPBcH7T6vYrVjD2gO/Su57X9XnlouRINaKymh/9/1bVztkM/2d5XKMAtFSP9NPC22F2ueLTwP3atnZibAMyz7Qj1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NjUHusV0; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e141ee9c14so123857a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 00:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707293207; x=1707898007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXnJs/wvpt7ukXIwUKCp3SR6FtTFb/O0JkjYwEeQrW8=;
        b=NjUHusV0CzzHdS8pBPOkTNKjQ0thajQ9VS+zwgiCg9OAw4RTcRxjIvc1H+QxqJiYWJ
         1rIathJYT+OxYW8HTX+uf/gNsvpPwc3tYaWJqU3R6p7yl7xmSEwrCbAj5fnVZaID/yz6
         5RGKlehaRYx7H5O1IbRBDegk4dQXB6mWVUri6+w0gRQ3peVt9tfWqp522j4xRQIRtn8Y
         riSS6S3os08Q4cYQjqPoil9O2QwH4yXlSbij3jsyHYvGW60BlVSCt1KIRRBrf/lWNTYY
         dqE4jg6YsDRu2WfUjtGpCE9xXlPZCIFyftmIy1JpY3nOi+8q4daI/6Nub+KETx+U2BEc
         WIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707293207; x=1707898007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXnJs/wvpt7ukXIwUKCp3SR6FtTFb/O0JkjYwEeQrW8=;
        b=OERXReU/VSz+7TQ7mefj5jrsrjwAiNjrHwRHiXVzUiXT6Xx+L5A0G/3hczgj6oZ1Nk
         PoHHEnH1gGDl5pelXtxn2YdSvzULRvRA979Hq0V6QONUrNXEchQXaoS9LFCnBG62ott5
         3qjf6+5EWGekM72n5GnrR8VGLpfDmrS0HU+h9xzuZS88V6/YyJQ86n4+ErxP9l4EHt5Q
         eF5/2T/K2D4vQRQMVp6tpxkgsQR70f+4O3+8L6bv6cJTtuzJCFL+5WC9GQb6PK4aEcie
         RYQBG2n0u/sKBA0bfiw6AQJCNPZ1P13tUzNEBBzSDERkQydefyEGx7Ow/cDq6P80iMpu
         V5zQ==
X-Gm-Message-State: AOJu0YxrHFozU8QTySln4Z0Wql+q845YWZJzjp1Ql4VA0hNO0tDCclon
	WouyMDthkGrd++va3XVxEUymWN/RXRypBeCYsE0i4FHd5HYCCbpy7SHxkCHqoNJmy9krcK1v5/P
	114BavV3lh8uGS8sgFqMg7BCbf0ySAsVDlkRDPw==
X-Google-Smtp-Source: AGHT+IE4wOWRAu3oI3SNNLr0tcJjjvUPYhxjYzL+i7Gsk18G1y4/RXneRI33bgPhiXWtIAdzxpNVCBNhJpyfjDKk6no=
X-Received: by 2002:a9d:6e8d:0:b0:6e0:faab:cff4 with SMTP id
 a13-20020a9d6e8d000000b006e0faabcff4mr5573144otr.13.1707293207230; Wed, 07
 Feb 2024 00:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
In-Reply-To: <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 7 Feb 2024 09:06:35 +0100
Message-ID: <CAHUa44Ht93U2Q78Xx91J_Xq=dBrhwjy2tERO4BntfNywewxVAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 1:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > A number of storage technologies support a specialised hardware
> > partition designed to be resistant to replay attacks. The underlying
> > HW protocols differ but the operations are common. The RPMB partition
> > cannot be accessed via standard block layer, but by a set of specific
> > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > partition provides authenticated and replay protected access, hence
> > suitable as a secure storage.
> >
> > The initial aim of this patch is to provide a simple RPMB Driver which
> > can be accessed by the optee driver to facilitate early RPMB access to
> > OP-TEE OS (secure OS) during the boot time.
>
> How early do we expect OP-TEE to need RPMB access?
>
> The way things work for mmc today, is that the eMMC card gets
> discovered/probed via a workqueue. The work is punted by the mmc host
> driver (typically a module-platform-driver), when it has probed
> successfully.
>
> The point is, it looks like we need some kind of probe deferral
> mechanism too. Whether we want the OP-TEE driver to manage this itself
> or whether we should let rpmb_dev_find_device() deal with it, I don't
> know.

As I wrote in another reply. I'd like to probe the OP-TEE driver
without touching RPMB first, and then as the devices start to appear
we discover the one to use. In this patchset I'm relying on the OP-TEE
client to wait until the RPMB device is available. That's probably
good enough for user space client, but I guess not for kernel clients
(drivers).

>
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > class_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > provides a callback to route RPMB frames to the RPMB device accessible
> > via rpmb_route_frames().
>
> By looking at the design of the interface, I do like it. It's simple
> and straightforward.
>
> However, I wonder if you considered avoiding using a class-device
> altogether? Even if it helps with lifecycle problems and the
> ops-lookup, we really don't need another struct device with a sysfs
> node, etc.

Yes, the class-device might be more of a leftover from earlier
versions with a user space interface too. Let's try to do this without
a class-device. I was considering using class_interface_register() for
the optee driver to get notified of an eventual RPMB device, but if we
don't have an RPMB class device we'll need some other mechanism for
that. Perhaps a rpmb_interface_register() with similar callbacks as
class_interface_register().

>
> To deal with the lifecycle issue, we could probably just add reference
> counting for the corresponding struct device that we already have at
> hand, which represents the eMMC/UFS/NVME card. That together with a
> simple list that contains the registered rpmb ops. But I may be
> overlooking something, so perhaps it's more complicated than that?

I could try to call mmc_blk_get() in mmc_blk_alloc_rpmb_part() when
storing the md pointer in the newly created struct mmc_rpmb_data. If
that works as I hope, then I can get rid of the two get_resources()
and put_resources() callbacks. We should probably update
mmc_rpmb_chrdev_open() and mmc_rpmb_chrdev_release() to match this.

>
> >
> > The detailed operation of implementing the access is left to the TEE
> > device driver itself.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  MAINTAINERS              |   7 ++
> >  drivers/misc/Kconfig     |   9 ++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/rpmb-core.c | 247 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/rpmb.h     | 184 +++++++++++++++++++++++++++++
> >  5 files changed, 448 insertions(+)
> >  create mode 100644 drivers/misc/rpmb-core.c
> >  create mode 100644 include/linux/rpmb.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8999497011a2..e83152c42499 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19012,6 +19012,13 @@ T:     git git://linuxtv.org/media_tree.git
> >  F:     Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de=
2-rotate.yaml
> >  F:     drivers/media/platform/sunxi/sun8i-rotate/
> >
> > +RPMB SUBSYSTEM
> > +M:     Jens Wiklander <jens.wiklander@linaro.org>
> > +L:     linux-kernel@vger.kernel.org
> > +S:     Supported
> > +F:     drivers/misc/rpmb-core.c
> > +F:     include/linux/rpmb.h
> > +
> >  RPMSG TTY DRIVER
> >  M:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >  L:     linux-remoteproc@vger.kernel.org
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 4fb291f0bf7c..891aa5763666 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -104,6 +104,15 @@ config PHANTOM
> >           If you choose to build module, its name will be phantom. If u=
nsure,
> >           say N here.
> >
> > +config RPMB
> > +       tristate "RPMB partition interface"
>
> Should we add a "depends on MMC"? (We can add the other NVME and UFS
> later on too).

That makes sense, I'll add that.

>
> > +       help
> > +         Unified RPMB unit interface for RPMB capable devices such as =
eMMC and
> > +         UFS. Provides interface for in kernel security controllers to=
 access
> > +         RPMB unit.
> > +
> > +         If unsure, select N.
> > +
> >  config TIFM_CORE
> >         tristate "TI Flash Media interface support"
> >         depends on PCI
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index ea6ea5bbbc9c..8af058ad1df4 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)           +=3D lkdtm/
> >  obj-$(CONFIG_TIFM_CORE)        +=3D tifm_core.o
> >  obj-$(CONFIG_TIFM_7XX1)        +=3D tifm_7xx1.o
> >  obj-$(CONFIG_PHANTOM)          +=3D phantom.o
> > +obj-$(CONFIG_RPMB)             +=3D rpmb-core.o
> >  obj-$(CONFIG_QCOM_COINCELL)    +=3D qcom-coincell.o
> >  obj-$(CONFIG_QCOM_FASTRPC)     +=3D fastrpc.o
> >  obj-$(CONFIG_SENSORS_BH1770)   +=3D bh1770glc.o
> > diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> > new file mode 100644
> > index 000000000000..a3c289051687
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,247 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
> > + * Copyright(c) 2021 - 2024 Linaro Ltd.
> > + */
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/rpmb.h>
> > +#include <linux/slab.h>
> > +
> > +static DEFINE_IDA(rpmb_ida);
> > +static DEFINE_MUTEX(rpmb_mutex);
> > +
> > +/**
> > + * rpmb_dev_get() - increase rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > +{
> > +       if (rdev)
> > +               get_device(&rdev->dev);
> > +       return rdev;
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_get);
> > +
> > +/**
> > + * rpmb_dev_put() - decrease rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +void rpmb_dev_put(struct rpmb_dev *rdev)
> > +{
> > +       if (rdev)
> > +               put_device(&rdev->dev);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_put);
> > +
> > +/**
> > + * rpmb_route_frames() - route rpmb frames to rpmb device
> > + * @rdev:      rpmb device
> > + * @req:       rpmb request frames
> > + * @req_len:   length of rpmb request frames in bytes
> > + * @rsp:       rpmb response frames
> > + * @rsp_len:   length of rpmb response frames in bytes
> > + *
> > + * @return < 0 on failure
> > + */
> > +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> > +                     unsigned int req_len, u8 *rsp, unsigned int rsp_l=
en)
> > +{
> > +       struct rpmb_frame *frm =3D (struct rpmb_frame *)req;
>
> Is there a reason why we are passing an u8 *req, in favor of a
> "rpmb_frame *frame" directly as the in-parameter?

In the OP-TEE driver, we get an arbitrarily sized block of data from
the secure world, but we don't interpret it. I expect that it would be
the same for any other driver. You get data from somewhere and need to
pass it on. With this interface, we can provide the needed sanity
checks here instead of forcing each caller to do it instead.

>
> > +       u16 req_type;
> > +       bool write;
> > +
> > +       if (!req || req_len < sizeof(*frm) || !rsp || !rsp_len)
> > +               return -EINVAL;
> > +
> > +       req_type =3D be16_to_cpu(frm->req_resp);
> > +       switch (req_type) {
> > +       case RPMB_PROGRAM_KEY:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   rsp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D true;
> > +               break;
> > +       case RPMB_GET_WRITE_COUNTER:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   rsp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D false;
> > +               break;
> > +       case RPMB_WRITE_DATA:
> > +               if (req_len % sizeof(struct rpmb_frame) ||
> > +                   rsp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D true;
> > +               break;
> > +       case RPMB_READ_DATA:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   rsp_len % sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D false;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return rdev->ops->route_frames(rdev->dev.parent, write,
> > +                                      req, req_len, rsp, rsp_len);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_route_frames);
>
> [...]
>
>
> > +
> > +/**
> > + * enum rpmb_type - type of underlaying storage technology
> > + *
> > + * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
> > + * @RPMB_TYPE_UFS   : UFS (JESD220)
> > + * @RPMB_TYPE_NVME  : NVM Express
> > + */
> > +enum rpmb_type {
> > +       RPMB_TYPE_EMMC,
> > +       RPMB_TYPE_UFS,
> > +       RPMB_TYPE_NVME,
> > +};
>
> In what way do we expect these to be useful?
>
> Perhaps we should add some information about this, because currently
> in the series they seem not to be used. Maybe the OP-TEE driver needs
> it when extending support to NVME and UFS?

Yes, we need to pass this information to the secure side. I'll update
the OP-TEE driver to extract and use the type field from struct
rpmb_ops.

Thanks,
Jens

>
> [...]
>
> Kind regards
> Uffe

