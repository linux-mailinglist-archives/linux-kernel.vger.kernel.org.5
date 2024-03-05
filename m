Return-Path: <linux-kernel+bounces-91736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F58715D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858C91F22055
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DD7C0B7;
	Tue,  5 Mar 2024 06:24:13 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9ED29437;
	Tue,  5 Mar 2024 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619853; cv=none; b=kvRtC2E8c0e8eW7hiwwyNtN/1uXwtstLGYUouJlFG/BTjvub5GOX+IwV6epJ++8ovxSONTT5+1vV5everC7/PKQP2eKlQs6RDL83nUTopMkb6GQJkcWr6L+g60yE+148gubgvK7XZFc2HbIfEdyxlvW+C8Rr15JL5EGsb2y4OMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619853; c=relaxed/simple;
	bh=7OQCuem/dH7I3j9E2bsrCLNZCmifdKDYrJY26mnm6rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1q+v7fSVd32OB68Jw2/5gl+vbNC8CeGmFUgrDLbeP13P6tU2QDwz+jiTdCEcuBF6soJ0ATLJTSZCuDmxNHlzvlp02SCA+dHsza69EtmkWWOYXvUKHeA56qerxWc9xi1Sv3qTZPH9tgxjCJObHGgClzVAPEuphRRTkFOOncNLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tplrg1G6Pz4f3k68;
	Tue,  5 Mar 2024 14:24:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A57BF1A0568;
	Tue,  5 Mar 2024 14:24:06 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGEuuZlVtP5Fw--.21762S3;
	Tue, 05 Mar 2024 14:24:06 +0800 (CST)
Message-ID: <2ae82ded-4d8a-cc0d-65b0-9468eaede73c@huaweicloud.com>
Date: Tue, 5 Mar 2024 14:24:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] block: move capacity validation to blkpg_do_ioctl()
To: Damien Le Moal <dlemoal@kernel.org>, axboe@kernel.dk, min15.li@samsung.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 yangerkun@huawei.com, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com
References: <20240305032132.548958-1-lilingfeng@huaweicloud.com>
 <474e78e7-9056-4b74-9ce2-592b8ee9411c@kernel.org>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <474e78e7-9056-4b74-9ce2-592b8ee9411c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBGEuuZlVtP5Fw--.21762S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45ZFyrGFW7Kr17Kw1DGFg_yoW5Wr4Up3
	yUJFW3Aw4rKF17uw12qan3Aw1Fgwnrtr4xAw4kG3WFy3srAws3KFyYkw4Yva40vr93KFWI
	vF4jvF929F17CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2024/3/5 12:30, Damien Le Moal 写道:
> On 3/5/24 12:21, Li Lingfeng wrote:
>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> Commit 6d4e80db4ebe ("block: add capacity validation in
>> bdev_add_partition()") add check of partition's start and end sectors to
>> prevent exceeding the size of the disk when adding partitions. However,
>> there is still no check for resizing partitions now.
>> Move the check to blkpg_do_ioctl() to cover resizing partitions.
>>
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   block/ioctl.c           |  9 ++++++++-
>>   block/partitions/core.c | 11 -----------
>>   2 files changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index 438f79c564cf..de0cc0d215c6 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -18,7 +18,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>>   {
>>   	struct gendisk *disk = bdev->bd_disk;
>>   	struct blkpg_partition p;
>> -	sector_t start, length;
>> +	sector_t start, length, capacity, end;
>>   
>>   	if (!capable(CAP_SYS_ADMIN))
>>   		return -EACCES;
>> @@ -41,6 +41,13 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>>   
>>   	start = p.start >> SECTOR_SHIFT;
>>   	length = p.length >> SECTOR_SHIFT;
>> +	capacity = get_capacity(disk);
>> +
>> +	if (check_add_overflow(start, length, &end))
>> +		return -EINVAL;
>> +
>> +	if (start >= capacity || end > capacity)
>> +		return -EINVAL;
>>   
>>   	switch (op) {
>>   	case BLKPG_ADD_PARTITION:
>> diff --git a/block/partitions/core.c b/block/partitions/core.c
>> index 5f5ed5c75f04..b11e88c82c8c 100644
>> --- a/block/partitions/core.c
>> +++ b/block/partitions/core.c
>> @@ -419,21 +419,10 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
>>   int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
>>   		sector_t length)
>>   {
>> -	sector_t capacity = get_capacity(disk), end;
>>   	struct block_device *part;
>>   	int ret;
>>   
>>   	mutex_lock(&disk->open_mutex);
>> -	if (check_add_overflow(start, length, &end)) {
>> -		ret = -EINVAL;
>> -		goto out;
>> -	}
>> -
>> -	if (start >= capacity || end > capacity) {
>> -		ret = -EINVAL;
>> -		goto out;
>> -	}
>> -
> Why do you remove this ? The check will not be done when *existing* partitions
I'm sorry, I didn't quite understand your point. The function 
bdev_add_partition() is only called within blkpg_do_ioctl(). I simply 
moved the check to a different location, but did not remove it entirely.
> are added. To do the check when *creating* a partition, make this code a helper
> and call that helper function here and from blkpg_do_ioctl() as well.
Do you mean call the helper function in blk_add_partition() and 
blkpg_do_ioctl()?
>
>>   	if (!disk_live(disk)) {
>>   		ret = -ENXIO;
>>   		goto out;


