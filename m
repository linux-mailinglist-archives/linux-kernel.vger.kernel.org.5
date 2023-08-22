Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1293E783CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjHVJUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjHVJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:20:41 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCE8113;
        Tue, 22 Aug 2023 02:20:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVP2m5Hjjz4f3lVH;
        Tue, 22 Aug 2023 17:20:32 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6nhfeRkc5Q8BQ--.32423S3;
        Tue, 22 Aug 2023 17:20:33 +0800 (CST)
Message-ID: <f33816ef-ce26-1501-99b6-c75f91c6d8f5@huaweicloud.com>
Date:   Tue, 22 Aug 2023 17:20:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linan666@huaweicloud.com" <linan666@huaweicloud.com>
Cc:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20230810014848.2148316-1-linan666@huaweicloud.com>
 <ZONr0f26IT/QKsSu@x1-carbon>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <ZONr0f26IT/QKsSu@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6nhfeRkc5Q8BQ--.32423S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw17GF1DuFy7Cw15WFy8Zrb_yoW5JrykpF
        Z8J34DuryDXrW0yr4kua10934Fya1kCFWayFyDG3s7Zw1DX3sYqrZakFZ0qFnFgw1kAw40
        93Wjgr98AFWkWr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjfUFYFADUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply, Niklas.

在 2023/8/21 21:51, Niklas Cassel 写道:
> On Thu, Aug 10, 2023 at 09:48:48AM +0800, linan666@huaweicloud.com wrote:

[snip]

> 
> Hello Li Nan,
> 
> I do not understand why the code in:
> https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L722-L731
> 
> does not kick in, and repeats EH.
> 
> 
> EH_PENDING is cleared before ->error_handler() is called:
> https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L697
> 
> So ahci_error_intr() from the second error interrupt, which is called after
> thawing the port, should have called ata_std_sched_eh(), which calls
> ata_eh_set_pending(), which should have set EH_PENDING:
> https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L884
> 
> 
> 
> My only guess is that after thawing the port:
> https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L2807
> 
> The second error irq comes, and sets EH_PENDING,
> but then this silly code might clear it:
> https://github.com/torvalds/linux/blob/v6.5-rc7/drivers/ata/libata-eh.c#L2825-L2837
> 

Yeah, I think so.

> I think the best way would be if we could improve this "spurious error
> condition check"... because if this is indeed the code that clears EH_PENDING
> for you, then this code basically makes the "goto repeat" code in
> ata_scsi_port_error_handler() useless...
> 
> 
> An alternative to improving the "spurious error condition check" might be for
> you to try something like:
> 

We have used this solution before, but it will case WARN_ON in
ata_eh_finish() as below:

   WARNING: CPU: 1 PID: 118 at ../drivers/ata/libata-eh.c:4016 
ata_eh_finish+0x15a/0x170

   ata_do_eh+0x70/0xf0
   ata_sff_error_handler+0xde/0x170
   ata_bmdma_error_handler+0x5b/0x1e0
   ata_scsi_port_error_handler+0x5b1/0xae0
   ata_scsi_error+0xb9/0x110
   scsi_error_handler+0x137/0x8d0

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 35e03679b0bf..82f032934ae1 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -962,7 +962,7 @@ void ata_std_end_eh(struct ata_port *ap)
>   {
>          struct Scsi_Host *host = ap->scsi_host;
>   
> -       host->host_eh_scheduled = 0;
> +       host->host_eh_scheduled--;
>   }
>   EXPORT_SYMBOL(ata_std_end_eh);
> 
> 
> 
> ...and see if that improves things for you.
> 
> 
> 
> Kind regards,
> Niklas.

-- 
Thanks,
Nan

