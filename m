Return-Path: <linux-kernel+bounces-141228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF5B8A1B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E506FB2AB75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077331863B;
	Thu, 11 Apr 2024 15:48:31 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92A182BD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850510; cv=none; b=gfvS6eT+fhzfnEL7bE/OwewhykpMYRUoN+2Duj1DN3bFGGPyYIbo97GAawd/kB2kad+4qYX9NV7TscFzr5iCinHbyEN4m+l58WSzRpEumuMrWUApPLpO8l+NPYr4lBzJz76ql+WGTdHsBogSaURXaljroyngeQ4wzaKeVso5WhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850510; c=relaxed/simple;
	bh=gxmEWGIJE5OWqT4IoVnr60s9cNY+kcDdy9T3WnwihIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPYTbYiU+tXEC7nFswT2ECVK/NZYsygYJ0fd9BXDWr7mDPQ9pAltmmhLb1O96D7lROWpxQZgNKLtcsANu8cphTP6LUX9yMiwBG3Vbv2xtLwoVU9WEZJnWkHe+qEq4R6d3VMvIRoo/9zZGcUj7UalpUb8DcFjBlxcFV2mTVLFOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ruwes-0006Iz-2b;
	Thu, 11 Apr 2024 15:48:14 +0000
Date: Thu, 11 Apr 2024 16:48:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: richard@nod.at, miquel.raynal@bootlin.com, ben.hutchings@mind.be,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ubi: ubi_init: Fix missed ubiblock cleanup in
 error handling path
Message-ID: <ZhgGPE_5urw2izAA@makrotopia.org>
References: <20240411031903.3050278-1-chengzhihao1@huawei.com>
 <20240411031903.3050278-3-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411031903.3050278-3-chengzhihao1@huawei.com>

On Thu, Apr 11, 2024 at 11:19:01AM +0800, Zhihao Cheng wrote:
> The ubiblock_init called by ubi_init will register device number, but
> device number is not released in error handling path of ubi_init when
> ubi is loaded by inserting module (eg. attaching failure), which leads
> to subsequent ubi_init calls failed by running out of device number
> (dmesg shows that "__register_blkdev: failed to get major for ubiblock").
> Since ubiblock_init() registers notifier and invokes notification
> functions, so we can move it after ubi_init_attach() to fix the problem.
> 
> Fixes: 927c145208b0 ("mtd: ubi: attach from device tree")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/mtd/ubi/build.c | 51 +++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 7f95fd7968a8..bc63fbf5e947 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -1263,9 +1263,21 @@ static struct mtd_notifier ubi_mtd_notifier = {
>  	.remove = ubi_notify_remove,
>  };
>  
> +static void detach_mtd_devs(int count)

Missing __init to avoid section missmatch.

See also: https://lore.kernel.org/oe-kbuild-all/202404112327.158HJfAw-lkp@intel.com/

> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++)
> +		if (ubi_devices[i]) {
> +			mutex_lock(&ubi_devices_mutex);
> +			ubi_detach_mtd_dev(ubi_devices[i]->ubi_num, 1);
> +			mutex_unlock(&ubi_devices_mutex);
> +		}
> +}
> +
>  static int __init ubi_init_attach(void)
>  {
> -	int err, i, k;
> +	int err, i;
>  
>  	/* Attach MTD devices */
>  	for (i = 0; i < mtd_devs; i++) {
> @@ -1317,12 +1329,7 @@ static int __init ubi_init_attach(void)
>  	return 0;
>  
>  out_detach:
> -	for (k = 0; k < i; k++)
> -		if (ubi_devices[k]) {
> -			mutex_lock(&ubi_devices_mutex);
> -			ubi_detach_mtd_dev(ubi_devices[k]->ubi_num, 1);
> -			mutex_unlock(&ubi_devices_mutex);
> -		}
> +	detach_mtd_devs(i);
>  	return err;
>  }
>  #ifndef CONFIG_MTD_UBI_MODULE
> @@ -1366,15 +1373,6 @@ static int __init ubi_init(void)
>  	if (err)
>  		goto out_slab;
>  
> -	err = ubiblock_init();
> -	if (err) {
> -		pr_err("UBI error: block: cannot initialize, error %d\n", err);
> -
> -		/* See comment above re-ubi_is_module(). */
> -		if (ubi_is_module())
> -			goto out_debugfs;
> -	}
> -
>  	register_mtd_user(&ubi_mtd_notifier);
>  
>  	if (ubi_is_module()) {
> @@ -1383,11 +1381,21 @@ static int __init ubi_init(void)
>  			goto out_mtd_notifier;
>  	}
>  
> +	err = ubiblock_init();
> +	if (err) {
> +		pr_err("UBI error: block: cannot initialize, error %d\n", err);
> +
> +		/* See comment above re-ubi_is_module(). */
> +		if (ubi_is_module())
> +			goto out_detach;
> +	}
> +
>  	return 0;
>  
> +out_detach:
> +	detach_mtd_devs(mtd_devs);
>  out_mtd_notifier:
>  	unregister_mtd_user(&ubi_mtd_notifier);
> -out_debugfs:
>  	ubi_debugfs_exit();
>  out_slab:
>  	kmem_cache_destroy(ubi_wl_entry_slab);
> @@ -1403,17 +1411,10 @@ device_initcall(ubi_init);
>  
>  static void __exit ubi_exit(void)
>  {
> -	int i;
> -
>  	ubiblock_exit();
>  	unregister_mtd_user(&ubi_mtd_notifier);
>  
> -	for (i = 0; i < UBI_MAX_DEVICES; i++)
> -		if (ubi_devices[i]) {
> -			mutex_lock(&ubi_devices_mutex);
> -			ubi_detach_mtd_dev(ubi_devices[i]->ubi_num, 1);
> -			mutex_unlock(&ubi_devices_mutex);
> -		}
> +	detach_mtd_devs(UBI_MAX_DEVICES);
>  	ubi_debugfs_exit();
>  	kmem_cache_destroy(ubi_wl_entry_slab);
>  	misc_deregister(&ubi_ctrl_cdev);
> -- 
> 2.39.2
> 

