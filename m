Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43F7AD3D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjIYIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjIYIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:55:02 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F31BE8;
        Mon, 25 Sep 2023 01:54:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RvGsP2PHVz4f3m7G;
        Mon, 25 Sep 2023 16:54:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgB3Dt7ZShFlAYZjBQ--.35145S3;
        Mon, 25 Sep 2023 16:54:51 +0800 (CST)
Subject: Re: [PATCH -next 0/2] md: fix potential hang for mddev_suspend()
To:     Xiao Ni <xni@redhat.com>, Song Liu <song@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230830092902.1236950-1-yukuai1@huaweicloud.com>
 <CAPhsuW4QNwL3+AXk8_ZNwgSAZj9k6Ce=tPmz9xPHwC+BjT=Dcg@mail.gmail.com>
 <CALTww28+gk4upte4wo=VBJxYCJxr2i1hdcwy+OwNHY1PqaCqVg@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aa13ca78-72b1-699a-5179-85fbc3a3c219@huaweicloud.com>
Date:   Mon, 25 Sep 2023 16:54:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww28+gk4upte4wo=VBJxYCJxr2i1hdcwy+OwNHY1PqaCqVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3Dt7ZShFlAYZjBQ--.35145S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr45GF4UAFyxAr43uFyxAFb_yoWfJwb_JF
        4UCr97Gw1UJ3W0qa4Durn0v3yq9ay5Gr43Ja4Utry2v3s8JrWUJFs5K395Xr13JFW8tFn8
        Ar4kZa40yr13WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/09/25 15:58, Xiao Ni 写道:
> On Sat, Sep 23, 2023 at 5:33 AM Song Liu <song@kernel.org> wrote:
>>
>> On Wed, Aug 30, 2023 at 2:33 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Yu Kuai (2):
>>>    md: factor out helpers to grab and put 'active_io'
>>>    md: fix potential hang for mddev_suspend()
>>
>> Applied to md-next. Thanks!
>>
>> Song
>>
>>>
>>>   drivers/md/md.c | 36 ++++++++++++++++++++++++++++++------
>>>   1 file changed, 30 insertions(+), 6 deletions(-)
>>>
>>> --
>>> 2.39.2
>>>
>>
> 
> Hi all
> 
> For the second patch, active_io_release does this job. So it doesn't
> need to do this in md_array_exit again.

Yes, this is correct, I missed this while reviewing related code.

Song, can you revert this patchset for now? Sorry for the trouble.

Thanks,
Kuai

> 
> Best Regards
> Xiao
> 
> .
> 

