Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FE176FE3D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjHDKOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjHDKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:14:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0727249D7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GYK9+OGfxviHr18NI+B7bkONaqcCERrPUSZDWZMRPEQ=; b=Si4qEE3c+HJrS2LkWUpXkEpwIY
        z2QG84d95tw+UddPI6rUzadRriq2PDZYJ6XXgw1x4zVAysI26DpGR+v731iLeXUZpRG2lgIbPY72I
        85Z6xFBogTIWFnZfNZ3S5QtL+ki4RcsOQiafmnH+Ad4fikMc2BFW263jmaF+Yq1RI6wmtI2QFGM9e
        ynZc/AAqQWPF0jP6VORFQ68/nqLS5sz5Lw9voBgJBLLNR9+ghPabvhaxhVI/lrVi2pG/Art4rrfjP
        Ipm/2XkF12gk117ch8cTn0cq83XETEzdbxKMmrQET7kTOkjlN6SKIYhgKMGA8v/MhBhxLtLPW2cf8
        KqI33mSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRroA-009Hn5-6s; Fri, 04 Aug 2023 10:13:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 400A730020C;
        Fri,  4 Aug 2023 12:13:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F03F2107C447; Fri,  4 Aug 2023 12:13:21 +0200 (CEST)
Date:   Fri, 4 Aug 2023 12:13:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second
 argument error code
Message-ID: <20230804101321.GH214207@hirez.programming.kicks-ass.net>
References: <20230804075734.8372-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804075734.8372-1-xin3.li@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 12:57:34AM -0700, Xin Li wrote:
> The IDT event delivery of X86_TRAP_DF, X86_TRAP_TS, X86_TRAP_NP,
> X86_TRAP_SS, X86_TRAP_GP, X86_TRAP_AC and X86_TRAP_CP pushes an error
> code into the orig_ax member of the pt_regs structure, and the error
> code is passed as the second argument of their C-handlers, although
> the pt_regs structure is already passed as the first argument.
> 
> The asm entry code of such faults does the following
> 
>   movq ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
>   movq $-1, ORIG_RAX(%rsp)	/* no syscall to restart */
> 
> to set the orig_ax member to -1 just before calling the C-handler.
> 
> In addition, the IRQ entry code uses the second error code argument
> as its IRQ vector, as the IRQ asm entry code pushes its IRQ vector
> into the orig_ax member.
> 
> The commit d99015b1abbad ("x86: move entry_64.S register saving out of
> the macros") introduced the changes to set orig_ax to -1, but I can't
> see why it's required. Our tests on x86_64 and x86_32 seem fine if
> orig_ax is left unchanged instead of set to -1.

That means that SYSCALL_NUM(regs) get to be garbage; or something like
that.
