Return-Path: <linux-kernel+bounces-121606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D788EAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DD21F31CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F634145B08;
	Wed, 27 Mar 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Gi+ErREN"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046431350C6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555531; cv=none; b=QcgXalp8YkyooE8v+PFK6XIqpDAlWSqBPYeKb7vCAN2kHAc4B/kU2HF0yKEmJNXwPUbNUamWjZFMZZSjUiyg3b6+O94Plh1SvTo0zd4ftEAji4nbiQhlh4EHO3o35uOfIGvv3X7bS5bVE3TbtSpjUoM7HayQslbVs7uXhf0Ti8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555531; c=relaxed/simple;
	bh=ol909hSea5gZlRMw9dyO0W3BdlyVbedYBdR8GBFMpq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTK51cDOY7guTaRNy8xNSZARPXG3qI0n89Yq+SSMjyg2s2lI+x6XU0JfS2E/WXzBbCdVvSmFjyjl2Bw9OzaMvRSpgmnRW68GTgLYorU5N4tndhz6S2nhmSW1QUW40cFAfsb3Sur/TQmEQpn8aR2hnIgm9YwVaokyIgxwgG5uf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Gi+ErREN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dffa5e3f2dso46214725ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711555529; x=1712160329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSdeTCpLrbMRKKMvHtorfIir+maEw9krU8ML3vSQsXQ=;
        b=Gi+ErREN0UCS19uzmg1o+E8din1IxVVtJf1VZhfYXZ1HsipdhcyUcWy9U50cC+E6ZV
         t5CCngRlactnq7YLMCx0JVHYtCsbyFMYK8kBECoqmRrLzl0UYrK/6ftFgIZneclQOTlo
         TB72IEQX4/a+jCg8nuK77YEcBfaMZUVVgvRL/8puG11n/2gpGZx1X5tb8KWbrZdpDzzT
         HWfk3LE6fbGB+ABRFHth+fJtkxkGE6Ki1sxzCMtUFrx/w2+yPiZCl63M7rrLkxH/Vy9G
         MRa7BpXJ1DRiDv4Vel2oiqLgXfUFh5sWeMF+5f1bsBg/5GVYkkNVqNeg3RCFvm2604QW
         XdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555529; x=1712160329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSdeTCpLrbMRKKMvHtorfIir+maEw9krU8ML3vSQsXQ=;
        b=GDOfeoGgJonZQpoXP3GoadK4fsDboUj6BuF8nia8cCJYFBQSfIgqQ+wQZ+Kg/yNQAf
         nJQ006tyLU46gwHl0sl1+s6IKCR9Ic43z+B6EXxID497jWE9gojVtEoPN0dmNjumqrYS
         n0tgOvSbUlyc+JztPyhsvndvtrYG5ahfIQiNJiDaSRaZ7UcZrEho+0JgnG/L1lFgofsj
         ozGEkDZJzHqYcow+a2O5ybC5QjxWp2LPV71/P5T6kWG5Bpe7/atFzPJESmDL9Rt3hTpK
         ZU25WRd1gD8ppcvSaN79adaFxeUkHREvFyY4TQ/X+b5Wt66eWwA5ph+sKTzu6tka1Hnp
         +45Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1q7RNN/FwT220/u4Haiuk4KMW/Qtooh4oLdK1FTP08cWh8KETTjuvae0GeriCAPyv5I8bB47jkqTOhBH3HRxg1TZsR2cmsVCocEua
X-Gm-Message-State: AOJu0YzruUyomKtdQPFheNvLJAyISijjC7axB9AZswKjWyKky6T7zHWR
	PwldfHvA0AxTT35GxTwEPi1RC4RF9cFObfL4DZPU3Ye3XjbDmRa6AGEkYveHRQA=
X-Google-Smtp-Source: AGHT+IEqRVMXpfbvhLVGnT+rNK/EL/AmWPjQNfVTk43pBb2QF8NUiJFixCdoiQv5OswSn3xtBhEfyw==
X-Received: by 2002:a17:903:8cd:b0:1df:fa1a:529f with SMTP id lk13-20020a17090308cd00b001dffa1a529fmr148822plb.24.1711555529446;
        Wed, 27 Mar 2024 09:05:29 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b001e14807f9cesm1718226plb.125.2024.03.27.09.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:05:28 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org
Subject: [PATCH v2 5/7] riscv: Pass patch_text() the length in bytes
Date: Wed, 27 Mar 2024 09:04:44 -0700
Message-ID: <20240327160520.791322-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327160520.791322-1-samuel.holland@sifive.com>
References: <20240327160520.791322-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

