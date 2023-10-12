Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCEA7C658B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377349AbjJLG0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjJLG0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:26:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A780EA;
        Wed, 11 Oct 2023 23:25:37 -0700 (PDT)
Date:   Thu, 12 Oct 2023 06:25:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697091935;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1KP8+oYpEZJePS2HiaWvpVh2+B/XGV8vKsjA2aqHYE=;
        b=j61sW8/sUZXIQ/adfLuYN7iklzU0Jh046d4LL2MpfYwz2PoIXQ1f481mkuXoaZB5yHuSRh
        P1oTRAnynw0luB9D+KJvMc4jOE3Qy6j1etDxw+gDbh/ys3+jOvTv5tWtH3oK8GLC1O1vxv
        0hCH4xUN75TbUR4KhfA5+4cZp3RObS02Ola7dPzOYILS9vwnznf+PK8Cpr/ZVXQpvvSDdX
        2vWLwIJ8Y95gS5V9OGmK1XvVyWhcWp6U0Eht9usxSuW8kxuYnypOgA7ikLtaVDF4y8pSsB
        fFayguNBq9Hq2JbTst5jMrc8IZYDS35n+N9MNf5OgdRJOrGcYuYmjhcbNxiMxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697091935;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1KP8+oYpEZJePS2HiaWvpVh2+B/XGV8vKsjA2aqHYE=;
        b=Rxu0bIRJMXUeTT0PCRdIyO5IngsCO67b/txdSinbxfO1AV5nS3hyzc4Pr5A711TKVFhDoG
        JotGywgiy2Sh19DA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] objtool: Fix return thunk patching in retpolines
Cc:     David Kaplan <david.kaplan@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231012024737.eg5phclogp67ik6x@treble>
References: <20231012024737.eg5phclogp67ik6x@treble>
MIME-Version: 1.0
Message-ID: <169709193522.3135.3437936240922691575.tip-bot2@tip-bot2>
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

Commit-ID:     3ab1bb69862d4477e2ffa556075a251bd7328910
Gitweb:        https://git.kernel.org/tip/3ab1bb69862d4477e2ffa556075a251bd7328910
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 11 Oct 2023 19:47:37 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Oct 2023 08:21:29 +02:00

objtool: Fix return thunk patching in retpolines

With CONFIG_RETHUNK enabled, the compiler replaces every RET with a tail
call to a return thunk ('JMP __x86_return_thunk').  Objtool annotates
all such return sites so they can be patched during boot by
apply_returns().

The implementation of __x86_return_thunk() is just a bare RET.  It's
only meant to be used temporarily until apply_returns() patches all
return sites with either a JMP to another return thunk or an actual RET.

The following commit:

  e92626af3234 ("x86/retpoline: Remove .text..__x86.return_thunk section")

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
