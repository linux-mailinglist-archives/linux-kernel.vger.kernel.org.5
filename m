Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ACA792F08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbjIETga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbjIETg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:36:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD1133;
        Tue,  5 Sep 2023 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693942569; x=1725478569;
  h=message-id:date:mime-version:from:to:subject:
   content-transfer-encoding;
  bh=BDSU9VeQX+hx4LFIZFqAP9tcR3BeCxhLtM7LqGrq/9k=;
  b=Cx+1EYAweQc+mwJ9HPMvJkL1FTHOzItna3h8m/jLR867VHZOY1SRphgi
   c84QJMOD2UX+CC9Xstr4PB6I3k4CeP2MJCWhRWy/9pAVZAG83619VDitF
   Id1ZVu+LM6m4LfvEu196SrB/oUWWRFY5DWLcyjKSOpZ0fqpM0ch313hHz
   YJDhYxDGgfL6nVG0Ugfjx9p8dzeAQEz65b071FaobFBTXb8YT8QClkRKU
   TmwNiZkrjlVfW0Z8pvtg9DpWhG6tJVv/mn6V7WLfzr0LF8+9Fg0OJMjWU
   s/hW7UBKgv64i4OvkkOOuRq6X+x7L90CEdKSOh05/XD1nKeKbVJXVNq1H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="440854975"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="440854975"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 12:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="691029488"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="691029488"
Received: from jsyoungb-mobl3.amr.corp.intel.com (HELO [10.212.138.7]) ([10.212.138.7])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 12:10:02 -0700
Message-ID: <700df3c4-2f6c-85f9-6c61-065bc5b2db3a@intel.com>
Date:   Tue, 5 Sep 2023 12:10:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
From:   Dave Hansen <dave.hansen@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Rajaram Regupathy <rajaram.regupathy@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wayne Chang <waynec@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-usb@vger.kernel.org
Subject: ucsi debugfs oops (current Linus pre-6.6-rc1)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some problems booting Linus's current tree.  It seems to have
happened in some content between commit 3f86ed6ec0b3 and df0383ffad.

I'm suspecting this commit:

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df0383ffad64dc09954a60873c1e202b47f08d90

I'm seeing a null pointer oops on this line:

void ucsi_debugfs_unregister(struct ucsi *ucsi)
{
===>    debugfs_remove_recursive(ucsi->debugfs->dentry);
        kfree(ucsi->debugfs);
}

on this instruction:

    66 0f 1f 00             nop    WORD PTR [rax]
    0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
    53                      push   rbx
    48 8b 47 38             mov    rax,QWORD PTR [rdi+0x38]
    48 89 fb                mov    rbx,rdi
=>  48 8b 78 20             mov    rdi,QWORD PTR [rax+0x20]
    e8 36 16 26 e1          call   0xffffffffe1261669
    48 8b 7b 38             mov    rdi,QWORD PTR [rbx+0x38]
    5b                      pop    rbx
    e9 5c 79 03 e1          jmp    0xffffffffe1037999

That's the second dereference in the function, so I assume this is
trying to dereference 'debugfs' above.  It appears that this is some
failure/error path out of ucsi_acpi_probe() that's not handled correctly.

Probably this:

>         if (ACPI_FAILURE(status)) { 
>                 dev_err(&pdev->dev, "failed to install notify handler\n");
>                 ucsi_destroy(ua->ucsi);
>                 return -ENODEV;
>         }
> 
>         ret = ucsi_register(ua->ucsi);

where ucsi_destroy() is called before ucsi_register().  Although I do
_not_ see the dev_err() message anywhere.

Full oops is below.

I'll try putting some hacks in place to avoid the null pointer.  Also,
please forgive the lack of a bisect for the moment.  This is happening
on my main laptop and it's a mild pain to do bisects on here.

