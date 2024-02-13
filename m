Return-Path: <linux-kernel+bounces-62558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FEB8522E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0C9285961
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F7CEDC;
	Tue, 13 Feb 2024 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLLpdeRF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CF07E6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782808; cv=none; b=QgfIZJyYqaJs88MX2E+Ex42SxW8PUweS2+S4hRMs6LbeKlAsgZw54RVeqwYmDWq/CPFwlphQA5E2YyoU5mPipnNHQS88v7Ty2rbNxA8aIC3tKyhmi33kQaJb6GzZkY9pPZD5EL1bXBZ8llhrazq39HxfoaOoLDCBe1S7ZJK3bNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782808; c=relaxed/simple;
	bh=jMnnyoNXxFmFhw7xz0fpCdQOOntpU6lZXJA6WYcxJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLYRma9qVzqKmp9nUl+3Nq+ltZ3a4+GsmH68MaBBqOHn8pQwxFoMwR6+cf87u9jEaHTagUkDHlQuB7cHb0xp1CTGTgKYvjz9vfw7VaUEUEO7SWLHdsSoMav3r6/tAtFOoppTxEe4HRZMFe9f8DhtaELHhN2gNCcDbe5UAWXhSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLLpdeRF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707782805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gEkRB5X9nhp6e5CZwbs1ixb2tAsBEKZ2oc5X6L0U38k=;
	b=RLLpdeRFNwumvMypYT+AUemZ5QxgTW7pTsxj4hfKza1IZ2y9m7ien/Aku847S0/ATQxh/k
	/JO9hq5ZXKQZCzqFxrFTwn6eYSIlGFYrVhbAwFz+JDzjQYXwj6HqlubNbQO0Rcrr7WDaf2
	/w8pRgsU5//e5PZjJ6nTPb6X49u5btE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-EhKOKVKEMJezXOxh9p4XwA-1; Mon, 12 Feb 2024 19:06:41 -0500
X-MC-Unique: EhKOKVKEMJezXOxh9p4XwA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a26f2da3c7bso192968966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707782800; x=1708387600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEkRB5X9nhp6e5CZwbs1ixb2tAsBEKZ2oc5X6L0U38k=;
        b=oWBb1plXDrBTdprb8WhP9KRzKyvXNCwjJ6uPDgtIQLU3eGELRvsUfK8SiSChoJ838r
         7Z3/szMGJCh9wUSTy+PDJla36h4+BAprzkoXqIIis9WtsnB5hR2cYIg61qHkX5gxbfnZ
         bDZ/jNpvCFMJKlOiLiYU5ZC4rWbsrPugkRC3oKIMwmmA1O3E4foqIVsJqJeYONcRRwhu
         bn3hJKDn7m/RLj4NBiY+4Pga7qmxr/hRWujnTKlHrUk/hwgWRMRz45vfb346Ge3P+ALm
         yAtUaNFyas91a4qZT1sVOfLXkwZrob8IKXuv5/i2UMt/PTFYR3nNxO9O8uRDprp7XsPm
         W0pw==
X-Forwarded-Encrypted: i=1; AJvYcCUEzzeXnORe4r7rlchhtJJafEgmVMHH3I2eQAPEHltgp3llU3FI20a95dLoD67ffD6JFx3GU6zw2DnZhD0J/hYa7XSibBdYQGJB9qPp
X-Gm-Message-State: AOJu0Yz3ojuIvMdPdbXOy5XwMIWZz8m/uKpA4dnx8LEITEjeIx3tJDIV
	dQX4fpa6nFxQ9Z5/CvIAmirpJteOTscXww/tGIHN5aRJTngaDGnsCOru6K0dU/BO+38qRu0FEtv
	pyhs0GlFyoC5XKIw323bKQzBDew12CcbmzIihNX7BgTSPqrlIe8efiHQWXuBqGg==
X-Received: by 2002:a17:906:3b56:b0:a37:8a2c:316a with SMTP id h22-20020a1709063b5600b00a378a2c316amr5386150ejf.45.1707782800516;
        Mon, 12 Feb 2024 16:06:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7LRdkAWmFp59moKlLNAtUzytroiaAJc4XSzIy0GJCxR+hnxcv59RblAMdZ3n+o+Ek+kgN5Q==
