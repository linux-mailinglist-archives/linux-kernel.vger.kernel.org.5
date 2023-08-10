Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC897778CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjHJMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjHJMtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:49:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB692694
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RZoVKi5KoyA0VAIRv2FdOy9xSWNMRhjIpnc2oRg/8Rs=; b=QjtVXq47zdaYaHVzaZ6V8D0Uxt
        ugkSqqgPewKB9n7YZFEsTgokPI11RLPPfqZDlGUBEaYFcczgjPWvqy8h+lxO8l2yC49sYPUOnBsob
        GTk9ywkaZwUa/3BCXiBZUIXZvpPVBuyZkP/hvtOtVDEBtFklyZAZbcGpuXdC6gkIWkmFMzD61Bv+q
        NtNatYmqpSp1sR4IPEvss5XLtXw72vWwQYA2e2c573P0ws8ZvQoHj0wTmvhFbUaSkfZTv2bTR7P/b
        sTsoXAGfbPyJvx92hQOKPkfJuT0T+O9WEzLxD6GDUgZ1N/VqUIzWLoNlK3wlxEMmz6Cpgkyic9gry
        nEvDX58g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qU563-00CYcJ-PM; Thu, 10 Aug 2023 12:48:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6867D30003A;
        Thu, 10 Aug 2023 14:48:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C00E203C78D8; Thu, 10 Aug 2023 14:48:59 +0200 (CEST)
Date:   Thu, 10 Aug 2023 14:48:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 04/17] objtool/x86: Fix SRSO mess
Message-ID: <20230810124859.GZ212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.715361518@infradead.org>
 <20230810120615.GGZNTSt49g/2YCTGYI@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810120615.GGZNTSt49g/2YCTGYI@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:06:15PM +0200, Borislav Petkov wrote:
> On Wed, Aug 09, 2023 at 09:12:22AM +0200, Peter Zijlstra wrote:
> > arch_is_rethunk() indicates those functions that will be considered
> > equivalent to INSN_RETURN and any callsite will be added to the
> > .return_sites section.
> > 
> > Notably: srso_untrain_ret, srso_safe_ret and __ret do not qualify.
> 
> They do not qualify *anymore*. Before your changes, the last two would
> call RET.

They were wrong too before too. From the previous email (slightly
refined), you had:

SYNC_FUNC_START(foo)
	...
	ALTERNATIVE "jmp __x86_return_thunk",
		    "ret; int3" ALT_NOT(X86_FEATURE_RETHUNK)
SYM_FUNC_END(foo)

SYM_FUNC_START(__x86_return_thunk)
	ALTERNATIVE "jmp __ret",
		    "call srso_safe_ret", X86_FEATURE_SRSO,
		    "call srso_alias_safe_ret", X86_FEATURE_SRSO_ALIAS
	int3
SYM_FUNC_END(__x86_return_thunk)


so we want foo's "jmp __x86_return_thunk" to end up in .return_sites.

But what you had would also add __x86_return_thunk's 'jmp __ret' to
.return_sites. And .altins_replacement's 'call srso_safe_ret' in
.return_sites if we're unlucky.

You do *NOT* want those in .return_sites.


objtool did two things:

 - generate .return_sites to rewrite all the compiler generated 'jmp
   __x86_return_thunk' sites to either 'ret; int3' or a jump to your
   function of choice (default __x86_return_thunk).

 - not get confused by the fact that __x86_return_thunk is in the middle
   of another instruction and zen_untrain_ret's validation fails to find
   the jump target because it doesn't know this instruction -- because
   it's inside another instruction.

Before all this they were both __x86_return_thunk, there was no
distinction needed.

But now there is, you still only want 'jmp __x86_return_thunk' to end up
in .return_sites. As per the above, you very much do *NOT* want any
other things on there.

But you added one more magic function inside another instruction
instance and had it identified at return_thunk, which is a fail.

Worse, you also added srso_untrain_ret, even though that really
shouldn't have been added since it doesn't suffer any of the above two
things.


