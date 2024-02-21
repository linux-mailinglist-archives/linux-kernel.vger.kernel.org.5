Return-Path: <linux-kernel+bounces-74394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5785D361
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DE9288C71
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D673D3A0;
	Wed, 21 Feb 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4VwYngi"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10B3D0C0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507385; cv=none; b=lxm3mTJuGaKoDqCVk4z7qyRrER53hos2MXJ8BI5/3zmLCUgZG4n0snWIx4iVfDALs+khnJDDa9Mg6HX0QYkafvY+Pa3s/QVwlOgiN5Bqm+TL4/OocLM0gUwsEptIX22VZGikcgmMlaH4jXo1yNN7Dmrj9qCbhfxKQMB9Yor0/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507385; c=relaxed/simple;
	bh=K+gCIizEIOhF3THCA2HhsJVEYG4bJvjGS9rZ4eiaFR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/7tJfq9HiciGJgbifRBXuvu2Sjyvg4DVhqeMEk8tGqTnrJ6Fs1/zIaOzyXrGQ55CKC6UaEbp4tN1wJvKO2e4/28bnpzmPAOiXubBFoPW+0n3AFOMC8Hb2yLf+YVZ0B69y9gRh0/Nc7taJGapSEcx+aoAeSZ8uS+q4uoXhfJzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4VwYngi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso7166a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507382; x=1709112182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8Iw+ecnsAvxKiT4ujJzI0in5wASuEUFoB3j6AJ1Ekw=;
        b=o4VwYngi+VEtdgvjFZw90hyG3NDQnRtUUxGoDJ77v95hA/IE7CFRa3xGt/0GcEaYXw
         mU7ynDtnpQSawYUB+WECzesZE7u5rzp3OITErpJ2nld0dVY5+8dMlVhkeYrqPfiAMwKm
         H8Hh3Y/3nE5H1qXnealBgI2Uk59GUXC/iKQnBlJhAPYQWUywzm6wl4otTDm/B0ty33OJ
         AW7Ti+4vmqyzAOAtBqxX1VoGoPLh4+Pid+WBX/z/zFsebT9S8XZVTpif6ywVIHLdu5t+
         EuQ9Hn/9+OkpvtokhF/qWROB20GNq6fqnckG0SkDmFvqzRSRbt5fQGe9K+UhemeThnYU
         u+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507382; x=1709112182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8Iw+ecnsAvxKiT4ujJzI0in5wASuEUFoB3j6AJ1Ekw=;
        b=ae62pt+dfUxK/UIKJnYB/6udNyyETbaW5NBoiT9QARwsLLJAiN/DpwRERnbc+PZbIT
         UPEZiwydWOLAxL91/CJLGozAd2dwRMb/UhqHZQOnIXAicp8zKBEYCvBS7rAVcl2pC5ks
         H+toZrfbEaXjlsK6s0fwZi252YpDnnDUaEeqcdTV5GEyqY+MQnJnnHbdXZw3KB89ZchT
         Ut6k2EOsyo5cggUSkq+z3QTRY1cypqySWI/AscSf0SRqLGuYVzOAwwD2+2dMNyQZQeWT
         RlC5UOvHf7fMALTjmulmy1YsUWJIR/M5JOHsPjxYX8Ws2jato6Lfij+IwqZvtTNWeszG
         Bebw==
X-Forwarded-Encrypted: i=1; AJvYcCVhD2EiVWRAONP9d61ID6Pw9NU0UNzy3snkp9PsNAEKGzb3hChfHU/JEwfnyabhpHnk/18TgpWYblrZhytbqOsHn7NNnibXHzHb5PBA
X-Gm-Message-State: AOJu0YwocB74IJdf+oWXJIcSWga3rhcSxhQXdiEIdip38IT9EY/cCt5Q
	wSK7QJXZn7ka6WqENU/adH2zHgiV1P3bxMiD33CI3Oe97Hzsq3ctLpnZJJFmHTCvc9cVzHpJxej
	7muN9opvSZzQotfi67unJ11/wOY2SMys5bCJL
X-Google-Smtp-Source: AGHT+IEy6kNcDvH8qV/VRy8uplqs4byx2iWbcUCj2utl/wZ7ZtNrmbmJN8hiP8u5MtxV1VFQ7vtdsIPdMmY5qpXruRs=
X-Received: by 2002:a50:bae7:0:b0:563:fc50:37f9 with SMTP id
 x94-20020a50bae7000000b00563fc5037f9mr84099ede.3.1708507381744; Wed, 21 Feb
 2024 01:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219061008.1761102-1-pumahsu@google.com> <20240219061008.1761102-3-pumahsu@google.com>
 <2024021906-celestial-tuesday-bd24@gregkh>
In-Reply-To: <2024021906-celestial-tuesday-bd24@gregkh>
From: Puma Hsu <pumahsu@google.com>
Date: Wed, 21 Feb 2024 17:22:24 +0800
Message-ID: <CAGCq0LYYkg0NR2pVS0sTn0vrW3oWXoSg6DgJN0v8ADY_poykag@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: xhci: Add support for Google XHCI controller
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, Thinh.Nguyen@synopsys.com, badhri@google.com, 
	royluo@google.com, howardyen@google.com, albertccwang@google.com, 
	raychi@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 2:30=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Feb 19, 2024 at 02:10:07PM +0800, Puma Hsu wrote:
> > diff --git a/drivers/usb/host/xhci-goog.c b/drivers/usb/host/xhci-goog.=
c
> > new file mode 100644
> > index 000000000000..db027a5866db
> > --- /dev/null
> > +++ b/drivers/usb/host/xhci-goog.c
> > @@ -0,0 +1,154 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * xhci-goog.c - xHCI host controller driver platform Bus Glue.
> > + *
> > + * Copyright (c) 2024 Google LLC
>
> This code is older than 2024, right?  :)

Yes, this actually started from 2023, will fix it.

>
> > +     if (WARN_ON(!sysdev->dma_mask)) {
>
> If this triggers, you just rebooted your device (as you run with
> panic-on-warn enabled), so please, if this is something that can
> actually happen, handle it properly and move on, don't reboot a device.

Thank you for advising. Will review and handle it properly.

>
> > +MODULE_ALIAS("platform:xhci-hcd-goog");
>
> Why is this alias needed?  I thought that was only for older-style
> platform devices

I will change to module_platform_driver(). Thank you for advising.

>
> > +static int __init xhci_goog_init(void)
> > +{
> > +     return platform_driver_register(&usb_goog_xhci_driver);
> > +}
> > +module_init(xhci_goog_init);
> > +
> > +static void __exit xhci_goog_exit(void)
> > +{
> > +     platform_driver_unregister(&usb_goog_xhci_driver);
> > +}
> > +module_exit(xhci_goog_exit);
>
> module_platform_driver()?
>
> thanks,
>
> greg k-h

