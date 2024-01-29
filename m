Return-Path: <linux-kernel+bounces-42821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0935784074B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BED81C22958
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5219657AC;
	Mon, 29 Jan 2024 13:44:40 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D4657A0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535880; cv=none; b=mD0VzJ70fxWrsDtAgp8M+6YrSyE74HRzRKHg4wqdH3GrwxeaLkcIH2RJ5HFQVYi0XjZrOjVULxtCB2b/+7/9oulpJ+6Po2F2E89jxyDqI9FCgsMLwbUeYcz5vvr2wvi1h/SjfQrki8yqEdfNRFGxQGPjkncvt26nk2E9TwK3u8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535880; c=relaxed/simple;
	bh=9RHzmXyp95smTH596j3zPZcF6C09siyI6U3XzckAzkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4ryMv1SKUZV7Nej31TxQuOQf8L7HGHZL1fWygQkBkzYPDS2pX3U+dUBlh0htxa/+89cMPN4NzwJNSYn+TnD9O2IJWjYR+AErBAyYyJd1aTTk5LqeJSF1XiGfaBy2MLtFRF2suUIfioWhSAvzEuKSayGgomsvN8Pu1qs/E1kfDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TNpyN2J57z4f3jHs
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:27:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 67FB01A0232
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:28:00 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgDH6w7fp7dl3CmSCQ--.20232S3;
	Mon, 29 Jan 2024 21:28:00 +0800 (CST)
Message-ID: <eac2fbfe-5565-96ad-68cb-11efa8af2ec8@huaweicloud.com>
Date: Mon, 29 Jan 2024 21:27:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ubi: block: fix memleak in ubiblock_create()
To: linan666@huaweicloud.com, richard@nod.at, miquel.raynal@bootlin.com,
 vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20231208074629.1656356-1-linan666@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20231208074629.1656356-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDH6w7fp7dl3CmSCQ--.20232S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKry7KrWrWFyDAr43CFWUtwb_yoWkGrcE9w
	4aqr93XrWIkwn2k34jyry3ua1Ykr4UKrWkuF1ftws8XFW7XFn7AF93Kr15Ww4DAF429a4r
	A3W8Wr12yr40qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAkucUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

friendly ping ...

在 2023/12/8 15:46, linan666@huaweicloud.com 写道:
> From: Li Nan <linan122@huawei.com>
> 
> If idr_alloc() fails, dev->gd will be put after goto out_cleanup_disk in
> ubiblock_create(), but dev->gd has not been assigned yet at this time, and
> 'gd' will not be put anymore. Fix it by putting 'gd' directly.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
> Changes in v2:
>   - modify the description of the problem in log
> 
>   drivers/mtd/ubi/block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index 309a42aeaa4c..654bd7372cd8 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -434,7 +434,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
>   	list_del(&dev->list);
>   	idr_remove(&ubiblock_minor_idr, gd->first_minor);
>   out_cleanup_disk:
> -	put_disk(dev->gd);
> +	put_disk(gd);
>   out_free_tags:
>   	blk_mq_free_tag_set(&dev->tag_set);
>   out_free_dev:

-- 
Thanks,
Nan


