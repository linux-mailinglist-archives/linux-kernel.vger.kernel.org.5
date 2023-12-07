Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09479807F28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjLGDaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLGD35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:29:57 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07F7018D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 19:30:02 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxrus5PHFl_YQ_AA--.58501S3;
        Thu, 07 Dec 2023 11:30:01 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3tw0PHFlBCFXAA--.60649S4;
        Thu, 07 Dec 2023 11:30:00 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] LoongArch: BPF: Fix unconditional bswap instructions
Date:   Thu,  7 Dec 2023 11:29:51 +0800
Message-ID: <20231207032951.16334-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207032951.16334-1-yangtiezhu@loongson.cn>
References: <20231207032951.16334-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3tw0PHFlBCFXAA--.60649S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw45KrW7Gw4DJr1DWw1fZrc_yoW8Ww1Dpr
        sFyrs5KrW0gFy7Xa4UX3yxJr4jkan5A3WUJF1av34rGa9Fqw1UWF18Kw1YvasIy3yvva40
        qa1jkFnIgF1UuagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
        14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8gAw7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can see that "bswap32: Takes an unsigned 32-bit number in either
big- or little-endian format and returns the equivalent number with
the same bit width but opposite endianness" in BPF Instruction Set
Specification, so it should clear the upper 32 bits in the case 32
for BPF_ALU and BPF_ALU64.

[root@linux fedora]# echo 1 > /proc/sys/net/core/bpf_jit_enable
[root@linux fedora]# modprobe test_bpf

Before:
test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 ret 1460850314 != -271733879 (0x5712ce8a != 0xefcdab89)FAIL (1 times)
test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 ret -1460850316 != 271733878 (0xa8ed3174 != 0x10325476)FAIL (1 times)

After:
test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 4 PASS
test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 4 PASS

Fixes: 4ebf9216e7df ("LoongArch: BPF: Support unconditional bswap instructions")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 8c907c2c42f7..da48398e8794 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -774,8 +774,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			break;
 		case 32:
 			emit_insn(ctx, revb2w, dst, dst);
-			/* zero-extend 32 bits into 64 bits */
-			emit_zext_32(ctx, dst, is32);
+			/* clear the upper 32 bits */
+			emit_zext_32(ctx, dst, true);
 			break;
 		case 64:
 			emit_insn(ctx, revbd, dst, dst);
-- 
2.42.0

