Return-Path: <linux-kernel+bounces-97441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2123876A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09AB1C21154
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5A53E17;
	Fri,  8 Mar 2024 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYPHHZvm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BD4F213
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921392; cv=none; b=kmtAu3sO9sPpM+6yNujaHiIaSz0RMIzAz9LNrBLABwKHbAMOCKnKIbozQiC9q4CKTwZRkXieYx83jTLXRnSPLP89NZ2kbwERY2AA7TZgby1YTj+7VhLbq/gbs05FNOABZocgEStoVKUECVl3m+v8I8Y8CK2yEwbfDwvx7hBtdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921392; c=relaxed/simple;
	bh=LikYyzCecy2Q4f2KC79AVP0DWAPyW0dRwSVNlJmxM1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uU+YSsF7aqIFEHJyrxLDu9Zn/5vzMUnlAflD2tYp5lWmvha3GSGe35EzooFCXqd/WdCnlG+oDCC3ulLNtdLc3XbDlGrWvqhuZgUFRqBlWPhI01t7bI/ymXUHIxMuAzDkHuxxiNez/ZfEefbE2s94Ev4yILV6uMGc3zTlgklRPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYPHHZvm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709921389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xz/YxiA/VGUbQYXY3ND1aG0ujsEUkM8N72A3ZL6M5NI=;
	b=ZYPHHZvm96rjEEwCZerOrzm1V7G+4PtBlr8V4t5MBrTm7ypCn1k6OPvlF7fPcF2NtXkEm+
	TgfeYbV4bl2PGLKgJss/rt+KW8AJ9kQkTfdvqqd9/oc/RkXRgFmTHaLE93B9DmVeloYkeF
	wTp7qVxPJZNEzOKlfqI0jW5QDV9fdDU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-jVr-e7yBPIG7jGLSQ7mspg-1; Fri, 08 Mar 2024 13:09:45 -0500
X-MC-Unique: jVr-e7yBPIG7jGLSQ7mspg-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36516d55c5fso21303895ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 10:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709921381; x=1710526181;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xz/YxiA/VGUbQYXY3ND1aG0ujsEUkM8N72A3ZL6M5NI=;
        b=u2jJf4ZxXpeJXB7ZiAUYtLhq4BFGvhMdoDWmTLoLNpzPB3ZsCeVfz8TGAEq55woSXW
         wCOh5MjqQdI6iB5DkiGVTVOm3U3kkkLtpc8AWmGchto4bYyi5wx2QHKqS3TlrYBtEdd9
         xMXK3o2nuf6APJpKLUWiC/qpKQOnamW9yTJSnLPqYrjNfKC0T+88PbSB0hC23P3T/KwM
         Jl1SsayHeu3HXxXY1Yar+7bLyiB/k99oGKZNHo4NgKtF5SM0JCMK2OlFvyB6axXuh8/Q
         CnCKQ49mgqNRckFC3CmV541tkfQPD1hbXN02YXdfA82Z+nECv6aYRIsCBKN+OgyBzBuP
         vd9g==
X-Forwarded-Encrypted: i=1; AJvYcCU9UClnwn07S3UVUh0MjlEXVnqH2Q83ye0fRKsrlPpfCAMuHZj67+d+xCKX/9xSCV6h40urOmDnRW+BPTTCCNmcxXKaTPxI+UB5MVbd
X-Gm-Message-State: AOJu0YwRT5GDJLXdml2eM43hZ5CZNtmqUIlf6zj5X5CGUUkcdB+clVhI
	KgrUu1HYJeTfPsFwfPcmEgLKEMZyP9/cTXh01ZdCwaFYGxcXYo1OtLIGJ8kTQ/XZTTJ0F2ErQ3y
	890MYtZ+ozaEy4xuwBFi5R2LiGxxSFyesWYApUM99Iwl3qxXzSr14qs/rSnZQ1g==
X-Received: by 2002:a05:6e02:218c:b0:365:1749:cae5 with SMTP id j12-20020a056e02218c00b003651749cae5mr26162581ila.19.1709921381788;
        Fri, 08 Mar 2024 10:09:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1gQYxWu4+4Cc/UIrD66Vitl3FDWB+wq5vJpfnJ7XfX/xSfWuW2ihD+P4DW6Rr6XiJ+ynUKw==
X-Received: by 2002:a05:6e02:218c:b0:365:1749:cae5 with SMTP id j12-20020a056e02218c00b003651749cae5mr26162558ila.19.1709921381520;
        Fri, 08 Mar 2024 10:09:41 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id j8-20020a05663822c800b00476c165e60csm646730jat.30.2024.03.08.10.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:09:40 -0800 (PST)
Date: Fri, 8 Mar 2024 11:09:37 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "clg@redhat.com" <clg@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] vfio/platform: Disable virqfds on cleanup
Message-ID: <20240308110937.2f2d934e.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB52766BAB438D1D1B782243038C272@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240306211445.1856768-1-alex.williamson@redhat.com>
	<20240306211445.1856768-6-alex.williamson@redhat.com>
	<BN9PR11MB52766BAB438D1D1B782243038C272@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 07:16:02 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, March 7, 2024 5:15 AM
> > 
> > @@ -321,8 +321,13 @@ void vfio_platform_irq_cleanup(struct
> > vfio_platform_device *vdev)
> >  {
> >  	int i;
> > 
> > -	for (i = 0; i < vdev->num_irqs; i++)
> > +	for (i = 0; i < vdev->num_irqs; i++) {
> > +		int hwirq = vdev->get_irq(vdev, i);  
> 
> hwirq is unused.

Yep, poor split with the next patch.  I'll update the next patch to use
vdev->irqs[i].hwirq here and in the unwind on init to avoid this.  Thanks,

Alex

> > +
> > +		vfio_virqfd_disable(&vdev->irqs[i].mask);
> > +		vfio_virqfd_disable(&vdev->irqs[i].unmask);
> >  		vfio_set_trigger(vdev, i, -1, NULL);
> > +	}
> > 
> >  	vdev->num_irqs = 0;
> >  	kfree(vdev->irqs);
> > --
> > 2.43.2  
> 


