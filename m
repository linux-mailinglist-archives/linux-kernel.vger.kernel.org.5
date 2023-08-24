Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2358778740F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbjHXPZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241806AbjHXPZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D1C19B4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2817267273
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBCAC433A9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692890716;
        bh=zM6juq8xM0ioLZjO8HqYn5YlFgyLKPSxXfTQouHy1Hk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iAGUTPCdoT0+BiGAKECcZToTz02uLWO/Idp4vZwu6ONMRNNmy2WFeMU/N6j5RziNU
         +cccaXU+seqG8zDkrmJlEttgWBBnh79kpaQkImLjCHRiujliOy3KgOLHsbkhmqobJK
         PrFVYLHsP1RUDuYWtWLCWWz/nl7/2hGt2prRYPV1V13NRKswXTy/0lf2ARQ9xoxiqg
         J81yjHuYWgrcxi6jg3GDzcKHAOVKyn/16mwESCE2wN9u7PhpVWYjlX+6LyjVjSaRGj
         Wrf2/EGHFFMDtev9toHXdM+pwY5yvoNw39yBjINu68mGXtHYZeyGfuE54yDezq+kod
         0X5klGTkOGbkw==
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1bf078d5f33so82365ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:25:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YyLTr0u/AzLOidxRDia+QomVQQg4t0WFUWjMqUl2dT2AYj8pxMC
        KCZ31m1/5VQzrU7TLV4YlKb4X+13RiK7hpivCVgusA==
X-Google-Smtp-Source: AGHT+IEHow0McqsBMgXtEFTtyq5RM47lr+urwT6cDnN6OOUx+FsmxIKCak8O1onoCCYUeUTYf0QnN3a8nC1/6bTr9v0=
X-Received: by 2002:a17:90a:4dc6:b0:26d:2fe5:ff2a with SMTP id
 r6-20020a17090a4dc600b0026d2fe5ff2amr14176041pjl.29.1692890715658; Thu, 24
 Aug 2023 08:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-free_pcppages_bulk-v1-2-c14574a9f80c@kernel.org> <202308241221.cc5ac84a-oliver.sang@intel.com>
In-Reply-To: <202308241221.cc5ac84a-oliver.sang@intel.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 24 Aug 2023 08:25:03 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNNcs5+0V4L9xC=DJSkDbUDj=61=70cw7FrKfgrHD60MA@mail.gmail.com>
Message-ID: <CAF8kJuNNcs5+0V4L9xC=DJSkDbUDj=61=70cw7FrKfgrHD60MA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] mm/page_alloc: free_pcppages_bulk clean up
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        baolin.wang@linux.alibaba.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

Indeed, that is my bad. Thanks for reporting it.

The patch has been sitting in my tree for a very long time.
When I adopt it for the later kernel, I accidentally drop this chunk:

-                       if (!list_empty(list))
-                               break;

I think that is what is missing. I will address that in the V2 and do
more testing before I send it out.

On Wed, Aug 23, 202

>
> in testcase: boot
>
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)

The kernel test robot is very interesting.
I see that is how to start the qemu system.

How do I invoke the test once I have qemu up and running with my testing kernel?

I want to replicate it before I send out the V2 version.

Chris

