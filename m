Return-Path: <linux-kernel+bounces-108459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C63880ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28241C20FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF1814F75;
	Wed, 20 Mar 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW3937wM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA381428E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710913705; cv=none; b=eIydhe6JgWEkmQoVSldh7obqaWn//BkeWFwm56rsSHt+xz1VHolsDfgW3Gy1CRtCYWTRrLGkjPgt73NycJdRF+zVWylphFkfWBvVdhH6kkwyMwZZkvYHm26H9PFaNCIdImxpkukDVsMOkgA14Ei0Onw41dTOnOsISJnWG0O2yUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710913705; c=relaxed/simple;
	bh=Wg7eZqUCttbPXDGjG8P5xiogz9p5l7a7HMCJzv2vC04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEuysEKMW7uaoukcf0P5kWwvwgqr1WH+/y8JhLsOexEr+sS4x8nZ/0cKixzINEDoxlbEaibCrO2rMOR2iYTC7qicW0cxmVNGNbbGGLX6hxFOg6T2IbsKJniUWpUfB2yWjiyfyj03h6wgAVFd5OkeWVvLyBtCjzxMZ8qDmZZB/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SW3937wM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710913702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+sQo95PVqbqVJP4YCXp26jFqxDf+OOM168/95yqj4+o=;
	b=SW3937wMz/wzFXU/J/gwsKVt6HA8id4n7pyI0OSe3oGk26Kn3VOs+NIT5PSxQkm3VhpPLI
	807371K7foxqfkcy6BbBPPIxC2zzbKLuY59BmhxmOAWaH3mHQoIvRNQz4jVg/1cMx6ayaB
	P7BantLEjzMye+4/38TDVpj5Qrm5W+Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-ZTBjCpRbPcKA8M7QhHj92Q-1; Wed, 20 Mar 2024 01:48:20 -0400
X-MC-Unique: ZTBjCpRbPcKA8M7QhHj92Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a468895a00dso326523466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710913699; x=1711518499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sQo95PVqbqVJP4YCXp26jFqxDf+OOM168/95yqj4+o=;
        b=feP+EWjDln83PFSM+llIGR86Jc5ha2MMUoPMo0T7zt3BokeD3Z5XyUUTWnSi78vPwR
         QFpFmksEFbrlcK4Hwcl4NGFPHI1xLiB+CXXS5RXJKuC7knHcS88fJ9DuPBDx3tdArxWI
         t9amO0CCA4HAqlSFljUpZFM5GhnIYPoL7CLdcQ0FUC8OzXsQNqcOjjSLmmu6fuZj5teN
         1sqAi1f86RMwyv+aVO9CnvS5l0DTK4bcSqJgGIuOuEmZjNjPacdXojwZky0+Dzs1Vauc
         fEkGMYKt6LoXu0YVpZk0C33NFhz6UWJAOW4tsBRc9XwcY5jozxChzgXM6AE4EnV19Aia
         SlcA==
X-Forwarded-Encrypted: i=1; AJvYcCU4eXjOjlXIo9yPCU3bG2yuBCKAcUQM7ZhYGbBNF+ajoujLUOYyK6Fb+37u4H90tGhCZr+N7LZ/jJ/u4CLNl2hq7+MM1+jdlvs68zw+
X-Gm-Message-State: AOJu0Yyr+zfwdbS0Zw9pZJ20AQBdV7M3EuZIh+OxaVp2zqKRZ1MveOoH
	+a5JRNxwbG4OWFwKdfi0r8PWKnpghEspQ0uuVFzkUNzkk/0+Cdzzwa24po4KK8M5JkoDuMLY3bB
	Bm5M7EYdTFocpZA7UrtQSeU8mUbcxG+kkzoUnPU4Dbi+324HQGGD5CWMfz3jprK9PmU2Bu/5VPp
	uhYPau/0IZXb8JVhspAFAYNWOnYPqKz7OLvfoI
