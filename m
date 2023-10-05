Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46F17BA56B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbjJEQQa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 12:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241131AbjJEQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:41 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C72352E;
        Thu,  5 Oct 2023 03:57:23 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57de3096e25so173286eaf.1;
        Thu, 05 Oct 2023 03:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696503441; x=1697108241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHZOHMKnHnUoQVrnF/VGJo5pGDkVnUXT2duBMZ63+cU=;
        b=HYtH0Sq+CKuBfx0Uh+8i+os14CxiB/fOV3vug5thOpQlq1rhFzI89Qd8V32EDS+F6M
         fr714nwrr+hNJu461hil4aUUfaIApCjynw8CW+swptEYNofP540FqXnk6WzLM4Q0uw20
         Jza4c8GhmoGO8NQkdaepzJUCHY5RTIRscdypbFKpUdU9Y1YxwSlOcjOWp8WxojlVyG7m
         v7vWiPVeedDQz4QT1SYLilh8/nD23n6fAAiDNkWFRF3el4oJpMOUt6MBZeQ/JSxBqak2
         SkNGjBRDj3MGKEC5ZaeOnpMauqE1vDLcN0kbAd0GmB/SAOeO1fEFEiM873lihMKkUrFj
         W+0Q==
X-Gm-Message-State: AOJu0Yy66OI7MUVw1dwPgcXTBkbf+PfbKsWf08ea1wSbJQPWapcah0FZ
        KB6FLGp/CA7oJflhajFFxfCGaN/z7ySfLFQKWkY=
X-Google-Smtp-Source: AGHT+IFizCurFp6FO9t8agx4COfRDlvV8vc8iFUsRVOy6AzVdXAwPC+J7MtbqH1HoTQMrLGQdJxRWkTm65Km4jqa6w0=
X-Received: by 2002:a4a:ee90:0:b0:57b:94b7:c6ba with SMTP id
 dk16-20020a4aee90000000b0057b94b7c6bamr4563196oob.0.1696503440785; Thu, 05
 Oct 2023 03:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <20230925144842.586829-2-michal.wilczynski@intel.com> <CAJZ5v0jyjH48XZ6vytncodYhsS6ODYg2yaZBPfRWb_qm99FMuA@mail.gmail.com>
 <f8b9cfb4-aa0f-44c0-84fe-613f005a2baf@intel.com>
In-Reply-To: <f8b9cfb4-aa0f-44c0-84fe-613f005a2baf@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Oct 2023 12:57:08 +0200
Message-ID: <CAJZ5v0jF_okRNkYySRQTSKBohaFk52V7Tcm=a1kVFaY6MWD4Hg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] ACPI: bus: Make notify wrappers more generic
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com,
        andriy.shevchenko@intel.com, lenb@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 10:10 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
