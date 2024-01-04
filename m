Return-Path: <linux-kernel+bounces-16869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA74C824532
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1061C221D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885024219;
	Thu,  4 Jan 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwtHzFyx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E12420A;
	Thu,  4 Jan 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bb69bfdd96so630850b6e.1;
        Thu, 04 Jan 2024 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704382947; x=1704987747; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5oMiGZMowUzqMWGwhCBfkbKcvKR9HrULZLN+Y7bf4S0=;
        b=ZwtHzFyx+IB3zt4jqUgNXfHgIR25r50eTXw5oPyoQ5Eoz7NGyWPDXK1FiiLEAYr6OC
         96vFQIb++EO4xp1IzCHWJoc5NTo4Svfiv379UqzGwK1IRAN9r2cZkhdV5KSEvflRm2Mn
         9l+wk2Z+RYB3MPRgSiyTSjbz4ETnQzNlmmZ/9Kt0gbcF16rLG5BMHi+KXOkAx1GoKxg/
         Jld/o1Zy0zZJoKreJg7tYJRWt90kB5sSnCn68JbSF3zRiVqhJwrFZ15clzRqTNWkJK6K
         o+Qz235IfuqFubBfJQ6/CYXEFkSbNUAfNJJg6u+PGCEfFb3Gx0C+ejVFALHi6DBpTHJa
         4VHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704382947; x=1704987747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oMiGZMowUzqMWGwhCBfkbKcvKR9HrULZLN+Y7bf4S0=;
        b=Y2Y7bQ+x/5pEIQM+439iB9MCs/vk4eDpzitqTswGHYa1IYmeCNSfCP/n9J3nuKJQBZ
         R4ULaQGvWngA4yQ2uwu6562bg6pw0oBTR3Uoest3Tb1zsTBbf33vPgcYDz7NabMXnZW1
         dAaVoOe29J5ObdW+DubONF3j8TmlbxJhAVKZbjAZ2sm4HArgNJlXffG/Rul+HvcrWVJ5
         nHGdUz6ZrQW+96SdUs/A07n+EpFJKOvvB4KcGqrEkFG/9Px5bDwJQTozuiepTOLZS1Z/
         F8+JmlnP4aGKP2IoQ/W5fxCCx2zv/JnIjaFCL7HpFIdBt+aRr0yE9wUodIhP/bxbXPYF
         FYdQ==
X-Gm-Message-State: AOJu0YzggIvwy+1pLzUBPGfdmAXd49hG9LrouozTM9zSq0EkN48/q4Ok
	OGwGeuI95jRgsMHSA5cEEw==
X-Google-Smtp-Source: AGHT+IGBVcQOehWgZgtVkqUEVkpT4ymFf47CPxuZ3r/zwB3M65lL8wGjFXR+faDYn1CyfX3tGNuADA==
X-Received: by 2002:a05:6808:1401:b0:3bc:23ca:b8f8 with SMTP id w1-20020a056808140100b003bc23cab8f8mr293904oiv.27.1704382947589;
        Thu, 04 Jan 2024 07:42:27 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id ct6-20020a056808360600b003bbcc7ad593sm2208336oib.34.2024.01.04.07.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:42:27 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:45b4:3a91:698e])
	by serve.minyard.net (Postfix) with ESMTPSA id 754301800BC;
	Thu,  4 Jan 2024 15:42:26 +0000 (UTC)
Date: Thu, 4 Jan 2024 09:42:25 -0600
From: Corey Minyard <minyard@acm.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, jdelvare@suse.com,
	linux@roeck-us.net, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/2] ACPI: IPMI: Add helper to wait for when SMI is
 selected
Message-ID: <ZZbR4X6z9wkSESzD@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20240104024819.848979-1-kai.heng.feng@canonical.com>
 <CAJZ5v0gNa7XvUo3B1srXaWBrWx+Bx=w=D7ddi-mqda8xBdWwCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gNa7XvUo3B1srXaWBrWx+Bx=w=D7ddi-mqda8xBdWwCQ@mail.gmail.com>

On Thu, Jan 04, 2024 at 02:34:52PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 4, 2024 at 3:48 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > The function of acpi_power_meter module on Dell system requires IPMI
> > handler is installed and SMI is selected.
> 
> Does the firmware use _DEP to let the OS know about this dependency?
> 
> > So add a helper to let acpi_power_meter know when IPMI handler and SMI
> > are ready.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >  - New patch.
> >
> >  drivers/acpi/acpi_ipmi.c | 17 ++++++++++++++++-
> >  include/acpi/acpi_bus.h  |  5 +++++
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> > index 0555f68c2dfd..54862cab7171 100644
> > --- a/drivers/acpi/acpi_ipmi.c
> > +++ b/drivers/acpi/acpi_ipmi.c
> > @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
> >  #define IPMI_TIMEOUT                   (5000)
> >  #define ACPI_IPMI_MAX_MSG_LENGTH       64
> >
> > +static struct completion smi_selected;
> > +
> >  struct acpi_ipmi_device {
> >         /* the device list attached to driver_data.ipmi_devices */
> >         struct list_head head;
> > @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct device *dev)
> >                 if (temp->handle == handle)
> >                         goto err_lock;
> >         }
> > -       if (!driver_data.selected_smi)
> > +       if (!driver_data.selected_smi) {
> >                 driver_data.selected_smi = ipmi_device;
> > +               complete(&smi_selected);
> > +       }
> >         list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
> >         mutex_unlock(&driver_data.ipmi_lock);
> >
> > @@ -578,10 +582,21 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
> >         return status;
> >  }
> >
> > +int acpi_wait_for_acpi_ipmi(void)
> > +{
> > +       long ret;
> > +
> > +       ret = wait_for_completion_interruptible_timeout(&smi_selected, 2 * HZ);
> > +
> > +       return ret > 0 ? 0 : -ETIMEDOUT;
> 
> What will happen if the IPMI driver is unloaded after this has returned 0?

The IPMI driver can't be unloaded if it has a user.

I've been following this, but I know little about ACPI.  Beyond this
solution, the only other solution I could come up with was to start the
IPMI driver earlier.  But then you are in a chicken-and-egg situation
(https://dictionary.cambridge.org/dictionary/english/chicken-and-egg-situation).
Which was the reason for the SPMI table, but that's really kind of
useless for this, even if the SPMI table existed.

-corey

> 
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_wait_for_acpi_ipmi);
> > +
> >  static int __init acpi_ipmi_init(void)
> >  {
> >         int result;
> >         acpi_status status;
> > +       init_completion(&smi_selected);
> >
> >         if (acpi_disabled)
> >                 return 0;
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 1216d72c650f..afa6e4d4bf46 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -821,11 +821,16 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
> >  {
> >         acpi_dev_put(adev);
> >  }
> > +
> > +int acpi_wait_for_acpi_ipmi(void);
> > +
> >  #else  /* CONFIG_ACPI */
> >
> >  static inline int register_acpi_bus_type(void *bus) { return 0; }
> >  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> >
> > +static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> > +
> >  #endif                         /* CONFIG_ACPI */
> >
> >  #endif /*__ACPI_BUS_H__*/
> > --
> 

