Return-Path: <linux-kernel+bounces-150561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69508AA0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074CB1C218BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0743172BD8;
	Thu, 18 Apr 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxJqzSj7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680A171E6C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460754; cv=none; b=YiAHSaTuXe577m2phv7kE1QsfXVN6A6FW/IbUa5Kf9V/bBk6SXgUzyXnLRgRKGf44Unla1HbkgOJhWEd0VMQ3jgPrEDcShfACCrSaukVNXGkJ+OSWFXiQOJjgfieFbKlkv5yz7PL12lh3TOpWkPck3HPoEz5/6VehcM2gQQlyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460754; c=relaxed/simple;
	bh=z8deP5JiCX4tE0osRAabfU/ka6kCpJORJ3z3SrfiQSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkLGpSr9eNpNgRCTPF0Gwmme2j7QP1Nakpzok6YLf94xC+GLHFF0Mmi5GC5mBkCx3RGFD0VU5XnIuyxQowRVk/iVgZK0GGBQWEPb63TQaiIzS8zb84o4m83zPOXPCRQJ31BWUtHIxnUurIzEQHqvQX22WV70WpiwLdDlG+M/6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxJqzSj7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713460752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5bV22Y6v5pDARLpQxuhoUtFKqLzg5Cehfkskiq3Udg=;
	b=SxJqzSj7R9u0s2zf1ptS+nOKQ8jRCRjq5Km8Hf6YQNC5bCAt18v7TuPQBwGqA3vUkPMPfO
	3f6pBiJguCc2kARezjcMDDjnocMbo61wnBfyVKwouRumIsK3cMSdllLRp1o/Rhi593kVa3
	L5w0V73RbGMliDoknlDZAc3f6mh/B7Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-x1Y1IXb-OR6tsYYaZ5Y7KQ-1; Thu, 18 Apr 2024 13:19:11 -0400
X-MC-Unique: x1Y1IXb-OR6tsYYaZ5Y7KQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43689467973so16064231cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460750; x=1714065550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5bV22Y6v5pDARLpQxuhoUtFKqLzg5Cehfkskiq3Udg=;
        b=Fhh6CwyQsE6qUEOAedKIkYUjKQObezcOip3oQNf1BnXsgdD3+5LhOD9DNM59xcODQq
         H2FVtTnzBHzyqlT6To6oA/9Av5GSLEgDp4e1T4jWquedUksize/5rIjLrrDidudePCtu
         rW2Y/MwFMe9flyobRZiqW2r41/mWP3Ilm8z2HDWEko1XOG/+v4nVBs/vQcN2b+onh8XJ
         s3z94SMDs5wF/22Hpcq4ed4w78SLnhv38MgkxDlSgiGrXaGW2yviDYgIc0onoxuUnuGr
         SY1iinvKlNwQvCYzDaqRfQidky4bCwAuoz1hZidF8JsGuJ4meVhEGizT8Lk7yGYjtSJy
         czIg==
X-Forwarded-Encrypted: i=1; AJvYcCXqtyxrphMfaP8JqWF3Pkdqw/tWGS2vNDGDYb9IOo80f3ANqXHmZFqBezB2qSwxw3uaSrVmIxsAvoH+wi6f1d53FhjrNRO2vSzxTbzr
X-Gm-Message-State: AOJu0Yx81xnR+rtlMmQH1vyylLDjJfprdBMRJGUX/EnsavzS8JHOlLC8
	iaug/GymBzHbrVFA5HrKCMqYWg1SXAVQRHA98bjJ/D00reZ9/zGaAMH/O5OHP3yajqj7k2PiNp+
	1h72VdKQrxhFN/uu5+CB4YVGLDntjtqvsY3NqZHmkvBu8kB5KMPzF+bEztYP7MBd54WVmSA4/b+
	/QySj3+nb0QIgTq4NwZmKDyN5PNbS6qBcFu0De
X-Received: by 2002:a05:622a:f:b0:436:ba2a:4aef with SMTP id x15-20020a05622a000f00b00436ba2a4aefmr4004842qtw.52.1713460750349;
        Thu, 18 Apr 2024 10:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKngSjSF6iWF1QhKj/ESh69oayLe4joJMZzFJEgkEVk0tUD3zJIsN6uNqpnXh8+kDRMgV0RR3zJNphOH8wO8g=
X-Received: by 2002:a05:622a:f:b0:436:ba2a:4aef with SMTP id
 x15-20020a05622a000f00b00436ba2a4aefmr4004823qtw.52.1713460750106; Thu, 18
 Apr 2024 10:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418131754.58217-3-wander@redhat.com> <9ff84256-c7d2-48e5-b06b-09a993db2c39@web.de>
In-Reply-To: <9ff84256-c7d2-48e5-b06b-09a993db2c39@web.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Thu, 18 Apr 2024 14:18:59 -0300
Message-ID: <CAAq0SUk7nJ80rrMG+zeVi-XReVJ7sdWTAT9fmi4E+LpYAYa=OA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: avoid memory leak on device register error
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:24=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
de> wrote:
>
> > If the device register fails, free the allocated memory before
> > returning.
>
> * I suggest to use the word =E2=80=9Cregistration=E2=80=9D (instead of =
=E2=80=9Cregister=E2=80=9D)
>   in the commit message.
>
> * Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?
>
>
> > +++ b/lib/kunit/device.c
> > @@ -131,6 +131,7 @@ static struct kunit_device *kunit_device_register_i=
nternal(struct kunit *test,
> >       err =3D device_register(&kunit_dev->dev);
> >       if (err) {
> >               put_device(&kunit_dev->dev);
> > +             kfree(kunit_dev);
> >               return ERR_PTR(err);
> >       }
>
> Common error handling code can be used instead
> if an additional label would be applied for a corresponding jump target.
>
> How do you think about to increase the application of scope-based resourc=
e management here?
>

I thought about that. But I think the code is simple enough (for now)
to not require an exit label.

> Regards,
> Markus
>


