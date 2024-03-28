Return-Path: <linux-kernel+bounces-122647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BD688FAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F036B25282
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1F8612F5;
	Thu, 28 Mar 2024 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY0KLUfK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763465189
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617280; cv=none; b=FI4O0h3zIV2I/t6nCQUw1716bfvx9Q6Km7TOaSkZ5C9txR9Qmlh4GxXztB59os9P31sK+eoKRIIDmJJA26ZLFiNidlreHBM77sACjV9eiWWZy8SJhedai/4WR2Dz/fXxhptzR4ZrrVPCG0blKB3u4pfdkl75ZsYJQR/7vBzq7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617280; c=relaxed/simple;
	bh=UzP6CMkk2ZXCDOwotQD/gmS6TjH0e7Di7zY0YNpZw5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R914xhIFcDw4BpP7Uo7T5zjJVdVHj0qCENiyq51kmyBAc/kjknj7eC+lrxvziJfv1jxze0DzgVm7hAzHHqSiwGQ/62cTcEhVa85OyqshpHIzCZndtfnmqTkwozAvipd6u3UqKGzeI3seYZEwNdlbBQR7tIPAcyyrRoPXiGoPTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LY0KLUfK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711617277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCPrvGXYWJ8By52IhH6oFnCB7CwZOeHwWNu18OjqJ8k=;
	b=LY0KLUfKjayczPuZx81XXL0MDeiZ88Qqf3+YEYgkUU/MhK8uA1jsGhi8Vm0EVDzTpZXdyh
	rW41Lte3TUUNi7rpvadXJ98z02b+SdP+qNlGSyRz5d1ui098KTvZ/94/cjQA0fBt99/kNW
	qhYuatN7HL1wTyjCmfWavCKV5cLpfYM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-N01DTK-mOpuehnin1_c68w-1; Thu, 28 Mar 2024 05:14:34 -0400
X-MC-Unique: N01DTK-mOpuehnin1_c68w-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a1fa1a83aeso637346a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617273; x=1712222073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCPrvGXYWJ8By52IhH6oFnCB7CwZOeHwWNu18OjqJ8k=;
        b=GZPcN+JAIl32bD5XAA86QPGsgBNQC7QEFSYEE2f5qvpch6U/GCW7j46siUCDKGrTwE
         h3CuKVc770mha1e806j2gn/OfguiVAi4yAidXaOyiNP8eW9hdomhGptLFr3ab/5ZHf8X
         nzsaXJIH/zCnQVCrKHRbmErKR913HLbsRVfTo5bYgAMbxEF7Nt8f/69ctrlR6UKWb+7v
         cFlfKrsazVFJ4AnCtyCpjW5ihiuyWIFvoCIa5wSKjMlyVfi2OJOv1W3V42uhcVCxs6tA
         /UjVaQm6UDxFRDBzXQsqRFkRxvpysIP58J4Fe+nRR0zce76jHAXuJAMa9wP+2Cx01QPm
         FFhw==
X-Forwarded-Encrypted: i=1; AJvYcCW+/TXtVjWzqqzQJ5a5mxG5gIBeEa2pMJ4cpmQ4K/MuFYgocdCgs6Sw65tuYF0H4nJdgRQ1pmbaZxz1+InWhmVlJ5WhLUoWtaY+vQRB
X-Gm-Message-State: AOJu0YzCTma0jhR/ejs+VFW5hnyZ0I9g7lWQ5/lMe62WIM2MSNgV4Peh
	JVahWp1CIC//GU2nTgvNCxf+3qv/1rR8qBDJdcSeNWXhKhQqrW+BCyi/0s1VH8bUw5M53s5E7tR
	mjUY2sTlvl0oz0E0rae3zcmTKt41b0NjsY+jH2ppNcLfvq1zFdfNF+4iG/dNfUsPpallogAxDdZ
	l7VgkBA6Zgtk+2xzbWrsntqea3pHDO3RrNxdR0
