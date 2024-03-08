Return-Path: <linux-kernel+bounces-96578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32233875E71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 928C6B22A59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0CD4EB52;
	Fri,  8 Mar 2024 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEkWrzWN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02672E3E4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882826; cv=none; b=F4HssLw9jZf+NYbI7f28p/6gESQ5fcQE3DL6nYgJDgKD1C3YqfdAZVAIj4NCd2gTmbS2RUHUonEq0BtPCeygha4YcEehaX+bKpehKQ7ghdrrD7O0HPamfPkGJ2SePXoDZAJe3ZnI7v6frZvhP4stZT8kxP+9NsM7a0zQLw6hM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882826; c=relaxed/simple;
	bh=zCrb73BuTj9kyLiia6xcWx7aO1iw9sz7HjR8msQyxKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpVLvplyPQmvBI4otBHP41Op9/rzBApAQ+7yL3i71ZKXOja5tgtTIWrvn3Aqh9RzIV8lWluuTv+qZkXK7+gru1RcDx6+cXH6CqmSYWo0mDZnWey0+P5o03mg6W5skjAkg8pvQi0XBWPxso6MWBA4vxM9WFipcocwA9Uhp0EJ7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEkWrzWN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709882823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAAAbwBNoFY5J5wJ/SMKb3fvQAop+d7O/KFW41OPB3A=;
	b=FEkWrzWNxedLB6GbBgjiPpkYSX+5qucj2whDgHLi5BlknH04rj9Teue7cDBcPtD9g3LeDr
	h3oEiAQ7M4Tt5zm3fBG+IVFiezvWIOZIbTBFWuauTeFlOBuRzJnnFVhKPz1raFyby/2LFD
	p2FZUi7er9wvvRJkuBApT3UbA5pDkzc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-mJ1Hc8XaPX6mHbdcaCYcTg-1; Fri, 08 Mar 2024 02:27:01 -0500
X-MC-Unique: mJ1Hc8XaPX6mHbdcaCYcTg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a450c660cdeso105405766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 23:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709882820; x=1710487620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAAAbwBNoFY5J5wJ/SMKb3fvQAop+d7O/KFW41OPB3A=;
        b=UhtDclMWvA9OSq6vU8D7+kp3QGxwtFCb6GmeUP4113BjMNLKLIBWuWt5qbiGylLiC/
         /9/p5PRHUK1vlpftk/Dgf4k73P/xy4822etDtqD2lreaV6SfIKwwojjq+S0BQ91O2Xo/
         0jHR+302PdOam8ikY7MqBjCweJ50l1457VfUCQsTvtkXDzwrwb3HCpJN50nfOFzax8PP
         AMjcOSMyAJnnoH+W68A2s6bt+JObwnzWUQ1ftr1mz1csSG98gtD4rK6AiJhGFzxpoQv+
         Nqs9Svf3QXhn2ru2jQN/bYk92dLcRjca1MukifEF2hsb+CnF/Zc5So3k35+cb7bIn0WB
         Ew3A==
X-Forwarded-Encrypted: i=1; AJvYcCWVcSjB5KOvSocMmm8WeZi8M7cosOkhs8OdYAwSTorcqTiTKSwI42oSzrLjiCq/gpwjtStRFivLV+sjo0lUHZ+GPyIwJzPEVPgQrB0c
X-Gm-Message-State: AOJu0YwpGR1RGYAoKUAnJezvz8HrKujqZEa5gFNgxTZjjfz/ojtVbTcM
	YbGiDzjk5y3vtHrXbCvf3jak3WgBuX9wGeHOU7/xWr7gPH6ZWgu0/B1LFg98Wl1hO9COUMDEX3Z
	1beLpqvHOg2JnC4guEhmMwFs37Ewcpk18TLf/Ty/0ae8lh8AjozcmEK2yIIO3bbx1qxQOdznScR
	LjkyUnU85c+S5ympeCmjfMT2iL0DOPx3lNUGtNal7mgaTiSRg=
X-Received: by 2002:a17:907:397:b0:a3e:b188:fcf3 with SMTP id ss23-20020a170907039700b00a3eb188fcf3mr12486281ejb.48.1709882820071;
        Thu, 07 Mar 2024 23:27:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoS7KGsEjwJTopxaDwKrVIjO4O1Ln5sYXKiYVDYebVeYOsXEsxaNu6Z1GKTt6GGPlLpf+5rjBbLuvO/ZBed5A=
X-Received: by 2002:a17:907:397:b0:a3e:b188:fcf3 with SMTP id
 ss23-20020a170907039700b00a3eb188fcf3mr12486272ejb.48.1709882819728; Thu, 07
 Mar 2024 23:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207054701.616094-1-lulu@redhat.com> <CACGkMEtb941fJ481xtaGvjF10r_iq53FoTtmAr9jHwvqXssFrw@mail.gmail.com>
In-Reply-To: <CACGkMEtb941fJ481xtaGvjF10r_iq53FoTtmAr9jHwvqXssFrw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 8 Mar 2024 15:26:22 +0800
Message-ID: <CACLfguWGWPMdvXgFd0bnpW_Ej0JrhGQULpPrp4grixnb9NtH9A@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] vduse: Add support for reconnection
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org, 
	maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 2:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Feb 7, 2024 at 1:47=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Here is the reconnect support in vduse,
> >
> > Kernel will allocate pages for reconnection.
> > Userspace needs to use mmap to map the memory to userspace and use thes=
e pages to
> > save the reconnect information.
> >
> > test passd in vduse+dpdk-testpmd
> >
> > change in V2
> > 1. Address the comments from v1
> > 2. Add the document for reconnect process
> >
> > change in V3
> > 1. Move the vdpa_vq_state to the uAPI.  vduse will use this to synchron=
ize the vq info between the kernel and userspace app.
> > 2. Add a new ioctl VDUSE_DEV_GET_CONFIG. userspace app use this to get =
config space
> > 3. Rewrite the commit message.
> > 4. Only save the address for the page address and remove the index.
> > 5. remove the ioctl VDUSE_GET_RECONNECT_INFO, userspace app will use uA=
PI VDUSE_RECONNCT_MMAP_SIZE to mmap
> > 6. Rewrite the document for the reconnect process to make it clearer.
> >
> > change in v4
> > 1. Change the number of map pages to VQ numbers. UserSpace APP can defi=
ne and maintain the structure for saving reconnection information in usersp=
ace. The kernel will not maintain this information.
>
> So this means the structure (e.g inflight descriptors) are application
> specific, we can't do cross application reconnection?
>
> Thanks
>
yes, this is also defined by the application itself. so maybe we can't
support the
cross-application reconnection
thanks
cindy
> > 2. Rewrite the document for the reconnect process to make it clearer.
> > 3. add the new ioctl for VDUSE_DEV_GET_CONFIG/VDUSE_DEV_GET_STATUS
> >
> > Cindy Lu (5):
> >   vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
> >   vduse: Add new ioctl VDUSE_DEV_GET_STATUS
> >   vduse: Add function to get/free the pages for reconnection
> >   vduse: Add file operation for mmap
> >   Documentation: Add reconnect process for VDUSE
> >
> >  Documentation/userspace-api/vduse.rst |  32 +++++++
> >  drivers/vdpa/vdpa_user/vduse_dev.c    | 125 ++++++++++++++++++++++++++
> >  include/uapi/linux/vduse.h            |   5 ++
> >  3 files changed, 162 insertions(+)
> >
> > --
> > 2.43.0
> >
>


