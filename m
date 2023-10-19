Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046C97CED1F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjJSBEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJSBEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:04:46 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AC0B8;
        Wed, 18 Oct 2023 18:04:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S9qHn2L6nz4f3lVL;
        Thu, 19 Oct 2023 09:04:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd2mgDBlIodZDQ--.31071S3;
        Thu, 19 Oct 2023 09:04:40 +0800 (CST)
Subject: Re: [PATCH -next 0/6] md: remvoe rcu protection to access rdev from
 conf
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231016092439.493646-1-yukuai1@huaweicloud.com>
 <CAPhsuW6vE7O1uPXnC3yrUT4maghKdx+E0odqF7UxP5esgBC=2A@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d330b1f1-fd72-554c-f25c-dd9c347d8dd1@huaweicloud.com>
Date:   Thu, 19 Oct 2023 09:04:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6vE7O1uPXnC3yrUT4maghKdx+E0odqF7UxP5esgBC=2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd2mgDBlIodZDQ--.31071S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy7KFy7XFyfCF45Zr47Arb_yoW8Jw4kpw
        nxJay3uw4rCr17Ja9rZ3yUKFy5GF1xJryUJr17Aw18Xa4jvFyUXF47try8ur98AFWftay7
        KFy5Gas8GF1Fy3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/10/19 1:58, Song Liu 写道:
> On Sun, Oct 15, 2023 at 6:28 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Yu Kuai (6):
>>    md: remove useless debug code to print configuration
>>    md: remove flag RemoveSynchronized
>>    md/raid1: remove rcu protection to access rdev from conf
>>    md/raid10: remove rcu protection to access rdev from conf
>>    md/raid5: remove rcu protection to access rdev from conf
>>    md/md-multipath: remove rcu protection to access rdev from conf
> 
> While a cover letter is highly recommended for a patchset. An empty
> cover letter like this doesn't really add value. If the description of each
> patch is clear enough, it is OK to not have a cover-letter.

Yes, I was hoping commit message in each patch is clear enough,I'll try
to explain everything more detailed.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
>>
>>   drivers/md/md-multipath.c |  29 ++---
>>   drivers/md/md.c           |  37 +-----
>>   drivers/md/raid1.c        |  94 ++++-----------
>>   drivers/md/raid10.c       | 248 +++++++++-----------------------------
>>   drivers/md/raid5-cache.c  |  11 +-
>>   drivers/md/raid5-ppl.c    |  16 +--
>>   drivers/md/raid5.c        | 225 ++++++++++------------------------
>>   drivers/md/raid5.h        |   4 +-
>>   8 files changed, 163 insertions(+), 501 deletions(-)
>>
>> --
>> 2.39.2
>>
> .
> 

