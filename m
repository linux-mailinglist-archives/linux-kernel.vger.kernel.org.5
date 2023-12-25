Return-Path: <linux-kernel+bounces-10856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E311281DD70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 02:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598781F215C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 01:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A29804;
	Mon, 25 Dec 2023 01:35:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B663C;
	Mon, 25 Dec 2023 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sz0pK2S81z4f3lCx;
	Mon, 25 Dec 2023 09:35:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AB9081A0198;
	Mon, 25 Dec 2023 09:35:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgC3uA5c3Ihl8Ss5Eg--.37786S3;
	Mon, 25 Dec 2023 09:35:26 +0800 (CST)
Subject: Re: [PATCH 1/2] md: fix WARN_ON if create symlink fail in
 bind_rdev_to_array()
To: Song Liu <song@kernel.org>, Li Nan <linan666@huaweicloud.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231221071109.1562530-1-linan666@huaweicloud.com>
 <20231221071109.1562530-2-linan666@huaweicloud.com>
 <CAPhsuW5SPiy5bsSfagYrSLa3JTn2Gw0VJKUToS2PS9h4w2=zSA@mail.gmail.com>
 <d00e6729-6e13-b1ab-0991-ce79b1245cfd@huaweicloud.com>
 <CAPhsuW6CBdM=8kmZDwQ2Ko4rN3cAW6z0=LpAOc+_t--FJZO9KQ@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3cf95141-0cdb-9e67-16a9-4c64b3251885@huaweicloud.com>
Date: Mon, 25 Dec 2023 09:35:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6CBdM=8kmZDwQ2Ko4rN3cAW6z0=LpAOc+_t--FJZO9KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3uA5c3Ihl8Ss5Eg--.37786S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4DJw4rCr4fXFW5Kr4kJFb_yoW8uFW3pF
	WrKF1YywsrJw1Uua1jqayYkw1Yqr17tFWUXFy3C34Ivr9xtrsIyr4xGF9ruFy5Xrn0kF4j
	qw1UGayxuayvkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2023/12/25 9:11, Song Liu 写道:
> On Thu, Dec 21, 2023 at 5:17 PM Li Nan <linan666@huaweicloud.com> wrote:
>>
>>
>>
>> 在 2023/12/22 2:58, Song Liu 写道:
> [...]
>>> In general, I would like to avoid adding flags if possible.
>>>
>>
>> This flag is mainly used to fix deadlock in next patch. Or should we
>> export bd_find_holder_disk()? Link hodler if it return NULL.
>> just like:
>>
>>     rdev_for_each_rcu
>>       if (!bd_find_holder_disk)
>>         bd_link_disk_holder
> 
> I was thinking we will not need the flag if we fail bind_rdev_to_array()
> on error (below).
> 
>>
>>
>>>>    };
>>>>
>>>>    static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
>>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>>> index e05858653a41..d6612b922c76 100644
>>>> --- a/drivers/md/md.c
>>>> +++ b/drivers/md/md.c
>>>> @@ -2526,7 +2526,8 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
>>>>                   sysfs_get_dirent_safe(rdev->kobj.sd, "bad_blocks");
>>>>
>>>>           list_add_rcu(&rdev->same_set, &mddev->disks);
>>>> -       bd_link_disk_holder(rdev->bdev, mddev->gendisk);
>>>> +       if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
>>>> +               set_bit(SymlinkCreated, &rdev->flags);
>>>
>>> Shall we just fail bind_rdev_to_array() if bd_link_disk_holder()
>>> returns non-zero?
>>>
>>
>> I keep this action because of commit 00bcb4ac7ee7 ("md: reduce
>> dependence on sysfs."). Fail bind_rdev_to_array is good to me.
> 
> I wonder whether the assumption in 00bcb4ac7ee7 is still true. If
> bd_link_disk_holder() fails for valid reasons, we need to handle it
> properly (set a flag, check the flag on unlink, etc.). If we only fail
> bd_link_disk_holder() on extreme cases (ENOMEM, etc.), we can
> just fail bind_rdev_to_array().

I totally agree! Currently, bd_link_disk_holder() from md won't return
-EINVAL, it will return -ENOMEM or -ENODEV if underlying disk is
deleted, which means bind_rdev_to_array() should fail as well.

The only problem is that this will make next patch more complicated, but
I think this can be solved.

Thanks,
Kuai
> 
> Thanks,
> Song
> .
> 


