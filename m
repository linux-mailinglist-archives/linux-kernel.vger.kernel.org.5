Return-Path: <linux-kernel+bounces-120400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211F88D6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0F01F2B42D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE2923754;
	Wed, 27 Mar 2024 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0SS72bW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867021DA20
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522422; cv=none; b=qLnrCqmQBFTDcLt9MY5Wrykh60Pl+NsBVC/wY0uitIcNHtkkZPboXzECQ0SpamZdjFM31qF0AG0ZBQ2GtcgDgvTRTwNlpEshUoufSq1JeGw5SNHgH/UfYNIJm6jTfKa+svH7cnhwI4KQPdhraVWMtxW3Aw1SiIlVg+PIoOEEoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522422; c=relaxed/simple;
	bh=W6RLXUxCHDJY3w70KCqWzO6oGutZMiRq4O8XdSmVm20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dh4WBw3/PCtur8hgiFHRVYvjEhY2isuP/gu5NxfsBL2D9smw+bO/rFp/nry+xGLUbqTSq6DE0gAMXYHDS4e52jJ2JKEj7jMvkJRqAQv8K+C9Qv7JVNw4Oyzyw77SddgwqJdXLnYCXvAMRj10e9DuBN6AX6s9Vgqtc5PHqJse+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0SS72bW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711522419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjyCvIB6syQyBLc/PURAesFgBPIAm7ixXYus2PqXUv8=;
	b=d0SS72bWPQ6p8uDLVNkl76IrCgbpiRyERUKlX3HrmhNHwvQpWzzGf4Pm2e9KIdBtV7zc5O
	EcFirHixjSYZ5RTnpTW3y2DZnI6C/2Ha3mm1Bt2zrecSux/4mOQrprtlxJhjlR12N/ibqj
	6Pq9eaPJhpzq0yMeq2fjRZLtml5Wny0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-Buj1WRQCOpmhvEPIiwmKhQ-1; Wed, 27 Mar 2024 02:53:38 -0400
X-MC-Unique: Buj1WRQCOpmhvEPIiwmKhQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5e4f312a995so3008713a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711522416; x=1712127216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjyCvIB6syQyBLc/PURAesFgBPIAm7ixXYus2PqXUv8=;
        b=sVHi0j/z4nUMYE+3W9tYIwTJ2nSEaoMPJkScHUpSOgpMSqmdDK8/IDmTPk3LwRQsYj
         yPq5YhoydeFZ9hF+CE82PqclLO5co8ZbfES4aVRJhXRXH2kgXHOQoXpUyL14mwHDVuEH
         r8b0BSotGCins6yPLg6bDvbGxXpXsVvpPLwZFTP1z6Ga1Ir7IntQih4KmuYNGOrJfdBv
         9eTETVYSijTiFehrDhufMfFBMIwCFRVPMR9u297ksOov3HEWaTVILxi9OTQR1sTTYvvr
         qEpXVASdxg7d7QpdimdqFXPq6lWwKeoUFlwjO12fX67cc8nH0AhkN4ti6EghslyKuCSR
         9cvw==
X-Forwarded-Encrypted: i=1; AJvYcCXXgM4RAnUWiUnm73ZxNoPpElYLZAmfOF5fKtKEbr3puuaF/s6Y4+AroyVo6vt9gclKjmQsGhcekI/y4HV4xzcAp4GaS4mBQhiwA16p
X-Gm-Message-State: AOJu0Yw9Y9WWbrD1uEz2s8ceoRJhnCFE7Faa34GK4mXRaKMOrNPaO0mC
	COAyDQ4WxUoHbTiJPVVoyhb8UD0M7wypw9EFIUIE6RrH5uouJzBTiWfbZkJTykaY6s+pQeZ0E93
	5/xbARto7JsTWIp+bS/RaR/sWbmuEXDudEVsOwQQMvyi8uMbflcqo7RFz3geREdGhAyDc4UdMEq
	3QANe8tzJBuFqBqIPh4KzZSBQxM35dOesJ13wyvnv8z8A4lvQ=
X-Received: by 2002:a05:6a21:339c:b0:1a3:8904:1fc9 with SMTP id yy28-20020a056a21339c00b001a389041fc9mr3637951pzb.41.1711522416608;
        Tue, 26 Mar 2024 23:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE92cxDxgpu4LIAd0jfCXzzTSPP16EKFP9ZwNdIoRwWxtFgYT4c5S27JpSdRV4WKq/fyTzRxyP70R1xOrLebfs=
X-Received: by 2002:a05:6a21:339c:b0:1a3:8904:1fc9 with SMTP id
 yy28-20020a056a21339c00b001a389041fc9mr3637931pzb.41.1711522416229; Tue, 26
 Mar 2024 23:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-3-hpa@redhat.com>
 <CAHp75VdosbYNKU90QWt+6SU_i5dWC94=xZy0GXiKvoQeDF30wg@mail.gmail.com>
In-Reply-To: <CAHp75VdosbYNKU90QWt+6SU_i5dWC94=xZy0GXiKvoQeDF30wg@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Wed, 27 Mar 2024 14:53:24 +0800
Message-ID: <CAEth8oFuPTRq0z-YbMMFt=kKgre6x+bDhtpUkj2vJeK-u8O72A@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 2/6] leds: rgb: leds-ktd202x: Get device
 properties through fwnode to support ACPI
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for reviewing it.

On Mon, Mar 25, 2024 at 3:57=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> wrote=
:
> >
> > This LED controller also installed on a Xiaomi pad2 and it is a x86
> > platform. The original driver is based on device tree and can't be
>
> the device
>
> > used for this ACPI based system. This patch migrated the driver to
> > use fwnode to access the properties. Moreover, the fwnode API
> > supports device tree so this work won't effect the original
>
> affect
>
> > implementations.
>
> ...
>
> > +       fwnode_for_each_available_child_node(fwnode, child) {
> > +               num_channels++;
> > +       }
>
> {} are not needed.
>
> >         if (!num_channels || num_channels > chip->num_leds)
> >                 return -EINVAL;
>
> ...
>
> > +static int ktd202x_add_led(struct ktd202x *chip,
> > +                          struct fwnode_handle *fwnode_color,
>
> Can it be simply fwnode? (Originally it was np, so I assume there is
> no name collision)
It can be. I'll revise this.

>
> ...
>
> > +       count =3D device_get_child_node_count(dev);
> >         if (!count || count > chip->num_leds)
> >                 return -EINVAL;
>
> > +       fwnode =3D dev_fwnode(chip->dev);
>
> Why not dev?
I'll use dev. I had declared it.

>
> > +       if (!fwnode)
> > +               return -ENODEV;
>
> This is dead code. Please remove these three lines.

Okay.

>
> ...
>
> > +       .id_table =3D ktd202x_id,
>
> Seems to me that you may split the I=C2=B2C ID table addition into a sepa=
rate change.

Could you please describe this more clearly? Thank you

>
> --
> With Best Regards,
> Andy Shevchenko
>

I'll propose the v6 patch according to your comments.


--=20
BR,
Kate


