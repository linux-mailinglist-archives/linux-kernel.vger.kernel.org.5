Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8207377B1C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjHNGmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjHNGl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:41:56 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2541AE5D;
        Sun, 13 Aug 2023 23:41:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RPPvL5FhCz4f3nVF;
        Mon, 14 Aug 2023 14:41:50 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqWszNlkBfGzAg--.55987S3;
        Mon, 14 Aug 2023 14:41:51 +0800 (CST)
Message-ID: <c2ae28b7-a105-9cd6-bf2e-63051a4000b0@huaweicloud.com>
Date:   Mon, 14 Aug 2023 14:41:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
References: <20230810014848.2148316-1-linan666@huaweicloud.com>
 <25c1aca7-d885-0fff-2639-bb68a7dff44f@kernel.org>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <25c1aca7-d885-0fff-2639-bb68a7dff44f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHoqWszNlkBfGzAg--.55987S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1kuw43ury7Kr1fJrW3GFg_yoW5uF15pF
        Z8J3Z09FyDKFyjva9Iva15Za43KFWxJFyUKryUJ34Ig3yqyFyrKrWIkr909Fy8ur1UC3W2
        qw4qgr1fCF4kA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xF
        o4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
        VOJ7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/8/10 10:49, Damien Le Moal 写道:
> On 8/10/23 10:48, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
>>
> 
> Please explain the problem first instead of starting with a function call
> timeline which cannot ba analized without explanations.
> 
>> interrupt                            scsi_eh
>>
>> ahci_error_intr
>>    =>ata_port_freeze
>>      =>__ata_port_freeze
>>        =>ahci_freeze (turn IRQ off)
>>      =>ata_port_abort
>>        =>ata_port_schedule_eh
>>          =>shost->host_eh_scheduled++;
>>          host_eh_scheduled = 1
>>                                       scsi_error_handler
>>                                         =>ata_scsi_error
>>                                           =>ata_scsi_port_error_handler
>>                                             =>ahci_error_handler
>>                                             . =>sata_pmp_error_handler
>>                                             .   =>ata_eh_thaw_port
>>                                             .     =>ahci_thaw (turn IRQ on)
>> ahci_error_intr                            .
>>    =>ata_port_freeze                        .
>>      =>__ata_port_freeze                    .
>>        =>ahci_freeze (turn IRQ off)         .
>>      =>ata_port_abort                       .
>>        =>ata_port_schedule_eh               .
>>          =>shost->host_eh_scheduled++;      .
>>          host_eh_scheduled = 2              .
>>                                             =>ata_std_end_eh
>>                                               =>host->host_eh_scheduled = 0;
>>
>> 'host_eh_scheduled' is 0 and scsi eh thread will not be scheduled again,
>> and the ata port remain freeze and will never be enabled.
>>
>> If EH thread is already running, no need to freeze port and schedule
>> EH again.
>>
>> Reported-by: luojian <luojian5@huawei.com>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/ata/libahci.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index e2bacedf28ef..0dfb0b807324 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -1840,9 +1840,17 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
>>   
>>   	/* okay, let's hand over to EH */
>>   
>> -	if (irq_stat & PORT_IRQ_FREEZE)
>> +	if (irq_stat & PORT_IRQ_FREEZE) {
>> +		/*
>> +		 * EH already running, this may happen if the port is
>> +		 * thawed in the EH. But we cannot freeze it again
>> +		 * otherwise the port will never be thawed.
>> +		 */
>> +		if (ap->pflags & (ATA_PFLAG_EH_PENDING |
>> +			ATA_PFLAG_EH_IN_PROGRESS))
>> +			return;
> 
> This is definitely not correct because EH may have been scheduled for a non
> fatal action like a device revalidate or to get sense data for successful
> commands. With this change, the port will NOT be frozen when a hard error IRQ
> comes while EH is waiting to start, that is, while EH waits for all commands to
> complete first.
> 

Yeah, we should find a better way to fix it. Do you have any suggesstions?

> Furthermore, if you get an IRQ that requires the port to be frozen, it means
> that you had a failed command. In that case, the drive is in error state per
> ATA specs and stops all communication until a read log 10h command is issued.
> So you should never ever see 2 error IRQs one after the other. If you do, it
> very likely means that you have buggy hardware.
> 
> How do you get into this situation ? What adapter and disk are you using ?
> 

 > How do you get into this situation ?
The first IRQ is io error, the second IRQ is disk link flash break.

 > What adapter and disk are you using ?
It is a disk developed by our company, but we think the same issue 
exists when using other disks.

>>   		ata_port_freeze(ap);
>> -	else if (fbs_need_dec) {
>> +	} else if (fbs_need_dec) {
>>   		ata_link_abort(link);
>>   		ahci_fbs_dec_intr(ap);
>>   	} else
> 

-- 
Thanks,
Nan

