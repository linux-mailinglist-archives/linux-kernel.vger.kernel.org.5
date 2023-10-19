Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3247CF01D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjJSGff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSGfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:35:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E8CBE;
        Wed, 18 Oct 2023 23:35:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8949AC433C7;
        Thu, 19 Oct 2023 06:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697697329;
        bh=KA6O+8wuL7bGbE8RNGjJQMf6hGTC2K3wIvLXI7A/9h8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVAqBUXatrh6lsx7lizXLecsW9xI+CWJ0TqjTi8U+rIBtOohwBaDyp/s1bqa4Y4fx
         CNS8JcSz2PKjLXJhhtvk1/9YTDOD7eNpzqkybbEPWra3a6lbhlazAznTRbqXW3ceet
         WCs90WuqSpDVQ/m46Eyv6RAn2SD6RgUd+J7X8N0LPZ0Kmuu0aGnAW0jXVIdDxZS3N0
         7oNFdrTe/waoS6/M8qkS2m/M6DE2/O8c2ZlKfKrK/32koxpYiqdXzXNvwBY+sSDs0Z
         qfT7d4Hr5gud3x0ZMbRv3m+U81ZPzEB9XoHE/r37ckVHOMA4kj8Pab2QcTiU4PMBRb
         S3FBUJgNm1Kbg==
Date:   Wed, 18 Oct 2023 23:35:27 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231019063527.iwgyioxi2gznnshp@treble>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:37:47PM +0200, Borislav Petkov wrote:
> +++ b/arch/x86/kernel/alternative.c
> @@ -748,14 +748,20 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
>                         continue;
>  
>                 op = insn.opcode.bytes[0];
> -               if (op == JMP32_INSN_OPCODE)
> +               if (op == JMP32_INSN_OPCODE || op == JMP8_INSN_OPCODE)
>                         dest = addr + insn.length + insn.immediate.value;

I can recreate (with my GCC 12) by disabling CONFIG_CALL_DEPTH_TRACKING
and CONFIG_CPU_SRSO, which puts __x86_return_thunk() close enough to the
retpolines to enable the two-byte JMP in the last retpoline.  And then
booting with spectre_v2=retpoline.

(Then to force two-byte JMPs for more retpolines, I cheated and just
moved __x86_return_thunk() to right after the retpolines.)

Your WARN patch didn't seem to fix the no-output hang for me, maybe due
to recursive warnings?

I was able to get more output by changing the WARN to (ahem) WARN_ONCE,
but it's still getting into some kind of stack corruption.  Full output
below.  I haven't had a chance to look further, but it's worrisome that
even the WARN_ONCE isn't being recovered from.

