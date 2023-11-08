Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC747E51CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjKHIR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjKHIR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:17:56 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232CA1A7;
        Wed,  8 Nov 2023 00:17:54 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SQHyM34msz4f3jLg;
        Wed,  8 Nov 2023 16:17:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 3664E1A0173;
        Wed,  8 Nov 2023 16:17:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgBHShAtREtl+GFrAQ--.5290S3;
        Wed, 08 Nov 2023 16:17:51 +0800 (CST)
Subject: Re: [PATCH] blk-core: use pr_warn_ratelimited() in bio_check_ro()
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231107111247.2157820-1-yukuai1@huaweicloud.com>
 <20231108071655.GA4875@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <af6d7fca-3581-e491-924a-9a3a838ed0d0@huaweicloud.com>
Date:   Wed, 8 Nov 2023 16:17:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20231108071655.GA4875@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHShAtREtl+GFrAQ--.5290S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtry3tr45ArWxKF15WF18Grg_yoWkKFbEva
        93Ca97Jwnrt3Z3tan8KFn8XrWkta1IkFWDJr1xXFs5WryxZr93uF4kWa95uFZxWF4rtrn7
        C3s2qrWft3s09jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG
        8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
        U==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/11/08 15:16, Christoph Hellwig Ð´µÀ:
> On Tue, Nov 07, 2023 at 07:12:47PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> If one of the underlying disks of raid or dm is set to read-only, then
>> each io will generate new log, which will cause message storm. This
>> environment is indeed problematic, however we can't make sure our
>> naive custormer won't do this, hence use pr_warn_ratelimited() to
>> prevent message storm in this case.
> 
> Reducing the log spam sounds good, and I guess the single warning
> would be even better.

Got it.

Jens, I see that you already apply this version, do you want me to send
a new version to generate single warning for each block_device?
> 
> That being said, why/how is the underlying device set to read-only?
> If there is a good reason we should probably add a holder op to tell
> the user about it so that it stop sending writes.
> 
Our custormer use blockdev --getro to underlying device directly,
they're trying to forbid other users to write underlying device, so
in this case I think set underlying device to read-only is not okay
because it's already write opened, however I'm not sure if we want the
ioctl to fail.

Thanks,
Kuai
> 
> .
> 

