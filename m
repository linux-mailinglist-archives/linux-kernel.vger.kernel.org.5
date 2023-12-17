Return-Path: <linux-kernel+bounces-2610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BC7815F64
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDED1F214B0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7DB44386;
	Sun, 17 Dec 2023 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwXn7Wsz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911643AB2;
	Sun, 17 Dec 2023 13:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978FEC433CA;
	Sun, 17 Dec 2023 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702819693;
	bh=VKYxZmLJHrRUExvb6OD/oatGIk4PJt4i1hI6U0b9XWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UwXn7WszwCiXAwBiYF/59t7ZPi9popEe7VvyKdXGshzDP7oiefSoyeAHBo37ALRUK
	 84Ef09r7feHWuLWUNe/gcBMhZAiaykYnEijYpe7Sgy0LIAOIC/2e4bmrstpQGWoivd
	 p6aNX3Kuc6fgSwqT3+VOXPIftiOZfAn7T4R5Soe5MwuqgoCOflSaxXfy48G/IhiVoC
	 4RWVMdKP7xX411dDLJmMn7j7dO3HqV7VwOFcwQ20t2OAKf9+UrIDSGdLotKSjNQL7W
	 ovgfxjduOZfE3o9g0iPcoIndC6dU4Vevyn9J4uTJaYAhvck82QT5G+aTHzydsOTvPa
	 6YXnZRjnXIJUA==
Date: Sun, 17 Dec 2023 13:28:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix memleak in iio_device_register_sysfs
Message-ID: <20231217132800.27e83a01@jic23-huawei>
In-Reply-To: <20231210133228.5fd425ea@jic23-huawei>
References: <20231208073119.29283-1-dinghao.liu@zju.edu.cn>
	<20231210133228.5fd425ea@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Dec 2023 13:32:28 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri,  8 Dec 2023 15:31:19 +0800
> Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> 
> > When iio_device_register_sysfs_group() fails, we should
> > free iio_dev_opaque->chan_attr_group.attrs to prevent
> > potential memleak.
> > 
> > Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>  
> Hi.
> 
> Looks good to me, but I'd like to leave this one on the list a little
> longer to see if anyone else has comments.
> 
Guess no comments!

Applied to the fixes-togreg branch of iio.git.  I might not get another
fixes request out far enough in advance of the merge window in which case
this will go in around then instead.

Also marked for stable

Jonathan

> Jonathan
> 
> > ---
> >  drivers/iio/industrialio-core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index c77745b594bd..e6d3d07a4c83 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1581,10 +1581,13 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
> >  	ret = iio_device_register_sysfs_group(indio_dev,
> >  					      &iio_dev_opaque->chan_attr_group);
> >  	if (ret)
> > -		goto error_clear_attrs;
> > +		goto error_free_chan_attrs;
> >  
> >  	return 0;
> >  
> > +error_free_chan_attrs:
> > +	kfree(iio_dev_opaque->chan_attr_group.attrs);
> > +	iio_dev_opaque->chan_attr_group.attrs = NULL;
> >  error_clear_attrs:
> >  	iio_free_chan_devattr_list(&iio_dev_opaque->channel_attr_list);
> >    
> 
> 


