Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAED27D7F13
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbjJZI4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjJZI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:56:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A117E193;
        Thu, 26 Oct 2023 01:56:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A473C433C9;
        Thu, 26 Oct 2023 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698310567;
        bh=suCN0GqTbLAZAR+pGq/eT2Kwv1yJMWbt7bUX77dcwdg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SQipISJxnYmqU7BYqeBxXAU8+Alf3BnLX0a3X8aaDQt9ZSC6fgcdtQ0Qhgft0Ktd7
         fRJZ9vIoV9UHVPheJOmkrZwes6bRCdR13u+ec0QDWj7jqOtcillWoNMuM6VGGmSr7P
         +N3jhgdxBPmOkUA6E7E2exjwhRe9Hm7QEP8Ill2lgsrDUMoRLl6s2E+BpSHhGUyQQS
         P1xDCGE4ccoYFVFMvz0553AwZBrp33CfQwncLvpcbUQGpiZ2oA+KqCFQAgIELMm5Jx
         ojnGg6vPB86Uutb8H2dtxslWPDn6SfTOBVWBYx0RohmTwSGRm24FuVaNtQBZNfEOMl
         bXmYnF8NQ5vKg==
Message-ID: <4bec6c99-68aa-ddfb-9c22-ba62f66e5901@kernel.org>
Date:   Thu, 26 Oct 2023 17:56:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Fwd: Marvell 88SE6320 SAS controller (mvsas) cannot survive ACPI
 S3 or ACPI S4
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux SCSI <linux-scsi@vger.kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        Nikolaos Barkas <nickosbarkas@gmail.com>
References: <7e8fab39-8cdd-4527-8c4f-b18dd79cee14@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <7e8fab39-8cdd-4527-8c4f-b18dd79cee14@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/26 17:25, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a bug report on Bugzilla [1]. Quoting from it:

[...]

>> [  437.249448] PM: suspend entry (deep)
>> [  437.255308] Filesystems sync: 0.005 seconds
>> [  437.255570] Freezing user space processes
>> [  437.257093] Freezing user space processes completed (elapsed 0.001 seconds)
>> [  437.257097] OOM killer disabled.
>> [  437.257098] Freezing remaining freezable tasks
>> [  437.258226] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [  437.258281] printk: Suspending console(s) (use no_console_suspend to debug)
>> [  437.291778] sd 0:0:0:0: [sdb] Synchronizing SCSI cache
>> [  437.291825] sd 0:0:1:0: [sdc] Synchronizing SCSI cache
>> [  437.292083] sd 0:0:0:0: [sdb] Stopping disk
>> [  437.292083] sd 0:0:1:0: [sdc] Stopping disk
>> [  438.363660] sd 1:0:0:0: [sda] Synchronizing SCSI cache
>> [  438.363760] sd 1:0:0:0: [sda] Stopping disk

Given this message, this does not look like the latest kernel.