Regardless of if we revert e92626af3234 ("x86/retpoline: Remove
.text..__x86.return_thunk section"), or do the above patch, we still
need to figure out why even WARN_ONCE() would be borking things.

Off to bed...

[    0.403286] ------------[ cut here ]------------
[    0.403286] missing return thunk: __x86_indirect_thunk_r12+0xa/0x20-0x0: eb 74 66 66 2e
[    0.403286] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:742 apply_returns+0xca/0x23a
[    0.403286] Modules linked in:
[    0.403286] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc2+ #193
[    0.403286] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[    0.403286] RIP: 0010:apply_returns+0xca/0x23a
[    0.403286] Code: 80 3d fa e2 65 01 00 75 b4 49 89 d8 b9 05 00 00 00 48 89 ea 48 89 de 48 c7 c7 c0 35 1a 82 c6 05 dc e2 65 01 01 e8 00 2c 0a 00 <0f> 0b eb 8f f6 05 50 18 e3 01 02 74 26 0f b6 54 24 52 48 63 44 24
[    0.403286] RSP: 0000:ffffffff82403e30 EFLAGS: 00010282
[    0.403286] RAX: 0000000000000000 RBX: ffffffff81aa100a RCX: 0000000000000003
[    0.403286] RDX: 0000000000000003 RSI: 0000000000000003 RDI: 0000000000000001
[    0.403286] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[    0.403286] R10: 0000000000000003 R11: ffffffff82403961 R12: ffffffff82e421f4
[    0.403286] R13: ffffffff82e42218 R14: ffffffff82411f40 R15: 0000000000093cb0
[    0.403286] FS:  0000000000000000(0000) GS:ffff88817b600000(0000) knlGS:0000000000000000
[    0.403286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.403286] CR2: ffff88817ffff000 CR3: 000000000243c001 CR4: 0000000000770ef0
[    0.403286] PKRU: 55555554
[    0.403286] Call Trace:
[    0.403286]  <TASK>
[    0.403286]  ? __warn+0xab/0x148
[    0.403286]  ? report_bug+0x109/0x17e
[    0.403286]  ? apply_returns+0xca/0x23a
[    0.403286]  ? handle_bug+0x41/0x6f
[    0.403286]  ? exc_invalid_op+0x13/0x60
[    0.403286]  ? asm_exc_invalid_op+0x16/0x20
[    0.403286]  ? __x86_indirect_thunk_r12+0xa/0x20
[    0.403286]  ? apply_returns+0xca/0x23a
[    0.403286]  ? __x86_indirect_thunk_r12+0xa/0x20
[    0.403286]  ? __x86_indirect_thunk_r12+0x19/0x20
[    0.403286]  ? __x86_indirect_thunk_r12+0xc/0x20
[    0.403286]  alternative_instructions+0x48/0xf5
[    0.403286]  arch_cpu_finalize_init+0xca/0xeb
[    0.403286]  start_kernel+0x588/0x610
[    0.403286]  x86_64_start_reservations+0x25/0x25
[    0.403286]  x86_64_start_kernel+0x73/0x73
[    0.403286]  secondary_startup_64_no_verify+0x166/0x16b
[    0.403286]  </TASK>
[    0.403286] irq event stamp: 116873
[    0.403286] hardirqs last  enabled at (116883): [<ffffffff811497c4>] console_unlock+0xb0/0xfe
[    0.403286] hardirqs last disabled at (116892): [<ffffffff811497a9>] console_unlock+0x95/0xfe
[    0.403286] softirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.403286] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.403286] ---[ end trace 0000000000000000 ]---
[    0.403286] ------------[ cut here ]------------
[    0.403286] Unconverted return thunk
[    0.403286] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/cpu/bugs.c:2855 check_thunks+0x21/0x28
[    0.403286] Modules linked in:
[    0.403286] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.6.0-rc2+ #193
[    0.403286] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[    0.403286] RIP: 0010:check_thunks+0x21/0x28
[    0.403286] Code: be 02 00 00 e9 3b f3 ff ff 0f 1f 44 00 00 80 3d c9 0f 65 01 00 75 15 48 c7 c7 9b 61 1a 82 c6 05 b9 0f 65 01 01 e8 c3 58 09 00 <0f> 0b c3 cc cc cc cc 89 ff e8 54 09 02 00 90 c3 cc cc cc cc 53 89
[    0.403286] RSP: 0000:ffffffff824039f8 EFLAGS: 00010082
[    0.403286] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
[    0.403286] RDX: 0000000000000004 RSI: 0000000000000003 RDI: 0000000000000001
[    0.403286] RBP: ffffffff82403aa8 R08: 0000000000000000 R09: 0000000000000000
[    0.403286] R10: 7574657220646574 R11: 7265766e6f636e55 R12: ffffffff824128c0
[    0.403286] R13: ffffffff8117bdf0 R14: ffffffff82403ab8 R15: ffffffff83097580
[    0.403286] FS:  0000000000000000(0000) GS:ffff88817b600000(0000) knlGS:0000000000000000
[    0.403286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.403286] CR2: ffff88817ffff000 CR3: 000000000243c001 CR4: 0000000000770ef0
[    0.403286] PKRU: 55555554
[    0.403286] Call Trace:
[    0.403286]  <TASK>
[    0.403286]  ? __warn+0xab/0x148
[    0.403286]  ? report_bug+0x109/0x17e
[    0.403286]  ? check_thunks+0x21/0x28
[    0.403286]  ? handle_bug+0x41/0x6f
[    0.403286]  ? exc_invalid_op+0x13/0x60
[    0.403286]  ? asm_exc_invalid_op+0x16/0x20
[    0.403286]  ? write_profile+0x163/0x163
[    0.403286]  ? check_thunks+0x21/0x28
[    0.403286]  ? check_thunks+0x21/0x28
[    0.403286]  __x86_return_thunk+0x5/0x7f
[    0.403286]  write_profile+0x163/0x163
[    0.403286]  arch_stack_walk+0xa3/0xda
[    0.403286]  ? stack_trace_save+0x48/0x6a
[    0.403286]  stack_trace_save+0x48/0x6a
[    0.403286]  save_trace+0x60/0x27a
[    0.403286]  mark_lock+0x108/0x357
[    0.403286]  ? desc_read+0x21/0xc5
[    0.403286]  ? insn_get_prefixes+0x17f/0x248
[    0.403286]  ? insn_get_opcode+0xd8/0x13a
[    0.403286]  __lock_acquire+0x538/0x1108
[    0.403286]  ? skip_nops+0x40/0x8e
[    0.403286]  ? _vm_unmap_aliases+0x58/0x203
[    0.403286]  lock_acquire+0x12b/0x277
[    0.403286]  ? _vm_unmap_aliases+0x58/0x203
[    0.403286]  ? insn_get_displacement+0x29/0x10a
[    0.403286]  ? __copy_user_flushcache+0x1d/0x94
[    0.403286]  ? _vm_unmap_aliases+0x58/0x203
[    0.403286]  __mutex_lock+0xbb/0x3ff
[    0.403286]  ? _vm_unmap_aliases+0x58/0x203
[    0.403286]  ? tracer_hardirqs_on+0x2c/0xd8
[    0.403286]  ? text_poke_early+0x85/0x95
[    0.403286]  ? _vm_unmap_aliases+0x58/0x203
[    0.403286]  _vm_unmap_aliases+0x58/0x203
[    0.403286]  ? __copy_user_flushcache+0x1d/0x94
[    0.403286]  change_page_attr_set_clr+0xc0/0x24f
[    0.403286]  change_page_attr_set.constprop.0+0xf/0x15
[    0.403286]  set_memory_nx+0x27/0x2d
[    0.403286]  free_init_pages+0x54/0x83
[    0.403286]  alternative_instructions+0xe1/0xf5
[    0.403286]  arch_cpu_finalize_init+0xca/0xeb
[    0.403286]  start_kernel+0x588/0x610
[    0.403286]  x86_64_start_reservations+0x25/0x25
[    0.403286]  x86_64_start_kernel+0x73/0x73
[    0.403286]  secondary_startup_64_no_verify+0x166/0x16b
[    0.403286]  </TASK>
[    0.403286] irq event stamp: 122505
[    0.403286] hardirqs last  enabled at (122505): [<ffffffff81033999>] text_poke_early+0x85/0x95
[    0.403286] hardirqs last disabled at (122504): [<ffffffff81033986>] text_poke_early+0x72/0x95
[    0.403286] softirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.403286] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.403286] ---[ end trace 0000000000000000 ]---
[    0.403286] BUG: kernel NULL pointer dereference, address: 0000000000000011
[    0.403286] #PF: supervisor read access in kernel mode
[    0.403286] #PF: error_code(0x0000) - not-present page
[    0.403286] PGD 0 P4D 0
[    0.403286] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    0.403286] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.6.0-rc2+ #193
[    0.403286] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[    0.403286] RIP: 0010:stack_trace_consume_entry+0x5/0x3c
[    0.403286] Code: 48 89 d8 48 8b 54 24 08 65 48 2b 14 25 28 00 00 00 74 05 e8 f9 47 91 00 48 83 c4 10 5b 5d 41 5c c3 cc cc cc cc 0f 1f 44 00 00 <8b> 47 10 31 d2 3b 47 08 73 26 8b 57 0c 85 d2 74 09 ff ca 89 57 0c
[    0.403286] RSP: 0000:ffffffff82403a08 EFLAGS: 00010082
[    0.403286] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
[    0.403286] RDX: 0000000000000004 RSI: 0000000000000003 RDI: 0000000000000001
[    0.403286] RBP: ffffffff82403aa8 R08: 0000000000000000 R09: 0000000000000000
[    0.403286] R10: 7574657220646574 R11: 7265766e6f636e55 R12: ffffffff824128c0
[    0.403286] R13: ffffffff8117bdf0 R14: ffffffff82403ab8 R15: ffffffff83097580
[    0.403286] FS:  0000000000000000(0000) GS:ffff88817b600000(0000) knlGS:0000000000000000
[    0.403286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.403286] CR2: 0000000000000011 CR3: 000000000243c001 CR4: 0000000000770ef0
[    0.403286] PKRU: 55555554
[    0.403286] Call Trace:
[    0.403286]  <TASK>
[    0.403286]  ? __die_body+0x1a/0x5c
[    0.403286]  ? page_fault_oops+0x333/0x380
[    0.403286]  ? do_user_addr_fault+0x125/0x503
[    0.403286]  ? exc_page_fault+0x168/0x19e
[    0.403286]  ? asm_exc_page_fault+0x22/0x30
[    0.403286]  ? write_profile+0x163/0x163
[    0.403286]  ? stack_trace_consume_entry+0x5/0x3c
[    0.403286]  ? write_profile+0x163/0x163
[    0.403286]  arch_stack_walk+0xa3/0xda
[    0.403286]  ? stack_trace_save+0x48/0x6a
[    0.403286]  stack_trace_save+0x48/0x6a
[    0.403286]  save_trace+0x60/0x27a
[    0.403286]  mark_lock+0x108/0x357
[    0.403286]  ? desc_read+0x21/0xc5
[    0.403286]  ? insn_get_prefixes+0x17f/0x248
[    0.403286]  ? insn_get_opcode+0xd8/0x13a
[    0.403286]  __lock_acquire+0x538/0x1108
[    0.403286]  ? skip_nops+0x40/0x8e
[    0.403286]  ? _vm_unmap_aliases+0x58/0x203
[    0.403286]  lock_acquire+0x12b/0x277
[    0.403286]  ? _vm_unmap_aliases+0x58/0x203
[    0.403286]  ? insn_get_displacement+0x29/0x10a
[    0.403286]  ? __copy_user_flushcache+0x1d/0x94
[    0.403286]  ? _vm_unmap_aliases+0x58/0x203
[    0.403286]  __mutex_lock+0xbb/0x3ff
[    0.403286]  ? _vm_unmap_aliases+0x58/0x203
[    0.403286]  ? tracer_hardirqs_on+0x2c/0xd8
[    0.403286]  ? text_poke_early+0x85/0x95
[    0.403286]  ? _vm_unmap_aliases+0x58/0x203
[    0.403286]  _vm_unmap_aliases+0x58/0x203
[    0.403286]  ? __copy_user_flushcache+0x1d/0x94
[    0.403286]  change_page_attr_set_clr+0xc0/0x24f
[    0.403286]  change_page_attr_set.constprop.0+0xf/0x15
[    0.403286]  set_memory_nx+0x27/0x2d
[    0.403286]  free_init_pages+0x54/0x83
[    0.403286]  alternative_instructions+0xe1/0xf5
[    0.403286]  arch_cpu_finalize_init+0xca/0xeb
[    0.403286]  start_kernel+0x588/0x610
[    0.403286]  x86_64_start_reservations+0x25/0x25
[    0.403286]  x86_64_start_kernel+0x73/0x73
[    0.403286]  secondary_startup_64_no_verify+0x166/0x16b
[    0.403286]  </TASK>
[    0.403286] Modules linked in:
[    0.403286] CR2: 0000000000000011
[    0.403286] ---[ end trace 0000000000000000 ]---
[    0.403286] RIP: 0010:stack_trace_consume_entry+0x5/0x3c
[    0.403286] Code: 48 89 d8 48 8b 54 24 08 65 48 2b 14 25 28 00 00 00 74 05 e8 f9 47 91 00 48 83 c4 10 5b 5d 41 5c c3 cc cc cc cc 0f 1f 44 00 00 <8b> 47 10 31 d2 3b 47 08 73 26 8b 57 0c 85 d2 74 09 ff ca 89 57 0c
[    0.403286] RSP: 0000:ffffffff82403a08 EFLAGS: 00010082
[    0.403286] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
[    0.403286] RDX: 0000000000000004 RSI: 0000000000000003 RDI: 0000000000000001
[    0.403286] RBP: ffffffff82403aa8 R08: 0000000000000000 R09: 0000000000000000
[    0.403286] R10: 7574657220646574 R11: 7265766e6f636e55 R12: ffffffff824128c0
[    0.403286] R13: ffffffff8117bdf0 R14: ffffffff82403ab8 R15: ffffffff83097580
[    0.403286] FS:  0000000000000000(0000) GS:ffff88817b600000(0000) knlGS:0000000000000000
[    0.403286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.403286] CR2: 0000000000000011 CR3: 000000000243c001 CR4: 0000000000770ef0
[    0.403286] PKRU: 55555554
[    0.403286] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.403286] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---


-- 
Josh
