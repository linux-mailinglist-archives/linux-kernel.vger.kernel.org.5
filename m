Return-Path: <linux-kernel+bounces-144051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184AB8A4143
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9744281B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A68C23769;
	Sun, 14 Apr 2024 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrcFMysy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F77023748
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083713; cv=none; b=JuCOGXLECiMqRu4ohqLC2mJstaLjAjnFoZLBNFeyTGlz4Vid85wLmjI7kZuMeTtfV/q+Kqb73bxeFsiz3wi5BfN38U8iR0zbc7JSv4+btbj+8+pSdjDoWABumiTNSk1nLHdZCfRVY6EOlnqEmBCxl0xmd01nsUslnnUe8mFpnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083713; c=relaxed/simple;
	bh=ZPYqqtyateQAglR+k6OVKvCAe8YRzI/MA8ssd/t5pbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmOen3/3MKp8NOO19kh81tne/9BTYM1D68gk8aq1g+cYZgTibSohVHIlvCNUiDoqL6pn7CF+hqGGMeGu8rhWsj/jQRPbpCJQ9wE/9RVuBAjhVzhwgXQ5wt67TpwEAKcZfMhBqipVOVjRo/+afqbdngLpLVbOc60ght8pvUuW8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrcFMysy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713083710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmgfpCrRtCqNbVMsFXJuOmvk/MLLt9gA4dRZP1RBeX4=;
	b=VrcFMysypTOei2Nx+OKdh1UuUdODAWgXQBp5ZKaipGgmQM2dUf2K4+ZhZXPzAthXn0yCsi
	bepF8E951QSn8rrpZkag7YOJMZ0iejCnfUPirF54yOF2Cn5c4gqBrt/QrgS+Za+9YVNF2X
	E2YUfUYxX8tHNOFl9e1w1FjD4/ZII+c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-yAkxYB7tNjqbuHTwOQ18Kw-1; Sun, 14 Apr 2024 04:35:08 -0400
X-MC-Unique: yAkxYB7tNjqbuHTwOQ18Kw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343f1064acaso1387941f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713083707; x=1713688507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmgfpCrRtCqNbVMsFXJuOmvk/MLLt9gA4dRZP1RBeX4=;
        b=tIzZjKakBqzCnKHj+lFZMPssGmBt73UVs5Rnt0VXoWJFYQORV4DmVYpInVBv/3vApw
         5XDhcgmi4B71t5dXUl0uY7ADJMEKw1ur9/1xZVFFSExBCcR1OUBs65xjyLvc0VrP3FIJ
         3H2tM37U4A6UJN9SSxqzipfO/x2i3Bpc1I6lLmVFwu5vIIPoPWmPtCH+vbScPQJ8zlVE
         nVbrAWe8JdmWr0mrUyqaHprBPsDXP94pEYglBD9CBAJ3lWYSzD0sNOWUWg86l0nqmJx7
         lLXiR55HYx7QYIrYBXqvaqYAHfQkhoEBoSlqXdFafsSUO6ZfqSzAMS8mqYYlr3eGxRKP
         to/g==
X-Forwarded-Encrypted: i=1; AJvYcCW+IGddY+rLtqy/v/IDTPCt0ub24wJl4/Zk9z6bv7Jkq2wlXt4YruJbPmdRSsK5de2B6YvD2l0NCL4etBY5Powtq+JI4WoKnTnEDqjr
X-Gm-Message-State: AOJu0YzRI+DlQCDxWSBpS2doZYdE6ZuhC69LP+nCKz3+uMZLkjjMF6XS
	bQJfPEr39jbGW2d6cLl16wh8k0e5S5WoiBphGmsvu8UksAhVYYxn/eH17ymaUhhLyEuiuSvpbQo
	HoCPsuR/Or09VwP+jG1DTpx6HyzMHE5MZ6oMsMukGattojZuzbOzrBa5IXoUv5UjXrsPvWQ==
X-Received: by 2002:a05:6000:232:b0:345:663f:f0a1 with SMTP id l18-20020a056000023200b00345663ff0a1mr5215822wrz.55.1713083706781;
        Sun, 14 Apr 2024 01:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEud3PzT7Nr9AygoJHk6xDRgJwZJGsPs20hazfYSLls12vM50Lh6SjxqeEIXzgG7uN3p2DHqQ==
X-Received: by 2002:a05:6000:232:b0:345:663f:f0a1 with SMTP id l18-20020a056000023200b00345663ff0a1mr5215809wrz.55.1713083706195;
        Sun, 14 Apr 2024 01:35:06 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe3c9000000b00344a8f9cf18sm8576894wrm.7.2024.04.14.01.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:35:05 -0700 (PDT)
Date: Sun, 14 Apr 2024 04:35:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20240414043334-mutt-send-email-mst@kernel.org>
References: <bd27d4066f7749997a75cf4111fbf51e11d5898d.1705350942.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd27d4066f7749997a75cf4111fbf51e11d5898d.1705350942.git.christophe.jaillet@wanadoo.fr>

On Mon, Jan 15, 2024 at 09:35:50PM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, buInputt the one of

What's buInputt? But?

> ida_alloc_max() is inclusive. So a -1 has been added when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Jason, wanna ack?

> ---
>  drivers/vhost/vdpa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..849b9d2dd51f 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1534,7 +1534,7 @@ static void vhost_vdpa_release_dev(struct device *device)
>  	struct vhost_vdpa *v =
>  	       container_of(device, struct vhost_vdpa, dev);
>  
> -	ida_simple_remove(&vhost_vdpa_ida, v->minor);
> +	ida_free(&vhost_vdpa_ida, v->minor);
>  	kfree(v->vqs);
>  	kfree(v);
>  }
> @@ -1557,8 +1557,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>  	if (!v)
>  		return -ENOMEM;
>  
> -	minor = ida_simple_get(&vhost_vdpa_ida, 0,
> -			       VHOST_VDPA_DEV_MAX, GFP_KERNEL);
> +	minor = ida_alloc_max(&vhost_vdpa_ida, VHOST_VDPA_DEV_MAX - 1,
> +			      GFP_KERNEL);
>  	if (minor < 0) {
>  		kfree(v);
>  		return minor;
> -- 
> 2.43.0


