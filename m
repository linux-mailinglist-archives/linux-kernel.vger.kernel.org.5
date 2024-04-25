Return-Path: <linux-kernel+bounces-158388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6AF8B1F20
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96161F24EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548738664D;
	Thu, 25 Apr 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4lcYsJc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EEA85955
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040825; cv=none; b=T5U7b8DGK8mMq1PxC0LtRNU7GYJlC5dFjV/ZkZk8lpSyRQzCyJmNCWmoHjMBbwUcRQfNk4izcuSR0G85cESgVR/iUaFx3nNdUnaJvAt/e1hOIh+En8Zho2i8JiftDFthHHe2lg0XHJaq/SL39AgEw+fXVy8mdzxOD1qo4MAMUfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040825; c=relaxed/simple;
	bh=uixl8nuzsyXFYXWzPKcewT6UnoNYs6qqp8WThBIlYYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/ZW5L5pHO1nmlgMjsrzQXpfczPGANQRBKJWwQ7l2FEfSAO2oJTAfCZKSbnjZnCv7Czgn5cwOQFP3qwSrwqBnKSUibFLx0vk1jGlQmCUP8YGB9Bo4k/QfPtQT0RHPr/tEUC1hHHa/uueafvoGyHP4J9fVMuQNTzI3/EE5REgsFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4lcYsJc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714040822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StDpHEj4qxN3O4ePPPw+2ExFWloqHkamN4QGQkrDpNQ=;
	b=C4lcYsJcL0januS1XvvYaY+YqiPHdE1KgX2Xy8PgFLfS2gJUWP/0YmaqjiPcu0Dk/BUboj
	K5sKdPXnX0Gcl7LMtEp4Gm/Gz0u/37CfrbGiyamga9JP1KchepNFeTGxbiGJkWOGvE953s
	rSrlaPjI4pFl9mGLRLhACI4vP+/hfV4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-nEFBYX2oNI6d6STI1Hlfgg-1; Thu, 25 Apr 2024 06:27:01 -0400
X-MC-Unique: nEFBYX2oNI6d6STI1Hlfgg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4169d69ce6bso3970535e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714040819; x=1714645619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StDpHEj4qxN3O4ePPPw+2ExFWloqHkamN4QGQkrDpNQ=;
        b=kl79azL0aPKCvwIyTG9BXqvwsvQzbmdU/pXaDxm32YkdbVWrcGnXVb/TF8oth22BoR
         /p3SzKO3YiofwKNJdi7/Zz55yCBUQiuMiACRUGHiltKRRTSUeRu6GhP0MszLD68ezyED
         zT/z2+QMubfomEXKVB+iX6wKPtIyhIXp8Thu2MDxGVhbkeqEODSxlB6ma9fBqapkjcr0
         07vZcHP77gxgRc+F2JZzVrqnD1CTEJH+v/8zJDPWw65a9JVJ8S+/kpeZCQ4RqJL2qXW/
         q6VT1J3dYRawDp/EO4hMZ37eBEgRBm0kAQSV2w5+Cmz+/IXWBUwfM3VFvrC8sqarF+Mf
         UAAg==
X-Forwarded-Encrypted: i=1; AJvYcCWNAn8PTXelsx9wYw/f/ZpOgsbFEILYKW+lcd/gYLbg04XELOGAtD6IOgSQBMMlMgTM5wEQt/MsC1r6MZn7czbIb+DU+7FP4noMufQ6
X-Gm-Message-State: AOJu0YzdiFvAZhhZGd+cIZembqzxNLX8a7rcpPs0DC8SYBseZr1Sj9+i
	Nq9caixerKksKtQqtuQHYLnh6aBGWIubawdm5cnAE04KCWjbdYydddssere7MsgkmbIU3tLBKCe
	U5BEZV6oa1lVH+fvEMAKQjcyfbFIXJDUMT53OJjm0DurVa8kOOZLD34/sNfKc7l5yOq+1PQ==