> [    4.903493] BUG: kernel NULL pointer dereference, address: 0000000000000020^M
> [    4.905624] #PF: supervisor read access in kernel mode^M
> [    4.907326] #PF: error_code(0x0000) - not-present page^M
> [    4.908993] PGD 0 P4D 0 ^M
> [    4.910998] Oops: 0000 [#1] PREEMPT SMP NOPTI^M
> [    4.913077] CPU: 6 PID: 150 Comm: systemd-udevd Not tainted 6.5.0-11704-g3f86ed6ec0b3 #138^M
> [    4.915211] Hardware name: Framework Laptop/FRANBMCP0B, BIOS 03.10 07/19/2022^M
> [    4.917355] RIP: 0010:ucsi_debugfs_unregister+0x11/0x30 [typec_ucsi]^M
> [    4.919705] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 53 48 8b 47 38 48 89 fb <48> 8b 78 20 e8 36 16 26 e1 48 8b 7b 38 5b e9 5c 79 03 e1 66 66 2e^M
> [    4.921982] RSP: 0018:ffffc900007e7bb8 EFLAGS: 00010246^M
> [    4.924227] RAX: 0000000000000000 RBX: ffff888101b2be00 RCX: 0000000000009a06^M
> [    4.926752] RDX: 0000000000000000 RSI: ffff888104491798 RDI: ffff888101b2be00^M
> [    4.929312] RBP: ffff888101b2be00 R08: 0000000000009906 R09: 00000000000333f0^M
> [    4.931887] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffed^M
> [    4.934451] R13: ffff888102594810 R14: ffff888100653600 R15: ffff888101fa7f78^M
> [    4.937115] FS:  00007f5dd0fb48c0(0000) GS:ffff88906fb80000(0000) knlGS:0000000000000000^M
> [    4.939581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> [    4.941308] CR2: 0000000000000020 CR3: 0000000105070005 CR4: 0000000000f70ee0^M
> [    4.943022] PKRU: 55555554^M
> [    4.944731] Call Trace:^M
> [    4.946438]  <TASK>^M
> [    4.948167]  ? __die+0x24/0x70^M
> [    4.949864]  ? page_fault_oops+0x15b/0x440^M
> [    4.951563]  ? acpi_evaluate_object+0x190/0x2f0^M
> [    4.953201]  ? _raw_spin_lock_irqsave+0x28/0x50^M
> [    4.954841]  ? exc_page_fault+0x6e/0x160^M
> [    4.956461]  ? asm_exc_page_fault+0x26/0x30^M
> [    4.958067]  ? ucsi_debugfs_unregister+0x11/0x30 [typec_ucsi]^M
> [    4.959677]  ucsi_destroy+0x12/0x20 [typec_ucsi]^M
> [    4.961298]  ucsi_acpi_probe+0x1cc/0x230 [ucsi_acpi]^M
> [    4.962908]  platform_probe+0x40/0xb0^M
> [    4.964522]  really_probe+0x1a2/0x410^M
> [    4.966110]  __driver_probe_device+0x78/0x160^M
> [    4.967735]  driver_probe_device+0x1e/0x90^M
> [    4.969306]  __driver_attach+0xd6/0x1d0^M
> [    4.970874]  ? __pfx___driver_attach+0x10/0x10^M
> [    4.972449]  bus_for_each_dev+0x79/0xd0^M
> [    4.974022]  bus_add_driver+0x116/0x220^M
> [    4.975600]  driver_register+0x60/0x120^M
> [    4.977169]  ? __pfx_ucsi_acpi_platform_driver_init+0x10/0x10 [ucsi_acpi]^M
> [    4.978762]  do_one_initcall+0x45/0x220^M
> [    4.980367]  ? kmalloc_trace+0x29/0x90^M
> [    4.981952]  do_init_module+0x90/0x260^M
> [    4.983530]  init_module_from_file+0x8b/0xd0^M
> [    4.985087]  idempotent_init_module+0x181/0x240^M
> [    4.986639]  __x64_sys_finit_module+0x5e/0xb0^M
> [    4.988198]  do_syscall_64+0x3c/0x90^M
> [    4.989739]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8^M
> [    4.991290] RIP: 0033:0x7f5dd16aaa3d^M
