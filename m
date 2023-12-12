Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA20880E2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345858AbjLLDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345805AbjLLDV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:21:29 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A086BBA;
        Mon, 11 Dec 2023 19:21:35 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sq3mk5M0Yz4f3l1W;
        Tue, 12 Dec 2023 11:21:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id A70151A055E;
        Tue, 12 Dec 2023 11:21:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgBHShC40XdlxCalDQ--.54352S3;
        Tue, 12 Dec 2023 11:21:30 +0800 (CST)
Subject: Re: [PATCH] md: Don't clear MD_CLOSING when the raid is about to stop
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linan666@huaweicloud.com
Cc:     song@kernel.org, zlliu@suse.com, neilb@suse.com, shli@fb.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231211081714.1923567-1-linan666@huaweicloud.com>
 <20231211105620.00001753@linux.intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f0ab24e5-eb0a-d564-19d4-b72ecedff34f@huaweicloud.com>
Date:   Tue, 12 Dec 2023 11:21:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20231211105620.00001753@linux.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHShC40XdlxCalDQ--.54352S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF17XryfGw45Gw48Kw1fXrb_yoW8uFWfpa
        yxXF1ayan0y3W8Cw42qw18GFyFqwn3trWDtFyIkFn5Aa45ZFyUGr4Sga90gF4DWFWfKF4j
        g3W7J3WDX3Wvg37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/12/11 17:56, Mariusz Tkaczyk Ð´µÀ:
> On Mon, 11 Dec 2023 16:17:14 +0800
> linan666@huaweicloud.com wrote:
> 
>> From: Li Nan <linan122@huawei.com>
>>
>> The raid should not be opened anymore when it is about to be stopped.
>> However, other processes can open it again if the flag MD_CLOSING is
>> cleared before exiting. From now on, this flag will not be cleared when
>> the raid will be stopped.
>>
>> Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called
>> md_set_readonly or do_md_stop") Signed-off-by: Li Nan <linan122@huawei.com>
> 
> Hello Li Nan,
> I was there when I needed to fix this:
> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=md-next&id=c8870379a21fbd9ad14ca36204ccfbe9d25def43
> 
> For sure, you have to consider applying same solution for array_store "clear".
> Minor nit below.
> 
> Thanks,
> Mariusz
> 
>> ---
>>   drivers/md/md.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 4e9fe5cbeedc..ebdfc9068a60 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -6238,7 +6238,6 @@ static void md_clean(struct mddev *mddev)
>>   	mddev->persistent = 0;
>>   	mddev->level = LEVEL_NONE;
>>   	mddev->clevel[0] = 0;
>> -	mddev->flags = 0;
> 
> I recommend (safety recommendation):
> 	mddev->flags = MD_CLOSING;

Taking a look I think both MD_CLOSING and MD_DELETED should not be
cleared, however, there is no guarantee that MD_CLOSING will be set
before md_clean, because mdadm can be removed without running. Hence I
think just set MD_CLOSING is werid.

I think the proper way is to keep MD_CLOSING and MD_DELETED if they are
set. However, there is no such api to clear other bits at once. Since
we're not expecting anyone else to write flags, following maybe
acceptable:

mddev->flags &= BIT_ULL_MASK(MD_CLOSING) | BIT_ULL_MASK(MD_DELETED);

Or after making sure other flags cannot race, this patch is ok.

Thanks,
Kuai

> 
> Unless you can prove that other flags cannot race.
> 
>>   	mddev->sb_flags = 0;
>>   	mddev->ro = MD_RDWR;
>>   	mddev->metadata_type[0] = 0;
> 
> .
> 

