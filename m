Return-Path: <linux-kernel+bounces-136897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2B89D984
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBFEB240F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33EA12E1E0;
	Tue,  9 Apr 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYWLMihC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D24B127B5A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667396; cv=none; b=XlHmRpYu9JiNEVNrBVW1prv75BtWLDOOZ/GycMXDnEY2CYqbggrWd34A+x1ptSyfpqZPC75skZOWSNjgeWMLy5E+IdrX9mTYyk6mexzyXaOzCDHVn/QPE7lSl4ZljsnLUpcyaEHAG5vSp+pXh/HCgL61qZUJtA/DQg4Ua/cD410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667396; c=relaxed/simple;
	bh=qFjj8gprOyy5QG3PDpMwH5OS6JMEOPGugaUWv8+tRvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSs78YvI8WwCrDgPHEyt1GiPY6AtXTiaE0Sk4APM5r4pU5nrws8Ar7YTrtSNK9GscVZk/KQfWzY15IYCV4uIZR60f9YCGPU/6RwWmvarQe8nfsccoM/1MHpdv4RYuyWM9imp8yYk5Km2Cgft0LPVg1jo4dnqD1Vt7bxVlTnQxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYWLMihC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712667393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pt0N3bL5TJP0v672v3Z/C/6PTX4AkZIvzQAggKI+KTY=;
	b=aYWLMihC9IAoQBWj2TWh3OwXNP5uprJNlrSK7JJywxjWPurFIFdW4Il0thBRorPjZNHg4M
	TXuEzhY97akUtz4GWHInYgjWGRrJQBY2JrSuXubPiz2CxEjBAZECURuA9DzY1MxI8iH+XK
	ANt8IdEJRBCPWsXChCtS29QdWsUIiZM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-beEtrhAwOPaB2IwdBgpTvA-1; Tue, 09 Apr 2024 08:56:31 -0400
X-MC-Unique: beEtrhAwOPaB2IwdBgpTvA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a51cf34d476so106573266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 05:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667391; x=1713272191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt0N3bL5TJP0v672v3Z/C/6PTX4AkZIvzQAggKI+KTY=;
        b=O9t0eRb2g80rkP+yOYH52BFs5h3AIaXYXnhUzj86cPyvYq3sMFkJ1W7/uzEEOMr71A
         tSPvY9t+PqQ5kdxp5v2qNtc04dqgteimJYNvbjJG+qGB+qwobZnVWn4eau9yxbvw/NMc
         gTOTAILEW7d3v91IsUOAxFg5UoIvRkxZ573g+bYdXpVDEe+YdZIxAa3IJhAYJ+ear/fY
         HHXYZ5MaJONpd66PH1r9KQVxwsjAs/QdLauN5YjvUJD34r7fPLrsLipoyuSrNA8HdixT
         TDLyG+VZawUUr+op41VT0wx1vjKHKkWxeWvlh+f6AjooXegboYqzljFJJf60KA107COD
         5w/w==
X-Forwarded-Encrypted: i=1; AJvYcCWovMwml+bh0hr2HRE5UAdHLuIISIfrPjroorVQEwZNT2hHyteARZe6EXwE+4SnNZTnFHJIPtocFbmAwdps360f2wnbwVpxvmer5dtF
X-Gm-Message-State: AOJu0YwQb5xij5Pds1JMOje9IWKElO2nauuw4wfVWwcvJGcdkpfgZxSR
	NTZF2ye8dYsyZqMb+Qu4mbY2iA1z6z/RBT4rDhj08DpMaMROLXiccNSQvGc5ndh8yjEQMSlx2JS
	PkQDsaK5F7MkkwcEli+aFh7ZBvK0qAOQZq5XPpXlOmIXB5QyJsyPfOHSZLO9Fj5Y4hn7bHR1KTA
	0kEUWi9aop36GYAMjIqO0dwnzr8IorNGVrc+CA
X-Received: by 2002:a17:906:6889:b0:a51:a688:3e9c with SMTP id n9-20020a170906688900b00a51a6883e9cmr6917337ejr.35.1712667390826;
        Tue, 09 Apr 2024 05:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoJWDaZk2RdQUZFsUUYdQeQjnpvYmMrAlJni0v8Qmi8hoHGlbaqGBCHz7xfsMA25ZelFLfveAk8CK5Iy6mxH0=
