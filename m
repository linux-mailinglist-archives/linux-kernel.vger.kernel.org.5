Return-Path: <linux-kernel+bounces-135359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F7989BF75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B18286E58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E86D1A9;
	Mon,  8 Apr 2024 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt/2rUbB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A076F08E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580654; cv=none; b=KfNM+N+g+N3pfHHgGvkCUi8AxszyaHGNMwXJdGpHF6JbxGUG5xEeBFs3WMaTGtVLbPDB/0Q2mE2l8YJROYLipdmJXfGXxrsThAz9ILwdCTEQgBjMLPWSFt06w90Z5ctbzz2Q2JCZ3cVe9qa27C5iEok1LyEiHoEV5Jo0lYDf3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580654; c=relaxed/simple;
	bh=t6rY2U7J7pGdzJQQnj7Amc0EfelzVuwnd+M+I4FgGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmU0cLfjm1IjFjvez52HuDTAcGqpHmfFyac62QacfW7LMxwPjMi0B0VJEh0kRQ6MUcAb1s7ulR+oKVVVv2KKu93MfGsgAj+4GDTZhoHn/qFgYh1XnxySgXg5gVXsR6OMe/xjFsefO5gmMrUchlUuc9M+BVT1smNw4B6NXNvcdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bt/2rUbB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712580651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgyAj+d0mXsaKlJNf1FRqd+kTl9TVEHoCjOdqUp78UU=;
	b=bt/2rUbB5D01oAm1lfdIsn6hNgPjo1HGziYPcVLBSSuJ0GtzKH+qhbPcqQCz7MZV9Q+FGN
	3dIOsXsV0D/gJBHlMfQcKJV5OUqSDIjs2mEHApO8HNNh5sGFc5AzfdCJcLR3f1ReuE5HUT
	CoZi33br/fln6au/pssm0hdnrcdvWNE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-pL4zqpBwMiuu0nIEF1EzwA-1; Mon, 08 Apr 2024 08:50:50 -0400
X-MC-Unique: pL4zqpBwMiuu0nIEF1EzwA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d87257c610so22690851fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580648; x=1713185448;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgyAj+d0mXsaKlJNf1FRqd+kTl9TVEHoCjOdqUp78UU=;
        b=wzbV9YU1OiCBMJgZUTG4pE5olgZJln8+bAbM+M1VD5E8lv6slTEqqL2ra9017rCCmJ
         YgeXhW45QHatzfpd8DQr3YxAwvOxKXR9qQjh9fx4hWCtd6hLxKF2a1Wo0t3JrZMe/4ll
         /QRmc6nEpD+9aXeJRfErpmRDBsBS/DQ9fAcZtAwaTFJw+ga4W7hsQlnJCB2eD4b0goCG
         uZgeMNwTCKNtwYz59d6Q68Qi7noD+UUyDVtMb46dMgB02u+Y+qJhGkSfMEu2i+5Kz3BK
         tImvYOINff7cdQ3DvQUNc3/Fqgv74+HSOY1apFGbsfTJSOksUwCfOEkYlgq4/BJ3uqlt
         KwFw==
X-Forwarded-Encrypted: i=1; AJvYcCVwQ7T939gkhQRkz1wmfHhUVT8e05eg7GxTgfGzFmg6BydCHUfE8L+OZdjw3rxh20iNjHf4AwxYbqxB2KfViK9OzZPdInF5U0rGYWGl
X-Gm-Message-State: AOJu0YzvMD0Ft70l+FM9qca5CCvoWm2Os5gsBrXLdWqV7oZjKWZdNAAj
	b+PGKNTPYX0PSb2vXy+moyOdW7hlLTDPFfpOD+8iqbOmhTlbmcYGV6ErLMcQAcCapyMPznxz2Ev
	aJO646US++FeD/VyRq/nGxYdJ+DzDMl3tMCkxw35Vtolha297+IZZrpYZqlggMw==
X-Received: by 2002:a2e:b0ca:0:b0:2d8:6fc4:d0b5 with SMTP id g10-20020a2eb0ca000000b002d86fc4d0b5mr6644110ljl.8.1712580647632;
        Mon, 08 Apr 2024 05:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlvCW0RSMUg3H9tBOc1SwabjdiTPzS2Fm8vr4WbbbbyDGcjVCN/zOPqhNUznAU5UGSgB/nQg==
