Return-Path: <linux-kernel+bounces-100731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1992D879C73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE631F221FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7782A142657;
	Tue, 12 Mar 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QZI1LJ2R"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81C1E53F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273406; cv=none; b=jL30MJ4/LNdgeHsf8uXZ3vpzrwDAwVW5xaIX2W8Ljr1c3KSc+MX2NJ/7AsTFlHyEDvll7gXAOMLnFSxlDuI+rqHqLjhuya7kxb1ok6xPNO1Jgj+S8s/l2UvZTNdHH6eUU+hYwuMwpR+DZRUgLWu6xScMmXcDSYWi/orz1nblc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273406; c=relaxed/simple;
	bh=NfuMaH7Y/8CSMgzfmLwCZoP8iZSzw8HM7XZf9JY3qEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/yV06rUzZBrvDOI3wHb0QsEivxdfPF0q7OXd529p8Ipwk82+4yX39e55hP4DNnAgEd6Gv9GS22wokrsbzNSfLtAu61C/Q7mDoaO3DPn63oFNXZ+NlCXoFpNhfTBkgSRUXAZpeN3XklrBrQRu2n5H78ksk5jU1cDRh5jigY+tPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QZI1LJ2R; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dd8f7d50c6so1674475ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710273403; x=1710878203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxEx3iDsM3WrZG2Ndd+J9E+wXDu/hB2Os8/24Q1t3OY=;
        b=QZI1LJ2REYGo1Bsc+3/Zqq2HkKct0LVwKXwjvtRUVdoTYpnvFrLuLNk5jJaNBmF8hP
         KgG7HxYJuYs1yT5N46OP5XurGkntOyZ+8UVrpWeNxRGEbFpLnV95CD91uYzN3tNv2xX2
         +E50mP7/BOglB3SmJVyEH/o7VpJ1OXjbGXeXM2oa6f04MrW69uFJWgL0H6enqnkCSVj/
         ApcqOgCuz+BFQQTLt6oRG/ryyK6ZygjUHNVZ1keJVcmndWfHEZ09gggSeZgokmXR8vi9
         Rxkapb02l9ucsKxnRass5RMvSHXbto/4tsRUyyluvKsNX1xCrgnB5G0Gcq94FOIrQRc0
         CICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710273403; x=1710878203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxEx3iDsM3WrZG2Ndd+J9E+wXDu/hB2Os8/24Q1t3OY=;
        b=ZocujWaapQCG6b8kpdHTOkjx7jtS8nOaXTwHZvcQgVqqIY2PNhEK2GA1nXGCi9YV1E
         axkrwvvboCwW2ZI4MbPOifYyrZt62dT05fS3jserVEqTnzTKVmR8YIvMHNq7dMGU9fNX
         Njtj+9eh0Tc8ojzOj02l2KYYmN4DoXXTsCfgLQmp4HnqaAfxdqBgW/v846gbznaNStcH
         4Hsx7hHj4uhbA6/qI5uz0PLz/kgbkt3MaHj5pOiKPre5lFuBPwdKeXzmFscjtkzSMMSZ
         GKl47tt9MFX0QetdWrgR6CK4NpwIqi2K++0G5GziBim9/REcYLCITUiVUSpBI7Lx1YA+
         eseg==
X-Forwarded-Encrypted: i=1; AJvYcCXzNEy5ep3iyLnlx9OC0DXJX6y8tPRsm7dmCeqNSZt//Y7MSR6K80RCr2RSf7netKhhzVtj1AZY/9YfFnfT2WdlxNqnTzaHFJsJL++L
X-Gm-Message-State: AOJu0YyMy1s02HJ+rztIUoRIW8NniGltX4sy4iby8HUYyJxen4ugASRb
	53kbda5NUOS9jvLlWFGQVAVT5iWspWYdTfeTKZlToCIsk8VUDUC/ziRaRB3WjR4=
X-Google-Smtp-Source: AGHT+IFpt7ff6HNFHc9Yq78Z63OwKzFZJ801dFotJRAscTaClrr1h/Au36ogZQmQ69SY/YT0n6oNpQ==
X-Received: by 2002:a17:90a:e54f:b0:29b:c49b:eb13 with SMTP id ei15-20020a17090ae54f00b0029bc49beb13mr628731pjb.24.1710273403142;
        Tue, 12 Mar 2024 12:56:43 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id hi23-20020a17090b30d700b0029bed0e75dbsm4708774pjb.17.2024.03.12.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 12:56:42 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Pavel Machek <pavel@ucw.cz>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] riscv: Do not save the scratch CSR during suspend
Date: Tue, 12 Mar 2024 12:56:38 -0700
Message-ID: <20240312195641.1830521-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the processor is executing kernel code, the value of the scratch
CSR is always zero, so there is no need to save the value. Continue to
write the CSR during the resume flow, so we do not rely on firmware to
initialize it.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/suspend.h | 1 -
 arch/riscv/kernel/suspend.c      | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 491296a335d0..6569eefacf38 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -13,7 +13,6 @@ struct suspend_context {
 	/* Saved and restored by low-level functions */
 	struct pt_regs regs;
 	/* Saved and restored by high-level functions */
-	unsigned long scratch;
 	unsigned long envcfg;
 	unsigned long tvec;
 	unsigned long ie;
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 299795341e8a..3d306d8a253d 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -14,7 +14,6 @@
 
 void suspend_save_csrs(struct suspend_context *context)
 {
-	context->scratch = csr_read(CSR_SCRATCH);
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
 		context->envcfg = csr_read(CSR_ENVCFG);
 	context->tvec = csr_read(CSR_TVEC);
@@ -37,7 +36,7 @@ void suspend_save_csrs(struct suspend_context *context)
 
 void suspend_restore_csrs(struct suspend_context *context)
 {
-	csr_write(CSR_SCRATCH, context->scratch);
+	csr_write(CSR_SCRATCH, 0);
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
 		csr_write(CSR_ENVCFG, context->envcfg);
 	csr_write(CSR_TVEC, context->tvec);
-- 
2.43.1


