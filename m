Return-Path: <linux-kernel+bounces-35223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1D838E11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F406C1F24FED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD885DF02;
	Tue, 23 Jan 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmjmp3k5"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C25D915
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011154; cv=none; b=R9vV48wjyWPfts6PeX0qMWwHlJjak8OJkyFPHTcvrqieDU0zkXqPW6tJFLw8zPNc4BAo7/7hZtGynZbkjog9A8hqQRxfBH0ClZzhiep8uBd5DDJRKp26DD4tqkfAt7BZVfnJHcINh9LuUCE3IlrThWnzM/SabV0FD+uimcqcGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011154; c=relaxed/simple;
	bh=Os8hIlLsFkGBkZeoXT/YcKzJ5GoXqLCjF3yLXjabNzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZIsv8gFvrLzK+Mnw+9+opJT3yFgDLLrgW8kGCFNxmBhpKygUFdmuVU41pcGxRTL3mQlLEVc+02GOzL6H97goRtvkLJKE5MyhvacNiqJoQmOCJP+3Kr3Fehp9htrzjCsidbh3jqeL/S9Px9gHu9+Pp0FOZTFhWOugKUtMRHtNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmjmp3k5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dd7c194bb2so297321b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706011153; x=1706615953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEI0es0Fh9CjmQ9+goIQ3glo1dNpAV2T7ObrjAwh6Bw=;
        b=dmjmp3k5S3iOWWnCHxXf9rjyCNK6GnzsbCuYCuyL8gnqVf817JiEGbybYIc0EXbgil
         7INAjF0lrMpA2vLsC4O2gYSDojuBegJamf0uxAE1QVTkl/JOdj+og3lPUI8zTODpfRKZ
         Oqw5Kwm/4UwrD+Yrq7tqeYSL9em1IKaJ739FkL0ZLmGgeC1/m6rXDnwgRMAem1emNdEM
         1rxJSa/V/1icF1PUc9AxfFKs1zIPFN2cWfsEpZbLlQbepucgOVyZ9OTxIbbGhGNaw8EY
         MGGnjCdkJgpJwm1E74F+hmRi5DsP5tUxCGj1qQPBQC24WNdLCyDxwRVeGXw5WSLfucFf
         CHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706011153; x=1706615953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEI0es0Fh9CjmQ9+goIQ3glo1dNpAV2T7ObrjAwh6Bw=;
        b=sTIvcxf5Yo58u03AkYdgeRaFuv/bKUplJ9OG4J6D7C5cLEPyZLTi8QRz1Wqu0mfqgp
         cTicYn8n09CguBMmTHoIMBIxyDb70dv+Ztwy/h/TNQEyPbZVKEk806B+BIJUe0UQ2z29
         e3yqRogmbp+fxsAQOyK4PtKmrFaIOfGKOFczk9GABqNkGLNj1uz7HwfY6hbg9cbi9ZMl
         VxpkDavBbVZRO4vyONtCYSOU3LTRW0cW74YywSkOMWvgzPn7jR5rbU7uG498iC0ZbcfV
         pQ0HGKgEPoJqxSFQ1MNLS9n8RbrWYqw59OE3Cn9ReWL0ACCTYZiWGac/YyCEi+lROdmO
         TpZA==
X-Gm-Message-State: AOJu0Yy/mrtMQfBgiPd5SLG6YuUzZ1UInZXoSapKiJcigLXBP+NE50ej
	+wbwdW+g2x3ghlY7nsb3u0aDOMOvC0OO2ylAJW8Hq6NKT7KIt+tj2UhQsxs2M8etMA9nv6/8ue4
	+ig7v8ce2TCkfQ9qgVRe+4es7kyfu9GtGcxd0
X-Google-Smtp-Source: AGHT+IGx72UbdOpW3i/0sgcjdJBt1MEPY7k67MDAMdIFzUHdiD++kJWWcxdSo5/N8e6JggX3TWq7yKj0n+9drNmZF7o=
X-Received: by 2002:a05:6a00:1405:b0:6d9:955a:d3bb with SMTP id
 l5-20020a056a00140500b006d9955ad3bbmr7944003pfu.10.1706011152521; Tue, 23 Jan
 2024 03:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117113806.2584341-1-badhri@google.com> <CA+XFjioEL4ZcdDZgK2N3squudx8T_DJGrwNDCaN-2XJ3Nb4sXQ@mail.gmail.com>
