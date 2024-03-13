Return-Path: <linux-kernel+bounces-101832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBDA87ABFB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16487285F79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612A6E5F2;
	Wed, 13 Mar 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnsvJboV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29676E5E4;
	Wed, 13 Mar 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347866; cv=none; b=qnQvhVWQd+h7/iQMS8QymSV9ixuJlTD6xjYW9AbgL6oQNBvAo+2JkmDdc5DVKDK9C4wLGnbAzXWhL8opklmaGrD57/H7UEkapjHOTpAZHXdOGXexsBV6V1enq0mebWrcZUjTKFQ6mlxDi+pE2fyV6Dpi7/8L71WtyN1nFDbmP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347866; c=relaxed/simple;
	bh=0349rCBtQHX3P/19UmozTqNz1mIKgWtcOTqH+LMfkwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBF8T0xNADyp/4weTId0ASeT3TuD5gXgUG81I76ogCet6aM6C3fzVlRLEno/IxxaAXMW+hR7HdUOTUq+6vjqI7r416LOA2zK0+rOhQjoxGd1VJOg7XukxZ1MpcvzIy40JhpOo5UBYv3Lbnc1qUh3vXhiNiCX3nuxTioZ7PexCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnsvJboV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD19C433B2;
	Wed, 13 Mar 2024 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347866;
	bh=0349rCBtQHX3P/19UmozTqNz1mIKgWtcOTqH+LMfkwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JnsvJboVfSSS46YlXFdTgsb/Ahfi97bmq0KlyW5CJOv9WQ8gOLUNWIgM1t35PttnN
	 mslc6XUXy8FGci9GlxkQ161rh1PM4TprUCxzxoixGfaYa5BllGXbpk0EnpnefqR+4w
	 UJDmtdEHkFffKWrri28sx/wzX8qYFbKVqdZ8K98bjampgxfKx0oGYyI1m3JD0EmCwh
	 q21q894omQc1vsTROaEXvLnw/AmC9OlONvxQnnrZxEZ8N5f/+QTmvW5XUu7vyEj0RS
	 sOL0UJuylckKY5X+4A9a5MUKKNghJnifNIh1zu81IQrVfxHqg4CTbI3bLJbQY1Fy+N
	 sZnSNd7gMU/CQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 29/60] bpf: check bpf_func_state->callback_depth when pruning states
Date: Wed, 13 Mar 2024 12:36:36 -0400
Message-ID: <20240313163707.615000-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit e9a8e5a587ca55fec6c58e4881742705d45bee54 ]

When comparing current and cached states verifier should consider
bpf_func_state->callback_depth. Current state cannot be pruned against
cached state, when current states has more iterations left compared to
cached state. Current state has more iterations left when it's
callback_depth is smaller.

Below is an example illustrating this bug, minimized from mailing list
discussion [0] (assume that BPF_F_TEST_STATE_FREQ is set).
The example is not a safe program: if loop_cb point (1) is followed by
loop_cb point (2), then division by zero is possible at point (4).

    struct ctx {
    	__u64 a;
    	__u64 b;
    	__u64 c;
    };

    static void loop_cb(int i, struct ctx *ctx)
    {
    	/* assume that generated code is "fallthrough-first":
    	 * if ... == 1 goto
    	 * if ... == 2 goto
    	 * <default>
    	 */
    	switch (bpf_get_prandom_u32()) {
    	case 1:  /* 1 */ ctx->a = 42; return 0; break;
    	case 2:  /* 2 */ ctx->b = 42; return 0; break;
    	default: /* 3 */ ctx->c = 42; return 0; break;
    	}
    }

    SEC("tc")
    __failure
    __flag(BPF_F_TEST_STATE_FREQ)
    int test(struct __sk_buff *skb)
    {
    	struct ctx ctx = { 7, 7, 7 };

    	bpf_loop(2, loop_cb, &ctx, 0);              /* 0 */
    	/* assume generated checks are in-order: .a first */
    	if (ctx.a == 42 && ctx.b == 42 && ctx.c == 7)
    		asm volatile("r0 /= 0;":::"r0");    /* 4 */
    	return 0;
    }

Prior to this commit verifier built the following checkpoint tree for
this example:

 .------------------------------------- Checkpoint / State name
 |    .-------------------------------- Code point number
 |    |   .---------------------------- Stack state {ctx.a,ctx.b,ctx.c}
 |    |   |        .------------------- Callback depth in frame #0
 v    v   v        v
   - (0) {7P,7P,7},depth=0
     - (3) {7P,7P,7},depth=1
       - (0) {7P,7P,42},depth=1
         - (3) {7P,7,42},depth=2
           - (0) {7P,7,42},depth=2      loop terminates because of depth limit
             - (4) {7P,7,42},depth=0    predicted false, ctx.a marked precise
             - (6) exit
(a)      - (2) {7P,7,42},depth=2
           - (0) {7P,42,42},depth=2     loop terminates because of depth limit
             - (4) {7P,42,42},depth=0   predicted false, ctx.a marked precise
             - (6) exit
(b)      - (1) {7P,7P,42},depth=2
           - (0) {42P,7P,42},depth=2    loop terminates because of depth limit
             - (4) {42P,7P,42},depth=0  predicted false, ctx.{a,b} marked precise
             - (6) exit
     - (2) {7P,7,7},depth=1             considered safe, pruned using checkpoint (a)
(c)  - (1) {7P,7P,7},depth=1            considered safe, pruned using checkpoint (b)

Here checkpoint (b) has callback_depth of 2, meaning that it would
never reach state {42,42,7}.
While checkpoint (c) has callback_depth of 1, and thus
could yet explore the state {42,42,7} if not pruned prematurely.
This commit makes forbids such premature pruning,
allowing verifier to explore states sub-tree starting at (c):

(c)  - (1) {7,7,7P},depth=1
       - (0) {42P,7,7P},depth=1
         ...
         - (2) {42,7,7},depth=2
           - (0) {42,42,7},depth=2      loop terminates because of depth limit
             - (4) {42,42,7},depth=0    predicted true, ctx.{a,b,c} marked precise
               - (5) division by zero

[0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linux.dev/

Fixes: bb124da69c47 ("bpf: keep track of max number of bpf_loop callback iterations")
Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20240222154121.6991-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7901ed358a0f..396c4c66932f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16238,6 +16238,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 {
 	int i;
 
+	if (old->callback_depth > cur->callback_depth)
+		return false;
+
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (!regsafe(env, &old->regs[i], &cur->regs[i],
 			     &env->idmap_scratch, exact))
-- 
2.43.0


