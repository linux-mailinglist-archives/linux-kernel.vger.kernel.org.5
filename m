Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763FB7661CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjG1CdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjG1CdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32FB30DA;
        Thu, 27 Jul 2023 19:33:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B82361F97;
        Fri, 28 Jul 2023 02:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D2DC433C8;
        Fri, 28 Jul 2023 02:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690511601;
        bh=H5DZiC+YGeGkUW+jjo5LoBNHhvMZFNEnZwIT7bvrBX4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PRlj79ZaeaAKHeUVKI/L6crpFIc8/WF3LSUJJpTKmFHAppfcCwiUNidwqXpLthN64
         Nz+AHCbzjyF8JoBmdvX9MC1XueQ+GP1j7qKzto+tRqKQorxKxfbuCZ5l04bH1HXZCp
         jpwQ3vgc8nCdWH29HYh55CsXYqfxnR+HY7vA6h+ABRoQFkXi6gmeCwhoUF7zsXCqjO
         5dAMINBKICbmOsWCqpIAV2mZL5/LcXOmGwCo82GEjuNc2ntjPKeoDovaXhxA3JlchZ
         SptGNaqek6fmbCAu1lScUPo5EoESrHsetYDo3CofFLV2KKw9s81PHFvK+AIwTIxZjg
         MUoS0pE4me1SA==
Message-ID: <40365501-283a-408b-3514-48c29db36861@kernel.org>
Date:   Fri, 28 Jul 2023 11:33:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
Content-Language: en-US
To:     TW <dalzot@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
 <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
 <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
 <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
 <86435987-734e-c6c1-a857-1ba80da709fe@gmail.com>
 <48bc1736-5e4e-3a9b-3715-60509c333bb1@kernel.org>
 <f7e7b601-571f-bd2e-6410-a8a27e510c2f@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f7e7b601-571f-bd2e-6410-a8a27e510c2f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 21:25, TW wrote:
> It was all 1 patch but the first change had a formatting issue from the 
> email format I guess. So I fixed that and the patch went through and 
> looks like the drive error message has stopped. Still a little slow 
> coming back but that error is gone at least.

"Slow coming back" -> Compared to which version of the kernel ? Do you have
numbers ?

If the devices are HDDs, resume will wait for these to spin up. That takes a
while (about 10s normally).

