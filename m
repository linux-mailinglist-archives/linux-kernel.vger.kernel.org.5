Return-Path: <linux-kernel+bounces-42839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F6184078F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3F11F2225E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B46657C7;
	Mon, 29 Jan 2024 13:55:47 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99E657AF;
	Mon, 29 Jan 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536546; cv=none; b=juE+fWcNutrywctvm2cEo7qIOeHQtDRZJ9Iko5XzILNqH8po+iH7ISNauydPPom4vh+gg/jcoy/vfWFMXPVu57ONM4Kj+K3RmTvSe7b9kR+aptyFf9+D/bhokVNn6jo3rJhp/XoTHRmtCCTDtqFPTA9mUqg57bLJTB8FgTSohbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536546; c=relaxed/simple;
	bh=Mu1POmJQZVm0NHymvBVIB8/NOZC6MGmOcANeEI54nU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/NUF8bLjUc4BgUsn/mnQl9g2lFQZZcUbZdTslrpSIsi8A3hmYXOZCxZx3idjMtoS29HfHUU2KwQk0rY+o6iI6rrKolX0S6Qlvi4KSSBwt1pDoMvxKx0oy+5oyLThGaSLabBcQjgrh4WBCqKIw2ZSvS/XP+d7kEmQITaaPq/hbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TNqZK2CD5z4f3jHm;
	Mon, 29 Jan 2024 21:55:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C99491A0232;
	Mon, 29 Jan 2024 21:55:39 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBFbrrdlZHhrCQ--.18903S3;
	Mon, 29 Jan 2024 21:55:39 +0800 (CST)
Message-ID: <c47a4ff6-43a0-a536-29ff-db2d1a931181@huaweicloud.com>
Date: Mon, 29 Jan 2024 21:55:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] md: get rdev->mddev with READ_ONCE()
To: song@kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, linan122@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, lilingfeng3@huawei.com
References: <20231229070500.3602712-1-lilingfeng@huaweicloud.com>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <20231229070500.3602712-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBFbrrdlZHhrCQ--.18903S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1Uuw43uF1xCF1xXr1rXrb_yoW8JFWrp3
	yrXFy5Wr1Yv3y5Cw4UZFWkua4Fqwn3KrZFkry3u34rZ3WjqwnxKF1UWa4DJFyrZanrur4x
	Xa17Xan8Z3sIgrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UGYL9UUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

Friendly ping ...

Thanks

在 2023/12/29 15:05, Li Lingfeng 写道:
> From: Li Lingfeng <lilingfeng3@huawei.com>
>
> Users may get rdev->mddev by sysfs while rdev is releasing.
> So use both READ_ONCE() and WRITE_ONCE() to prevent load/store tearing
> and to read/write mddev atomically.
>
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   drivers/md/md.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 9bdd57324c37..3b38a565bffa 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2562,7 +2562,7 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
>   	list_del_rcu(&rdev->same_set);
>   	pr_debug("md: unbind<%pg>\n", rdev->bdev);
>   	mddev_destroy_serial_pool(rdev->mddev, rdev);
> -	rdev->mddev = NULL;
> +	WRITE_ONCE(rdev->mddev, NULL);
>   	sysfs_remove_link(&rdev->kobj, "block");
>   	sysfs_put(rdev->sysfs_state);
>   	sysfs_put(rdev->sysfs_unack_badblocks);
> @@ -3646,7 +3646,7 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
>   	struct kernfs_node *kn = NULL;
>   	bool suspend = false;
>   	ssize_t rv;
> -	struct mddev *mddev = rdev->mddev;
> +	struct mddev *mddev = READ_ONCE(rdev->mddev);
>   
>   	if (!entry->store)
>   		return -EIO;


