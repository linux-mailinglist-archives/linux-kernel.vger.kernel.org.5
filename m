Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0527C7CB51C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjJPVKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjJPVKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:10:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3FD9;
        Mon, 16 Oct 2023 14:10:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7251EC433C7;
        Mon, 16 Oct 2023 21:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697490643;
        bh=7cpEk/t1C/OxwaVPDQHhvdtHVxGFDlQIy3Y2+oNlSC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTJu1mQVJtk/V65idE9k53xWPhJ6W7F9Fsnc1QvsIRWNNJxuMisu7OIKZDavPWBWb
         sLm+rFuGxHLLE0HD2IDy9vR6maMHPsykEdaH0MgcUdQiyz7jIDgzbWTmTCzQyaLSrt
         ZOkVxPl6S4mvTBelo5Lai0ctZgZ/6RnFeSOa9KFSr1ZkuZDwwzvB9k4M8cJLbUhzuy
         pe6KQU/66v/bWXI/lv6A7MP0/bYivZMzZnnaP1z5kTigZHC4VmIL+bAMOyYDRATCdB
         nnuRnzR8nRGRNWG4jCIrtpu5RorW6qsZqkiSZc1zsw1wMFBAx7SD6rYlxD1E3vR22L
         ZshEaDdUkrZpw==
Date:   Mon, 16 Oct 2023 14:10:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        llvm@lists.linux.dev
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231016211040.GA3789555@dev-arch.thelio-3990X>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:50:35PM -0000, tip-bot2 for David Kaplan wrote:
> The following commit has been merged into the x86/bugs branch of tip:
> 
> Commit-ID:     91174087dcc7565d8bf0d576544e42d5b1de6f39
> Gitweb:        https://git.kernel.org/tip/91174087dcc7565d8bf0d576544e42d5b1de6f39
> Author:        David Kaplan <david.kaplan@amd.com>
> AuthorDate:    Thu, 12 Oct 2023 16:10:31 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 12 Oct 2023 19:44:34 +02:00
> 
> x86/retpoline: Ensure default return thunk isn't used at runtime
> 
> All CPU bugs that require a return thunk define a special return thunk
> to use (e.g., srso_return_thunk).  The default thunk,
> __x86_return_thunk, should never be used after apply_returns()
> completes.  Otherwise this could lead to potential speculation holes.
> 
> Enforce this by replacing this thunk with a ud2 when alternatives are
> applied.  Alternative instructions are applied after apply_returns().
> 
> The default thunk is only used during kernel boot, it is not used during
> module init since that occurs after apply_returns().
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local
> ---
>  arch/x86/lib/retpoline.S | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index 6376d01..fe05c13 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -356,15 +356,17 @@ SYM_FUNC_END(call_depth_return_thunk)
>   * This function name is magical and is used by -mfunction-return=thunk-extern
>   * for the compiler to generate JMPs to it.
>   *
> - * This code is only used during kernel boot or module init.  All
> + * This code is only used during kernel boot.  All
>   * 'JMP __x86_return_thunk' sites are changed to something else by
>   * apply_returns().
> + *
> + * This thunk is turned into a ud2 to ensure it is never used at runtime.
> + * Alternative instructions are applied after apply_returns().
>   */
>  SYM_CODE_START(__x86_return_thunk)
>  	UNWIND_HINT_FUNC
>  	ANNOTATE_NOENDBR
> -	ANNOTATE_UNRET_SAFE
> -	ret
> +	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret),"ud2", X86_FEATURE_ALWAYS
>  	int3
>  SYM_CODE_END(__x86_return_thunk)
>  EXPORT_SYMBOL(__x86_return_thunk)

I just bisected a boot failure that our continuous integration sees [1]
with x86_64_defconfig + CONFIG_KCSAN=y to this change in -tip/-next. It
does not appear to be clang specific, as I can reproduce it with GCC
13.2.0 from kernel.org [2] (the rootfs is available at [3], if it is
necessary for reproducing).

$ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- defconfig
$ scripts/config -e KCSAN
$ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- olddefconfig bzImage
$ qemu-system-x86_64 \
    -display none \
    -nodefaults \
    -d unimp,guest_errors \
    -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
    -kernel arch/x86/boot/bzImage \
    -initrd x86_64-rootfs.cpio \
    -cpu host \
    -enable-kvm \
    -m 512m \
    -smp 2 \
    -serial mon:stdio
[    0.000000] Linux version 6.6.0-rc2-00316-g91174087dcc7 (nathan@dev-arch.thelio-3990X) (x86_64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT_DYNAMIC Mon Oct 16 13:54:09 MST 2023
...
[    0.269298] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[    0.269592] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-00316-g91174087dcc7 #1
[    0.269592] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-14-g1e1da7a96300-prebuilt.qemu.org 04/01/2014
[    0.269592] RIP: 0010:__x86_return_thunk+0x0/0x10
[    0.269592] Code: e8 01 00 00 00 cc e8 01 00 00 00 cc 48 81 c4 80 00 00 00 65 48 c7 04 25 d0 ac 02 00 ff ff ff ff c3 cc 0f 1f 84 00 00 00 00 00 <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc e9 db 8c 8e fe 0f
[    0.269592] RSP: 0018:ffffaef1c0013ed0 EFLAGS: 00010246
[    0.269592] RAX: ffffffffa0e80eb0 RBX: ffffffffa0f05240 RCX: 0001ffffffffffff
[    0.269592] RDX: 0000000000000551 RSI: ffffffffa0dcc64e RDI: ffffffffa0f05238
[    0.269592] RBP: ffff8f93c11708e0 R08: ffffffffa1387280 R09: 0000000000000000
[    0.269592] R10: 0000000000000282 R11: 0001ffffa0f05238 R12: 0000000000000002
[    0.269592] R13: 0000000000000282 R14: 0000000000000001 R15: 0000000000000000
[    0.269592] FS:  0000000000000000(0000) GS:ffff8f93df000000(0000) knlGS:0000000000000000
[    0.269592] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.269592] CR2: ffff8f93d6c01000 CR3: 0000000015c2e000 CR4: 0000000000350ef0
[    0.269592] Call Trace:
[    0.269592]  <TASK>
[    0.269592]  ? die+0x31/0x80
[    0.269592]  ? do_trap+0xd5/0x100
[    0.269592]  ? call_depth_return_thunk+0x90/0x90
[    0.269592]  ? do_error_trap+0x60/0x80
[    0.269592]  ? call_depth_return_thunk+0x90/0x90
[    0.269592]  ? exc_invalid_op+0x50/0x70
[    0.269592]  ? call_depth_return_thunk+0x90/0x90
[    0.269592]  ? asm_exc_invalid_op+0x1a/0x20
[    0.269592]  ? _sub_I_00099_0+0x20/0x20
[    0.269592]  ? kernel_init_freeable+0x1de/0x4b0
[    0.269592]  ? call_depth_return_thunk+0x90/0x90
[    0.269592]  kernel_init_freeable+0x1e4/0x4b0
[    0.269592]  ? __pfx_kernel_init+0x10/0x10
[    0.269592]  kernel_init+0x1a/0x220
[    0.269592]  ? srso_return_thunk+0x5/0x5f
[    0.269592]  ret_from_fork+0x2f/0x50
[    0.269592]  ? __pfx_kernel_init+0x10/0x10
[    0.269592]  ret_from_fork_asm+0x1b/0x30
[    0.269592]  </TASK>
[    0.269592] Modules linked in:
[    0.269596] ---[ end trace 0000000000000000 ]---
[    0.270115] RIP: 0010:__x86_return_thunk+0x0/0x10
[    0.270598] Code: e8 01 00 00 00 cc e8 01 00 00 00 cc 48 81 c4 80 00 00 00 65 48 c7 04 25 d0 ac 02 00 ff ff ff ff c3 cc 0f 1f 84 00 00 00 00 00 <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc e9 db 8c 8e fe 0f
[    0.271597] RSP: 0018:ffffaef1c0013ed0 EFLAGS: 00010246
[    0.272234] RAX: ffffffffa0e80eb0 RBX: ffffffffa0f05240 RCX: 0001ffffffffffff
[    0.272597] RDX: 0000000000000551 RSI: ffffffffa0dcc64e RDI: ffffffffa0f05238
[    0.273393] RBP: ffff8f93c11708e0 R08: ffffffffa1387280 R09: 0000000000000000
[    0.273599] R10: 0000000000000282 R11: 0001ffffa0f05238 R12: 0000000000000002
[    0.274398] R13: 0000000000000282 R14: 0000000000000001 R15: 0000000000000000
[    0.274599] FS:  0000000000000000(0000) GS:ffff8f93df000000(0000) knlGS:0000000000000000
[    0.275500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.275597] CR2: ffff8f93d6c01000 CR3: 0000000015c2e000 CR4: 0000000000350ef0
[    0.276426] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.276592] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

