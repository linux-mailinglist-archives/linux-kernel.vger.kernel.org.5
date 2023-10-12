Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB47C6302
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376765AbjJLCrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJLCrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:47:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B50A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:47:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EC2C433C8;
        Thu, 12 Oct 2023 02:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697078860;
        bh=vhaHa8oKbBL75azKtpMU5ef0xkRutZtJTgdLyMCYYkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eL+erSy7d10Jqji3GPYgAwTz6KfGrwSZ38v1Yhjdgos3aZ4jVE2EFku1x6pGc1NVK
         3kwMcM9THnC6qTF9iCJBOdIK50UH8tciwpeNXAc44rGz/m5PDFplWN8E9Msoxt9y34
         a5+Z+jVf087YhX+BNBInV01ed+EZGAsrvopZOr0aNGaw5S9Dyu8TLnKC0Y1n2Gfma+
         fSBqNp5Mqte4siSpugopi9qfkLvhjWt/uskk0IKX/3NMc+PG0RiKs7Jpow89q6E3Gt
         /BmFvA6mCfCwCnoIaiDXceOYBY5C006Es0IL1yNHk5i+xA574KO0hANbo/HOFJE+MD
         QKNJurnGQ+6bA==
Date:   Wed, 11 Oct 2023 19:47:37 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] objtool: Fix return thunk patching in retpolines
Message-ID: <20231012024737.eg5phclogp67ik6x@treble>
References: <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
 <20231010212254.ypk2wdogno55shit@treble>
 <20231011074142.GK14330@noisy.programming.kicks-ass.net>
 <20231011162843.grv6kixw4ides6uw@treble>
 <20231011223513.GH6307@noisy.programming.kicks-ass.net>
 <20231012022758.lf62lgf5jx5xrno7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012022758.lf62lgf5jx5xrno7@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
a return thunk (or retpoline).

Fixes: e92626af3234 ("x86/retpoline: Remove .text..__x86.return_thunk section")
Reported-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e308d1ba664e..e94756e09ca9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1610,6 +1610,22 @@ static int add_jump_destinations(struct objtool_file *file)
 			return -1;
 		}
 
+		/*
+		 * An intra-TU jump in retpoline.o might not have a relocation
+		 * for its jump dest, in which case the above
+		 * add_{retpoline,return}_call() didn't happen.
+		 */
+		if (jump_dest->sym && jump_dest->offset == jump_dest->sym->offset) {
+			if (jump_dest->sym->retpoline_thunk) {
+				add_retpoline_call(file, insn);
+				continue;
+			}
+			if (jump_dest->sym->return_thunk) {
+				add_return_call(file, insn, true);
+				continue;
+			}
+		}
+
 		/*
 		 * Cross-function jump.
 		 */
-- 
2.41.0

