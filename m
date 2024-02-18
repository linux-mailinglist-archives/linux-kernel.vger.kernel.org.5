Return-Path: <linux-kernel+bounces-70301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A293D8595C8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176F1282E17
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6957168BE;
	Sun, 18 Feb 2024 08:47:57 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57114281;
	Sun, 18 Feb 2024 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708246077; cv=none; b=ftWL/vr/SLdRB5MWUfUBOAkyNNkriV0rXSeumO3doSDuNTlbY15G1bcyshZVAGXXC4B/QhMw1LhNHzfeqsrB6JNQGrHREIwil48YFvsK+T/xbc4gcAhxKNql9kGun1MOKlldr5sYGtkmejmQfSvlC/GUtZOSMUZ10XRXVkvims4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708246077; c=relaxed/simple;
	bh=hTNi/orprw9Qjmvh/s2Omv4QpAAV9grYwXTtiGH83o0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Qy7GztT1pSSXm4qbt9mNM5wMSnunyVXVQzy1dFCpYn4A9GJqtDr3aNJ4kq4t0UfPW3Fb/VCmp8FpgGMIiQ0wfwjCDP5TBFSoqdcGOdQwlueXOuIngGBQlQsqFaKkK5TIl2+IbIHlT2dzciit3UUYIHz0iEJgiR8hIhtEMSXdZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tcznw5mfbz4f3kJs;
	Sun, 18 Feb 2024 16:47:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DC3FC1A0C84;
	Sun, 18 Feb 2024 16:47:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ41xNFl6KqFEQ--.10218S3;
	Sun, 18 Feb 2024 16:47:51 +0800 (CST)
Subject: Re: [PATCH v5 01/14] md: don't ignore suspended array in
 md_check_recovery()
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com,
 agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 song@kernel.org, neilb@suse.de, shli@fb.com, akpm@osdl.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com,
 Jonathan Brassow <jbrassow@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
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
 <5480b350-efe3-2be7-cf3b-3a62bb0e012b@huaweicloud.com>
 <CALTww2-_uvkB7M=_J_6DgW1kfzW2rpQgp0vyKt7EYvON41adGw@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ed1fc73d-57f8-6862-76f4-2e6ff0cd5fc8@huaweicloud.com>
Date: Sun, 18 Feb 2024 16:47:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2-_uvkB7M=_J_6DgW1kfzW2rpQgp0vyKt7EYvON41adGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ41xNFl6KqFEQ--.10218S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1UuFyDWrWxJFWfGFy3Jwb_yoW7Jr15pa
	4IqF45tr4UAr1Uu3sFy3W8XFy8t3WYqrW7Wry3Gr15CwnIyrn3AF48ta15CFyDAFnrC3Wq
	vr4Uta4fArn8J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JU6c_fUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/18 16:07, Xiao Ni 写道:
