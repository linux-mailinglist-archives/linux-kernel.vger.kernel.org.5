Return-Path: <linux-kernel+bounces-149629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274C88A93AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1711F2374F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FC83B1AE;
	Thu, 18 Apr 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiAZHUmr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4E136B01
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423693; cv=none; b=oSY11nY3wYLYkjksyInK/FCfCxPjyU29/BgZjRFLzhD3+6GzvZU5KtvP15cwfvB7sjl9/rZYbDa8mT/GDRBd1IrHGZOWe02uJ+jpKxh4fz5k7LpLTvHiUQpMX8g0n23FI9x1nVTI2WhnuarVemDUmgIEUtf6tqIVbie/A3jA4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423693; c=relaxed/simple;
	bh=aBa+Zd4DOsCV5bBQi56SDbzPnQQrs8wGfyaz6qAplIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDyweOa+X1CVN2343ucWF28p1757c6VF6oMEs8gt510mLECXmVPvdcpYH1MUeOuL0T9lhEUwsT9f4cSpHQ7RnxBxTf2M9AFddnUlIKIXeVZnvl8hWTQVxzlrogY6d7krsXLLzpMukrJRkvfzA6LpHBoo8kUYn71qdXuHRM4dxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiAZHUmr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713423687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCeGODggKk984bbqSwADAeFH8dPaC8yv8N2n7Vqmn3A=;
	b=DiAZHUmrk/1zUMGjtJrVdbprN3QW+iaH+DxXUD57AShJD3q6Yyr3XxxTqdQGrMy2g5jo+e
	8PepwI1YZEavf5ZA13XfoWbja7vhI/EdVHqJIpywqa9Bz9jl/pNQKKIrLqHLCkfB1RCKPV
	Q2m4MDN0XRhZxG/Fd0wSFVEW1JgjJ3U=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-cE5CAaZEOQayisN4u2gJNw-1; Thu, 18 Apr 2024 03:01:26 -0400
X-MC-Unique: cE5CAaZEOQayisN4u2gJNw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6edff450718so684134b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713423685; x=1714028485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCeGODggKk984bbqSwADAeFH8dPaC8yv8N2n7Vqmn3A=;
        b=ZdpOVcUbm5stN3kzVG82ft0n6/2DYBbVdA8xe41MhqsNb7Cnk27F4wxgGUtGcPNH04
         fgFzVkcVmPKvs69Q7YEtFnddlUMWL7u814KM/c4cE5fZmlcewZykIGM3mjLPSKsVUrDc
         vre7h36JRhkgcs21MGLs3ALDGZrPqee4mB3bTzPQ6lh9Lu40R845g9WAOdMyQ4sim+Wx
         vM6XAZgPUMrtdYH4PxdgYrWkjyJvdViyKgphDJusHko5TscnzmrTE6w7ub1aZLjfgS1w
         YWxDqhn8DCh8sc8wZXK5x6moTDmE+L7/jmIK0kC2flxLLrFJNLnorpQyfAjsiDRWZvrF
         iByA==
X-Forwarded-Encrypted: i=1; AJvYcCXQKnIJaOtezexjAvyLn15VXsMPPyWQ/IQ6rJpq+yQzNM6Y2Z8EZFrvvVeDgZ1Sa70FTbO8rL7egpbr9nmi9h/yidZWLSZwRWVRhF37
X-Gm-Message-State: AOJu0Yy2JgRG9VjEa3lAX4hgEi/dTriqPosSE2nrZ/HO1zyBL40TGjOE
	yIFG0ttxky1MSRGKlRBh3LrBuTADhYWVOIBm8iA3Hx+x7i1Xz9BdfxlS2c5yUNCXNE89I/Y1rF0
	uTbuDlY0tvf87MJyO7pzZqDLrJCTIgCpjgcsmOy0gK8++cEEmcSrX6EId+PyYjx8Y/8UBGuG8ad
	/H1SwSGuuzH3GjzFejXH4TrbFmgz+wMy+rGLTx
X-Received: by 2002:a05:6a20:1588:b0:1aa:5984:d3 with SMTP id h8-20020a056a20158800b001aa598400d3mr2813384pzj.6.1713423685033;
        Thu, 18 Apr 2024 00:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9LpK02ULWJ6ZvpKG3pyD3OiboVfLCBcf9kyYEbDUPg0rA+sYUJZ9rBRQ1cKRvIYIB81qkbkXpr0XQAKD8VfU=
X-Received: by 2002:a05:6a20:1588:b0:1aa:5984:d3 with SMTP id
 h8-20020a056a20158800b001aa598400d3mr2813354pzj.6.1713423684648; Thu, 18 Apr
 2024 00:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416053909.256319-1-hpa@redhat.com> <20240416053909.256319-4-hpa@redhat.com>
 <CAHp75VdRgBqaX4NNvABS-90O34OtRf5t85JOjpG=tOw2SHr_tw@mail.gmail.com>
In-Reply-To: <CAHp75VdRgBqaX4NNvABS-90O34OtRf5t85JOjpG=tOw2SHr_tw@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Thu, 18 Apr 2024 15:01:13 +0800
Message-ID: <CAEth8oEtb+m_2DKF6Z5W1m1fbBxnP_dgS1tNS9iJMUgg4ZRhnw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] leds: rgb: leds-ktd202x: I2C ID tables for KTD2026
 and 2027
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy

On Wed, Apr 17, 2024 at 1:32=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Apr 16, 2024 at 8:40=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote=
:
> >
> > This table shows the maximum support LED channel for KTD2026 and KTD-20=
27.
> > The 3-channel LED controller KTD2026 controls R/G/B three LEDs. The
> > 4-channel LED controller KTD2027 controls R/G/B and a flashing LEDs.
>
> and flashing

LEDs should be LED.

>
> ...
>
> > Link: https://www.kinet-ic.com/uploads/KTD2026-7-04h.pdf
>
> Make it Datasheet: tag
Okay
>
> >
>
> and drop this blank line (to ensure the Datasheet will be recognised as a=
 tag).
Okay
>
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
>
> ...
>
> > -       .shutdown =3D ktd202x_shutdown
> > +       .shutdown =3D ktd202x_shutdown,
> > +       .id_table =3D ktd202x_id
>
> Exactly good example to show what the difference is between
> "terminator entry" and "last field in the initialiser" and why in the
> latter it's better to keep a trailing comma. And hence why the stray
> change in the previous patch. So, id_table also should keep a trailing
> comma.

Thank you for reviewing it.
Lesson learned. Now I know how to manipulate the comma correctly.

>
> --
> With Best Regards,
> Andy Shevchenko
>


--=20
BR,
Kate