> 
> Jul 27 05:05:05 rageworks systemd[1]: Starting System Suspend...
> Jul 27 05:05:05 rageworks systemd-sleep[1624]: Entering sleep state 
> 'suspend'...
> Jul 27 05:05:05 rageworks kernel: PM: suspend entry (deep)
> Jul 27 05:05:05 rageworks kernel: Filesystems sync: 0.246 seconds
> Jul 27 05:05:26 rageworks kernel: Freezing user space processes
> Jul 27 05:05:26 rageworks kernel: Freezing user space processes 
> completed (elapsed 0.001 seconds)
> Jul 27 05:05:26 rageworks kernel: OOM killer disabled.
> Jul 27 05:05:26 rageworks kernel: Freezing remaining freezable tasks
> Jul 27 05:05:26 rageworks kernel: Freezing remaining freezable tasks 
> completed (elapsed 0.000 seconds)
> Jul 27 05:05:26 rageworks kernel: printk: Suspending console(s) (use 
> no_console_suspend to debug)
> Jul 27 05:05:26 rageworks kernel: serial 00:05: disabled
> Jul 27 05:05:26 rageworks kernel: sd 9:0:0:0: [sdc] Synchronizing SCSI cache
> Jul 27 05:05:26 rageworks kernel: sd 1:0:0:0: [sdb] Synchronizing SCSI cache
> Jul 27 05:05:26 rageworks kernel: sd 0:0:0:0: [sda] Synchronizing SCSI cache
> Jul 27 05:05:26 rageworks kernel: sd 9:0:0:0: [sdc] Stopping disk
> Jul 27 05:05:26 rageworks kernel: sd 1:0:0:0: [sdb] Stopping disk
> Jul 27 05:05:26 rageworks kernel: sd 0:0:0:0: [sda] Stopping disk
> Jul 27 05:05:26 rageworks kernel: ACPI: PM: Preparing to enter system 
> sleep state S3
> Jul 27 05:05:26 rageworks kernel: ACPI: PM: Saving platform NVS memory
> Jul 27 05:05:26 rageworks kernel: Disabling non-boot CPUs ...
> Jul 27 05:05:26 rageworks kernel: smpboot: CPU 1 is now offline
> Jul 27 05:05:26 rageworks kernel: smpboot: CPU 2 is now offline
> Jul 27 05:05:26 rageworks kernel: smpboot: CPU 3 is now offline
> Jul 27 05:05:26 rageworks kernel: ACPI: PM: Low-level resume complete
> Jul 27 05:05:26 rageworks kernel: ACPI: PM: Restoring platform NVS memory
> Jul 27 05:05:26 rageworks kernel: Enabling non-boot CPUs ...
> Jul 27 05:05:26 rageworks kernel: smpboot: Booting Node 0 Processor 1 
> APIC 0x1
> Jul 27 05:05:26 rageworks kernel: CPU1 is up
> Jul 27 05:05:26 rageworks kernel: smpboot: Booting Node 0 Processor 2 
> APIC 0x2
> Jul 27 05:05:26 rageworks kernel: CPU2 is up
> Jul 27 05:05:26 rageworks kernel: smpboot: Booting Node 0 Processor 3 
> APIC 0x3
> Jul 27 05:05:26 rageworks kernel: CPU3 is up
> Jul 27 05:05:26 rageworks kernel: ACPI: PM: Waking up from system sleep 
> state S3
> Jul 27 05:05:26 rageworks kernel: xhci_hcd 0000:02:00.0: xHC error in 
> resume, USBSTS 0x401, Reinit
> Jul 27 05:05:26 rageworks kernel: usb usb1: root hub lost power or was reset
> Jul 27 05:05:26 rageworks kernel: usb usb2: root hub lost power or was reset
> Jul 27 05:05:26 rageworks kernel: sd 0:0:0:0: [sda] Starting disk
> Jul 27 05:05:26 rageworks kernel: sd 1:0:0:0: [sdb] Starting disk
> Jul 27 05:05:26 rageworks kernel: sd 9:0:0:0: [sdc] Starting disk
> Jul 27 05:05:26 rageworks kernel: serial 00:05: activated
> Jul 27 05:05:26 rageworks kernel: ata6: SATA link down (SStatus 0 
> SControl 330)
> Jul 27 05:05:26 rageworks kernel: ata5: SATA link down (SStatus 0 
> SControl 330)
> Jul 27 05:05:26 rageworks kernel: ata9: SATA link down (SStatus 0 
> SControl 300)
> Jul 27 05:05:26 rageworks kernel: usb 1-10: reset full-speed USB device 
> number 4 using xhci_hcd
> Jul 27 05:05:26 rageworks kernel: usb 1-8: reset full-speed USB device 
> number 3 using xhci_hcd
> Jul 27 05:05:26 rageworks kernel: usb 1-7: reset full-speed USB device 
> number 2 using xhci_hcd
> Jul 27 05:05:26 rageworks kernel: OOM killer enabled.
> Jul 27 05:05:26 rageworks kernel: Restarting tasks ... done.
> Jul 27 05:05:26 rageworks kernel: random: crng reseeded on system resumption
> Jul 27 05:05:26 rageworks kernel: PM: suspend exit
> 
> 
> On 7/27/23 04:27, Damien Le Moal wrote:
>> On 7/27/23 19:22, TW wrote:
>>> I managed to fix the patch file, guess the formatting messed up a bit. So will
>>> try with those patches installed.
>> Just in case, patch fil attached to avoid formatting issues.
>>
>>

-- 
Damien Le Moal
Western Digital Research

