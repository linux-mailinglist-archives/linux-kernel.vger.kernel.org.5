Return-Path: <linux-kernel+bounces-47728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62A8451DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A970AB21D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69921586E2;
	Thu,  1 Feb 2024 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FK0P7dK5"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D18634FF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772226; cv=none; b=NiQtuSbYUSx2Gg8jaw80+3VNVwb+ngxffE6lk9/aU1811x2NA/iVhTanhNUjUBvY94nMS6zTSPiICagOEQOEMSY9KNdOCTNKUedz7Fk0+HCcAHfS05il4RRn0bejQ2j5gWP4uWE2bfS9CiExCNFAMWs1Dh5QqSFbFfhmlzLYQPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772226; c=relaxed/simple;
	bh=DEN/kHFjqWUd0ytUfrFgKzKqg40sG6kKXfo4lyhtOyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCPC1ENC1m0DfaPGLlXVPnF2sMjZKna9/3CAk1oALMxjlJpf8LPUwhO08+eNmStQwCTZ5GpBYlfEbaHtt7lGH1lBH1QJpDMPmNLqoqU5wYe2GFyJot0ALpbaIh7Ja6sulr+6ubG18peHt6WZB7PtGJUdbcpsQBkL/ojOevw/F8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FK0P7dK5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f85a2a43fso6402a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706772223; x=1707377023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEHTNo21libmsE7au9AeaAX5BU9TiDgxYF+CMdrd70k=;
        b=FK0P7dK5QAhdP/JxeOXXLy8C+nRjXO3JD0Nsc6+5CGE6KfbuGWk3sPRSKAQb453Xsq
         0HYc2Uj8c1WNkBRn/vSr6ONUMfwB/vs9E3aYSXwdL0DnqZfQk7M/f4YmrUU4o3sO2Mtw
         cA+gLd0uU6pxXe06HF7IpVkKGiaFPf0OjlXfmVUOXICntz+dNtANM0UJj06nU8vkdW+R
         YVCdEpFDU8FzQx010i9DehXjfjDoBdqiq27i+UVYSksq8c/EMrVYdKgXjR3r77glDt9m
         dBqKmWk90qs4+oPqgz3MduQOBNcytdra2QUznIWI+oUHoku9qXAfcrOHd1PNJPcIZheZ
         P8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706772223; x=1707377023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEHTNo21libmsE7au9AeaAX5BU9TiDgxYF+CMdrd70k=;
        b=sHbGf7RMnjWk9buEGG4otBq9Aimx4CZ+h5OeQuHCr4RkRvr+mmYYUZELRakMC0XYCy
         ONdC0Wka3OObqgYRGnsGswUl/4+z/3tiXfvjACx0xYRXwhYaPYt4Ik1SEp76cLDVAwh8
         jjbgRMzUGWPvpGpdmQ9Ysbf9BYcun/rhTRLcdBCP50rXyfLXdGZE5BCJ0g8U2ZjXjzFs
         uw++wZhA15lhjF0pbE8Zh/+y6PVij4mY+EhIynXZ2tpa31omw20C5mmJVAUWEatS21vK
         9TwpNMOeNaikRxnsbWxnY6h/QM3jN57c/LFQ85b7KH9cvRupkrdayS4I8INnfHslWbbf
         JhYg==
X-Gm-Message-State: AOJu0YzOmKgDxrx70PhWLIIYclfyfpWYBueEh+NuoUcDTpFxJIEf4tcc
	yOvo4q4GNCmwZ/Z+59+Pu/2XGiahyRrt/BrpAJ8K3BHf0hd6zYXsLMl6fozIVquwTKq+NUXozHH
	qfyLRYTcihhuqvvkKI7G13EVkfR7Dkkz/Y27y
X-Google-Smtp-Source: AGHT+IHjjVrlcT3LSzE8w+BkqBD3RoRplYUGqC6zXRrHb9zrZPFin4bJ79b2Kc6+WqHo20r3JwuIzo7Rgkel23480xM=
X-Received: by 2002:a50:cd02:0:b0:55f:a1af:bade with SMTP id
 z2-20020a50cd02000000b0055fa1afbademr5139edi.4.1706772222937; Wed, 31 Jan
 2024 23:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130064819.1362642-1-guanyulin@google.com> <2024013056-fidelity-sandy-0353@gregkh>
