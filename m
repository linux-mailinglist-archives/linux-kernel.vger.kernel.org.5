Return-Path: <linux-kernel+bounces-36394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBBA83A000
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1332B28838
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5675C85;
	Wed, 24 Jan 2024 03:16:56 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC4524C;
	Wed, 24 Jan 2024 03:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706066215; cv=none; b=Tgx1HNhrTJ1nn3lhZP/9snjmDdzYd58CP8V0o9QnzHsJMOVkBpBfWNNCEQGOb42rJEy3GcxisBj6cZd7k/ElBb/48uvZg6UVBS+wnaNUNqf1Ydujg58RoSplud5jg1tj6brYlCJH8tYwRmgy9n7uVvJ1JLLVceMILIIWTn9Pxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706066215; c=relaxed/simple;
	bh=KoKJOAfFqJj/64JXWg/TEVuQifWy5nCHkEHI2/1w9NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrBODRH5ss0nOjYj7OEMRgxtOpEmndiEKc5ymR9Rh3cByArfm++F+iQbXXWpzjswiVLnIr87nBBUY1nvZwXO3+kJ8CfoN/FNcpW5o03LidYtBuNA3UoX9KE0Xhb3SJ18FhzPseAItdBw3tUUdf3YJ2yQy6hgIDsYPJ3tDRoQaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TKTdX4GCyz4f3k6W;
	Wed, 24 Jan 2024 11:16:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E7D151A0272;
	Wed, 24 Jan 2024 11:16:50 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgBXfA8ggbBlYOZHBw--.11031S3;
	Wed, 24 Jan 2024 11:16:50 +0800 (CST)
Message-ID: <425044a0-95ce-b2a3-e98d-527c31f0313a@huaweicloud.com>
Date: Wed, 24 Jan 2024 11:16:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/3] md: sync blockdev before stopping raid or setting
 readonly
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
 linan666@huaweicloud.com
Cc: song@kernel.org, shli@fb.com, neilb@suse.com, zlliu@suse.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20240117093707.2767209-1-linan666@huaweicloud.com>
 <20240117093707.2767209-4-linan666@huaweicloud.com>
 <20240118090205.00000212@linux.intel.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20240118090205.00000212@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXfA8ggbBlYOZHBw--.11031S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyDCF4kAryDCrW7JFy5Jwb_yoW8AF45p3
	y0yFs0gr1UJry3A3ZrW3W8Wa4rKF92yFZxKr13A3WUZryDCrnxXr9agw4YvFykK3sayw40
	vw4UXa93Ga42ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/1/18 16:02, Mariusz Tkaczyk 写道:
> On Wed, 17 Jan 2024 17:37:07 +0800
> linan666@huaweicloud.com wrote:
> 
>> From: Li Nan <linan122@huawei.com>
>>
>> Commit a05b7ea03d72 ("md: avoid crash when stopping md array races
>> with closing other open fds.") added sync_block before stopping raid and
>> setting readonly. Later in commit 260fa034ef7a ("md: avoid deadlock when
>> dirty buffers during md_stop.") it is moved to ioctl. array_state_store()
>> was ignored. Add sync blockdev to array_state_store() now.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>

[...]

>> +
>> +	/* we will call set readonly or stop raid, sync blockdev */
>> +	if (st == clear || (mddev->pers && (st == readonly ||
>> +	    st == inactive || (st == read_auto && md_is_rdwr(mddev))))) {
>> +		err = mddev_sync_blockdev(mddev);
>> +		if (err)
>> +			return err;
>> +		clear_md_closing = true;
>> +	}
>> +
> 
> Please reorganize it a little for readability:
> I think if no mddev->pers we don't need to consider sync_blockdev at all. If
> personality is there we can probably check for read-write. If it is not
> read-write then nothing to sync. What about that:
> 
> if (mddev->pers && md_is_rdwr(mddev) &&
>      (st == clear || st == readonly || st == inactive || st == read_auto))
> 
> Please note that I didn't test it so please let me know if you see issue in
> proposed logic.
> I think that we may be able to include it in "/* No lock dependent actions */"
> switch. Please consider it too:
> 

Thanks for your review.
It is a really good idea. I will test and improve it.

> case clear:
> case readonly:
> case inactive:
> case read_auto:
>      if(!mddev->pers || !md_is_rdwr(mddev))
>            break;
>      err = mddev_sync_blockdev(mddev);
>      if (err)
>          return err;
>      clear_md_closing = true;
>      

-- 
Thanks,
Nan


