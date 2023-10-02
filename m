Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3D67B5BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjJBUEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjJBUEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:04:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258ACB4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 13:04:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CDFC433C8;
        Mon,  2 Oct 2023 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696277069;
        bh=QfIjIIA7pnZYZcoivXnRsNr37t8TQJ5EwfPC5niWPmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIHvUI6IX5Nf+sEt9J+gFJkuvjwPaZS8t6DRdyx8A16gPOnyFUt+TP7ZsLYPsA12Y
         DCXInBsEq8gypMJb/4pzLwMVbF/+Ywu9Xpd3Sfhds+7mpy3xmEFiWVV6qS+1JpHk2x
         Fnrg2tqmA3nBAB+BuuIrCiq9IOspMdqiJcaDq+JzU2mRr5XgksU06mtTc8G/95/Tik
         dx6QNR0CjnTbRxmTQHMcuNfyMKbgJJrjYukeEjvFCXp7hFVgCX/6QYpD2KNanMto/z
         rMmaP+9tDqkVq9XDJampGPRvM5btEJYzk88snzUi6Dtn8KFnkcKQwaoxVkN1+IqLVe
         gqbIjCkA/xFEQ==
Date:   Mon, 2 Oct 2023 13:04:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Adam Dunlap <acdunlap@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Peter Gonda <pgonda@google.com>,
        David Rientjes <rientjes@google.com>,
        Khalid ElMously <khalid.elmously@canonical.com>,
        Jacob Xu <jacobhxu@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] x86/sev-es: Only set x86_virt_bits to correct
 value
Message-ID: <20231002200426.GA4127272@dev-arch.thelio-3990X>
References: <20230912002703.3924521-1-acdunlap@google.com>
 <20230912002703.3924521-3-acdunlap@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912002703.3924521-3-acdunlap@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Mon, Sep 11, 2023 at 05:27:03PM -0700, Adam Dunlap wrote:
> Instead of setting x86_virt_bits to a possibly-correct value and then
> correcting it later, do all the necessary checks before setting it.
> 
> At this point, the #VC handler references boot_cpu_data.x86_virt_bits,
> and in the previous version, it would be triggered by the cpuids between
> the point at which it is set to 48 and when it is set to the correct
> value.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Adam Dunlap <acdunlap@google.com>

