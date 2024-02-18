Return-Path: <linux-kernel+bounces-70217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E33B8594F2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF771C211E1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228D611E;
	Sun, 18 Feb 2024 06:22:19 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7114E15C9;
	Sun, 18 Feb 2024 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237339; cv=none; b=kT3tH8huh7PHSrPlm/h9km2R5QpmSK05ER5ffn1Y7683CF0LfeMURN8ynR/zzv6Go9ZM8g99XvKu0dVwLincNAxfrQhBO5XVlAESUuyJk6nYDETEiTnjxl+xkLCyfVCUY1SWTesWlh7V11MLshF9N+RWkliQWu/X/IqEVmuN8D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237339; c=relaxed/simple;
	bh=DELF/Sa212R0lUf3hHPALmBz+5/UQRBsAaWQYXYZETc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FOHssHe59p47pufgJFyPTNGBzyU450PgCyQC0mZ6TsoXbUi28brceh4hnUS4K9cM9th4USL5NfGAnR7PeW+inNodKwY6/1n1gLvPr7XxAJDUzj/XOVSIGVhoAHFMtAuEGaisOmh/23CqYZ6CXl3fdkGhcH0LcgT9e5Ga6BSzy7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TcwYm5Yghz4f3jMP;
	Sun, 18 Feb 2024 14:22:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9E2801A0D7B;
	Sun, 18 Feb 2024 14:22:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEPotFlQQ17EQ--.38616S3;
	Sun, 18 Feb 2024 14:22:09 +0800 (CST)
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
 <2fa01c30-2ee7-7c01-6833-bf74142e6d7c@huaweicloud.com>
 <CALTww2-HngEJ9z9cYZ0=kcfuKMpziH3utSgk_8u3dxc553ZNeg@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5480b350-efe3-2be7-cf3b-3a62bb0e012b@huaweicloud.com>
Date: Sun, 18 Feb 2024 14:22:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2-HngEJ9z9cYZ0=kcfuKMpziH3utSgk_8u3dxc553ZNeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBEPotFlQQ17EQ--.38616S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr15XF1kGry7AF1ktrW5KFg_yoW7Zr47pr
	y0qF4UKr4UAr17Ar9Fva1kXFyrtw1jqrWUXry5Gr15GwnIvrn3JFW0qF45CFyDAF93G3ZF
	vw4UJa4fZr1rJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/18 13:07, Xiao Ni 写道:
> On Sun, Feb 18, 2024 at 11:24 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/02/18 11:15, Xiao Ni 写道:
>>> On Sun, Feb 18, 2024 at 10:34 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> 在 2024/02/18 10:27, Xiao Ni 写道:
>>>>> On Sun, Feb 18, 2024 at 9:46 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> 在 2024/02/18 9:33, Xiao Ni 写道:
>>>>>>> The deadlock problem mentioned in this patch should not be right?
>>>>>>
>>>>>> No, I think it's right. Looks like you are expecting other problems,
>>>>>> like mentioned in patch 6, to be fixed by this patch.
>>>>>
>>>>> Hi Kuai
>>>>>
>>>>> Could you explain why step1 and step2 from this comment can happen
>>>>> simultaneously? From the log, the process should be
>>>>> The process is :
>>>>> dev_remove->dm_destroy->__dm_destroy->dm_table_postsuspend_targets(raid_postsuspend)
>>>>> -> dm_table_destroy(raid_dtr).
>>>>> After suspending the array, it calls raid_dtr. So these two functions
>>>>> can't happen simultaneously.
>>>>
>>>> You're removing the target directly, however, dm can suspend the disk
>>>> directly, you can simplily:
>>>>
>>>> 1) dmsetup suspend xxx
>>>> 2) dmsetup remove xxx
>>>
>>> For dm-raid, the design of suspend stops sync thread first and then it
>>> calls mddev_suspend to suspend array. So I'm curious why the sync
>>> thread can still exit when array is suspended. I know the reason now.
>>> Because before f52f5c71f (md: fix stopping sync thread), the process
>>> is raid_postsuspend->md_stop_writes->__md_stop_writes
>>> (__md_stop_writes sets MD_RECOVERY_FROZEN). In patch f52f5c71f, it
>>> doesn't set MD_RECOVERY_FROZEN in __md_stop_writes anymore.
>>>
>>> The process changes to
>>> 1. raid_postsuspend->md_stop_writes->__md_stop_writes->stop_sync_thread
>>> (wait until MD_RECOVERY_RUNNING clears)
>>> 2. md thread -> md_check_recovery -> unregister_sync_thread ->
>>> md_reap_sync_thread (clears MD_RECOVERY_RUNNING, stop_sync_thread
>>> returns, md_reap_sync_thread sets MD_RECOVERY_NEEDED)
>>> 3. raid_postsuspend->mddev_suspend
>>> 4. md sync thread starts again because __md_stop_writes doesn't set
>>> MD_RECOVERY_FROZEN.
>>> It's the reason why we can see sync thread still happens when raid is suspended.
>>>
>>> So the patch fix this problem should:
>>
>> As I said, this is really a different problem from this patch, and it is
>> fixed seperately by patch 9. Please take a look at that patch.
> 
> I think we're talking about the same problem. In patch07 it has a new
> api md_frozen_sync_thread. It sets MD_RECOVERY_FROZEN before
> stop_sync_thread. This is right. If we use this api in
> raid_postsuspend, sync thread can't restart. So the deadlock can't
> happen anymore?

