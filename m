Return-Path: <linux-kernel+bounces-61068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B5D850CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1C41C238EC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17FB46A5;
	Mon, 12 Feb 2024 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AgLGh7Xp"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540901841
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707704807; cv=none; b=EeK11xUsKbKX6z+ckUb7RUtzrqj4YBCOZPkPUoV1xUxxspTLkbGbvDCNTCg7VPHKYjRxbHTdV3GtoMNF5ogULC0nMinyamP2zIUnpTzhQ7BmB6AS7IPx6Q4IZM843NeCrkpaT5TLu29dt8zlZqKYwtr+6aECyZHe2kTSWl513Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707704807; c=relaxed/simple;
	bh=eLVssV5TvJUMBxnLDaEn4qjDgsNgLxpew7tHdFwrk2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OH7TB9vLOH7UuZjPcGMDKlI9ECJ4CNf0LT1gmFNBagQcS45tH00+RpJ1SFBbiRd/6XIY+Ngg+qTZb7xyc93pXqxQ5v9B1XqRKqQjY2vy4Xs42i7fvwsfhkZ3zmTKg4DRBLXSUwvzyDOTy1AaB2tVuNRpA5G/DzKum3wqbM+IN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AgLGh7Xp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d91397bd22so20380855ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707704806; x=1708309606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wExfnkW+ofqoMhPp98EXVpYHYdKKuq8sVv8wNwYyPSY=;
        b=AgLGh7XpN/+6VRv7sXe/yl4hTA/b29e3vwE0agddVBfCyWsZrq9sfF0yx82y/zXiBO
         qOYjGuux+46MwRrPhyleibNwQhF4/cyH+2UtEuV6prKrsIGNSEySDaW7iNUq3Y48+EFC
         HmHITBUGLwzsvkTx1IimfpVYLyx3+TuLr1HGzhtRS4ErkdJ7l/grIF0rnw99FIAPtjs1
         Qkzo6z/I2NTNlkO959V/8RsP+vehzNhSUeDsR5Va6IPxLW9Um2u7V0ngaR4caZNUKl6W
         /lGjqnTq6J7TiMVFd5HO4cZQFC9+JwZLBtC/Pw2byq6TOkWCsyhsA/uf7JgImbjkXxbW
         13PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707704806; x=1708309606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wExfnkW+ofqoMhPp98EXVpYHYdKKuq8sVv8wNwYyPSY=;
        b=GVRXTpwfxM6eRNYrERjpFiuSqPVQOntiT+MsJfsByWCriWg1dhTTkxs8dZOXky3qCw
         fKefsG/ly/xTUACkKRa+MtUgO6kJY8DJuHNwVyQHEY3utX2VyAaNa4qOkJD0rRvXJsFY
         T6R4c3Q/aqg4bnnNHj+lbhuUid9zithP82rXlBvG51iVi3oP/E6UppbHVpGW9GEdD8Sf
         fTXDokEht6MnAfxNh6QFRlm5wbHbZeOjMKWo77eUr5a7aWGnMw7nSIZbPbX6O1youKoU
         eCnBTQYk4Aqt5UrfjVDZ82tUZT+0++d7NfMutHsLZXUkqY5KA3s0Y+poQlUgoSG9WCNM
         gCdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTYaYirrTSiZFIcFFK4TAISVxKSGAaOPhvF16yfg4o4/suKygtk5RyJ2eaRroh2JSD5LTUlGem5QCvGWEprynOcBWtexuHDxLYE70s
X-Gm-Message-State: AOJu0YyaeQRUay98RVyVGcVtb+IReCAiERw6GKAFp3vdUk+Ot8fmUsME
	AI4uQvm2yILPrfMmxBErsITXXD/yREiPI0BvKKk/lrO46qIgXxtOaPXab3CIA/4=
X-Google-Smtp-Source: AGHT+IHsgEpxMWwncMmYnfnphnuqCxyUZrn2Q+KaKaF3ptByDMIbIw9fJf2oX3fuYh82MqOr5OfRDA==
X-Received: by 2002:a17:902:eccc:b0:1d8:e2af:f7a3 with SMTP id a12-20020a170902eccc00b001d8e2aff7a3mr4928995plh.60.1707704805691;
        Sun, 11 Feb 2024 18:26:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPOvgu3XozXDl5roe3CqjO7iyXASdEDHaHVU0+Ex493nHL6cFs8XhrJP3Nw6Jml5gLkIEGeMHeoGP+fR19E/IMBqsvBbVPKMFYcWiMVNcMGCFbDcaB4j71OWOlEiJZGk8nvSUzQNGobocCBcSIqBwO4/N7dqTUK21uJVKTzKcqsUMsVj0F76zf4Z3xuUTR
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id mg8-20020a170903348800b001da27cbcf5dsm1719624plb.228.2024.02.11.18.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:26:45 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Jones <ajones@ventanamicro.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@kernel.org
Subject: [PATCH -fixes 2/2] riscv: Save/restore envcfg CSR during CPU suspend
Date: Sun, 11 Feb 2024 18:26:15 -0800
Message-ID: <20240212022642.1968739-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212022642.1968739-1-samuel.holland@sifive.com>
References: <20240212022642.1968739-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of the [ms]envcfg CSR is lost when entering a nonretentive
idle state, so the CSR must be rewritten when resuming the CPU.

