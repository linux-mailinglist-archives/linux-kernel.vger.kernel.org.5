Return-Path: <linux-kernel+bounces-70974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E85859EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D00E1F21A96
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5C22323;
	Mon, 19 Feb 2024 08:53:46 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE322063;
	Mon, 19 Feb 2024 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332825; cv=none; b=oL1UmiwQVt5Y1T0zLb6Id3B9XCLVrPYJAENGenHlxErVv2V02Wr/7/AgDEzEK+Eb5VnMOw4YBgwRO8bkQ65bKYlQULjdTc+JQUNZiThj/JfrqjiWAiEZLsnE7HNuj9c6rimtIbcLXfSJfFG9lNh3yZQIYHZWzsRCS2v6pKcJHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332825; c=relaxed/simple;
	bh=8HkkR6iJ4IHWS6OvdN4vAUbuMZcIA4Hfk4172V+EblI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z/4Inx72Qnjum6uO6QxfOPP8HFJEiifxW32AS0qfmd2fG3mGYixvC9zT9S1InBKjNviRtge3YVTF09435HB3hiJ0YEKR1uzb9P0tSQrVMqfQ+iG1GP3LXiKMlcfWzh5Di04wjRu3bRvVb0CKS/z3vhxj39emBQcdWtR4ZWV0mUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tdbt301VXz4f3tPG;
	Mon, 19 Feb 2024 16:53:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0F0EA1A016E;
	Mon, 19 Feb 2024 16:53:38 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAQF9NlTC7vEQ--.53103S3;
	Mon, 19 Feb 2024 16:53:37 +0800 (CST)
Subject: Re: [PATCH] block: fix deadlock between bd_link_disk_holder and
 partition scan
To: linan666@huaweicloud.com, axboe@kernel.dk, Christoph Hellwig
 <hch@lst.de>, "yukuai (C)" <yukuai3@huawei.com>
Cc: linux-raid@vger.kernel.org, song@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20240207092756.2087888-1-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d7456326-ebb1-fc4a-9071-bf7083191211@huaweicloud.com>
Date: Mon, 19 Feb 2024 16:53:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240207092756.2087888-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAQF9NlTC7vEQ--.53103S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4rCr1xtw4xtFW5XFW3Awb_yoWrXFyDpF
	Z8KFWrtryUtF4Dur4Utw47uF45Kw40ga1xGr97Kry29r9rArs29r17tFy7uFy8trWIyF4D
	tF1UX3yYyF10y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Christoph

ÔÚ 2024/02/07 17:27, linan666@huaweicloud.com Ð´µÀ:
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
> Fix it by introducing a local mutex 'holder_mutex' to replace 'open_mutex'.

Can you take a look at this patch? I think for raid(perhaps and dm and
other drivers), it's reasonable to suspend IO while hot adding new
underlying disks. And I think add new slaves to holder is not related to
open the holder disk, because caller should already open the holder disk
to hot add slaves, hence 'open_mutex' for holder is not necessary here.

Actually bd_link_disk_holder() is protected by 'reconfig_mutex' for
raid, and 'table_devices_lock' for dm(I'm not sure yet if other drivers
have similiar lock).

For raid, we do can fix this problem in raid by delay
bd_link_disk_holder() while the array is not suspended, however, we'll
consider this fix later if you think this patch is not acceptable.

Thanks,
Kuai

> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   block/holder.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/holder.c b/block/holder.c
> index 37d18c13d958..5bfb0a674cc7 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -8,6 +8,8 @@ struct bd_holder_disk {
>   	int			refcnt;
>   };
>   
> +static DEFINE_MUTEX(holder_mutex);
> +
>   static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
>   						  struct gendisk *disk)
>   {
> @@ -80,7 +82,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	kobject_get(bdev->bd_holder_dir);
>   	mutex_unlock(&bdev->bd_disk->open_mutex);
>   
> -	mutex_lock(&disk->open_mutex);
> +	mutex_lock(&holder_mutex);
>   	WARN_ON_ONCE(!bdev->bd_holder);
>   
>   	holder = bd_find_holder_disk(bdev, disk);
> @@ -108,7 +110,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   		goto out_del_symlink;
>   	list_add(&holder->list, &disk->slave_bdevs);
>   
> -	mutex_unlock(&disk->open_mutex);
> +	mutex_unlock(&holder_mutex);
>   	return 0;
>   
>   out_del_symlink:
> @@ -116,7 +118,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   out_free_holder:
>   	kfree(holder);
>   out_unlock:
> -	mutex_unlock(&disk->open_mutex);
> +	mutex_unlock(&holder_mutex);
>   	if (ret)
>   		kobject_put(bdev->bd_holder_dir);
>   	return ret;
> @@ -140,7 +142,7 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	if (WARN_ON_ONCE(!disk->slave_dir))
>   		return;
>   
> -	mutex_lock(&disk->open_mutex);
> +	mutex_lock(&holder_mutex);
>   	holder = bd_find_holder_disk(bdev, disk);
>   	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
>   		del_symlink(disk->slave_dir, bdev_kobj(bdev));
> @@ -149,6 +151,6 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   		list_del_init(&holder->list);
>   		kfree(holder);
>   	}
> -	mutex_unlock(&disk->open_mutex);
> +	mutex_unlock(&holder_mutex);
>   }
>   EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
> 


