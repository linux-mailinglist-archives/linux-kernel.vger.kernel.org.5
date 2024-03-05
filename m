Return-Path: <linux-kernel+bounces-92812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87595872644
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FFB1F24A90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291118041;
	Tue,  5 Mar 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="bs/DfrmL"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A93314286
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662092; cv=none; b=goIAy+qAewV5I6p4F73MWKJd2Uq5fxADwzwlOvCFq2PjMVZw99ACMRMXr93woG8PQIku3jfset4JNV+FNHCeoMZ+i0cjAZjmLsLLozzqbHwyQILej5pqUZNXOOn7PWYvTBHszkd8xYTNt8PS6niwVEVKHzJdlAIdy+Va1rX/YKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662092; c=relaxed/simple;
	bh=6Sy54NacpSyMETSvVMfc3fbh+bSzYtBB5w7DOWhhpsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9IT9aGSyOXHvSYsQbpjyPl5M+9mt9LBomlVAmJBCRQSVuMwD7YkEYH57sG2gY4hKcA+HVbWzbvyZQnRUJ6t8XrcsLQf3tFAVTEUIvuCI8QlYk+abHl4tGsMfqwqEHD5P6/Lu3SQMj+pAxgvJ8ZohhasCrBxInOF1jweStevecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=bs/DfrmL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e627596554so1823539b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 10:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709662090; x=1710266890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x5whaAzOMVpJ9oleSNFRgGIgTqWcKl3NhWO0NiuDErg=;
        b=qpOtFm7uOuGJYYfsgajzMJ1CABYUASjXKTtrkfq5fbZsXpE+yjEsOlsy9ZFx6/lNoI
         9rj6pQa5JyzhauQoHch2CbQj4JXmnpqj6TW4eXxznc/IRoMVPBlxuuVs80KBleckK7S4
         jAkrQKlw9maidxYoNf1cDGbfiLmoYSHUo/xtDwGF5b1bNZZN9r2/xi1BXhyauxwJ7oSs
         ChWnd2Qfa/VWDdosmN+bDZy/JVE++SWnchEsNLY+IWTCqadytMyxAl9DqEPx208vm/dg
         SpRrLsrKD2BbKlO4KPah1sijMjD88z0fIRN2G68+WZNBd/wkM1y7eQLzSQsbhtD0Uqsh
         I2IA==
X-Forwarded-Encrypted: i=1; AJvYcCWIsQ8eJbKRvJQxRUteqR4PphkVv8ekMBMmWD9VfBk9XwkouXHwIMZVcn95CaEHELYn8lwVtkR04fYku6vmi4oWZmZfepI3j9Ls44fJ
X-Gm-Message-State: AOJu0Yy2Hc6iGqPZZgfkdKvcptzlHV1zs+jw+Va6TmYVvd5rMMlh1Dcp
	2dJ10CoL0XETsw6mzjaAeSdlbxAlDOinq7QNIJXPCBKGiWpVUfVikO4sn/RQFiaF4A==
X-Google-Smtp-Source: AGHT+IHsBuJZigH06x0TIQSPMWS5CzB5BE8Lix9SJIw0WAHEauJC2Yg3UCxAysG+IWH+PtEQGVWj8w==
X-Received: by 2002:a05:6a00:2d20:b0:6e6:1822:1315 with SMTP id fa32-20020a056a002d2000b006e618221315mr7585099pfb.23.1709662088686;
        Tue, 05 Mar 2024 10:08:08 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id jw37-20020a056a0092a500b006e621e75cffsm3796044pfb.83.2024.03.05.10.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:08:08 -0800 (PST)
Date: Tue, 5 Mar 2024 15:08:04 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709662086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5whaAzOMVpJ9oleSNFRgGIgTqWcKl3NhWO0NiuDErg=;
	b=bs/DfrmLdwl2DuC1Sf7HIL2FdGgIdBdssE7oEwpnxFCNWPqZWFMc8sRttKEHufHlYzm4YB
	2b3fWMVo/o8oXzb2YI379S0dHjN8oS1c59yXYUPsFaDlLyOxV/of2TdYt8Kp4+h14D2i/n
	b43Jr7p+64MCbklVwOlgvXYuLYFCb6Ksrtmkk7VDU9voHQntmvLhN6Ji7Mv6Iu3pwOkExm
	tWXDg1iVWP58WAHyBosnvgyxXXRgl1prlryOfoXpwnLQvc1gQsxPuni7zs1KYF809P25Zt
	9qECQfyv8mFvAIuIdTSrNaXokuLjlAUAvOsTqb+oNOd436IRspqk7ACuQTOYSA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drm/amdkfd: make kfd_class constant