X-Received: by 2002:a17:906:6889:b0:a51:a688:3e9c with SMTP id
 n9-20020a170906688900b00a51a6883e9cmr6916714ejr.35.1712667365422; Tue, 09 Apr
 2024 05:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404055635.316259-1-lulu@redhat.com> <20240408033804-mutt-send-email-mst@kernel.org>
 <CACLfguUL=Kteorvyn=wRUWFJFvhvgRyp+V7GNBp2R33hK1vnSw@mail.gmail.com> <20240408085008-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240408085008-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Apr 2024 20:55:23 +0800
Message-ID: <CACLfguWC3LruVfLndc4vzpzOuomEz-+nHY0KENZ6iiXNB728eg@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Add reconnect process for VDUSE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 8:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Apr 08, 2024 at 08:39:21PM +0800, Cindy Lu wrote:
> > On Mon, Apr 8, 2024 at 3:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Thu, Apr 04, 2024 at 01:56:31PM +0800, Cindy Lu wrote:
> > > > Add a document explaining the reconnect process, including what the
> > > > Userspace App needs to do and how it works with the kernel.
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++=
++++
> > > >  1 file changed, 41 insertions(+)
> > > >
> > > > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/=
userspace-api/vduse.rst
> > > > index bdb880e01132..7faa83462e78 100644
> > > > --- a/Documentation/userspace-api/vduse.rst
> > > > +++ b/Documentation/userspace-api/vduse.rst
> > > > @@ -231,3 +231,44 @@ able to start the dataplane processing as foll=
ows:
> > > >     after the used ring is filled.
> > > >
> > > >  For more details on the uAPI, please see include/uapi/linux/vduse.=
h.
> > > > +
> > > > +HOW VDUSE devices reconnection works
> > > > +------------------------------------
> > > > +1. What is reconnection?
> > > > +
> > > > +   When the userspace application loads, it should establish a con=
nection
> > > > +   to the vduse kernel device. Sometimes,the userspace application=
 exists,
> > > > +   and we want to support its restart and connect to the kernel de=
vice again
> > > > +
> > > > +2. How can I support reconnection in a userspace application?
> > > > +
> > > > +2.1 During initialization, the userspace application should first =
verify the
> > > > +    existence of the device "/dev/vduse/vduse_name".
> > > > +    If it doesn't exist, it means this is the first-time for conne=
ction. goto step 2.2
> > > > +    If it exists, it means this is a reconnection, and we should g=
oto step 2.3
> > > > +
> > > > +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > > > +    /dev/vduse/control.
> > > > +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memor=
y for
> > > > +    the reconnect information. The total memory size is PAGE_SIZE*=
vq_mumber.
> > >
> > > Confused. Where is that allocation, in code?
> > >
> > > Thanks!
> > >
> > this should allocated in function vduse_create_dev(),
>
> I mean, it's not allocated there ATM right? This is just doc patch
> to become part of a larger patchset?
>
Got it, thanks Michael I will send the whole patchset soon
thanks
Cindy

> > I will rewrite
> > this part  to make it more clearer
> > will send a new version soon
> > Thanks
> > cindy
> >
> > > > +2.3 Check if the information is suitable for reconnect
> > > > +    If this is reconnection :
> > > > +    Before attempting to reconnect, The userspace application need=
s to use the
> > > > +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GE=
T_FEATURES...)
> > > > +    to get the information from kernel.
> > > > +    Please review the information and confirm if it is suitable to=
 reconnect.
> > > > +
> > > > +2.4 Userspace application needs to mmap the memory to userspace
> > > > +    The userspace application requires mapping one page for every =
vq. These pages
> > > > +    should be used to save vq-related information during system ru=
nning. Additionally,
> > > > +    the application must define its own structure to store informa=
tion for reconnection.
> > > > +
> > > > +2.5 Completed the initialization and running the application.
> > > > +    While the application is running, it is important to store rel=
evant information
> > > > +    about reconnections in mapped pages. When calling the ioctl VD=
USE_VQ_GET_INFO to
> > > > +    get vq information, it's necessary to check whether it's a rec=
onnection. If it is
> > > > +    a reconnection, the vq-related information must be get from th=
e mapped pages.
> > > > +
> > > > +2.6 When the Userspace application exits, it is necessary to unmap=
 all the
> > > > +    pages for reconnection
> > > > --
> > > > 2.43.0
> > >
>


