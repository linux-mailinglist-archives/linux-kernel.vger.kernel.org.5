Return-Path: <linux-kernel+bounces-151408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A9E8AAE73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742761F21DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655445812F;
	Fri, 19 Apr 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaAw2RNs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A68563B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529823; cv=none; b=YCW3MSo0WcXJxZ3nHVM+++8ZLV0LKthRPOPlCMffMFp3tH5sOk7z4bEv2jDADId2gwJ0NGx3XYcQs9JiaHr9NZgNemRfaZQ06VR1MWh6r8q4KAnVTzSWSjD2HsoCqWl4qn5iVAcwAPBaCGJFX2sSfp504eSpjuxovTxBDsl87DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529823; c=relaxed/simple;
	bh=Y0qzuaLHp7jYNZt/yJHBqCPkPqeNLCNBhwMVULVwpAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iijd3QB9nA4GfDsxuDN1ZK3tB8khxXlsOjdVj6C48RZdAbKmOw1XcDVdbgHa8r+n8oMizJlU+UjFBb1RiWSPyqPfIGs1H8UqTvsI9bSZvB3r7SYEhCrB+ppqx0G4dblMIWHhBagS2i2bf/tSWSAU9feFhLsp162m+Oygy9WkH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaAw2RNs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713529821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUl9xI+kv1Ecrl0dN5hTZc3O707nonguLWXio7bCIq4=;
	b=YaAw2RNs4xRsISLfLz+296Nf0ShbW60WUPb349jnd73Nr7h4CShlDmwPhRouLX3ViPZkCm
	lCMuVE50V078McFi3+ZG7rIx1oQuEfZrYnIQYRM7F13a5HLyRWkVYWYylgi8MjW/C9w7u8
	Zj/fvVXlopo4X0THRMa0v2rFtVUzqxc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-iux10_i5OjiKSBAZBkX17g-1; Fri, 19 Apr 2024 08:30:19 -0400
X-MC-Unique: iux10_i5OjiKSBAZBkX17g-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-434e545b504so26912551cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713529819; x=1714134619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUl9xI+kv1Ecrl0dN5hTZc3O707nonguLWXio7bCIq4=;
        b=aIMVUNIBVU4f7ItdRdAbZYdv7giE7W1Tcp0Q9d9Kfx/pJO2TXk/0NZcSPJ1opzpJci
         aDaJ6+cKAyzqnXRk/U6aCuMUg+eqnhQAxkCUxZ9EMnMWLb9a1/S5ZLDy7gvZ1DBeByQ8
         5DjQbADohpdddCMEVPzanegOAbDIdiOCxSml356WZExLeLVjBIRXqTNqI2Ae86YcSIqq
         BHa7/z6iLG0SU6ZlaK3S1HQZDXKo0Oj7uH1D/AzrxT3E1m/Fvg7+jvcCXHN3iG8fGt1V
         cgv7iALhIPQiqzIm7FXx/R3gp492HT/C83CNYDfgWO6vEK0W8r5PN2Vmaki29VKbnjwk
         +mOg==
X-Forwarded-Encrypted: i=1; AJvYcCVWGUvud4SBErcs1Dv+SHhGx624X9IQ3da6EThk752VItTyjrL5nhR91DbkuMG8kcbzXplqD+632RIR3XIpMonAgnpQYYq/E8CiR6fu
X-Gm-Message-State: AOJu0YzgD4hRubrg5UcgK9sJ7eTso7O+tTCE/hQ9QO/XsyVHavBlVgy6
	l3xDgXn+w4dD3XklNs/GrcBClGxhBW0XVnD0wG27Fp8htLCb7abCz29jKm3Xete/JLwQIr2kkN9
	sLtk0FqjHFDhLJVcNgvUY7w36J55jc8TqS24rdWxb/lZBqESug3YNlsoRU8X76DimHK4oMp5adZ
	1Q3U0ujZSm6bU5uYC8cm7kcH88P/pF8TlaG3HI
