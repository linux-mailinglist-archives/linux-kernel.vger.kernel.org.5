Return-Path: <linux-kernel+bounces-61196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDFD850EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933B71C21746
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B136EAEA;
	Mon, 12 Feb 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDuw3765"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA979FD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725990; cv=none; b=HoC0Brg+An0pCzPy3MfvGylOkXiUq3RENuISCwRrU31fU3O+jmaEqc/SYczkSaGHsc7POUr0kEsRn0V7wW80Cg6l/ojpbq6SAkShEbT9dJy//Q2u2PsWyPipJYb+CZP24/fHvK4ek5LOn4ff9h8BSOI2W4yjc27VwiqPrdZatW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725990; c=relaxed/simple;
	bh=I4E9R0xwA/wiWRCLjRonNM/vS7VQXnp85joW0SqBSrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQZTqXCYNe+Ssn9EkXarpNGCFKxCD+e4FoITibBP3D0jPj3UbGQl5wv765TGADUJa3WkjwVPEMjUeRIoSEuejKlUge2aQ3tbuyoMJ+6pH0wrfK/1PgEfhydeT7IF0fgrbeJK4qFbnrtnkxA8R4iVE5Q3sXqh2lU9g6W5/LyNOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDuw3765; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707725987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lQjqAVriqfV/RO3Ugjr/Wkmdgl2+6OB2j7bRQwASar0=;
	b=NDuw3765k8GH8S4vdZ2Z7bNXnfcZCW5DetQib2RJA/QHUnV9lfpmLLp9FHubQHe1yOeNJ7
	s81UCLI8yY489TjyiUpTo1WO9+zbOs4pnBT2JlBWr35EH3YLFo+UgiM45cpWo0BYhRKnpQ
	ZKKxpYILvs4Numd+XCge8RuxIpgNeoc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-a9j5HaiaMEasHEyaSR566g-1; Mon, 12 Feb 2024 03:19:45 -0500
X-MC-Unique: a9j5HaiaMEasHEyaSR566g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2fba67ec20so182309066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707725984; x=1708330784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQjqAVriqfV/RO3Ugjr/Wkmdgl2+6OB2j7bRQwASar0=;
        b=L/PCOrlS0HW86h06r/QHIyaif/ByUK28wsKMrPDg0RXRvjuO0P8H/WNLMuImEuOAEw
         rciIfUlglC9LOCdWg0hrtuapHOnsGR2om1d0ILpym5ih9OEsF5nleXZTNeBSmDn5DOS/
         yLpuUVczLgXKK+B80vaHm275lB9PYNBI98yqZ8a5v7BjehdfzLQZpCcZV0IoTokODiy+
         azk9zLw/kZEWNkQODHELDJ/zvV+K1Fsx3mVK56eoxVsPOieMjzrTOTea+aBkq7dPsMYG
         XfoXYcw+eMAvQ3Q0OP3O8GPrazM0G9W3YUftn1xFyf92tO9fKhLffRbGi1I/Af54GNPf
         0uvA==
X-Forwarded-Encrypted: i=1; AJvYcCW5T3R0neSuJU9h9qzG2JBBxD65OZOr8NdyQsZyIw2FHtPkHHfUjzQcyevwRhzl1Znby6igXAU57Cv43hkzmNpNbd1pSTos6aJbob6P
X-Gm-Message-State: AOJu0YyJNv7jhYK/iQsT+O3V7WHyrYNU4OpPEzFwCTU1/qiuqkq8y+i8
	nEyKU0BX0HOoafVIZzemzJa4m/+Mts2bBzAwAxgG+vidKjBi0LBZTL6PZfm6vzFVG6Y22TuL6bc
	+iaHOnGXkJIoh/wH63LRB1hYklAuHG/PcC7Vr+rvzH+boM3Kx36YnugMlCdIF92Sf3iZRDQ==
X-Received: by 2002:a17:907:1188:b0:a3c:36ae:6c96 with SMTP id uz8-20020a170907118800b00a3c36ae6c96mr3303304ejb.42.1707725984258;
        Mon, 12 Feb 2024 00:19:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuv2yXO2qRvX72QX7GYrSJyaiawng8PNwVNQmwh/vWxNOis0v/WxumMQoGvxk2ldmRs+05Kg==
X-Received: by 2002:a17:907:1188:b0:a3c:36ae:6c96 with SMTP id uz8-20020a170907118800b00a3c36ae6c96mr3303297ejb.42.1707725983920;
        Mon, 12 Feb 2024 00:19:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUx1DVn3NtyWCcg88vdkQVJynYFJL4yJLZYzIxf6wNZXAsNys5kG0KJHxdzXLkiKNTY0c2SkMtdIsPrNg5Ty0wJyO55poMERFAy91zEcqq/4anzHwO6D9+BXIUUK9sJN+4t0VefznK0qgTkrbDJ0KOvJThNmaXOYnXoxy3LyOyET/LiRBizbFyueBlM8R0Mq5Cla7/c0xqHNLY28w5cU3VgHC4=
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id z22-20020a170906715600b00a34c07816e3sm3610793ejj.73.2024.02.12.00.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 00:19:43 -0800 (PST)
Date: Mon, 12 Feb 2024 03:19:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
Message-ID: <20240212031722-mutt-send-email-mst@kernel.org>
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>

On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
> Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
> vdpa devices.
> 
> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

I don't think failing suspend or resume makes sense though -
e.g. practically failing suspend will just prevent sleeping I think -
why should guest not having driver loaded prevent
system suspend?

there's also state such as features set which does need to be
preserved.

I think the thing to do is to skip invoking suspend/resume callback, and in
fact checking suspend/resume altogether.

> ---
>  drivers/vhost/vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..ce1882acfc3b 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>  	if (!ops->suspend)
>  		return -EOPNOTSUPP;
>  
> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		return -EINVAL;
> +
>  	ret = ops->suspend(vdpa);
>  	if (!ret)
>  		v->suspended = true;
> @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>  	if (!ops->resume)
>  		return -EOPNOTSUPP;
>  
> +	if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +		return -EINVAL;
> +
>  	ret = ops->resume(vdpa);
>  	if (!ret)
>  		v->suspended = false;
> -- 
> 2.39.3


