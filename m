Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD07807DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442969AbjLGBeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjLGBeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:34:10 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F40ED5A;
        Wed,  6 Dec 2023 17:34:13 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Slxd961Hfz4f3lfY;
        Thu,  7 Dec 2023 09:34:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 92BDA1A0D77;
        Thu,  7 Dec 2023 09:34:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDX2hARIXFlMOPLCw--.6613S3;
        Thu, 07 Dec 2023 09:34:10 +0800 (CST)
Subject: Re: [PATCH -next] md: split MD_RECOVERY_NEEDED out of mddev_resume
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        dm-devel@lists.linux.dev, janpieter.sollie@edpnet.be,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231204031703.3102254-1-yukuai1@huaweicloud.com>
 <CAPhsuW4sF=jAyA+Q=2tFBBAApjcW=gWXndDNX6t3nrAfnk_zZA@mail.gmail.com>
 <269ac5cb-aa09-02ca-4150-c90cd5a72e06@huaweicloud.com>
 <CAPhsuW7US8f7gR+Eo=hYU0RF+L8YkF6ebiWG+FDO6frAxoBarw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3befdaea-9365-b28e-b8f0-f70c33a1a79a@huaweicloud.com>
Date:   Thu, 7 Dec 2023 09:34:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7US8f7gR+Eo=hYU0RF+L8YkF6ebiWG+FDO6frAxoBarw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2hARIXFlMOPLCw--.6613S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy3KF48WryxZw4fGF4fGrg_yoW8uw15p3
        yjqF4rKF4Duw1fArZF9wn7Ka9Yy3yxKr4rWr9xWF13C34qk34fKF13Wrn0gFWDtryfK3W7
        tr4qka97AFy5trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/12/07 1:24, Song Liu 写道:
> On Wed, Dec 6, 2023 at 3:36 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/12/06 16:30, Song Liu 写道:
>>> On Sun, Dec 3, 2023 at 7:18 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> New mddev_resume() calls are added to synchroniza IO with array
>>>> reconfiguration, however, this introduce a regression while adding it in
>>>> md_start_sync():
>>>>
>>>> 1) someone set MD_RECOVERY_NEEDED first;
>>>> 2) daemon thread grab reconfig_mutex, then clear MD_RECOVERY_NEEDED and
>>>>      queue a new sync work;
>>>> 3) daemon thread release reconfig_mutex;
>>>> 4) in md_start_sync
>>>>      a) check that there are spares that can be added/removed, then suspend
>>>>         the array;
>>>>      b) remove_and_add_spares may not be called, or called without really
>>>>         add/remove spares;
>>>>      c) resume the array, then set MD_RECOVERY_NEEDED again!
>>>>
>>>> Loop between 2 - 4, then mddev_suspend() will be called quite often, for
>>>> consequence, normal IO will be quite slow.
>>>>
>>>> Fix this problem by spliting MD_RECOVERY_NEEDED out of mddev_resume(), so
>>>> that md_start_sync() won't set such flag and hence the loop will be broken.
>>>
>>> I hope we don't leak set_bit MD_RECOVERY_NEEDED to all call
>>> sites of mddev_resume().
>>
>> There are also some other mddev_resume() that is added later and don't
>> need recovery, so md_start_sync() is not the only place:
>>
>>    - md_setup_drive
>>    - rdev_attr_store
>>    - suspend_lo_store
>>    - suspend_hi_store
>>    - autorun_devices
>>    - md_ioct
>>    - r5c_disable_writeback_async
>>    - error path from new_dev_store(), ...
>>
>> I'm not sure add a new helper is a good idea, because all above apis
>> should use new helper as well.
> 
> I think for most of these call sites, it is OK to set MD_RECOVERY_NEEDED
> (although it is not needed), and md_start_sync() is the only one that may
> trigger "loop between 2 - 4" scenario. Did I miss something?

Yes, it's the only problematic one. I'll send v2.

Thanks,
Kuai

> 
> It is already rc4, so we need to send the fix soon.
> 
> Thanks,
> Song
> .
> 

