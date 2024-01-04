Return-Path: <linux-kernel+bounces-16988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 202A78246E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CE31F239AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1201B25578;
	Thu,  4 Jan 2024 17:11:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB7E25562;
	Thu,  4 Jan 2024 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59614694ca2so104632eaf.1;
        Thu, 04 Jan 2024 09:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704388300; x=1704993100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhZv6WKE21ijDjkX//WJHcBwftHQ98gnRwrr5hSH+/g=;
        b=k46nqwfpEj7Ci8klWm4VWhhmPO6rWy15OQnLEcgWyyfkHFHEtcSGS8hkTjsHa5qhdi
         vgagpzbpC0ksCMzFRkinZs9bhHQyEdfgIHT+cQVjJkPZ8wwGT0ydjs+CHcZLNW5w81z0
         TxFylD171NjkSw0yl9AX2VEl4P3uU7+ROsay4tvehndyI9DKO9wkHYE8c+qpRwqXSO9t
         uFlwnz+1GBjEdUDWH13MF1+0izwrXhdL0MVT8oaeKWtwvC9G+v/EvJkycQ5o5nTGqvJx
         A+kGahCwf9Zq50k+OZCQDYKT7rayfZq1M2p8AcBOgYJzQzse6AuSGkkE53vANo8mUpxo
         a48w==
X-Gm-Message-State: AOJu0YxWJ4cnE3P1ul5y6hGABucurm3lFtyl3MD75W6iRJwMd0uuQY7z
	ZP8a8EZ9pYM9qRykdUowFHTWWUbgWwAi63Jc2aU=
X-Google-Smtp-Source: AGHT+IFEEFQaBzfWwAvTtOe/ABYhj0GW7g/hP6FBd9e54ozQGSs863YGil9cJ11drqzai3yQoGhWif48Sqz5xsSQfFA=
X-Received: by 2002:a4a:e70a:0:b0:596:27ee:455d with SMTP id
 y10-20020a4ae70a000000b0059627ee455dmr1544834oou.0.1704388300249; Thu, 04 Jan
 2024 09:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024819.848979-1-kai.heng.feng@canonical.com>
 <CAJZ5v0gNa7XvUo3B1srXaWBrWx+Bx=w=D7ddi-mqda8xBdWwCQ@mail.gmail.com> <ZZbR4X6z9wkSESzD@mail.minyard.net>
In-Reply-To: <ZZbR4X6z9wkSESzD@mail.minyard.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 18:11:29 +0100
Message-ID: <CAJZ5v0ibP7Kn1SgY2QK+7Ky_d0UjKG3CpG+hH+cEaCRG4EdDVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: IPMI: Add helper to wait for when SMI is selected
To: minyard@acm.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, jdelvare@suse.com, 
	linux@roeck-us.net, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:42=E2=80=AFPM Corey Minyard <minyard@acm.org> wrot=
e:
>
> On Thu, Jan 04, 2024 at 02:34:52PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 4, 2024 at 3:48=E2=80=AFAM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > The function of acpi_power_meter module on Dell system requires IPMI
> > > handler is installed and SMI is selected.
> >
> > Does the firmware use _DEP to let the OS know about this dependency?
> >
> > > So add a helper to let acpi_power_meter know when IPMI handler and SM=
I
> > > are ready.
> > >
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > v3:
> > >  - New patch.
> > >
> > >  drivers/acpi/acpi_ipmi.c | 17 ++++++++++++++++-
> > >  include/acpi/acpi_bus.h  |  5 +++++
> > >  2 files changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> > > index 0555f68c2dfd..54862cab7171 100644
> > > --- a/drivers/acpi/acpi_ipmi.c
> > > +++ b/drivers/acpi/acpi_ipmi.c
> > > @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
> > >  #define IPMI_TIMEOUT                   (5000)
> > >  #define ACPI_IPMI_MAX_MSG_LENGTH       64
> > >
> > > +static struct completion smi_selected;
> > > +
> > >  struct acpi_ipmi_device {
> > >         /* the device list attached to driver_data.ipmi_devices */
> > >         struct list_head head;
> > > @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct =
device *dev)
> > >                 if (temp->handle =3D=3D handle)
> > >                         goto err_lock;
> > >         }
> > > -       if (!driver_data.selected_smi)
> > > +       if (!driver_data.selected_smi) {
> > >                 driver_data.selected_smi =3D ipmi_device;
> > > +               complete(&smi_selected);
> > > +       }
> > >         list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
> > >         mutex_unlock(&driver_data.ipmi_lock);
> > >
> > > @@ -578,10 +582,21 @@ acpi_ipmi_space_handler(u32 function, acpi_phys=
ical_address address,
> > >         return status;
> > >  }
> > >
> > > +int acpi_wait_for_acpi_ipmi(void)
> > > +{
> > > +       long ret;
> > > +
> > > +       ret =3D wait_for_completion_interruptible_timeout(&smi_select=
ed, 2 * HZ);
> > > +
> > > +       return ret > 0 ? 0 : -ETIMEDOUT;
> >
> > What will happen if the IPMI driver is unloaded after this has returned=
 0?
>
> The IPMI driver can't be unloaded if it has a user.

Because of the use of the exported symbol, right?

> I've been following this, but I know little about ACPI.  Beyond this
> solution, the only other solution I could come up with was to start the
> IPMI driver earlier.  But then you are in a chicken-and-egg situation
> (https://dictionary.cambridge.org/dictionary/english/chicken-and-egg-situ=
ation).
> Which was the reason for the SPMI table, but that's really kind of
> useless for this, even if the SPMI table existed.

Fine.

Let me reply to the patch with some more comments then.

