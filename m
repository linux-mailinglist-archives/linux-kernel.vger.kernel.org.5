Return-Path: <linux-kernel+bounces-141358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C291E8A1D36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7591F240D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CB4146D5F;
	Thu, 11 Apr 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="O3IHB9DW"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367C482CA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854386; cv=none; b=Vr7OpfP2p6oJ5KyPvfntsgcXFsw3KLKHrZRlNaXIN7Xbadt9IXRRLU+4nkHMIj03WHopVaARZxOP42Qwoj7Fc0RR2NBBfl/aYpwLrofD1ogRQ++LZ8M1cyxo6tJKXdcwafgojoHB4NKIE4nVeniaZCBGDw7JhIHdJmfEMzcHOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854386; c=relaxed/simple;
	bh=AeYBArhI/qCfLSv0Zo44jUHHp6STwez+9qRuFMcKxxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpkTd2upGx/PuOycRdrU1NgwXyGUotTAHM9sD1bjwh8H858d1Zaj17fw0MphZRtTbZ4SeUhHnGBXKNBg/L95tc/LsfY43Wq5xj4t/jOCTX3BtOeKDI8R36au7lNg8HI2wZ3K6P9j/udf4zxxl7SwFrYdBZIHO2HBa0o0wFQ/X3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3IHB9DW; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dd161eb03afso26362276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712854384; x=1713459184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk9ow4mQo0ztyiO7KrDlitvaa4igMglZOi5Xwvcpnhc=;
        b=O3IHB9DWxrXhWSwDTdtix6ux958upK2GaXEGyeJxt39OhW0y1/bPs6zrB7M98yNLbc
         gZRY3lQg7ebYJdcH5aQf0RqgYhsSq9Ds2td9wnpVr5hWX2VG/BRSbYICJx6qa0zg6mO6
         Czp4Q89af8xLL0d9QD9dslflL08RefBTVLvyOkaGmwdrPwMJspIKM2Foj2v4qwFSPsxh
         WmBbAICnhQYyYDFmL/BpJxzl5VmLTPC7Pnxn7ZEJN9urb7voA4QxWOC5mpIA2+NdZPuz
         VWFzIJCaBgKGTyvXJ0yU2tO/YKUZmjNC2MhF6jSNnpOfhhbypee+9asKkFFQST9lOwzC
         aHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712854384; x=1713459184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk9ow4mQo0ztyiO7KrDlitvaa4igMglZOi5Xwvcpnhc=;
        b=qWMPOm5CvyyFgjuj7TlF5/0YuPNmJjPMVRLQNUl8wkmA2/4owwVNIoWDVYKOuepoXy
         J2l4WNv2op+mb8N+Y+ASE6wtOWN95KU2db29ZFSky7PhaGu+f9aXl6qM76MQv7SWnPt3
         2Z/E0feC5bysaXoz9JRtlNtPlkZMVNMf8Lz00dkRa7GdMuFycrRlkF2UByazcuxJcW5J
         S21oZaCd0qb3drSBFQGc9IsI7QqWoFdbq8WsgEjV2+H1PyK8d1CAqxhvUG3iGvqD6Zzj
         kNCuNEzFkIgud+EL2r9YSWKp20YwAFHYEhwwcJFQz2cerrQRmTzNZ+0Ec5lUPgHdtT81
         lpVw==
X-Forwarded-Encrypted: i=1; AJvYcCWwlPke0KJlQ3AdYxU7N6IxSoBWKv6nOMG1Icsf08Zok+tu1t1ladHWoW8HqXcF1Pgw/qBx8yUpz7daKlNxw8htAdoegRtB1C3GCCA+
X-Gm-Message-State: AOJu0YxZ/+REA1f7UVOwmmo3j57UzBAwIhvjTnGdzvwKvwBaAZoHs9BW
	DuEnOPBRDL5+QEy6W3Czii61gaBUC5l/5NOT01BHEOqUDjIPOMV0B90kNoEAYubwGY7zprvAPlA
	S7n1PFUKNJug7luntLGLCKo5k+uKjTEmCjwDg
X-Google-Smtp-Source: AGHT+IHrAmk4FEak1U24FFhz5I0pjJ4Y1W1GoH1d+YXdH2uAvcc4gxTiyypFZ0hyOkDoXT/aukk4rEfY2anMtoK+l4s=
X-Received: by 2002:a25:86d1:0:b0:dc6:b088:e742 with SMTP id
 y17-20020a2586d1000000b00dc6b088e742mr112053ybm.8.1712854383276; Thu, 11 Apr
 2024 09:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20211113062222.3743909-1-jay.xu@rock-chips.com>
 <1da5cdf0-ccb8-3740-cf96-794c4d5b2eb4@amd.com> <3175d41a-fc44-4741-91ac-005c8f21abb8@vivo.com>
 <9e6f1f52-db49-43bb-a0c2-b0ad12c28aa1@amd.com> <5c7ac24c-79fa-45fc-a4fd-5b8fc77a741b@vivo.com>
 <CABdmKX1OZ9yT3YQA9e7JzKND9wfiL-hnf87Q6v9pwtnAeLHrdA@mail.gmail.com> <da21fe55-2ffb-4c8e-9863-2f27aa18cf5c@vivo.com>