X-Received: by 2002:ac8:58c5:0:b0:436:9fc4:6146 with SMTP id u5-20020ac858c5000000b004369fc46146mr2525511qta.57.1713529819033;
        Fri, 19 Apr 2024 05:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/0gAu1715B7QcJo9RzfxjgsVK4gM72ujbyqIpwdqiQsGOP/u/P3Xa/+8cNacgni8XdO9khMEeRrBNwJnQxNQ=
X-Received: by 2002:ac8:58c5:0:b0:436:9fc4:6146 with SMTP id
 u5-20020ac858c5000000b004369fc46146mr2525485qta.57.1713529818801; Fri, 19 Apr
 2024 05:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418210236.194190-1-wander@redhat.com> <20240418210236.194190-3-wander@redhat.com>
 <CABVgOSncx1eS_8EWsNkoDOj+TaNsaW8MpjG8XaFY2Q8JXo+oqQ@mail.gmail.com>
In-Reply-To: <CABVgOSncx1eS_8EWsNkoDOj+TaNsaW8MpjG8XaFY2Q8JXo+oqQ@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 19 Apr 2024 09:30:06 -0300
Message-ID: <CAAq0SUmMdTb5C-SCSD5WPPyj5B1iB6dD5QWuDTsXPnJktFr36g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kunit: avoid memory leak on device register error
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Maxime Ripard <mripard@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 1:59=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Fri, 19 Apr 2024 at 05:02, Wander Lairson Costa <wander@redhat.com> wr=
ote:
> >
> > If the device register fails, free the allocated memory before
> > returning.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> > ---
>
> Thanks.
>
> I'm not sure this is correct, though... Shouldn't put_device() free this =
for us?
>
> The documentation for device_register() says to never free a device
> after device_register() has been called, even if it fails:
> https://docs.kernel.org/driver-api/infrastructure.html#c.device_register
>
> Or am I missing something?
>

I am not freeing the device object passed to device_register, but its
parent structure.

As a side note, the behavior of device_register() seems
counterintuitive and error-prone, IMO. If the function returns an
error, it should ensure it leaks no resource and shouldn't require the
caller to do any cleanup.

> Cheers,
> -- David
>
>
> >  lib/kunit/device.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> > index 25c81ed465fb..bc2e2032e505 100644
> > --- a/lib/kunit/device.c
> > +++ b/lib/kunit/device.c
> > @@ -119,10 +119,8 @@ static struct kunit_device *kunit_device_register_=
internal(struct kunit *test,
> >         kunit_dev->owner =3D test;
> >
> >         err =3D dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name=
);
> > -       if (err) {
> > -               kfree(kunit_dev);
> > -               return ERR_PTR(err);
> > -       }
> > +       if (err)
> > +               goto error;
> >
> >         kunit_dev->dev.release =3D kunit_device_release;
> >         kunit_dev->dev.bus =3D &kunit_bus_type;
> > @@ -131,7 +129,7 @@ static struct kunit_device *kunit_device_register_i=
nternal(struct kunit *test,
> >         err =3D device_register(&kunit_dev->dev);
> >         if (err) {
> >                 put_device(&kunit_dev->dev);
> > -               return ERR_PTR(err);
> > +               goto error;
> >         }
> >
> >         kunit_dev->dev.dma_mask =3D &kunit_dev->dev.coherent_dma_mask;
> > @@ -140,6 +138,9 @@ static struct kunit_device *kunit_device_register_i=
nternal(struct kunit *test,
> >         kunit_add_action(test, device_unregister_wrapper, &kunit_dev->d=
ev);
> >
> >         return kunit_dev;
> > +error:
> > +       kfree(kunit_dev);
> > +       return ERR_PTR(err);
> >  }
> >
> >  /*
> > --
> > 2.44.0
> >


