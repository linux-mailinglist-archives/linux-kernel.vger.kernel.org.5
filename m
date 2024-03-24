Return-Path: <linux-kernel+bounces-112711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F5F887D3C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52951C20A42
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FC918622;
	Sun, 24 Mar 2024 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7ENOZGf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF618030
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711291739; cv=none; b=B8NsahqkWtno6IfVdLF1cDgd3UZNZ4BC1T4pAXN13YvGryC8CYn2Pia5PJKahc4r26oYfexFLs3uKUvrxc//nKCXfWO9FzGazTb/+PSu3T2nvmhyR4IYKJVH+JuhCCGTEKcTVrNy7t1ORyyHbXaESDqOI5IxMg3IFW0710oxGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711291739; c=relaxed/simple;
	bh=+hmNad4AcBKeWQma6Izd7CkEUkildK4LrIOj1dEfDRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltVpYPN6ecODPvIX86olmjZD2kSC1EfBzsU9aFWDcotmFT2+BldjylPL4R34aAMs50esabeQzuM4h4xagLLSjDEm+3JUUVGQ/2TKxbkl4wyygeRrPmKSFAB8q7LmEl40BbVE8aALaRyVeJEmoP9v+vAWNu0Q/VNGk3/gJe6StfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7ENOZGf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711291736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6C7+8Wp6+2qZOsRGd4+RkqMnsrYwdbiueBVs6ZMFIQ=;
	b=W7ENOZGfYNHCzGi+ZsZ3/pK9Lu14EfBxYNvZONg+2TwpcwVucsWVPYMalhHjzY+t9L/xbt
	XSpVsjdV/xBfQTEamH4M87bBs/Y/+SDhYcxpHj4L6JoCEAfjDHzm+x8cL1u+jp4db0jdrp
	m4Svy6hlCoRQG1WO4DXyogQOQQsUBOg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-QpYV1TKSORG8UeZIs3bxqw-1; Sun, 24 Mar 2024 10:48:54 -0400
X-MC-Unique: QpYV1TKSORG8UeZIs3bxqw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a00fbe5192so2797571a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 07:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711291734; x=1711896534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6C7+8Wp6+2qZOsRGd4+RkqMnsrYwdbiueBVs6ZMFIQ=;
        b=tvVmUo5yj29nEAJXNK3QkzdeMUbAfYjWCcvKdUp4ttdCgNErzytoVL34CyD5ocnROn
         fF8EI5z/E7hPippGp/g6CGDYX7lB+ZRvUME+/+DcknCc0weP0Ujf3b5W67XggHqFyAlO
         j1lrKuLWGFxfUIOsh2wzJwtj3YM24bTW18P/lnJ2mf6917/s4PqJlTD4RnsTLaWvlMdz
         nVfDPL9RMq8y6uVkSyR8zlsn5Rj+2Jxqs431GLaHgtI6tzBSHotpHzGPCegc9jotyIec
         VakHIUL3jjl0/CIOYDHadYF7Hy5ZzXK0tB8jL1qV9aXOuR8RnvVRRJkrnMIFncE6nzQx
         ki9A==
X-Forwarded-Encrypted: i=1; AJvYcCUD0GM8iQJBmko6ih2M5o1EZwajMtU0Sq3YfUg6J1dnbbHFAWa7S/VU3HnK52AVfMTM/4VPmkXDSOtP9Cl3T65ZMtKNtRd9TywxjUbw
X-Gm-Message-State: AOJu0YxzjgLX9ppL/fFpCRhbpH6d27MriMXCPNG44m+1zhQra3SnVm2X
	dER6iOMbbF8edeSHmGmx3sfksIeTHqfYltji3pqhT9T196CV/M7t5VXGO6fQPE7OCpA1/yQ8L4H
	g+QiJgMV8ajOaaSpuhDIVz4GGle2/x8KoOAv6Ly6H4hd2Nmq39f427EvWaKlFBVzgADkpXnA+cz
	hC1Y1v3lDv36kzycUaODCqyWGTpHj/BrPe9T8q
X-Received: by 2002:a17:90b:1004:b0:29c:6000:a12b with SMTP id gm4-20020a17090b100400b0029c6000a12bmr3410706pjb.38.1711291733809;
        Sun, 24 Mar 2024 07:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTD1jp0nZuoHDHAd1Pk4uTsJIWjJGwFeXb0QFll1ryEavOQegPIcvGaYKN72cZx2wc/59DCc28e68iStBHLpI=
X-Received: by 2002:a17:90b:1004:b0:29c:6000:a12b with SMTP id
 gm4-20020a17090b100400b0029c6000a12bmr3410693pjb.38.1711291733484; Sun, 24
 Mar 2024 07:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306025801.8814-1-hpa@redhat.com> <20240306025801.8814-3-hpa@redhat.com>
 <Ze-N_y5Tbjc93aRp@surfacebook.localdomain> <CAEth8oEdzomdn5avXf44HXpoMFDfGpOjjxPFtaGkh0EhfZsPMQ@mail.gmail.com>
 <CAHp75VeoZ7p=7e9CgZftT5hThf-uMaUrqZBv=+tNYiUOevUOnw@mail.gmail.com>
In-Reply-To: <CAHp75VeoZ7p=7e9CgZftT5hThf-uMaUrqZBv=+tNYiUOevUOnw@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Sun, 24 Mar 2024 22:48:42 +0800
Message-ID: <CAEth8oFPwBKPRdTFqgtC8TXYVp1QcRzz-tuwy03VkanWOWfSpA@mail.gmail.com>
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

On Sat, Mar 23, 2024 at 12:02=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Mar 22, 2024 at 7:45=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote=
:
> > On Tue, Mar 12, 2024 at 7:04=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
>
> ...
>
> > > > +     chip->num_leds =3D (unsigned long)i2c_get_match_data(client);
> > >
> > > No warnings during compilation?
> > Yes, the compiler doesn't complain about it.
>
> And for 32-bit mode as well?
>

Hi Andy,

I've tested it with 32bits kernel build and the compiler didn't
complain about the warnings.

> ...
>
> P.S. You have commented only on the two comments. What about the rest?

For the rest, including variable renaming, error number shadowing, and
"%pfw" were fixed in the v5 patch.
I sent the patch but I forgot to add you.
I'll resend the v5 patch and keep you in the loop.

Thank you :)

>
> --
> With Best Regards,
> Andy Shevchenko
>


--=20
BR,
Kate