Because the [ms]envcfg CSR is part of the base RISC-V privileged ISA
specification, it cannot be detected from the ISA string. However, most
existing hardware is too old to implement this CSR. As a result, it must
be probed at runtime.

Extend the logic for the Zicsr ISA extension to probe for the presence
of specific CSRs. Since the CSR number is encoded as an immediate value
within the csrr instruction, a switch case is necessary for any CSR that
must be probed this way. Use the exception table to handle the illegal
instruction exception raised when the CSR is not implemented.

Cc: stable@kernel.org
Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/csr.h     | 23 +++++++++++++++++++++++
 arch/riscv/include/asm/suspend.h |  1 +
 arch/riscv/kernel/cpufeature.c   | 23 +++++++++++++++++++++++
 arch/riscv/kernel/suspend.c      |  2 ++
 4 files changed, 49 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2468c55933cd..daff95feb817 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -542,6 +542,29 @@
 			      : "memory");			\
 })
 
+#define ALT_CSR_READ(csr)					\
+({								\
+	unsigned long __v;					\
+	__asm__ __volatile__ (					\
+		ALTERNATIVE("li %[v], 0", "csrr %[v], %[r]", 0,	\
+			    csr << 16 | RISCV_ISA_EXT_ZICSR, 1)	\
+		: [v] "=r" (__v)				\
+		: [r] "i" (csr)					\
+		: "memory");					\
+	__v;							\
+})
+
+#define ALT_CSR_WRITE(csr, val)					\
+({								\
+	unsigned long __v = (unsigned long)(val);		\
+	__asm__ __volatile__ (					\
+		ALTERNATIVE("nop", "csrw %[r], %[v]", 0,	\
+			    csr << 16 | RISCV_ISA_EXT_ZICSR, 1)	\
+		: : [r] "i" (csr), [v] "rK" (__v)		\
+		: "memory");					\
+	__v;							\
+})
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_CSR_H */
diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 02f87867389a..491296a335d0 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -14,6 +14,7 @@ struct suspend_context {
 	struct pt_regs regs;
 	/* Saved and restored by high-level functions */
 	unsigned long scratch;
+	unsigned long envcfg;
 	unsigned long tvec;
 	unsigned long ie;
 #ifdef CONFIG_MMU
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c5b13f7dd482..934090270ae5 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -954,6 +954,27 @@ void riscv_user_isa_enable(void)
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
+static bool riscv_cpufeature_probe_csr(u16 csr)
+{
+	bool ret = false;
+
+	switch (csr) {
+#define PROBE_CSR_CASE(_csr)			\
+	case _csr:				\
+		asm("1:	csrr zero, %[csr]\n"	\
+		    "	li %[r], 1\n"		\
+		    "2:\n"			\
+		    _ASM_EXTABLE(1b, 2b)	\
+			: [r] "+r" (ret)	\
+			: [csr] "i" (_csr));	\
+		break
+	PROBE_CSR_CASE(CSR_ENVCFG);
+#undef PROBE_CSR_CASE
+	}
+
+	return ret;
+}
+
 /*
  * Alternative patch sites consider 48 bits when determining when to patch
  * the old instruction sequence with the new. These bits are broken into a
@@ -974,6 +995,8 @@ static bool riscv_cpufeature_patch_check(u16 id, u16 value)
 		return true;
 
 	switch (id) {
+	case RISCV_ISA_EXT_ZICSR:
+		return riscv_cpufeature_probe_csr(value);
 	case RISCV_ISA_EXT_ZICBOZ:
 		/*
 		 * Zicboz alternative applications provide the maximum
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 239509367e42..fe544f12a5c5 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -15,6 +15,7 @@
 void suspend_save_csrs(struct suspend_context *context)
 {
 	context->scratch = csr_read(CSR_SCRATCH);
+	context->envcfg = ALT_CSR_READ(CSR_ENVCFG);
 	context->tvec = csr_read(CSR_TVEC);
 	context->ie = csr_read(CSR_IE);
 
@@ -36,6 +37,7 @@ void suspend_save_csrs(struct suspend_context *context)
 void suspend_restore_csrs(struct suspend_context *context)
 {
 	csr_write(CSR_SCRATCH, context->scratch);
+	ALT_CSR_WRITE(CSR_ENVCFG, context->envcfg);
 	csr_write(CSR_TVEC, context->tvec);
 	csr_write(CSR_IE, context->ie);
 
-- 
2.43.0


