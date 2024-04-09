Return-Path: <linux-kernel+bounces-137333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BAC89E09B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8917A1F21989
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A436A15358D;
	Tue,  9 Apr 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGGXWA65"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFBB153574
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680641; cv=none; b=Z0/nYvW3RpBlIvyXI3UwIKvAJeVR2mX1uWNN4s+oZZfpv0nVn4avJWF5hFCbrdXD/ulGpzbYTNed0g8Jc1MJQSEquj2Qrml73Y/FzpBLxdTbM4e6WxVAj8nfSEeF6axoCV9Pk2fBhXzY2Q2Kvdcw+sMyMIFmGw4zNvpZS1lvrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680641; c=relaxed/simple;
	bh=HdCPsHozXYwytuqNw0ZGiEDF8p+ZYozg6NI6BJrhggw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbMmlaT54AdnvCaFHwUJf/cqp+XyVsS1Tij7TONUeyINETkK/t4neGxdlH640feBwsOZCQkLY7qNYH3hi4ZdFYyYciAurmGfHzXUalkwt/y0aO6AFBpOodQSCxP3jjRQUyZ96gVRnMbDHMyr+UQorRR4EjsI+TJtF7gx2mwLgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGGXWA65; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc742543119so5592291276.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712680639; x=1713285439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWrgc6fSc3w4dKU6IsZCUM+SMdZmjryY3zaMUJ1lg5M=;
        b=uGGXWA65SXFIIj2rsXWkBxBOk3P8Bnitw0HHVrRv3Y1Pm8FMSQE6N9O2Ax54Bfjusr
         KPmgw/Bd57hKZkE40jDYgve8SIuxkKTbP6eEs6zTpAMwesNgNjKBpa6Okx5LS7X0y77g
         3QdzW8HB95QZPmxtT7ot9q0IpM28mQetfoFb9gCZCfBN59nBzFdS2L0XA6B+zxjZAsEa
         D1hpi2n0MgB7+XCBajpI+c5LTe8j7KCd6iUpNkVeLTpAd6nM1GgtxI+kyG4Uu4314+mn
         pBDm710ePO9fJ42fOJyURyF2CKocu+y+U8LKpzP67GmyU3rpNcstS/sH8cLQzar3eC+O
         rLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680639; x=1713285439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWrgc6fSc3w4dKU6IsZCUM+SMdZmjryY3zaMUJ1lg5M=;
        b=Ca4DD4hErhqHQsblftLg9gkNwNM+9nUSwHvynw1c4+J1d54Iab8hkNyvnn1b+wNh5D
         Cy2eS8Iv2So4dpvwCKLCQsa9ffqci/Ayc3nAqelzGTXz71Y0NFzKj09nYsgmNAGdOg9P
         Zfm2tJjspHnGOXdAWbcTMjeSENek9MVg3bhC+MvlCnVjyJx7xCR7+eH84XddgO7Mgdpl
         6GL5xREWsuUjdHPB05s41ckvxUzgEoVBO8/CdXON8wjAgdd5Xtv1BWtz375LiVlnaHDM
         mh5wfDOXet8XR9+n3bsZJTrCOhO1ex2d0ULvRtNfiP4Cr3wXwsqD30b4DbX6X31L3YSJ
         GgYA==
X-Forwarded-Encrypted: i=1; AJvYcCWfnIYc460WHhpvdGc7jfTlj9YECO9oVVt53fS3AgwSroVi7jweTDKnKsDr7u7qwnWuYexMOkx+bW/r19mzKzbw9EP+1XLHoqh6eeI+
X-Gm-Message-State: AOJu0YzOLN01mQthIfDS8IMN5Ur5gxdhn8wV/40JBtTs3lDW9C7nw8n/
	NGK/YbSLxPNY/Euxd6KmCwRjpcIx7SymEREXdc99od5EiezOsdf54To2Zf6Eq/K9LlxQujdGl1D
	oa2kZ4+mD1xC+b/XM+8nCgfCiuqWyMHb0/N05
