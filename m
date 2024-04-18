Return-Path: <linux-kernel+bounces-150230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBF58A9C09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BB31F20C74
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685D165FB4;
	Thu, 18 Apr 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6K2/8Ff"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C9548E9;
	Thu, 18 Apr 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448814; cv=none; b=J2ySf3/Sr0+ffPiF/Cyi/x52IvceHHHSZrb22P6ym/Dod6aySt5buw1ynELS9wU1O4XTv1iTewsS7uGDJGGulBQmfgMldes7XaUYOQfERgkM2oilBtw7APFsf4ThCjhhUD74XsV7yjiTFfBo7D5qksF1kOk4e4kiDS4AQb3tYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448814; c=relaxed/simple;
	bh=3x4YtFem5i68pHRvsRarHF+OwK1l9hPtEIyAaNF1kBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSibZyF/DIjTaFKDB8tY0likJPBmeQXH0NrY0PVQIk+iGmZx/HOUFqpiipi0GMd30BO+rM826V1lP3wDjdquvEp6ergeOsjT8Ftsum4CaY4jjxhBYhK7w7IEn1urs9s/rRlZ1PrpQF0MnwcqON+rRbIDUrx476BaCEd3bIxDUME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6K2/8Ff; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3465921600dso758812f8f.3;
        Thu, 18 Apr 2024 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713448811; x=1714053611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrJobdf05VR55MPzvvqAhAZGqW+VKfpfsZCu1Cykk0o=;
        b=L6K2/8Ffw6YzFm/3odFoXhkcsqGYeW05gpz2MJne5Bz9kCPEa3efHHiDdCI/BPFJ0t
         mKR0mbkn8RFqG0z2mzBgheShnrUYLj0lC6UZoCjwMWjwpbUVnuNQzyqt+oq2MAb85v/U
         ltbOv+qR86YD3SY78LiigvnZ4H7iIYwq60ztqSM8ls7Ftj/E5CGx5e7KTYWVJB+oMnSX
         BEWyljaT80LLp24znDy1cLnxfQG8Tu/B6XCbz6lzicmz6MIun2MCjSCUo0t+fPD2KKRv
         0n0o22uOtpp8/F0ZWeHxPqHvLxtZox4S/wzOk4HF0CMbfOYOoIBZSKf5MSWdEXbEmR9C
         vGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713448811; x=1714053611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrJobdf05VR55MPzvvqAhAZGqW+VKfpfsZCu1Cykk0o=;
        b=YFLnfZ6r9k8gObkkzgsb2xHhwhfkk61ldyI9eQj52g/0pET+P3pGtOtEToeU9XN+66
         0dUMTd1Jutcsm2SBt4JgXCxvjxUKq1WrvH+iq/0Gwzl6/woIuYJrmmaHn5GTio+DEooY
         vrt4AyznWXduhWq1FelAWM9SNKpFftY3JiVTcos7Rh9Rf6e17J0LtWKBdEZw5rZAqw5q
         OBbJMtgxpdNBzr3ifZ3P+RuFq/4KF2RtffrDKiFKjXKzd49vkHrAYqLblfbi59frb25g
         7IUfUt7Jwwvg3DvEcnE3yNdeYtrLa5MN98veXVt23q4d0JsvuotRBIQRwiDb0gub8Orq
         Qc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKu3RGAjh2i3Hk9vfh4l9PufzVtSUXyAO+V0trEoYLQjPsYnY/7vxtolMF3yRt6Sa3tYypPGp8HaFUT3bd5cjPZRh3N/B9v0rgJ6GBR1HqxcMzXLrxhqtGPD1zrMaV8xAqsanEByAG
X-Gm-Message-State: AOJu0YyTyB9GaJM8poLgr5jDw271Yo0IwbbhVrHjzfVzBOf/uKhv8eDs
	VMd/PhnykR5CEUiiwxcfrnpGD0hHE8zx7lEJ2x6YsBDkhlgrwDVncdlKxTVl/2NJRZofVNBxAyo
	ZvIf2YFAcfkgvU+BwSf+eVAA5kG0=
X-Google-Smtp-Source: AGHT+IF4io6pWaC1pV+NK3eAMZgzmqLFDQ0IApf4hVd6v3XiYlCwckn3UzXvWbZkzuxlzBatD0+J2HpKSZ+9ShNiJ64=
X-Received: by 2002:adf:e481:0:b0:349:cafd:a779 with SMTP id
 i1-20020adfe481000000b00349cafda779mr1555514wrm.68.1713448811029; Thu, 18 Apr
 2024 07:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZiCp2ArgSzjGQZql@dread.disaster.area> <ZiDECInm854YiSPo@infradead.org>
In-Reply-To: <ZiDECInm854YiSPo@infradead.org>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Thu, 18 Apr 2024 15:58:52 +0200
Message-ID: <CAPAsAGxPEZYBCb30=an8yyku9zNZT74g3n4W_XFCRwLgg=9Xyw@mail.gmail.com>
Subject: Re: xfs : WARNING: possible circular locking dependency detected
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Xiubo Li <xiubli@redhat.com>, linux-xfs@vger.kernel.org, 
	chandan.babu@oracle.com, djwong@kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:56=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Adding the KASAN maintainer so that we actuall have a chane of
> fixing this instead of a rant that just gets lost on the xfs list..
>

Thanks.

> On Thu, Apr 18, 2024 at 03:04:24PM +1000, Dave Chinner wrote:
> > The only krealloc() in this path is:
> >
> >       new =3D krealloc(ifp->if_data, new_size,
> >                         GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
> >
> > And it explicitly uses __GFP_NOLOCKDEP to tell lockdep not to warn
> > about this allocation because of this false positive situation.
> >
> > Oh. I've seen this before. This is a KASAN bug, and I'm pretty sure
> > I've posted a patch to fix it a fair while back that nobody seemed
> > to care about enough to review or merge it.
> >

Sorry, must have been my bad. I didn't find the actual patch though,
only proposed way to fix this bug:
https://lkml.kernel.org/r/%3C20230119045253.GI360264@dread.disaster.area%3E
So I'll cook patch and will send it shortly.

