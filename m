Return-Path: <linux-kernel+bounces-50089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4599F847413
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3E01F2723D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90021487C8;
	Fri,  2 Feb 2024 15:59:48 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E09148308;
	Fri,  2 Feb 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889588; cv=none; b=u1LRu2bQjeFOtKyYX9+oCK5edlM5rw6URML3Rhy/EY244xfJqBQUj59/UMvG4RNI4jHPIqj3QH5ddaxcUjMDn1H+9tLJn2iChakBu9EugAJQBRlVxjy7UV8rbUC9FyfwrszlQ0dgdEMZy7C+secH6ljlaDJJwrqeeEAiR7daCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889588; c=relaxed/simple;
	bh=7yi/zjSsxVNqTRQbhdO51Oqbn2B4A00QYjxdFqIJ0x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+hbrwY8ksCo7roGfNISy/6HCiCS5jmK/eS/3ZsLYAsXAWd1LlCZ0NVbG2G5t3b47gfls73CO9Aaq81bIn+FNi0Pdct8hxY+wnjKJc2k7f8yRwS7dS6dxFWYX88p4gZPyMYRBMlYdPCd2HZgIxxJglXy6yfoJWCdjd6fp1357pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bc21303a35so676500b6e.0;
        Fri, 02 Feb 2024 07:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889586; x=1707494386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auL16LpvoDkFJLLhh00PkECn/QrUMlvnY9JxMZw7mDc=;
        b=owXCVQa2Ta9GiK6FIIUSXT5dM9/wuYkNoZT3jZ7wp3f8+3S+UR0eDUixDNqvkvZTN9
         pZVraxhd36/hsqt6XraBjp+ixNrj80EDtLgI6CCyW77Kgei6oxOpZLOddLDOHax/4+Oa
         Fuq6Tz3JuCoPcZjWlq9T+s6S1kANttPJYqcc2aodFuQEHanAclRus5WUgQgPd4uyxIVY
         PJGgXFskPn1JiBu9OPZniYcUE/Wb0CD+CxQgULV+OOyCuswS9FghxdJwwa7uNRsAgQvy
         BqNEnbieMiSBvPuu7EHrnf/hY3JL8I+jg2qh39Rz44U0WghPqTRmvSIWoSlfF66bYjzd
         Mj5A==
X-Forwarded-Encrypted: i=0; AJvYcCVCxldZTDy2HG8/RxPzZ69VKJ8srbKatCchwIaANgvEK4+vUJaxamlmmGWC/UiKCenawN2NnNQ+TV/V77pXe0AG8GRhu9gBqV9RgGBvlzJh1+8TTDxEwvCAbS8aZJmj63n4cz+030JxJUNle0iky9CybvezNT0BO+UGUZtI2x/p1Pawtl8=
X-Gm-Message-State: AOJu0YwjKVlZILGGjupI7c2k9njzmtGzgOzbr72XUL7t70inYE9Xb6KA
	Vf/KGVSDEl409d9WrqZtMm3tuG3dMP3Cj8UilIQTXZdJxVUvdJM5S4mlVvXU8ip88QDMR80x1jO
	RO5EupMggJ2SQ3h54ERfMh73l17s=
X-Google-Smtp-Source: AGHT+IFa9hpjb88gx1bG9zjhuo/116xDCr2ZTPA35bmFzYzkmqNVdEhrrS4FotLAIFnYwWojff5VFDJL+3bCvZI8CPU=
X-Received: by 2002:a05:6808:2191:b0:3be:1b04:ee82 with SMTP id
 be17-20020a056808219100b003be1b04ee82mr9871977oib.0.1706889585756; Fri, 02
 Feb 2024 07:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-fix-device-links-overlays-v1-0-f9fd1404c8e2@analog.com> <20240202-fix-device-links-overlays-v1-1-f9fd1404c8e2@analog.com>
