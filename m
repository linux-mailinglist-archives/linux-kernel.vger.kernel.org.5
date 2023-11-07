Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08837E3C70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjKGMQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjKGMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:15:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7491270D;
        Tue,  7 Nov 2023 04:11:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1432C43391;
        Tue,  7 Nov 2023 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359095;
        bh=zSrIQgw/YAK/2n4kkUjBaCOfBLHX9FZqFa2FLZAbeyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRssxghFmAPBC+Ey5eFIOBNY8se0kwpdV2ZdGp+6n1zL1gZgPktHg6o0SwjDyIGfZ
         s+FN31TS5vUxxkoc+vFlZjLQrTkV6NGX0xtz6mBNHK6grCsX6Xvj+GGYBzZtxHBuRC
         KqOOKWcY5m15xreK8u9NS1NnyteZvRzuv9gbGZQwfhgQ3BzvS1ABhaD8tQwE/pFMsg
         d/5KVccV1KDuvxt9teGZj8/66N66dnv4/O+qbsEVqXDVUKnZxXqwjay3WP+jRVKc5U
         PHSWJGik8pTllhnhdRzEe+NEq2Pd5OQ039SGlxm4Ce4InuRBwVMe0ha+i0DjRutn3e
         jQscsxDonE4SQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ast@kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/18] bpf: Ensure proper register state printing for cond jumps
Date:   Tue,  7 Nov 2023 07:10:42 -0500
Message-ID: <20231107121104.3757943-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121104.3757943-1-sashal@kernel.org>
References: <20231107121104.3757943-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 1a8a315f008a58f54fecb012b928aa6a494435b3 ]

Verifier emits relevant register state involved in any given instruction
next to it after `;` to the right, if possible. Or, worst case, on the
separate line repeating instruction index.

E.g., a nice and simple case would be:

  2: (d5) if r0 s<= 0x0 goto pc+1       ; R0_w=0

But if there is some intervening extra output (e.g., precision
backtracking log) involved, we are supposed to see the state after the
precision backtrack log:

  4: (75) if r0 s>= 0x0 goto pc+1
  mark_precise: frame0: last_idx 4 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=r0 stack= before 2: (d5) if r0 s<= 0x0 goto pc+1
  mark_precise: frame0: regs=r0 stack= before 1: (b7) r0 = 0
  6: R0_w=0

First off, note that in `6: R0_w=0` instruction index corresponds to the
next instruction, not to the conditional jump instruction itself, which
is wrong and we'll get to that.

But besides that, the above is a happy case that does work today. Yet,
if it so happens that precision backtracking had to traverse some of the
parent states, this `6: R0_w=0` state output would be missing.

This is due to a quirk of print_verifier_state() routine, which performs
mark_verifier_state_clean(env) at the end. This marks all registers as
"non-scratched", which means that subsequent logic to print *relevant*
registers (that is, "scratched ones") fails and doesn't see anything
relevant to print and skips the output altogether.

print_verifier_state() is used both to print instruction context, but
also to print an **entire** verifier state indiscriminately, e.g.,
during precision backtracking (and in a few other situations, like
during entering or exiting subprogram).  Which means if we have to print
entire parent state before getting to printing instruction context
state, instruction context is marked as clean and is omitted.

Long story short, this is definitely not intentional. So we fix this
behavior in this patch by teaching print_verifier_state() to clear
scratch state only if it was used to print instruction state, not the
parent/callback state. This is determined by print_all option, so if
it's not set, we don't clear scratch state. This fixes missing
instruction state for these cases.

As for the mismatched instruction index, we fix that by making sure we
call print_insn_state() early inside check_cond_jmp_op() before we
adjusted insn_idx based on jump branch taken logic. And with that we get
desired correct information:

  9: (16) if w4 == 0x1 goto pc+9
  mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1
  mark_precise: frame0: parent state regs=r4 stack=: R2_w=1944 R4_rw=P1 R10=fp0
  mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9
  mark_precise: frame0: regs=r4 stack= before 8: (66) if w4 s> 0x3 goto pc+5
  mark_precise: frame0: regs=r4 stack= before 7: (b7) r4 = 1
  9: R4=1

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20231011223728.3188086-6-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb3f52be115d6..7fbc6492fe7b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -978,7 +978,8 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 	if (state->in_async_callback_fn)
 		verbose(env, " async_cb");
 	verbose(env, "\n");
-	mark_verifier_state_clean(env);
+	if (!print_all)
+		mark_verifier_state_clean(env);
 }
 
 static inline u32 vlog_alignment(u32 pos)
@@ -10476,6 +10477,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
 					       *insn_idx))
 			return -EFAULT;
+		if (env->log.level & BPF_LOG_LEVEL)
+			print_insn_state(env, this_branch->frame[this_branch->curframe]);
 		*insn_idx += insn->off;
 		return 0;
 	} else if (pred == 0) {
@@ -10488,6 +10491,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 					       *insn_idx + insn->off + 1,
 					       *insn_idx))
 			return -EFAULT;
+		if (env->log.level & BPF_LOG_LEVEL)
+			print_insn_state(env, this_branch->frame[this_branch->curframe]);
 		return 0;
 	}
 
-- 
2.42.0

