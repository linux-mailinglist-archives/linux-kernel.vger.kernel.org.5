Return-Path: <linux-kernel+bounces-64714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9FD8541DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91BA1F240BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A7BA22;
	Wed, 14 Feb 2024 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5uEeppc"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC31B64A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707882210; cv=none; b=k1h36s+PIY+zrUTMSDCKgvcMu1NKPXOIdXK04MMAoEiF1H9wbrd8fy/Q7aSaaoY4dwLks4SAvkrDBuiUwO5CAbzkk5O2byLlEWCexeky7C+c6xUe/2/nfDi7fCgJNbiUZIUOdn79ZwLx23J4tq8YgWxJJjGws5rObWVuknDNB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707882210; c=relaxed/simple;
	bh=KfMxCfELFvPSxQe57DRwXg0Qv8zopwXZCm4P1wudT+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l40BhZeUzgrAuTelNe+AuITgLpsiDHwDCW3HuUYxj5fVKbS0O49lKYcvAW8Fw3cJftxRmJc5L9m1ksGImibQqSPdOTO4Bn24MF6WlxD2uSPPfafEqnWJj5DOn+7zSj7OSmiZBROBTRtUqnH78aokAmlrUebEj32dFCO7AR0pMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5uEeppc; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so577231cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707882207; x=1708487007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVdsZB/ToMM1hFsUZU0UC5LfdCPk9RGSv+kQCIcz0sE=;
        b=P5uEeppc7Ak+pW8C10bhHjE2xl/gXRV/DWxreTrZGpFnRZBHNeQlaX26QL+6YTPzju
         njX7b0qg7GziHI718rF/eCyaY3l5tA/y9CPugalHwCS82KEA5eipXz3EVSUTk3bu3mFU
         61e01BB9hc7qK82XjuFrlpmaysqti6Cff+9rWn5mrWu3ws+tlOprXzB99AyyhHqerZOc
         T2Y4K33eOig+hFLjzluQKy5uLB0Je9JIxn5/h8V0pbkzNr5XKaGwPSDVvsaD5rf+dC/A
         VLmHEIIx8klHn6uNHwVIxQiNSZum+hBSbhVhHPLe3himJ+aRkpmET9ijf60h3aQSw/Z4
         HSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707882207; x=1708487007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVdsZB/ToMM1hFsUZU0UC5LfdCPk9RGSv+kQCIcz0sE=;
        b=XDyvvduuIwwQJuzAoR6FLRXp+YUfjnFgirNbr+X4T9qPJZDeuhyjxvYutCx2nWAcUi
         zz2+cvJhhCDH133P/jVa4HlqRb2jtXLnF7x9gZ1Ej0hz6A6pOWUw7vuz7MTDkrDxeus4
         2LAjL9rUGKumFQHs9gIkfzDo18dkfQkVMsFSSFUU4OmGKSFOHfkhv3ygCFWq/JleBZI6
         hWaLAI2KvlmgAqmLax28PuapyZriDGFYNiwjSgQ/N7KN7ON7IBfQESeISrZhYeDMe0z8
         9svfkaQVBLj1Mj/nXYiViY/KatnYonMV2Wtn6seNjpr9yDwfASoqUUVEtc9twAKkkj5f
         /ufw==
X-Gm-Message-State: AOJu0Yz3axIYmVL2M3R+ZxtG6DLch+aht99t88wOJ/cYVHQCV0o1K6IW
	6TbSdV+9LNCXeLj55t9FvU1S8x14QPFf6rSFfNolFj9CNOLXn5N6kQaIpM0K2KXRZjWYa55+Fsi
	qPJ8mz8N6hRVUFeEIwPILO9GBSS1IQhBpfIbLMrW9zDMLM+IyElPJ
X-Google-Smtp-Source: AGHT+IERNeITuXB2DOctF8Q3TmFhxDZD8cOk9Z6lv9oJLw9g32v/uohB8ZGy6kvhRku0RZXUjsHH+ryWlD5ENik9eMI=
X-Received: by 2002:ac8:5dce:0:b0:42d:b492:868f with SMTP id
 e14-20020ac85dce000000b0042db492868fmr199017qtx.24.1707882206589; Tue, 13 Feb
 2024 19:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207184100.18066-1-djeffery@redhat.com> <20240207184100.18066-2-djeffery@redhat.com>
In-Reply-To: <20240207184100.18066-2-djeffery@redhat.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 13 Feb 2024 19:42:50 -0800
Message-ID: <CAGETcx91KahXY6ULXDpek3Xf6k4s646Y6+jn_LtfZPDDOpg7hA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] minimal async shutdown infrastructure
To: David Jeffery <djeffery@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Laurence Oberman <loberman@redhat.com>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:40=E2=80=AFAM David Jeffery <djeffery@redhat.com>=
 wrote:
>
> Adds the async_shutdown_start and async_shutdown_end calls to perform asy=
nc
> shutdown. Implements a very minimalist method of async shutdown support
> within device_shutdown(). The device at the head of the shutdown list is
> checked against a list of devices under async shutdown. If the head is a
> parent of a device on the async list, all active async shutdown operation=
s
> are completed before the parent's shutdown call is performed.
>
> The number of async operations also has a max limit to prevent the list b=
eing
> checked for a child from getting overly large.
>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Tested-by:     Laurence Oberman <loberman@redhat.com>
>
> ---
>  drivers/base/core.c           | 116 +++++++++++++++++++++++++++++++++-
>  include/linux/device/bus.h    |   8 ++-
>  include/linux/device/driver.h |   7 ++
>  3 files changed, 127 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 14d46af40f9a..5bc2282c00cd 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4719,12 +4719,92 @@ int device_change_owner(struct device *dev, kuid_=
t kuid, kgid_t kgid)
>  }
>  EXPORT_SYMBOL_GPL(device_change_owner);
>
> +
> +#define MAX_ASYNC_SHUTDOWNS 32
> +static int async_shutdown_count;
> +static LIST_HEAD(async_shutdown_list);
> +
> +/**
> + * If a device has a child busy with an async shutdown or there are too =
many
> + * async shutdowns active, the device may not be shut down at this time.
> + */
> +static bool may_shutdown_device(struct device *dev)
> +{
> +       struct device *tmp;
> +
> +       if (async_shutdown_count >=3D MAX_ASYNC_SHUTDOWNS)
> +               return false;
> +
> +       list_for_each_entry(tmp, &async_shutdown_list, kobj.entry) {
> +               if (tmp->parent =3D=3D dev)
> +                       return false;
> +       }
> +       return true;
> +}
> +
> +/**
> + * Call and track each async shutdown call
> + */
> +static void async_shutdown_start(struct device *dev, void (*callback) (s=
truct device *))
> +{
> +       if (initcall_debug)
> +               dev_info(dev, "async_shutdown_start\n");
> +
> +       (*callback)(dev);
> +       list_add_tail(&dev->kobj.entry, &async_shutdown_list);
> +       async_shutdown_count++;
> +}
> +
> +/**
> + * Wait for all async shutdown operations currently active to complete
> + */
> +static void wait_for_active_async_shutdown(void)
> +{
> +       struct device *dev, *parent;
> +
> +        while (!list_empty(&async_shutdown_list)) {
> +                dev =3D list_entry(async_shutdown_list.next, struct devi=
ce,
> +                                kobj.entry);
> +
> +                parent =3D dev->parent;

I didn't check the code thoroughly, but so there might be other big
issues. But you definitely need to take device links into account.
Shutdown all your consumers first similar to how you shutdown the
children devices first. Look at the async suspend/resume code for some
guidance.

> +
> +                /*
> +                 * Make sure the device is off the list
> +                 */
> +                list_del_init(&dev->kobj.entry);
> +                if (parent)
> +                        device_lock(parent);
> +                device_lock(dev);
> +                if (dev->bus && dev->bus->async_shutdown_end) {
> +                        if (initcall_debug)
> +                                dev_info(dev,
> +                                "async_shutdown_end called\n");
> +                        dev->bus->async_shutdown_end(dev);
> +                } else if (dev->driver && dev->driver->async_shutdown_en=
d) {
> +                       if (initcall_debug)
> +                               dev_info(dev,
> +                               "async_shutdown_end called\n");
> +                       dev->driver->async_shutdown_end(dev);
> +               }
> +                device_unlock(dev);
> +                if (parent)
> +                        device_unlock(parent);
> +
> +                put_device(dev);
> +                put_device(parent);
> +        }
> +       if (initcall_debug)
> +               printk(KERN_INFO "device shutdown: waited for %d async sh=
utdown callbacks\n", async_shutdown_count);
> +       async_shutdown_count =3D 0;
> +}
> +
>  /**
>   * device_shutdown - call ->shutdown() on each device to shutdown.
>   */
>  void device_shutdown(void)
>  {
>         struct device *dev, *parent;
> +       bool async_busy;
>
>         wait_for_device_probe();
>         device_block_probing();
> @@ -4741,6 +4821,8 @@ void device_shutdown(void)
>                 dev =3D list_entry(devices_kset->list.prev, struct device=
,
>                                 kobj.entry);
>
> +               async_busy =3D false;
> +
>                 /*
>                  * hold reference count of device's parent to
>                  * prevent it from being freed because parent's
> @@ -4748,6 +4830,17 @@ void device_shutdown(void)
>                  */
>                 parent =3D get_device(dev->parent);
>                 get_device(dev);
> +
> +                if (!may_shutdown_device(dev)) {
> +                       put_device(dev);
> +                       put_device(parent);
> +
> +                       spin_unlock(&devices_kset->list_lock);
> +                       wait_for_active_async_shutdown();
> +                       spin_lock(&devices_kset->list_lock);
> +                       continue;
> +               }
> +
>                 /*
>                  * Make sure the device is off the kset list, in the
>                  * event that dev->*->shutdown() doesn't remove it.
> @@ -4769,26 +4862,43 @@ void device_shutdown(void)
>                                 dev_info(dev, "shutdown_pre\n");
>                         dev->class->shutdown_pre(dev);
>                 }
> -               if (dev->bus && dev->bus->shutdown) {
> +               if (dev->bus && dev->bus->async_shutdown_start) {
> +                       async_shutdown_start(dev, dev->bus->async_shutdow=
n_start);
> +                       async_busy =3D true;
> +               } else if (dev->bus && dev->bus->shutdown) {
>                         if (initcall_debug)
>                                 dev_info(dev, "shutdown\n");
>                         dev->bus->shutdown(dev);
> +               } else if (dev->driver && dev->driver->async_shutdown_sta=
rt) {
> +                       async_shutdown_start(dev, dev->driver->async_shut=
down_start);
> +                       async_busy =3D true;
>                 } else if (dev->driver && dev->driver->shutdown) {
>                         if (initcall_debug)
>                                 dev_info(dev, "shutdown\n");
>                         dev->driver->shutdown(dev);
> +               } else {
> +                       if (initcall_debug)
> +                               dev_info(dev, "no shutdown callback\n");
>                 }
>
>                 device_unlock(dev);
>                 if (parent)
>                         device_unlock(parent);
>
> -               put_device(dev);
> -               put_device(parent);
> +               /* if device has an async shutdown, drop the ref when don=
e */
> +               if (!async_busy) {
> +                       put_device(dev);
> +                       put_device(parent);
> +               }
>
>                 spin_lock(&devices_kset->list_lock);
>         }
>         spin_unlock(&devices_kset->list_lock);
> +       /*
> +        * Wait for any async shutdown still running.
> +        */
> +       if (!list_empty(&async_shutdown_list))
> +               wait_for_active_async_shutdown();
>  }
>
>  /*
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 5ef4ec1c36c3..7a4a2ff0bc23 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -48,7 +48,11 @@ struct fwnode_handle;
>   *             will never get called until they do.
>   * @remove:    Called when a device removed from this bus.
>   * @shutdown:  Called at shut-down time to quiesce the device.
> - *
> + * @async_shutdown_start:      Optional call to support and begin the sh=
utdown
> + *                             process on the device in an asynchronous =
manner.
> + * @async_shutdown_end:                Optional call to complete an asyn=
chronous
> + *                             shutdown of the device. Must be provided =
if a
> + *                             sync_shutdown_start call is provided.
>   * @online:    Called to put the device back online (after offlining it)=
.
>   * @offline:   Called to put the device offline for hot-removal. May fai=
l.
>   *
> @@ -87,6 +91,8 @@ struct bus_type {
>         void (*sync_state)(struct device *dev);
>         void (*remove)(struct device *dev);
>         void (*shutdown)(struct device *dev);
> +       void (*async_shutdown_start)(struct device *dev);
> +       void (*async_shutdown_end)(struct device *dev);
>
>         int (*online)(struct device *dev);
>         int (*offline)(struct device *dev);
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.=
h
> index 7738f458995f..af0ad2d3687a 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -71,6 +71,11 @@ enum probe_type {
>   * @remove:    Called when the device is removed from the system to
>   *             unbind a device from this driver.
>   * @shutdown:  Called at shut-down time to quiesce the device.
> + * @async_shutdown_start:      Optional call to support and begin the sh=
utdown
> + *                             process on the device in an asynchronous =
manner.
> + * @async_shutdown_end:                Optional call to complete an asyn=
chronous
> + *                             shutdown of the device. Must be provided =
if a
> + *                             sync_shutdown_start call is provided.
>   * @suspend:   Called to put the device to sleep mode. Usually to a
>   *             low power state.
>   * @resume:    Called to bring a device from sleep mode.
> @@ -110,6 +115,8 @@ struct device_driver {
>         void (*sync_state)(struct device *dev);
>         int (*remove) (struct device *dev);
>         void (*shutdown) (struct device *dev);
> +       void (*async_shutdown_start) (struct device *dev);
> +       void (*async_shutdown_end) (struct device *dev);

Why not use the existing shutdown and call it from an async thread and
wait for it to finish? Similar to how async probes are handled. Also,
adding separate ops for this feels clunky and a very narrow fix. Just
use a flag to indicate the driver can support async shutdown using the
existing shutdown() op.

-Saravana