In-Reply-To: <20240202-fix-device-links-overlays-v1-1-f9fd1404c8e2@analog.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Feb 2024 16:59:33 +0100
Message-ID: <CAJZ5v0g5JbstLhCaXcY1kawP8etB5Z4TBuGXHz8_wsrXm3CaQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver: core: add dedicated workqueue for devlink removal
To: nuno.sa@analog.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:18=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Let's use a dedicated queue for devlinks since releasing a link happens
> asynchronously but some code paths, like DT overlays, have some
> expectations regarding the of_node when being removed (the refcount must
> be 1). Given how devlinks are released that cannot be assured. Hence, add=
 a
> dedicated queue so that it's easy to sync against devlinks removal.

Thanks for following my suggestion!

> While at it, make sure to explicitly include <linux/workqueue.h>.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/base/core.c    | 33 +++++++++++++++++++++++++++++----
>  include/linux/fwnode.h |  1 +
>  2 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 14d46af40f9a..06e7766b5227 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -31,6 +31,7 @@
>  #include <linux/swiotlb.h>
>  #include <linux/sysfs.h>
>  #include <linux/dma-map-ops.h> /* for dma_default_coherent */
> +#include <linux/workqueue.h>
>
>  #include "base.h"
>  #include "physical_location.h"
> @@ -44,6 +45,7 @@ static bool fw_devlink_is_permissive(void);
>  static void __fw_devlink_link_to_consumers(struct device *dev);
>  static bool fw_devlink_drv_reg_done;
>  static bool fw_devlink_best_effort;
> +static struct workqueue_struct *devlink_release_queue __ro_after_init;
>
>  /**
>   * __fwnode_link_add - Create a link between two fwnode_handles.
> @@ -235,6 +237,11 @@ static void __fw_devlink_pickup_dangling_consumers(s=
truct fwnode_handle *fwnode,
>                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
>  }
>
> +void fwnode_links_flush_queue(void)
> +{
> +       flush_workqueue(devlink_release_queue);
> +}
> +
>  static DEFINE_MUTEX(device_links_lock);
>  DEFINE_STATIC_SRCU(device_links_srcu);
>
> @@ -531,9 +538,10 @@ static void devlink_dev_release(struct device *dev)
>          * It may take a while to complete this work because of the SRCU
>          * synchronization in device_link_release_fn() and if the consume=
r or
>          * supplier devices get deleted when it runs, so put it into the =
"long"
> -        * workqueue.
> +        * devlink workqueue.
> +        *
>          */
> -       queue_work(system_long_wq, &link->rm_work);
> +       queue_work(devlink_release_queue, &link->rm_work);
>  }
>
>  static struct class devlink_class =3D {
> @@ -636,10 +644,27 @@ static int __init devlink_class_init(void)
>                 return ret;
>
>         ret =3D class_interface_register(&devlink_class_intf);
> -       if (ret)
> +       if (ret) {
> +               class_unregister(&devlink_class);
> +               return ret;
> +       }
> +
> +       /*
> +        * Using a dedicated queue for devlinks since releasing a link ha=
ppens
> +        * asynchronously but some code paths, like DT overlays, have som=
e
> +        * expectations regarding the of_node when being removed (the ref=
count
> +        * must be 1). Given how devlinks are released that cannot be ass=
ured.
> +        * Hence, add a dedicated queue so that it's easy to sync against
> +        * devlinks removal.
> +        */
> +       devlink_release_queue =3D alloc_workqueue("devlink_release", 0, 0=
);
> +       if (!devlink_release_queue) {
> +               class_interface_unregister(&devlink_class_intf);
>                 class_unregister(&devlink_class);

This is a bit drastic.

I think that device links can still work if devlink_release_queue is
NULL, just devlink_dev_release() needs to check it and release
synchronously if it is NULL.

Apart from this LGTM.

> +               return -ENODEV;
> +       }
>
> -       return ret;
> +       return 0;
>  }
>  postcore_initcall(devlink_class_init);
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 2a72f55d26eb..017b170e9903 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -213,5 +213,6 @@ extern bool fw_devlink_is_strict(void);
>  int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup=
);
>  void fwnode_links_purge(struct fwnode_handle *fwnode);
>  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> +void fwnode_links_flush_queue(void);
>
>  #endif
>
> --

