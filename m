Return-Path: <linux-kernel+bounces-76213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3421685F443
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4F71F258DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7005376ED;
	Thu, 22 Feb 2024 09:24:26 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8DB2BB09;
	Thu, 22 Feb 2024 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593866; cv=none; b=ju686H+q/UbCzK0O4IVvgY61PfNbzbZVHJZJoSWeOeZpyPBUUFDhQz7oDamGXO23S7t76pQmOiVPuhkr5gE346iawZrxdsVGTWux5mKPGLG2rwtZ0If7CFkivxq+m9OOl8znx1RrFzIBKHLX7GA2N2AW48JAh//aHYa1SFjTEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593866; c=relaxed/simple;
	bh=Yqq/aNPUZed2Oe5vM66rRJzixSD3hRXsrZvbY3LmYxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJGLBe83tcEoCP8yRzlO5w1MKOpk+sEMQIyOjFuBYZ69U1l67f470cREG6GMOxnLcpd7rbd++AyW/7a8tX+///fE+Q8vmpuFYggr8OhnMd+/Gkwn4zWuJUDYJ4nXYqLc1hqEMzM+4qYiEJPK9/GcUnwWWpvGJYOH+dAE9JTKEBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgSQ95XpMz4f3kpQ;
	Thu, 22 Feb 2024 17:24:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F39D21A0172;
	Thu, 22 Feb 2024 17:24:20 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgAXOQzBEtdlquR_Ew--.59051S3;
	Thu, 22 Feb 2024 17:24:20 +0800 (CST)
Message-ID: <772d4058-aef0-0b06-068c-f33636fac01e@huaweicloud.com>
Date: Thu, 22 Feb 2024 17:24:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] scsi: sd: unregister device if device_add_disk() failed
 in sd_probe()
To: linan666@huaweicloud.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 mcgrof@kernel.org, mcgrof@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20231208082335.1754205-1-linan666@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20231208082335.1754205-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXOQzBEtdlquR_Ew--.59051S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKryxKr45ArWUGF1kKFyfWFg_yoWDWwb_Cw
	42v397Xr1rCw1Iyr1fAr1avrW0vFsFq3yrCF4jqr9avayfX3yv9F9Y9ryYvr4UGF4xuw1j
	yr1UXr4Fkr4kGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

friendly ping...

在 2023/12/8 16:23, linan666@huaweicloud.com 写道:
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
> ---
>   drivers/scsi/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 542a4bbb21bc..d81cbeee06eb 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3736,7 +3736,7 @@ static int sd_probe(struct device *dev)
>   
>   	error = device_add_disk(dev, gd, NULL);
>   	if (error) {
> -		put_device(&sdkp->disk_dev);
> +		device_unregister(&sdkp->disk_dev);
>   		put_disk(gd);
>   		goto out;
>   	}

-- 
Thanks,
Nan


