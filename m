Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FFC7C425A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbjJJVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjJJVW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:22:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF05991
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:22:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2179CC433C8;
        Tue, 10 Oct 2023 21:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696972976;
        bh=92/rhgJQgW0IguxjkQ9zaKQHYtda7wa0gYMUcGbkklM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqn294FHXWs1B31Ge4hykxr4U+h1xE6UxW0tpkkQ1D1Ti/IWGMsPBF5cRUx60I1Zk
         DTK1gMSErrojn8g17ciTgNC6Zchs7we/+XQ0We03H+rtQ+0ah/ozwdnOl4wm+bAPPc
         4m42vrmToJIGm1Zmyz/FBJOZkkhFrwESUm8Pf0s52ZQUzSq7sY6jGv9kjs8JbVzpun
         pNcB9gmv5qjFG36Nx0xx/WRwfwEuP8JBPhbVJhXm0HFNwrWyXMhYsM2qCTXNuwd+Fv
         SaRxpO23n5nyndsoFwNgdWFNxnFV2k6mwsX1KjyEhLEz++E61Hs3PeV00iA89fpngY
         LHRZOcBtXmmrQ==
Date:   Tue, 10 Oct 2023 14:22:54 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231010212254.ypk2wdogno55shit@treble>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010201912.7pjksbparssqu34k@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 01:19:12PM -0700, Josh Poimboeuf wrote:
> On Tue, Oct 10, 2023 at 10:04:29PM +0200, Borislav Petkov wrote:
> > On Tue, Oct 10, 2023 at 12:57:21PM -0700, Josh Poimboeuf wrote:
> > > Also we could make objtool properly detect the non-relocated jump
> > > target.
> > 
> > I was wondering about that... I guess it can compute the JMP target and
> > compare it to the address of __x86_return_thunk?
> 
> Fine, you twisted my arm ;-)
> 
> This seems to do the trick.  Lemme write up a proper patch.

Here is said patch.

---8<---

From: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] objtool: Fix return thunk patching in retpolines

With CONFIG_RETHUNK enabled, the compiler replaces every RET with a tail
call to a return thunk ('JMP __x86_return_thunk').  Objtool annotates
all such return sites so they can be patched during boot by
apply_returns().

The implementation of __x86_return_thunk() is just a bare RET.  It's
only meant to be used temporarily until apply_returns() patches all
return sites with either a JMP to another return thunk or an actual RET.

The following commit

  e92626af3234 ("x86/retpoline: Remove .text..__x86.return_thunk section") retpolines

broke objtool's detection of return sites in retpolines.  Since
retpolines and return thunks are now in the same section, the compiler
no longer uses relocations for the intra-section jumps between the
retpolines and the return thunk, causing objtool to overlook them.

As a result, none of the retpolines' return sites get patched.  Each one
stays at 'JMP __x86_return_thunk', effectively a bare RET.

Fix it by teaching objtool to detect when a non-relocated jump target is
a return thunk.

Fixes: e92626af3234 ("x86/retpoline: Remove .text..__x86.return_thunk section")
Reported-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e308d1ba664e..556469db4239 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1610,6 +1610,15 @@ static int add_jump_destinations(struct objtool_file *file)
 			return -1;
 		}
 
+		/*
+		 * Since retpolines are in the same section as the return
+		 * thunk, they might not use a relocation when branching to it.
+		 */
+		if (jump_dest->sym && jump_dest->sym->return_thunk) {
+			add_return_call(file, insn, true);
+			continue;
+		}
+
 		/*
 		 * Cross-function jump.
 		 */
-- 
2.41.0

