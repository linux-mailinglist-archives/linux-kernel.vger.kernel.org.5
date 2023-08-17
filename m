Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649BE77F16A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348589AbjHQHm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348618AbjHQHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:42:07 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668372D79;
        Thu, 17 Aug 2023 00:42:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RRH5K5ft5z4f3wtJ;
        Thu, 17 Aug 2023 15:41:57 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgD3hqlDz91k0bGlAw--.54630S3;
        Thu, 17 Aug 2023 15:41:58 +0800 (CST)
Message-ID: <acc72614-74bb-0230-a319-8b8d08c19ba5@huaweicloud.com>
Date:   Thu, 17 Aug 2023 15:41:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com, jianghong011@huawei.com,
        zhangcheng75@huawei.com, kangfenglong@huawei.com,
        yangxingui@huawei.com
References: <20230810014848.2148316-1-linan666@huaweicloud.com>
 <25c1aca7-d885-0fff-2639-bb68a7dff44f@kernel.org>
 <c2ae28b7-a105-9cd6-bf2e-63051a4000b0@huaweicloud.com>
 <eb135aff-dc33-d559-1826-9284a22c095a@kernel.org>
 <977879af-8603-82ae-07ad-38be3a27194d@huaweicloud.com>
 <611dfd5e-33b7-12ad-5902-ad20edf3b02e@kernel.org>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <611dfd5e-33b7-12ad-5902-ad20edf3b02e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3hqlDz91k0bGlAw--.54630S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr45Cry8Jr1fKFyrAFy8Grg_yoWrKrykpF
        Z5X3WqkFWDKFW0yw4Iv3W5ZFy0kr4fAFWjgF98J34xXryDtF1ftrW2kryq9Fy29ryYk34j
        qr4jg393AF1rZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E
        8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Zr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07UCXd8UUUUU=
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



在 2023/8/15 10:41, Damien Le Moal 写道:
> On 8/14/23 22:20, Li Nan wrote:
>>
>> 在 2023/8/14 15:50, Damien Le Moal 写道:
>>> On 8/14/23 15:41, Li Nan wrote:
>>>>> This is definitely not correct because EH may have been scheduled for a non
>>>>> fatal action like a device revalidate or to get sense data for successful
>>>>> commands. With this change, the port will NOT be frozen when a hard error IRQ
>>>>> comes while EH is waiting to start, that is, while EH waits for all commands to
>>>>> complete first.
>>>>>
>>>>
>>>> Yeah, we should find a better way to fix it. Do you have any suggesstions?
>>>>
>>>>> Furthermore, if you get an IRQ that requires the port to be frozen, it means
>>>>> that you had a failed command. In that case, the drive is in error state per
>>>>> ATA specs and stops all communication until a read log 10h command is issued.
>>>>> So you should never ever see 2 error IRQs one after the other. If you do, it
>>>>> very likely means that you have buggy hardware.
>>>>>
>>>>> How do you get into this situation ? What adapter and disk are you using ?
>>>>>
>>>>
>>>>    > How do you get into this situation ?
>>>> The first IRQ is io error, the second IRQ is disk link flash break.
>>>
>>> What does "link flash break" mean ?
>>>
>>>>
>>>>    > What adapter and disk are you using ?
>>>> It is a disk developed by our company, but we think the same issue
>>>> exists when using other disks.
>>>
>>> As I said, I find this situation highly suspect because if the first IRQ was to
>>> signal an IO error that the drive reported, then per ATA specifications, the
>>> drive should be in error mode and should NOT have transmitted any other FIS
>>> after the SDB FIS that signaled the error. Nothing at all should come after that
>>> error SDB FIS, until the host issues a read log 10h to get thee drive out of
>>> error state.
>>>
>>> If this is a prototype device, I would recommend that you take an ATA bus trace
>>> and verify the FIS traffic. Something fishy is going on with the drive in my
>>> opinion.
>>>
>>
>> Thank you for your patient explanation. I'm sorry I didn't explain the
>> problem clearly before. After discussing with my colleagues who know
>> more about dirvers, Let me re-describe the problem.
>>
>> The problem`s situation is the SATA link is quickly disconnected and
>> connected. For example, when an I/O error is processed in error handling
>> thread, the disk is manually removed and inserted, and the AHCI chip
>> reports a hot plug interrupt.
>>
>> This scenario is not just an NCQ error, but a disk is removed and
>> quickly inserted before the error processing is completed. For the error
>> handling process, the disk status needs to be restored after the error
>> handling is complete.
> 
> In your original email, you showed:
> 
> interrupt                            scsi_eh
> 
> ahci_error_intr
>    =>ata_port_freeze
>      =>__ata_port_freeze
>        =>ahci_freeze (turn IRQ off)
>      =>ata_port_abort
>        =>ata_port_schedule_eh
>          =>shost->host_eh_scheduled++;
>          host_eh_scheduled = 1
>                                       scsi_error_handler
>                                         =>ata_scsi_error
>                                           =>ata_scsi_port_error_handler
>                                             =>ahci_error_handler
>                                             . =>sata_pmp_error_handler
>                                             .   =>ata_eh_thaw_port
>                                             .     =>ahci_thaw (turn IRQ on)
> ahci_error_intr                            .
>    =>ata_port_freeze                        .
>      =>__ata_port_freeze                    .
>        =>ahci_freeze (turn IRQ off)         .
>      =>ata_port_abort                       .
>        =>ata_port_schedule_eh               .
>          =>shost->host_eh_scheduled++;      .
>          host_eh_scheduled = 2              .
> 
> But here, I do not understand how host_eh_scheduled can be incremented since the
> shost state should still be SHOST_RECOVERY until scsi_restart_operations() is
> called at the end of scsi_error_handler(), which is after ata_std_end_eh() is
> executed toward the end of ata_scsi_port_error_handler().

Yeah, shost state is still SHOST_RECOVERY during this period. But I 
don't think this will affect host_eh_scheduled++.
In scsi_host_set_state(), if (state == old state), it will return 0. So:
   ata_port_schedule_eh
    ata_std_sched_eh
     scsi_schedule_eh
      if (scsi_host_set_state(shost, SHOST_RECOVERY) == 0)  -> true
       shost->host_eh_scheduled++

> Not sure how what you are showing here can happen. Can you have a closer look ?
> 
>                                             =>ata_std_end_eh
>                                               =>host->host_eh_scheduled = 0;
> 
> In any case, for you particular failure pattern, given that the disk "goes away"
> while EH is running, I would expect the commands executed during EH (e.g. read
> log 10h) to timeout, which would cause a reset and a revalidate after that. The


If we remove the disk when EH is abount to end (after 'ahci_thaw'), the
commands which needed to be executed on the disk has already been
completed, and EH will not time out.

> reset should clear the port interrupt error bits, which should allow everything
> to recover after aborting all commands caught by the first EH run.
> 

-- 
Thanks,
Nan

