Return-Path: <linux-kernel+bounces-91758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691E5871626
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966AF1C21FF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F27CF29;
	Tue,  5 Mar 2024 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZmpoI7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9192F5D46B;
	Tue,  5 Mar 2024 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622010; cv=none; b=IV5RTKpiVT7Rke28n8yrQe4634DU997thQGdT+xwAp9wUIPOc8v75Gxw/0hQAWGSuNtArpq4dk/7ikUHcOOPxXwxPCSu2r0pM21dnHvd32fIsQ+MEOg8bCzzoysTPCHZgxH+jLtnpMSHXv5Ay29ZzvXx1sos67zCxE8zJBjo8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622010; c=relaxed/simple;
	bh=Xpo+kzipCOmlginqY4JX8Wmv8TpqX9dz9u795LbG/GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaOIWBibwyhG3o9lnvgzBWSEyxtCHQUt9rHhoi2kAPQZPJRwN+fr5HPR1YuDLblRRPZQnznDml85GhPUjYCOcaMb0xAaf5vwRkMbsjSIFTtVvi+HZeG6tm57JR+UQsE9wrjoLG/46iix+I6UjtMaj5s3ogyYdFPJXIfuwVjY4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZmpoI7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7F7C433F1;
	Tue,  5 Mar 2024 07:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709622010;
	bh=Xpo+kzipCOmlginqY4JX8Wmv8TpqX9dz9u795LbG/GE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UZmpoI7iWMqlhQaYYswyEsx1Evr6pxay3y99haW/oZtiQzhxEK41SbkLzKmaF2rjR
	 Uzop+kI0b9VvzA/a+o2Y5mBtsGgS91i32HJ1tSlYUe5WBH4klt4ULW8l1eNbQ6QrbU
	 8XfnqXsmxni4TNbnfqgRGORnq9k/IRabQ6hRPJFFxXbgbMc5/1J+ZDi7tfUbIBYvRl
	 6i5q7hzEecCXhkJebBI5nLTG5kG5+iH43IqVDZnhlVUVJWCBFx78CptEwQq883nh+R
	 D5izbuXuHI7FUQYS1OHGBTXwMQzQ7kirzz/ZfhFCa6TlrEU1tvXzhkL83moToRVJKn
	 aluqSkiFIfddw==
Message-ID: <65936df3-e963-474a-84ca-2fac6eba54ea@kernel.org>
Date: Tue, 5 Mar 2024 16:00:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: move capacity validation to blkpg_do_ioctl()
Content-Language: en-US
To: Li Lingfeng <lilingfeng@huaweicloud.com>, axboe@kernel.dk,
 min15.li@samsung.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 yangerkun@huawei.com, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com
References: <20240305032132.548958-1-lilingfeng@huaweicloud.com>
 <474e78e7-9056-4b74-9ce2-592b8ee9411c@kernel.org>
 <2ae82ded-4d8a-cc0d-65b0-9468eaede73c@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2ae82ded-4d8a-cc0d-65b0-9468eaede73c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/5/24 15:24, Li Lingfeng wrote:
> 
> 在 2024/3/5 12:30, Damien Le Moal 写道:
>> On 3/5/24 12:21, Li Lingfeng wrote:
>>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>>
>>> Commit 6d4e80db4ebe ("block: add capacity validation in
>>> bdev_add_partition()") add check of partition's start and end sectors to
>>> prevent exceeding the size of the disk when adding partitions. However,
>>> there is still no check for resizing partitions now.
>>> Move the check to blkpg_do_ioctl() to cover resizing partitions.
>>>
>>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> ---
>>>   block/ioctl.c           |  9 ++++++++-
>>>   block/partitions/core.c | 11 -----------
>>>   2 files changed, 8 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/block/ioctl.c b/block/ioctl.c
>>> index 438f79c564cf..de0cc0d215c6 100644
>>> --- a/block/ioctl.c
>>> +++ b/block/ioctl.c
>>> @@ -18,7 +18,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>>>   {
>>>       struct gendisk *disk = bdev->bd_disk;
>>>       struct blkpg_partition p;
>>> -    sector_t start, length;
>>> +    sector_t start, length, capacity, end;
>>>         if (!capable(CAP_SYS_ADMIN))
>>>           return -EACCES;
>>> @@ -41,6 +41,13 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>>>         start = p.start >> SECTOR_SHIFT;
>>>       length = p.length >> SECTOR_SHIFT;
>>> +    capacity = get_capacity(disk);
>>> +
>>> +    if (check_add_overflow(start, length, &end))
>>> +        return -EINVAL;
>>> +
>>> +    if (start >= capacity || end > capacity)
>>> +        return -EINVAL;
>>>         switch (op) {
>>>       case BLKPG_ADD_PARTITION:
>>> diff --git a/block/partitions/core.c b/block/partitions/core.c
>>> index 5f5ed5c75f04..b11e88c82c8c 100644
>>> --- a/block/partitions/core.c
>>> +++ b/block/partitions/core.c
>>> @@ -419,21 +419,10 @@ static bool partition_overlaps(struct gendisk *disk,
>>> sector_t start,
>>>   int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
>>>           sector_t length)
>>>   {
>>> -    sector_t capacity = get_capacity(disk), end;
>>>       struct block_device *part;
>>>       int ret;
>>>         mutex_lock(&disk->open_mutex);
>>> -    if (check_add_overflow(start, length, &end)) {
>>> -        ret = -EINVAL;
>>> -        goto out;
>>> -    }
>>> -
>>> -    if (start >= capacity || end > capacity) {
>>> -        ret = -EINVAL;
>>> -        goto out;
>>> -    }
>>> -
>> Why do you remove this ? The check will not be done when *existing* partitions
> I'm sorry, I didn't quite understand your point. The function
> bdev_add_partition() is only called within blkpg_do_ioctl(). I simply moved the
> check to a different location, but did not remove it entirely.

Oh ! My bad ! I got confused with blk_add_partition() which is the function
adding partitions when a new disk is scanned. So yes, your patch is fine. My
apologies for the noise.

>> are added. To do the check when *creating* a partition, make this code a helper
>> and call that helper function here and from blkpg_do_ioctl() as well.
> Do you mean call the helper function in blk_add_partition() and blkpg_do_ioctl()?
>>
>>>       if (!disk_live(disk)) {
>>>           ret = -ENXIO;
>>>           goto out;
> 
> 

-- 
Damien Le Moal
Western Digital Research


