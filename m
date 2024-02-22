Return-Path: <linux-kernel+bounces-76209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF82F85F432
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2D6B27461
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5B376ED;
	Thu, 22 Feb 2024 09:22:29 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805AB17BA5;
	Thu, 22 Feb 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593749; cv=none; b=r5yKCdthcY6ce2YhnjxeMaYZ2u7YKndYd/e/tBY1XncXsaUBiGWb3rP4lzygEUjZlJZxAV2eEOtSUutGjsKPEUfocWhj0tbBBiSABLBwTZN5+QhWQIpwnRHQk2jY/00qAS7dHUZkOAL6z2wiqmStNMH4nOxTVE4cpT/dvBi4Auc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593749; c=relaxed/simple;
	bh=jGKNly6F5h90kehyDssDVfUuSAoQ4RIiQ6MOk2EJz/A=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VSrFXnU5LAMUI0EISasoqC+faHzn4UdKvu5mOMooO7JRpaknNh9qcihPThungYIDLjZrgrG+UwWn8C/4qUVuemVQHMRdFwBP6Y8eKuZWvqiLNOGyfiBG8Bx8rGfDb5Rx7Vc+K9q5JE8d+rCj45cb/2/rDq6964gLPX+h4QB8xWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgSMv4bHdz4f3k5c;
	Thu, 22 Feb 2024 17:22:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D39141A0C2A;
	Thu, 22 Feb 2024 17:22:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxBNEtdlwV0nEw--.33761S3;
	Thu, 22 Feb 2024 17:22:22 +0800 (CST)
Subject: Re: [PATCH] block: add put_device() call when device_add() fails in
 device_add_disk()
To: Alfredo Cruz <alfredo.carlon@gmail.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240221220141.32316-1-alfredo.carlon@gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bf8659c5-8cfe-fd0e-3b59-c07cf1f48a87@huaweicloud.com>
Date: Thu, 22 Feb 2024 17:22:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240221220141.32316-1-alfredo.carlon@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxBNEtdlwV0nEw--.33761S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1fWF4kKF4UWw13Aw4DCFg_yoWDZrb_C3
	4j9F97uw1fAws3Ar909w1UAr10kwsFq3yfWFy0qFn3Xa43JF90v3s7JryrWr9rWay8Cr13
	Cw48Zr4xtr4SgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/02/22 6:01, Alfredo Cruz Ð´µÀ:
> When device_add() fails, put_device() should called for cleanup.
> Added this call before the jump to out_free_ext_minor to not
> interfere with device_del() on error paths where deivce_add() succeeded
> 
> Signed-off-by: Alfredo Cruz <alfredo.carlon@gmail.com>
> ---
>   block/genhd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index d74fb5b4ae68..5a231fb075bd 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -456,8 +456,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>   	if (!(disk->flags & GENHD_FL_HIDDEN))
>   		ddev->devt = MKDEV(disk->major, disk->first_minor);
>   	ret = device_add(ddev);
> -	if (ret)
> +	if (ret) {
> +		put_device(ddev);
>   		goto out_free_ext_minor;
> +	}

This is wrong, gendisk is allocated by caller, and caller is responsible
to free the gendisk, as you can see in many callers.

Thanks,
Kuai

>   
>   	ret = disk_alloc_events(disk);
>   	if (ret)
> 