Message-ID: <iiyzek47iwn4av7bohszmhbgwkjpk3ytqkuwq7sk2qpoqdzrvg@msh5rt5bp3iy>
References: <20240305-class_cleanup-drm-amd-v1-1-ea99b37f26c7@marliere.net>
 <0f572801-8dcb-4124-94fa-cb219f60730d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f572801-8dcb-4124-94fa-cb219f60730d@amd.com>

On  5 Mar 12:38, Felix Kuehling wrote:
> On 2024-03-05 7:15, Ricardo B. Marliere wrote:
> > Since commit 43a7206b0963 ("driver core: class: make class_register() take
> > a const *"), the driver core allows for struct class to be in read-only
> > memory, so move the kfd_class structure to be declared at build time
> > placing it into read-only memory, instead of having to be dynamically
> > allocated at boot time.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> The patch looks good to me. Do you want me to apply this to Alex's 
> amd-staging-drm-next?
> 
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

Hi Felix!

Thanks for reviewing. The patch was based in agd5f/linux/drm-next. But I
think amd-staging-drm-next would be fine, too.

Best regards,
-	Ricardo.


> 
> 
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 21 +++++++++++----------
> >   1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index f030cafc5a0a..dfa8c69532d4 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -63,8 +63,10 @@ static const struct file_operations kfd_fops = {
> >   };
> >   
> >   static int kfd_char_dev_major = -1;
> > -static struct class *kfd_class;
> >   struct device *kfd_device;
> > +static const struct class kfd_class = {
> > +	.name = kfd_dev_name,
> > +};
> >   
> >   static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
> >   {
> > @@ -94,14 +96,13 @@ int kfd_chardev_init(void)
> >   	if (err < 0)
> >   		goto err_register_chrdev;
> >   
> > -	kfd_class = class_create(kfd_dev_name);
> > -	err = PTR_ERR(kfd_class);
> > -	if (IS_ERR(kfd_class))
> > +	err = class_register(&kfd_class);
> > +	if (err)
> >   		goto err_class_create;
> >   
> > -	kfd_device = device_create(kfd_class, NULL,
> > -					MKDEV(kfd_char_dev_major, 0),
> > -					NULL, kfd_dev_name);
> > +	kfd_device = device_create(&kfd_class, NULL,
> > +				   MKDEV(kfd_char_dev_major, 0),
> > +				   NULL, kfd_dev_name);
> >   	err = PTR_ERR(kfd_device);
> >   	if (IS_ERR(kfd_device))
> >   		goto err_device_create;
> > @@ -109,7 +110,7 @@ int kfd_chardev_init(void)
> >   	return 0;
> >   
> >   err_device_create:
> > -	class_destroy(kfd_class);
> > +	class_unregister(&kfd_class);
> >   err_class_create:
> >   	unregister_chrdev(kfd_char_dev_major, kfd_dev_name);
> >   err_register_chrdev:
> > @@ -118,8 +119,8 @@ int kfd_chardev_init(void)
> >   
> >   void kfd_chardev_exit(void)
> >   {
> > -	device_destroy(kfd_class, MKDEV(kfd_char_dev_major, 0));
> > -	class_destroy(kfd_class);
> > +	device_destroy(&kfd_class, MKDEV(kfd_char_dev_major, 0));
> > +	class_unregister(&kfd_class);
> >   	unregister_chrdev(kfd_char_dev_major, kfd_dev_name);
> >   	kfd_device = NULL;
> >   }
> >
> > ---
> > base-commit: 8bc75586ea01f1c645063d3472c115ecab03e76c
> > change-id: 20240305-class_cleanup-drm-amd-bdc7255b7540
> >
> > Best regards,