X-Google-Smtp-Source: AGHT+IGJRrnZd6GpHhz2e2NeVhdfIMLHOtWWI1dHIs7kshaTz2NJhrtoPZ84nV+L11Kpx9q3bco9EMqTwIkVE14CEDU=
X-Received: by 2002:a5b:cc8:0:b0:de0:de50:d6d4 with SMTP id
 e8-20020a5b0cc8000000b00de0de50d6d4mr296806ybr.8.1712680639127; Tue, 09 Apr
 2024 09:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20211113062222.3743909-1-jay.xu@rock-chips.com>
 <1da5cdf0-ccb8-3740-cf96-794c4d5b2eb4@amd.com> <3175d41a-fc44-4741-91ac-005c8f21abb8@vivo.com>
 <9e6f1f52-db49-43bb-a0c2-b0ad12c28aa1@amd.com> <5c7ac24c-79fa-45fc-a4fd-5b8fc77a741b@vivo.com>
In-Reply-To: <5c7ac24c-79fa-45fc-a4fd-5b8fc77a741b@vivo.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 9 Apr 2024 09:37:07 -0700
Message-ID: <CABdmKX1OZ9yT3YQA9e7JzKND9wfiL-hnf87Q6v9pwtnAeLHrdA@mail.gmail.com>
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

On Tue, Apr 9, 2024 at 12:34=E2=80=AFAM Rong Qianfeng <11065417@vivo.com> w=
rote:
>
>
> =E5=9C=A8 2024/4/8 15:58, Christian K=C3=B6nig =E5=86=99=E9=81=93:
> > Am 07.04.24 um 09:50 schrieb Rong Qianfeng:
> >> [SNIP]
> >>> Am 13.11.21 um 07:22 schrieb Jianqun Xu:
> >>>> Add DMA_BUF_IOCTL_SYNC_PARTIAL support for user to sync dma-buf with
> >>>> offset and len.
> >>>
> >>> You have not given an use case for this so it is a bit hard to
> >>> review. And from the existing use cases I don't see why this should
> >>> be necessary.
> >>>
> >>> Even worse from the existing backend implementation I don't even see
> >>> how drivers should be able to fulfill this semantics.
> >>>
> >>> Please explain further,
> >>> Christian.
> >> Here is a practical case:
> >> The user space can allocate a large chunk of dma-buf for
> >> self-management, used as a shared memory pool.
> >> Small dma-buf can be allocated from this shared memory pool and
> >> released back to it after use, thus improving the speed of dma-buf
> >> allocation and release.
> >> Additionally, custom functionalities such as memory statistics and
> >> boundary checking can be implemented in the user space.
> >> Of course, the above-mentioned functionalities require the
> >> implementation of a partial cache sync interface.
> >
> > Well that is obvious, but where is the code doing that?
> >
> > You can't send out code without an actual user of it. That will
> > obviously be rejected.
> >
> > Regards,
> > Christian.
>
> In fact, we have already used the user-level dma-buf memory pool in the
> camera shooting scenario on the phone.
>
>  From the test results, The execution time of the photo shooting
> algorithm has been reduced from 3.8s to 3s.
>
For phones, the (out of tree) Android version of the system heap has a
page pool connected to a shrinker. That allows you to skip page
allocation without fully pinning the memory like you get when
allocating a dma-buf that's way larger than necessary. If it's for a
camera maybe you need physically contiguous memory, but it's also
possible to set that up.

https://android.googlesource.com/kernel/common/+/refs/heads/android14-6.1/d=
rivers/dma-buf/heaps/system_heap.c#377


> To be honest, I didn't understand your concern "...how drivers should be
> able to fulfill this semantics." Can you please help explain it in more
> detail?
>
> Thanks,
>
> Rong Qianfeng.
>
> >
> >>
> >> Thanks
> >> Rong Qianfeng.
> >
>