Our continuous integration started seeing panics when booting ARCH=i386
without KVM after this change landed in -tip as commit fbf6449f84bf
("x86/sev-es: Set x86_virt_bits to the correct value straight away,
instead of a two-phase approach"):

https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/6374441341/job/17299441736

I can reproduce this with GCC 13.2.0 from kernel.org and QEMU 8.1.1 (in
case those versions matter):

https://mirrors.edge.kernel.org/pub/tools/crosstool/

$ make -skj"$(nproc)" ARCH=i386 CROSS_COMPILE=i386-linux- defconfig bzImage

$ qemu-system-i386 \
    -display none \
    -nodefaults \
    -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
    -kernel arch/x86/boot/bzImage \
    -initrd rootfs.cpio \
    -m 512m \
    -serial mon:stdio
[    0.000000] Linux version 6.6.0-rc1-00008-gfbf6449f84bf (nathan@dev-arch.thelio-3990X) (i386-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Mon Oct  2 12:55:06 MST 2023
...
[    0.061831] BUG: kernel NULL pointer dereference, address: 00000020
[    0.062135] #PF: supervisor write access in kernel mode
[    0.062279] #PF: error_code(0x0002) - not-present page
[    0.062430] *pde = 00000000
[    0.062602] Oops: 0002 [#1] PREEMPT SMP
[    0.062839] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc1-00008-gfbf6449f84bf #1
[    0.063086] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[    0.063515] EIP: __ring_buffer_alloc+0x3a/0x1a4
[    0.064135] Code: 8b 15 74 da c2 ce 8d 42 6f f7 da 21 d0 ba c0 0d 00 00 e8 2d d0 07 00 85 c0 0f 84 15 01 00 00 8b 4d f0 89 c3 81 c6 f3 0f 00 00 <c7> 40 10 00 00 00 00 8d 40 4c ba 2d a7 8b ce 89 78 b4 c7 40 ec 60
[    0.064795] EAX: 00000010 EBX: 00000010 ECX: ced82e8d EDX: 00000dc0
[    0.064970] ESI: 00001ff3 EDI: 00000001 EBP: cea3df54 ESP: cea3df44
[    0.065151] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00200006
[    0.065347] CR0: 80050033 CR2: 00000020 CR3: 0ed2d000 CR4: 00000090
[    0.065596] Call Trace:
[    0.066142]  ? show_regs+0x4d/0x54
[    0.066293]  ? __die+0x21/0x68
[    0.066383]  ? page_fault_oops+0x18c/0x368
[    0.066502]  ? kernelmode_fixup_or_oops.constprop.0+0x84/0xdc
[    0.066663]  ? __bad_area_nosemaphore.constprop.0+0x125/0x1dc
[    0.066811]  ? __alloc_pages+0x156/0xe34
[    0.066920]  ? bad_area_nosemaphore+0x12/0x18
[    0.067036]  ? do_user_addr_fault+0x133/0x3e8
[    0.067156]  ? exc_page_fault+0x51/0x13c
[    0.067269]  ? pvclock_clocksource_read_nowd+0x110/0x110
[    0.067421]  ? handle_exception+0x133/0x133
[    0.067553]  ? pvclock_clocksource_read_nowd+0x110/0x110
[    0.067724]  ? __ring_buffer_alloc+0x3a/0x1a4
[    0.067846]  ? pvclock_clocksource_read_nowd+0x110/0x110
[    0.067983]  ? __ring_buffer_alloc+0x3a/0x1a4
[    0.068113]  early_trace_init+0xab/0x390
[    0.068296]  ? ring_buffer_reset_online_cpus+0xfc/0xfc
[    0.068443]  start_kernel+0x217/0x650
[    0.068542]  ? set_init_arg+0x70/0x70
[    0.068643]  i386_start_kernel+0x43/0x44
[    0.068754]  startup_32_smp+0x156/0x158
[    0.068960] Modules linked in:
[    0.069166] CR2: 0000000000000020
[    0.069495] ---[ end trace 0000000000000000 ]---
[    0.069653] EIP: __ring_buffer_alloc+0x3a/0x1a4
[    0.069781] Code: 8b 15 74 da c2 ce 8d 42 6f f7 da 21 d0 ba c0 0d 00 00 e8 2d d0 07 00 85 c0 0f 84 15 01 00 00 8b 4d f0 89 c3 81 c6 f3 0f 00 00 <c7> 40 10 00 00 00 00 8d 40 4c ba 2d a7 8b ce 89 78 b4 c7 40 ec 60
[    0.070249] EAX: 00000010 EBX: 00000010 ECX: ced82e8d EDX: 00000dc0
[    0.070412] ESI: 00001ff3 EDI: 00000001 EBP: cea3df54 ESP: cea3df44
[    0.070577] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00200006
[    0.070761] CR0: 80050033 CR2: 00000020 CR3: 0ed2d000 CR4: 00000090
[    0.071023] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.071643] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
...

In case it is necessary, our rootfs image is available at
https://github.com/ClangBuiltLinux/boot-utils/releases.

As mentioned before, this interestingly does not reproduce with
'-enable-kvm', so it could be potentially related to QEMU's TCG. If
there is any additional information I can provide or patches I can test,
I am more than happy to do so.

Cheers,
Nathan

# bad: [18a1f37f57ff28fa544124151ef0171ffdafd162] Merge branch into tip/master: 'x86/tdx'
# good: [9f3ebbef746f89f860a90ced99a359202ea86fde] Merge tag '6.6-rc3-ksmbd-server-fixes' of git://git.samba.org/ksmbd
git bisect start '18a1f37f57ff28fa544124151ef0171ffdafd162' '9f3ebbef746f89f860a90ced99a359202ea86fde'
# good: [6395aa368403d595c8aab4ee1ac451b84fb37640] Merge branch into tip/master: 'sched/core'
git bisect good 6395aa368403d595c8aab4ee1ac451b84fb37640
# good: [7eddb9db1104079c5f5ac6b17a46f7a7860cf444] Merge branch into tip/master: 'x86/boot'
git bisect good 7eddb9db1104079c5f5ac6b17a46f7a7860cf444
# good: [3fb58599f5a9efaa422c9c9e78e3e799a58d4f63] Merge branch into tip/master: 'x86/entry'
git bisect good 3fb58599f5a9efaa422c9c9e78e3e799a58d4f63
# bad: [062ce2831f0526dec8930a35f1624c0ae50dd667] Merge branch into tip/master: 'x86/platform'
git bisect bad 062ce2831f0526dec8930a35f1624c0ae50dd667
# good: [f4c5ca9850124fb5715eff06cffb1beed837500c] x86_64: Show CR4.PSE on auxiliaries like on BSP
git bisect good f4c5ca9850124fb5715eff06cffb1beed837500c
# good: [24775700eaa93ff83b2a0f1e005879cdf186cdd9] x86/amd_nb: Add AMD Family MI300 PCI IDs
git bisect good 24775700eaa93ff83b2a0f1e005879cdf186cdd9
# bad: [fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6] x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach
git bisect bad fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6
# good: [f79936545fb122856bd78b189d3c7ee59928c751] x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot
git bisect good f79936545fb122856bd78b189d3c7ee59928c751
# first bad commit: [fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6] x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach
