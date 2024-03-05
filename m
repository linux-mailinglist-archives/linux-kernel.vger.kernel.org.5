Return-Path: <linux-kernel+bounces-91656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C08714BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106B31C2318A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C313FE5D;
	Tue,  5 Mar 2024 04:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORWxleWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4929A2;
	Tue,  5 Mar 2024 04:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613049; cv=none; b=KbmC3PSq2MmRmZrbaqU+5XieelZ1g0MAkdXozIPk4W2SO4q8bjIGEJuP7brMdUxYsRod6D3MnOFnl+f1myEDAC+5JnLQtUoaGseUYQyDAu3kM0GEDUi1wyEPXrGfzsJpMmhXtjMLwCuLL3aa36KmaT3vLnreVCy3DGSXkv4yMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613049; c=relaxed/simple;
	bh=9rARLDaLXDlmL73GSWpwPcSLa2+EkPEWN6GvaI9/NfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afHlkZT+mHvw587iA5Pn6QMBPUqf6YNPz3aXhyXv2nIr5DNDPn0GUwHerxYpivqlgqdEXeqZNKldWhb7jGV0fDW7RhTauYJYOJTBsSSeZw6CMgCO2GLXIt8P8o4hs8vZt/rWKz2DvRLiBGmKRWjXAl29abKPp2Ey1M5YD5LuCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORWxleWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F7CC433F1;
	Tue,  5 Mar 2024 04:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709613048;
	bh=9rARLDaLXDlmL73GSWpwPcSLa2+EkPEWN6GvaI9/NfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ORWxleWrgQvOCYRmP6nAJufsAa8n+T9LMtQdGSebziw1HfoS6rMdLYhkO06pnCcWk
	 GNMFNODTLi6BNQUEhYyozWBmnVKwfPew+MO/9GwQndCKJ7TYxoAEgta2MAwSRncNGC
	 1znNDWPh0KjE/7xKkAPOgz2Y7GuNbhd1VijvytFeaN0YzGYDJHGR2Q5wiGtfhRj9iU
	 kgjOhs3PaVwlrk+spODCHlybrms6PKOsm3uXsOTtyHEqSjDgs9CQx8a+7VL+JkpHdG
	 0m4dkYdTwHVcyN7Xa3Eo/Q4ts/zhWB4BKPhx1HZZLJXDs3yEb9amyLFO0ShTWQkUcS
	 tvXWbFDKXAbtw==
Message-ID: <474e78e7-9056-4b74-9ce2-592b8ee9411c@kernel.org>
Date: Tue, 5 Mar 2024 13:30:45 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240305032132.548958-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 12:21, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Commit 6d4e80db4ebe ("block: add capacity validation in
> bdev_add_partition()") add check of partition's start and end sectors to
> prevent exceeding the size of the disk when adding partitions. However,
> there is still no check for resizing partitions now.
> Move the check to blkpg_do_ioctl() to cover resizing partitions.
> 
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>  block/ioctl.c           |  9 ++++++++-
>  block/partitions/core.c | 11 -----------
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 438f79c564cf..de0cc0d215c6 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -18,7 +18,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>  {
>  	struct gendisk *disk = bdev->bd_disk;
>  	struct blkpg_partition p;
> -	sector_t start, length;
> +	sector_t start, length, capacity, end;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;
> @@ -41,6 +41,13 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>  
>  	start = p.start >> SECTOR_SHIFT;
>  	length = p.length >> SECTOR_SHIFT;
> +	capacity = get_capacity(disk);
> +
> +	if (check_add_overflow(start, length, &end))
> +		return -EINVAL;
> +
> +	if (start >= capacity || end > capacity)
> +		return -EINVAL;
>  
>  	switch (op) {
>  	case BLKPG_ADD_PARTITION:
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 5f5ed5c75f04..b11e88c82c8c 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -419,21 +419,10 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
>  int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
>  		sector_t length)
>  {
> -	sector_t capacity = get_capacity(disk), end;
>  	struct block_device *part;
>  	int ret;
>  
>  	mutex_lock(&disk->open_mutex);
> -	if (check_add_overflow(start, length, &end)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (start >= capacity || end > capacity) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -

Why do you remove this ? The check will not be done when *existing* partitions
are added. To do the check when *creating* a partition, make this code a helper
and call that helper function here and from blkpg_do_ioctl() as well.

>  	if (!disk_live(disk)) {
>  		ret = -ENXIO;
>  		goto out;

-- 
Damien Le Moal
Western Digital Research


