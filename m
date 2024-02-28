Return-Path: <linux-kernel+bounces-84579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207F886A895
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EBC1F2733F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28F223759;
	Wed, 28 Feb 2024 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dxpPXuGc"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F921362
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709103365; cv=none; b=pxlVWmtRhEhBoi9LKYxaxvQxP4Edqf5hwGt8lFDdWkSK/tEPLHAsrH7+whyFZ8Bi9T/gXriGpygx1Jax0rwDjZjizSRx6MJDuGoF/M+O6yM8jzgG7QMUwHda/O3WEG3y9LzLlboHcKLhUzrkOyxPZWrokn9Q03sQD0kAzF/Tc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709103365; c=relaxed/simple;
	bh=DS0otXxBIAg/AMim69yUhYg9b3z+zSXh8HjudQ+pVJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/t/l7xjOk9PnthL4dOX/CrXFSFWov75dLrJoSjnBXxu8R0pGvSwwRpg51OM5SDv0oS7Ec2bRVlJPYRUs6Yik6n0F1XaxpGEvdu+RFDrdsiDseYf4lnUat+Co/uejjO4Ivgd2NVcB+ZfjsYgUOKKJaAukNBTpkPBggJDxi5W/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dxpPXuGc; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c17ac08a38so2326987b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709103363; x=1709708163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1cp6XMBopp3tzzHV/G51+rKShiExWAPZnHAB8vVY2k=;
        b=dxpPXuGcq3+WrgWE8Yq5E9zD7FeffDa0Xic+iFOo6HYQ5vZ711HhbF+2HRSEgAMvo/
         eodWK3e9GwQiJx/eucWVD8yInRFgqQpQlYaYnPPU4/qJ8Sqeuad5tI68egIPGze1p9ar
         T7JU9DKUu98mtel+SNhpvVQ10vMLxR0ad4lSxsxr6jzs0nf42gB4TGLH4UQMYCdEn1fo
         lnyBHoQzLh83FonyN6eQ2d5LqoM0xD/H7hR2LI5SYOhbA+kDZXNzAtCy/vncdtE8q7CU
         yo5jd3KYHbBBm04HzKpI0HMk6Mr9HOt/r9Sak/Emfim4n+u3PUSkscalIPe9dAeiJX9V
         bMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709103363; x=1709708163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1cp6XMBopp3tzzHV/G51+rKShiExWAPZnHAB8vVY2k=;
        b=J4W6XfFKoWMC+UVZyWB5uOMkXx7n37mqhUqmnth0sSs+87dynFaQzMNJlzCc7Zg1wy
         VtdHc2pPsjvjgHR9/LaO0fc3qtDUFvjtd49MW9QNfL51m6Iac/F6TGA4rPxq43EkHTGA
         YfUomoMsJgvkwHULQ415Lx9RIuPTjxm/3+qnicMqkPB8Icz22IprRFCRlDV5dOKkK9A5
         BQK8Yb8LWeus1n78ydqXtSEh4HjGzbDCj/e8G2pgSaTvN9YQiYpxPzfKjt0itU6TFtt1
         eUrKxu6rXbvXppiOBLMeO/1DysnnmMISUeAoicXIotv3zH5wE9ode8o8UYhB8ohhf7fT
         mbZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8PPFyaESyAxZEIdj2L45kH+ZNhYnOCkbP1bZx+iOfk0aicRHb1tio6o45TZ/+Lir8wJsdBxmGxkea2cS/ed9T8bEggWDBgmrTAu4
X-Gm-Message-State: AOJu0YwaEgOa3ZJvvIadmqN42mX7jXyqKI6ME91zmydWwKhjdYLWGIH5
	sjfWVohHTsb4KO25ZDpDr8QKv7Zcwo4BN27566P1TLvxmXrz9HFdC1aEUEe15XY=
X-Google-Smtp-Source: AGHT+IFXIsSjDWuHRYBUZ4nH4ci0C53IjlWATHbpl7/aaCUY4gxiRH0rXlKJl12edB4xIX1p9ussRA==
X-Received: by 2002:a05:6808:8b:b0:3c1:5b63:579b with SMTP id s11-20020a056808008b00b003c15b63579bmr3629169oic.49.1709103362812;
        Tue, 27 Feb 2024 22:56:02 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b006e5590729aasm1010112pff.89.2024.02.27.22.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:56:02 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes v4 1/3] riscv: Fix enabling cbo.zero when running in M-mode
Date: Tue, 27 Feb 2024 22:55:33 -0800
Message-ID: <20240228065559.3434837-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240228065559.3434837-1-samuel.holland@sifive.com>
References: <20240228065559.3434837-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel is running in M-mode, the CBZE bit must be set in the
menvcfg CSR, not in senvcfg.

Cc: <stable@vger.kernel.org>
Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

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
2.43.1


