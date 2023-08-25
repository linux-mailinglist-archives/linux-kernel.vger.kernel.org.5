Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090C6788029
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbjHYGpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjHYGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:44:42 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06FACD5;
        Thu, 24 Aug 2023 23:44:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RX9RP0Fclz4f3jZg;
        Fri, 25 Aug 2023 14:44:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDHVqnPTehky60iBg--.23128S3;
        Fri, 25 Aug 2023 14:44:33 +0800 (CST)
Subject: Re: [PATCH -next v4 0/7] md: make rdev addition and removal
 independent from daemon thread
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
 <CAPhsuW4rQ1V7EHgfpfx9rL2=pUAcjr+Eint2iD0_EfVAbzcKOQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2832ee84-4365-d35d-1ae4-fa260a1beb9f@huaweicloud.com>
Date:   Fri, 25 Aug 2023 14:44:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4rQ1V7EHgfpfx9rL2=pUAcjr+Eint2iD0_EfVAbzcKOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHVqnPTehky60iBg--.23128S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw17CrW5WryUKryUCF1UGFg_yoW8uw17p3
        4aq3W3KrWDXFsrCr93Ja47W3s5Kws3XrZrJF9xWw1fCw15ur10vryxtF4kur90yrySkry2
        9r4rtF95C3WvyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_
        Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/25 14:39, Song Liu 写道:
> On Thu, Aug 24, 2023 at 8:20 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Changes in v4:
>>   - add some review tag;
>>   - add comments to make code more readadble for patch 4,6;
>>   - rework patch 7 a litter;
> 
> Applied v4 to md-next. But this set won't go into 6.6.
> 
Thanks! I'll work on rebasing the next huge patchset.

Kuai

> Thanks,
> Song
> 
>>
>> Changes in v3:
>>   - rename md_choose_sync_direction() to md_choose_sync_action() in patch 2;
>>   - fix an error in patch 3;
>>   - add flush_work(&mddev->sync_work) while change read-only array to
>>   read-write;
>>
>> Changes in v2:
>>   - remove patch 1 from v1 and some related patches, those patches will
>>   be sent later when rcu protection for rdev is removed.
>>   - add patch 2.
>>
>> This is the third patchset to do some preparatory work to synchronize
>> io with array reconfiguration.
>>
>> 1) The first patchset refactor 'active_io', make sure that mddev_suspend()
>> will wait for io to be done. [1]
>>
>> 2) The second patchset remove 'quiesce' callback from mddev_suspend(), so
>> that mddev_suspend() doesn't rely on 'quiesce' callback is registered,
>> and can be used for all personalites; [2]
>>
>> 3) This patchset make array reconfiguration independent from daemon thread,
>> and synchronize it with io will be much easier because io may rely on
>> daemon thread to be done.
>>
>> More patchset on the way!
>>
>> Yu Kuai (7):
>>    md: use separate work_struct for md_start_sync()
>>    md: factor out a helper to choose sync action from md_check_recovery()
>>    md: delay choosing sync action to md_start_sync()
>>    md: factor out a helper rdev_removeable() from remove_and_add_spares()
>>    md: factor out a helper rdev_is_spare() from remove_and_add_spares()
>>    md: factor out a helper rdev_addable() from remove_and_add_spares()
>>    md: delay remove_and_add_spares() for read only array to
>>      md_start_sync()
>>
>>   drivers/md/md.c | 308 +++++++++++++++++++++++++++++++++---------------
>>   drivers/md/md.h |   5 +-
>>   2 files changed, 218 insertions(+), 95 deletions(-)
>>
>> --
>> 2.39.2
>>
> .
> 

