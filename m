Return-Path: <linux-kernel+bounces-161313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5163D8B4A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C931F216C4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2051C3F;
	Sun, 28 Apr 2024 07:51:51 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011563209
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714290711; cv=none; b=uoUI8FFCzG7x6d7tu3zZxXkzDbbAtlZi+5W7dU927ug/JbBqSWOhvfoFByXHztX8X66On555Ag16qaOAXwkOvABAGYuzqn7VW5TbAixIP1i4wl4i9RHpycSXWDRpKcr6KPpOAcTVdw3cRdB1Z42kjpm/TJ/tYkA8U0M86UUjiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714290711; c=relaxed/simple;
	bh=SrBTxYzw3d3KAoGYMAdU6JfnCRLmrefQS2NelXl/BTg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y08fUD42dNja+92B3yPdwaQaIQsl4mdtcbGCTocQ3X8ATsMfu3GzIUPDLp8C7t+KosrgGRe0dV/2bdaUdfBDrHLnmMZCQHeHqI9ZDMg8sJjsGcvCzLXb2IOENLTuHB8cIB+IPzn8uqibpRi6iZ+XIfocosvKRRoHGI815/nB99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VRz8n6GnyzXn7f;
	Sun, 28 Apr 2024 15:48:09 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 344B718007D;
	Sun, 28 Apr 2024 15:51:45 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 15:51:44 +0800
Subject: Re: [PATCH] ubi: block: fix null-pointer-dereference in
 ubiblock_create()
To: <linan666@huaweicloud.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
	<vigneshr@ti.com>, <axboe@kernel.dk>, <chaitanya.kulkarni@wdc.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yukuai3@huawei.com>, <yi.zhang@huawei.com>, <houtao1@huawei.com>,
	<yangerkun@huawei.com>
References: <20240428071922.2270892-1-linan666@huaweicloud.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <98698009-e3a2-5c00-7619-6b6e3422cd1b@huawei.com>
Date: Sun, 28 Apr 2024 15:51:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240428071922.2270892-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/4/28 15:19, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> Similar to commit adbf4c4954e3 ("ubi: block: fix memleak in
> ubiblock_create()"), 'dev->gd' is not assigned but dereferenced if
> blk_mq_alloc_tag_set() fails, and leading to a null-pointer-dereference.
> 
> Using 'gd' directly here is not a good idea, too. 'gd->part0.bd_device'
> is not initialized at this point. The error log will be:
>    block (null): block: dynamic minor allocation failed
> 
> Fix it by using pr_err() and print ubi id.
> 
> Fixes: 77567b25ab9f ("ubi: use blk_mq_alloc_disk and blk_cleanup_disk")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/mtd/ubi/block.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index f82e3423acb9..bf7308e8ec2f 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -390,7 +390,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
>   
>   	ret = blk_mq_alloc_tag_set(&dev->tag_set);
>   	if (ret) {
> -		dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
> +		pr_err("ubiblock%d_%d: blk_mq_alloc_tag_set failed\n",
> +			dev->ubi_num, dev->vol_id);
>   		goto out_free_dev;
>   	}
>   
> @@ -407,8 +408,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
>   	gd->minors = 1;
>   	gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);

There is no need to modify this place. The device of 'gd' is initialized 
in blk_mq_alloc_disk. Refer to nbd_dev_add.
>   	if (gd->first_minor < 0) {
> -		dev_err(disk_to_dev(gd),
> -			"block: dynamic minor allocation failed");
> +		pr_err("ubiblock%d_%d: block: dynamic minor allocation failed\n",
> +			dev->ubi_num, dev->vol_id);
>   		ret = -ENODEV;
>   		goto out_cleanup_disk;
>   	}
> 


