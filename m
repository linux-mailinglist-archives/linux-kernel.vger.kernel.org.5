Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD78799EB1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbjIJOmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 10:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjIJOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 10:42:43 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A49D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 07:42:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2C67340E01A4;
        Sun, 10 Sep 2023 14:42:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jktFb9yEFjSy; Sun, 10 Sep 2023 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1694356949; bh=uvGM5BWjDSCWnEfZKzvSx0n53RAtCLKsFGmZ1/vA98g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cdk3BNdSdZ7LuZFp9YTtQ834TGCSjtoEaTJkKQI42MPi3AdEUPlmpAYrBpEJ50thG
         EcGYCRRz19nPvIFLk8mSrNlfWfRmnO4RxIYJcthW7A2FHOjyZmoxNCROAkiBJMme6P
         IDxm4YJw5zX2w581ydZJtqmqb8TRopB9qmvOpodxJtSteDOaGgRiu9MsPTW5gSsHnk
         eh2na1eP6Arx6bXbk3gCeRkCo5MAl6s8j8ZzYbkTW+5QpSwGBoHu0OmnFrvWberAbL
         KVt6+tRneOg++/ZdwS9jimD8v5VTaDLR8j+ehP1CYvUxCgmDAom9Xam5ucYEA+cb7O
         6Ot/w1NnVQvUFu1lbpJAGCMJl3wf0qCamoWtcIRuynknio0V/STMvZvamo8fA39CFf
         fxHGlJXazaLNd+jXnZoaqetznFqpq+jxm/Ih/uQUhPG9wEnUA4KZ11YNr9DSDzoyL1
         JgTfVL5eqyCUG+rvwqHcpAtY9zxG7yOPeVeVnpmsQmbjbaXkahJmW+oQ+XsrHV6SpO
         A3IleaHHpC/qiwtOM3w7nAPoiHgV+7MM9XFKjK06l4tPVgFHEEoADC4FeSaBtHGVg6
         r6Y/hj6wkctFqXbmjonc27eD9g4Lz7qXVLNwycCCD3IP7zNnGz1odIcPIGx4lJa3SJ
         ycKGRhlztsKAArwrXhu371Kc=
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8465240E0174;
        Sun, 10 Sep 2023 14:42:21 +0000 (UTC)
Date:   Sun, 10 Sep 2023 16:42:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230909092554.GC2771@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 11:25:54AM +0200, Peter Zijlstra wrote:
> So what you end up with is:
> 
> 661:
>   "one byte orig insn"
>   "one nop because alt1 is 2 bytes"
>   "one nop because alt2 is 3 bytes"
> 
> right?

Right.

> This becomes more of a problem with your example above where the
> respective lengths are 0, 5, 16. In that case, when you patch 5, you'll
> leave 11 single nops in there.

Well, I know what you mean but the code handles that gracefully and it
works. Watch this:

I made it always apply the second one and not apply the third, the
longest one:

.macro UNTRAIN_RET
#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
        defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
        VALIDATE_UNRET_END
        ALTERNATIVE_3 "",                                               \
                      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,              \
                      "call entry_ibpb", X86_FEATURE_ALWAYS,            \
                      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
#endif
.endm

So it comes in and pokes in the padding for the first one:
X86_FEATURE_UNRET

[    0.903506] SMP alternatives: feat: 11*32+15, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 5), repl: (ffffffff833a362b, len: 5)
[    0.911256] SMP alternatives: ffffffff81c000d1: [0:5) optimized NOPs: 0f 1f 44 00 00

Then patches in the entry_ibpb call:

[    0.916849] SMP alternatives: feat: 3*32+21, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 5), repl: (ffffffff833a3630, len: 5)
[    0.924844] SMP alternatives: ffffffff81c000d1:   old_insn: 0f 1f 44 00 00
[    0.928842] SMP alternatives: ffffffff833a3630:   rpl_insn: e8 5b 9e 81 fe
[    0.932849] SMP alternatives: ffffffff81c000d1: final_insn: e8 ba d3 fb ff

and now it comes to the call depth thing which is of size 16:

[    0.936845] SMP alternatives: feat: 11*32+19, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 16), repl: (ffffffff833a3635, len: 16)
[    0.940844] SMP alternatives: __optimize_nops: next: 5, insn len: 5

and this is why it works: __optimize_nops() is cautious enough to do
insn_is_nop() and there is the CALL insn: e8 ba d3 fb ff, it skips over
it:

[    0.944852] SMP alternatives: __optimize_nops: next: 6, insn len: 1

next one is a NOP and it patches the rest of it. Resulting in an 11
bytes NOP:

[    0.950758] SMP alternatives: ffffffff81c000d1: [5:16) optimized NOPs: e8 ba d3 fb ff 66 66 2e 0f 1f 84 00 00 00 00 00

So we're good here without this max(repl_len) thing even if it is the
right thing to do.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
