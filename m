Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E477D0E97
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377168AbjJTLhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376988AbjJTLhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:37:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A77D4C;
        Fri, 20 Oct 2023 04:37:16 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801835;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+ptQnvlrK5Wl+iHM0CGZ1eWdW1lTR+wvpqSbU/A2ws=;
        b=R3vxINwFrsfkIBMvq34WQhv7viQ2ZcWF02Z1aXO4/8Is+DB0DD1v4ztTohLOfgUXu5PYXN
        xNXkE6dChi1sQtveueIitFuTU93uG5HTPdkAyVnmsI7HL5MdBod3488AxPZIe9esA0Vkma
        8KUGThehVU+E+bvSBj6ra4OwxaGGhamz6jM8JwGcYn+cNliV1rQZWxiQITQo4f2rHyd+FO
        2p7RSX00A4PHiBCKkd1Ay2jlLB3KDKfv381swLto81ye66tBHGBtq7ogVcjqjAbFex85DX
        dtMWwH8PUmDIJ+ESblaexbnhQDggWNg+riIXOt9qonWjTl9ehzxTO8qVnW19RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801835;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+ptQnvlrK5Wl+iHM0CGZ1eWdW1lTR+wvpqSbU/A2ws=;
        b=1OyLoAXHLjuoy5GiSQ6dR5QlsVX1dBRTPQgvW2rUocnh/eNWuc+KVHuM1KdCIxSf8cmCuB
        HERpo9WdmxtpSMBg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] objtool: Fix return thunk patching in retpolines
Cc:     David Kaplan <david.kaplan@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231012024737.eg5phclogp67ik6x@treble>
References: <20231012024737.eg5phclogp67ik6x@treble>
MIME-Version: 1.0
Message-ID: <169780183488.3135.1271262066935601198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     34de4fe7d1326c5c27890df3297dffd4c7196b0e
Gitweb:        https://git.kernel.org/tip/34de4fe7d1326c5c27890df3297dffd4c7196b0e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 11 Oct 2023 19:47:37 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Oct 2023 12:51:41 +02:00

objtool: Fix return thunk patching in retpolines

With CONFIG_RETHUNK enabled, the compiler replaces every RET with a tail
call to a return thunk ('JMP __x86_return_thunk').  Objtool annotates
all such return sites so they can be patched during boot by
apply_returns().

The implementation of __x86_return_thunk() is just a bare RET.  It's
only meant to be used temporarily until apply_returns() patches all
return sites with either a JMP to another return thunk or an actual RET.

Removing the .text..__x86.return_thunk section would break objtool's
detection of return sites in retpolines.  Since retpolines and return
thunks would land in the same section, the compiler no longer uses
relocations for the intra-section jumps between the retpolines and the
return thunk, causing objtool to overlook them.

As a result, none of the retpolines' return sites would get patched.
Each one stays at 'JMP __x86_return_thunk', effectively a bare RET.

Fix it by teaching objtool to detect when a non-relocated jump target is
a return thunk (or retpoline).

  [ bp: Massage the commit message now that the offending commit
    removing the .text..__x86.return_thunk section has been zapped.
    Still keep the objtool change here as it makes objtool more robust
    wrt handling such intra-TU jumps without relocations, should some
    toolchain and/or config generate them in the future. ]

Reported-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231012024737.eg5phclogp67ik6x@treble
---
 tools/objtool/check.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e308d1b..e94756e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1611,6 +1611,22 @@ static int add_jump_destinations(struct objtool_file *file)
 		}
 
 		/*
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
+		/*
 		 * Cross-function jump.
 		 */
 		if (insn_func(insn) && insn_func(jump_dest) &&