>> [  589.081341] drivers/scsi/mvsas/mv_sas.c 1304:mvs_I_T_nexus_reset for device[1]:rc= 0
>> [  610.481270] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> [  610.481280] rcu: 	11-...0: (0 ticks this GP) idle=4f84/1/0x4000000000000000 softirq=19873/19873 fqs=1159
>> [  610.481292] 	(detected by 5, t=5252 jiffies, g=53581, q=31630 ncpus=12)
>> [  610.481299] Sending NMI from CPU 5 to CPUs 11:
>> [  610.481309] NMI backtrace for cpu 11
>> [  610.481312] CPU: 11 PID: 3152 Comm: kworker/u32:59 Tainted: G          I        6.1.57-vanilla #14
>> [  610.481318] Hardware name: System manufacturer System Product Name/P6T WS PRO, BIOS 1205    09/24/2010
>> [  610.481321] Workqueue: events_unbound async_run_entry_fn
>> [  610.481329] RIP: 0010:mvs_int_rx+0x81/0x150 [mvsas]
>> [  610.481346] Code: 00 00 44 39 75 70 74 47 48 8b 45 60 45 89 e6 41 81 e6 ff 03 00 00 41 8d 56 01 8b 1c 90 49 89 d4 41 89 df 41 81 e7 00 00 08 00 <f7> c3 00 00 01 00 74 58 31 d2 89 de 48 89 ef e8 0b f9 ff ff 45 85
>> [  610.481350] RSP: 0018:ffffb61f06acbb60 EFLAGS: 00000046
>> [  610.481354] RAX: ffff9a7cc2658000 RBX: 0000000000010000 RCX: 0000000000000000
>> [  610.481358] RDX: 000000000000026e RSI: 0000000000010000 RDI: ffff9a7ce2660000
>> [  610.481361] RBP: ffff9a7ce2660000 R08: ffff9a7ce2660f00 R09: ffff9a7ce2660000
>> [  610.481364] R10: ffff9a7ce26600c8 R11: ffffffff884d4300 R12: 000000000000026e
>> [  610.481367] R13: 0000000000000000 R14: 000000000000026d R15: 0000000000000000
>> [  610.481371] FS:  0000000000000000(0000) GS:ffff9a7df7cc0000(0000) knlGS:0000000000000000
>> [  610.481375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  610.481378] CR2: 0000563633425300 CR3: 0000000077210006 CR4: 00000000000206e0
>> [  610.481382] Call Trace:
>> [  610.481385]  <NMI>
>> [  610.481389]  ? nmi_cpu_backtrace.cold+0x1b/0x76
>> [  610.481398]  ? nmi_cpu_backtrace_handler+0xd/0x20
>> [  610.481403]  ? nmi_handle+0x5d/0x120
>> [  610.481410]  ? mvs_int_rx+0x81/0x150 [mvsas]
>> [  610.481423]  ? default_do_nmi+0x69/0x170
>> [  610.481428]  ? exc_nmi+0x13c/0x170
>> [  610.481432]  ? end_repeat_nmi+0x16/0x67
>> [  610.481443]  ? mvs_int_rx+0x81/0x150 [mvsas]
>> [  610.481457]  ? mvs_int_rx+0x81/0x150 [mvsas]
>> [  610.481470]  ? mvs_int_rx+0x81/0x150 [mvsas]
>> [  610.481483]  </NMI>
>> [  610.481484]  <TASK>
>> [  610.481487]  mvs_do_release_task+0x3f/0x90 [mvsas]
>> [  610.481501]  mvs_release_task+0x13e/0x1a0 [mvsas]
>> [  610.481516]  mvs_I_T_nexus_reset+0xb2/0xd0 [mvsas]
>> [  610.481530]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
>> [  610.481552]  sas_ata_hard_reset+0x48/0x80 [libsas]
>> [  610.481575]  ata_eh_reset+0x2e5/0x1090 [libata]
>> [  610.481631]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
>> [  610.481652]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
>> [  610.481676]  ata_eh_recover+0x2e6/0xe00 [libata]
>> [  610.481728]  ? __wake_up_klogd.part.0+0x56/0x80
>> [  610.481735]  ? vprintk_emit+0x207/0x290
>> [  610.481739]  ? smp_ata_check_ready_type+0xb0/0xb0 [libsas]
>> [  610.481760]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
>> [  610.481783]  ? smp_ata_check_ready_type+0xb0/0xb0 [libsas]
>> [  610.481804]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
>> [  610.481824]  ata_do_eh+0x75/0xf0 [libata]
>> [  610.481876]  ? del_timer_sync+0x6f/0xb0
>> [  610.481884]  ata_scsi_port_error_handler+0x3a8/0x800 [libata]
>> [  610.481938]  async_sas_ata_eh+0x44/0x7f [libsas]
>> [  610.481960]  async_run_entry_fn+0x30/0x130
>> [  610.481966]  process_one_work+0x1c7/0x380
>> [  610.481974]  worker_thread+0x4d/0x380
>> [  610.481981]  ? rescuer_thread+0x3a0/0x3a0
>> [  610.481987]  kthread+0xe9/0x110
>> [  610.481992]  ? kthread_complete_and_exit+0x20/0x20
>> [  610.481999]  ret_from_fork+0x22/0x30
>> [  610.482009]  </TASK>
>> [  665.286198] NMI watchdog: Watchdog detected hard LOCKUP on cpu 11
Could be due to the libata deadlock without the recent suspend/resume fixes. Or
this is yet another adapter that was not tested for suspend/resume. mpt3sas
crashes the machine 100% of the time as well. I had no time to dig into that issue.

