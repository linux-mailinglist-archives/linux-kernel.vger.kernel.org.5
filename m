Return-Path: <linux-kernel+bounces-70177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C7F859460
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3AF2822A9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976605223;
	Sun, 18 Feb 2024 03:24:43 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3734C6D;
	Sun, 18 Feb 2024 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708226683; cv=none; b=pHefC7beNVT7HNvcHxws7fOltNSOCCO/PzxXD5cv+LZo/xhYi92YVpBYD1ykfTRqtlwMvbMIRN02NzWw1R26Hiv8IZu3pP1njggBVESCgRXwW99PVKLFOlYDEMCqtwZ4cGGfuw2DZmjQQrIR+AipjddBkZ8bzUNJNkVMXL59ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708226683; c=relaxed/simple;
	bh=BY05uZrcFu7xtAxk5fCx+bheSiCu/C4nKPg69SmEjJk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WXi0jOoQRzbnuzZd9sOnS3jx5A/ftdTmjQvEfOS0Mqp7oT50OczRy2pp36OG0yua6hpIS4pbkC6m+1jEfbJBLXGGMte9GEV7gjlTpOd6/GA87nwgTqAXOpDQrNvXyGZBaR4BJ80Bs+lCVxyCzh0b2QGI/VFt1leIbaAinoa5wes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tcrcs4DS9z4f3lWJ;
	Sun, 18 Feb 2024 11:24:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 978A31A0172;
	Sun, 18 Feb 2024 11:24:36 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgB3fW9yeNFlYqKrEQ--.57206S3;
	Sun, 18 Feb 2024 11:24:36 +0800 (CST)
Subject: Re: [PATCH v5 01/14] md: don't ignore suspended array in
 md_check_recovery()
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com,
 agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 song@kernel.org, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com,
 akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-2-yukuai1@huaweicloud.com>
 <CALTww2-ZhRBJOD3jXs=xKFaD=iR=dtoC9h2rUQi5Stpi+tJ9Bw@mail.gmail.com>
 <64d27757-9387-09dc-48e8-a9eedd67f075@huaweicloud.com>
 <CALTww28E=k6fXJURG77KwHb7M2OByLrcE8g7GNkQDTtcOV48hQ@mail.gmail.com>
 <d4a2689e-b5cc-f268-9fb2-84c10e5eb0f4@huaweicloud.com>
 <CALTww28bUzmQASme3XOz0CY=o86f1EUU23ENmnf42UVyuGzQ4Q@mail.gmail.com>
 <c1195efd-dd83-317e-3067-cd4891ae013e@huaweicloud.com>
 <CALTww2-7tTMdf_XZ60pNKH_QCq3OUX2P==VPXZo3f-dHzVhmnw@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2fa01c30-2ee7-7c01-6833-bf74142e6d7c@huaweicloud.com>
Date: Sun, 18 Feb 2024 11:24:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2-7tTMdf_XZ60pNKH_QCq3OUX2P==VPXZo3f-dHzVhmnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3fW9yeNFlYqKrEQ--.57206S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1DCr4kXrWktr43uw48JFb_yoW5KrW7pF
	y0qa10kr4UAryxA3sFva1kXa4Fvw1aqrWUZry3Kr1rCwn29w1rAF40gF45CFyDAFZ3G3ZF
	vw45ta93Zw1kJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/18 11:15, Xiao Ni 写道:
> On Sun, Feb 18, 2024 at 10:34 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/02/18 10:27, Xiao Ni 写道:
>>> On Sun, Feb 18, 2024 at 9:46 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> 在 2024/02/18 9:33, Xiao Ni 写道:
>>>>> The deadlock problem mentioned in this patch should not be right?
>>>>
>>>> No, I think it's right. Looks like you are expecting other problems,
>>>> like mentioned in patch 6, to be fixed by this patch.
>>>
>>> Hi Kuai
>>>
>>> Could you explain why step1 and step2 from this comment can happen
>>> simultaneously? From the log, the process should be
>>> The process is :
>>> dev_remove->dm_destroy->__dm_destroy->dm_table_postsuspend_targets(raid_postsuspend)
>>> -> dm_table_destroy(raid_dtr).
>>> After suspending the array, it calls raid_dtr. So these two functions
>>> can't happen simultaneously.
>>
>> You're removing the target directly, however, dm can suspend the disk
>> directly, you can simplily:
>>
>> 1) dmsetup suspend xxx
>> 2) dmsetup remove xxx
> 
> For dm-raid, the design of suspend stops sync thread first and then it
> calls mddev_suspend to suspend array. So I'm curious why the sync
> thread can still exit when array is suspended. I know the reason now.
> Because before f52f5c71f (md: fix stopping sync thread), the process
> is raid_postsuspend->md_stop_writes->__md_stop_writes
> (__md_stop_writes sets MD_RECOVERY_FROZEN). In patch f52f5c71f, it
> doesn't set MD_RECOVERY_FROZEN in __md_stop_writes anymore.
> 
> The process changes to
> 1. raid_postsuspend->md_stop_writes->__md_stop_writes->stop_sync_thread
> (wait until MD_RECOVERY_RUNNING clears)
> 2. md thread -> md_check_recovery -> unregister_sync_thread ->
> md_reap_sync_thread (clears MD_RECOVERY_RUNNING, stop_sync_thread
> returns, md_reap_sync_thread sets MD_RECOVERY_NEEDED)
> 3. raid_postsuspend->mddev_suspend
> 4. md sync thread starts again because __md_stop_writes doesn't set
> MD_RECOVERY_FROZEN.
> It's the reason why we can see sync thread still happens when raid is suspended.
> 
> So the patch fix this problem should:

As I said, this is really a different problem from this patch, and it is
fixed seperately by patch 9. Please take a look at that patch.

Thanks,
Kuai

> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 9e41a9aaba8b..666761466f02 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6315,6 +6315,7 @@ static void md_clean(struct mddev *mddev)
> 
>   static void __md_stop_writes(struct mddev *mddev)
>   {
> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>          stop_sync_thread(mddev, true, false);
>          del_timer_sync(&mddev->safemode_timer);
> 
> Like other places which call stop_sync_thread, it needs to set the
> MD_RECOVERY_FROZEN bit.
> 
> Regards
> Xiao
> 
>>
>> Please also take a look at other patches, why step 1) can't stop sync
>> thread.
>>
>> Thanks,
>> Kuai
>>
>>>
>>>
>>>>
>>>> Noted that this patch just fix one case that MD_RECOVERY_RUNNING can't
>>>> be cleared, I you are testing this patch alone, please make sure that
>>>> you still triggered the exactly same case:
>>>>
>>>> - MD_RCOVERY_RUNNING can't be cleared while array is suspended.
>>>
>>> I'm not testing this patch. I want to understand the patch well. So I
>>> need to understand the issue first. I can't understand how this
>>> deadlock (step1,step2) happens.
>>>
>>> Regards
>>> Xiao
>>>>
>>>> Thanks,
>>>> Kuai
>>>>
>>>
>>> .
>>>
>>
> 
> .
> 