If there is any other information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan

[1]: https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/6533455720/job/17740995771
[2]: https://mirrors.edge.kernel.org/pub/tools/crosstool/
[3]: https://github.com/ClangBuiltLinux/boot-utils/releases

# bad: [4d0515b235dec789578d135a5db586b25c5870cb] Add linux-next specific files for 20231016
# good: [58720809f52779dc0f08e53e54b014209d13eebb] Linux 6.6-rc6
git bisect start '4d0515b235dec789578d135a5db586b25c5870cb' '58720809f52779dc0f08e53e54b014209d13eebb'
# good: [8c7c066964a7274b254171552d465219e9f234e6] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git
git bisect good 8c7c066964a7274b254171552d465219e9f234e6
# good: [018e1e44855a873d74d712657abc93bdb9aaf961] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git bisect good 018e1e44855a873d74d712657abc93bdb9aaf961
# bad: [e9deda4910ddc2b03bf58e8c946bd63f101f25be] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
git bisect bad e9deda4910ddc2b03bf58e8c946bd63f101f25be
# good: [ca6177c462b7eca552a967b1caf2a535f0f536f5] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good ca6177c462b7eca552a967b1caf2a535f0f536f5
# bad: [a92888f634feb41d6fb29f9a4da4e8ccfc5e8968] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect bad a92888f634feb41d6fb29f9a4da4e8ccfc5e8968
# bad: [63f98235b237e94f82b16d21292c013109c9ae66] Merge branch into tip/master: 'x86/bugs'
git bisect bad 63f98235b237e94f82b16d21292c013109c9ae66
# good: [d3a3b8c3efbb532c867447b8c00a59489a08f8ef] Merge branch into tip/master: 'objtool/core'
git bisect good d3a3b8c3efbb532c867447b8c00a59489a08f8ef
# good: [3657680f38cd7df413d665f2b2f38e9a78130d8b] sched/psi: Delete the 'update_total' function parameter from update_triggers()
git bisect good 3657680f38cd7df413d665f2b2f38e9a78130d8b
# good: [791b24f02bf2230cec50f6c7a508f1d554f69464] Merge branch into tip/master: 'x86/asm'
git bisect good 791b24f02bf2230cec50f6c7a508f1d554f69464
# bad: [91174087dcc7565d8bf0d576544e42d5b1de6f39] x86/retpoline: Ensure default return thunk isn't used at runtime
git bisect bad 91174087dcc7565d8bf0d576544e42d5b1de6f39
# good: [074c9666d42211d0f70d5c156d377a4881b2a98c] x86/srso: Move retbleed IBPB check into existing 'has_microcode' code block
git bisect good 074c9666d42211d0f70d5c156d377a4881b2a98c
# good: [88494339b5bccf0abea5660228fd066ec2e91dea] x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()
git bisect good 88494339b5bccf0abea5660228fd066ec2e91dea
# good: [5c44836dd1451c754c58cea5179d2fa5cbd9fc85] x86/srso: Remove unnecessary semicolon
git bisect good 5c44836dd1451c754c58cea5179d2fa5cbd9fc85
# good: [99b5bf0276d4ae5028ab9743053c6d16044009ea] x86/vdso: Run objtool on vdso32-setup.o
git bisect good 99b5bf0276d4ae5028ab9743053c6d16044009ea
# first bad commit: [91174087dcc7565d8bf0d576544e42d5b1de6f39] x86/retpoline: Ensure default return thunk isn't used at runtime
