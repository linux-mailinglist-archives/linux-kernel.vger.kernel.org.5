Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBE3792AEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbjIEQni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354634AbjIENJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:09:19 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC7127;
        Tue,  5 Sep 2023 06:09:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rg5S45Njzz4f3pFl;
        Tue,  5 Sep 2023 21:09:08 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgA3xqhyKPdkZYq4CQ--.15031S3;
        Tue, 05 Sep 2023 21:09:10 +0800 (CST)
Message-ID: <8a34d182-0adb-fcf5-6c3f-0ffa8392f615@huaweicloud.com>
Date:   Tue, 5 Sep 2023 21:09:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
References: <20230905034840.478332-1-linan666@huaweicloud.com>
 <c4d397c4-1969-935f-6dc3-cf7775d96f5c@kernel.org>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <c4d397c4-1969-935f-6dc3-cf7775d96f5c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3xqhyKPdkZYq4CQ--.15031S3
X-Coremail-Antispam: 1UD129KBjvJXoWxArWrGr48tw47Ary7GrWDXFb_yoW5Kr17pF
        Z8J3WqgryUtry2vrsFq3W5XFyFgay8Kry2qrn8Gw1fZr4qya4rK39rCrZ0gF92kr97J3WI
        9a1Yg39xCF10vaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



在 2023/9/5 15:44, Damien Le Moal 写道:
> On 9/5/23 12:48, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
> 
> Please change the patch title to something like:
> 
> ata: libata-eh: Honor all EH scheduling requests
> 
> Because the issue could happen I think with other ata drivers than AHCI.
> 
> 
>>
>> If a disk is removed and quickly inserted when an I/O error is processing,
>> the disk may not be able to be re-added. The function call timeline is as
>> follows:
>>
>>    interrupt                            scsi_eh
>>
>>    ahci_error_intr
>>     ata_port_freeze
>>      __ata_port_freeze
>>       =>ahci_freeze (turn IRQ off)
>>      ata_port_abort
>>       ata_do_link_abort
>>        ata_port_schedule_eh
>>         =>ata_std_sched_eh
>>          ata_eh_set_pending
>> 	 set EH_PENDING
>>          scsi_schedule_eh
>>           shost->host_eh_scheduled++ (=1)
>>                                         scsi_error_handler
>>                                          =>ata_scsi_error
>>                                           ata_scsi_port_error_handler
>> 					  clear EH_PENDING
>>                                            =>ahci_error_handler
>>                                            . sata_pmp_error_handler
>>                                            .  ata_eh_reset
>>                                            .   ata_eh_thaw_port
>>                                            .   . =>ahci_thaw (turn IRQ on)
>>    ahci_error_intr			  .   .
>>     ata_port_freeze			  .   .
>>      __ata_port_freeze			  .   .
>>       =>ahci_freeze (turn IRQ off)	  .   .
>>      ...					  .   .
>>          ata_eh_set_pending		  .   .
>> 	 set EH_PENDING			  .   .
>>          scsi_schedule_eh		  .   .
>>           shost->host_eh_scheduled++ (=2)  .   .
>> 					  .   clear EH_PENDING
>> 					  check EH_PENDING
>>                                            =>ata_std_end_eh
>>                                             host->host_eh_scheduled = 0;
>>
>> 'host_eh_scheduled' is 0 and scsi eh thread will not be scheduled again.
>> The ata port remain freeze and will never be enabled.
> 
> s/remain freeze/remains frozen
> 
>>
>> Decrease ’host_eh_scheduled‘ instead of set it to 0 roughly and move
>> WARN_ON of nr_active_links to ata_scsi_port_error_handler().
> 
> To fix this issue, decrease ’host_eh_scheduled‘ instead of setting it to 0 so
> that EH is scheduled again to re-enable the port. Also move the update of
> nr_active_links to 0 when host_eh_scheduled is 0 to ata_scsi_port_error_handler().
> 

Thanks for your review. I will improve the commmit message.

>>
>> Reported-by: luojian <luojian5@huawei.com>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>> Changes in v2:
>>    - fix the bug by decrease 'host_eh_scheduled’
>>    - improve commit message.
>>
>>   drivers/ata/libata-eh.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 159ba6ba19eb..b9454756ecde 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -735,6 +735,12 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
>>   	 */
>>   	ap->ops->end_eh(ap);
>>   
>> +	if (!ap->scsi_host->host_eh_scheduled) {
>> +		/* make sure nr_active_links is zero after EH */
>> +		WARN_ON(ap->nr_active_links);
>> +		ap->nr_active_links = 0;> +	}
>> +
>>   	spin_unlock_irqrestore(ap->lock, flags);
>>   	ata_eh_release(ap);
>>   
>> @@ -948,7 +954,7 @@ void ata_std_end_eh(struct ata_port *ap)
>>   {
>>   	struct Scsi_Host *host = ap->scsi_host;
>>   
>> -	host->host_eh_scheduled = 0;
>> +	host->host_eh_scheduled--;
> 
> While at it, please drop the host variable:
> 
> 	ap->scsi_host->host_eh_scheduled--;
> 
> is just fine.
> 

I agree. I will change it in next version.

>>   }
>>   EXPORT_SYMBOL(ata_std_end_eh);
>>   
>> @@ -3922,10 +3928,6 @@ void ata_eh_finish(struct ata_port *ap)
>>   			}
>>   		}
>>   	}
>> -
>> -	/* make sure nr_active_links is zero after EH */
>> -	WARN_ON(ap->nr_active_links);
>> -	ap->nr_active_links = 0;
>>   }
>>   
>>   /**
> 

-- 
Thanks,
Nan

