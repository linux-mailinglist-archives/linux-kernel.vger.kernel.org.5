Return-Path: <linux-kernel+bounces-61929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD5F85188E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA031C21771
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBC13D0B5;
	Mon, 12 Feb 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEo6XOsC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F56F3CF72
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753414; cv=none; b=bXlm7KzxAtI0kq+DPodtoBTcdW5/xcOsJBEgVJxIXZ2oV1lDtR7gEnsl3HBZeG/5ZhbQZEinoqT8F8PyMpA/HjlaetwXWKlW/Prr3/OkaGgnt5ebOy+PmVPtuWBQV3kULpvGPjbh/zpcrvF1NJ6BdfbXpRboBfjX8B99AU9ZUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753414; c=relaxed/simple;
	bh=i+CWSXjieb9+g3XNqpNF8tfttfF6GckHkqIIP8N1CSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfPmwLsvO93IhuxC643vytIsSPwn0F9bYSnz4wIcAMuevZpMjc6aWUVMZUYW5NOdtgbf/uE27e7B4lzX7Y6cKxEl+4ffvJaHOqcR4FQd0i4Lut9xkwPP97mcaKkRXPIsRIkuWtMSlavD0XLammQjP7/RgzwqA3lh86ORiZHHVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NEo6XOsC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707753412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80GrjE91srg+UL67pV7wExMUIzc8aRkIezP7bk9CD6k=;
	b=NEo6XOsCUZS7fd1Na9MvitwSnOSqJJXhYXSDJ+eWGuIe8ogVXXhHz2k0UJRaGBDSP9nL/c
	THNIGDd7ZLPHWyLiYUr56p7aMl1odzy37cGgf3uZQJWQ1eCC1OF9ocBBmN1cHTheGjgyQ/
	vah/nJlEO7jpuygMyUgAZbv6AcERBA0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-0E5WVMycNuqzcQRPl9bcRg-1; Mon, 12 Feb 2024 10:56:49 -0500
X-MC-Unique: 0E5WVMycNuqzcQRPl9bcRg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2f71c83b7eso260467466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753408; x=1708358208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80GrjE91srg+UL67pV7wExMUIzc8aRkIezP7bk9CD6k=;
        b=WDmpshS5W0YRnenjR5bkMEFGrMhU06j8r6eNURCqwhsM2f5Uq9szrDWST3GLrFT0Gl
         32GfjLQr0uKOchFOTM+mRM6TumQM5hill5V0Gj6dRWYr6VddtLb/LcKdV/ID71nKeHx+
         iMhv/SpnIvauKmLtf3GsQ+9ZDZU6e4j3GiAtsruRw0DjgdkCQtkEZ8rZDZoajpTSirl0
         OGajsKKvaWTVEsxN0+mwKQdogNsnsS2KQJE3YS/UE0R1+sBZDxmRouTbnp+dB8sWikjy
         +fRKrZH0h604c7AsjK3vKW4DqXwUiNvv+tLgui+L3prZE8Ng/YZpmtqUKZCVthqezrCb
         ySpw==
X-Gm-Message-State: AOJu0YxZ/ko3WcrKoauctKqpBP0bQZOKXO1HrCxh8vLIX3bEzWLS4Bhh
	Ov1IE/pMgGqglqF9v22o1+iz5sXono7jGD+4eHzfXrpULOf5QLjR//dZ4bc15jCAq40IfBn6iHh
	GhN79GUjucalc+pn1mzBGotGaFcQse2WLZuSs2aWHTGf151VCvMBuzOVFLSenSg==
X-Received: by 2002:a17:906:dd2:b0:a3c:d159:cb27 with SMTP id p18-20020a1709060dd200b00a3cd159cb27mr1049462eji.72.1707753408721;
        Mon, 12 Feb 2024 07:56:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyKF1R8d6gAgnYz0NnbDP75czUwW1lB9zvvmzVavx3OhAr2ygTGmn4J2bxDaU9fm51Qb++4g==
X-Received: by 2002:a17:906:dd2:b0:a3c:d159:cb27 with SMTP id p18-20020a1709060dd200b00a3cd159cb27mr1049449eji.72.1707753408300;
        Mon, 12 Feb 2024 07:56:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUe7XGBQb9gJA94EmQMG/iEZxuM39xO8CoJr7ldFc2kcTVE8KHBgtrE3eutSTFm7JQHbvX9iTEf7oH2wHP+x50U3qEUtf9y+yIGzwicMdnos0Ajy5B0RkbgH+3QtYAQIz4VOwQG8Bjkrqrx01U0yvf1aV9xDHw7GjOMxDUatXoFIizfsH/rT2Y+eU/Fr4VOBJ5qiyl+5so/SD4yLKeWsp9cSvY=
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id gv20-20020a170906f11400b00a3c9bd8e1c9sm330563ejb.76.2024.02.12.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:56:47 -0800 (PST)
Date: Mon, 12 Feb 2024 10:56:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
Message-ID: <20240212105604-mutt-send-email-mst@kernel.org>
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
 <20240212031722-mutt-send-email-mst@kernel.org>
 <a4d2626d-7d74-4243-93a9-01d7adc8cda4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d2626d-7d74-4243-93a9-01d7adc8cda4@oracle.com>

On Mon, Feb 12, 2024 at 09:56:31AM -0500, Steven Sistare wrote:
> On 2/12/2024 3:19 AM, Michael S. Tsirkin wrote:
> > On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
> >> Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
> >> vdpa devices.
> >>
> >> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > I don't think failing suspend or resume makes sense though -
> > e.g. practically failing suspend will just prevent sleeping I think -
> > why should guest not having driver loaded prevent system suspend?
> 
> Got it, my fix is too heavy handed.
> 
> > there's also state such as features set which does need to be
> > preserved.
> > 
> > I think the thing to do is to skip invoking suspend/resume callback
> 
> OK.
> 
> >  and in
> > fact checking suspend/resume altogether.
> 
> Currently ops->suspend, vhost_vdpa_can_suspend(), and VHOST_BACKEND_F_SUSPEND
> are equivalent.  Hence if !ops->suspend, then then the driver does not support
> it, and indeed may break if suspend is used, so system suspend must be blocked,
> AFAICT.  Yielding:

If DRIVER_OK is not set then there's nothing to be done for migration.
So callback not needed.


>     vhost_vdpa_suspend()
>         if (!ops->suspend)
>             return -EOPNOTSUPP;
> 
>         if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>             return 0;
> 
> - Steve
> 
> >> ---
> >>  drivers/vhost/vdpa.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index bc4a51e4638b..ce1882acfc3b 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
> >>  	if (!ops->suspend)
> >>  		return -EOPNOTSUPP;
> >>  
> >> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >> +		return -EINVAL;
> >> +
> >>  	ret = ops->suspend(vdpa);
> >>  	if (!ret)
> >>  		v->suspended = true;
> >> @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
> >>  	if (!ops->resume)
> >>  		return -EOPNOTSUPP;
> >>  
> >> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >> +		return -EINVAL;
> >> +
> >>  	ret = ops->resume(vdpa);
> >>  	if (!ret)
> >>  		v->suspended = false;
> >> -- 
> >> 2.39.3
> > 


