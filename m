Return-Path: <linux-kernel+bounces-107110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C413787F798
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A8F1F24FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1B7BAEE;
	Tue, 19 Mar 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDXyD8gZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623351C40
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830262; cv=none; b=BY9dDDvS3VEG6A8S/4c9H5HuNfcbKtfgFBQmLfFH4FHezqfxFkf/q1n9i+NuArmLYsgde0CmcUwnQYkvyXJdqQAzhhjOfkgHXAW3qpNZdh4FIO2tqlv7pAXE1yQVghZD3lGk9DyTMGviUthIyRaBudPkqfxuM1p5vL+ZMJHBac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830262; c=relaxed/simple;
	bh=7aOlHQm8LHVQXz6TfSw+5H1DQnYvg5Ofbhh0jTaIx30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaZFXiHtx8yCBvP8TGPzJ37YOoZuwP8zdUhQ9m89ULNYLSXbHIdy7odhAcBrOijIuu/rjKf3sYY3n3lC4SMKX4XPxrHDI6ZSJ3PPQqKL0rYumny4rc1PpzpW6ifTOtuRSYeapE7TQoHwOF5B1rLTUHTw61g4rxPgoUf0ogKJs/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDXyD8gZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710830259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmRH0uJYTzTFBbk+S/AFs1mOFzNaVKzjMcyfGac8DX8=;
	b=NDXyD8gZPvoLoyBYF6tQ3sIOxfr0zR5O88ZHOAabUq0XUGrBY339X3znfxDf2AuwM7Aosf
	nco1nqZ4kZeaKAFkQMM7aSGoyQ3bskSDSopYlJY1z+1hKEL7B3agrIq+fq+DmZWPg0Sjg2
	bBrm9xaQ7O+Mua2gsH83l/sjSfc/C3U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-UpROPJDyMp6sekbj6TuP-Q-1; Tue, 19 Mar 2024 02:37:37 -0400
X-MC-Unique: UpROPJDyMp6sekbj6TuP-Q-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56b8c7b4fe0so727599a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830256; x=1711435056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmRH0uJYTzTFBbk+S/AFs1mOFzNaVKzjMcyfGac8DX8=;
        b=leIf6+pDd3hF4Hs1DrucVrnENDuEKq1YSDLfNWAsHouyVhtHu/J+c9p53Kp8oeOtMT
         U45hi2Ee9unfKjCkIfqB5+A46yK0YnFRiBZZMWQW0uz7MJKhz9uo8T/yGfDRbsxha9m8
         BErYzlzffc5kF+AgJyVqUOGp1CFbxWEfz1ebc4CT+XwC/BGlgoI8l8+bM+vmZUo0pTgy
         NPqbwHaidx1IZS9oBzxnbvTfshB/z+0BI3RSLdvc1svkahUTxfAXKHpCrHrz3V4piAuh
         ELxTvj4pKnIj0sy6qo/AKcU7iOkUYmRnUB/IfgbYoUQLbFxlOF74RhEiV/r31A0p4yd9
         fQgA==
X-Forwarded-Encrypted: i=1; AJvYcCUUx2eA2phi0J3Djo5qS2RtCobSwKURcoSrNGfT2GgAWypEu3eXp2g8XxPfFd+DqB6z4vanzStVD9yQSrAW4qxXWqIR6BQRhjJRV7l8
X-Gm-Message-State: AOJu0YxMI+dNDl+eEJ7N/cGRvnfdttnBGZScjBUJXC0FRl53QMCXG9sU
	yfwkXZgkvzcbVoNWVot/dJwX4mF9QINwegWKxUBonueQbK1DUebYyO/HST+PBlm9y4SEab0bo/p
	1bX/gwA/VxIuxY0Ejlae5nARDb4F5nnFd7UUmsPNtec1oeJe7fOHFqfnNAISn3VhECypuGA==
X-Received: by 2002:a05:6402:390c:b0:566:ab90:1073 with SMTP id fe12-20020a056402390c00b00566ab901073mr912061edb.34.1710830255722;
        Mon, 18 Mar 2024 23:37:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvYkpBGQ2mHKUWZ+9xF6UsDlpDfsJ2CiCIykYnLAQzsEsdKWIsFCI+bv4ochvk+hEyJlMUqg==
X-Received: by 2002:a05:6402:390c:b0:566:ab90:1073 with SMTP id fe12-20020a056402390c00b00566ab901073mr912048edb.34.1710830255232;
        Mon, 18 Mar 2024 23:37:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id cs4-20020a0564020c4400b00568a1ce4562sm5225755edb.25.2024.03.18.23.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:37:34 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:37:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, xieyongji@bytedance.com,
	linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Subject: Re: [PATCH v4 0/5] vduse: Add support for reconnection
Message-ID: <20240319023636-mutt-send-email-mst@kernel.org>
References: <20240207054701.616094-1-lulu@redhat.com>
 <20240222141559-mutt-send-email-mst@kernel.org>
 <CACLfguXQ3c91-Xpb3rzpoF9kxwnah=CJa_igk5j5p93_0JnRAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguXQ3c91-Xpb3rzpoF9kxwnah=CJa_igk5j5p93_0JnRAQ@mail.gmail.com>

On Fri, Mar 08, 2024 at 03:29:50PM +0800, Cindy Lu wrote:
> On Fri, Feb 23, 2024 at 3:18 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Feb 07, 2024 at 01:43:27PM +0800, Cindy Lu wrote:
> > > Here is the reconnect support in vduse,
> > >
> > > Kernel will allocate pages for reconnection.
> > > Userspace needs to use mmap to map the memory to userspace and use these pages to
> > > save the reconnect information.
> >
> > What is "reconnect"? Not really clear from documentation - it seems to
> > be assumed that reader has an idea but most don't.
> >
> > Also what's with all the typos? reconnect with 3 nnn s, sutiable and so
> > on. Can you pls run a speller?
> >
> Thanks a lot, Micheal. I will fix these and also update the speller
> thanks
> Cindy

Didn't get an updated version, dropped the patch from the pull for this
merge window.

> > > test passd in vduse+dpdk-testpmd
> > >
> > > change in V2
> > > 1. Address the comments from v1
> > > 2. Add the document for reconnect process
> > >
> > > change in V3
> > > 1. Move the vdpa_vq_state to the uAPI.  vduse will use this to synchronize the vq info between the kernel and userspace app.
> > > 2. Add a new ioctl VDUSE_DEV_GET_CONFIG. userspace app use this to get config space
> > > 3. Rewrite the commit message.
> > > 4. Only save the address for the page address and remove the index.
> > > 5. remove the ioctl VDUSE_GET_RECONNECT_INFO, userspace app will use uAPI VDUSE_RECONNCT_MMAP_SIZE to mmap
> > > 6. Rewrite the document for the reconnect process to make it clearer.
> > >
> > > change in v4
> > > 1. Change the number of map pages to VQ numbers. UserSpace APP can define and maintain the structure for saving reconnection information in userspace. The kernel will not maintain this information.
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
> > >  drivers/vdpa/vdpa_user/vduse_dev.c    | 125 ++++++++++++++++++++++++++
> > >  include/uapi/linux/vduse.h            |   5 ++
> > >  3 files changed, 162 insertions(+)
> > >
> > > --
> > > 2.43.0
> >


