Return-Path: <linux-kernel+bounces-120487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF7C88D83D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E501F2AE26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F84A990;
	Wed, 27 Mar 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGeKM79S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1F45954
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526283; cv=none; b=ricKyfQQC3gbVeBNSj1P5oAag4m4O6f1qW11jC93mTjZRIh51AYlyyhDab7gUO3+LKpxLTHCw+sc0n/M0c1C6gcev3HTUUM9bebEwziw/Dl4YTeB4IydXV0mb0BMXxvDCW1Jc43JcrNxpLKsl54JhxmJMTcgUiOJspHaYfnU8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526283; c=relaxed/simple;
	bh=+jMhjERTTtRLM0KWZ1Ds1bG7HJxMTKBPNk0QcjknlfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLHygBdvfMVNmPy27TdG5N0zewedTi1uRsVSZpuO9+Q7Uyclw/GLmEtREj6aZedXQ2rftDYecCkvUGDogqfkbkNuxq00cC7Pm8krcYYgpKP9YnoWnmgXYcyrXz0HtJR99SlqmbMcjiDdoLysl8DpDgzy1rRZHcqo69XbrlG8DxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGeKM79S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711526281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvCZIXlyJ0i9W5y1NVajdFVbSmQI+ddDaK6Um2GHqYw=;
	b=QGeKM79SYM2frmbmt2fxZHlTNPc5Oc842ZXIV9fYAHyaizqKZdm6AQwbQ2/i7sBfZ6yLBG
	/3zjToBOF6R5v9/jolUeie+s7O0lGrLHanmRp8WfGz9AHCuTQt4iVPqe1SUqo5L+iRAxdS
	JXhpwPhJDXSNffPjD54Q6jbnEfn3mdQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-R9b45yNHNeijrkQ2kURyKw-1; Wed, 27 Mar 2024 03:57:59 -0400
X-MC-Unique: R9b45yNHNeijrkQ2kURyKw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso3076420a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711526279; x=1712131079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvCZIXlyJ0i9W5y1NVajdFVbSmQI+ddDaK6Um2GHqYw=;
        b=Uv9XhyvHlfyzm2jyXkAD5W3NZzw4ZVIhH77RcFc+BEDrcaUBcPoart3JXIgc1y5bH5
         YZzaBmSbfLa46bx/9FZz+wb/mwJwmo3coNtIdZzSBsbJ21BrPSL6hIg0JazxOPt347SF
         NnjCL2izvWFwLWRXcfW0uz4NT3Pbce1XI/4DJyRZ54fJ05o9jiqGqyVeVKsEjFeszjsn
         ZmK0fEIU0ak/RF8CI/1SQzzM6otjz30XDwALS5dkLSd9csKBls59umoAfa6DqC6M+vhN
         7yGCOJAuRFPJUjAL/RU7WgP3EfQ8A/r56rHNTz/CYOcSM922dUi0jLIxWVqFmaJCaTnl
         dpJA==
X-Forwarded-Encrypted: i=1; AJvYcCVVusx8GIVAL0AznOV3yVz/Lt0TSRrQbZY7vX+5U21RKu4q+V34mV2SLbmmLtqW6k951Gb8Mx4i0HAVC5vYX6wFEveKXat7xa9lV7gN
X-Gm-Message-State: AOJu0Yz+uqvW3eC/2T/PpMR/PlwsKw+7RZcnu6UMqLY7CSwLxzC9i16k
	KU45GOjPtsKhdUD8MR4loSx0/A7CcRTAmr95+HcMQvDExj5GcPYF0JV95/1+MG8QE+VXLJP3qtk
	3LGPxZO7ZkaWurkBbO7LlksBnkbkswt9Ero7jHKba022nhUvFfN4e+Omu5HXkLK47fDr++QGzaO
	mbL0vV3u+dPwjYF2KaNaHuUrRAb9d2iCgaJUTm
X-Received: by 2002:a05:6a21:78a1:b0:1a3:5440:520 with SMTP id bf33-20020a056a2178a100b001a354400520mr2261630pzc.1.1711526278845;
        Wed, 27 Mar 2024 00:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Q9fuG8yTs+ELOSdaWHYwqpSczYEeTI5UtBaHspHNLcfSZRVndgU5mB3Z2zq0Hcih2Q+cX9I9biaM+ykuO08=
X-Received: by 2002:a05:6a21:78a1:b0:1a3:5440:520 with SMTP id
 bf33-20020a056a2178a100b001a354400520mr2261613pzc.1.1711526278530; Wed, 27
 Mar 2024 00:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-2-hpa@redhat.com>
 <CAHp75Ve5201KNdjvDZYq_unHTKp9wZXPWZXDgStP8y+XjtnWWg@mail.gmail.com>
In-Reply-To: <CAHp75Ve5201KNdjvDZYq_unHTKp9wZXPWZXDgStP8y+XjtnWWg@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Wed, 27 Mar 2024 15:57:47 +0800
Message-ID: <CAEth8oG7_qFuUrL+kX3ezNatWqKPqT-qiaO5NGY-N3F3ufQL9w@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 1/6] platform: x86-android-tablets: other: Add
 swnode for Xiaomi pad2 indicator LED
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

On Mon, Mar 25, 2024 at 3:30=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> wrote=
:
> >
> > There is a KTD2026 LED controller to manage the indicator LED for Xiaom=
i
> > pad2. The ACPI for it is not properly made so the kernel can't get
> > a correct description of it.
> >
> > This work add a description for this RGB LED controller and also set a
>
> adds
> sets
>
> > trigger to indicate the chaging event (bq27520-0-charging). When it is
>
> charging
>
> > charging, the indicator LED will be turn on.
>
> turned
>
> ...
>
> > +/* main fwnode for ktd2026 */
> > +static const struct software_node ktd2026_node =3D {
> > +       .name =3D "ktd2026"
>
> Leave a comma, this is not a terminator.
>
> > +};
>
> When I asked about the name I relied on the fact that you have an idea
> how it works. So, assuming my understanding is correct, this platform
> may not have more than a single LED of this type. Dunno if we need a
> comment about this.

I'll make a comment to describe the configuration.
This LED controller can be configured to an RGB LED like this. Also,
it can be configured as three single-color (RGB) LEDs to show red,
green, and blue only.
I think the name can be "ktd2026-multi-color". Is it good for you?


>
> ...
>
> > +static int __init xiaomi_mipad2_init(void)
> > +{
> > +       return software_node_register_node_group(ktd2026_node_group);
> > +}
> > +
> > +static void xiaomi_mipad2_exit(void)
>
> __exit ?
No need.
x86-andriod-tablet is based on platform_driver and platform_device so
it doesn't need __exit.

I put __exit and the compiler complained about the warning.
=3D=3D=3D
WARNING: modpost:
drivers/platform/x86/x86-android-tablets/x86-android-tablets: section
mismatch in reference: xiaomi_mipad2_info+0x50 (section: .init.rodata)
-> xiaomi_mipad2_exit (section: .exit.text)
=3D=3D=3D
>
> > +{
> > +       software_node_unregister_node_group(ktd2026_node_group);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>

I'll propose the v6 patch to fix them according to your comments.

--
BR,
Kate