>> Hibernate/resume with a sas disk and then running gnome disks for a couple of reads:
>>
>> [    0.000000] Linux version 6.1.57-vanilla (turbo@dbn-003) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #14 SMP PREEMPT_DYNAMIC Sat Oct 14 11:48:05 EEST 2023
>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.1.57-vanilla root=/dev/mapper/test-root ro quiet
>>
>>     4.191667] scsi host0: mvsas
>> [    4.202932] sas: phy-0:1 added to port-0:0, phy_mask:0x2 (2bad2bad2bad2bad)
>> [    4.202935] drivers/scsi/mvsas/mv_sas.c 1099:set wide port phy map 2
>> [    4.232802] sas: DOING DISCOVERY on port 0, pid:78
>> [    4.234233] scsi 0:0:0:0: Direct-Access     WD       WD3001HKHG-02VUC SR07 PQ: 0 ANSI: 6
>> [    4.234723] scsi 0:0:0:0: Power-on or device reset occurred
>> [    4.243180] sas: DONE DISCOVERY on port 0, pid:78, result:0
>> [    4.243958] sd 0:0:0:0: [sdb] 586072368 512-byte logical blocks: (300 GB/279 GiB)
>> [    4.251366] sd 0:0:0:0: [sdb] Write Protect is off
>> [    4.251372] sd 0:0:0:0: [sdb] Mode Sense: df 00 10 08
>> [    4.256088] sd 0:0:0:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
>>
>> [  331.841349] PM: hibernation: hibernation entry
>> [  331.846068] Filesystems sync: 0.004 seconds
>> [  331.846251] Freezing user space processes
>> [  331.847662] Freezing user space processes completed (elapsed 0.001 seconds)
>> [  331.847665] OOM killer disabled.
>> [  331.847752] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
>> [  331.847754] PM: hibernation: Marking nosave pages: [mem 0x0009c000-0x000fffff]
>> [  331.847757] PM: hibernation: Marking nosave pages: [mem 0xbf780000-0xffffffff]
>> [  331.848818] PM: hibernation: Basic memory bitmaps created
>> [  331.848868] PM: hibernation: Preallocating image memory
>> [  332.320952] PM: hibernation: Allocated 468298 pages for snapshot
>> [  332.320958] PM: hibernation: Allocated 1873192 kbytes in 0.47 seconds (3985.51 MB/s)
>> [  332.320961] Freezing remaining freezable tasks
>> [  332.322205] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [  332.322378] printk: Suspending console(s) (use no_console_suspend to debug)
>> [  334.826522] ACPI: PM: Preparing to enter system sleep state S4
>> [  334.826773] ACPI: PM: Saving platform NVS memory
>> [  334.826979] Disabling non-boot CPUs ...
>> [  334.829452] smpboot: CPU 1 is now offline
>> [  334.831537] smpboot: CPU 2 is now offline
>> [  334.833750] smpboot: CPU 3 is now offline
>> [  334.835897] smpboot: CPU 4 is now offline
>> [  334.838296] smpboot: CPU 5 is now offline
>> [  334.840868] smpboot: CPU 6 is now offline
>> [  334.842966] smpboot: CPU 7 is now offline
>> [  334.845060] smpboot: CPU 8 is now offline
>> [  334.847030] smpboot: CPU 9 is now offline
>> [  334.848955] smpboot: CPU 10 is now offline
>> [  334.850837] smpboot: CPU 11 is now offline
>> [  334.851340] PM: hibernation: Creating image:
>> [  335.133820] PM: hibernation: Need to copy 480821 pages
>> [  335.133826] PM: hibernation: Normal pages needed: 480821 + 1024, available pages: 1613904
>> [  334.852388] ACPI: PM: Restoring platform NVS memory
>> [  334.852777] Enabling non-boot CPUs ...
>> [  334.852817] x86: Booting SMP configuration:
>> [  334.852818] smpboot: Booting Node 0 Processor 1 APIC 0x2
>> [  334.856338] CPU1 is up
>> [  334.856369] smpboot: Booting Node 0 Processor 2 APIC 0x4
>> [  334.859345] CPU2 is up
>> [  334.859375] smpboot: Booting Node 0 Processor 3 APIC 0x10
>> [  334.862383] CPU3 is up
>> [  334.862412] smpboot: Booting Node 0 Processor 4 APIC 0x12
>> [  334.865376] CPU4 is up
>> [  334.865407] smpboot: Booting Node 0 Processor 5 APIC 0x14
>> [  334.868395] CPU5 is up
>> [  334.868423] smpboot: Booting Node 0 Processor 6 APIC 0x1
>> [  334.871618] CPU6 is up
>> [  334.871649] smpboot: Booting Node 0 Processor 7 APIC 0x3
>> [  334.874844] CPU7 is up
>> [  334.874878] smpboot: Booting Node 0 Processor 8 APIC 0x5
>> [  334.878160] CPU8 is up
>> [  334.878189] smpboot: Booting Node 0 Processor 9 APIC 0x11
>> [  334.881557] CPU9 is up
>> [  334.881586] smpboot: Booting Node 0 Processor 10 APIC 0x13
>> [  334.884946] CPU10 is up
>> [  334.884974] smpboot: Booting Node 0 Processor 11 APIC 0x15
>> [  334.888415] CPU11 is up
>> [  334.901008] ACPI: PM: Waking up from system sleep state S4
>> [  335.001313] usb usb4: root hub lost power or was reset
>> [  335.001314] usb usb2: root hub lost power or was reset
>> [  335.001314] usb usb5: root hub lost power or was reset
>> [  335.001365] usb usb1: root hub lost power or was reset
>> [  335.001372] usb usb6: root hub lost power or was reset
>> [  335.001375] usb usb7: root hub lost power or was reset
>> [  335.001428] usb usb8: root hub lost power or was reset
>> [  335.001449] usb usb3: root hub lost power or was reset
>> [  335.297280] usb 3-4: reset high-speed USB device number 2 using ehci-pci
>> [  335.537215] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [  335.549624] ata1.00: configured for UDMA/133
>> [  335.549810] ata1.00: Enabling discard_zeroes_data
>> [  335.769243] usb 3-4.3: reset full-speed USB device number 3 using ehci-pci
>> [  335.957245] usb 3-4.4: reset full-speed USB device number 4 using ehci-pci
>> [  336.385247] usb 3-4.4.1: reset full-speed USB device number 5 using ehci-pci
>> [  336.539864] PM: hibernation: Basic memory bitmaps freed
>> [  336.540367] OOM killer enabled.
>> [  336.540368] Restarting tasks ... 
>> [  336.541593] done.
>> [  336.541600] PM: hibernation: hibernation exit
>> [  336.636953] RTL8211B Gigabit Ethernet r8169-0-800:00: attached PHY driver (mii_bus:phy_addr=r8169-0-800:00, irq=MAC)
>> [  336.703336] r8169 0000:08:00.0 enp8s0: Link is Down
>> [  336.704991] RTL8211B Gigabit Ethernet r8169-0-900:00: attached PHY driver (mii_bus:phy_addr=r8169-0-900:00, irq=MAC)
>> [  336.772497] r8169 0000:09:00.0 enp9s0: Link is Down
>>
>> [  463.977280] sas: Enter sas_scsi_recover_host busy: 3 failed: 3
>> [  463.977288] sas: trying to find task 0x00000000f13c22cf
>> [  463.977292] sas: sas_scsi_find_task: aborting task 0x00000000f13c22cf
>> [  463.977416] sas: task done but aborted
>> [  463.977422] sas: sas_scsi_find_task: task 0x00000000f13c22cf is done
>> [  463.977425] sas: sas_eh_handle_sas_errors: task 0x00000000f13c22cf is done
>> [  463.977429] sas: trying to find task 0x0000000089d39e25
>> [  463.977431] sas: sas_scsi_find_task: aborting task 0x0000000089d39e25
>> [  472.026033] sas: task done but aborted
>> [  472.026040] sas: sas_scsi_find_task: task 0x0000000089d39e25 is done
>> [  472.026044] sas: sas_eh_handle_sas_errors: task 0x0000000089d39e25 is done
>> [  472.026048] sas: trying to find task 0x000000002d226601
>> [  472.026050] sas: sas_scsi_find_task: aborting task 0x000000002d226601
>> [  492.601193] sas: TMF task timeout for 2bad2bad2bad2bad and not done
>> [  492.601204] drivers/scsi/mvsas/mv_sas.c 1410:mvs_abort_task:rc= 5
>> [  492.601208] sas: sas_scsi_find_task: querying task 0x000000002d226601
>> [  513.081228] sas: TMF task timeout for 2bad2bad2bad2bad and not done
>> [  513.081241] drivers/scsi/mvsas/mv_sas.c 1340:mvs_query_task:rc= 5
>> [  513.081247] sas: sas_scsi_find_task: task 0x000000002d226601 failed to abort
>> [  513.081252] sas: task 0x000000002d226601 is not at LU: I_T recover
>> [  513.081255] sas: I_T nexus reset for dev 2bad2bad2bad2bad
>> [  513.577383] drivers/scsi/mvsas/mv_sas.c 1690:Release slot [5] tag[5], task [000000002d226601]:
>> [  513.577396] sas: task done but aborted
>> [  513.577398] drivers/scsi/mvsas/mv_sas.c 1690:Release slot [1] tag[1], task [00000000d0d28957]:
>> [  515.321219] drivers/scsi/mvsas/mv_sas.c 1304:mvs_I_T_nexus_reset for device[0]:rc= 0
>> [  515.321226] sas: I_T 2bad2bad2bad2bad recovered
>> [  515.321243] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 3 tries: 1
>> [  515.337273] sd 0:0:0:0: [sdb] tag#8 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=81s
>> [  515.337281] sd 0:0:0:0: [sdb] tag#8 CDB: Read(10) 28 00 11 77 78 98 00 04 00 00
>> [  515.337283] I/O error, dev sdb, sector 293042328 op 0x0:(READ) flags 0x4000 phys_seg 8 prio class 2
>> [  515.337299] sd 0:0:0:0: [sdb] tag#9 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=81s
>> [  515.337303] sd 0:0:0:0: [sdb] tag#9 CDB: Read(10) 28 00 11 77 7c 98 00 04 00 00
>> [  515.337305] I/O error, dev sdb, sector 293043352 op 0x0:(READ) flags 0x4000 phys_seg 8 prio class 2
>> [  515.337315] sd 0:0:0:0: [sdb] tag#10 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=81s
>> [  515.337318] sd 0:0:0:0: [sdb] tag#10 CDB: Read(10) 28 00 11 77 80 98 00 04 00 00
>> [  515.337320] I/O error, dev sdb, sector 293044376 op 0x0:(READ) flags 0x4000 phys_seg 9 prio class 2
>> [  515.710666] drivers/scsi/mvsas/mv_sas.c 1099:set wide port phy map 2
>> [  515.710714] sas: sas_form_port: phy1 belongs to port0 already(1)!
>> [  519.721300] drivers/scsi/mvsas/mv_sas.c 1690:Release slot [1] tag[1], task [00000000d0d28957]:
>> [  521.822694] drivers/scsi/mvsas/mv_sas.c 1099:set wide port phy map 2
>> [  521.822702] sas: sas_form_port: phy1 belongs to port0 already(1)!

This one is not libata :) So the adapter driver itself may have an issue.

-- 
Damien Le Moal
Western Digital Research