X-Received: by 2002:a17:906:3b56:b0:a37:8a2c:316a with SMTP id h22-20020a1709063b5600b00a378a2c316amr5386139ejf.45.1707782800133;
        Mon, 12 Feb 2024 16:06:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhSLlW6LQbIyotm6kODHZhTnovjWYe6PE+ZAOplUjdM/Yr7vaSf+YlmTBcfVwbT2YrzE5TV8LCjUVbNx6eLUGeW/dexxjI0RwjwbD/eO9GCkWbX/EmfsgEVVGEcqAWL67ESi2jshYKjHTOWOP0YRA5Gbuy9I5PUvVD8lDw2t/I6JdMucqfL7Cv0oFXk0t359G4V1vKFEaLhpkT4UA5QXSxgy8=
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906370d00b00a3c66ac5146sm693550ejc.120.2024.02.12.16.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:06:38 -0800 (PST)
Date: Mon, 12 Feb 2024 19:06:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
Message-ID: <20240212190628-mutt-send-email-mst@kernel.org>
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
 <20240212031722-mutt-send-email-mst@kernel.org>
 <a4d2626d-7d74-4243-93a9-01d7adc8cda4@oracle.com>
 <20240212105604-mutt-send-email-mst@kernel.org>
 <e3515937-7d36-4167-84dc-a9c1721249cc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3515937-7d36-4167-84dc-a9c1721249cc@oracle.com>

On Mon, Feb 12, 2024 at 11:37:12AM -0500, Steven Sistare wrote:
> On 2/12/2024 10:56 AM, Michael S. Tsirkin wrote:
> > On Mon, Feb 12, 2024 at 09:56:31AM -0500, Steven Sistare wrote:
> >> On 2/12/2024 3:19 AM, Michael S. Tsirkin wrote:
> >>> On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
> >>>> Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
> >>>> vdpa devices.
> >>>>
> >>>> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> >>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>>
> >>> I don't think failing suspend or resume makes sense though -
> >>> e.g. practically failing suspend will just prevent sleeping I think -
> >>> why should guest not having driver loaded prevent system suspend?
> >>
> >> Got it, my fix is too heavy handed.
> >>
> >>> there's also state such as features set which does need to be
> >>> preserved.
> >>>
> >>> I think the thing to do is to skip invoking suspend/resume callback
> >>
> >> OK.
> >>
> >>>  and in
> >>> fact checking suspend/resume altogether.
> >>
> >> Currently ops->suspend, vhost_vdpa_can_suspend(), and VHOST_BACKEND_F_SUSPEND
> >> are equivalent.  Hence if !ops->suspend, then then the driver does not support
> >> it, and indeed may break if suspend is used, so system suspend must be blocked,
> >> AFAICT.  Yielding:
> > 
> > If DRIVER_OK is not set then there's nothing to be done for migration.
> > So callback not needed.
> 
> OK, I missed your point.  Next attempt:
> 
>    vhost_vdpa_suspend()
>        if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>            return 0;
> 
>        if (!ops->suspend)
>            return -EOPNOTSUPP;

right

> - Steve
> >>     vhost_vdpa_suspend()
> >>         if (!ops->suspend)
> >>             return -EOPNOTSUPP;
> >>
> >>         if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >>             return 0;
> >>
> >> - Steve
> >>
> >>>> ---
> >>>>  drivers/vhost/vdpa.c | 6 ++++++
> >>>>  1 file changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >>>> index bc4a51e4638b..ce1882acfc3b 100644
> >>>> --- a/drivers/vhost/vdpa.c
> >>>> +++ b/drivers/vhost/vdpa.c
> >>>> @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
> >>>>  	if (!ops->suspend)
> >>>>  		return -EOPNOTSUPP;
> >>>>  
> >>>> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >>>> +		return -EINVAL;
> >>>> +
> >>>>  	ret = ops->suspend(vdpa);
> >>>>  	if (!ret)
> >>>>  		v->suspended = true;
> >>>> @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
> >>>>  	if (!ops->resume)
> >>>>  		return -EOPNOTSUPP;
> >>>>  
> >>>> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> >>>> +		return -EINVAL;
> >>>> +
> >>>>  	ret = ops->resume(vdpa);
> >>>>  	if (!ret)
> >>>>  		v->suspended = false;
> >>>> -- 
> >>>> 2.39.3
> >>>
> > 