> Hi,
>
> Thanks for your review !
>
> On 10/4/2023 9:09 PM, Rafael J. Wysocki wrote:
> > On Mon, Sep 25, 2023 at 6:31 PM Michal Wilczynski
> > <michal.wilczynski@intel.com> wrote:
> >> acpi_dev_install_notify_handler() and acpi_dev_remove_notify_handler()
> >> are wrappers around ACPICA installers. They are meant to save some
> >> duplicated code from drivers. However as we're moving towards drivers
> >> operating on platform_device they become a bit inconvenient to use as
> >> inside the driver code we mostly want to use driver data of platform
> >> device instead of ACPI device.
> > That's fair enough, but ->
> >
> >> Make notify handlers installer wrappers more generic, while still
> >> saving some code that would be duplicated otherwise.
> >>
> >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >> ---
> >>
> >> Notes:
> >>     So one solution could be to just replace acpi_device with
> >>     platform_device as an argument in those functions. However I don't
> >>     believe this is a correct solution, as it is very often the case that
> >>     drivers declare their own private structures which gets allocated during
> >>     the .probe() callback, and become the heart of the driver. When drivers
> >>     do that it makes much more sense to just pass the private structure
> >>     to the notify handler instead of forcing user to dance with the
> >>     platform_device or acpi_device.
> >>
> >>  drivers/acpi/ac.c         |  6 +++---
> >>  drivers/acpi/acpi_video.c |  6 +++---
> >>  drivers/acpi/battery.c    |  6 +++---
> >>  drivers/acpi/bus.c        | 14 ++++++--------
> >>  drivers/acpi/hed.c        |  6 +++---
> >>  drivers/acpi/nfit/core.c  |  6 +++---
> >>  drivers/acpi/thermal.c    |  6 +++---
> >>  include/acpi/acpi_bus.h   |  9 ++++-----
> >>  8 files changed, 28 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> >> index 225dc6818751..0b245f9f7ec8 100644
> >> --- a/drivers/acpi/ac.c
> >> +++ b/drivers/acpi/ac.c
> >> @@ -256,8 +256,8 @@ static int acpi_ac_add(struct acpi_device *device)
> >>         ac->battery_nb.notifier_call = acpi_ac_battery_notify;
> >>         register_acpi_notifier(&ac->battery_nb);
> >>
> >> -       result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
> >> -                                                acpi_ac_notify);
> >> +       result = acpi_dev_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
> >> +                                                acpi_ac_notify, device);
> >>         if (result)
> >>                 goto err_unregister;
> >>
> >> @@ -306,7 +306,7 @@ static void acpi_ac_remove(struct acpi_device *device)
> >>
> >>         ac = acpi_driver_data(device);
> >>
> >> -       acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
> >> +       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
> >>                                        acpi_ac_notify);
> >>         power_supply_unregister(ac->charger);
> >>         unregister_acpi_notifier(&ac->battery_nb);
> >> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> >> index 948e31f7ce6e..025c17890127 100644
> >> --- a/drivers/acpi/acpi_video.c
> >> +++ b/drivers/acpi/acpi_video.c
> >> @@ -2059,8 +2059,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
> >>
> >>         acpi_video_bus_add_notify_handler(video);
> >>
> >> -       error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> >> -                                               acpi_video_bus_notify);
> >> +       error = acpi_dev_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> >> +                                               acpi_video_bus_notify, device);
> >>         if (error)
> >>                 goto err_remove;
> >>
> >> @@ -2092,7 +2092,7 @@ static void acpi_video_bus_remove(struct acpi_device *device)
> >>
> >>         video = acpi_driver_data(device);
> >>
> >> -       acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> >> +       acpi_dev_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> >>                                        acpi_video_bus_notify);
> >>
> >>         mutex_lock(&video_list_lock);
> >> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> >> index 969bf81e8d54..45dae32a8646 100644
> >> --- a/drivers/acpi/battery.c
> >> +++ b/drivers/acpi/battery.c
> >> @@ -1213,8 +1213,8 @@ static int acpi_battery_add(struct acpi_device *device)
> >>
> >>         device_init_wakeup(&device->dev, 1);
> >>
> >> -       result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
> >> -                                                acpi_battery_notify);
> >> +       result = acpi_dev_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
> >> +                                                acpi_battery_notify, device);
> >>         if (result)
> >>                 goto fail_pm;
> >>
> >> @@ -1241,7 +1241,7 @@ static void acpi_battery_remove(struct acpi_device *device)
> >>
> >>         battery = acpi_driver_data(device);
> >>
> >> -       acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
> >> +       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
> >>                                        acpi_battery_notify);
> >>
> >>         device_init_wakeup(&device->dev, 0);
> >> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> >> index f41dda2d3493..479fe888d629 100644
> >> --- a/drivers/acpi/bus.c
> >> +++ b/drivers/acpi/bus.c
> >> @@ -554,14 +554,13 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
> >>         acpi_os_wait_events_complete();
> >>  }
> >>
> >> -int acpi_dev_install_notify_handler(struct acpi_device *adev,
> >> -                                   u32 handler_type,
> >> -                                   acpi_notify_handler handler)
> >> +int acpi_dev_install_notify_handler(acpi_handle handle, u32 handler_type,
> >> +                                   acpi_notify_handler handler, void *context)
> >>  {
> >>         acpi_status status;
> >>
> >> -       status = acpi_install_notify_handler(adev->handle, handler_type,
> >> -                                            handler, adev);
> >> +       status = acpi_install_notify_handler(handle, handler_type,
> >> +                                            handler, context);
> > The wrapper now takes exactly the same arguments as the wrapped
> > function, so what exactly is the point of having it?  The return value
> > type?
>
> I considered removing the wrapper altogether, but decided not to do so.
> One trivial advantage of leaving this wrapper is the return value type as
> you noticed, another is that the removal wrapper actually does something
> extra and removing it would result in duplicate code among the drivers.
> So I didn't really want to remove the 'install' wrapper but leave the
> 'remove' wrapper, as I think this might be confusing for the future reader.
> In my mind if something is removed by the wrapper it should also be
> installed by the wrapper.

I agree here.

> >
> >>         if (ACPI_FAILURE(status))
> >>                 return -ENODEV;
> >>
> >> @@ -569,11 +568,10 @@ int acpi_dev_install_notify_handler(struct acpi_device *adev,
> >>  }
> >>  EXPORT_SYMBOL_GPL(acpi_dev_install_notify_handler);
> >>
> >> -void acpi_dev_remove_notify_handler(struct acpi_device *adev,
> >> -                                   u32 handler_type,
> >> +void acpi_dev_remove_notify_handler(acpi_handle handle, u32 handler_type,
> >>                                     acpi_notify_handler handler)
> >>  {
> >> -       acpi_remove_notify_handler(adev->handle, handler_type, handler);
> >> +       acpi_remove_notify_handler(handle, handler_type, handler);
> >>         acpi_os_wait_events_complete();
> > Here at least there is the extra workqueues synchronization point.
> >
> > That said, why exactly is it better to use acpi_handle instead of a
> > struct acpi_device pointer?
>
> I wanted to make the wrapper as close as possible to the wrapped function.
> This way it would be easier to remove it in the future i.e if we ever deem
> extra synchronization not worth it etc. What the ACPICA function need to
> install a wrapper is a handle not a pointer to a device.
> So there is no need for a middle man.

Taking a struct acpi_device pointer as the first argument is part of
duplication reduction, however, because in the most common case it
saves the users of it the need to dereference the struct acpi_device
they get from ACPI_COMPANION() in order to obtain the handle.

Arguably, acpi_handle is an ACPICA concept and it is better to reduce
its usage outside ACPICA.

> >
> > Realistically, in a platform driver you'll need the latter to obtain
> > the former anyway.
>
> I don't want to introduce arbitrary limitations where they are not necessary.

I'm not sure what you mean.  This patch is changing existing functions.

> It is often the case that driver allocates it's own private struct using kmalloc
> family of functions, and that structure already contains everything that is
> needed to remove the handler, so why force ? There are already examples
> in the drivers that do that i.e in acpi_video the function
> acpi_video_dev_add_notify_handler() uses raw ACPICA handler to install
> a notify handler and it passes private structure there.
> So there is value in leaving the choice of an actual type to the user of the
> API.

No, if the user has a pointer to struct acpi_device already, there is
no difference between passing this and passing the acpi_handle from it
except for the extra dereference in the latter case.

If the user doesn't have a struct acpi_device pointer, let them use
the raw ACPICA handler directly and worry about the synchronization
themselves.

The wrappers are there to cover the most common case, not to cover all cases.

> To summarize:
> I would say the wrappers are mostly unnecessary, but they actually save
> some duplicate code in the drivers, so I decided to leave them, as I don't
> want to introduce duplicate code if I can avoid that.

What duplicate code do you mean, exactly?

IMV you haven't really explained why this particular patch is
necessary or even useful.

Thanks!
