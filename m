Return-Path: <linux-kernel+bounces-108172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E973A880712
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E632285977
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E11604BC;
	Tue, 19 Mar 2024 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kiYoQx0n"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9386026C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885569; cv=none; b=Cqxg6PNCznVbCDObnM45GpWAHQpoL8g75COv5T+b/E9t2b62x3II6msyszLN3S+kHE0kHkXgusrw+kBYoWoseGML328oA5O6TMXR6UMR5E6GI9TxxkJe3PFgQV63F0zKUF4kp5S+SL+c5VPbdZf8FmuA+dt3SP+udXPifIGXXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885569; c=relaxed/simple;
	bh=xyp68/gmEX4m4uxB1XFqC3g2BTPwBItSqCxg8DcU1qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwektvc6RTlLtinNXX6d/q7DkTtDsN3NZJhl/9wdRyVSmTZNIJwdMDAG1MhyPFyF0aBlP6L0M1Uk8NNJTplPB0mU70C5w0oq+qpCAfkWC2s7bTMNlEt1lyAJjxb42Os2CUGif41gAg/ZBPtNB2iwkq80bHXg5yjcCk6Ke2L3Yb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kiYoQx0n; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6f6d782e4so4001061b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710885567; x=1711490367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5y8ITBc9KMnXCgtx77FHcE1LkP6cPCkee9IZD/0lAIU=;
        b=kiYoQx0njORwdGgRz/u5MAkzUItvp56MU6BNdJke2zQp6ZFBsj0aTZ3omAUYJzCdY4
         WtD9/jz2JnyQbf8coyQWEZxvO6KPQswm+LmCxsjF6RAEOXYwLfK+GvCFC+Q7TzFMax1A
         CKehf3sKxzkal+a9vlN/YgQqGWL+kGfgDJT6ccxJPu5Fq4r578u6asJOPPFau8ajmsZj
         vZOIaV1KCVFEpRRlBjHCjyZoE1xgb6fUzV5BRzITjhYtsLDq8qqVNgxgP8PoXhlhoriY
         7/3HAt6b5Bsozyei2DT3J/DxCNzQfe0vdGBthpsQILCpAzSId0MTWQC9NkbC8Ri8wZtn
         e23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710885567; x=1711490367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5y8ITBc9KMnXCgtx77FHcE1LkP6cPCkee9IZD/0lAIU=;
        b=hbJtZ6ZizQL4Fe6FsdoSTttNfhMnpw2ZdM7wPug7alHTgK6/VM9LQpOvZwmr+4uULS
         h+KCQOsRpUmMWjQfPqj3+h0R7yQo6axu3sW8w9jLWMRq67UWkzBYglU2/zJs5+G02j/v
         XIZATSNKl5OzAlNAf4XPJGMl2unXI88wCZI+S+HSCKYQu/DZd/PKqkqAHyyNwlie304l
         H0iTkqpS8EFi1A3fZMcDqFbB2Q4ocOt/IcFofupM5ZIqUV0j7+q2Qfv4JH7mGDpBFhHY
         E+AxfOyf2l7YQmt0SDt3o/OrHHWcjitQXLYKr0BaksqimD7VFkzSa9NYSxqa2uxKO/Ij
         O3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXavp4ttRQ+PflRX721E7Te7LndGCYUrymwQpRIsPUM82vGiwxaYviPy7MiS1UQYvDVx4U2pIfVM9br/JyL3DX3NtjNC539OSAjspvu
X-Gm-Message-State: AOJu0YyTBhNy1DiWh7kVZoxyy21ZbGv7G++mixjpWiDI4GGVbeY9qlfB
	wbC8se4+rgBY0pW8LLTjLJi13CReREpju1BXyTsOFY57bzt4vfpq5/qAPLrSgPM=
X-Google-Smtp-Source: AGHT+IHUdXawCkbimlLWn+n2NYwUpCHwdCxYmf1G6S225P30rVgH1guDbncjMramMLIp2vM31iLyBg==
X-Received: by 2002:a05:6a20:3942:b0:1a3:2f9e:b0da with SMTP id r2-20020a056a20394200b001a32f9eb0damr14091704pzg.23.1710885567124;
        Tue, 19 Mar 2024 14:59:27 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e6c61b264bsm10273892pfn.32.2024.03.19.14.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:59:26 -0700 (PDT)
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
	Alejandro Colomar <alx@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: [RFC PATCH 8/9] riscv: Allow ptrace control of the tagged address ABI
Date: Tue, 19 Mar 2024 14:58:34 -0700
Message-ID: <20240319215915.832127-9-samuel.holland@sifive.com>
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

This allows a tracer to control the ABI of the tracee, as on arm64.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/ptrace.c | 42 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index e8515aa9d80b..3d414db2118b 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -28,6 +28,9 @@ enum riscv_regset {
 #ifdef CONFIG_RISCV_ISA_V
 	REGSET_V,
 #endif
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+	REGSET_TAGGED_ADDR_CTRL,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -152,6 +155,35 @@ static int riscv_vr_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+static int tagged_addr_ctrl_get(struct task_struct *target,
+				const struct user_regset *regset,
+				struct membuf to)
+{
+	long ctrl = get_tagged_addr_ctrl(target);
+
+	if (IS_ERR_VALUE(ctrl))
+		return ctrl;
+
+	return membuf_write(&to, &ctrl, sizeof(ctrl));
+}
+
+static int tagged_addr_ctrl_set(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	long ctrl;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ctrl, 0, -1);
+	if (ret)
+		return ret;
+
+	return set_tagged_addr_ctrl(target, ctrl);
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -182,6 +214,16 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = riscv_vr_set,
 	},
 #endif
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+	[REGSET_TAGGED_ADDR_CTRL] = {
+		.core_note_type = NT_RISCV_TAGGED_ADDR_CTRL,
+		.n = 1,
+		.size = sizeof(long),
+		.align = sizeof(long),
+		.regset_get = tagged_addr_ctrl_get,
+		.set = tagged_addr_ctrl_set,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 9417309b7230..90806024fed6 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -447,6 +447,7 @@ typedef struct elf64_shdr {
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
+#define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
-- 
2.43.1


