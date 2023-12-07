Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5CB807F29
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjLGDaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjLGD36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:29:58 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D31819E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 19:30:02 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxfOo4PHFl+oQ_AA--.34214S3;
        Thu, 07 Dec 2023 11:30:00 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3tw0PHFlBCFXAA--.60649S3;
        Thu, 07 Dec 2023 11:29:59 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] LoongArch: BPF: Fix sign-extension mov instructions
Date:   Thu,  7 Dec 2023 11:29:50 +0800
Message-ID: <20231207032951.16334-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207032951.16334-1-yangtiezhu@loongson.cn>
References: <20231207032951.16334-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3tw0PHFlBCFXAA--.60649S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar48Xr47uw47ZF15Xw4kKrX_yoW8WF1rpr
        s8Crs5KrWxX3yI9a4kA3y7XF4qkFs5Gr13Ga4aqay8WwsxXryUXF1xKw1Utan5JrZYvFW8
        ua4Skwn09a4kXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8niSPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can see that "Short form of movsx, dst_reg = (s8,s16,s32)src_reg"
in include/linux/filter.h, additionally, for BPF_ALU64 the value of
the destination register is unchanged whereas for BPF_ALU the upper
32 bits of the destination register are zeroed, so it should clear
the upper 32 bits for BPF_ALU.

[root@linux fedora]# echo 1 > /proc/sys/net/core/bpf_jit_enable
[root@linux fedora]# modprobe test_bpf

Before:
test_bpf: #81 ALU_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
test_bpf: #82 ALU_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)

After:
test_bpf: #81 ALU_MOVSX | BPF_B jited:1 6 PASS
test_bpf: #82 ALU_MOVSX | BPF_H jited:1 6 PASS

By the way, the bpf selftest case "./test_progs -t verifier_movsx" can
also be fixed with this patch.

Fixes: f48012f16150 ("LoongArch: BPF: Support sign-extension mov instructions")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 169ff8b3915e..8c907c2c42f7 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -480,10 +480,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		case 8:
 			move_reg(ctx, t1, src);
 			emit_insn(ctx, extwb, dst, t1);
+			emit_zext_32(ctx, dst, is32);
 			break;
 		case 16:
 			move_reg(ctx, t1, src);
 			emit_insn(ctx, extwh, dst, t1);
+			emit_zext_32(ctx, dst, is32);
 			break;
 		case 32:
 			emit_insn(ctx, addw, dst, src, LOONGARCH_GPR_ZERO);
-- 
2.42.0

