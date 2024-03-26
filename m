Return-Path: <linux-kernel+bounces-118308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6673088B786
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EF52E7B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97681129E85;
	Tue, 26 Mar 2024 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9tdChCh"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D88128398;
	Tue, 26 Mar 2024 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420730; cv=none; b=RyY9d3El3qSWvypi1fVSeNb6HlrAB3mTWuk14nMc667imj8/8vZVMPCxMbr+LHyjmvZllO6+iCrsflJzLbCXV9EoQjeObleTU89lN9A5LaO9jtqYE8+6RUAdKU3OCbpNC51k67ryKV1s0Eyzg71gHi4uc80KrjyWyrsql7lek88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420730; c=relaxed/simple;
	bh=in6c2v3xl19HUF11Ca5Ajl+w+Eugi73J4PwyZgpMS2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpKk+FMVqe1keMb0w7cveffYBTzd6/5com5wzY9tbvhMSeeqp8bVbyxT8+TTzQ4GVGUlMmORmEUw+Ux4FEGF97IbfQSqHV4BPMMJa1SBWRNWq0fCTGXDEe2XvaSF4rgRRZZKk2mbN+inEwYRn0JGMDr/zou1Y13+ovoYosB1ADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9tdChCh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46de423039so286711466b.0;
        Mon, 25 Mar 2024 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711420727; x=1712025527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvuTO++gksCL8fZc9rnTMteYbv8VDF4X35FDvigGhis=;
        b=Z9tdChCh4afgt/I360grf7kVaHb7bUG7ubWdfd0URRyl49F6kEV6TEBNIfxnLW8qpt
         SgyF5hsNFpmjtRJVolN35t+kAcWZlMX8K/1kROtfGjnuLzXTpkaXb1JGCuxh4cd11H6A
         Sb/kt/65HP23cG9J1jRyieGKZwHozFrF1uhDjldhEdda9r1c3hZ5wpiim69/Qr5rRUip
         GNcxU0rcEKSlT1dl/94r/g5maokc3dcoAuLVdXlQFH9LY7WXIS2PAuEJNz+Rjta7BIMl
         nYhPJactU3LbeT+s08P4SOFlnfwpz/EF4Ffif9GnPeIETGdlDsyFulXg+fatIRtDCdY5
         whzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711420727; x=1712025527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvuTO++gksCL8fZc9rnTMteYbv8VDF4X35FDvigGhis=;
        b=xEhwLEnG8k/9ZoMIpkQQb/wXf985uqlvxiQfwMPrhO7MzhnXXV2lXwrwaWPHrrmn/w
         2Iik4cxPP8EuHl1xN4xq2Znc4k1Xlcl50v6rzZ9ZQU1cNtp0nzG2batyR9rU2p2Zl74s
         BJd7RbGBg5nWmfpsOWsprb/WyJ7i0g5P05li3xg004IcifTLguDaEFG7lVV03/ifeDg0
         1LaOzoLxoxSQ8iy7Gwv8HO0ksVxZ5lEgijQl2Ym3mPaab15ncCkrbHXb96whgmilmMH0
         E6gZXxK3O/SBjs6E9BuQeorHQZVWyqddCtkjc9p0KaGJ1/kN9pPBollCXSzYqeeZO8cp
         REqg==
X-Forwarded-Encrypted: i=1; AJvYcCVYIx3O/m2gi8uT4AJChx2qGd5+Jz4V7JcG3qQ0TsONLSya/9yyo7xzBs/IR3Z5zRwEljmqh3HnoTq6iY/xJC1mbbgOTjR4wmmheO8uBIposQ6zAR2uUZZoIgygrwyup3q8l6y/6mefNCE=
X-Gm-Message-State: AOJu0YwAKpXn1zPfOlGOSFFQQHLv8ESCo7gx0M4GaH0dEPjJ3O0KbEDz
	M2/VTfDx28PNrYw9nu48f/70JTcJKLTjGT06Nk3sazaaNXbQVqYCmNx66LNLtb+Am+Nj6PK5WGd
	oTYrKnprZSpfUXD3dnoOWSVmDY7o=
