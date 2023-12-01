Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA62E8013D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379570AbjLAUAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379559AbjLAUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:00:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E517795
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:00:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5042AC433C8;
        Fri,  1 Dec 2023 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701460856;
        bh=IT7yyK2lIBKnfcOQs1byPql0uqwNmalDnLqIwsW1VZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNPWC/g0a2x2cmuUHv1mcctnA+KRhgd9p3y7l11tr/iMr9fHvbQmGdDAPGs/jBW3e
         530pOyTqaWrhQf8yGhGd4F42a+0XOxsg5GcCntPFajZbuaumj792bydrBtBr8nepZE
         vasZlw/KSLZs2v7F2Co9V/rhqlGoCLT1ixGg30992DzMr4WAaUWoXWfX1DPvC9900h
         ds+5HasFsw0cILwlbw0SOvFzuFPCHPzAhhqJzdZaDgZmkyLzdvOfUYVeeZI5AZQ5qo
         2CZRh1FWiqD0QgXUYu6yjSeF9hePz4ANF0XrwvzDmWpKdbjcU73s7Tl0xJikEijj6Q
         x63GZHSbidejw==
Date:   Fri, 1 Dec 2023 11:59:54 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, tony.luck@intel.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH  v4 4/6] x86/bugs: Use ALTERNATIVE() instead of
 mds_user_clear static key
Message-ID: <20231201195954.sr3nhvectmtkc47q@treble>
References: <20231027-delay-verw-v4-0-9a3622d4bcf7@linux.intel.com>
 <20231027-delay-verw-v4-4-9a3622d4bcf7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027-delay-verw-v4-4-9a3622d4bcf7@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 07:38:59AM -0700, Pawan Gupta wrote:
> The VERW mitigation at exit-to-user is enabled via a static branch
> mds_user_clear. This static branch is never toggled after boot, and can
> be safely replaced with an ALTERNATIVE() which is convenient to use in
> asm.
> 
> Switch to ALTERNATIVE() to use the VERW mitigation late in exit-to-user
> path. Also remove the now redundant VERW in exc_nmi() and
> arch_exit_to_user_mode().
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  Documentation/arch/x86/mds.rst       | 38 +++++++++++++++++++++++++-----------
>  arch/x86/include/asm/entry-common.h  |  1 -
>  arch/x86/include/asm/nospec-branch.h | 12 ------------
>  arch/x86/kernel/cpu/bugs.c           | 15 ++++++--------
>  arch/x86/kernel/nmi.c                |  2 --
>  arch/x86/kvm/vmx/vmx.c               |  2 +-
>  6 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/arch/x86/mds.rst b/Documentation/arch/x86/mds.rst
> index e73fdff62c0a..a5c5091b9ccd 100644
> --- a/Documentation/arch/x86/mds.rst
> +++ b/Documentation/arch/x86/mds.rst
> @@ -95,6 +95,9 @@ The kernel provides a function to invoke the buffer clearing:
>  
>      mds_clear_cpu_buffers()
>  
> +Also macro CLEAR_CPU_BUFFERS is meant to be used in ASM late in exit-to-user
> +path. This macro works for cases where GPRs can't be clobbered.

What does this last sentence mean?  Is it trying to say that the macro
doesn't clobber registers (other than ZF)?

-- 
Josh
