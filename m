Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6E7CE567
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjJRRzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRRzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:55:50 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6045DEA;
        Wed, 18 Oct 2023 10:55:48 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 91EB840E0196;
        Wed, 18 Oct 2023 17:55:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PVMOhDw17b1i; Wed, 18 Oct 2023 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697651744; bh=h8dqClmQ0sq/MV6zPdpgsznCjz8VpPQTgB3SxTIF0oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F232D63q1cznJq5AGjEIZAmT4+Pb38JT7CdosuQA2fu4QiT+5/+XBaO17Kd/dC4ji
         5BDYlMO27qS583vFK8rA/VbpZS1xeL2XdCUrNPfZka2jht7qJea0yjfenGatO0U8Rn
         1m+VEnSIBunbmSMmjV2OccArVrwhFqg5zkx6t+XdzfM3qPkyhkuO13nT+1ZE5S2QKb
         m9nFbyBMro7RZt0yUcoUsPg4BSKj5YWVf0UU/grjKmBG/QAPudlkmrI1/gZKJ0Sz99
         3zvjeqhzR44osXlS6EMdtg/U9a014niwKyfAbABKf6Griwc+MmBm/rJ8nkSmj5R5Sc
         6YQQJnUO9g9D6kfdKQXYqLIuQZw4x9LOOuqnRdbjz8y7QnR6OfuGVfiHh0xjZFBmQD
         liELKgpxSy5bpmxJHMtM5oS796RQ79XsvhRt9FvhPy+W38z2ilIWMPP7G1stRzAyB4
         65ceZnN/u9uDb5OexE88jJ0a0vtn7nxoaS05gy1OmWRRur25xhC/kz+Q1TLQsq5bCS
         p3eMOSmCfwH7mm+eKfznKRcDxYVSnxLsxKE/YSAgjju28YIJBRMuUNGpztuM/6II3/
         Fu1ggvwq0XK9kOSHG128kV8Kfxl9Pv54egJDEzV3x77Vomx09pZC3adGF9OtbhuZAg
         y0jtE4pmwZ4F5oBkkJf2MUYk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FAE040E0193;
        Wed, 18 Oct 2023 17:55:36 +0000 (UTC)
Date:   Wed, 18 Oct 2023 19:55:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018155433.z4auwckr5s27wnig@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:54:33AM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 18, 2023 at 05:12:45PM +0200, Borislav Petkov wrote:
> > On Wed, Oct 18, 2023 at 03:38:56PM +0200, Ingo Molnar wrote:
> > > If then WARN_ONCE().
> > 
> > WARN_ONCE() is not enough considering that if this fires, it means we're
> > not really properly protected against one of those RET-speculation
> > things.
> > 
> > It needs to be warning constantly but then still allow booting. I.e,
> > a ratelimited warn of sorts but I don't think we have that... yet.
> 
> I'm not sure a rate-limited WARN() would be a good thing.  Either the
> user is regularly checking dmesg (most likely in some automated fashion)
> or they're not.  If the latter, a rate-limited WARN() would wrap dmesg
> pretty quickly.

Well, freezing the box without any mention about why it happens is not
viable either. So for lack of a better solution, overflowing dmesg is
all we could do.

And, on a related note, I'm thinking I should revert:

  e92626af3234 ("x86/retpoline: Remove .text..__x86.return_thunk section")

after all because I'm debugging another similar issue reported by
dhowells.

And I can reproduce it on linux-next with his config and gcc-13. The
splat looks like this below - and mind you, that's in a VM. On baremetal
you get to see only the first warning and output stops.

And that happens because for whatever reason apply_returns() can't find
that last jmp __x86_return_thunk for %r15 and it barfs.

When I revert e92626af3234, it is fixed. It fixes dhowells' box too.

Which means, IMHO, objtool is missing to add a return return call site
at the end of that __x86_indirect_thunk_r15.

And considering how close we are to the merge window, I'd let that
.text..__x86.return_thunk section exist so that objtool can find the
return sites more reliably that what we currently have.

We can always do e92626af3234 later, when it has seen more testing.

Now, to the UD2 case - look below at "* first splat".

Stack protector fires but there's no #UD exception. Well, there is, it
is well hidden:

(gdb) bt
#0  delay_tsc (cycles=3670543) at arch/x86/lib/delay.c:90
#1  0xffffffff810c706e in panic (fmt=fmt@entry=0xffffffff82504fe4 "stack-protector: Kernel stack is corrupted in: %pB")
    at kernel/panic.c:456
#2  0xffffffff81d64afb in __stack_chk_fail () at kernel/panic.c:763
#3  0xffffffff810e9333 in notify_die (val=val@entry=DIE_TRAP, str=str@entry=0xffffffff824f49b8 "invalid opcode", 
    regs=regs@entry=0xffff8880794000a8, err=err@entry=0, trap=trap@entry=6, sig=sig@entry=4) at kernel/notifier.c:597
