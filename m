Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697957B7EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjJDMHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjJDMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:07:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F0DD7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:07:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29373C433CB;
        Wed,  4 Oct 2023 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696421241;
        bh=FcFliYtfyClr234Bg/rnUbyn6yhoW+Ofj/60M8uTrGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLUaEbOvU1kBTFb7wZoed/Rv0qLtoGKvSyOsVygiWjcfUAlkint7h1M+DWCNXvjwe
         NrOjlZcCRicZLfg2m2aFCTHDLXOb1HZmzUloc6WzK2rByf6Y7AXPNgSI6s+hdkR8Uo
         jK7yKdsGC9NY3PefxgD4iW5Sjdx3HNymiCYr/WU+GEjSkIdjVGakdiM7J+aM41wb+B
         A0yVL2c+P/TIxuXVK7RkpFjgT68TWPekSQM8B6fRS6RdmxBrAC/kQh3IU01ufgAMTq
         lPgpZzVbkka4E+2Q3OiyhlmxKCOcuk9ogp2Qm6QHS5D+vHqv8io7C8PWt7WwySB7ZC
         f1SMAfjxoZ2Dg==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Pu Lehui <pulehui@huawei.com>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, linux-riscv@lists.infradead.org
Subject: [PATCH bpf 1/2] riscv, bpf: Sign-extend return values
Date:   Wed,  4 Oct 2023 14:07:05 +0200
Message-Id: <20231004120706.52848-2-bjorn@kernel.org>
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

The RISC-V architecture does not expose sub-registers, and hold all
32-bit values in a sign-extended format [1] [2]:

  | The compiler and calling convention maintain an invariant that all
  | 32-bit values are held in a sign-extended format in 64-bit
  | registers. Even 32-bit unsigned integers extend bit 31 into bits
  | 63 through 32. Consequently, conversion between unsigned and
  | signed 32-bit integers is a no-op, as is conversion from a signed
  | 32-bit integer to a signed 64-bit integer.

While BPF, on the other hand, exposes sub-registers, and use
zero-extension (similar to arm64/x86).

This has led to some subtle bugs, where a BPF JITted program has not
sign-extended the a0 register (return value in RISC-V land), passed
the return value up the kernel, e.g.:

  | int from_bpf(void);
  |
  | long foo(void)
  | {
  |    return from_bpf();
  | }

Here, a0 would be 0xffff_ffff, instead of the expected
0xffff_ffff_ffff_ffff.

Internally, the RISC-V JIT uses a5 as a dedicated register for BPF
return values.

Keep a5 zero-extended, but explicitly sign-extend a0 (which is used
outside BPF land). Now that a0 (RISC-V ABI) and a5 (BPF ABI) differs,
a0 is only moved to a5 for non-BPF native calls (BPF_PSEUDO_CALL).

Link: https://github.com/riscv/riscv-isa-manual/releases/download/riscv-isa-release-056b6ff-2023-10-02/unpriv-isa-asciidoc.pdf # [2]
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf # [2]
Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index ecd3ae6f4116..de4c9957d223 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -245,7 +245,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
 	/* Set return value. */
 	if (!is_tail_call)
-		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
+		emit_addiw(RV_REG_A0, RV_REG_A5, 0, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
 		  is_tail_call ? (RV_FENTRY_NINSNS + 1) * 4 : 0, /* skip reserved nops and TCC init */
 		  ctx);
@@ -1515,7 +1515,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (ret)
 			return ret;
 
-		emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
+		if (insn->src_reg != BPF_PSEUDO_CALL)
+			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
 	}
 	/* tail call */
-- 
2.39.2

