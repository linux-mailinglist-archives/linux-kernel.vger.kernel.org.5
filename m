Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A876DD21
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjHCB0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjHCB0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:26:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92E3590
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:26:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686efa1804eso306334b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 18:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691025970; x=1691630770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KnkEmzZYZtLV9bJcf/lKsKflsIaYK5O+EUs/jmBBVS8=;
        b=mW1d1iN57SrWe3nCbYedyyIjo5aVpEAFsdcvOI56OLPAO1wdvj8v71+OP/wjZcuJ+n
         nFtZYyqycgEH5gdLo7BKz2kb6v6/rM6bcQsLEo5JBupZ1kPGvS0pdKc5hN1p4IQSn0yb
         KPJc+3bTAi2pirNR+tZbOmjmq6abdFIWz7VmZpSAfQ45iS2LbsiDWAYM3OH4QeUFXYDi
         RqnAsx3J9XGQNOGuDzWCv7O8JK84QXDyoKdrcfUKDUiBdEzO0KKaefi7e41+DNe0Jd22
         SGpoWATjtNQru/ZttY9eJjGiluLbHvQz/kPR0hJcS/zvGs8r+8i5hzLMDVYDz2+AryGj
         BxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691025970; x=1691630770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnkEmzZYZtLV9bJcf/lKsKflsIaYK5O+EUs/jmBBVS8=;
        b=PJhzvOOveebpZwg3fk9Q6kOFM65ZhMLJCMd5XZ7dL0x+i0tYjyj5/znvLMajme0V+l
         pabHWOuxuXjRfiI/ORXvu4G+gCt1coG7Lk9axxUyQcipx6yBWI7Ok5VexwC3BKzhdmu1
         cr1LhCtQCImpPpM4fTLiBbIojBtoA45JnChGxhjLsLYnoijkuCDLIerp+7TWJo7lxIKZ
         azKbg2oZoKHu+5EqaHZo8uvc4qOoXKYhPXLST6+tFCOIAWcg1q8RggOgJyMP/mPaBw6O
         PUwwM/P04o9rmghEgrhGk5jA6a6jg98XkMoKpXMJKnQXEljB+Rz0m/lYE2dDYJ2lfUnP
         brjw==
X-Gm-Message-State: ABy/qLYttIK0hwcG94VYSAv9V03WXWBE/1t83Fq6GiLtyg0BYddfoHNn
        d0OEZi6MN0SHC648QMVpMbP1EQ==
X-Google-Smtp-Source: APBJJlEVv6aXJeOnSSSQQWns6Sl8BpWl9aS5x67fhg3fIVNKMvhNnd0rpPfLUYh52tUPu5B+lSL06A==
X-Received: by 2002:a05:6a20:4cf:b0:134:a478:6061 with SMTP id 15-20020a056a2004cf00b00134a4786061mr16915077pzd.26.1691025970144;
        Wed, 02 Aug 2023 18:26:10 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id z1-20020a170903018100b001b6a27dff99sm13025734plg.159.2023.08.02.18.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 18:26:09 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH] riscv: Fix CPU feature detection with SMP disabled
Date:   Wed,  2 Aug 2023 18:26:06 -0700
Message-ID: <20230803012608.3540081-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 914d6f44fc50 ("RISC-V: only iterate over possible CPUs in ISA
string parser") changed riscv_fill_hwcap() from iterating over CPU DT
nodes to iterating over logical CPU IDs. Since this function runs long
before cpu_dev_init() creates CPU devices, it hits the fallback path in
of_cpu_device_node_get(), which itself iterates over the DT nodes,
searching for a node with the requested CPU ID. (Incidentally, this
makes riscv_fill_hwcap() now take quadratic time.)

riscv_fill_hwcap() passes a logical CPU ID to of_cpu_device_node_get(),
which uses the arch_match_cpu_phys_id() hook to translate the logical ID
to a physical ID as found in the DT.

arch_match_cpu_phys_id() has a generic weak definition, and RISC-V
provides a strong definition using cpuid_to_hartid_map(). However, the
RISC-V specific implementation is located in arch/riscv/kernel/smp.c,
and that file is only compiled when SMP is enabled.

As a result, when SMP is disabled, the generic definition is used, and
riscv_isa gets initialized based on the ISA string of hart 0, not the
boot hart. On FU740, this means has_fpu() returns false, and userspace
crashes when trying to use floating-point instructions.

Fix this by moving arch_match_cpu_phys_id() to a file which is always
compiled.

Fixes: 70114560b285 ("RISC-V: Add RISC-V specific arch_match_cpu_phys_id")
Fixes: 914d6f44fc50 ("RISC-V: only iterate over possible CPUs in ISA string parser")
Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/cpu.c | 5 +++++
 arch/riscv/kernel/smp.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index a2fc952318e9..35b854cf078e 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -17,6 +17,11 @@
 #include <asm/smp.h>
 #include <asm/pgtable.h>
 
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id == cpuid_to_hartid_map(cpu);
+}
+
 /*
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
  * isn't an enabled and valid RISC-V hart node.
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 85bbce0f758c..40420afbb1a0 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -61,11 +61,6 @@ int riscv_hartid_to_cpuid(unsigned long hartid)
 	return -ENOENT;
 }
 
-bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
-{
-	return phys_id == cpuid_to_hartid_map(cpu);
-}
-
 static void ipi_stop(void)
 {
 	set_cpu_online(smp_processor_id(), false);
-- 
2.41.0