patch_text_nosync() already handles an arbitrary length of code, so this
removes a superfluous loop and reduces the number of icache flushes.

Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Remove unnecessary line wrapping

 arch/riscv/include/asm/patch.h     |  2 +-
 arch/riscv/kernel/patch.c          | 14 +++++---------
 arch/riscv/kernel/probes/kprobes.c | 18 ++++++++++--------
 arch/riscv/net/bpf_jit_comp64.c    |  7 ++++---
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index 9f5d6e14c405..7228e266b9a1 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -9,7 +9,7 @@
 int patch_insn_write(void *addr, const void *insn, size_t len);
 int patch_text_nosync(void *addr, const void *insns, size_t len);
 int patch_text_set_nosync(void *addr, u8 c, size_t len);
-int patch_text(void *addr, u32 *insns, int ninsns);
+int patch_text(void *addr, u32 *insns, size_t len);
 
 extern int riscv_patch_in_stop_machine;
 
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0d1700d1934c..243e1573410b 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -19,7 +19,7 @@
 struct patch_insn {
 	void *addr;
 	u32 *insns;
-	int ninsns;
+	size_t len;
 	atomic_t cpu_count;
 };
 
@@ -231,14 +231,10 @@ NOKPROBE_SYMBOL(patch_text_nosync);
 static int patch_text_cb(void *data)
 {
 	struct patch_insn *patch = data;
-	unsigned long len;
-	int i, ret = 0;
+	int ret = 0;
 
 	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
-		for (i = 0; ret == 0 && i < patch->ninsns; i++) {
-			len = GET_INSN_LENGTH(patch->insns[i]);
-			ret = patch_insn_write(patch->addr + i * len, &patch->insns[i], len);
-		}
+		ret = patch_insn_write(patch->addr, patch->insns, patch->len);
 		/*
 		 * Make sure the patching store is effective *before* we
 		 * increment the counter which releases all waiting CPUs
@@ -258,13 +254,13 @@ static int patch_text_cb(void *data)
 }
 NOKPROBE_SYMBOL(patch_text_cb);
 
-int patch_text(void *addr, u32 *insns, int ninsns)
+int patch_text(void *addr, u32 *insns, size_t len)
 {
 	int ret;
 	struct patch_insn patch = {
 		.addr = addr,
 		.insns = insns,
-		.ninsns = ninsns,
+		.len = len,
 		.cpu_count = ATOMIC_INIT(0),
 	};
 
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index fecbbcf40ac3..f3cbc3ec9e6a 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -23,13 +23,13 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
+	size_t len = GET_INSN_LENGTH(p->opcode);
 	u32 insn = __BUG_INSN_32;
-	unsigned long offset = GET_INSN_LENGTH(p->opcode);
 
-	p->ainsn.api.restore = (unsigned long)p->addr + offset;
+	p->ainsn.api.restore = (unsigned long)p->addr + len;
 
-	patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
-	patch_text_nosync(p->ainsn.api.insn + offset, &insn, 1);
+	patch_text_nosync(p->ainsn.api.insn, &p->opcode, len);
+	patch_text_nosync(p->ainsn.api.insn + len, &insn, GET_INSN_LENGTH(insn));
 }
 
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
@@ -116,16 +116,18 @@ void *alloc_insn_page(void)
 /* install breakpoint in text */
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
-	u32 insn = (p->opcode & __INSN_LENGTH_MASK) == __INSN_LENGTH_32 ?
-		   __BUG_INSN_32 : __BUG_INSN_16;
+	size_t len = GET_INSN_LENGTH(p->opcode);
+	u32 insn = len == 4 ? __BUG_INSN_32 : __BUG_INSN_16;
 
-	patch_text(p->addr, &insn, 1);
+	patch_text(p->addr, &insn, len);
 }
 
 /* remove breakpoint from text */
 void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
-	patch_text(p->addr, &p->opcode, 1);
+	size_t len = GET_INSN_LENGTH(p->opcode);
+
+	patch_text(p->addr, &p->opcode, len);
 }
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index aac190085472..6ed4035a8136 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -15,6 +15,7 @@
 #include "bpf_jit.h"
 
 #define RV_FENTRY_NINSNS 2
+#define RV_FENTRY_NBYTES (RV_FENTRY_NINSNS * 4)
 
 #define RV_REG_TCC RV_REG_A6
 #define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
@@ -663,7 +664,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	if (ret)
 		return ret;
 
-	if (memcmp(ip, old_insns, RV_FENTRY_NINSNS * 4))
+	if (memcmp(ip, old_insns, RV_FENTRY_NBYTES))
 		return -EFAULT;
 
 	ret = gen_jump_or_nops(new_addr, ip, new_insns, is_call);
@@ -672,8 +673,8 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
-	if (memcmp(ip, new_insns, RV_FENTRY_NINSNS * 4))
-		ret = patch_text(ip, new_insns, RV_FENTRY_NINSNS);
+	if (memcmp(ip, new_insns, RV_FENTRY_NBYTES))
+		ret = patch_text(ip, new_insns, RV_FENTRY_NBYTES);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 
-- 
2.43.1


