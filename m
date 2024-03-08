Return-Path: <linux-kernel+bounces-96636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8DB875F3C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1921B282657
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A043BB38;
	Fri,  8 Mar 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SK5Z5tjp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AB2DF9C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885823; cv=none; b=TnAH576c0X8Ol5bq9iXTM4TJFBywYAMKI6FoGvQXH9uCG2TCccpywcsU010TAKF0oxb1UkI52vZbbwbkUPY4Tnml62FwwyE4PzIhoP8/DoJRzKWalZZdVOw0dV6WCiuq+mQflQKR8mbtCjvTBIlnXoGPlYSfadgCv+EGDkvNUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885823; c=relaxed/simple;
	bh=IY4XZ1orm5EVRtlkCeiM3kEswCENLkndbeAuLwCNleY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YT7q0yzi82mvdtzxtjUE/lpYlYkW7HjoYKJ1aO0KUFum+55yBUH6l69oMNCgQ1gr3sgAltdDVMyloChd+6KdtgtdAL6LFQ/JHMJABdRdeYcX1w1xT+25ljGHvJxP4LnNUCz56Bi83wLih5/rWbUDsbtxMvzcR/1C2vpKMLOlVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SK5Z5tjp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709885820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNWdgYfJ3EazW30/6d2pGmEwb5ZHWmDLFUVwsMl5Z34=;
	b=SK5Z5tjp8kdhLX9grXrJeqKfxTpn4MzUweuF2OWm6bEpI9s35LOT4KprcNdA6BTkh/wdro
	QjhPEHmyUhaGXPGYS7F8ESUzJBii09mj37QyHYNqde1JABB01D+vnCKE8UuJmAR3iZhhAw
	8+3RLPHL4HSu9W1t+O+Nc36QLdiPmYo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-nJQEpJusODu80r2of0jo_Q-1; Fri, 08 Mar 2024 03:16:58 -0500
X-MC-Unique: nJQEpJusODu80r2of0jo_Q-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso490919a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 00:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709885817; x=1710490617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNWdgYfJ3EazW30/6d2pGmEwb5ZHWmDLFUVwsMl5Z34=;
        b=D8zUgzt8kxMoHmEwJ3q+ZwA7vWHNJ/YDZoY/SRVSanpED0lcWw3qEs3Im1l9wRjeI5
         gxqUaw/rEXiNw7/C/noJVsE9oTqDpQq7lEEUa8Ps6mktvWzbfbYxQq7RfeTIiW+OXZje
         cc71e8qqI0/jaHgDSdwNrsu3TMjmeo90zj/5PRgAyqQNSvKzXCobcOhEH5mHMUCE6LCK
         7HrQ+yi2ifNnfq5Sf5dsa4p6lpCVGXQ5CB8I6AFJ3yacXAjNtgESWFnvO9+/H97qjqNR
         IXXvC426pX7KU6ZwcFM+D2CH4wa3v5jZHjHxElzKmUuXxv0Zv5AIgGEvlv5QVroHygEy
         6QwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGpkQgG33xO79aJ3KLoXtvnwXzZVSR0OZ4lOjMkS6RBHP3OicgF4eobPWKFUWAxeZpLKL3Rh8x+dOhnu38ZzUyDTgdYVA09UqIAKnX
X-Gm-Message-State: AOJu0YymZVnVwtSKi4/nyn9fRD65i6DLWei49FfpJ8J2d5NZCWbrxvyQ
	PQOCjGJD2PpA+y/m2JlSx/c3hntzfOKAPKexg+X9jx0AWB67B4+C0m8zpJgHqYPCmANuhxKG9ea
	JMpM4JJM14V96SdUkYuoazAZ9nf3WhsnrA62y9XLljokQylukY8IrYn4XPh91d+chDX0v0MZ4Yg
	lk+gRSVl/lykSZaUvytMHFK+pv5Rfg+kpgV2k9
