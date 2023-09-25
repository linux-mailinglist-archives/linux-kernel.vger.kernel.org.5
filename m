Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784947ACD67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjIYBHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIYBHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:07:18 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13956C4;
        Sun, 24 Sep 2023 18:07:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rv4Tg10FLz4f3kGF;
        Mon, 25 Sep 2023 09:07:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd063RBlXnxIBQ--.63700S3;
        Mon, 25 Sep 2023 09:07:07 +0800 (CST)
Subject: Re: [PATCH -next] md: simplify md_seq_ops
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230911065010.3530461-1-yukuai1@huaweicloud.com>
 <20230911160540.0000060e@linux.intel.com>
 <b2754d8e-dfe7-ffff-66ac-052f366530e4@huaweicloud.com>
 <CAPhsuW59JAy7q2B1DeCbKGVAap4pOrfXuyzs9T9KOnaM-4VSdA@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d4f63e49-b5a9-3972-4232-94ffe10ceb2d@huaweicloud.com>
Date:   Mon, 25 Sep 2023 09:07:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW59JAy7q2B1DeCbKGVAap4pOrfXuyzs9T9KOnaM-4VSdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3jd063RBlXnxIBQ--.63700S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1fWrW8Cr4UGr4fGF1DGFg_yoW8Wr1DpF
        Z8XFZYyr4UZry8Xws2qw4q9rn3tws7WrZ3Wrn3G3y3J34qqr93A3W3X3W7uFykZr4fGrn0
        vw4qgr9xGrWrCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/09/23 5:22, Song Liu 写道:
> On Mon, Sep 11, 2023 at 6:02 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
> [...]
>>>> +static void *md_seq_start(struct seq_file *seq, loff_t *pos)
>>>> +{
>>>> +    struct md_personality *pers;
>>>> +
>>>> +    seq_puts(seq, "Personalities : ");
>>>> +    spin_lock(&pers_lock);
>>>> +    list_for_each_entry(pers, &pers_list, list)
>>>> +            seq_printf(seq, "[%s] ", pers->name);
>>>> +
>>>> +    spin_unlock(&pers_lock);
>>>> +    seq_puts(seq, "\n");
>>>> +    seq->poll_event = atomic_read(&md_event_count);
>>>> +
>>>> +    spin_lock(&all_mddevs_lock);
>>>
>>> I would prefer to increase "active" instead holding lock when enumerating over
>>> the devices. the main reason is that parsing mdstat is implemented in mdadm, so
>>> it could kind of blocker action- for example mdmon follows mdstat so it is read
>>> frequently. The time of getting other actions done can highly increase because
>>> every open or sysfs_read/write requires this lock.
> 
> Existing code holds pers_lock can seq_printf() in md_seq_show(). Do we see
> issues with this?

before this patch, in each loop:
- hold lock, get mddev, drop lock
- md_seq_show

and after this patch:
- hold lock in start, drop lock in stop
- lock is always held in each loop

And mariusz is concerned that lock time is increased and may cause some
performance regression.

We've discussed in slack, and decided to keep this behaviour. I'll
update this in v2.

Thanks,
Kuai

> 
> Hi Kuai,
> 
> This patch doesn't apply cleanly to md-next now. Please rebase and send v2.
> 
> Thanks,
> Song
> .
> 

