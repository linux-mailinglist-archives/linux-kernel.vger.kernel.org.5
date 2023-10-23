Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CD27D2B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjJWH0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWH0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:26:53 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB739D6;
        Mon, 23 Oct 2023 00:26:50 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SDRZm4TV8z4f3kGC;
        Mon, 23 Oct 2023 15:26:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 5DA941A0171;
        Mon, 23 Oct 2023 15:26:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBn+dg0IDZlt0TeDg--.38637S3;
        Mon, 23 Oct 2023 15:26:46 +0800 (CST)
Subject: Re: [PATCH RFC v2 0/8] blk-mq: improve tag fair sharing
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
 <ZTX4q7QBerKbjzQA@fedora>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <40652bee-4086-1b32-b840-1f9a3adfe358@huaweicloud.com>
Date:   Mon, 23 Oct 2023 15:26:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZTX4q7QBerKbjzQA@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn+dg0IDZlt0TeDg--.38637S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW5Cw1rXFWUWw47KFWfXwb_yoW8WF47pF
        WSqF47tws2vw42kFWDX39xGFyfKr4kGry5Kr97G347Zws8urnagr4xtr45uFZ7AF1DGrWU
        urWq9rZ8CFyDX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/10/23 12:38, Ming Lei Ð´µÀ:
> Hello Yu Kuai,
> 
> On Sat, Oct 21, 2023 at 11:47:58PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Current implementation:
>>   - a counter active_queues record how many queue/hctx is sharing tags,
>>   and it's updated while issue new IO, and cleared in
>>   blk_mq_timeout_work().
>>   - if active_queues is more than 1, then tags is fair shared to each
>>   node;
> 
> Can you explain a bit what the problem is in current tag sharing?
> And what is your basic approach for this problem?
> 
> Just mentioning the implementation is not too helpful for initial
> review, cause the problem and approach(correctness) need to be
> understood first.

Of course, I'll add following if there will be a v3;

Current problems:

If there are multiple active_queues, then tag is fair shared to each
queue, and if one queue is not busy(for example, only issue one IO once
for a while), then shared tags for this queue is wasted and can't be
used for other queues.

Depends on the hardware, this might casue performance problems in some
user case. For example, as reported by [1], UFS devices
have multiple logical units. One of these logical units (WLUN) is used
to submit control commands, e.g. START STOP UNIT. If any request is
submitted to the WLUN, the queue depth is reduced from 31 to 15 or
lower for data LUNs.

This patchset first delay tag sharing from issue IO to failed to get
driver tag; then add a counter to record how many times shared queue
failed to get driver tag to indicate if the queue is busy; finially,
allow busy queue to borrow more tags from idle queue.

Thanks,
Kuai

> 
> Thanks,
> Ming
> 
> .
> 

