Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6041B7DB61D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjJ3J1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJ3J06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:26:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB684C1;
        Mon, 30 Oct 2023 02:26:56 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SJnwC2dd1z4f3lXw;
        Mon, 30 Oct 2023 17:26:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 64E1B1A0171;
        Mon, 30 Oct 2023 17:26:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBn+djbdj9lI3ZoEQ--.33867S3;
        Mon, 30 Oct 2023 17:26:53 +0800 (CST)
Subject: Re: [PATCH] block: Fix minor range check in device_add_disk()
To:     zhongjinghua <zhongjinghua@huaweicloud.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231025084621.2338604-1-zhongjinghua@huaweicloud.com>
 <119b7314-10a9-4d62-b40f-19462dc68009@I-love.SAKURA.ne.jp>
 <26bafe93-345d-2696-8ee7-7d1baa0e7eb7@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <df52b8a2-dff1-3973-b2bf-ca915c3f44d3@huaweicloud.com>
Date:   Mon, 30 Oct 2023 17:26:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <26bafe93-345d-2696-8ee7-7d1baa0e7eb7@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn+djbdj9lI3ZoEQ--.33867S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr45urWrAw1DJF1UXw43KFg_yoW8Jr4Dpr
        W3ZFy5tF4DGr48uFsrJryFkr1rAw1jqrWrKF4xtryIgrZ0yFna9r9xtw45GFWxKryxKF4F
        gF45XFZFva1rta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/10/26 16:52, zhongjinghua 写道:
> 
> 在 2023/10/25 18:06, Tetsuo Handa 写道:
>> On 2023/10/25 17:46, Zhong Jinghua wrote:
>>> Checks added in patch:
>>> commit e338924bd05d ("block: check minor range in device_add_disk()")
>>> ignore the problem of first_minore < 0 and disk->minors < 0.
>> What is the problem of first_minor < 0 or disk->minors < 0 ?
>> Are negative values legal/illegal ?
> 
> These two values are used as the secondary device number and the maximum 
> number of partitions, which is illegal if negative. Then first_minore 
> and disk->minors are signed numbers, and the sum may be less than 
> MINORMASK to bypass the check.

Let me complement it, first_minor and minors can be set by driver, and
driver allow set them throuhh ioctl/sysfs from user parameters, for
example:

If user pass in -1, and each disk support 8 partitions, driver will
usually set:

disk->first_minor = -1 * 8 = -8;
disk->minors = 8;

Then first_minor + minors = 0, then the following condition can't detect
this case:

if (disk->first_minor + disk->minors > MINORMASK + 1)

By the way, we never limit how first_minor and minors is set by driver,
and it's illegal if driver set first_minor = -4, and minors = 8.

Thanks,
Kuai

> 
> .
> 

