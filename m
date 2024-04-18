Return-Path: <linux-kernel+bounces-149648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D338A93F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832831F214DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CDF54BE2;
	Thu, 18 Apr 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjWkmSy9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8F4EB45
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424997; cv=none; b=ejB/fRoGRmj7YpA6MKTeLnk2VCSTphOM1N9EfRxRaUMM6Bnx4X9AH5fU3lvjA9P9GMHPQbvwe+u185tx9wuSXdmuULDrRE8uNxBoCzYfS9jHOsdziawxhCz49nkMX1dZkifpREab30rFpnnWr6erK7Ig80WHdlY1K+edr/bOza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424997; c=relaxed/simple;
	bh=vgK0r6JlkgRyVng0vK7xeA2Mb4CDysk3xJwerY7ubwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr6TclnZyvmf2wWUtlN2TihNFJkkg/Bvk0zAd4UgUncRp/G2ZNHBu3tMHbY1LGt5/YzAfJ+99BpT+U+hKWd/YjwG3KNR6r6m+ee7e7WFhXMmkJ1bCwZuGZocFnGk/usBLeqayrga7GovD60fMgEhMgkIxtdfbSIxaje4iKTrsj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjWkmSy9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713424994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVEgCUNH2+ucbxNW8o7LrLo4xbai7FQO2lfQoIgrFHE=;
	b=VjWkmSy98uksvOUNsnMKbFST6OeSILuBcps5/SE93pbDU/3S14T6X9Kyiz0+QfDHH4OL6z
	UGaga6DBNSGltfxuYJZptA5lPURORWJN3w1M3UcbDpVwBmBOy2sQIQYIR7gD7v2q2f8MJW
	387TGLWRtYvhlhgT6WvR+Hhov4JWavQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-bx_d_xSiPeeKetv2ovdnDQ-1; Thu, 18 Apr 2024 03:23:13 -0400
X-MC-Unique: bx_d_xSiPeeKetv2ovdnDQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6edddd0375fso688193b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713424991; x=1714029791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVEgCUNH2+ucbxNW8o7LrLo4xbai7FQO2lfQoIgrFHE=;
        b=vRb1OTiKgc9/FWVRSqKG+OL7NJzjO+3m+dCL7Sh9r1lH8IybN8VhV9eJuejNm30e3f
         kbIgjmUOyiih1APsn9kJG3bUmLTbfIadgpkucDafZr7a39HNR8oOolUocFvecIVSeizj
         +1a+/okKK4hbd71d1ibJDJLqkhqh7P9gVpCXCHSbcU1569XLFlMubUptbWONRwoNYWwp
         2XU48W/nFc9082xmbK1aCso7/MC5hu2ZpExy5kW0SZHn1x/MvpVt2SwD/I3zwvRme1Qm
         PO9Ab1/iziVgBAVSR9pMXxQ2PvgQjoRcMvHtAABFW/nsi7KGo4pRYAiDefP7yk8uY4Yf
         +jOg==
X-Forwarded-Encrypted: i=1; AJvYcCVTxYFa0pJXneqEoLaruBcS+KtkkpPVnXZ+5Fj/IKwVAfprBe6gtSNOTBfMU4VPvTeP1xHSoeRMf51ICI4yKC+jWdwr2dDeIwdE29eA
X-Gm-Message-State: AOJu0Yz+RWmNAzpo7OSD6yawFPVRE9L6iMdbvHpLot/S/wjGY1LQsjje
	6FXRymebcd1VDT2xzKPdgrWT5NIUrAeUBCvbPB5NKAuJlYlWe/9lqoWhOnjVjf7j3FsWWg9o/if
	vYPXfZS0lCerOR04AsRG5kjrxlqkCnzgXJLMBDKHOMKUEYpfRUE+LGN/iw5IG0ZWE0z4O/My8z2
	DuXApkrUp8SYKf7TycCewmgomVmKw5Be9L7ynq
X-Received: by 2002:a05:6a21:999b:b0:1aa:66ad:6094 with SMTP id ve27-20020a056a21999b00b001aa66ad6094mr2646451pzb.8.1713424990633;
        Thu, 18 Apr 2024 00:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb6KDSdMbWA5pEE2/RfPBEDrTWyeMJrakgp6Dj7adISR0wr3x3K1kxRaRUXVxLHPRcarcIGEu4VMy3oL4mikE=
X-Received: by 2002:a05:6a21:999b:b0:1aa:66ad:6094 with SMTP id
 ve27-20020a056a21999b00b001aa66ad6094mr2646428pzb.8.1713424990300; Thu, 18
 Apr 2024 00:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416053909.256319-1-hpa@redhat.com> <20240416053909.256319-3-hpa@redhat.com>
 <CAHp75Vdw6gCN=45iRdKcm=qT07Z90+z6Cw=inYR+C6+5gML+_Q@mail.gmail.com>
In-Reply-To: <CAHp75Vdw6gCN=45iRdKcm=qT07Z90+z6Cw=inYR+C6+5gML+_Q@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Thu, 18 Apr 2024 15:22:59 +0800
Message-ID: <CAEth8oHx66Q8esGNNgXnOOT2RJXTFMAo3RJPLHDYh9oewxJKxQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] leds: rgb: leds-ktd202x: Get device properties
 through fwnode to support ACPI
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for reviewing.

On Wed, Apr 17, 2024 at 1:29=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Apr 16, 2024 at 8:39=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote=
:
> >
> > This LED controller is installed on a Xiaomi pad2 and it is an x86
> > platform. The original driver is based on the device tree and can't be
> > used for this ACPI based system. This patch migrated the driver to use
> > fwnode to access the properties. Moreover, the fwnode API supports the
> > device tree so this work won't affect the original implementations.
>
> ...
>
> > -       int num_channels;
> > +       int num_channels =3D 0;
>
> Split this assignment, so...
>
> >         int i =3D 0;
>
> > -       num_channels =3D of_get_available_child_count(np);
>
> ...it become
>
>   num_channels =3D 0;
>
> here.
>
> > +       fwnode_for_each_available_child_node(fwnode, child)
> > +               num_channels++;
>

It will look like this:
       num_channels =3D 0;
       fwnode_for_each_available_child_node(fwnode, child)
              num_channels++;

> ...
>
> > -static int ktd202x_add_led(struct ktd202x *chip, struct device_node *n=
p, unsigned int index)
> > +static int ktd202x_add_led(struct ktd202x *chip,
> > +                          struct fwnode_handle *fwnode,
> > +                          unsigned int index)
>
> Why split over 3 lines? I believe it can be still two or one
> (depending if you use a relaxed limit).

Make it to be one line.

>
> ...
>
> >  static int ktd202x_probe_dt(struct ktd202x *chip)
>
> Perhaps you want to rename this to something like ktd202x_probe_fw().

Sounds good.

>
> ...
>
> > +       fwnode =3D dev_fwnode(dev);
>
> Will be no use if the bellow applied, right?

Right. It can be dropped.

>
> ...
>
> > -       for_each_available_child_of_node(np, child) {
> > +       fwnode_for_each_available_child_node(fwnode, child) {
>
> Use device_for_each_child_node() instead.

Okay.

>
> >         }
>
> ...
>
> > -       .shutdown =3D ktd202x_shutdown,
> > +       .shutdown =3D ktd202x_shutdown
>
> Stray change.

I know the reason  :)

>
> --
> With Best Regards,
> Andy Shevchenko
>


--=20
BR,
Kate


