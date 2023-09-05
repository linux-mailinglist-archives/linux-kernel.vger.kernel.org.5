Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809A1792C06
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352426AbjIERFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353540AbjIEGgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:36:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0138BD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:35:54 -0700 (PDT)
Received: from nazgul.tnic (dynamic-046-114-110-212.46.114.pool.telefonica.de [46.114.110.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 907431EC0105;
        Tue,  5 Sep 2023 08:35:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693895752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7JbPky9QQ58uQoCBrX2DreDWjKTUEmcDRWqbPsyYUmY=;
        b=eTwh7bH0jeQyx3c1Zs8ymj1Mg0G4HKMusJoL+A85cr+Vh58PTCF/0STNg+X04H19tHmaa6
        mVb5V1lte75Th1W9vo7CI3AfYxcnVVeV/9g4lx9fl9y4DjHth6FdfbOVph9mksf56lF7Dj
        eNOAJnsDSSJmzo5Kq/LpCbjFnOC+370=
Date:   Tue, 5 Sep 2023 08:35:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 00/20] SRSO fixes/cleanups
Message-ID: <20230905063550.GAZPbMRuLizPxmRuHF@fat_crate.local>
References: <cover.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693889988.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 10:04:44PM -0700, Josh Poimboeuf wrote:
> v3:
> - drop kvm patches (to be picked up by Sean)
> - fix "no microcode, no microcode" printk
> - fix "Safe Ret" capitalization in documentation
> - fix chopped line in commit log
> - drop "x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB check" patch
> 
> Josh Poimboeuf (20):
>   x86/srso: Fix srso_show_state() side effect
>   x86/srso: Set CPUID feature bits independently of bug or mitigation
>     status
>   x86/srso: Don't probe microcode in a guest
>   x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
>   x86/srso: Fix SBPB enablement for (possible) future fixed HW
>   x86/srso: Print actual mitigation if requested mitigation isn't
>     possible
>   x86/srso: Print mitigation for retbleed IBPB case
>   x86/srso: Fix vulnerability reporting for missing microcode
>   x86/srso: Fix unret validation dependencies
>   x86/alternatives: Remove faulty optimization
>   x86/srso: Improve i-cache locality for alias mitigation
>   x86/srso: Unexport untraining functions
>   x86/srso: Remove 'pred_cmd' label
>   x86/bugs: Remove default case for fully switched enums
>   x86/srso: Move retbleed IBPB check into existing 'has_microcode' code
>     block
>   x86/srso: Disentangle rethunk-dependent options
>   x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
>   x86/retpoline: Remove .text..__x86.return_thunk section
>   x86/nospec: Refactor UNTRAIN_RET[_*]
>   x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()
> 
>  Documentation/admin-guide/hw-vuln/srso.rst |  24 ++-
>  arch/x86/include/asm/nospec-branch.h       |  69 ++++-----
>  arch/x86/include/asm/processor.h           |   2 -
>  arch/x86/kernel/alternative.c              |   8 -
>  arch/x86/kernel/cpu/amd.c                  |  28 ++--
>  arch/x86/kernel/cpu/bugs.c                 | 102 ++++++------
>  arch/x86/kernel/vmlinux.lds.S              |  10 +-
>  arch/x86/lib/retpoline.S                   | 171 +++++++++++----------
>  include/linux/objtool.h                    |   3 +-
>  scripts/Makefile.vmlinux_o                 |   3 +-
>  10 files changed, 201 insertions(+), 219 deletions(-)

They all look good to me, thanks!

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
