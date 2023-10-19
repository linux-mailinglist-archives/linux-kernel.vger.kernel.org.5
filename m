Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C697CFDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbjJSPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346191AbjJSPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:20:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C184012A;
        Thu, 19 Oct 2023 08:20:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE0FC433C7;
        Thu, 19 Oct 2023 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697728854;
        bh=lQaE1qMfGaNQfTwIe5gsMhygImrbmEJBUzXnM8oRqOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAMrYUfqy9YtSKcNVGNUHSqvs4ZS62SLGOSZp38atMXAvaTU/HDW+d6H6WCP/jkkx
         NJHM/afUfi6Mrn3RSjK4NEjCBypDfmty0FHKTsf+mXc+Boa3z40aSNxLjiwKUer2Lj
         E9ypcEZrhVgJntVbZJ4ZAgCQjKKjEaHTSuLCn0rJ8iwQXwc9ZRajahgmDAg8BF/Ifx
         QONpNAq65QWE3mGq0w+pLVFYINauYl+81D9ANQh4UGKEwFKuvBCY/IxwWZ3iZrjuQh
         ujEg5+FNEEeG6E35/bwkdz8TOjcs1dAHNChhwF5GHxWZ3nBUTpGyzVpQv4P8wF2ULu
         k5c1Vule/NLNA==
Date:   Thu, 19 Oct 2023 08:20:51 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kaplan, David" <David.Kaplan@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231019152051.4u5xwhopbdisy6zl@treble>
References: <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
 <20231019063527.iwgyioxi2gznnshp@treble>
 <20231019065928.mrvhtfaya22p2uzw@treble>
 <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
 <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 04:39:51PM +0200, Borislav Petkov wrote:
> On Thu, Oct 19, 2023 at 02:21:40PM +0000, Kaplan, David wrote:
> > The return thunk is used for all functions though, including assembly
> > coded functions which may use non-standard calling conventions and
> > aren't visible to gcc.  I think the only safe thing would be to
> > preserve all GPRs across the call to check_thunks.  Something like
> > PUSH_REGS/call check_thunks/POP_REGS.
> 
> That call nop will be inside the return thunk. I.e., something like
> this:
> 
> SYM_CODE_START(__x86_return_thunk)
>         UNWIND_HINT_FUNC
>         ANNOTATE_NOENDBR
>         ANNOTATE_UNRET_SAFE
> 	ALTERNATIVE CALL nop, check_thunks, X86_FEATURE_ALWAYS
> 	ret
> 	int3
> SYM_CODE_END(__x86_return_thunk)
> EXPORT_SYMBOL(__x86_return_thunk)
> 
> I suspect that gcc doesn't know that there is a function call in the asm
> there, which is also what you hint at - I need to ask a compiler guy.
> 
> But yeah, if it doesn't, then we'll need to push/pop regs as you
> suggest.

GCC doesn't read asm.  Even if it did that wouldn't fix things for
callers of custom-ABI return-thunk-using functions.

The below seems to work.

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 27b5da2111ac..54c043e010f9 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -46,3 +46,5 @@ THUNK preempt_schedule_thunk, preempt_schedule
 THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 EXPORT_SYMBOL(preempt_schedule_thunk)
 EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
+
+THUNK warn_thunk_thunk, __warn_thunk
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 14cd3cd5f85a..315e3f9410b2 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -357,6 +357,8 @@ extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
 
+extern void __warn_thunk(void);
+
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 extern void call_depth_return_thunk(void);
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb0ab8466b91..7d89fe7a2e69 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2849,3 +2849,8 @@ ssize_t cpu_show_gds(struct device *dev, struct device_attribute *attr, char *bu
 	return cpu_show_common(dev, attr, buf, X86_BUG_GDS);
 }
 #endif
+
+void __warn_thunk(void)
+{
+	WARN_ONCE(1, "unpatched return thunk");
+}
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index fe05c139db48..389662b88e19 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -360,13 +360,14 @@ SYM_FUNC_END(call_depth_return_thunk)
  * 'JMP __x86_return_thunk' sites are changed to something else by
  * apply_returns().
  *
- * This thunk is turned into a ud2 to ensure it is never used at runtime.
- * Alternative instructions are applied after apply_returns().
+ * The RET is replaced with a WARN_ONCE() to ensure it is never used at
+ * runtime.  Alternative instructions are applied after apply_returns().
  */
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret),"ud2", X86_FEATURE_ALWAYS
+	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
+		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
 	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)

