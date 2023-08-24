Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7163787B29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243819AbjHXWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbjHXWEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1EC1991
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA4AF65737
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB35C433C8;
        Thu, 24 Aug 2023 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692914683;
        bh=7Vbc8OMhC8QnpJJvlpLenZviLbygq6etasK3R0bAsbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HoaMfuj3uEjgh+fLcsQaDYd9oDdKsNmLIJ/ALlS0PpJHUCsfedFVa5O7jnxJexvSS
         6pMfZQZjAC5t8y7sgsuHYA6Qghb85cr+wWFtrhjzii84wXqoSiAI9Ul/HBAfqfELaW
         b7HwbmkIYsV+moFsUdN3uDemJjgF6QPEuKzhPiTmXL10dF9tdxHRfRVPp2Fif7fapP
         XD58jmaDjLBD68KQDenr9L6YJyZh+mjUWMqxCFQtHKUFYQNfXHCb9pbyjI2Pm1PthQ
         1+rtU884pAPs3VBqVvevRt9hMhrLFdhmCYFDKoXr9hAzvFpAaxGx8loKy6BRgjXaAF
         LhAI6eguEvXxw==
Date:   Thu, 24 Aug 2023 15:04:40 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 02/22] x86/srso: Set CPUID feature bits independently of
 bug or mitigation status
Message-ID: <20230824220440.ltmozuypice2kmwg@treble>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
 <26a3421e-3a88-b326-4c4f-abdaa2262852@citrix.com>
 <20230821140619.GBZONvWz+iwQZwx/sC@fat_crate.local>
 <20230823052007.GBZOWXBymcCUOoMax3@fat_crate.local>
 <22eb07b3-6de4-9fc2-fb05-2c7ebe6dc951@citrix.com>
 <20230824042420.GAZObbdNb38eKaCPAm@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824042420.GAZObbdNb38eKaCPAm@fat_crate.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 06:24:20AM +0200, Borislav Petkov wrote:
> On Wed, Aug 23, 2023 at 01:22:34PM +0100, Andrew Cooper wrote:
> > In my previous reply, I explained why this goes wrong when Linux ignores
> > the CPUID bit provided by the hypervisor and decides to probe manually.
> 
> Send a patch and explain in its commit message *why* this is needed.
> 
> > No.
> 
> Hell yeah!
> 
> How do you expect us to support use cases we don't know about?!
> 
> > You don't get to take my code, break it when integrating it into Linux,
> > then dismiss the bug as something hypothetical that you don't want to fix.
> 
> I have no clue what you're talking about but it sounds like
> a misunderstanding. All I'm saying is, the live migration use cases the
> kernel should support, should be documented first. If there's no
> documentation for them, *then* you have hypothetical.
> 
> So patches explaining what we're supporting are welcome.

Something like this?

From: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] x86/srso: Don't probe microcode in a guest

To support live migration, the hypervisor sets the "lowest common
denominator" of features.  Probing the microcode isn't allowed because
any detected features might go away after a migration.

As Andy Cooper states:

  "Linux must not probe microcode when virtualised.  What it may see
  instantaneously on boot (owing to MSR_PRED_CMD being fully passed
  through) is not accurate for the lifetime of the VM."

Rely on the hypervisor to set the needed IBPB_BRTYPE and SBPB bits.

Fixes: 1b5277c0ea0b ("x86/srso: Add SRSO_NO support")
Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b08af929135d..28e77c5d6484 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -767,7 +767,7 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_TOPOEXT))
 		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
 
-	if (!cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
 		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
 		else if (c->x86 >= 0x19 && !wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
-- 
2.41.0


