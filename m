Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAA880C285
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjLKH7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjLKH7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:59:39 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38BD5;
        Sun, 10 Dec 2023 23:59:45 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpZ0F42GCz4f3k5x;
        Mon, 11 Dec 2023 15:59:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
        by mail.maildlp.com (Postfix) with ESMTP id B6FBF1A09F8;
        Mon, 11 Dec 2023 15:59:42 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP2 (Coremail) with SMTP id Syh0CgDnP05rwXZljFDDDQ--.46165S3;
        Mon, 11 Dec 2023 15:59:42 +0800 (CST)
Message-ID: <95b13a5c-7926-9c8f-8836-85aa3ab6c620@huaweicloud.com>
Date:   Mon, 11 Dec 2023 15:59:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] md: factor out a helper exceed_read_errors() to check
 read_errors
To:     Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
References: <20231204070327.3150356-1-linan666@huaweicloud.com>
 <20231204070327.3150356-2-linan666@huaweicloud.com>
 <CAPhsuW6Zr-ztojUtf9=g8Tj0pyS9cHLY0hnoJ85mFcSEZaAY3Q@mail.gmail.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAPhsuW6Zr-ztojUtf9=g8Tj0pyS9cHLY0hnoJ85mFcSEZaAY3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnP05rwXZljFDDDQ--.46165S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF18GryrKr1ruFy8tFWkJFb_yoW5XF1kpa
        1DAas8Wr4UGay5Ca4DXryq9a4Fywn5KrWUtrW8Gw43X3ZrZr98JayUWayjgr1kWr1fta4a
        qrW5GrZrC3WUKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/12/9 2:38, Song Liu 写道:
> On Sun, Dec 3, 2023 at 11:04 PM <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> Move check_decay_read_errors() to raid1-10.c and factor out a helper
>> exceed_read_errors() to check if read_errors exceeds the limit, so that
>> raid1 can also use it. There are no functional changes.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
> [...]
>> +static inline bool exceed_read_errors(struct mddev *mddev, struct md_rdev *rdev)
>> +{
>> +       int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
>> +       int read_errors;
>> +
>> +       check_decay_read_errors(mddev, rdev);
>> +       read_errors =  atomic_inc_return(&rdev->read_errors);
>> +       if (read_errors > max_read_errors) {
>> +               pr_notice("md:%s: %pg: Raid device exceeded read_error threshold [cur %d:max %d]\n",
>> +                         mdname(mddev), rdev->bdev, read_errors, max_read_errors);
>> +               pr_notice("md:%s: %pg: Failing raid device\n",
>> +                         mdname(mddev), rdev->bdev);
> 
> This changed the print message from "md/raid10:" to "md:". We should
> try to avoid
> such changes. How about we do something like the following?
> 
> Thanks,
> Song
> 
> diff --git i/drivers/md/raid1-10.c w/drivers/md/raid1-10.c
> index 3f22edec70e7..6c0ef0fe6ba7 100644
> --- i/drivers/md/raid1-10.c
> +++ w/drivers/md/raid1-10.c
> @@ -173,3 +173,10 @@ static inline void
> raid1_prepare_flush_writes(struct bitmap *bitmap)
>          else
>                  md_bitmap_unplug(bitmap);
>   }
> +
> +static inline bool exceed_read_errors(struct mddev *mddev, struct
> md_rdev *rdev)
> +{
> +       pr_notice("md/" RAID_1_10_NAME ":%s: %pg: Raid device ...\n",
> +                 ...);
> +       ...
> +}
> diff --git i/drivers/md/raid1.c w/drivers/md/raid1.c
> index 9348f1709512..412e98d02a05 100644
> --- i/drivers/md/raid1.c
> +++ w/drivers/md/raid1.c
> @@ -49,6 +49,7 @@ static void lower_barrier(struct r1conf *conf,
> sector_t sector_nr);
>   #define raid1_log(md, fmt, args...)                            \
>          do { if ((md)->queue) blk_add_trace_msg((md)->queue, "raid1 "
> fmt, ##args); } while (0)
> 
> +#define RAID_1_10_NAME "raid1"
>   #include "raid1-10.c"
> 
>   #define START(node) ((node)->start)
> diff --git i/drivers/md/raid10.c w/drivers/md/raid10.c
> index 375c11d6159f..a1531b5f15e3 100644
> --- i/drivers/md/raid10.c
> +++ w/drivers/md/raid10.c
> @@ -77,6 +77,8 @@ static void end_reshape(struct r10conf *conf);
>   #define raid10_log(md, fmt, args...)                           \
>          do { if ((md)->queue) blk_add_trace_msg((md)->queue, "raid10 "
> fmt, ##args); } while (0)
> 
> +#define RAID_1_10_NAME "raid10"
> +
>   #include "raid1-10.c"
> 
>   #define NULL_CMD
> 
> [...]
> 
> .

I agree. Let me improve this in v2.


-- 
Thanks,
Nan