X-Received: by 2002:a05:600c:45cd:b0:41a:a4d1:a896 with SMTP id s13-20020a05600c45cd00b0041aa4d1a896mr3784206wmo.16.1714040819402;
        Thu, 25 Apr 2024 03:26:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJY9XrsRahoUquS47308gYuYDwb7vPf7/AD+bocV5qjiT1KaTqb1OttUK1khms9pm9okb6pg==
X-Received: by 2002:a05:600c:45cd:b0:41a:a4d1:a896 with SMTP id s13-20020a05600c45cd00b0041aa4d1a896mr3784184wmo.16.1714040818916;
        Thu, 25 Apr 2024 03:26:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:9e35:9594:88eb:df3e:840e])
        by smtp.gmail.com with ESMTPSA id j2-20020a05600c1c0200b0041ac3e13f1esm8619446wms.37.2024.04.25.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:26:58 -0700 (PDT)
Date: Thu, 25 Apr 2024 06:26:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for
 reconnection
Message-ID: <20240425062507-mutt-send-email-mst@kernel.org>
References: <20240412133017.483407-1-lulu@redhat.com>
 <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org>
 <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org>
 <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org>
 <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
 <20240424055108-mutt-send-email-mst@kernel.org>
 <CACGkMEtosWhV-eJbPetgPtp-Thg31CLUBGaENbQRknYtzEV3bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtosWhV-eJbPetgPtp-Thg31CLUBGaENbQRknYtzEV3bQ@mail.gmail.com>

On Thu, Apr 25, 2024 at 09:35:58AM +0800, Jason Wang wrote:
> On Wed, Apr 24, 2024 at 5:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Apr 24, 2024 at 08:44:10AM +0800, Jason Wang wrote:
> > > On Tue, Apr 23, 2024 at 4:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > > > > On Tue, Apr 23, 2024 at 4:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > > > > On Wed, Apr 17, 2024 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > > > > These functions allow vduse to allocate and free memory for reconnection
> > > > > > > > > information. The amount of memory allocated is vq_num pages.
> > > > > > > > > Each VQS will map its own page where the reconnection information will be saved
> > > > > > > > >
> > > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
> > > > > > > > >  1 file changed, 40 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > > > > >       int irq_effective_cpu;
> > > > > > > > >       struct cpumask irq_affinity;
> > > > > > > > >       struct kobject kobj;
> > > > > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  struct vduse_dev;
> > > > > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > > > > > > > >
> > > > > > > > >       vq->irq_effective_cpu = curr_cpu;
> > > > > > > > >  }
> > > > > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > > > > > > > > +{
> > > > > > > > > +     unsigned long vaddr = 0;
> > > > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > > > +
> > > > > > > > > +     for (int i = 0; i < dev->vq_num; i++) {
> > > > > > > > > +             /*page 0~ vq_num save the reconnect info for vq*/
> > > > > > > > > +             vq = dev->vqs[i];
> > > > > > > > > +             vaddr = get_zeroed_page(GFP_KERNEL);
> > > > > > > >
> > > > > > > >
> > > > > > > > I don't get why you insist on stealing kernel memory for something
> > > > > > > > that is just used by userspace to store data for its own use.
> > > > > > > > Userspace does not lack ways to persist data, for example,
> > > > > > > > create a regular file anywhere in the filesystem.
> > > > > > >
> > > > > > > Good point. So the motivation here is to:
> > > > > > >
> > > > > > > 1) be self contained, no dependency for high speed persist data
> > > > > > > storage like tmpfs
> > > > > >
> > > > > > No idea what this means.
> > > > >
> > > > > I mean a regular file may slow down the datapath performance, so
> > > > > usually the application will try to use tmpfs and other which is a
> > > > > dependency for implementing the reconnection.
> > > >
> > > > Are we worried about systems without tmpfs now?
> > >
> > > Yes.
> >
> > Why? Who ships these?
> 
> Not sure, but it could be disabled or unmounted. I'm not sure make
> VDUSE depends on TMPFS is a good idea.
> 
> Thanks

Don't disable or unmount it then?
The use-case needs to be much clearer if we are adding a way for
userspace to pin kernel memory for unlimited time.

-- 
MST


