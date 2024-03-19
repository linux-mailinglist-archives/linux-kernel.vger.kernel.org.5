Return-Path: <linux-kernel+bounces-108170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B415488070D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E251F22D77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B6B5FEE5;
	Tue, 19 Mar 2024 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TKQkzW47"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39665FBA9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885565; cv=none; b=h+vLBPTPCKb4wu3iZJlaj2+91L2Xbz8Xdb8A0edf8Od27oKsX9mbTepP3xNlS2DeBodLNdq9QHckj2WTaAmZv5AP0CosJ22n8+2AFM7joB7iF+T+O6LwPd7eUlUOi5bJ69shZF+gKar6wATHlaYMsZ0jN5m9GlJjYwZbFh41gR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885565; c=relaxed/simple;
	bh=p8ZwaHGgzvhLBCO4DSAd729Yfm2+NvPHNFvbnQChbv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8GZFqlncjPxM0bI/uW1O4odOnRn21FssNWAj98lzvu64yU/I4fxBPeAHurnDclKBzkM06r9eQv5jEIvOn1eHHr/3aLZ1pBxew/KMD3OrPKgx1+fIR4CXzH/AYKWLUuFFvDt0SEm61bZg7QrH7P6ra9DmLOWeUX+RFurZsvPSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TKQkzW47; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e74aa08d15so725498b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710885563; x=1711490363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz0gWVnpXPU7ElrUaImwHtbiCroEAM5Xe/I2DTavV7g=;
        b=TKQkzW47GJQSS1O2YS4H90zXlR8WVNwfZBbajSA/7oW3BH576BE59nu8rbUk8xM6Hw
         OYOLXP93QE7e4do9d+tzoS4LPFeAUiVky3yv5QXyKY9gEGar1tx+wYGxDGDI45HHmPqw
         RapbM36gYwKQfjJ43DYlGiQVMKf/0mrTWk4TihRnp4A3N2OKD7tMtWUT9zR0LlhvldCA
         IH+fCvaGOVnkcagZthv6Gu4RqpwWWlxqABrYleUBaaL0AawrVGAwKELss1ZZ2k2p5KWc
         Ozv7GknNb+GhLefgAOn1JMjweQka4D8Cu2y34gWAVuwTwIpqdQbhkqDT1crBNUWFUkOe
         nelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710885563; x=1711490363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz0gWVnpXPU7ElrUaImwHtbiCroEAM5Xe/I2DTavV7g=;
        b=F7s0mVJvsZqURHEby4HyEJ+QOP7z+/S9h5dywhO5imDDLWgfNZlDZ/+VzE8vDu/5pU
         0vxkpxEXGGAW6aWp7CH/Ee5/f526IQqffs4wl6NIhliL5h27hQYJTI3E7VH3oXpuHne2
         T/uHNGvyflkLtm67d+bpoTC9PMtzW0IyZsFlOfJAYB3QVLXMJ4xkeJ1auSHsSDLPMldB
         ATwH70ERoR++DCZVBbj5ARMC71Fgn46+PQSUAPuQSr/Q+2qdrExDvQiNNoe72nU5kVYu
         1nfrxBF5FfgbNA7txwZaTbgTOzRcajRxCZuS0pO1REtEBtHGYUbQs3WZ1jRgMH3eFXMO
         K5qA==
X-Forwarded-Encrypted: i=1; AJvYcCUqn+2DZEplOOIu5xapkpdzGuS4WuHFCfLf+GyEQv8rrroekGdheFq3NXtZtaSVc8rqf2Bt2i1A8N3iGbbSNfPIzAmPqmHlDR4wpsb4
X-Gm-Message-State: AOJu0YxlsYh6E0Hao/jSRChhU/nMo1fTwNNNdMW1F7yfRNuNQIB/3Syq
	NX94XLrREuKKqMtwu02Qmtuo1i414QI/NwuSfutsPZaMFQuShxIMGdeTwd37F1I=
X-Google-Smtp-Source: AGHT+IEXM30Lrne9ss/C/7W/K1gxYQD71hKRIdntgbmHeEfv/1G3LVtA8crJjeRdhBQq5PV/uA1LDA==
X-Received: by 2002:a05:6a00:1482:b0:6e7:2379:dd18 with SMTP id v2-20020a056a00148200b006e72379dd18mr4524923pfu.0.1710885563216;
        Tue, 19 Mar 2024 14:59:23 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e6c61b264bsm10273892pfn.32.2024.03.19.14.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:59:22 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	tech-j-ext@lists.risc-v.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: [RFC PATCH 5/9] riscv: Split per-CPU and per-thread envcfg bits
Date: Tue, 19 Mar 2024 14:58:31 -0700
Message-ID: <20240319215915.832127-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240319215915.832127-1-samuel.holland@sifive.com>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some envcfg bits need to be controlled on a per-thread basis, such as
the pointer masking mode. However, the envcfg CSR value cannot simply be
stored in struct thread_struct, because some hardware may implement a
different subset of envcfg CSR bits is across CPUs. As a result, we need
to combine the per-CPU and per-thread bits whenever we switch threads.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/cpufeature.h |  2 ++
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/include/asm/switch_to.h  | 12 ++++++++++++
 arch/riscv/kernel/cpufeature.c      |  4 +++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 0bd11862b760..b1ad8d0b4599 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -33,6 +33,8 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
+DECLARE_PER_CPU(unsigned long, riscv_cpu_envcfg);
+
 void riscv_user_isa_enable(void);
 
 #ifdef CONFIG_RISCV_MISALIGNED
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index a8509cc31ab2..06b87402a4d8 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -118,6 +118,7 @@ struct thread_struct {
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
+	unsigned long envcfg;
 	u32 riscv_v_flags;
 	u32 vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 7efdb0584d47..256a354a5c4a 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -69,6 +69,17 @@ static __always_inline bool has_fpu(void) { return false; }
 #define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
+static inline void sync_envcfg(struct task_struct *task)
+{
+	csr_write(CSR_ENVCFG, this_cpu_read(riscv_cpu_envcfg) | task->thread.envcfg);
+}
+
+static inline void __switch_to_envcfg(struct task_struct *next)
+{
+	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
+		sync_envcfg(next);
+}
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -80,6 +91,7 @@ do {							\
 		__switch_to_fpu(__prev, __next);	\
 	if (has_vector())					\
 		__switch_to_vector(__prev, __next);	\
+	__switch_to_envcfg(__next);			\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d1846aab1f78..32aaaf41f8a8 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -44,6 +44,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
+DEFINE_PER_CPU(unsigned long, riscv_cpu_envcfg);
+
 /* Performance information */
 DEFINE_PER_CPU(long, misaligned_access_speed);
 
@@ -978,7 +980,7 @@ arch_initcall(check_unaligned_access_all_cpus);
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
-		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
+		this_cpu_or(riscv_cpu_envcfg, ENVCFG_CBZE);
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.43.1


