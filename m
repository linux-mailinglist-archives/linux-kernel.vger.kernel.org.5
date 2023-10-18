Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4C7CE924
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjJRUiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJRUiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:38:01 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427C2A4;
        Wed, 18 Oct 2023 13:38:00 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7FEE040E01AF;
        Wed, 18 Oct 2023 20:37:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YUPvjayGgkMM; Wed, 18 Oct 2023 20:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697661476; bh=Pm4YziE+m+355hgaPXWCNbxGtS+NNwjyA12sofw3mNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdmGecDgTAXRw4mZx51qBJTV+XDxNBhWlpCwZvoSCw/PfR0gTsJOWAtNPor1mabaf
         WBv2KPTCEyiA9kvoTXOM4eIklFh2ktN7BGwC0lUq97eXXL7bGCldr6sAaIS75nhtUv
         LaC5GYLQFgbkJMk3FwpMm2KHYio3zywxCXWPaxMoB5CffLOEmkZEznKJBRARmqh9PN
         aHPg/aBvqp6GwHYf7YqRPNX2Lur6FOuU1GrRDF4ozXjtykOVsFvyMNBqcgoqNjHMQ0
         wKAUSL5ewCKClSGHDCJhxjL+Vh0xXh443F5+hd6okzLIU7UWHbbuzRhmSupGXlNCaU
         1jLcoS60m5XCMFV675+lbESkeMoE3vo5fASodY1BgUq3hwlunEksL7z1xcSp27nlN8
         PBHr87DzSRx5xeOgDbosquwa9tK9BoLZ8Y8/UDF/6Da1CTI4tYHiJnY++l2c6fT5zC
         aflX7q1XRwG4QHbcb7Km5HgOPFsvuoeIEBr03KsF6si3uqux715F7cQ1Kl3DzDLYu4
         dI249bYR8Ma2BXCgGLBNhyxsVuXl8qyqbV7363T31Ddc0deprt6Pf6jP9PkGQAzEMu
         JyGbUJ9LjOlC9ImeQ4lr+0uhAnoF2br+5mONC102lghRQquXLMxFkSFvSeNG2p75qD
         +ISRj56aOPYHN/VCaeOX+VS8=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FCBA40E0196;
        Wed, 18 Oct 2023 20:37:48 +0000 (UTC)
Date:   Wed, 18 Oct 2023 22:37:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 07:55:31PM +0200, Borislav Petkov wrote:
> And that happens because for whatever reason apply_returns() can't find
> that last jmp __x86_return_thunk for %r15 and it barfs.

Some more info on why it happens:

something with gcc-13 or this config of whatever ends up generating
this:

ffffffff81d71200 <__x86_indirect_thunk_r14>:
ffffffff81d71200:       e8 01 00 00 00          call   ffffffff81d71206 <__x86_indirect_thunk_r14+0x6>
ffffffff81d71205:       cc                      int3
ffffffff81d71206:       4c 89 34 24             mov    %r14,(%rsp)
ffffffff81d7120a:       e9 91 00 00 00          jmp    ffffffff81d712a0 <__x86_return_thunk>
^^^^^^^^^

ffffffff81d7120f:       66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
ffffffff81d71216:       00 00 00 00 
ffffffff81d7121a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

ffffffff81d71220 <__x86_indirect_thunk_r15>:
ffffffff81d71220:       e8 01 00 00 00          call   ffffffff81d71226 <__x86_indirect_thunk_r15+0x6>
ffffffff81d71225:       cc                      int3
ffffffff81d71226:       4c 89 3c 24             mov    %r15,(%rsp)
ffffffff81d7122a:       eb 74                   jmp    ffffffff81d712a0 <__x86_return_thunk>
^^^^^^^^^^

notice the two JMP opcodes there.

Now look at the code in apply_returns:

                if (op == JMP32_INSN_OPCODE)
                        dest = addr + insn.length + insn.immediate.value;

with

#define JMP32_INSN_OPCODE       0xE9

And here's the fix:

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 73be3931e4f0..50d64f5226f4 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -748,14 +748,20 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
                        continue;
 
                op = insn.opcode.bytes[0];
-               if (op == JMP32_INSN_OPCODE)
+               if (op == JMP32_INSN_OPCODE || op == JMP8_INSN_OPCODE)
                        dest = addr + insn.length + insn.immediate.value;
 

I'd still prefer the revert, though, that close to the MW. We can work
at those things later, at leisure.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
