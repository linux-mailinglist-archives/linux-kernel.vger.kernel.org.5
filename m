Return-Path: <linux-kernel+bounces-162808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF82C8B60CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39571C20FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A5129E75;
	Mon, 29 Apr 2024 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAYoCZsD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45268127E24
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413273; cv=none; b=ofMyFFem9UuDz6or5UmIvBx/rlv4lPFLv93751U8K1E20j728UC0Qi/j3xWdPZjv9SJhx9ylh1tn/eZ6K+5Li7uannAN4MfhkxYubiCknHQS4FuzXwxgrZvoqCMmtaDqcoOBH6hlj/ZALC48g3k3UyeXZFqBk2X2CgT9qkJi9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413273; c=relaxed/simple;
	bh=mQ+dViiISiBY3UUx7HmdmAIQtmXneM2PNlajVKBffc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mef9wz0H5/K5APc72NvoHZHg97SwDhcmArVVop01c6hlvXyzjBZRNJQ3j7sQ2m/fVr49nQcDVo4J3kk5d0sb8x1ykl9F81SIiiAVlw/LAl+vK3oEU1F0MFei/5Dn3CHfCZz8oOKNiUlIwhP1np4pCpqjelTkWBHDkQcpDCVMhjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAYoCZsD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714413270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ype1v6kiFfmsjABNIIcOV532jtXMQZ0jQQvVfGIFAzE=;
	b=cAYoCZsDiMFQSaVGPKsH20DEc2dSzW1t6v3SV0AKWFbuN7quAj+nUg9WoeLTjQnW3ha+ne
	mvM4iMDRpvNFAIU7RM7DDuRIJu7Hpuqcsb30p0ZGkTH2AJ8kLxD8Qf7TVeBChhq10zwvgW
	bKraZ3RAU1zWvwxGUWtTKM7BRft7yf0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-G-ZmSKAvN-KHzFpm0uZwmg-1; Mon, 29 Apr 2024 13:54:28 -0400
X-MC-Unique: G-ZmSKAvN-KHzFpm0uZwmg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78ed2a710efso607289085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714413268; x=1715018068;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ype1v6kiFfmsjABNIIcOV532jtXMQZ0jQQvVfGIFAzE=;
        b=v/6pgwYXG39fF/oasBmVaNcQq8HBBXn23LmETx5cdn3i0vO2epfm1cCA6GV+nHYsLW
         GBbAx9viOqc/ePBKFiKPUfo7f1gv5A97UktWc7z1hEZhZ5bRAOVKNbe8NgFPod/r7jIE
         cnUdQNxIYjtk6inOJZSj4QLykbE6K3WirWKfebHsZP5MMoUcVao9JpH9cDBG+z/8SgvY
         jHBhgJluvDS195RkWEX7rHeT8BtZjwespB5/AOHw3UfieoLrdqdq5lR9OtRjWBUKnWDT
         PqLAni+jEhfOAQ5wg9lvjNGm5viw+e+lzWNWlQkkhAoIM4uPVXi7adoqnIjbIUPA59N+
         Xzdg==
X-Forwarded-Encrypted: i=1; AJvYcCUS/3uT1Fz/heLobm5xZOfB4gLCl993Fd5CQ7NAJEwI2O46BWQq9H6A7s87SZezGCayoJrZAoMPXKp8YzFCfv8w9eIYO3iHFS5ZNX8L
X-Gm-Message-State: AOJu0YyLwptPGr0ZXToCjYgRWrfe4pmAdSXzPnwPzaoi5YtMYmxc/HPC
	88qzz+TaawVrhV2NmlH+TDIu2HGVokDKdJqG8oAeEUknHrrX/zPiWNoJiY+RkxOTUY3/A9igVpM
	NjY3xC14F5mn7MPsjwxkCdJyHJ2h8lU5Bj+MzXeaxf1Nwb0xTp/moZPlO4sd0RQ==
X-Received: by 2002:a05:620a:4045:b0:790:c01a:2c20 with SMTP id i5-20020a05620a404500b00790c01a2c20mr288984qko.74.1714413267785;
        Mon, 29 Apr 2024 10:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4ju2zz7vG7FCZK0OPUJOhir1BIvHKqGWTvYWM2+TupK/mAQcQx7+iEqSQG0BoImvyK7vcNA==
X-Received: by 2002:a05:620a:4045:b0:790:c01a:2c20 with SMTP id i5-20020a05620a404500b00790c01a2c20mr288962qko.74.1714413267417;
        Mon, 29 Apr 2024 10:54:27 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c6c:a300::789])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a13e600b0078f044ff474sm10696246qkl.35.2024.04.29.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:54:26 -0700 (PDT)