>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308241221.cc5ac84a-oliver.sang@intel.com
>
>
>
> [   15.890907][    C0] BUG: kernel NULL pointer dereference, address: 00000005
> [   15.891555][    C0] #PF: supervisor read access in kernel mode
> [   15.892037][    C0] #PF: error_code(0x0000) - not-present page
> [   15.893161][    C0] *pdpt = 000000002c9e7001 *pde = 0000000000000000
> [   15.894410][    C0] Oops: 0000 [#1] SMP PTI
> [   15.895385][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G            E      6.5.0-rc4-00242-g3373e582e78e #1
> [   15.896801][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   15.898250][    C0] EIP: free_pcppages_bulk+0x7d/0x200
> [   15.899281][    C0] Code: 8d 34 c6 89 75 e4 83 f8 0c 0f 84 ee 00 00 00 ba ab aa aa aa f7 e2 b8 01 00 00 00 89 d1 d1 e9 d3 e0 89 45 e0 8b 45 e4 8b 50 04 <8b> 72 04
>  8d 5a fc 83 ee 04 39 c2 0f 84 0a 01 00 00 89 4d e8 eb 28
> [   15.914130][    C0] EAX: e4c7520c EBX: e4c9f510 ECX: 55555555 EDX: 00000001
> [   15.915477][    C0] ESI: e4c7520c EDI: e4c75200 EBP: c1819d98 ESP: c1819d60
> [   15.916755][    C0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210006
> [   15.918067][    C0] CR0: 80050033 CR2: 00000005 CR3: 2ca6a000 CR4: 000406f0
> [   15.919278][    C0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   15.920468][    C0] DR6: fffe0ff0 DR7: 00000400
> [   15.921446][    C0] Call Trace:
> [   15.922298][    C0]  <SOFTIRQ>
> [   15.923149][    C0]  ? show_regs+0x55/0x80
> [   15.924069][    C0]  ? __die+0x1d/0x80
> [   15.924934][    C0]  ? page_fault_oops+0x65/0xc0
> [   15.925890][    C0]  ? kernelmode_fixup_or_oops+0x73/0x100
> [   15.926986][    C0]  ? __bad_area_nosemaphore+0xdc/0x1c0
> [   15.928086][    C0]  ? bad_area_nosemaphore+0xf/0x40
> [   15.929061][    C0]  ? do_user_addr_fault+0x1ac/0x3c0
> [   15.930036][    C0]  ? exc_page_fault+0x51/0x140
> [   15.930957][    C0]  ? pvclock_clocksource_read_nowd+0x140/0x140
> [   15.931997][    C0]  ? handle_exception+0x133/0x133
> [   15.932938][    C0]  ? pmd_clear_huge+0x7b/0x80
> [   15.934885][    C0]  ? pvclock_clocksource_read_nowd+0x140/0x140
> [   15.935963][    C0]  ? free_pcppages_bulk+0x7d/0x200
> [   15.936915][    C0]  ? pvclock_clocksource_read_nowd+0x140/0x140
> [   15.937954][    C0]  ? free_pcppages_bulk+0x7d/0x200
> [   15.938876][    C0]  free_unref_page_commit+0x120/0x180
> [   15.939826][    C0]  free_unref_page+0xe7/0x100
> [   15.940688][    C0]  __free_pages+0x87/0xc0
> [   15.941519][    C0]  __free_slab+0xa1/0x100
> [   15.942383][    C0]  free_slab+0x27/0xc0
> [   15.943187][    C0]  discard_slab+0x38/0x40
> [   15.944014][    C0]  __unfreeze_partials+0x20c/0x240
> [   15.946439][    C0]  put_cpu_partial+0x5b/0x80
> [   15.947347][    C0]  __slab_free+0x287/0x380
> [   15.948207][    C0]  ? __mod_memcg_lruvec_state+0x3e/0x80
> [   15.949138][    C0]  kmem_cache_free+0x329/0x340
> [   15.950003][    C0]  ? mt_free_rcu+0x10/0x40
> [   15.950805][    C0]  ? free_task+0x4d/0x80
> [   15.951594][    C0]  ? mt_free_rcu+0x10/0x40
> [   15.952390][    C0]  mt_free_rcu+0x10/0x40
> [   15.953181][    C0]  rcu_do_batch+0x158/0x440
> [   15.953998][    C0]  rcu_core+0xce/0x1c0
> [   15.954751][    C0]  rcu_core_si+0xd/0x40
> [   15.955512][    C0]  __do_softirq+0xad/0x233
> [   15.956293][    C0]  ? __lock_text_end+0x3/0x3
> [   15.957084][    C0]  call_on_stack+0x45/0x80
> [   15.957871][    C0]  </SOFTIRQ>
> [   15.958525][    C0]  ? irq_exit_rcu+0x6a/0xc0
> [   15.959284][    C0]  ? sysvec_apic_timer_interrupt+0x27/0x40
> [   15.960136][    C0]  ? handle_exception+0x133/0x133
> [   15.960900][    C0]  ? alarm_handle_timer+0xfb/0x100
> [   15.961669][    C0]  ? sysvec_call_function_single+0x40/0x40
> [   15.962542][    C0]  ? default_idle+0xb/0x40
> [   15.963234][    C0]  ? sysvec_call_function_single+0x40/0x40
> [   15.964026][    C0]  ? default_idle+0xb/0x40
> [   15.964703][    C0]  ? arch_cpu_idle+0x8/0x40
> [   15.965379][    C0]  ? default_idle_call+0x2a/0xc0
> [   15.967867][    C0]  ? cpuidle_idle_call+0x122/0x180
> [   15.968680][    C0]  ? do_idle+0x79/0xc0
> [   15.969357][    C0]  ? cpu_startup_entry+0x25/0x40
> [   15.970106][    C0]  ? rest_init+0x96/0xc0
> [   15.970770][    C0]  ? arch_call_rest_init+0xd/0x80
> [   15.971505][    C0]  ? start_kernel+0x347/0x480
> [   15.972209][    C0]  ? early_idt_handler_common+0x44/0x44
> [   15.972969][    C0]  ? i386_start_kernel+0x48/0x80
> [   15.973678][    C0]  ? startup_32_smp+0x156/0x158
> [   15.974397][    C0] Modules linked in: intel_rapl_msr(E) intel_rapl_common(E) ata_generic(E) ppdev(E) crc32_pclmul(E) crc32c_intel(E) aesni_intel(E) ipmi_devintf(
> E) ipmi_msghandler(E) crypto_simd(E) ata_piix(E) cryptd(E) rapl(E) i2c_piix4(E) psmouse(E) evdev(E) serio_raw(E) bochs(E) drm_vram_helper(E) drm_kms_helper(E) drm_tt
> m_helper(E) ttm(E) libata(E) parport_pc(E) floppy(E) parport(E) qemu_fw_cfg(E) button(E) drm(E) configfs(E) fuse(E) autofs4(E)
> [   15.978905][    C0] CR2: 0000000000000005
> [   15.979621][    C0] ---[ end trace 0000000000000000 ]---
> [   15.980419][    C0] EIP: free_pcppages_bulk+0x7d/0x200
> [   15.981222][    C0] Code: 8d 34 c6 89 75 e4 83 f8 0c 0f 84 ee 00 00 00 ba ab aa aa aa f7 e2 b8 01 00 00 00 89 d1 d1 e9 d3 e0 89 45 e0 8b 45 e4 8b 50 04 <8b> 72 04
>  8d 5a fc 83 ee 04 39 c2 0f 84 0a 01 00 00 89 4d e8 eb 28
> [   15.983663][    C0] EAX: e4c7520c EBX: e4c9f510 ECX: 55555555 EDX: 00000001
> [   15.984705][    C0] ESI: e4c7520c EDI: e4c75200 EBP: c1819d98 ESP: c1819d60
> [   15.985738][    C0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210006
> [   15.986822][    C0] CR0: 80050033 CR2: 00000005 CR3: 2ca6a000 CR4: 000406f0
> [   15.987832][    C0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   15.988839][    C0] DR6: fffe0ff0 DR7: 00000400
> [   15.989679][    C0] Kernel panic - not syncing: Fatal exception in interrupt
> [   15.996118][    C0] Kernel Offset: disabled
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230824/202308241221.cc5ac84a-oliver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
