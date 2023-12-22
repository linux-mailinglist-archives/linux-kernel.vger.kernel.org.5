Return-Path: <linux-kernel+bounces-9422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCCA81C544
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC14E2856EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA458F6A;
	Fri, 22 Dec 2023 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bAvN7k5z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDFD8C00;
	Fri, 22 Dec 2023 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lylqq7ftixmgzmGz5mqZoPbKSpJD7b/C154szLGN3Cg=; b=bAvN7k5zDaRqUU3TXNGvo2oprA
	3F3Z3EYrftvBWm9hUR1uK+3xL6tYR9T8crprYsp/P5rHwsfDjMH1oIxBkBN5OrOAUBtJoEje6AqMj
	r9VDkHnr6hY3XaV3+ZKYoEde1r+k6JqdX/t+exjHGZPAz7ocN7LAq/kpsvGke6SEqFefXWHYySAYx
	c9zjCUsh8xAhzCdFY2GhiK8K09fIt2YBV1M0O7JtUi4aWaes8KryqKAp13G2zS+Q41RB3nR71Is/E
	rWGZMqyvVrAWbWljCWaGTBD+iPKm2OEWIGzdH+vA7EsUWAqewuKfpCIY4i8JzCCy0QoyKyJ7n/7Zo
	YZAqLAmw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGZLJ-0056er-0C;
	Fri, 22 Dec 2023 06:49:09 +0000
Date: Thu, 21 Dec 2023 22:49:09 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: linan666@huaweicloud.com
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] scsi: sd: unregister device if device_add_disk() failed
 in sd_probe()
Message-ID: <ZYUxZc/my2v6UfFJ@bombadil.infradead.org>
References: <20231208082335.1754205-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208082335.1754205-1-linan666@huaweicloud.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Dec 08, 2023 at 04:23:35PM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> "if device_add() succeeds, you should call device_del() when you want to
> get rid of it."
> 
> In sd_probe(), device_add_disk() fails when device_add() has already
> succeeded, so change put_device() to device_unregister() to ensure device
> resources are released.
> 
> Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
> Signed-off-by: Li Nan <linan122@huawei.com>

Nacked-by: Luis Chamberlain <mcgrof@kernel.org>

> ---
>  drivers/scsi/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 542a4bbb21bc..d81cbeee06eb 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3736,7 +3736,7 @@ static int sd_probe(struct device *dev)
>  
>  	error = device_add_disk(dev, gd, NULL);
>  	if (error) {
> -		put_device(&sdkp->disk_dev);
> +		device_unregister(&sdkp->disk_dev);
>  		put_disk(gd);
>  		goto out;
>  	}

This is incorrect, device_unregister() calls:

void device_unregister(struct device *dev)                                      
{                                                                               
	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);                
	device_del(dev);                                                        
	put_device(dev);                                                        
}   

So you're adding what you believe to be a correct missing device_del().
But what you missed is that if device_add_disk() fails then device_add()
did not succeed because the new code we have in the kernel *today* unwinds
this for us now.

What you missed is that in today's code inside device_add_disk(), if
device_add() succeeeds we now unwind and call device_del() for the
device for you. And so, quoting the next sentence you took from
device_add():

"If device_add() has *not* succeeded, use *only* put_device() to drop the
 reference count."

Please do reference in the future a crash dump / or explain how you
reached your conclusions if you do not have a crash dump to prove an
issue. Specially if you are suggesting it Fixes a commit.

  Luis