X-Received: by 2002:a2e:b0ca:0:b0:2d8:6fc4:d0b5 with SMTP id g10-20020a2eb0ca000000b002d86fc4d0b5mr6644089ljl.8.1712580647022;
        Mon, 08 Apr 2024 05:50:47 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id oz31-20020a170906cd1f00b00a4e8e080869sm4432937ejb.176.2024.04.08.05.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:50:46 -0700 (PDT)
Date: Mon, 8 Apr 2024 08:50:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Add reconnect process for VDUSE
Message-ID: <20240408085008-mutt-send-email-mst@kernel.org>
References: <20240404055635.316259-1-lulu@redhat.com>
 <20240408033804-mutt-send-email-mst@kernel.org>
 <CACLfguUL=Kteorvyn=wRUWFJFvhvgRyp+V7GNBp2R33hK1vnSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguUL=Kteorvyn=wRUWFJFvhvgRyp+V7GNBp2R33hK1vnSw@mail.gmail.com>

On Mon, Apr 08, 2024 at 08:39:21PM +0800, Cindy Lu wrote:
> On Mon, Apr 8, 2024 at 3:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 04, 2024 at 01:56:31PM +0800, Cindy Lu wrote:
> > > Add a document explaining the reconnect process, including what the
> > > Userspace App needs to do and how it works with the kernel.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >
> > > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> > > index bdb880e01132..7faa83462e78 100644
> > > --- a/Documentation/userspace-api/vduse.rst
> > > +++ b/Documentation/userspace-api/vduse.rst
> > > @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
> > >     after the used ring is filled.
> > >
> > >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > > +
> > > +HOW VDUSE devices reconnection works
> > > +------------------------------------
> > > +1. What is reconnection?
> > > +
> > > +   When the userspace application loads, it should establish a connection
> > > +   to the vduse kernel device. Sometimes,the userspace application exists,
> > > +   and we want to support its restart and connect to the kernel device again
> > > +
> > > +2. How can I support reconnection in a userspace application?
> > > +
> > > +2.1 During initialization, the userspace application should first verify the
> > > +    existence of the device "/dev/vduse/vduse_name".
> > > +    If it doesn't exist, it means this is the first-time for connection. goto step 2.2
> > > +    If it exists, it means this is a reconnection, and we should goto step 2.3
> > > +
> > > +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > > +    /dev/vduse/control.
> > > +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory for
> > > +    the reconnect information. The total memory size is PAGE_SIZE*vq_mumber.
> >
> > Confused. Where is that allocation, in code?
> >
> > Thanks!
> >
> this should allocated in function vduse_create_dev(),

I mean, it's not allocated there ATM right? This is just doc patch
to become part of a larger patchset?

> I will rewrite
> this part  to make it more clearer
> will send a new version soon
> Thanks
> cindy
> 
> > > +2.3 Check if the information is suitable for reconnect
> > > +    If this is reconnection :
> > > +    Before attempting to reconnect, The userspace application needs to use the
> > > +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FEATURES...)
> > > +    to get the information from kernel.
> > > +    Please review the information and confirm if it is suitable to reconnect.
> > > +
> > > +2.4 Userspace application needs to mmap the memory to userspace
> > > +    The userspace application requires mapping one page for every vq. These pages
> > > +    should be used to save vq-related information during system running. Additionally,
> > > +    the application must define its own structure to store information for reconnection.
> > > +
> > > +2.5 Completed the initialization and running the application.
> > > +    While the application is running, it is important to store relevant information
> > > +    about reconnections in mapped pages. When calling the ioctl VDUSE_VQ_GET_INFO to
> > > +    get vq information, it's necessary to check whether it's a reconnection. If it is
> > > +    a reconnection, the vq-related information must be get from the mapped pages.
> > > +
> > > +2.6 When the Userspace application exits, it is necessary to unmap all the
> > > +    pages for reconnection
> > > --
> > > 2.43.0
> >


