Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314DC80A91C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574051AbjLHQfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574057AbjLHQfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:35:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A1C19AA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:35:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBEEC433C8;
        Fri,  8 Dec 2023 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702053308;
        bh=SUBvtEn9z9UrSU17r7Cw0HAstRv+zJkI6nOLOYxgtBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgZj87RJDMQntv41jgP4YNzanNPs+Fpah5vLvv/Fi7x0xv29OoS4clgN/qIAyR3jV
         hNHJeCEa/bbQa3tIPnXKAXv1XPy755Z5yFhAqz/ZNGNCeHC60vxB53+qo4cZ5ZDMGt
         1bKvP6XKSFo//muVUOZZnkbmDgADqtIdir6Z1wlBqONgp6SxBcA0Fpg4TBCaa7JPoH
         DyIwjCw1N0hyzBtUCNEkS+BkeEJHcvJ2vMCyeg2HJIFUbmpLMN74veO6ZY9RsKKn+X
         WnLEVHuFTlAKZL/rOOjuiuX5Vaa7uEQymnLPerK8Spbtr8wV1Ef8GfvngNKvimkVO8
         EumXuDYVXZszg==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 2/9] powerpc/ftrace: Unify 32-bit and 64-bit ftrace entry code
Date:   Fri,  8 Dec 2023 22:00:41 +0530
Message-ID: <e89bb62a9bca1b60c758dc78980be677d6768ed1.1702045299.git.naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702045299.git.naveen@kernel.org>
References: <cover.1702045299.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit powerpc, gcc generates a three instruction sequence for
function profiling:
	mflr	r0
	stw	r0, 4(r1)
	bl	_mcount

On kernel boot, the call to _mcount() is nop-ed out, to be patched back
in when ftrace is actually enabled. The 'stw' instruction therefore is
not necessary unless ftrace is enabled. Nop it out during ftrace init.

When ftrace is enabled, we want the 'stw' so that stack unwinding works
properly. Perform the same within the ftrace handler, similar to 64-bit
powerpc.

For 64-bit powerpc, early versions of gcc used to emit a three
instruction sequence for function profiling (with -mprofile-kernel) with
a 'std' instruction to mimic the 'stw' above. Address that scenario also
by nop-ing out the 'std' instruction during ftrace init.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/trace/ftrace.c       | 6 ++++--
 arch/powerpc/kernel/trace/ftrace_entry.S | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 82010629cf88..2956196c98ff 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -229,13 +229,15 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 		/* Expected sequence: 'mflr r0', 'stw r0,4(r1)', 'bl _mcount' */
 		ret = ftrace_validate_inst(ip - 8, ppc_inst(PPC_RAW_MFLR(_R0)));
 		if (!ret)
-			ret = ftrace_validate_inst(ip - 4, ppc_inst(PPC_RAW_STW(_R0, _R1, 4)));
+			ret = ftrace_modify_code(ip - 4, ppc_inst(PPC_RAW_STW(_R0, _R1, 4)),
+						 ppc_inst(PPC_RAW_NOP()));
 	} else if (IS_ENABLED(CONFIG_MPROFILE_KERNEL)) {
 		/* Expected sequence: 'mflr r0', ['std r0,16(r1)'], 'bl _mcount' */
 		ret = ftrace_read_inst(ip - 4, &old);
 		if (!ret && !ppc_inst_equal(old, ppc_inst(PPC_RAW_MFLR(_R0)))) {
 			ret = ftrace_validate_inst(ip - 8, ppc_inst(PPC_RAW_MFLR(_R0)));
-			ret |= ftrace_validate_inst(ip - 4, ppc_inst(PPC_RAW_STD(_R0, _R1, 16)));
+			ret |= ftrace_modify_code(ip - 4, ppc_inst(PPC_RAW_STD(_R0, _R1, 16)),
+						  ppc_inst(PPC_RAW_NOP()));
 		}
 	} else {
 		return -EINVAL;
diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 40677416d7b2..17d1ed3d0b40 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -33,6 +33,8 @@
  * and then arrange for the ftrace function to be called.
  */
 .macro	ftrace_regs_entry allregs
+	/* Save the original return address in A's stack frame */
+	PPC_STL		r0, LRSAVE(r1)
 	/* Create a minimal stack frame for representing B */
 	PPC_STLU	r1, -STACK_FRAME_MIN_SIZE(r1)
 
@@ -44,8 +46,6 @@
 	SAVE_GPRS(3, 10, r1)
 
 #ifdef CONFIG_PPC64
-	/* Save the original return address in A's stack frame */
-	std	r0, LRSAVE+SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE(r1)
 	/* Ok to continue? */
 	lbz	r3, PACA_FTRACE_ENABLED(r13)
 	cmpdi	r3, 0
-- 
2.43.0

