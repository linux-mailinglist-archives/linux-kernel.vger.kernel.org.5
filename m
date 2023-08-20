Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA551781C2A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHTCpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjHTCpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:45:12 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3CB937CA;
        Sat, 19 Aug 2023 19:04:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RSzSR0BNfz4f3nwr;
        Sun, 20 Aug 2023 10:04:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH1qindOFkTviCBA--.17337S3;
        Sun, 20 Aug 2023 10:04:24 +0800 (CST)
Subject: Re: [PATCH -next v2 3/7] md: delay choosing sync direction to
 md_start_sync()
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
 <20230815030957.509535-4-yukuai1@huaweicloud.com>
 <CALTww2-LzW76_=vH+TKjZGzChrsz_JJKJxh1-+SCNZ9NHv0N2A@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <937878d9-7c43-a3e3-9208-d3ff1bb3df20@huaweicloud.com>
Date:   Sun, 20 Aug 2023 10:04:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww2-LzW76_=vH+TKjZGzChrsz_JJKJxh1-+SCNZ9NHv0N2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH1qindOFkTviCBA--.17337S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4fuF4kuryDKw45XF1rXrb_yoW5XF15pa
        y2qFn8Kw4DGr4xZFZF93Z7Wa48t3yUXF43Jr1fXF98A3s0yFWxuF1xG3yDuFWv9r97W3Wj
        vFn0gFZxZFy5CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/16 14:38, Xiao Ni 写道:
> On Tue, Aug 15, 2023 at 11:13 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Before this patch, for read-write array:
>>
>> 1) md_check_recover() found that something need to be done, and it'll
>>     try to grab 'reconfig_mutex'. The case that md_check_recover() need
>>     to do something:
>>     - array is not suspend;
>>     - super_block need to be updated;
>>     - 'MD_RECOVERY_NEEDED' or ''MD_RECOVERY_DONE' is set;
>>     - unusual case related to safemode;
>>
>> 2) if 'MD_RECOVERY_RUNNING' is not set, and 'MD_RECOVERY_NEEDED' is set,
>>     md_check_recover() will try to choose a sync direction, and then
>>     queue a work md_start_sync().
>>
>> 3) md_start_sync() register sync_thread;
>>
>> After this patch,
>>
>> 1) is the same;
>> 2) if 'MD_RECOVERY_RUNNING' is not set, and 'MD_RECOVERY_NEEDED' is set,
>>     queue a work md_start_sync() directly;
>> 3) md_start_sync() will try to choose a sync direction, and then
>>     register sync_thread();
>>
>> Because 'MD_RECOVERY_RUNNING' is cleared when sync_thread is done, 2)
>> and 3) is always ran in serial and they can never concurrent, this
>> change should not introduce any behavior change for now.
>>
>> Also fix a problem that md_start_sync() can clear 'MD_RECOVERY_RUNNING'
>> without protection in error path, which might affect the logical in
>> md_check_recovery().
>>
>> The advantage to change this is that array reconfiguration is
>> independent from daemon now, and it'll be much easier to synchronize it
>> with io, consider that io may rely on daemon thread to be done.
> 
> Hi Kuai
> 
> What's the meaning of "array reconfiguration" here? "mdadm -f/-r/-a"
> something like this, right?. Because before and after this patch, only
> one sync thread can be running, so If we don't do this change, are
> there bugs or performance problems?

As we discussed([1]), and explained in patch 0, the purpose of this
change is to prepare to synchronize io with array reconfiguration(add
or remove rdev from array, for example, modify
conf->mirrors[].rdev/replacement for raid10).

Without this change, normal io can rely on daemon thread, while daemone
thread can change array configuration. raid1/raid10 record such io as
'io_queued', and can use freeze_array() to do synchronization in daemon
thread. However, other personalities have to implement such logical as
well, and I found it quite complicated, at least for raid456.

[1] 
https://lore.kernel.org/all/cb390b39-1b1e-04e1-55ad-2ff8afc47e1b@huawei.com/

Thanks,
Kuai

> 
> If it's only a patch that wants to make md_check_recovery more clearer
> and easier, I'm good with this idea too.
> 