X-Received: by 2002:a17:90b:4b8e:b0:2a1:fa61:c36f with SMTP id lr14-20020a17090b4b8e00b002a1fa61c36fmr2296337pjb.6.1711617273116;
        Thu, 28 Mar 2024 02:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi3BKQN7KjYtiTy0xPe3Kaj+iV31sWFRGS6rMfhFKO/KB1x141HXgNSJIkZ/MeZctX/AQnyjyJUk1BCb2Qnx0=
X-Received: by 2002:a17:90b:4b8e:b0:2a1:fa61:c36f with SMTP id
 lr14-20020a17090b4b8e00b002a1fa61c36fmr2296315pjb.6.1711617272743; Thu, 28
 Mar 2024 02:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-2-hpa@redhat.com>
 <CAHp75Ve5201KNdjvDZYq_unHTKp9wZXPWZXDgStP8y+XjtnWWg@mail.gmail.com>
 <CAEth8oG7_qFuUrL+kX3ezNatWqKPqT-qiaO5NGY-N3F3ufQL9w@mail.gmail.com> <CAHp75VdQtmT0G1dFhdY7TrcBj2W6GhOaVv90_T1e3MdEtiduQQ@mail.gmail.com>
In-Reply-To: <CAHp75VdQtmT0G1dFhdY7TrcBj2W6GhOaVv90_T1e3MdEtiduQQ@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Thu, 28 Mar 2024 17:14:21 +0800
Message-ID: <CAEth8oH9iDm1fN1LyPRtvHt=w7z72kunpRssxg3-nPNAgOyoXg@mail.gmail.com>
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

On Wed, Mar 27, 2024 at 7:06=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Mar 27, 2024 at 9:58=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote=
:
> > On Mon, Mar 25, 2024 at 3:30=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> w=
rote:
>
> ...
>
> > > > +/* main fwnode for ktd2026 */
> > > > +static const struct software_node ktd2026_node =3D {
> > > > +       .name =3D "ktd2026"
> > >
> > > Leave a comma, this is not a terminator.
> > >
> > > > +};
> > >
> > > When I asked about the name I relied on the fact that you have an ide=
a
> > > how it works. So, assuming my understanding is correct, this platform
> > > may not have more than a single LED of this type. Dunno if we need a
> > > comment about this.
> >
> > I'll make a comment to describe the configuration.
> > This LED controller can be configured to an RGB LED like this. Also,
> > it can be configured as three single-color (RGB) LEDs to show red,
> > green, and blue only.
> > I think the name can be "ktd2026-multi-color". Is it good for you?
>
> My point here is that the name is static and if you have more than one
> LED in the system, the second one won't be registered due to sysfs
> name collisions. Question here is how many of these types of LEDs are
> possible on the platform? If more than one, the name has to be
> dropped. Writing this I think a comment would be good to have in any
> case.

Only one RGB LED controller on this platform so we can name it. I also
tested the LED with and without the name and the LED worked properly.
I think the name can be dropped and put a comment there to describe
the usage and configuration of the LED controller.

Thank you :)
>
> ...
>
> > > > +static int __init xiaomi_mipad2_init(void)
> > > > +{
> > > > +       return software_node_register_node_group(ktd2026_node_group=
);
> > > > +}
> > > > +
> > > > +static void xiaomi_mipad2_exit(void)
> > >
> > > __exit ?
> > No need.
> > x86-andriod-tablet is based on platform_driver and platform_device so
> > it doesn't need __exit.
> >
> > I put __exit and the compiler complained about the warning.
> > =3D=3D=3D
> > WARNING: modpost:
> > drivers/platform/x86/x86-android-tablets/x86-android-tablets: section
> > mismatch in reference: xiaomi_mipad2_info+0x50 (section: .init.rodata)
> > -> xiaomi_mipad2_exit (section: .exit.text)
> > =3D=3D=3D
>
> This is interesting. Why then do we call them symmetrically?
>
> Hans, do we need to have anything here been amended?
>
> --
> With Best Regards,
> Andy Shevchenko
>


--=20
BR,
Kate


