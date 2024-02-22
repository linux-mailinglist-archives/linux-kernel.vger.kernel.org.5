Return-Path: <linux-kernel+bounces-76219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBCC85F452
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3791C211F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7142381B4;
	Thu, 22 Feb 2024 09:26:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C163717C;
	Thu, 22 Feb 2024 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594003; cv=none; b=qVUyxXEGv8sx7kRliB/GlEKkWIU/NCmhNRYGc5dETY+rEssPkpamheDtEcw9G3p/ax4+GxchIoU7negdYej3fwj+xvlJirxPwK5tUN7GBDV6UP3h+MSI4McsH46HceC7R0Jy0ovtOdha1UZeZCeOrRQ74iY4NIWaSY1C2i80JQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594003; c=relaxed/simple;
	bh=kGPhBtLA7fOjhIpyW24MDCbxh7JdZBMP1iVR46NnC44=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FvriNrNcPEcppNvE1F7Ec3XWOe5z0jUTc7DWlQVQRzb/fYH8dy4N5f51NrweGFaPaR61cAK0NPaIGZvOI/eYKid+alYCHL6sFg3Fkxc8fO7UT8He0P0sntj85Mqg64N2HLYq54XUfmXsA9aq5Zyul6cZ9Fry/VHtzI+Swo2dKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TgSQx32sQzWv29;
	Thu, 22 Feb 2024 17:24:57 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 39356140153;
	Thu, 22 Feb 2024 17:26:38 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 17:26:37 +0800
Subject: Re: [PATCH v2] block: fix deadlock between bd_link_disk_holder and
 partition scan
To: <linan666@huaweicloud.com>, <axboe@kernel.dk>, <song@kernel.org>,
	Christoph Hellwig <hch@lst.de>
CC: <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>, <houtao1@huawei.com>,
	<yangerkun@huawei.com>
References: <20240221090122.1281868-1-linan666@huaweicloud.com>
From: Yu Kuai <yukuai3@huawei.com>
Message-ID: <9b4c511b-5ab1-7ba2-8ccc-5538c4672eb4@huawei.com>
Date: Thu, 22 Feb 2024 17:26:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240221090122.1281868-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)

+CC Christoph

ÔÚ 2024/02/21 17:01, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> 'open_mutex' of gendisk is used to protect open/close block devices. But
> in bd_link_disk_holder(), it is used to protect the creation of symlink
> between holding disk and slave bdev, which introduces some issues.
> 
> When bd_link_disk_holder() is called, the driver is usually in the process
> of initialization/modification and may suspend submitting io. At this
> time, any io hold 'open_mutex', such as scanning partitions, can cause
> deadlocks. For example, in raid:
> 
> T1                              T2
> bdev_open_by_dev
>   lock open_mutex [1]
>   ...
>    efi_partition
>    ...
>     md_submit_bio
> 				md_ioctl mddev_syspend
> 				  -> suspend all io
> 				 md_add_new_disk
> 				  bind_rdev_to_array
> 				   bd_link_disk_holder
> 				    try lock open_mutex [2]
>      md_handle_request
>       -> wait mddev_resume
> 
> T1 scan partition, T2 add a new device to raid. T1 waits for T2 to resume
> mddev, but T2 waits for open_mutex held by T1. Deadlock occurs.
> 
> Fix it by introducing a local mutex 'blk_holder_mutex' to replace
> 'open_mutex'.
> 
> Fixes: 1b0a2d950ee2 ("md: use new apis to suspend array for ioctls involed array reconfiguration")
> Reported-by: mgperkow@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218459
> Signed-off-by: Li Nan <linan122@huawei.com>

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> ---
> v2: add a blk_ prefix to 'holder_mutex'.
> 
>   block/holder.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/holder.c b/block/holder.c
> index 37d18c13d958..791091a7eac2 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -8,6 +8,8 @@ struct bd_holder_disk {
>   	int			refcnt;
>   };
>   
> +static DEFINE_MUTEX(blk_holder_mutex);
> +
>   static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
>   						  struct gendisk *disk)
>   {
> @@ -80,7 +82,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	kobject_get(bdev->bd_holder_dir);
>   	mutex_unlock(&bdev->bd_disk->open_mutex);
>   
> -	mutex_lock(&disk->open_mutex);
> +	mutex_lock(&blk_holder_mutex);
>   	WARN_ON_ONCE(!bdev->bd_holder);
>   
>   	holder = bd_find_holder_disk(bdev, disk);
> @@ -108,7 +110,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   		goto out_del_symlink;
>   	list_add(&holder->list, &disk->slave_bdevs);
>   
> -	mutex_unlock(&disk->open_mutex);
> +	mutex_unlock(&blk_holder_mutex);
>   	return 0;
>   
>   out_del_symlink:
> @@ -116,7 +118,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   out_free_holder:
>   	kfree(holder);
>   out_unlock:
> -	mutex_unlock(&disk->open_mutex);
> +	mutex_unlock(&blk_holder_mutex);
>   	if (ret)
>   		kobject_put(bdev->bd_holder_dir);
>   	return ret;
> @@ -140,7 +142,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	if (WARN_ON_ONCE(!disk->slave_dir))
>   		return;
>   
> -	mutex_lock(&disk->open_mutex);
> +	mutex_lock(&blk_holder_mutex);
>   	holder = bd_find_holder_disk(bdev, disk);
>   	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
>   		del_symlink(disk->slave_dir, bdev_kobj(bdev));
> @@ -149,6 +151,6 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   		list_del_init(&holder->list);
>   		kfree(holder);
>   	}
> -	mutex_unlock(&disk->open_mutex);
> +	mutex_unlock(&blk_holder_mutex);
>   }
>   EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
> 

