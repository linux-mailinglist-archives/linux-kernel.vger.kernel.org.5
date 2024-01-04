Return-Path: <linux-kernel+bounces-16242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B13823B5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277171F2634E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5F810A16;
	Thu,  4 Jan 2024 04:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngH3RJ0o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6B1DFE6;
	Thu,  4 Jan 2024 04:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC08C433C8;
	Thu,  4 Jan 2024 04:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704341584;
	bh=ylBARymjYrog7nf4LTQyyVmdSy3x6uAoxe8NKMlZDIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngH3RJ0oqkizOg0INkeg3QTZAW4PGnt0D+Rp2vvMDnoUfz4CSvldjRre2PcegtRi5
	 4GuKAcEwUR71kowYEzb9MLihoj8dRM9HGvAJzPVLRhamuvPx+FHCWZc3pIAYmdO+RE
	 beTK1wQZWPhvkfHIjy/qbm6z16lUyMBvRzIUENKHnstPY/B8VR4tif1yffITu3eGEK
	 c9vHQp50WVADA/kOdh+XJZs4ydSg9FyAxNg3rBfhv/tqPK8IdU4fYgi4upDte0kQiV
	 5P0asPSk8PtJBt3nEDNH/X33Fp+/NZtR2ej7ZgcYUwmks+V9PJCWCEi7qRhkweEIr+
	 Hd2T1jQH2wOsQ==
Date: Thu, 4 Jan 2024 13:12:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: fix incorrect return address calculation
 in kprobe_emulate_call_indirect
Message-Id: <20240104131259.d66b4284deb6c4acde992dfa@kernel.org>
In-Reply-To: <20240102233345.385475-1-jinghao7@illinois.edu>
References: <20240102233345.385475-1-jinghao7@illinois.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jan 2024 17:33:45 -0600
Jinghao Jia <jinghao7@illinois.edu> wrote:

> kprobe_emulate_call_indirect currently uses int3_emulate_call to emulate
> indirect calls. However, int3_emulate_call always assumes the size of
> the call to be 5 bytes when calculating the return address. This is
> incorrect for register-based indirect calls in x86, which can be either
> 2 or 3 bytes depending on whether REX prefix is used.

Ah, that's a really good point! Yes, it should handle the shorter
indirect call with registers.

