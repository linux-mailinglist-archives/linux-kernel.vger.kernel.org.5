Return-Path: <linux-kernel+bounces-49055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32679846559
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EEB28BB15
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110F63AA;
	Fri,  2 Feb 2024 01:17:20 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C5BE55;
	Fri,  2 Feb 2024 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836640; cv=none; b=UROvdFZWb/rfbdA3mV47wM3YSvL3mZTpCgrm5FH5dU2SRFUEI83Up3a5TcekxCgBlsheC3ZDAXcTbUWBSlZQw+g81qJpDucjCucRTROwoj4NWhv4U7NrBftgPvJ2Vd3J3cFcdWdkPKGwhSE7rJFp2BxswMwue5Eoi59XWofrG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836640; c=relaxed/simple;
	bh=qI20fyk9DQCmtxvlkNkYw3r/jcLTcN+mdMrbRQb7HxU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MnBrsui0wwn6LcpMMQeCiJ0xPoqWMDGTRWLQj2zy9vUlNMOrpRpFOxkc524hXuJx82L346l9Pj/AE+ATAOMCBXJ+uHnOBmCTO+UKz2QoHXjs2fR/OWiMMBz1Ui16jVOz1ks/tlUv7a7GMmseYxCdYXR4JOAUvWuNH56ZqViDlQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQyYL3rRFz4f3jsY;
	Fri,  2 Feb 2024 09:17:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BF08F1A027B;
	Fri,  2 Feb 2024 09:17:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g6ZQrxlgtfNCg--.12072S3;
	Fri, 02 Feb 2024 09:17:14 +0800 (CST)
Subject: Re: [PATCH v5 1/8] md: merge the check of capabilities into
 md_ioctl_valid()
To: linan666@huaweicloud.com, song@kernel.org, neilb@suse.com,
 mariusz.tkaczyk@linux.intel.com, shli@fb.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201063404.772797-1-linan666@huaweicloud.com>
 <20240201063404.772797-2-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1421044e-aeb2-86b2-40f1-af4ff6d2b415@huaweicloud.com>
Date: Fri, 2 Feb 2024 09:17:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201063404.772797-2-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g6ZQrxlgtfNCg--.12072S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13WrWrWFWUAFW8tF48Crg_yoW8CFyUpF
	43GFW3A3y3Jry7Gr13J3ykCa45Zwn2qrWfJrya9a4kXF1UC398WryrKw4Fvasayr929F4x
	W3WUCF48uw48trUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/02/01 14:33, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> There is no functional change. Just to make code cleaner.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> ---
>   drivers/md/md.c | 30 ++++++++++++------------------
>   1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index e351e6c51cc7..1b509fb82040 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7545,16 +7545,17 @@ static int md_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>   	return 0;
>   }
>   
> -static inline bool md_ioctl_valid(unsigned int cmd)
> +static inline int md_ioctl_valid(unsigned int cmd)
>   {
>   	switch (cmd) {
> -	case ADD_NEW_DISK:
>   	case GET_ARRAY_INFO:
> -	case GET_BITMAP_FILE:
>   	case GET_DISK_INFO:
> +	case RAID_VERSION:
> +		return 0;
> +	case ADD_NEW_DISK:
> +	case GET_BITMAP_FILE:
>   	case HOT_ADD_DISK:
>   	case HOT_REMOVE_DISK:
> -	case RAID_VERSION:
>   	case RESTART_ARRAY_RW:
>   	case RUN_ARRAY:
>   	case SET_ARRAY_INFO:
> @@ -7563,9 +7564,11 @@ static inline bool md_ioctl_valid(unsigned int cmd)
>   	case STOP_ARRAY:
>   	case STOP_ARRAY_RO:
>   	case CLUSTERED_DISK_NACK:
> -		return true;
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EACCES;
> +		return 0;
>   	default:
> -		return false;
> +		return -ENOTTY;
>   	}
>   }
>   
> @@ -7625,18 +7628,9 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
>   	struct mddev *mddev = NULL;
>   	bool did_set_md_closing = false;
>   
> -	if (!md_ioctl_valid(cmd))
> -		return -ENOTTY;
> -
> -	switch (cmd) {
> -	case RAID_VERSION:
> -	case GET_ARRAY_INFO:
> -	case GET_DISK_INFO:
> -		break;
> -	default:
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EACCES;
> -	}
> +	err = md_ioctl_valid(cmd);
> +	if (err)
> +		return err;
>   
>   	/*
>   	 * Commands dealing with the RAID driver but not any
> 