> On Sun, Feb 18, 2024 at 2:22 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/02/18 13:07, Xiao Ni 写道:
>>> On Sun, Feb 18, 2024 at 11:24 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> 在 2024/02/18 11:15, Xiao Ni 写道:
>>>>> On Sun, Feb 18, 2024 at 10:34 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> 在 2024/02/18 10:27, Xiao Ni 写道:
>>>>>>> On Sun, Feb 18, 2024 at 9:46 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> 在 2024/02/18 9:33, Xiao Ni 写道:
>>>>>>>>> The deadlock problem mentioned in this patch should not be right?
>>>>>>>>
>>>>>>>> No, I think it's right. Looks like you are expecting other problems,
>>>>>>>> like mentioned in patch 6, to be fixed by this patch.
>>>>>>>
>>>>>>> Hi Kuai
>>>>>>>
>>>>>>> Could you explain why step1 and step2 from this comment can happen
>>>>>>> simultaneously? From the log, the process should be
>>>>>>> The process is :
>>>>>>> dev_remove->dm_destroy->__dm_destroy->dm_table_postsuspend_targets(raid_postsuspend)
>>>>>>> -> dm_table_destroy(raid_dtr).
>>>>>>> After suspending the array, it calls raid_dtr. So these two functions
>>>>>>> can't happen simultaneously.
>>>>>>
>>>>>> You're removing the target directly, however, dm can suspend the disk
>>>>>> directly, you can simplily:
>>>>>>
>>>>>> 1) dmsetup suspend xxx
>>>>>> 2) dmsetup remove xxx
>>>>>
>>>>> For dm-raid, the design of suspend stops sync thread first and then it
>>>>> calls mddev_suspend to suspend array. So I'm curious why the sync
>>>>> thread can still exit when array is suspended. I know the reason now.
>>>>> Because before f52f5c71f (md: fix stopping sync thread), the process
>>>>> is raid_postsuspend->md_stop_writes->__md_stop_writes
>>>>> (__md_stop_writes sets MD_RECOVERY_FROZEN). In patch f52f5c71f, it
>>>>> doesn't set MD_RECOVERY_FROZEN in __md_stop_writes anymore.
>>>>>
>>>>> The process changes to
>>>>> 1. raid_postsuspend->md_stop_writes->__md_stop_writes->stop_sync_thread
>>>>> (wait until MD_RECOVERY_RUNNING clears)
>>>>> 2. md thread -> md_check_recovery -> unregister_sync_thread ->
>>>>> md_reap_sync_thread (clears MD_RECOVERY_RUNNING, stop_sync_thread
>>>>> returns, md_reap_sync_thread sets MD_RECOVERY_NEEDED)
>>>>> 3. raid_postsuspend->mddev_suspend
>>>>> 4. md sync thread starts again because __md_stop_writes doesn't set
>>>>> MD_RECOVERY_FROZEN.
>>>>> It's the reason why we can see sync thread still happens when raid is suspended.
>>>>>
>>>>> So the patch fix this problem should:
>>>>
>>>> As I said, this is really a different problem from this patch, and it is
>>>> fixed seperately by patch 9. Please take a look at that patch.
>>>
>>> I think we're talking about the same problem. In patch07 it has a new
>>> api md_frozen_sync_thread. It sets MD_RECOVERY_FROZEN before
>>> stop_sync_thread. This is right. If we use this api in
>>> raid_postsuspend, sync thread can't restart. So the deadlock can't
>>> happen anymore?
>>
>> We are not talking about the same problem at all. This patch just fix a
>> simple problem in md/raid(not dm-raid). And the deadlock can also be
>> triggered for md/raid the same.
>>
>> - mddev_suspend() doesn't handle sync_thread at all;
>> - md_check_recovery() ignore suspended array;
>>
>> Please keep in mind this patch just fix the above case. The deadlock in
>> dm-raid is just an example of problems caused by this. Fix the deadlock
>> other way doesn't mean this case is fine.
> 
> Because this patch set is used to fix dm raid deadlocks. But this
> patch changes logic, it looks like more a feature - "we can start/stop
> sync thread when array is suspended". Because this patch is added many
> years ago and dm raid works well. If we change this, there is
> possibilities to introduce new problems. Now we should try to walk
> slowly.

This patch itself really is quite simple, it fixes problems for md/raid,
and can be triggered by dm-raid as well. This patch will be needed
regardless of dm-raid, and it's absolutely not a feature.

For dm-raid, there is no doubt that sync_thread should be stopped before
suspend, and keep frozen until resume, and this behaviour is not changed
at all and will never change. Other patches actually tries to gurantee
this. If you think this patch can introduce new problems for dm-raid,
please be more specific.

The problem in dm-raid is that it relies on __md_stop_writes() to stop
and frozen sync_thread, while it also relies that MD_RECOVERY_FROZEN is
not set, and this is abuse of MD_RECOVERY_FROZEN. And if you still think
there are problems with considering of the entire patchset, feel free to
discuss. :)

Thanks,
Kuai


