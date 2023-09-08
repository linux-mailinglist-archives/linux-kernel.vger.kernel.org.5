Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340A0798D67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbjIHSVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbjIHSUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:20:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C95D2D62;
        Fri,  8 Sep 2023 11:19:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2885C4166B;
        Fri,  8 Sep 2023 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197082;
        bh=C1BnmGLJT9NoxlOUfK1c5na4HhanWQLdO6b0FjJqhq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teaPWG5LhRDbBfdxI7E7P5NASwbHwk0lWhxq+Bl9tNM1u0VVOWufyIGElP35KykP1
         nMZxIeKy3dbIjRn6lO8TZ/kRAqWCcOgUza5AN60L+SXapJC3BdO3E7oB/R+GYansLA
         JNrHJFmgCunlxOOgmz0C3gIBkKadxjr8GFDbTe2VsA0Vxg7zmWtmrgTimKu7pYr36m
         GQ5xmzzsYEg72j4R8h65SwIEsEl+aklRfJ5oJ2UdMaU+KvGuA4dA86ZUSpJDU7VtTO
         FGH5XzJNm5fGvLuIGpMCwuMz1fpkHXMt2p4yrqxKVx1R8cZa3Lor6ZzIWsDc3XNKke
         aN//1CqXNhcgw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 41/41] bpf: Consider non-owning refs to refcounted nodes RCU protected
Date:   Fri,  8 Sep 2023 14:15:55 -0400
Message-Id: <20230908181555.3459640-41-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Marchevsky <davemarchevsky@fb.com>

[ Upstream commit 0816b8c6bf7fc87cec4273dc199e8f0764b9e7b1 ]

An earlier patch in the series ensures that the underlying memory of
nodes with bpf_refcount - which can have multiple owners - is not reused
until RCU grace period has elapsed. This prevents
use-after-free with non-owning references that may point to
recently-freed memory. While RCU read lock is held, it's safe to
dereference such a non-owning ref, as by definition RCU GP couldn't have
elapsed and therefore underlying memory couldn't have been reused.

From the perspective of verifier "trustedness" non-owning refs to
refcounted nodes are now trusted only in RCU CS and therefore should no
longer pass is_trusted_reg, but rather is_rcu_reg. Let's mark them
MEM_RCU in order to reflect this new state.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Link: https://lore.kernel.org/r/20230821193311.3290257-6-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h   |  3 ++-
 kernel/bpf/verifier.c | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1ad211acf1d25..0646d377dae7f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -640,7 +640,8 @@ enum bpf_type_flag {
 	MEM_RCU			= BIT(13 + BPF_BASE_TYPE_BITS),
 
 	/* Used to tag PTR_TO_BTF_ID | MEM_ALLOC references which are non-owning.
-	 * Currently only valid for linked-list and rbtree nodes.
+	 * Currently only valid for linked-list and rbtree nodes. If the nodes
+	 * have a bpf_refcount_field, they must be tagged MEM_RCU as well.
 	 */
 	NON_OWN_REF		= BIT(14 + BPF_BASE_TYPE_BITS),
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4fbfe1d086467..ad44f64c2dec6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7646,6 +7646,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. In the other cases, fixed offset
 		 * can be non-zero. This was already checked above. So pass
@@ -10106,6 +10107,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_verifier_state *state = env->cur_state;
+	struct btf_record *rec = reg_btf_record(reg);
 
 	if (!state->active_lock.ptr) {
 		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
@@ -10118,6 +10120,9 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 	}
 
 	reg->type |= NON_OWN_REF;
+	if (rec->refcount_off >= 0)
+		reg->type |= MEM_RCU;
+
 	return 0;
 }
 
@@ -10936,6 +10941,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
 
+		if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
+			verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
+			return -EACCES;
+		}
+
 		if (rcu_lock) {
 			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
 			return -EINVAL;
@@ -16234,7 +16244,8 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_rcu_lock) {
+				if (env->cur_state->active_rcu_lock &&
+				    !in_rbtree_lock_required_cb(env)) {
 					verbose(env, "bpf_rcu_read_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.40.1