#4  0xffffffff8101d4fb in do_error_trap (regs=regs@entry=0xffff8880794000a8, error_code=error_code@entry=0, 
    str=str@entry=0xffffffff824f49b8 "invalid opcode", trapnr=trapnr@entry=6, signr=signr@entry=4, sicode=sicode@entry=2, 
    addr=0xffffffff81d712a0 <__x86_return_thunk>) at arch/x86/kernel/traps.c:170
#5  0xffffffff81d62355 in handle_invalid_op (regs=0xffff8880794000a8) at ./arch/x86/include/asm/ptrace.h:209a
^^^^^^^^^^^^^^^^

#6  exc_invalid_op (regs=0xffff8880794000a8) at arch/x86/kernel/traps.c:263
#7  0xffffffff81e00a96 in asm_exc_invalid_op () at ./arch/x86/include/asm/idtentry.h:568
#8  0xffffffff81d49ff4 in cmp_ex_sort (a=0x38020f, b=0x761d61d8b) at lib/extable.c:61
#9  0x000000000000000c in fixed_percpu_data ()
#10 0xffff888079400198 in ?? ()
#11 0xffffffff826cdc70 in __modver_attr ()
#12 0x0000000000000270 in ?? ()
#13 0xffffffff826ceb10 in __start___ex_table ()
#14 0x0000000000000000 in ?? ()
(gdb)

*while* it runs the #UD exception handler, stackprotector determines
that the stack has been corrupted, leading to that panic.

And nothing in dmesg tells the user what's really going on.

And with the warn, you can actually see it:

------------[ cut here ]------------
Unconverted return thunk
WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:2855 check_thunks+0x11/0x1a
Modules linked in:
...
----

I still need to figure out, though, how to make check_thunks *not* have a "jmp
__x86_return_thunk" at the end itself because it gets loopy. :)

* first splat
-------------
...
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
------------[ cut here ]------------
missing return thunk: __x86_indirect_thunk_r15+0xa/0x5f-0x0: eb 74 66 66 2e
WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:755 apply_returns+0xca/0x247
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc6-next-20231018-build3 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:apply_returns+0xca/0x247
Code: 80 3d bd e1 aa 01 00 75 b4 49 89 d8 48 89 ea 48 89 de c6 05 ab e1 aa 01 01 b9 05 00 00 00 48 c7 c7 45 65 4f 82 e8 0b 10 0a 00 <0f> 0b eb 8f f6 05 36 2e 1f 02 02 74 26 0f b6 54 24 52 48 89 de 48
RSP: 0000:ffffffff82803e30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff81d7122a RCX: 0000000000000003
RDX: 0000000000000086 RSI: 00000000fff7ffff RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff82803969 R12: ffffffff831fed00
R13: 0000000000000005 R14: ffffffff831fed18 R15: 0000000000013af0
FS:  0000000000000000(0000) GS:ffff888079400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888003401000 CR3: 0000000002854000 CR4: 00000000001506f0
Call Trace:
 <TASK>
 ? __warn+0x8c/0xf6
 ? report_bug+0xbf/0x11f
 ? apply_returns+0xca/0x247
 ? handle_bug+0x3c/0x63
 ? exc_invalid_op+0x13/0x5d
 ? asm_exc_invalid_op+0x16/0x20
 ? __x86_indirect_thunk_r15+0xa/0x5f
 ? apply_returns+0xca/0x247
 ? __x86_indirect_thunk_r15+0xa/0x5f
 ? __x86_indirect_thunk_r15+0x19/0x5f
 ? __x86_indirect_thunk_r15+0xc/0x5f
 alternative_instructions+0x35/0xe2
 arch_cpu_finalize_init+0xba/0xdb
 start_kernel+0x4a1/0x524
 x86_64_start_reservations+0x25/0x25
 x86_64_start_kernel+0x73/0x73
 secondary_startup_64_no_verify+0x166/0x16b
 </TASK>
---[ end trace 0000000000000000 ]---
Freeing SMP alternatives memory: 36K
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=capability,yama,selinux
Yama: becoming mindful.
SELinux:  Initializing.
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
smpboot: CPU0: Intel Core Processor (Haswell, no TSX) (family: 0x6, model: 0x3c, stepping: 0x1)
RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
Performance Events: unsupported p6 CPU model 60 no PMU driver, software events only.
signal: max sigframe size: 1776
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 1000.
NMI watchdog: Perf NMI watchdog permanently disabled
smp: Bringing up secondary CPUs ...
BUG: spinlock bad magic on CPU#0, swapper/0/1
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: notify_die+0x52/0x5b
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.6.0-rc6-next-20231018-build3 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: notify_die+0x52/0x5b ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
