Return-Path: <linux-kernel+bounces-64905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C15A854480
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5171C22CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D31679DF;
	Wed, 14 Feb 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vu3CK0nb"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26179EE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901331; cv=none; b=e8o7MuXUFUbMOqiVHyeXg9Z3LFNh+yN1Z0dPOei1O1gdk9ZQzcjz9m0RvD5AtOg88AV1JYwV6RFiSjh2JC6h2DE6ziYF55lE7jFH1BqUtK9paI3dGfbXdq3jRWdE1Mv6sgB5Dgv1ujxjckF/9C9WjRtEmrYsbxL//o9wDQV2J7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901331; c=relaxed/simple;
	bh=whB7Ohz/aZw41jDLmsNbB2EZqD6VWqw1GxgDMy7wNzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klbNGZGoXD5I9SU0W+IqsX3HF71SK2k9pAzRCSdyodO24gZw71NJ5cQLDFqws0SXF2r+7oaWn8oHwnIzNmYtu2BB8QnxSjE/n6dgpso3WVgsnmmpUSEhqE4t0hrU9W74o1ukqPiid+Jrdlp/9NKDKkDh6ii9oDCc8zQdUV9eJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Vu3CK0nb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e0a4823881so2226200b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707901329; x=1708506129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbCTJ5IGhkP1LmE7TbGdUdt79kYAcBAyFyeC8QWmnbA=;
        b=Vu3CK0nbeZvAPFO8TBI187ZZSnXKk7NZyQOjaKzW17lmGlge1A3wFJ+niufluvOIfo
         suRI5Bh4QxSL+yPaJ3PhNTH4xyB5ANsob4+9cXUFJGvhvYmsmz+KnR4l92mX8/seUfAn
         u8BbKc2d7FfTxNJrssFZA1OmXrA/T/Fhf+Fi8l93+YnyUMA06HQj502xrg978mj2Yrl8
         yhiS7riKONRBPnZjnlZ4Yna6fz/rM3IrngSUtM1vNkq1plu/57/9dH3XbL3PLZOT/PCV
         jB0AQ2YWUg8KDPDKmetsLNCBNyqnX59dCWTpm7OsumSqifx64E8t7Gj2W4Hf24yOrD8K
         fFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707901329; x=1708506129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbCTJ5IGhkP1LmE7TbGdUdt79kYAcBAyFyeC8QWmnbA=;
        b=AujqGBoReCz/6XN7VU/+eAkVMLcy2s9ACohYweAg71+l01ttpzCgMYAbxGdhclKZYV
         5adi9AhaATa8mL0VEoZP5vRXU/A2zt+OLcALQl5sd7LIEZvDfVIHGldWpZiFudAF33Co
         /P56emu1ch15+25lsw9Qz0ytVM11fuP5SYfOE0FiaIPdOkb/Z0RUUMH8XDIaXIMWFZ2g
         hjd6TzrVW7Et4UD98JQV6d4BfI6GXGcEQRh9Jy3wr6b8QSv+Zlhn3wnhEe6ICbJpEg7f
         v1+tIyZqCZij6ypHsryske3ZaYrNOrx3z+qcab3brcAfFyRtGfreVuBxJiqujqa810+9
         q+sw==
X-Forwarded-Encrypted: i=1; AJvYcCXKignrZISDjlwQFjXjvf8uy5I6sDNblCL+niKq7oo1sZBbvwUYll97PMCEfVo2AMZG8Zbnudsscv+7/eIcT9K9bNf0Nsci+eJGBzZu
X-Gm-Message-State: AOJu0Yw3VEbz7pOd4Oy4c0bf2QhEM4dd6VmHPbOzPZNHRi0wtaemkimC
	PVfrM2eTgIegdI6CXHC+ltf0Ar8b2CBdyAMxxiCwG7wBwzh8R2JPe5Zx9YKQ0bc=
X-Google-Smtp-Source: AGHT+IFsjTuVAsJab6ip88ByI9QyNPkKm0np9TXh01qjGS2E4T32B1s1GFubfCKk7kV11vqAbji1+g==
X-Received: by 2002:a05:6a21:3a44:b0:19e:4f38:d8b8 with SMTP id zu4-20020a056a213a4400b0019e4f38d8b8mr2502137pzb.49.1707901329240;
        Wed, 14 Feb 2024 01:02:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7j4Fc4POZ09+xXH83jfYc+PuXbyH/VpOIAqmnBvkJ7GqY+HqUjeaxss0dPHCrRc2j31VDWX26D00yKHkfrVrh/CtH4mEa+eXidreRJPQVQm1CHNxDFHSujA1O2DtcTmfQJnAyb7E4fgp4iJkddZeH14jt0tzjkqeMTpNzqbiEa+Ttjq1fIS3GLjWb/svp7lzGE6D9Zk/QFtwED28vrb5ty1QHbbn+rGhZxsay3cXFF5d9pj9rukcYm/6vj7pH010lIbqQV9ff
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id m25-20020a638c19000000b005d7994a08dcsm2476681pgd.36.2024.02.14.01.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:02:08 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes v3 1/2] riscv: Fix enabling cbo.zero when running in M-mode
Date: Wed, 14 Feb 2024 01:01:56 -0800
Message-ID: <20240214090206.195754-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214090206.195754-1-samuel.holland@sifive.com>
References: <20240214090206.195754-1-samuel.holland@sifive.com>
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
2.43.0


