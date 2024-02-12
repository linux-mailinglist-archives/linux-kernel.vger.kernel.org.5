Return-Path: <linux-kernel+bounces-61067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A15850CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAB41C239E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840871FB9;
	Mon, 12 Feb 2024 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LzQPPsyl"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9CF1877
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707704806; cv=none; b=Y2/Z51OfTw3qBdDEMMzrdLgg31JAuChCx12Uej2kZGBjdBmrbte6xH9snkmNj+0Hh1DAf7eczEaNWnFoNhWQHthffP7Sh2ykykPV4J7YWQAgPOdqnl+6YiW7q/8GswsY7g4hUGM40UmplFyF1lCXqPkM6sRT3q4G0blNWKxAoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707704806; c=relaxed/simple;
	bh=I8xais3M6KWt4jD9YpX9Bk9467Z0fCdsov2sXouaIUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCLDrflNNUs5VMNTeb9Gqm/mNg1TdJmxKqO/cUM27RfSRKYv6npJeeerw5lxk0WycEqV6HNwZINPCCG9ASoshaacxghlE3S+DI+2nWRQFD4+tBeQ0BO8JMLqiVE83Jl9+RkzgQfun9++249t52sz3p0Cvm1dPzkid5lpPrmDi2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LzQPPsyl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d8ef977f1eso19484685ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707704804; x=1708309604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+kIZpNvKn1kQfhO8EuiKdYkkbsLjW1fhO0uLZ9v9zVM=;
        b=LzQPPsylzO73aUClijYzrRs/vv2dIntGKpKNXabFKGHM1f9nkWp1kGdfLQ8LxmPEnd
         XZTHuZJKLRsRCm5hnDiHeDRmljTL5HzygMExSdukf8cc/K2xW4/xIvuWAutMda+cHcf6
         1/JYQ25Cissojr2u8EzJLVFeS5RIusEPn5NK+4S1EwiqkBqnYAiNqpi22h5Pc4G0z6Qr
         xqp80+/vZ8nls/JpuSyjEr1eq8mzp/YBbtK5pLxBikyJYrJcwjC5GnRAXD5SJZo6tVDD
         6vc44LyysN0a5NaHxQFDnMnap8c9W6YRzaWe1dApHO94IjpVGXhdINonGzyG0vZrd4Fk
         /3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707704804; x=1708309604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kIZpNvKn1kQfhO8EuiKdYkkbsLjW1fhO0uLZ9v9zVM=;
        b=E43dAWEW0YecXH2LbO9MLTnZpKPy68bc8mR8Pyy2w6pmz5jFQS8nMdOzCzcqSHnRKp
         ElLyMFPQCetUc8+8Cs1l1hz1LrqxXiSFUiqBpOrm/ErVXePMklvFcm+Xfag/5zswtdX3
         MX5+z8eYGWHSPdHWGVhVNy0ItuqM1khwnc4gVBB4C0CL8HL5RvJXGrhlVnQEkjP8p8ty
         L5vmkP4KBmGwsS9yk82ixawcNucsKvWDkUInbfI1jP55Fon33ik0MpxKk/ottpD6+gnW
         i4kdzyhuwzBxnGqP2yZckwOWICvld0JkG1RYxmUXlGJHtHBvpZ2vhDfa2WOdkrfaQrLX
         t1aA==
X-Gm-Message-State: AOJu0YxA9NK2A+Fu7AlqzBFlizw9MR1vT6I3Q1ZJnIYbecDBnqw+kzG0
	3IpZSgB6G3Im25KZGQsSzP/quHMlouaOTiQz7DaNKHUYKpklrRPozTGsHhzRm2HvjAo6rlqX4Ue
	i
X-Google-Smtp-Source: AGHT+IGPtKmdFrCoAXwq0IynPe2vhdhsmEWzTlOxO+M0NscVcWz7/5WgR2aYGbS2vfq/fGcYE/Bqvw==
X-Received: by 2002:a17:902:ce8a:b0:1d9:5f11:d018 with SMTP id f10-20020a170902ce8a00b001d95f11d018mr6165050plg.1.1707704804598;
        Sun, 11 Feb 2024 18:26:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfdeKz8qQ1Wm/LNrWafjLgkv2+Xkl8QrY/iZkgowaE8IySyAhm6B7a9c9c/cifytyBUKmSpQly+vFAnwjO1HIVW1XVe+DkIvqGaDhJ43ypOJnuMyTSRDRJMdhMKGU+Az55/4QPqYlZXa82EICvNRAepdBnJg4jItKVtMxdi7IV5ihxUtDCkD/VY9r2gLvJ
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id mg8-20020a170903348800b001da27cbcf5dsm1719624plb.228.2024.02.11.18.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:26:44 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Jones <ajones@ventanamicro.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@kernel.org
Subject: [PATCH -fixes 1/2] riscv: Fix enabling cbo.zero when running in M-mode
Date: Sun, 11 Feb 2024 18:26:14 -0800
Message-ID: <20240212022642.1968739-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel is running in M-mode, the CBZE bit must be set in the
menvcfg CSR, not in senvcfg.

Cc: stable@kernel.org
Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/csr.h   | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 510014051f5d..2468c55933cd 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -424,6 +424,7 @@
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
 # define CSR_TVEC	CSR_MTVEC
+# define CSR_ENVCFG	CSR_MENVCFG
 # define CSR_SCRATCH	CSR_MSCRATCH
 # define CSR_EPC	CSR_MEPC
 # define CSR_CAUSE	CSR_MCAUSE
@@ -448,6 +449,7 @@
 # define CSR_STATUS	CSR_SSTATUS
 # define CSR_IE		CSR_SIE
 # define CSR_TVEC	CSR_STVEC
+# define CSR_ENVCFG	CSR_SENVCFG
 # define CSR_SCRATCH	CSR_SSCRATCH
 # define CSR_EPC	CSR_SEPC
 # define CSR_CAUSE	CSR_SCAUSE
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 89920f84d0a3..c5b13f7dd482 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -950,7 +950,7 @@ arch_initcall(check_unaligned_access_all_cpus);
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
-		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
+		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.43.0