X-Received: by 2002:a17:906:c298:b0:a46:e9fb:e3db with SMTP id r24-20020a170906c29800b00a46e9fbe3dbmr1686440ejz.65.1710913699507;
        Tue, 19 Mar 2024 22:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPqSYqkSna5IL4SsSknX595OrRR8NbTz0OLrhob/YUlhlhxn9jlKX+jun6ZecKrQ9mZVjdvbpFgTxtKEs8hB8=
X-Received: by 2002:a17:906:c298:b0:a46:e9fb:e3db with SMTP id
 r24-20020a170906c29800b00a46e9fbe3dbmr1686430ejz.65.1710913699152; Tue, 19
 Mar 2024 22:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207054701.616094-1-lulu@redhat.com> <20240222141559-mutt-send-email-mst@kernel.org>
 <CACLfguXQ3c91-Xpb3rzpoF9kxwnah=CJa_igk5j5p93_0JnRAQ@mail.gmail.com> <20240319023636-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240319023636-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 20 Mar 2024 13:47:41 +0800
Message-ID: <CACLfguW+ipYvLi5TbiRb7==EqSOA9DoaNXG9CpLZgTQ-_VVwwg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] vduse: Add support for reconnection
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org, 
	maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 08, 2024 at 03:29:50PM +0800, Cindy Lu wrote:
> > On Fri, Feb 23, 2024 at 3:18=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Feb 07, 2024 at 01:43:27PM +0800, Cindy Lu wrote:
> > > > Here is the reconnect support in vduse,
> > > >
> > > > Kernel will allocate pages for reconnection.
> > > > Userspace needs to use mmap to map the memory to userspace and use =
these pages to
> > > > save the reconnect information.
> > >
> > > What is "reconnect"? Not really clear from documentation - it seems t=
o
> > > be assumed that reader has an idea but most don't.
> > >
> > > Also what's with all the typos? reconnect with 3 nnn s, sutiable and =
so
> > > on. Can you pls run a speller?
> > >
> > Thanks a lot, Micheal. I will fix these and also update the speller
> > thanks
> > Cindy
>
> Didn't get an updated version, dropped the patch from the pull for this
> merge window.
>
Hi Micheal
Really apologize for the delay, I was working in an emergency bug, I
will provide the updated version soon
apologize again for this mistake
Thanks
Cindy
> > > > test passd in vduse+dpdk-testpmd
> > > >
> > > > change in V2
> > > > 1. Address the comments from v1
> > > > 2. Add the document for reconnect process
> > > >
> > > > change in V3
> > > > 1. Move the vdpa_vq_state to the uAPI.  vduse will use this to sync=
hronize the vq info between the kernel and userspace app.
> > > > 2. Add a new ioctl VDUSE_DEV_GET_CONFIG. userspace app use this to =
get config space
> > > > 3. Rewrite the commit message.
> > > > 4. Only save the address for the page address and remove the index.
> > > > 5. remove the ioctl VDUSE_GET_RECONNECT_INFO, userspace app will us=
e uAPI VDUSE_RECONNCT_MMAP_SIZE to mmap
> > > > 6. Rewrite the document for the reconnect process to make it cleare=
r.
> > > >
> > > > change in v4
> > > > 1. Change the number of map pages to VQ numbers. UserSpace APP can =
define and maintain the structure for saving reconnection information in us=
erspace. The kernel will not maintain this information.
> > > > 2. Rewrite the document for the reconnect process to make it cleare=
r.
> > > > 3. add the new ioctl for VDUSE_DEV_GET_CONFIG/VDUSE_DEV_GET_STATUS
> > > >
> > > > Cindy Lu (5):
> > > >   vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
> > > >   vduse: Add new ioctl VDUSE_DEV_GET_STATUS
> > > >   vduse: Add function to get/free the pages for reconnection
> > > >   vduse: Add file operation for mmap
> > > >   Documentation: Add reconnect process for VDUSE
> > > >
> > > >  Documentation/userspace-api/vduse.rst |  32 +++++++
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c    | 125 ++++++++++++++++++++++=
++++
> > > >  include/uapi/linux/vduse.h            |   5 ++
> > > >  3 files changed, 162 insertions(+)
> > > >
> > > > --
> > > > 2.43.0
> > >
>


