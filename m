Return-Path: <linux-kernel+bounces-83541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E01B869B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E1F1F25874
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EC9148FE5;
	Tue, 27 Feb 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO5g2sSg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62A1482E3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048939; cv=none; b=t9wHXJE0aE2VBIcJuqh5qupjcNS9Cm4rI7caPdk3j3S44wNOPTV7ZVSf33IDK/ZPPWBer0fdv+ACUz3AFZ07TWoX0sPRlX7oao4tKmZGfDkN1hpz1u1RDHYoL7kPuPsIAtwrlbrImg3qOXEqrZ/u01Sg7ilq4fYDtFiR5Bow3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048939; c=relaxed/simple;
	bh=up+DCN5ChGl/E+3j2L4zs+YPx9EtncoGLVBvu8pAspA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0Ks2kp3bLiK2U8fHUOXKtjTNgQJrMkxYmTeErgipAH4evvHE/YKoBmCdlCEFNzW+pKDQvwWXkPglKJHUweEK0+P/BHxHUz89SiMdyJWqQfIOj/cqeddAnL8tCj5f+5j2kERR0Pl8Va9Y7SvdZOnglMC92WEAZ/vVBa32sSlvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO5g2sSg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709048937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xbnPq7RXIvNg+PfYUQ/SxQLN6DLHw3idVYtn+kLNDc=;
	b=YO5g2sSgOA9ZUeviweCeFCQ4DH0bxYJCawiNTNqm0voftXnIsfR1qJVAVEHMRrCJ427qG6
	39PGcW0pYoPvkFmHQIl/SeZY0sAGoFtXWXm8OHkWvM9pGNspHNnMrM5Be82GBym1yMH9WT
	3uLjAXEE1CU9fN9DGZnmR5zFclMe1MQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-ndtj2l53OwmyEkRUSmQ0xA-1; Tue, 27 Feb 2024 10:48:55 -0500
X-MC-Unique: ndtj2l53OwmyEkRUSmQ0xA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d29de76abso2335288f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048934; x=1709653734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xbnPq7RXIvNg+PfYUQ/SxQLN6DLHw3idVYtn+kLNDc=;
        b=JrvqiBDQDYea/odTYU1WfQ2tkILCx3ojG3KFpfTUgGOcXif2RrrR0qa1bFO7KX0YEP
         7RVyfVVB7niKB097nNyf8MfrO5NmwjdkakZmT+QNPWAkclbY3+rW/tCJBohOqiAS37WL
         Gug9Lf6oVR3EypmkptTqMrj1sBTDl8WHCuZ9dLtczCAsbHos3cfGljlfAzHLaceSaIY7
         dTwN4EDqaTFmm9eaeH4F95C9NZVLM5oufeVUEXPRvxcMz9jFIk2ZLs817wycvCtZVf2u
         x7cUd5exubs1svgV+Dg1M0bmfL8yuGs4yA8BEGO2pCwyMiBFbG5TkpRf9ScfgUPvnTuW
         AlAg==
X-Forwarded-Encrypted: i=1; AJvYcCWrEqvSimlgGnZ+pV6vDFPTx7ivYiDJEtljBM2dwmpPVnAGegAJ1FaZQsl4G8g98jQymwWakcJ1x8QnQjFOcu/XVKY9LSUPZpQPoZo6
X-Gm-Message-State: AOJu0Yyijkkx1tvamq2Hly1CCWfHrSF1Azho8nBDnsXptWixa3ceHczZ
	tIl2AOmAukio7nmVefkOLttcf6nRnOnGmBteE1HDGLzNsydo42gFnNj2B5YSqwbCEUTuwNwHIvh
	uad5uDYY9W4IssyBQewynv2a84b7wlqoFjCd8dLlforK5GScv0LhABVNWc+9Orw==
X-Received: by 2002:adf:e702:0:b0:33d:509c:5692 with SMTP id c2-20020adfe702000000b0033d509c5692mr7613812wrm.31.1709048934563;
        Tue, 27 Feb 2024 07:48:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhhMpgy8POimkjUANc+4RteuVbX4FX4SRQYH18i2c3XpSnO3gd/o0FCmDM1lLUaZunxWosww==
X-Received: by 2002:adf:e702:0:b0:33d:509c:5692 with SMTP id c2-20020adfe702000000b0033d509c5692mr7613789wrm.31.1709048934215;
        Tue, 27 Feb 2024 07:48:54 -0800 (PST)
Received: from redhat.com ([2.52.10.44])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b0033dbeb2eb4dsm11575355wrn.110.2024.02.27.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:48:53 -0800 (PST)
Date: Tue, 27 Feb 2024 10:48:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <20240227104743-mutt-send-email-mst@kernel.org>
References: <e26476e0-68ae-412d-a5d9-4996bc30d038@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e26476e0-68ae-412d-a5d9-4996bc30d038@moroto.mountain>

On Tue, Feb 27, 2024 at 06:21:46PM +0300, Dan Carpenter wrote:
> The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> reading one element beyond the end of the array.
> 
> Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>


Oh wow and does this not come from userspace? If yes we
need the speculation magic macro when using the index, do we not?

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index b7a1fb88c506..9150c8281953 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1532,7 +1532,7 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
>  	if ((vma->vm_flags & VM_SHARED) == 0)
>  		return -EINVAL;
>  
> -	if (index > dev->vq_num)
> +	if (index >= dev->vq_num)
>  		return -EINVAL;
>  
>  	vq = dev->vqs[index];
> -- 
> 2.43.0