We are not talking about the same problem at all. This patch just fix a
simple problem in md/raid(not dm-raid). And the deadlock can also be
triggered for md/raid the same.

- mddev_suspend() doesn't handle sync_thread at all;
- md_check_recovery() ignore suspended array;

Please keep in mind this patch just fix the above case. The deadlock in
dm-raid is just an example of problems caused by this. Fix the deadlock
other way doesn't mean this case is fine.

> 
> And patch01 is breaking one logic which seems right:
> 
> commit 68866e425be2ef2664aa5c691bb3ab789736acf5
> Author: Jonathan Brassow <jbrassow@f14.redhat.com>
> Date:   Wed Jun 8 15:10:08 2011 +1000
> 
>      MD: no sync IO while suspended
> 
>      Disallow resync I/O while the RAID array is suspended.
> 
> We're trying to fix deadlock problems. But it's not good to fix a
> problem by breaking an existing rule.

The existing rule itself is problematic. Above patch doesn't do well.

It's just a simple problem here, should sync thread also stop in
mddev_suspend? If you want do do this, you can submit a patch, in the
right way, we'll see how this will work.

- keep this patch to remove checking of suspended array;
- set MD_RECOVERY_FORZEN and stop sync thread in mddev_suspend,
'reconfig_mutex' will be needed again, and lots of callers need to be
checked.

Thanks,
Kuai

> 
> Regards
> Xiao
> 
> 
>>
>> Thanks,
>> Kuai
>>
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 9e41a9aaba8b..666761466f02 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -6315,6 +6315,7 @@ static void md_clean(struct mddev *mddev)
>>>
>>>    static void __md_stop_writes(struct mddev *mddev)
>>>    {
>>> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>           stop_sync_thread(mddev, true, false);
>>>           del_timer_sync(&mddev->safemode_timer);
>>>
>>> Like other places which call stop_sync_thread, it needs to set the
>>> MD_RECOVERY_FROZEN bit.
>>>
>>> Regards
>>> Xiao
>>>
>>>>
>>>> Please also take a look at other patches, why step 1) can't stop sync
>>>> thread.
>>>>
>>>> Thanks,
>>>> Kuai
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Noted that this patch just fix one case that MD_RECOVERY_RUNNING can't
>>>>>> be cleared, I you are testing this patch alone, please make sure that
>>>>>> you still triggered the exactly same case:
>>>>>>
>>>>>> - MD_RCOVERY_RUNNING can't be cleared while array is suspended.
>>>>>
>>>>> I'm not testing this patch. I want to understand the patch well. So I
>>>>> need to understand the issue first. I can't understand how this
>>>>> deadlock (step1,step2) happens.
>>>>>
>>>>> Regards
>>>>> Xiao
>>>>>>
>>>>>> Thanks,
>>>>>> Kuai
>>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
>>>
>>> .
>>>
>>
> 
> .
> 


