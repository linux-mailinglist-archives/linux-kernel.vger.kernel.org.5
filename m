Return-Path: <linux-kernel+bounces-149771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D28A959E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308221F225F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFBD15A4B8;
	Thu, 18 Apr 2024 09:08:06 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623C0136991
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431285; cv=none; b=PLXyLMdJTKGHO+TkFeIeCx7EfLD/iSgTcXLe83SpgorxMQc5eagvolE2DECoXxBgSqq8Lhnx8T23F7suvEQATW0AYYThvEftU2PGYdVE+GwalgvkFaUpDqnWnwDSdvf6uqZ5UepleeXAFALubawmG65BXuPuWhzHlGljhN8Ddec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431285; c=relaxed/simple;
	bh=GkOI1exuQQfDFEVfrCXf/l0c9+WgsCIFXlSCqwzTLJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1WLLmjXff/ZMopuu55oZjRvNQq3zDp131wtSU/Y3wUigY+OkJTKbyE5xdjCwaupjlW979hsSiU0BjpMq2qXdIZg/WfRvq52kkB37WlbJwg2zJXw9J6T7Hb1/xoLV1/ZoCnEge0Nd8CdVheScTW4FN6mNFX1OmmgApTAvjRNNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VKsPM5ZPyz4f3l8C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:07:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7201C1A0DF7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:07:56 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgC32w7q4iBmfXcbKg--.44051S3;
	Thu, 18 Apr 2024 17:07:56 +0800 (CST)
Message-ID: <6d826865-b296-627c-3f83-e0a18263de7a@huaweicloud.com>
Date: Thu, 18 Apr 2024 17:07:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ubi: block: fix memleak in ubiblock_create()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
 houtao1@huawei.com, yangerkun@huawei.com
References: <20231208074629.1656356-1-linan666@huaweicloud.com>
 <79703e8b-ce3a-4407-9750-05f9202039d4@moroto.mountain>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <79703e8b-ce3a-4407-9750-05f9202039d4@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC32w7q4iBmfXcbKg--.44051S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW7Gw47JFy3CryrtFWxtFb_yoWxAFbE9a
	n0vr95ZrWxAr9FywsrG3sYkwn8Jrn8t3y8ZrZ7JrZxur18ZFykGFZxX3s0ya15Za13uan0
	k345Kr4Igw1FgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
	5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
	AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3
	Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU1VOJ7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

Hi, dan,

在 2024/4/15 14:33, Dan Carpenter 写道:
> On Fri, Dec 08, 2023 at 03:46:29PM +0800, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
>>
>> If idr_alloc() fails, dev->gd will be put after goto out_cleanup_disk in
>> ubiblock_create(), but dev->gd has not been assigned yet at this time, and
>> 'gd' will not be put anymore. Fix it by putting 'gd' directly.
>>
> 
> There is another invalid reference to dev->gd if blk_mq_alloc_tag_set()
> fails.
> 
> 	dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
>                              ^^^^^^^
> 

You are really very careful! I will fix it later.

> regards,
> dan carpenter

-- 
Thanks,
Nan