X-Google-Smtp-Source: AGHT+IHOdLWyBfukeIVQCzdbwxRaGW3vVBOom0CaCVMlu32t8AKYWeJCkDsVov9mGGSIhvtfIDAySQLVgGHxvqfS2+Q=
X-Received: by 2002:a05:6402:520a:b0:56c:d21:d919 with SMTP id
 s10-20020a056402520a00b0056c0d21d919mr5364774edd.34.1711420726461; Mon, 25
 Mar 2024 19:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322214801.319975-1-robdclark@gmail.com> <CABUrSUAykXUoX0y6jzCw1s=E=E08Z54Ygo1TvBm49_iT88oDFg@mail.gmail.com>
In-Reply-To: <CABUrSUAykXUoX0y6jzCw1s=E=E08Z54Ygo1TvBm49_iT88oDFg@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 25 Mar 2024 19:38:34 -0700
Message-ID: <CAF6AEGvK7fBhh36rQyqiHf_qVvsCJhHZjoyOqGqxRPcMZ3dzjw@mail.gmail.com>
Subject: Re: [PATCH] drm/prime: Unbreak virtgpu dma-buf export
To: Dominik Behr <dbehr@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Simon Ser <contact@emersion.fr>, open list <linux-kernel@vger.kernel.org>, 
	"open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b" <linux-media@vger.kernel.org>, 
	"moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b" <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is actually a bit concerning.. importing a host page backed
buffer without guest mapping into a passthru device probably doesn't
work and should be rejected earlier.

I do think we should relax the restriction (either taking my patch or
reverting the commit it fixes) until we work this out properly
(because the original patch is a regression), but importing a buffer
without guest pages into a passthru device can't possibly work
properly.  Maybe it works by chance if the host buffer is mapped to
the guest, but that is not guaranteed.

BR,
-R

On Mon, Mar 25, 2024 at 3:35=E2=80=AFPM Dominik Behr <dbehr@chromium.org> w=
rote:
>
> It also fixes importing virtgpu blobs into real hardware, for instance am=
dgpu for DRI_PRIME rendering.
>
> On Fri, Mar 22, 2024 at 2:48=E2=80=AFPM Rob Clark <robdclark@gmail.com> w=
rote:
>>
>> From: Rob Clark <robdclark@chromium.org>
>>
>> virtgpu "vram" GEM objects do not implement obj->get_sg_table().  But
>> they also don't use drm_gem_map_dma_buf().  In fact they may not even
>> have guest visible pages.  But it is perfectly fine to export and share
>> with other virtual devices.
>>
>> Reported-by: Dominik Behr <dbehr@chromium.org>
>> Fixes: 207395da5a97 ("drm/prime: reject DMA-BUF attach when get_sg_table=
 is missing")
>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>>  drivers/gpu/drm/drm_prime.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>> index 7352bde299d5..64dd6276e828 100644
>> --- a/drivers/gpu/drm/drm_prime.c
>> +++ b/drivers/gpu/drm/drm_prime.c
>> @@ -582,7 +582,12 @@ int drm_gem_map_attach(struct dma_buf *dma_buf,
>>  {
>>         struct drm_gem_object *obj =3D dma_buf->priv;
>>
>> -       if (!obj->funcs->get_sg_table)
>> +       /*
>> +        * drm_gem_map_dma_buf() requires obj->get_sg_table(), but drive=
rs
>> +        * that implement their own ->map_dma_buf() do not.
>> +        */
>> +       if ((dma_buf->ops->map_dma_buf =3D=3D drm_gem_map_dma_buf) &&
>> +           !obj->funcs->get_sg_table)
>>                 return -ENOSYS;
>>
>>         return drm_gem_pin(obj);
>> --
>> 2.44.0
>>