In-Reply-To: <CA+XFjioEL4ZcdDZgK2N3squudx8T_DJGrwNDCaN-2XJ3Nb4sXQ@mail.gmail.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Tue, 23 Jan 2024 03:58:30 -0800
Message-ID: <CAPTae5Lz3dW6Qw4izJFa7XGiBHmRr24vPWkoieijWd0TaLUBCA@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "usb: typec: tcpm: fix cc role at port reset"
To: =?UTF-8?Q?G=C3=A1bor_Stefanik?= <netrolller.3d@gmail.com>
Cc: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com, kyletso@google.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, rdbabiera@google.com, 
	amitsd@google.com, stable@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gabor,

While HI-Zing CC pins disrupts power for batteryless devices, not
Hi-Zing CC pins would prevent clean error recovery for self powered
devices.
Hi-Zing CC pins would make the port partner recognize it as disconnect
and will result in bringup the connection back cleanly.

How about leveraging "self-powered" device tree property and Hi-Zing
CC pins only when using "self-powered" ?

Regards,
Badhri

On Wed, Jan 17, 2024 at 8:07=E2=80=AFAM G=C3=A1bor Stefanik <netrolller.3d@=
gmail.com> wrote:
>
> This will break operation of batteryless devices relying on a USB
> Type-C port for their power needs, as the port reset upon controller
> initialization will cause power to be cut to the device, resulting in
> a boot loop.
> Devices using the FUSB302C port controller are especially severely
> affected, as upon losing power, this controller can retain CC states
> for a very long time (potentially forever if some parasitic source of
> power is present), requiring a full mechanical disconnect-reconnect
> cycle before the device receives power again.
>
> While the USB Type C specification does require this behavior, I would
> consider this an oversight in the standard (perhaps left over from
> when USB Power Delivery was still going to be USB Battery Charging
> 2.0).
>
> Badhri Jagan Sridharan <badhri@google.com> ezt =C3=ADrta (id=C5=91pont: 2=
024.
> jan. 17., Sze, 12:38):
> >
> > This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.
> >
> > Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
> > the CC pins, setting CC pins to default state during PORT_RESET
> > breaks error recovery.
> >
> > 4.5.2.2.2.1 ErrorRecovery State Requirements
> > The port shall not drive VBUS or VCONN, and shall present a
> > high-impedance to ground (above zOPEN) on its CC1 and CC2 pins.
> >
> > Hi-Zing the CC pins is the inteded behavior for PORT_RESET.
> > CC pins are set to default state after tErrorRecovery in
> > PORT_RESET_WAIT_OFF.
> >
> > 4.5.2.2.2.2 Exiting From ErrorRecovery State
> > A Sink shall transition to Unattached.SNK after tErrorRecovery.
> > A Source shall transition to Unattached.SRC after tErrorRecovery.
> >
> > Cc: stable@kernel.org
> > Fixes: 1e35f074399d ("usb: typec: tcpm: fix cc role at port reset")
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index 5945e3a2b0f7..9d410718eaf4 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -4876,8 +4876,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >                 break;
> >         case PORT_RESET:
> >                 tcpm_reset_port(port);
> > -               tcpm_set_cc(port, tcpm_default_state(port) =3D=3D SNK_U=
NATTACHED ?
> > -                           TYPEC_CC_RD : tcpm_rp_cc(port));
> > +               tcpm_set_cc(port, TYPEC_CC_OPEN);
> >                 tcpm_set_state(port, PORT_RESET_WAIT_OFF,
> >                                PD_T_ERROR_RECOVERY);
> >                 break;
> >
> > base-commit: 933bb7b878ddd0f8c094db45551a7daddf806e00
> > --
> > 2.43.0.429.g432eaa2c6b-goog
> >
> >

