Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542647B7EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjJDMHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242218AbjJDMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:07:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6255F0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:07:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE09AC433C9;
        Wed,  4 Oct 2023 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696421244;
        bh=vLvgsGAj3vc8B6/nSYNfFLo6uk+g4NpV7dEmI8AKTYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffk7vBFT5mbKfpS4JsRj1/srW+OQBeawmaCbwedd64L5PBIXa35ukJio0aGa/79fP
         XDBl5Dqtggjo+cBwBIOgZTuARLyykM12k507R6ubzMvE42nQ2mkhwyn5J80OENEIO8
         m3Ag+25W74eAEFvJu1mfdI0GdG/B/l7fx9eOkhl+fRhEy9EzutvfDB7IuH3+cAM2Dp
         rUGeixzlVrVfIeeL3wZ6TSW0xUq9zLGPiBBeXGSRM+tE98wA3fqllIR+Q+IQHDCZ7A
         tCqaAqP3sb47Cf8hd462KfH4XTV8ZZxs1LSp6O2MSpCWgVNURx7xWbhuHNyFOqRwej
         CJSmc1nrCsyhQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Pu Lehui <pulehui@huawei.com>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, linux-riscv@lists.infradead.org
Subject: [PATCH bpf 2/2] riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values
Date:   Wed,  4 Oct 2023 14:07:06 +0200
Message-Id: <20231004120706.52848-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004120706.52848-1-bjorn@kernel.org>
References: <20231004120706.52848-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V BPF uses a5 for BPF return values, which are zero-extended,
whereas the RISC-V ABI uses a0 which is sign-extended. In other words,
a5 and a0 can differ, and are used in different context.

The BPF trampoline are used for both BPF programs, and regular kernel
functions.

Make sure that the RISC-V BPF trampoline saves, and restores both a0
and a5.

Fixes: 49b5e77ae3e2 ("riscv, bpf: Add bpf trampoline support for RV64")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index de4c9957d223..8581693e62d3 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -759,8 +759,10 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	if (ret)
 		return ret;
 
-	if (save_ret)
-		emit_sd(RV_REG_FP, -retval_off, regmap[BPF_REG_0], ctx);
+	if (save_ret) {
+		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
+		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
+	}
 
 	/* update branch with beqz */
 	if (ctx->insns) {
@@ -853,7 +855,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
 	if (save_ret) {
-		stack_size += 8;
+		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
 		retval_off = stack_size;
 	}
 
@@ -957,6 +959,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		if (ret)
 			goto out;
 		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
+		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
 		im->ip_after_call = ctx->insns + ctx->ninsns;
 		/* 2 nops reserved for auipc+jalr pair */
 		emit(rv_nop(), ctx);
@@ -988,8 +991,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_args(nregs, args_off, ctx);
 
-	if (save_ret)
+	if (save_ret) {
 		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
+		emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
+	}
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
 
-- 
2.39.2