X-Received: by 2002:a05:6a20:9f88:b0:1a1:67be:f4a2 with SMTP id mm8-20020a056a209f8800b001a167bef4a2mr8072071pzb.59.1709885817469;
        Fri, 08 Mar 2024 00:16:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHjphCuFZVNCoHIMDMnH+dQXdb8kS89pBKUJQIae8JCi6mX+qrQbV6TMzyRw7aZ00TxzWaUhDcyIU8xNpj2fw=
X-Received: by 2002:a05:6a20:9f88:b0:1a1:67be:f4a2 with SMTP id
 mm8-20020a056a209f8800b001a167bef4a2mr8072059pzb.59.1709885817139; Fri, 08
 Mar 2024 00:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207054701.616094-1-lulu@redhat.com> <CACGkMEtb941fJ481xtaGvjF10r_iq53FoTtmAr9jHwvqXssFrw@mail.gmail.com>
 <CACLfguWGWPMdvXgFd0bnpW_Ej0JrhGQULpPrp4grixnb9NtH9A@mail.gmail.com>
In-Reply-To: <CACLfguWGWPMdvXgFd0bnpW_Ej0JrhGQULpPrp4grixnb9NtH9A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Mar 2024 16:16:45 +0800
Message-ID: <CACGkMEu_QWvZWZtt+_Z3pa+P5Lc9gfym+Lh7iK8ZUtW7wDYZAg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] vduse: Add support for reconnection
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org, 
	maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Fri, Mar 8, 2024 at 2:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Feb 7, 2024 at 1:47=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > Here is the reconnect support in vduse,
> > >
> > > Kernel will allocate pages for reconnection.
> > > Userspace needs to use mmap to map the memory to userspace and use th=
ese pages to
> > > save the reconnect information.
> > >
> > > test passd in vduse+dpdk-testpmd
> > >
> > > change in V2
> > > 1. Address the comments from v1
> > > 2. Add the document for reconnect process
> > >
> > > change in V3
> > > 1. Move the vdpa_vq_state to the uAPI.  vduse will use this to synchr=
onize the vq info between the kernel and userspace app.
> > > 2. Add a new ioctl VDUSE_DEV_GET_CONFIG. userspace app use this to ge=
t config space
> > > 3. Rewrite the commit message.
> > > 4. Only save the address for the page address and remove the index.
> > > 5. remove the ioctl VDUSE_GET_RECONNECT_INFO, userspace app will use =
uAPI VDUSE_RECONNCT_MMAP_SIZE to mmap
> > > 6. Rewrite the document for the reconnect process to make it clearer.
> > >
> > > change in v4
> > > 1. Change the number of map pages to VQ numbers. UserSpace APP can de=
fine and maintain the structure for saving reconnection information in user=
space. The kernel will not maintain this information.
> >
> > So this means the structure (e.g inflight descriptors) are application
> > specific, we can't do cross application reconnection?
> >
> > Thanks
> >
> yes, this is also defined by the application itself. so maybe we can't
> support the
> cross-application reconnection
> thanks
> cindy

Well, ok. We can probably start from this but let's document this
explicitly in the doc patch.

Thanks

> > > 2. Rewrite the document for the reconnect process to make it clearer.
> > > 3. add the new ioctl for VDUSE_DEV_GET_CONFIG/VDUSE_DEV_GET_STATUS
> > >
> > > Cindy Lu (5):
> > >   vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
> > >   vduse: Add new ioctl VDUSE_DEV_GET_STATUS
> > >   vduse: Add function to get/free the pages for reconnection
> > >   vduse: Add file operation for mmap
> > >   Documentation: Add reconnect process for VDUSE
> > >
> > >  Documentation/userspace-api/vduse.rst |  32 +++++++
> > >  drivers/vdpa/vdpa_user/vduse_dev.c    | 125 ++++++++++++++++++++++++=
++
> > >  include/uapi/linux/vduse.h            |   5 ++
> > >  3 files changed, 162 insertions(+)
> > >
> > > --
> > > 2.43.0
> > >
> >
>


