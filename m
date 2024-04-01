Return-Path: <linux-kernel+bounces-126393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AB98936B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F45F1C20B9D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A554138C;
	Mon,  1 Apr 2024 01:31:20 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26094623;
	Mon,  1 Apr 2024 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711935080; cv=none; b=rUWRozZ+amMMbGzS/576Bgtdx7RMWEsEyz2svPRI8q4VaUP3YkM7evqSXU0JUbXOTep3VpLIgGqAxiyqJRMb5r27K55h+mKlNj3lKBpGIAsLRdsnMyuJr9kZgpR8kNKkiGxOqvvkIfCwjYpS2SGjTwYstm3PAwBOr4tyvum4nJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711935080; c=relaxed/simple;
	bh=5GybeWNqzs6nv4wJq1pfFM+SRAKyKCyXUGqdzSUt76A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RCeJ/fVO3dyF9yvp/Mf+opE82yXHdwJRV+SJscAC03FbiptkX/BWIm0lL8aebmOmQTUkdALquULpZQ7HklN3V+kMd7Cv/R4pacI3ujEOF81mEwPr1Bw/FG3oEdjrgZarWT0PjSw1B7qYrc5k0QcpCLfeQSv6XwKhhl/oSIMLAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V7D423tjnz4f3nJQ;
	Mon,  1 Apr 2024 09:30:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D02031A0232;
	Mon,  1 Apr 2024 09:31:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ5YDgpmKjnDIg--.2486S3;
	Mon, 01 Apr 2024 09:31:06 +0800 (CST)
Subject: Re: [PATCH] scsi: sd: unregister device if device_add_disk() failed
 in sd_probe()
To: linan666@huaweicloud.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 mcgrof@kernel.org, hch@lst.de, bvanassche@acm.org,
 "yukuai (C)" <yukuai3@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20231208082335.1754205-1-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6066205b-bdc8-4434-cc2d-3ce06004ae47@huaweicloud.com>
Date: Mon, 1 Apr 2024 09:31:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231208082335.1754205-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ5YDgpmKjnDIg--.2486S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKryxKr45ArWUGF1kKFyfWFg_yoW8Jr48pa
	1kuasYkryUWr1DC3W7uFWUua48Ga4Iy3s5Wr4xJ34Ygas3Gr98K39agay5W3W8Jr47GFs8
	JF17GryrX3W8tw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

+CC Christoph Hellwig
+CC Bart Van Assche
ÔÚ 2023/12/08 16:23, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> "if device_add() succeeds, you should call device_del() when you want to
> get rid of it."
> 
> In sd_probe(), device_add_disk() fails when device_add() has already
> succeeded, so change put_device() to device_unregister() to ensure device
> resources are released.

I was shocked that this patch is still there. This patch is easy and
straightforward.

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

BTW, Nan, it will be better if you have a reporducer for this.
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
> 


