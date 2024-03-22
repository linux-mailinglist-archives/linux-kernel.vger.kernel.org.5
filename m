Return-Path: <linux-kernel+bounces-110965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B9A88665F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4ADF1C23650
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12FB663;
	Fri, 22 Mar 2024 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0R5xp09"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477EFBA3F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086314; cv=none; b=M9Kd8jkKbdaST9rm+bkqGUcfDLcvo9u/EFfyna+ludPoIizc8gw9WtOagpE0SjZN5GcgD/PcLHOaJtIFnEPG2crFmfwycdH16Y9S4o5ZfOYkFMlPvePeX6Ou5SF3w+qRqfenIA9ZG6KHRXZrQCnj0Zwv8T0zEu4L0U7jW1GIxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086314; c=relaxed/simple;
	bh=b4UeU92r62bIY8HhL/ow3jMfrvwN8JSL7OEhfPL5vDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofEcBRitEH7L/Hw/pGn1dyOANEk7SMBQY6Sl0y0pfDKGzB9HxJqhptA0yEAIQmSnI4D2jvSAe1DcbArUObp+ZXdTbIjzlzp/nbkpsNf5pYynAH5tPOLqAaZtdptjvZr6rNqNZwBDsler89MqSbyDhk6iQwSn+g0fa1DgZzcVKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0R5xp09; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711086312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2v9+xfia68QeoWpLPgvZTLinBR+rs9FvXTVbndoolI0=;
	b=J0R5xp090oweD5Y/nxjkq9OBeYkAUxo7ZhVbefmID/Jp6I+Oq5r07QIS+1gESq4Q1Ax8Zk
	t6jqa1DzQ+MKNX9v/a2PysEgFlf/YKMkEgUGdjNdRg1nqTtGUp3Hh6iwDrGHkGDmVrKss0
	g56+HM69EyFHkI6s0D5jV+zs4et1I/0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-ghOdygkuO3OpXStypkHlmw-1; Fri, 22 Mar 2024 01:45:07 -0400
X-MC-Unique: ghOdygkuO3OpXStypkHlmw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c37ea11ef3so1712066b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711086306; x=1711691106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v9+xfia68QeoWpLPgvZTLinBR+rs9FvXTVbndoolI0=;
        b=Niy5MCwevKTDgjmu7eLuFPkJnLWsH16ZOF/hB/sXd7F8MIcFaT3eVesJ/ptoPBk0j6
         a3MmBX61Ya4Q+cSZRhzb12TSzxpjVcHbm6qWJujBW/WlwyIw0Q//wg1ttvfLU7rMnHHp
         P9eu7V9v7P3hd3UKDrtVpLxo0HAtDxn1v8t7HIt/Do3k9xbqOOFXrNhClcoLNmFYaKsG
         UbxVf8SiSpZBuMIN0lsG2AoHkBQA4DO5fsDBlgc4yIrEk1qRR0XEqszLsp12VWWO4rre
         kUkz95SozLAfX1VeJxIbUPpVtNjeaPRIUg4e1W2W3j33QqaL6Z4xFRgcd7h0bOPhMWLo
         l4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHqwWeoDS62QuRi+IW/bHlO7JgRYJGaTG188hlwTIdruBwqHoboQ8jT5Uem5Yio4kecGjrrKss5fJJni3LDcfD7wN46Ppf//z6NLVd
X-Gm-Message-State: AOJu0Yys57PtOFGr/t7kyr6HNzL/S7dL1ckuH2EWQ8omcOSJPS5oA+KX
	tAFGzspBQcP6CBXR5BKtdkkT54NP7m0N9eQK/NTFn4ozT8723xh7VN1I6kKw+Uk4+bbOQEEs8Og
	Mz9/Xe+nmYoe9NY2lVTL1yrs1jmOWU9Jdu0ud/RcSuxLWr5KPmMNAN+cSeTkL3CVxTNcFSnuWfb
	iKkkUaUi+LVpc2WmajbmnWYJ4rOa0zJtEsyLtS
X-Received: by 2002:a05:6808:16a2:b0:3c1:7eac:a8a8 with SMTP id bb34-20020a05680816a200b003c17eaca8a8mr1460927oib.26.1711086306431;
        Thu, 21 Mar 2024 22:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjP042aRQsdUdB9ehHITlv37xk5alHFWxpQm2MqNv8pk9MTzqxxtDhf60Pr2uz0kgKfHbuG+XxWZGNk/DWcmk=
X-Received: by 2002:a05:6808:16a2:b0:3c1:7eac:a8a8 with SMTP id
 bb34-20020a05680816a200b003c17eaca8a8mr1460912oib.26.1711086306145; Thu, 21
 Mar 2024 22:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306025801.8814-1-hpa@redhat.com> <20240306025801.8814-3-hpa@redhat.com>
 <Ze-N_y5Tbjc93aRp@surfacebook.localdomain>
In-Reply-To: <Ze-N_y5Tbjc93aRp@surfacebook.localdomain>
From: Kate Hsuan <hpa@redhat.com>
Date: Fri, 22 Mar 2024 13:44:54 +0800
Message-ID: <CAEth8oEdzomdn5avXf44HXpoMFDfGpOjjxPFtaGkh0EhfZsPMQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] leds: rgb: leds-ktd202x: Get device properties
 through fwnode to support ACPI
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Thank you for reviewing.

