Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF079A44E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjIKHRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjIKHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:17:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B235CCD;
        Mon, 11 Sep 2023 00:16:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87CAC433C7;
        Mon, 11 Sep 2023 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694416618;
        bh=lWO/C3U3yqJl7tGyp46raVBwGBuyZj7w0yX4db1mPx8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xdd4B/wTOAbv4WtkaHdz8hIcZ4t47IDoYOXCjU77wxDiMHSey+J52iTQLul0adktJ
         V3J7bD/qZHjFNWYvjy81zuU9seURlGdPVVH3SEe0w9/Z+mUfTKrCNIPXdwxib3oOUa
         vgShLAyVEuNC9YKkiZKbuk4TkZeFVKM9xC/eRlCA1x0JDGwMyP3SosIXjzH1dQepNF
         FM2qPf+fc/4gITGtfw2l6l24d/QHSXDOi/C2QsAedKAmGrhce9fipEB5XZdqpyUPWc
         VUXXtRvAaE7Vvo0HgTcIyCJjvzFFCKQdBEsU5eMsq6NUmEp1M6p72CTYfcFExkPZAS
         LzBU/RAfTgIiw==
Message-ID: <d88625ca-9bc7-cf33-2fa7-9e71d4153e7f@kernel.org>
Date:   Mon, 11 Sep 2023 16:16:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] ata: libata-eh: Honor all EH scheduling requests
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     "linan666@huaweicloud.com" <linan666@huaweicloud.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>, luojian <luojian5@huawei.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "htejun@gmail.com" <htejun@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linan122@huawei.com" <linan122@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20230906084212.1016634-1-linan666@huaweicloud.com>
 <202309071557.3a90e7a8-oliver.sang@intel.com> <ZPo6fXqTbmwDyopr@x1-carbon>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZPo6fXqTbmwDyopr@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/23 06:02, Niklas Cassel wrote:
> On Thu, Sep 07, 2023 at 03:43:19PM +0800, kernel test robot wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed "kernel_BUG_at_drivers/ata/libata-sff.c" on:
>>
>> commit: d3d099d5c2dd38db84abd96df39f9f0828c16b7b ("[PATCH v4] ata: libata-eh: Honor all EH scheduling requests")
>> url: https://github.com/intel-lab-lkp/linux/commits/linan666-huaweicloud-com/ata-libata-eh-Honor-all-EH-scheduling-requests/20230906-164907
>> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
>> patch link: https://lore.kernel.org/all/20230906084212.1016634-1-linan666@huaweicloud.com/
>> patch subject: [PATCH v4] ata: libata-eh: Honor all EH scheduling requests
>>
>> in testcase: boot
>>
>> compiler: gcc-12
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> Unfortunately the problem reported by the kernel test robot is very real.
> I could reproduce without too much effort in QEMU.
> 
> The problem is basically that we cannot simply perform a host_eh_scheduled--;
> in ata_std_end_eh().
> 
> ata_std_end_eh() is called at the end of ata_scsi_port_error_handler(),
> so it is called once every time ata_scsi_port_error_handler() is called.
> 
> However, ata_scsi_port_error_handler() will be called by SCSI EH each
> time SCSI wakes up.
> 
> SCSI EH will sleep as long as:
> if ((shost->host_failed == 0 && shost->host_eh_scheduled == 0) ||
>                     shost->host_failed != scsi_host_busy(shost)) {
> 	schedule();
> 	continue;
> }
> 
> 
> The methods in libata which we use to trigger EH are:
> 
> 1) ata_std_sched_eh(), which calls scsi_schedule_eh(), which does
> host_eh_scheduled++;
> 
> 2) ata_qc_schedule_eh(), which will end up in scsi_timeout,
> which calls scsi_eh_scmd_add() which does:
> host_failed++;
> 
> 
> So before this patch, setting host_eh_scheduled = 0; in ata_std_end_eh()
> makes us say that works because it only negates the EH scheduled by
> ata_std_sched_eh().
> 
> However, if we do host_eh_scheduled--, then if the EH was triggered by
> ata_qc_schedule_eh(), then host_eh_scheduled will decrease < 0,
> which will trigger SCSI EH to wake up again :)
> 
> We could do something like only decreasing host_eh_scheduled if it is > 0.
> The QCs added to EH using ata_qc_schedule_eh() will be handled by
> ata_eh_finish(), which will iterate over all QCs owned by EH, and will
> either fail or retry each QC. After that scsi_error_handler() has finished
> the call to eh_strategy_handler() (ata_scsi_error()) it will unconditionally
> set host_failed to 0:
> https://github.com/torvalds/linux/blob/v6.5/drivers/scsi/scsi_error.c#L2331-L2337
> 
> So something like this on top of the patch in $subject:
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 2d5ecd68b7e0..9ab12d7f6d9f 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -952,7 +952,13 @@ EXPORT_SYMBOL_GPL(ata_std_sched_eh);
>   */
>  void ata_std_end_eh(struct ata_port *ap)
>  {
> -       ap->scsi_host->host_eh_scheduled--;
> +       struct Scsi_Host *host = ap->scsi_host;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(host->host_lock, flags);
> +       if (host->host_eh_scheduled > 0)
> +               host->host_eh_scheduled--;
> +       spin_unlock_irqrestore(host->host_lock, flags);
>  }
>  EXPORT_SYMBOL(ata_std_end_eh);
> 
> 
> With that incremental patch, I can no longer reproduce the crash reported
> by the kernel test robot in my QEMU setup.

I am not confident that playing with host_eh_schedule count is the right
approach. A better solution may be to change the timing of clearing
ATA_PFLAG_EH_PENDING. Right now, this is done on entry to
ata_scsi_port_error_handler(), unconditionally. So ata_eh_reset() should not
need to clear the flag again. If we remove that, then a new interrupt received
after ata_eh_thaw() and setting EH_PENDING would be cought by the retry loop in
ata_scsi_port_error_handler(), which would run again ap->ops->error_handler(ap).

So let's try this fix instead:

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 159ba6ba19eb..d1d081aa0c95 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2807,7 +2807,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
        memset(&link->eh_info, 0, sizeof(link->eh_info));
        if (slave)
                memset(&slave->eh_info, 0, sizeof(link->eh_info));
-       ap->pflags &= ~ATA_PFLAG_EH_PENDING;
        spin_unlock_irqrestore(link->ap->lock, flags);

        if (ata_port_is_frozen(ap))

Li,

Can you please test this ?

> 
> 
> 
> It might be worth mentioning that the race window for the bug that the patch
> in $subject is fixing, should be much smaller after this patch is in:
> https://lore.kernel.org/linux-ide/20230907081710.4946-1-Chloe_Chen@asmedia.com.tw/
> 
> Li Nan, perhaps you could see if you can still reproduce your original
> problem with the patch from the ASMedia guys?


> 
> However, even with the ASMedia patch, it should still be theoretically
> possible to get an error irq after ata_eh_reset() has called ahci_thaw(),
> so I suppose that this patch still makes some sense...
> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

