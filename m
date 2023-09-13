Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5296979E8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbjIMNQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbjIMNQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:16:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D019B4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XykPdTzsn8Xcv1oV9WgnfxToFhzNN/MMq5y8pKpBp+k=; b=VeuzbFjg/BxPGvHlcEKFoexKxT
        6iiwpXzfJI+mtcF0WLiDQHIV/dMwCZKPFAZY0/BMTZ/He0LSwJK5S2un7/70nTBOaZ+u/KYoOPkVa
        /RsatHPLwyJK0oJcmzVFDjl2SyWnybLZsXByBvspE7C8ya727VvzSzzs29XmsJ9pENGr24CFKYRET
        6Ohip1HYxoG+g5DKICirbtrTjiWGzUasAcKqD8kyr0Tt2eT0o8cqRdby8t+uiyrUgY17/5dDfoMix
        WASKJyP8TJNdCvpXux50OjCPbttpoqhfD0PHcNyXbHzLdoJfKd2+muvDvmVKDpyNxawAkKdca8kzg
        0DlRPTrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgPiV-00E2yL-Qn; Wed, 13 Sep 2023 13:15:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B673300348; Wed, 13 Sep 2023 15:15:39 +0200 (CEST)
Date:   Wed, 13 Sep 2023 15:15:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] x86/srso: Rename fam17 SRSO infrastructure to
 srso_fam17_*()
Message-ID: <20230913131539.GA22758@noisy.programming.kicks-ass.net>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-3-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821112723.3995187-3-andrew.cooper3@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:27:21PM +0100, Andrew Cooper wrote:
> The naming is inconsistent.  Rename it to fam17 to state the microarchitecture
> it is applicable to, and to mirror the srso_fam19_*() change.
> 
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
> CC: x86@kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Borislav Petkov <bp@alien8.de>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Josh Poimboeuf <jpoimboe@kernel.org>
> CC: Babu Moger <babu.moger@amd.com>
> CC: David.Kaplan@amd.com
> CC: Nikolay Borisov <nik.borisov@suse.com>
> CC: gregkh@linuxfoundation.org
> CC: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/nospec-branch.h |  4 ++--
>  arch/x86/kernel/cpu/bugs.c           |  2 +-
>  arch/x86/kernel/vmlinux.lds.S        |  2 +-
>  arch/x86/lib/retpoline.S             | 32 ++++++++++++++--------------
>  4 files changed, 20 insertions(+), 20 deletions(-)
> 

Re your objtool woes:

> -SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
> +	.skip 64 - (srso_fam17_safe_ret - srso_fam17_untrain_ret), 0xcc
> +SYM_START(srso_fam17_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
>  	ANNOTATE_NOENDBR
>  	.byte 0x48, 0xb8
>  
>  /*
>   * This forces the function return instruction to speculate into a trap
> - * (UD2 in srso_return_thunk() below).  This RET will then mispredict
> + * (UD2 in srso_fam17_return_thunk() below).  This RET will then mispredict
>   * and execution will continue at the return site read from the top of
>   * the stack.
>   */
> -SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
> +SYM_INNER_LABEL(srso_fam17_safe_ret, SYM_L_GLOBAL)

Note that there is a mention of 'srso_safe_ret' in
tools/objtool/arch/x86/decode.c:arch_is_embedded_insn() which you
'forgot' to update.

>  	lea 8(%_ASM_SP), %_ASM_SP
>  	ret
>  	int3
>  	int3
>  	/* end of movabs */
>  	lfence
> -	call srso_safe_ret
> +	call srso_fam17_safe_ret
>  	ud2
> -SYM_CODE_END(srso_safe_ret)
> -SYM_FUNC_END(srso_untrain_ret)
> -__EXPORT_THUNK(srso_untrain_ret)
> +SYM_CODE_END(srso_fam17_safe_ret)
> +SYM_FUNC_END(srso_fam17_untrain_ret)
> +__EXPORT_THUNK(srso_fam17_untrain_ret)