In-Reply-To: <2024013056-fidelity-sandy-0353@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Thu, 1 Feb 2024 15:22:00 +0800
Message-ID: <CAOuDEK1o_oGRcfQqCo5yjDRGibKAWa2NvZrK=hjim8GuNqJ9yQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] usb: host: Allow userspace to control usb suspend flows
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, stern@rowland.harvard.edu, royluo@google.com, 
	hadess@hadess.net, benjamin.tissoires@redhat.com, 
	heikki.krogerus@linux.intel.com, oneukum@suse.com, grundler@chromium.org, 
	yajun.deng@linux.dev, dianders@chromium.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, badhri@google.com, albertccwang@google.com, 
	pumahsu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:41=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Jan 30, 2024 at 06:47:13AM +0000, Guan-Yu Lin wrote:
> > In a system with sub-system engaged, the controllers are controlled by
> > both the main processor and the co-processor. Chances are when the main
> > processor decides to suspend the USB device, the USB device might still
> > be used by the co-processor. In this scenario, we need a way to let
> > system know whether it can suspend the USB device or not. We introduce =
a
> > new sysfs entry "deprecate_device_pm" to allow userspace to control the
> > device power management functionality on demand. As the userspace shoul=
d
> > possess the information of both the main processor and the co-processor=
,
> > it should be able to address the conflict mentioned above.
> >
> > Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-usb | 10 +++++++++
> >  drivers/usb/core/driver.c               | 18 ++++++++++++++++
> >  drivers/usb/core/sysfs.c                | 28 +++++++++++++++++++++++++
> >  drivers/usb/host/xhci-plat.c            | 20 ++++++++++++++++++
> >  include/linux/usb.h                     |  4 ++++
> >  5 files changed, 80 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/AB=
I/testing/sysfs-bus-usb
> > index 2b7108e21977..3f3d6c14201f 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-usb
> > +++ b/Documentation/ABI/testing/sysfs-bus-usb
> > @@ -19,6 +19,16 @@ Description:
> >               would be authorized by default.
> >               The value can be 1 or 0. It's by default 1.
> >
> > +What:                /sys/bus/usb/devices/usbX/deprecate_device_pm
> > +Date:                January 2024
> > +Contact:     Guan-Yu Lin <guanyulin@google.com>
> > +Description:
> > +             Deprecates the device power management functionality of U=
SB devices
> > +             and their host contorller under this usb bus. The modific=
ation of
> > +             this entry should be done when the system is active to en=
sure the
> > +             correctness of system power state transitions.
> > +             The value can be 1 or 0. It's by default 0.
> > +
> >  What:                /sys/bus/usb/device/.../authorized
> >  Date:                July 2008
> >  KernelVersion:       2.6.26
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index e02ba15f6e34..e03cf972160d 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -1569,6 +1569,15 @@ int usb_suspend(struct device *dev, pm_message_t=
 msg)
> >       struct usb_device       *udev =3D to_usb_device(dev);
> >       int r;
> >
> > +     /*
> > +      * Skip the entire suspend process under the same usb bus if its =
sysfs
> > +      * entry `deprecate_device_pm` is set.
> > +      */
> > +     if (udev->bus->deprecate_device_pm) {
> > +             dev_vdbg(&udev->dev, "deprecating dev_pm_ops: %s\n", __fu=
nc__);
>
> Nit, dev_dbg() already contains __func__ by default, so no need for that
> at all.  And please use dev_dbg(), why are you using dev_vdbg()?
>
Thanks for the suggestion. I'll change it to dev_dbg() in the next version.
>
> > +             return 0;
> > +     }
> > +
> >       unbind_no_pm_drivers_interfaces(udev);
> >
> >       /* From now on we are sure all drivers support suspend/resume
> > @@ -1605,6 +1614,15 @@ int usb_resume(struct device *dev, pm_message_t =
msg)
> >       struct usb_device       *udev =3D to_usb_device(dev);
> >       int                     status;
> >
> > +     /*
> > +      * Skip the entire resume process under the same usb bus if its s=
ysfs
> > +      * entry `deprecate_device_pm` is set.
> > +      */
> > +     if (udev->bus->deprecate_device_pm) {
> > +             dev_vdbg(&udev->dev, "deprecating dev_pm_ops: %s\n", __fu=
nc__);
>
> Same as above.  And for all other instances you added.
>
> > +static ssize_t deprecate_device_pm_store(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      const char *buf, size_t count)
> > +{
> > +     struct usb_device       *udev =3D to_usb_device(dev);
> > +     int                     val, rc;
> > +
> > +     if (sscanf(buf, "%d", &val) !=3D 1 || val < 0 || val > 1)
> > +             return -EINVAL;
>
> Please use the builtin function for determining if a boolean has been
> written through sysfs, don't roll your own.
>
Thanks for the advice. I'll use kstrtobool() in the next version. In additi=
on,
I'll prepare another patch to update other self-rolled implementations.
>
> Note, these are just cosmetic things, I'm not taking the time yet to
> comment on the contents here, I'll let others do that first :)
>
> thanks,
>
> greg k-h

