Return-Path: <linux-kernel+bounces-157910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547AE8B187C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F32847AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDE11171D;
	Thu, 25 Apr 2024 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXEAqHTn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F1E56A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008976; cv=none; b=TIxj65nKrts82QfIWhGzkDQo3csiXlwlQZ+LA00CH9/JpdF6Cm9jN3F0Fk7ngtp67EXdUf72C4E/xRlGYwfktouB/NPnrlDzyHD1+orOyaH96ERSa5eHxM7cwuPqsxL7PdNmxMTWZgUD0LcG0dy9UXxmyREQR9aGTZA406L2+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008976; c=relaxed/simple;
	bh=OYZOIiMVGrjpLAGzPdLgl+swk58Tp9BY5qQ7cKzmASM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Txk5aZcQJmpkHwsJf6bJ4g4s3H5Z5EyvCGL1XQbwFxH3QnsQxmTM6BvYTTP8LypqpC76TwourURlRimNhA5tLn5Z5og0W58eeT7LsQx78Nw7zC1LlQhOpTpkBhWor77PNzLrCNPOB4J/b9wPIlybO3p0x8TFsbLdB0AFAj9nVZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXEAqHTn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714008972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpCIALRhH6s1EwiBqcuDDSTBd5kPwwUWzmPiht3kNis=;
	b=WXEAqHTnSHAYviDWryQa56V2R8R0STcr6xdhWchUYU+qhmPpzMwj9sAHcLNRi4CzqS+XYW
	W7s5V/G/XjoDgRrApzvZnxYvwDQsBD5RSzBvbf4im+cu/VzBQ/uyqL43qxSohcGu5g2/PH
	77MjDk5euYVOhxw1hKAYQw9nQdlbE3c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-DKm2BuoBNOyFSVHxcVpk5w-1; Wed, 24 Apr 2024 21:36:11 -0400
X-MC-Unique: DKm2BuoBNOyFSVHxcVpk5w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a49440f7b5so580367a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714008970; x=1714613770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpCIALRhH6s1EwiBqcuDDSTBd5kPwwUWzmPiht3kNis=;
        b=lH0iTO2DJDHiJeXiGdyFvkcAVEUfxbA1+whAawF3suCo3CtEBDajhW1xGRaSoEaXJ0
         B1CWU9FaDs03o1efKVYy9obAJGAt8xtV5uUihqJ+IrbiTKrIe4I1ryp8C9QBDwXq/kgc
         Vh9TPaN3wbztc0sPy1MP7fceCYxEtuzrms/8d/qy4dHIw0EVXOVOCXufT2z7ETPRfx54
         yo1amqe9ShzRGLjlWMYVXT5xmCsbic90/vGz+2lLSGBkjYS2PpjN+KgIhzSlga2/I3xR
         heKeUYB/rZwfY8Uezjw/MwLlrDkWJ79E8RjsYfjKwdr74uLnpRhV3E/5dazZJYeDgONg
         0I8w==
X-Forwarded-Encrypted: i=1; AJvYcCVguSk8qrur/HPT6KqBP8rZf20tEk2AGcz5P9w5olEEPoX0TkCafMGWA6SuXWW6eK5vtvBva4nep+E9BbFR28HhupV7FVML37PxBm/x
X-Gm-Message-State: AOJu0YxGpLpJ+ZZE7kWtJzejFEudWNm4rlguPxAG+5fYh2qVTcZ+5nlN
	6Ths7XyvKuj987yysdHwUNiLvVRQ5/D3WEEPjfOUcURzcZGimSEZzItv2XcgYfESiBiLzIkjSyT
	t4CGc+wPwOfSrlvfhBXcKOU78lRXYx7M6uajTRGb5V0ZFC2G0nY/hBgsL/KzSsJnY1IyoecbVFL
	UJsys6Tqx059IWRRAHsc+5GJcaHALguSnBYAd9
X-Received: by 2002:a17:90a:f6c8:b0:2ad:ec71:b7e5 with SMTP id er8-20020a17090af6c800b002adec71b7e5mr4056465pjb.33.1714008970494;
        Wed, 24 Apr 2024 18:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCYK3BKE5mGR4DRabWx3KJUsQiI9ul/+yxnnCH+JAugha/KAI9C2EmP0KFnDfSAsDmXu/TMVd1PQAmdTgPqbA=
X-Received: by 2002:a17:90a:f6c8:b0:2ad:ec71:b7e5 with SMTP id
 er8-20020a17090af6c800b002adec71b7e5mr4056453pjb.33.1714008970137; Wed, 24
 Apr 2024 18:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org> <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org> <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org> <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
 <20240424055108-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240424055108-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Apr 2024 09:35:58 +0800
Message-ID: <CACGkMEtosWhV-eJbPetgPtp-Thg31CLUBGaENbQRknYtzEV3bQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 5:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Apr 24, 2024 at 08:44:10AM +0800, Jason Wang wrote:
> > On Tue, Apr 23, 2024 at 4:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > > > On Tue, Apr 23, 2024 at 4:05=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > > > On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > > > These functions allow vduse to allocate and free memory for=
 reconnection
> > > > > > > > information. The amount of memory allocated is vq_num pages=
.
> > > > > > > > Each VQS will map its own page where the reconnection infor=
mation will be saved
> > > > > > > >
> > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++=
++++++++++++
> > > > > > > >  1 file changed, 40 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > > > >       int irq_effective_cpu;
> > > > > > > >       struct cpumask irq_affinity;
> > > > > > > >       struct kobject kobj;
> > > > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  struct vduse_dev;
> > > > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effectiv=
e_cpu(struct vduse_virtqueue *vq)
> > > > > > > >
> > > > > > > >       vq->irq_effective_cpu =3D curr_cpu;
> > > > > > > >  }
> > > > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_de=
v *dev)
> > > > > > > > +{
> > > > > > > > +     unsigned long vaddr =3D 0;
> > > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > > +
> > > > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > > > +             /*page 0~ vq_num save the reconnect info for =
vq*/
> > > > > > > > +             vq =3D dev->vqs[i];
> > > > > > > > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
> > > > > > >
> > > > > > >
> > > > > > > I don't get why you insist on stealing kernel memory for some=
thing
> > > > > > > that is just used by userspace to store data for its own use.
> > > > > > > Userspace does not lack ways to persist data, for example,
> > > > > > > create a regular file anywhere in the filesystem.
> > > > > >
> > > > > > Good point. So the motivation here is to:
> > > > > >
> > > > > > 1) be self contained, no dependency for high speed persist data
> > > > > > storage like tmpfs
> > > > >
> > > > > No idea what this means.
> > > >
> > > > I mean a regular file may slow down the datapath performance, so
> > > > usually the application will try to use tmpfs and other which is a
> > > > dependency for implementing the reconnection.
> > >
> > > Are we worried about systems without tmpfs now?
> >
> > Yes.
>
> Why? Who ships these?

Not sure, but it could be disabled or unmounted. I'm not sure make
VDUSE depends on TMPFS is a good idea.

Thanks