In-Reply-To: <da21fe55-2ffb-4c8e-9863-2f27aa18cf5c@vivo.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 11 Apr 2024 09:52:51 -0700
Message-ID: <CABdmKX0AJjdVBPR=3c7oRyDRQx86GCGheVwkheXi7fOkJaRY8A@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: add DMA_BUF_IOCTL_SYNC_PARTIAL support
To: Rong Qianfeng <11065417@vivo.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Rong Qianfeng <rongqianfeng@vivo.com>, Jianqun Xu <jay.xu@rock-chips.com>, sumit.semwal@linaro.org, 
	pekka.paalanen@collabora.com, daniel.vetter@ffwll.ch, jason@jlekstrand.net, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:21=E2=80=AFAM Rong Qianfeng <11065417@vivo.com> w=
rote:
>
>
> =E5=9C=A8 2024/4/10 0:37, T.J. Mercier =E5=86=99=E9=81=93:
> > [You don't often get email from tjmercier@google.com. Learn why this is=
 important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Tue, Apr 9, 2024 at 12:34=E2=80=AFAM Rong Qianfeng <11065417@vivo.co=
m> wrote:
> >>
> >> =E5=9C=A8 2024/4/8 15:58, Christian K=C3=B6nig =E5=86=99=E9=81=93:
> >>> Am 07.04.24 um 09:50 schrieb Rong Qianfeng:
> >>>> [SNIP]
> >>>>> Am 13.11.21 um 07:22 schrieb Jianqun Xu:
> >>>>>> Add DMA_BUF_IOCTL_SYNC_PARTIAL support for user to sync dma-buf wi=
th
> >>>>>> offset and len.
> >>>>> You have not given an use case for this so it is a bit hard to
> >>>>> review. And from the existing use cases I don't see why this should
> >>>>> be necessary.
> >>>>>
> >>>>> Even worse from the existing backend implementation I don't even se=
e
> >>>>> how drivers should be able to fulfill this semantics.
> >>>>>
> >>>>> Please explain further,
> >>>>> Christian.
> >>>> Here is a practical case:
> >>>> The user space can allocate a large chunk of dma-buf for
> >>>> self-management, used as a shared memory pool.
> >>>> Small dma-buf can be allocated from this shared memory pool and
> >>>> released back to it after use, thus improving the speed of dma-buf
> >>>> allocation and release.
> >>>> Additionally, custom functionalities such as memory statistics and
> >>>> boundary checking can be implemented in the user space.
> >>>> Of course, the above-mentioned functionalities require the
> >>>> implementation of a partial cache sync interface.
> >>> Well that is obvious, but where is the code doing that?
> >>>
> >>> You can't send out code without an actual user of it. That will
> >>> obviously be rejected.
> >>>
> >>> Regards,
> >>> Christian.
> >> In fact, we have already used the user-level dma-buf memory pool in th=
e
> >> camera shooting scenario on the phone.
> >>
> >>   From the test results, The execution time of the photo shooting
> >> algorithm has been reduced from 3.8s to 3s.
> >>
> > For phones, the (out of tree) Android version of the system heap has a
> > page pool connected to a shrinker. That allows you to skip page
> > allocation without fully pinning the memory like you get when
> > allocating a dma-buf that's way larger than necessary. If it's for a
> > camera maybe you need physically contiguous memory, but it's also
> > possible to set that up.
> >
> > https://android.googlesource.com/kernel/common/+/refs/heads/android14-6=
1/drivers/dma-buf/heaps/system_heap.c#377
> >
> Thank you for the reminder.
>
> The page pool of the system heap can meet the needs of most scenarios,
> but the camera shooting scenario is quite special.
>
> Why the camera shooting scenario needs to have a dma-buf memory pool in
> the user-level=EF=BC=9F
>
> (1) The memory demand is extremely high and time requirements are
> stringent.

Preallocating for this makes sense to me, whether it is individual
buffers or one large one.

> (2) The memory in the page pool(system heap) is easily reclaimed or used
> by other apps.

Yeah, by design I guess. I have seen an implementation where the page
pool is proactively refilled after it has been empty for some time
which would help in scenarios where the pool is often reclaimed and
low/empty. You could add that in a vendor heap.

> (3) High concurrent allocation and release (with deferred-free) lead to
> high memory usage peaks.

Hopefully this is not every frame? I saw enough complaints about the
deferred free of pool pages that it hasn't been carried forward since
Android 13, so this should be less of a problem on recent kernels.

> Additionally, after the camera exits, the shared memory pool can be
> released, with minimal impact.

Why do you care about the difference here? In one case it's when the
buffer refcount goes to 0 and memory is freed immediately, and in the
other it's the next time reclaim runs the shrinker.


I don't want to add UAPI for DMA_BUF_IOCTL_SYNC_PARTIAL to Android
without it being in the upstream kernel. I don't think we can get that
without an in-kernel user of dma_buf_begin_cpu_access_partial first,
even though your use case wouldn't rely on that in-kernel usage. :\ So
if you want to add this to phones for your camera app, then I think
your best option is to add a vendor driver which implements this IOCTL
and calls the dma_buf_begin_cpu_access_partial functions which are
already exported.

Best,
T.J.