On Tue, Mar 12, 2024 at 7:04=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Wed, Mar 06, 2024 at 10:58:01AM +0800, Kate Hsuan kirjoitti:
> > This LED controller also installed on a Xiaomi pad2 and it is a x86
> > platform. The original driver is based on device tree and can't be
> > used for this ACPI based system. This patch migrated the driver to
> > use fwnode to access the properties. Moreover, the fwnode API
> > supports device tree so this work won't effect the original
> > implementations.
>
> ...
>
> > +     fwnode_for_each_available_child_node(np, child) {
>
> Please, rename np to fwnode to avoid confusion.
>
> > +             num_channels++;
> > +     }
>
> ...
>
> > -     for_each_available_child_of_node(np, child) {
> > +     fwnode_for_each_available_child_node(np, child) {
> >               u32 mono_color;
> >               u32 reg;
> >               int ret;
> >
> > -             ret =3D of_property_read_u32(child, "reg", &reg);
> > +             ret =3D fwnode_property_read_u32(child, "reg", &reg);
> >               if (ret !=3D 0 || reg >=3D chip->num_leds) {
> >                       dev_err(chip->dev, "invalid 'reg' of %pOFn\n", ch=
ild);
>
> Must be %pfw now.
>
> > -                     of_node_put(child);
> > +                     fwnode_handle_put(child);
>
> >                       return -EINVAL;
>
> Side note: This shouldn't shadow error code when ret !=3D 0.
>
> >               }
>
> ...
>
> > -             ret =3D of_property_read_u32(child, "color", &mono_color)=
;
> > +             ret =3D fwnode_property_read_u32(child, "color", &mono_co=
lor);
> >               if (ret < 0 && ret !=3D -EINVAL) {
> >                       dev_err(chip->dev, "failed to parse 'color' of %p=
OF\n", child);
>
> Must be %pfw now.
>
> > -                     of_node_put(child);
> > +                     fwnode_handle_put(child);
> >                       return ret;
> >               }
>
> ...
>
> > -     ret =3D of_property_read_u32(np, "reg", &reg);
> > +     ret =3D fwnode_property_read_u32(np, "reg", &reg);
> >       if (ret !=3D 0 || reg >=3D chip->num_leds) {
> >               dev_err(chip->dev, "invalid 'reg' of %pOFn\n", np);
>
> Must be %pfw now.
>
> >               return -EINVAL;
>
> >       /* Color property is optional in single color case */
> > -     ret =3D of_property_read_u32(np, "color", &color);
> > +     ret =3D fwnode_property_read_u32(np, "color", &color);
> >       if (ret < 0 && ret !=3D -EINVAL) {
> >               dev_err(chip->dev, "failed to parse 'color' of %pOF\n", n=
p);
>
> Must be %pfw now.
>
> >               return ret;
> >       }
>
> ...
>
> > +     struct fwnode_handle *child, *np;
>
> Do not use np for sturct fwnode_handle. It will be quite confusing.
>
> ...
>
> > -     chip->num_leds =3D (int)(unsigned long)of_device_get_match_data(c=
hip->dev);
> > +     count =3D device_get_child_node_count(dev);
>
> >
>
> Redundant blank line.
>
> > -     count =3D of_get_available_child_count(np);
> >       if (!count || count > chip->num_leds)
> >               return -EINVAL;
>
> ...
>
> > +     chip->num_leds =3D (unsigned long)i2c_get_match_data(client);
>
> No warnings during compilation?
Yes, the compiler doesn't complain about it.

>
> ...
>
> > +static const struct i2c_device_id ktd202x_id[] =3D {
> > +     {"ktd2026", KTD2026_NUM_LEDS},
> > +     {"ktd2027", KTD2027_NUM_LEDS},
> > +     {},
>
> N ocomma for the terminator entry.
>
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ktd202x_id);
>
> ...
>
> > +#ifndef CONFIG_ACPI
>
> Please, no. Drop them.
Okay, I've dropped them in v5 patch.

>
> >  static const struct of_device_id ktd202x_match_table[] =3D {
> >       { .compatible =3D "kinetic,ktd2026", .data =3D (void *)KTD2026_NU=
M_LEDS },
> >       { .compatible =3D "kinetic,ktd2027", .data =3D (void *)KTD2027_NU=
M_LEDS },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, ktd202x_match_table);
> > +#endif
> >
> >  static struct i2c_driver ktd202x_driver =3D {
> >       .driver =3D {
> >               .name =3D "leds-ktd202x",
> > +#ifndef CONFIG_ACPI
> >               .of_match_table =3D ktd202x_match_table,
> > +#endif
>
> This is quite unusual besides being ugly.
>
> >       },
> >       .probe =3D ktd202x_probe,
> >       .remove =3D ktd202x_remove,
> >       .shutdown =3D ktd202x_shutdown,
> > +     .id_table =3D ktd202x_id,
> >  };
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
BR,
Kate


