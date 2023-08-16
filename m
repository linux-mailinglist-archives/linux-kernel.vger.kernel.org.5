Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3477DCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbjHPIys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbjHPIyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:54:39 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0403610C8;
        Wed, 16 Aug 2023 01:54:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RQhlW1Tnjz4f3jXm;
        Wed, 16 Aug 2023 16:54:31 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgCXc6bEjtxkxHNZAw--.11704S3;
        Wed, 16 Aug 2023 16:54:32 +0800 (CST)
Message-ID: <6042c46d-72f1-6480-032d-1670916a734e@huaweicloud.com>
Date:   Wed, 16 Aug 2023 16:54:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/4] block/badblocks: fix badblocks setting error
To:     axboe@kernel.dk, vishal.l.verma@intel.com,
        dan.j.williams@intel.com, ashok_raj@linux.intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
References: <20230626080913.3493135-1-linan666@huaweicloud.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20230626080913.3493135-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXc6bEjtxkxHNZAw--.11704S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKryxKw13ZF4rZF13GF1kGrg_yoWktFc_u3
        yIyFyrGr4kXayfAay3tF15XrWIyF4UCr10kFyDtr4Sqr17tF4Utws5JrWDXwnxWF4kWwn8
        Z3s5XryfXw1IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbakYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
        AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3
        Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
        IYCTnIWIevJa73UjIFyTuYvjxUFfHjUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.

在 2023/6/26 16:09, linan666@huaweicloud.com 写道:
> From: Li Nan <linan122@huawei.com>
> 
> This patch series fixes some simple bugs of setting badblocks and
> optimizing struct badblocks. Coly Li has been trying to refactor badblocks
> in patch series "badblocks improvement for multiple bad block ranges"
> (https://lore.kernel.org/all/20220721121152.4180-1-colyli@suse.de). but the
> workload is significant. Before that, I will fix some easily triggered
> issues and optimize some code that does not conflict with Coly's changes.
> 
> Changes in v4:
>   - patch 1, remove the part of reorder fields
>   - patch 3/4, improve commit log.
> 
> Changes in v3:
>   - delete patchs with significant changes.
> 
> Li Nan (4):
>    block/badblocks: change some members of badblocks to bool
>    block/badblocks: only set bb->changed/unacked_exist when badblocks
>      changes
>    block/badblocks: fix badblocks loss when badblocks combine
>    block/badblocks: fix the bug of reverse order
> 
>   include/linux/badblocks.h |  9 +++++----
>   block/badblocks.c         | 38 ++++++++++++++++++++++----------------
>   2 files changed, 27 insertions(+), 20 deletions(-)
> 

-- 
Thanks,
Nan

