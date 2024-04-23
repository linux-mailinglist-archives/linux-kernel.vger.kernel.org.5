Return-Path: <linux-kernel+bounces-154594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770968ADE14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69A628325B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF145C04;
	Tue, 23 Apr 2024 07:15:47 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849293F8ED;
	Tue, 23 Apr 2024 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856546; cv=none; b=T4Degtb7jTFvjnxe1LDSjcNmWhx//z+kdfdX2ROGOGKif71TKYteNrwaqOQqqJeh/V/O3TqW6F3tLvBt+Ec/M3/06yI3Me/pLS/aBWElt0Wx+G5n32RMQAxpVzDQEVhSlvyuUAmyJ9Bv0lIIy4U8OvP5i9ERyR26XqYkuQkrxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856546; c=relaxed/simple;
	bh=Ca1/XulGZelB5Bn0Dp6m6xNgjx+/Qh3GXQf31tYrpWs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=g11kMDMyC8MdqctL16O6g3vGWYnkdLWxuK4xDU3m1IEw2kahbn95+zewNFsaa/XXZIEPs0N+bMTyceetToMZOlR+NYKtJcT7m3p5N3PWEqky8CWRjWaACtpp6orVfEwNP1Et80NkOGS1eZHNapcz8RdiYKUxSWILwPmpkg67NAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VNtgT4j1tz4f3kpM;
	Tue, 23 Apr 2024 15:15:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2517E1A0572;
	Tue, 23 Apr 2024 15:15:41 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBEaYCdmxbXrKg--.32203S3;
	Tue, 23 Apr 2024 15:15:39 +0800 (CST)
Subject: Re: [PATCH -next] md: fix resync softlockup when bitmap size is less
 than array size
To: Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org, linan122@huawei.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, Nigel Croxon
 <ncroxon@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240422065824.2516-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8f87adb7-5f80-3bd7-7bc0-a80dbf1e4d0a@huaweicloud.com>
Date: Tue, 23 Apr 2024 15:15:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240422065824.2516-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBEaYCdmxbXrKg--.32203S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy5AF1fGry3KF45Gw47CFg_yoW5Aw18pF
	WUKa13Cr15t345Ww4UJry8uFyFv3s5tF9rGF1fGw13Ca48JFsxGrWkGF1Yg3WkWrWfGFZ8
	Xws8WFZ3uF1kWaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
	DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

+CC Nigel

Sorry I forgot that.

ÔÚ 2024/04/22 14:58, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Is is reported that for dm-raid10, lvextend + lvchange --syncaction will
> trigger following softlockup:
> 
> kernel:watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [mdX_resync:6976]
> CPU: 7 PID: 3588 Comm: mdX_resync Kdump: loaded Not tainted 6.9.0-rc4-next-20240419 #1
> RIP: 0010:_raw_spin_unlock_irq+0x13/0x30
> Call Trace:
>   <TASK>
>   md_bitmap_start_sync+0x6b/0xf0
>   raid10_sync_request+0x25c/0x1b40 [raid10]
>   md_do_sync+0x64b/0x1020
>   md_thread+0xa7/0x170
>   kthread+0xcf/0x100
>   ret_from_fork+0x30/0x50
>   ret_from_fork_asm+0x1a/0x30
> 
> And the detailed process is as follows:
> 
> md_do_sync
>   j = mddev->resync_min
>   while (j < max_sectors)
>    sectors = raid10_sync_request(mddev, j, &skipped)
>     if (!md_bitmap_start_sync(..., &sync_blocks))
>      // md_bitmap_start_sync set sync_blocks to 0
>      return sync_blocks + sectors_skippe;
>    // sectors = 0;
>    j += sectors;
>    // j never change
> 
> Root cause is that commit 301867b1c168 ("md/raid10: check
> slab-out-of-bounds in md_bitmap_get_counter") return early from
> md_bitmap_get_counter(), without setting returned blocks.
> 
> Fix this problem by always set returned blocks from
> md_bitmap_get_counter"(), as it used to be.
> 
> Noted that this patch just fix the softlockup problem in kernel, the
> case that bitmap size doesn't match array size still need to be fixed.
> 
> Fixes: 301867b1c168 ("md/raid10: check slab-out-of-bounds in md_bitmap_get_counter")
> Reported-and-tested-by: Nigel Croxon <ncroxon@redhat.com>
> Closes: https://lore.kernel.org/all/71ba5272-ab07-43ba-8232-d2da642acb4e@redhat.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md-bitmap.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 059afc24c08b..f5b66d52cbe3 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1424,15 +1424,17 @@ __acquires(bitmap->lock)
>   	sector_t chunk = offset >> bitmap->chunkshift;
>   	unsigned long page = chunk >> PAGE_COUNTER_SHIFT;
>   	unsigned long pageoff = (chunk & PAGE_COUNTER_MASK) << COUNTER_BYTE_SHIFT;
> -	sector_t csize;
> +	sector_t csize = ((sector_t)1) << bitmap->chunkshift;
>   	int err;
>   
> +
>   	if (page >= bitmap->pages) {
>   		/*
>   		 * This can happen if bitmap_start_sync goes beyond
>   		 * End-of-device while looking for a whole page or
>   		 * user set a huge number to sysfs bitmap_set_bits.
>   		 */
> +		*blocks = csize - (offset & (csize - 1));
>   		return NULL;
>   	}
>   	err = md_bitmap_checkpage(bitmap, page, create, 0);
> @@ -1441,8 +1443,7 @@ __acquires(bitmap->lock)
>   	    bitmap->bp[page].map == NULL)
>   		csize = ((sector_t)1) << (bitmap->chunkshift +
>   					  PAGE_COUNTER_SHIFT);
> -	else
> -		csize = ((sector_t)1) << bitmap->chunkshift;
> +
>   	*blocks = csize - (offset & (csize - 1));
>   
>   	if (err < 0)
> 