> At kprobe runtime,
> the incorrect return address causes control flow to land onto the wrong
> place after return -- possibly not a valid instruction boundary. This
> can lead to a panic like the following:
> 
> [    7.308204][    C1] BUG: unable to handle page fault for address: 000000000002b4d8
> [    7.308883][    C1] #PF: supervisor read access in kernel mode
> [    7.309168][    C1] #PF: error_code(0x0000) - not-present page
> [    7.309461][    C1] PGD 0 P4D 0
> [    7.309652][    C1] Oops: 0000 [#1] SMP
> [    7.309929][    C1] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.7.0-rc5-trace-for-next #6
> [    7.310397][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
> [    7.311068][    C1] RIP: 0010:__common_interrupt+0x52/0xc0
> [    7.311349][    C1] Code: 01 00 4d 85 f6 74 39 49 81 fe 00 f0 ff ff 77 30 4c 89 f7 4d 8b 5e 68 41 ba 91 76 d8 42 45 03 53 fc 74 02 0f 0b cc ff d3 65 48 <8b> 05 30 c7 ff 7e 65 4c 89 3d 28 c7 ff 7e 5b 41 5c 41 5e 41 5f c3
> [    7.312512][    C1] RSP: 0018:ffffc900000e0fd0 EFLAGS: 00010046
> [    7.312899][    C1] RAX: 0000000000000001 RBX: 0000000000000023 RCX: 0000000000000001
> [    7.313334][    C1] RDX: 00000000000003cd RSI: 0000000000000001 RDI: ffff888100d302a4
> [    7.313702][    C1] RBP: 0000000000000001 R08: 0ef439818636191f R09: b1621ff338a3b482
> [    7.314146][    C1] R10: ffffffff81e5127b R11: ffffffff81059810 R12: 0000000000000023
> [    7.314509][    C1] R13: 0000000000000000 R14: ffff888100d30200 R15: 0000000000000000
> [    7.314951][    C1] FS:  0000000000000000(0000) GS:ffff88813bc80000(0000) knlGS:0000000000000000
> [    7.315396][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.315691][    C1] CR2: 000000000002b4d8 CR3: 0000000003028003 CR4: 0000000000370ef0
> [    7.316153][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    7.316508][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    7.316948][    C1] Call Trace:
> [    7.317123][    C1]  <IRQ>
> [    7.317279][    C1]  ? __die_body+0x64/0xb0
> [    7.317482][    C1]  ? page_fault_oops+0x248/0x370
> [    7.317712][    C1]  ? __wake_up+0x96/0xb0
> [    7.317964][    C1]  ? exc_page_fault+0x62/0x130
> [    7.318211][    C1]  ? asm_exc_page_fault+0x22/0x30
> [    7.318444][    C1]  ? __cfi_native_send_call_func_single_ipi+0x10/0x10
> [    7.318860][    C1]  ? default_idle+0xb/0x10
> [    7.319063][    C1]  ? __common_interrupt+0x52/0xc0
> [    7.319330][    C1]  common_interrupt+0x78/0x90
> [    7.319546][    C1]  </IRQ>
> [    7.319679][    C1]  <TASK>
> [    7.319854][    C1]  asm_common_interrupt+0x22/0x40
> [    7.320082][    C1] RIP: 0010:default_idle+0xb/0x10
> [    7.320309][    C1] Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 b8 0c 67 40 a5 66 90 0f 00 2d 09 b9 3b 00 fb f4 <fa> c3 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 b8 0c 67 40 a5 e9
> [    7.321449][    C1] RSP: 0018:ffffc9000009bee8 EFLAGS: 00000256
> [    7.321808][    C1] RAX: ffff88813bca8b68 RBX: 0000000000000001 RCX: 000000000001ef0c
> [    7.322227][    C1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000001ef0c
> [    7.322656][    C1] RBP: ffffc9000009bef8 R08: 8000000000000000 R09: 00000000000008c2
> [    7.323083][    C1] R10: 0000000000000000 R11: ffffffff81058e70 R12: 0000000000000000
> [    7.323530][    C1] R13: ffff8881002b30c0 R14: 0000000000000000 R15: 0000000000000000
> [    7.323948][    C1]  ? __cfi_lapic_next_deadline+0x10/0x10
> [    7.324239][    C1]  default_idle_call+0x31/0x50
> [    7.324464][    C1]  do_idle+0xd3/0x240
> [    7.324690][    C1]  cpu_startup_entry+0x25/0x30
> [    7.324983][    C1]  start_secondary+0xb4/0xc0
> [    7.325217][    C1]  secondary_startup_64_no_verify+0x179/0x17b
> [    7.325498][    C1]  </TASK>
> [    7.325641][    C1] Modules linked in:
> [    7.325906][    C1] CR2: 000000000002b4d8
> [    7.326104][    C1] ---[ end trace 0000000000000000 ]---
> [    7.326354][    C1] RIP: 0010:__common_interrupt+0x52/0xc0
> [    7.326614][    C1] Code: 01 00 4d 85 f6 74 39 49 81 fe 00 f0 ff ff 77 30 4c 89 f7 4d 8b 5e 68 41 ba 91 76 d8 42 45 03 53 fc 74 02 0f 0b cc ff d3 65 48 <8b> 05 30 c7 ff 7e 65 4c 89 3d 28 c7 ff 7e 5b 41 5c 41 5e 41 5f c3
> [    7.327570][    C1] RSP: 0018:ffffc900000e0fd0 EFLAGS: 00010046
> [    7.327910][    C1] RAX: 0000000000000001 RBX: 0000000000000023 RCX: 0000000000000001
> [    7.328273][    C1] RDX: 00000000000003cd RSI: 0000000000000001 RDI: ffff888100d302a4
> [    7.328632][    C1] RBP: 0000000000000001 R08: 0ef439818636191f R09: b1621ff338a3b482
> [    7.329223][    C1] R10: ffffffff81e5127b R11: ffffffff81059810 R12: 0000000000000023
> [    7.329780][    C1] R13: 0000000000000000 R14: ffff888100d30200 R15: 0000000000000000
> [    7.330193][    C1] FS:  0000000000000000(0000) GS:ffff88813bc80000(0000) knlGS:0000000000000000
> [    7.330632][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.331050][    C1] CR2: 000000000002b4d8 CR3: 0000000003028003 CR4: 0000000000370ef0
> [    7.331454][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    7.331854][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    7.332236][    C1] Kernel panic - not syncing: Fatal exception in interrupt
> [    7.332730][    C1] Kernel Offset: disabled
> [    7.333044][    C1] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> The relevant assembly code is (from objdump, faulting address
> highlighted):
> 
> ffffffff8102ed9d:       41 ff d3                  call   *%r11
> ffffffff8102eda0:       65 48 <8b> 05 30 c7 ff    mov    %gs:0x7effc730(%rip),%rax
> 
> The emulation incorrectly sets the return address to be ffffffff8102ed9d
> + 0x5 = ffffffff8102eda2, which is the 8b byte in the middle of the next
> mov. This in turn causes incorrect subsequent instruction decoding and
> eventually triggers the page fault above.
> 
> Instead of invoking int3_emulate_call, perform push and jmp emulation
> directly in kprobe_emulate_call_indirect. At this point we can obtain
> the instruction size from p->ainsn.size so that we can calculate the
> correct return address.

This looks good to me, because 'p->ainsn.size = insn->length' so the
'regs->ip - INT3_INSN_SIZE + p->ainsn.size' will point the next instruction
correctly.

Let me pick it.

Thanks!

> 
> Fixes: 6256e668b7af ("x86/kprobes: Use int3 instead of debug trap for single-step")
> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>  arch/x86/kernel/kprobes/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index e8babebad7b8..a0ce46c0a2d8 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -576,7 +576,8 @@ static void kprobe_emulate_call_indirect(struct kprobe *p, struct pt_regs *regs)
>  {
>  	unsigned long offs = addrmode_regoffs[p->ainsn.indirect.reg];
>  
> -	int3_emulate_call(regs, regs_get_register(regs, offs));
> +	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + p->ainsn.size);
> +	int3_emulate_jmp(regs, regs_get_register(regs, offs));
>  }
>  NOKPROBE_SYMBOL(kprobe_emulate_call_indirect);
>  
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

