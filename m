Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6C7E5A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjKHPqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjKHPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:46:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086FC186
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:46:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015E7C433CA;
        Wed,  8 Nov 2023 15:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699458391;
        bh=rZ9HX1+atEHu++YlPY3PMKy6I5q8b1mlWO6r/QezZaA=;
        h=Date:From:To:Cc:Subject:From;
        b=jDCcHs7aTuKTdXtMnwKR1FSV5LQgdeNTnKhBiCVOws9M5UHHw/qxldHFn9PfjkyZy
         MlNvWXhckG6BZ+Zhn5ZtE7xOIkZY/6E1lbbxTeomfP5ee2K0V2ttAjuB41c/rkxtYi
         z90Y4lPN0H/bckmkVv9axrxwvkb17742Hcl0eXmvW940ea4mh6u/SVyj+pMfF8PrAn
         iDsxFN8S9furNaT+ZH7Tw5Sj3850NOeks67CPwQW2CPSuvTr6PamPqEgkGorRJVEm7
         /fOGJLAseiLyE510zD5fgSXMkYpOKpY/N/+Uf8QHR+oyDElQLPYkZyBXYm7XyRPL2/
         bbRqf9iPsBBvA==
Date:   Wed, 8 Nov 2023 15:46:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     x86@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [REPORT] BPF: Reproducible triggering of BUG() from userspace PoC
Message-ID: <20231108154626.GB8909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon,

After coming across a recent Syzkaller report [0] I thought I'd take
some time to firstly reproduce the issue, then see if there was a
trivial way to mitigate it.  The report suggests that a BUG() in
prog_array_map_poke_run() [1] can be trivially and reliably triggered
from userspace using the PoC provided [2].

        ret = bpf_arch_text_poke(poke->tailcall_bypass,
                                 BPF_MOD_JUMP,
                                 old_bypass_addr,
                                 poke->bypass_addr);
        BUG_ON(ret < 0 && ret != -EINVAL);

Indeed the PoC does seem to be able to consistently trigger the BUG(),
not only on the reported kernel (v6.1), but also on linux-next.  I went
to the trouble of checking LORE, but failed to find any patches which
may be attempting to fix this.

    kernel BUG at kernel/bpf/arraymap.c:1094!
    invalid opcode: 0000 [#1] PREEMPT SMP KASAN
    CPU: 5 PID: 45 Comm: kworker/5:0 Not tainted 6.6.0-rc3-next-20230929-dirty #74
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
    Workqueue: events prog_array_map_clear_deferred
    RIP: 0010:prog_array_map_poke_run+0x6b4/0x6d0
    Code: ff 0f 0b e8 1e 27 e1 ff 48 c7 c7 60 80 93 85 48 c7 c6 00 7f 93 85 48 c7 c2 bb c2 39 86 b9 45 04 00 00 45 89 f8 e8 9c 890
    RSP: 0018:ffffc9000036fb50 EFLAGS: 00010246
    RAX: 0000000000000044 RBX: ffff88811f337490 RCX: 63af48a1314f9900
    RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
    RBP: ffffc9000036fbe8 R08: ffffffff815c23c5 R09: 1ffff11084c14eba
    R10: dfffe91084c14ebc R11: ffffed1084c14ebb R12: ffff888116517800
    R13: dffffc0000000000 R14: ffff888125a1a400 R15: 00000000fffffff0
    FS:  0000000000000000(0000) GS:ffff888426080000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00000000004ab678 CR3: 0000000122ac4000 CR4: 0000000000350eb0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
     <TASK>
     ? __die_body+0x92/0xf0
     ? die+0xa2/0xe0
     ? do_trap+0x12f/0x370
     ? handle_invalid_op+0xa6/0x140
     ? handle_invalid_op+0xdf/0x140
     ? prog_array_map_poke_run+0x6b4/0x6d0
     ? prog_array_map_poke_run+0x6b4/0x6d0
     ? exc_invalid_op+0x32/0x50
     ? asm_exc_invalid_op+0x1b/0x20
     ? __wake_up_klogd+0xd5/0x110
     ? prog_array_map_poke_run+0x6b4/0x6d0
     ? bpf_prog_6781ebc2dae4bad9+0xb/0x53
     fd_array_map_delete_elem+0x152/0x250
     prog_array_map_clear_deferred+0xf6/0x210
     ? __bpf_array_map_seq_show+0xa40/0xa40
     ? kick_pool+0x164/0x350
     ? process_one_work+0x57a/0xd00
     process_one_work+0x5e4/0xd00
     worker_thread+0x9cf/0xea0
     kthread+0x2b4/0x350
     ? pr_cont_work+0x580/0x580
     ? kthread_blkcg+0xd0/0xd0
     ret_from_fork+0x4a/0x80
     ? kthread_blkcg+0xd0/0xd0
     ret_from_fork_asm+0x11/0x20
     </TASK>
    Modules linked in:
    ---[ end trace 0000000000000000 ]---

However, with my very limited BPF subsystem knowledge I was unable to
trivially fix the issue.  Hopefully some knowledgable person would be
kind enough to provide me with some pointers.

bpf_arch_text_poke() seems to be returning -EBUSY due to a negative
memcmp() result from [3].

        ret = -EBUSY;
        mutex_lock(&text_mutex);
        if (memcmp(ip, old_insn, X86_PATCH_SIZE)) {
                goto out;
        [...]

When spitting out the memory at those locations, this is the result:

    ip:        e9 06 00 00 00
    old_insn:  0f 1f 44 00 00
    nop_insn:  0f 1f 44 00 00

As you can see, the information stored in 'ip' does not match that of
the data stored in 'old_insn', causing bpf_arch_text_poke() to return
early with the error -EBUSY, suggesting that the data pointed to by
'old_insn', and by extension 'prog' should have been changed when
emit_call()ing, to the value of 'ip', but wasn't.

It's possible for me to see what is happening, but I'm afraid finding
possible causes of corruption became too time consuming on this
occasion.  Would anyone be able to chime in to provide their take on
possible causes please?

Any help would be gratefully received.

[0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
[1] https://elixir.bootlin.com/linux/latest/source/kernel/bpf/arraymap.c#L1092
[2] https://syzkaller.appspot.com/text?tag=ReproC&x=1397180f680000
[3] https://elixir.bootlin.com/linux/latest/source/arch/x86/net/bpf_jit_comp.c#L387

-- 
Lee Jones [李琼斯]
