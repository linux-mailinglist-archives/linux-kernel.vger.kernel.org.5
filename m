Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F3F7D5707
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbjJXP45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343974AbjJXP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:56:52 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8FF10D9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:56:50 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2AE3740E01AF;
        Tue, 24 Oct 2023 15:56:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7-kj0tA55rDc; Tue, 24 Oct 2023 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698163006; bh=DDWp9LBZ4yK0qClG4gce19/2v9Q2AaKQTJsTXZaGEdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDvEUIIwQhalP83Xm7N1/EMqh+iyXx7sgH5ZUAwjM1DwjavWP7T5Wmj6ircmMjiP+
         RDwNJt3mhkOI/15TmKemFFHTMI3lLpKgkvJp+0e6rr23yCUN5l/EMxObFIJzJoCkNU
         QXMSY8G7M1HF31jwQ8vSlMQGEKN9lH92cH8LMiyR9r8M6lFZNwTgFHVncwWK5R98kO
         AonxR5rDrrQYrzwvii1J1tSn4UILAVc2s4XIOLmc1CxNVSA+8mGPesJSB1+HgnQDYC
         VCriOvjXGmMn8l633uWo/S1Ye26IxgVDTsRPkZGY9+pz+9jGlJ07QXQQPwEe2zu/PC
         ZX8M42kepvmhm2XRMpqLn8IwWl7EQMQ3AqeaPEXBs1Ha1KxMZ6y99lZVIcrst0+qMU
         2MBUvYt0idqbsGI0Fv/PRuoaBDL43RdO2GuVKFFnjiPYZs1Z7SG/+Ksm3TABgpMT7y
         uzhR4i9IZm/pWcC335MVAnXczciNiuD/JZlxtmGFRE3msbfJuw+A001ifkA0LS6Wb1
         eLnpwBzzfrmDixKmNiE4FYGHdUh9kDOPE+AwYt1Ai643uM+AoKSleZ3S5xzRd8wv/i
         epJQv6cHNQTSwBLlWFpizRqDnzxkuQdMRPez42aAArmxdQV+DQiQYlPcVfvr8armln
         f1tkjF5B0Vehs11SQ1Iu/DQA=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4682E40E01B1;
        Tue, 24 Oct 2023 15:56:34 +0000 (UTC)
Date:   Tue, 24 Oct 2023 17:56:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/percpu: Return correct variable from
 current_top_of_stack()
Message-ID: <20231024155629.GGZTfpLdLyol1+FP4/@fat_crate.local>
References: <20231024142830.3226-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024142830.3226-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 04:28:14PM +0200, Uros Bizjak wrote:
> current_top_of_stack() should return variable from _seg_gs
> qualified named address space when CONFIG_USE_X86_SEG_SUPPORT
> is enbled.

I presume you're sending those two in order to fix stuff like the splat
below which fires in my guest with latest Linus + latest tip/master
lineup.

Because disabling CONFIG_USE_X86_SEG_SUPPORT fixes it.

I'm wondering that close to the merge window whether we should delay
all that new and fancy percpu stuff one more round until it is tested
more widely...

[    1.623994] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    1.627398] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    1.627101] BUG: unable to handle page fault for address: 000000000002f0d8
[    1.629645] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    1.628158] #PF: supervisor read access in kernel mode
[    1.628161] #PF: error_code(0x0000) - not-present page
[    1.628163] PGD 0 P4D 0 
[    1.628167] Oops: 0000 [#1] PREEMPT SMP
[    1.628171] CPU: 1 PID: 10 Comm: kworker/u32:0 Not tainted 6.6.0-rc7+ #1
[    1.631566] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.629156] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    1.632494] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    1.629990] Workqueue: ftrace_check_wq ftrace_check_work_func
[    1.631041] RIP: 0010:raw_irqentry_exit_cond_resched+0x16/0x50
[    1.631041] Code: 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 f7 05 d4 ff ef 7e ff ff ff 7f 75 21 <48> 8b 05 db ff ef 7e 48 29 e0 48 3d ff 3f 00 00 77 19 65 48 8b 05
[    1.631041] RSP: 0018:ffffc9000005bab8 EFLAGS: 00010046
[    1.631041] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000002f900
[    1.631041] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000005bac8
[    1.631041] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000001
[    1.631041] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[    1.631041] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    1.631041] FS:  0000000000000000(0000) GS:ffff88807da40000(0000) knlGS:0000000000000000
[    1.631041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.631041] CR2: 000000000002f0d8 CR3: 0000000002416000 CR4: 00000000003506f0
[    1.631041] Call Trace:
[    1.631041]  <TASK>
[    1.631041]  ? __die+0x31/0x80
[    1.631041]  ? page_fault_oops+0x160/0x440
[    1.631041]  ? exc_page_fault+0x74/0x150
[    1.631041]  ? asm_exc_page_fault+0x26/0x30
[    1.631041]  ? raw_irqentry_exit_cond_resched+0x16/0x50
[    1.631041]  irqentry_exit+0x21/0x60
[    1.631041]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    1.631041] RIP: 0010:get_symbol_offset+0x26/0x60
[    1.631041] Code: 90 90 90 90 0f 1f 44 00 00 48 89 f8 48 c1 e8 08 8b 04 85 80 4f 0b 82 48 05 88 af f1 81 81 e7 ff 00 00 00 74 25 31 c9 0f b6 10 <84> d2 79 0e 0f b6 70 01 83 e2 7f c1 e6 07 09 f2 ff c2 ff c2 ff c1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