Message-ID: <ba3e7914e816f893bdba9aebe045f9af04ed85a6.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/nouveau/gsp: Use the sg allocator for level 2
 of radix3
From: Lyude Paul <lyude@redhat.com>
To: Dave Airlie <airlied@gmail.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Karol
 Herbst <kherbst@redhat.com>, Danilo Krummrich <dakr@redhat.com>, Daniel
 Vetter <daniel@ffwll.ch>,  Dave Airlie <airlied@redhat.com>, Ben Skeggs
 <bskeggs@redhat.com>, Timur Tabi <ttabi@nvidia.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, open list <linux-kernel@vger.kernel.org>
Date: Mon, 29 Apr 2024 13:54:25 -0400
In-Reply-To: <CAPM=9txB5Zhyyno-GLD_JShV-GZd8hgYVh=Ok=Skmzs=eTi64A@mail.gmail.com>
References: <20240426154138.64643-1-lyude@redhat.com>
	 <20240426154138.64643-2-lyude@redhat.com>
	 <CAPM=9txB5Zhyyno-GLD_JShV-GZd8hgYVh=Ok=Skmzs=eTi64A@mail.gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 16:03 +1000, Dave Airlie wrote:
> > Currently, this can result in runtime PM issues on systems where
> > memory
> > Luckily, we don't actually need to allocate coherent memory for the
> > page
> > table thanks to being able to pass the GPU a radix3 page table for
> > suspend/resume data. So, let's rewrite nvkm_gsp_radix3_sg() to use
> > the sg
> > allocator for level 2. We continue using coherent allocations for
> > lvl0 and
> > 1, since they only take a single page.
> >=20
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: stable@vger.kernel.org
> > ---
> > =C2=A0.../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |=C2=A0 4 +-
> > =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/r535.c=C2=A0=C2=A0=C2=A0 | 71=
 ++++++++++++---
> > ----
> > =C2=A02 files changed, 47 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> > b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> > index 6f5d376d8fcc1..a11d16a16c3b2 100644
> > --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> > +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> > @@ -15,7 +15,9 @@ struct nvkm_gsp_mem {
> > =C2=A0};
> >=20
> > =C2=A0struct nvkm_gsp_radix3 {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nvkm_gsp_mem mem[3];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nvkm_gsp_mem lvl0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nvkm_gsp_mem lvl1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sg_table lvl2;
>=20
> This looks great, could we go a step further and combine lvl0 and
> lvl1
> into a 2 page allocation, I thought we could combine lvl0/lvl1 into a
> 2 page alloc, but that actually might be a bad idea under memory
> pressure.

I'm not sure I understand :P, do we want to go for that or not? TBH -
I'm not sure there's any hardware reason we wouldn't be able to do the
whole radix3 table as an sg allocation with two additional memory pages
added on for level 0 and 1 - since both of those can only be the size
of a single page anyway it probably doesn't make much of a difference.

The main reason I didn't end up doing that though is because it would
make the codepath in nvkm_radix3_sg() a lot uglier.=C2=A0We need the virtua=
l
addresses of level 0-2's first/only pages to populate them, and we also
need the DMA addresses of level 1-2. There isn't an iterator that lets
you go through both DMA/virtual addresses as far as I can tell - and
even if there was we'd start having to keep track of when we reach the
end of a page in the loop and make sure that we always set pte to the
address of the third sg page on the first iteration of the loop. IMO,
scatterlist could definitely benefit from having an iterator that does
both and can be stepped through both in and out of for loop macros
(like Iterator in rust).

So - it's definitely possible, but considering:

 * nvkm_gsp_mem isn't a very big struct
 * We're only allocating a single page for level 0 and 1, so at least
   according to the advice I got from Sima this should be a safe amount
   to allocate coherently under memory pressure.
 * It's just a lot easier code-wise having direct address to the
   DMA/virt addresses for the first two levels

I decided to stay with nvkm_gsp_mem_ctor() for the first two pages and
just use nvkm_gsp_sg() for the rest. I can definitely convert the whole
thing to using nvkm_gsp_sg() if we really want though - but I don't
think it'll give us much benefit.

I'll send out the new version of the patch without these changes and a
fix for one of the issues with this patch I already mentioned to Timur,
just let me know what you end up deciding and I can revise the patch if
you want.

>=20
> Dave.
>=20

--=20
Cheers, Lyude Paul (she/her) Software Engineer at Red Hat


