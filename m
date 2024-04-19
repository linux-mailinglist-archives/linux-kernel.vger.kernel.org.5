Return-Path: <linux-kernel+bounces-151555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AA38AB071
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704B8285A99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6D512E1DE;
	Fri, 19 Apr 2024 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epn20zBx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C112BE93
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535907; cv=none; b=BGjAcGN7HB5RRoPZbluta0a6C58nq5g2kZhvTH/hrO7OW5xGV9LRZNkE2LTG4EAjj1Cbxn/U2poXwBuLGzK4ZAX4EIPguNXFKv0RC7XVYcmMe43t3dHwRT4JB+geq0U/QNvGMLlJu9GnSY1S7Y9GJNhgaNXBFFVBXaG/3zYyCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535907; c=relaxed/simple;
	bh=qBW9kC20d2MgXPK0K7PyE29H/AqaKDpOJmt3FajduGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PT/aKltfMxTrCZtyB7CNqZwn+xhNjqwOdhJd2+Ut6ZyzasusITzjmVbKV6ffD9KC02NjF7shDjoySuMZ9fR/5aJMdw/ajIzzsChxxbKUG8fhuhALfCj8B24YDhqKaZhZc73thzkbdl8IUW/HoP+c6Cxb7fsM0k9Bvygv47JVyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epn20zBx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713535904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veCFJ5s5nwQXNCbj3LY7veh9fp5tYNFk3WMUGDvs+DQ=;
	b=epn20zBxsKjTrwSSIBVLEMJ4mxt1TTar8pRoDdUzbWgb8YHfFy9mq4LHNU0PMzPDDu+ytI
	bcSnSUKHunMZyDZa3HA7A9DSw2JN/Eq25l49QxPB+wDS4nOahXe86rdpDAE59+KsIZxrup
	yx5BlBRxKihZjI35WTQEsL1KpfrO87Q=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-Vv2VOt4QPwKXZdlp5BBFvg-1; Fri, 19 Apr 2024 10:11:43 -0400
X-MC-Unique: Vv2VOt4QPwKXZdlp5BBFvg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c5ed72fe10so2862351b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535901; x=1714140701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veCFJ5s5nwQXNCbj3LY7veh9fp5tYNFk3WMUGDvs+DQ=;
        b=iPvp/VWlSl4eU6ovoDmSKYHH2hfnCBFMN11FLjzc0wj6l6Tl/LV1mmFli9Qpa9IlmK
         MA1g/xgAKeOpBMhSda5nhpwmaqBZQ7a/UndtGH9Nr0MXe1zQR/sL0W8xCrl0jr/gjTKD
         8iQ2FmMIEsiEzxICFuHf23MbANet10aeauL6RYruSXgIC6YjPA66OT5F2LcXiweEGyzm
         aMKwTi6ITpRyMwuRXOFa8aQVWOww0gXyS4L2v9sp9Wn2vu0n8s/Ck2latFhrzARzIhug
         5iOgUH39WdIesFWiJ4rpogdam7YwRXrlmehDmv0ebZ/cPkMXf0ox/G9h3PkcQWq6Dbn/
         IY9A==
X-Forwarded-Encrypted: i=1; AJvYcCWTudD9GjozZMyHQMQNO6ZFipmKvPocGt8zl8KRgUse6o/LwSJsrQkxGMGIZ+lBYjwlssvBT6i0Nrp5gxE7I6AYymPiivZXLj9kC5+2
X-Gm-Message-State: AOJu0YwcFtOKea/0kwoFUst7VrCoCziSwXzTFYcE9gtke/cJp51oOAEG
	l974sEYvde9TMJdHsTTojAezGee2tbKIUMiXThQ8VU/42JiS5lXKmsMmlOCrsOnCpZ5yQk7PxZU
	gdVvphyJ/LGovtRhIAJZ1iMUfSnyOxddyIwFrUPG/UBR7WmdHz3+wUUt34qXHnTpJ9qEYRs20hQ
	vBmZMTW0SPxQNg2CjgkOW4xF9SbazwnU/Klhqk
X-Received: by 2002:a05:6808:429a:b0:3c7:2616:554e with SMTP id dq26-20020a056808429a00b003c72616554emr1983462oib.57.1713535901374;
        Fri, 19 Apr 2024 07:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGZRV9MmeZLQ+H+l4h7XmRd2gRa+8XU74Iwg4+D93gJXQFmHszAJlk1X+qg0QPerkZdmQbcYhJSafs6s24UAM=
X-Received: by 2002:a05:6808:429a:b0:3c7:2616:554e with SMTP id
 dq26-20020a056808429a00b003c72616554emr1983444oib.57.1713535901153; Fri, 19
 Apr 2024 07:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419132504.9488-1-wander@redhat.com> <20240419132504.9488-3-wander@redhat.com>
 <2024041919-unify-improve-d4a5@gregkh>
In-Reply-To: <2024041919-unify-improve-d4a5@gregkh>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 19 Apr 2024 11:11:29 -0300
Message-ID: <CAAq0SUnjc03N5kHgJ8vwk19BjzQr8DCRCokh09npmCs2mxxwXA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kunit: avoid memory leak on device register error
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:03=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 19, 2024 at 10:25:02AM -0300, Wander Lairson Costa wrote:
> > If the device register fails, free the allocated memory before
> > returning.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> > ---
> >  lib/kunit/device.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> > index 25c81ed465fb..d8c09dcb3e79 100644
> > --- a/lib/kunit/device.c
> > +++ b/lib/kunit/device.c
> > @@ -131,6 +131,7 @@ static struct kunit_device *kunit_device_register_i=
nternal(struct kunit *test,
> >       err =3D device_register(&kunit_dev->dev);
> >       if (err) {
> >               put_device(&kunit_dev->dev);
> > +             kfree(kunit_dev);
>
> This still looks wrong, the release function for the device should free
> the memory here, not this kfree, as the reference count in the embedded
> 'struct device' handles the memory logic for the whole structure (if
> not, then something is REALLY wrong...)
>
> You _do_ have a release function for the device, right?  If not, you
> should be getting loud messages in the kernel log when releasing a
> device here.
>

Ok, I got it. Yes, there is a release function. So this patch is
wrong, ignore it. Should I send a v5 with only the other patch?

> thanks,
>
> greg k-h
>


