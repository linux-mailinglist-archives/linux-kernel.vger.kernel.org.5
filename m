Return-Path: <linux-kernel+bounces-52734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39339849C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81FC1F24CEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2976328DD8;
	Mon,  5 Feb 2024 13:38:00 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1846C28E02;
	Mon,  5 Feb 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140279; cv=none; b=bSyUlZJtD1r/xwfaUgAibIk7aiqPQuh5KCN0FnNWAFD9UUKC729jeTrugazrbTU+qafx4LljW9PK27FR82W5/2Nsdh+DemFdTZ9NLaQPRtAHYk+qPqIwujNMptp0EEW2/GgheCJcmtjQ+CalL3+J9R8MxXh3BIHfcnDjYtoCfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140279; c=relaxed/simple;
	bh=bjy2cTKIG5MIwS71BFpPmwz9u0IgB3fRcGxLN2GaGCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tO8eAjPOqLzSm5ZLypVt/GIUHK6G235+yGm8LBT5lgsSL570XkylSi9s7D5hbK4gtYXzztv5SJZxV/d8Vdph1LzKf2V7PauI/KLn0wQOEPseZrsPYLlYvzx77p6p1zAri1ZBNj+4VMoLLpU4VSFqVNDgt1pG7T7kYSn0Y3F8w8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bc21303a35so1562726b6e.0;
        Mon, 05 Feb 2024 05:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140277; x=1707745077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHzeDjcpRLRmLjdC/W3BzMsilNLy88EgDleTTO6CSOU=;
        b=NGjZ4J13VqHB717T4OW+9SQ6SW4LJUjYqBwrjCVf1YzWXFqwHO0egS3nj1nPho5mPf
         LWxfczXr6c2bx6vb/74ivlSABd1bEibJ8atOxL9tUj7LmTCgUf+Y8cW5csavWwh88EK+
         oaySxPLi/i18vFen2h/cfJ5DgWj7xDMP3zalwmWWvDYek4lDvPEUGMzpHHYyAcmIj7o8
         C7H6PsAudaF2nnoJmvdHu3d8O7l/wlEw0W7QPdlmhmwZZD+9cFxbJAM8JWNq7HOSsiGc
         dMzY7/g98WGef3fxJ8Hy0qlIfTMhs8Kqy/7Yhcpv8kRXF253+4MuFVcL8y+HFZiGymdM
         ypyQ==
X-Forwarded-Encrypted: i=0; AJvYcCWk7T9nWH445sSNlVwWhDCNcci7/W1WXNkpSOadc31geN9d7CJ4CDv7xBQsIjhJTQLZ8BWUy0Jm3j3crOyBsqIZr6ksZs9mmHkCpo2OkwMl9Wi0eELmKKY9+AINJkSW8lvScChAFcFhF/e7cFiz5yv8qAfRWi1e3njxPgLXli1I2UV87XI=
X-Gm-Message-State: AOJu0YwiO32fwTnIiX4P6KVNz2qkMKrRI4FzcKFjVwvhbO1BRedxvWAq
	2TzMuCxjcpW98zoe4s88zMShTvb34EnKknSUVfIQOufqik8tOdjpGjM9lFpTcKzjkwi06/bghBB
	x9QQIGsfOTdPEus/V8P8OfP040jg=
X-Google-Smtp-Source: AGHT+IHtvU5AWKH2/sbbZ4kcP66v4YuviTYjq8anzvhlvzNs6vRyDKtMqAmd/SnDra/TKGp99EHkhtHNQbVrdqac57w=
X-Received: by 2002:a05:6870:598:b0:218:c0c1:a091 with SMTP id
 m24-20020a056870059800b00218c0c1a091mr16246651oap.2.1707140277106; Mon, 05
 Feb 2024 05:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com> <20240205-fix-device-links-overlays-v2-1-5344f8c79d57@analog.com>
In-Reply-To: <20240205-fix-device-links-overlays-v2-1-5344f8c79d57@analog.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Feb 2024 14:37:46 +0100
Message-ID: <CAJZ5v0hNtTg+tJZSP_tZUrxQcYa9fp7LZXNG3bGVEbxX1W1Eqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver: core: add dedicated workqueue for devlink removal
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

On Mon, Feb 5, 2024 at 1:09=E2=80=AFPM Nuno Sa via B4 Relay
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
>
> While at it, make sure to explicitly include <linux/workqueue.h>.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c    | 32 ++++++++++++++++++++++++++++----
>  include/linux/fwnode.h |  1 +
>  2 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 14d46af40f9a..4bb9c10489ed 100644
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
> @@ -235,6 +237,12 @@ static void __fw_devlink_pickup_dangling_consumers(s=
truct fwnode_handle *fwnode,
>                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
>  }
>
> +void fwnode_links_flush_queue(void)
> +{
> +       if (devlink_release_queue)
> +               flush_workqueue(devlink_release_queue);
> +}
> +
>  static DEFINE_MUTEX(device_links_lock);
>  DEFINE_STATIC_SRCU(device_links_srcu);
>
> @@ -531,9 +539,13 @@ static void devlink_dev_release(struct device *dev)
>          * It may take a while to complete this work because of the SRCU
>          * synchronization in device_link_release_fn() and if the consume=
r or
>          * supplier devices get deleted when it runs, so put it into the =
"long"
> -        * workqueue.
> +        * devlink workqueue (in case we could allocate one).
> +        *
>          */
> -       queue_work(system_long_wq, &link->rm_work);
> +       if (devlink_release_queue)
> +               queue_work(devlink_release_queue, &link->rm_work);
> +       else
> +               device_link_release_fn(&link->rm_work);
>  }
>
>  static struct class devlink_class =3D {
> @@ -636,10 +648,22 @@ static int __init devlink_class_init(void)
>                 return ret;
>
>         ret =3D class_interface_register(&devlink_class_intf);
> -       if (ret)
> +       if (ret) {
>                 class_unregister(&devlink_class);
> +               return ret;
> +       }
>
> -       return ret;
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
> +
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
> 2.43.0
>

