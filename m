Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E02F7917B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347881AbjIDNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjIDNAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:00:19 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A63B90;
        Mon,  4 Sep 2023 06:00:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfTJB5BzZz4f3l7y;
        Mon,  4 Sep 2023 21:00:10 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgCXc6bX1PVkZC5lCQ--.16578S3;
        Mon, 04 Sep 2023 21:00:11 +0800 (CST)
Message-ID: <033cb727-35b5-3845-64b1-e698891d70b1@huaweicloud.com>
Date:   Mon, 4 Sep 2023 21:00:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20230810014848.2148316-1-linan666@huaweicloud.com>
 <ZONr0f26IT/QKsSu@x1-carbon>
 <f33816ef-ce26-1501-99b6-c75f91c6d8f5@huaweicloud.com>
 <ZOSONbLwc6RtQnS0@x1-carbon>
 <5d37add3-41ce-e2af-b45a-d701eaf36a6c@huaweicloud.com>
 <ZPXGM0YUPP4+n0Rz@x1-carbon>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <ZPXGM0YUPP4+n0Rz@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXc6bX1PVkZC5lCQ--.16578S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyUKr1rKrWkWw43ZrW3GFg_yoWrJFyrpF
        WUJa1qkr1DXrW8tr4qqa1F9F1Fqan7Kry7ZryDJ3s7Zr1qq34rtr1DCFZ8WFn29wn7Gw1I
        vw4jgr9rAFWUXrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
        AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07Al
        zVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
        VOJ7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/4 19:57, Niklas Cassel 写道:
> On Mon, Sep 04, 2023 at 07:45:51PM +0800, Li Nan wrote:
>>
>>
>> 在 2023/8/22 18:30, Niklas Cassel 写道:
>>> On Tue, Aug 22, 2023 at 05:20:33PM +0800, Li Nan wrote:
>>>> Thanks for your reply, Niklas.
>>>>
>>>> 在 2023/8/21 21:51, Niklas Cassel 写道:
>>>>> On Thu, Aug 10, 2023 at 09:48:48AM +0800, linan666@huaweicloud.com wrote:
>>>>
>>>> [snip]
>>>>
>>>>>
>>>>> Hello Li Nan,
>>>>>
>>>>> I do not understand why the code in:
>>>>> https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L722-L731
>>>>>
>>>>> does not kick in, and repeats EH.
>>>>>
>>>>>
>>>>> EH_PENDING is cleared before ->error_handler() is called:
>>>>> https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L697
>>>>>
>>>>> So ahci_error_intr() from the second error interrupt, which is called after
>>>>> thawing the port, should have called ata_std_sched_eh(), which calls
>>>>> ata_eh_set_pending(), which should have set EH_PENDING:
>>>>> https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L884
>>>>>
>>>>>
>>>>>
>>>>> My only guess is that after thawing the port:
>>>>> https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L2807
>>>>>
>>>>> The second error irq comes, and sets EH_PENDING,
>>>>> but then this silly code might clear it:
>>>>> https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L2825-L2837
>>>>>
>>>>
>>>> Yeah, I think so.
>>>>
>>>>> I think the best way would be if we could improve this "spurious error
>>>>> condition check"... because if this is indeed the code that clears EH_PENDING
>>>>> for you, then this code basically makes the "goto repeat" code in
>>>>> ata_scsi_port_error_handler() useless...
>>>>>
>>>>>
>>>>> An alternative to improving the "spurious error condition check" might be for
>>>>> you to try something like:
>>>>>
>>>>
>>>> We have used this solution before, but it will case WARN_ON in
>>>> ata_eh_finish() as below:
>>>>
>>>>     WARNING: CPU: 1 PID: 118 at ../drivers/ata/libata-eh.c:4016
>>>> ata_eh_finish+0x15a/0x170
>>>
>>> Ok.
>>>
>>> How about if you simply move the WARN_ON to ata_scsi_port_error_handler()
>>> as well:
>>>
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index 35e03679b0bf..5be2fc651131 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -741,6 +741,12 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
>>>                    */
>>>                   ap->ops->end_eh(ap);
>>> +               if (!ap->scsi_host->host_eh_scheduled) {
>>> +                       /* make sure nr_active_links is zero after EH */
>>> +                       WARN_ON(ap->nr_active_links);
>>> +                       ap->nr_active_links = 0;
>>> +               }
>>> +
>>>                   spin_unlock_irqrestore(ap->lock, flags);
>>>                   ata_eh_release(ap);
>>>           } else {
>>> @@ -962,7 +968,7 @@ void ata_std_end_eh(struct ata_port *ap)
>>>    {
>>>           struct Scsi_Host *host = ap->scsi_host;
>>> -       host->host_eh_scheduled = 0;
>>> +       host->host_eh_scheduled--;
>>>    }
>>>    EXPORT_SYMBOL(ata_std_end_eh);
>>> @@ -3948,10 +3954,6 @@ void ata_eh_finish(struct ata_port *ap)
>>>                           }
>>>                   }
>>>           }
>>> -
>>> -       /* make sure nr_active_links is zero after EH */
>>> -       WARN_ON(ap->nr_active_links);
>>> -       ap->nr_active_links = 0;
>>>    }
>>>    /**
>>>
>>>
>>>
>>> Kind regards,
>>> Niklas
>>
>> We have tested this patch and it can fix the bug. Thank you so much. :)
> 
> Awesome! :)
> 
> Please send out a real patch, so that it is easier for the maintainer to
> apply.
> 
> No need to give any credit to me.
> 
> 
> Kind regards,
> Niklas

It is my pleasure. I will send v2 later.

-- 
Thanks,
Nan

