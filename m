Return-Path: <linux-kernel+bounces-152027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC978AB79E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B11CB21609
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3FF14291E;
	Fri, 19 Apr 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PyDjOqTV"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE99142659
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570474; cv=none; b=PEfDbQjP+wVKMr/LXXDohj6K+p+kMTWNyF0+WTRVNS7iq1LtwTWdvWaCXMir16vu0qeMOCQjC9NLK1FDBYlMrBpDge9jby3y0Lda++eoE3ff1i2EB9cPfTTqnQ7VduSks2NBDt4nxmZ6DnFettPvSWSA79wLend8rKAa/dzJFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570474; c=relaxed/simple;
	bh=J8TrFuN//G6PmUvmCaqpAzaTIpoKbVOHs/yKTawHfLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fywLCKfqV/aOcR9Po55KVoFlgVCmPYRUfmNZgBXyp99YGzDBOEyR4HEibafJyuhHf7jJIjrAcIGHrN3yzSeiT8FiwZNYNl5EFf9/7qB+FIjxhMpWrnP8cj3XN4DRDvRGRNSwMhabsQpCc/cE8tHAk+olqC5VyBMX0IAaN0vnCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PyDjOqTV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2c725e234so28947425ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570472; x=1714175272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITt+KwUVR5JlR3QMHjofp/8j27l4zwoSN907Yn7Ybbg=;
        b=PyDjOqTVhmhhgtfZsWc0jioetZfve3T8G6D4shs3Xr7XwwaCmoNCW6iEqo/eAiKTWw
         kaKofaCHYCVNcJhaf08cLUn25CN0DZ8EsxfIHNAy4I5YxGYxnHPpGTQ5jT66l3nXquMy
         JcTlgUJL3whjYef1jLsraCva+0FFBTpMNBEnrMActuSFpHfq0RWHxweijortWpGlzFfE
         GndvUXRZwvnNlUECWq/hlUg+CnSwePDvxlq5NJeA9YzIuy8UgyQJ7fHvVOh0rhA5AzCk
         tAYN3v/127oI8rEKHPBqiBO0JQf+CRrS3WXsIfAj+IQlZpIAMVKRUZfjggpnIlrEkoF7
         s6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570472; x=1714175272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITt+KwUVR5JlR3QMHjofp/8j27l4zwoSN907Yn7Ybbg=;
        b=eoPD80Qog2m2tXNacatcjxP06BWjQ2WGHOEBWG3gwEC0XW0frKF1i2YQFLEcpRTDIa
         NAneZbITpoyvPIB0lWYpUEs8+FHfaGrmHUe45DRURd5xK4nXi6Vc0dLzEMm4/8dHBkiS
         F9TtRO7m2nj+CJvmsfjmnZZZdCQbYbAeRTVDgKznqJS5//EOVWAk4lGL/48O/rrUKshb
         DDFBWZR+/Mx/dPgzrRGNdEYPkztvABYe0U9HWTwpcqVtMh9krEPTTo65sKjp8jrUA/5l
         3sKkAzM22tjnwc0kRDzc7+DANgCWxU14WHTXAHLgvsdIb30EugGRgllJWMagUxsCWwNB
         WPiw==
X-Gm-Message-State: AOJu0Yw4LkZCZiY1sqOxFNmIMRpxB8oIvGjsQqgpwA6Sx/w6gTGr74jK
	W4+2z54poNTS70lX0O+4rTIsMdEbvrrwl4ecvsYfdl4B0o3gEJDV+IgNG/dJPDyeiAMWyepaAx6
	2
X-Google-Smtp-Source: AGHT+IH5QGSC9XYAm6rDKcSeLNzkHXWCmDzCWOnGmFWs22ruWfJPyGgW69pbeeyR0NhMBzdKPRq55w==
X-Received: by 2002:a17:902:e741:b0:1e5:5c69:fcda with SMTP id p1-20020a170902e74100b001e55c69fcdamr10097280plf.26.1713570471976;
        Fri, 19 Apr 2024 16:47:51 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:51 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	samuel.holland@sifive.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v8 04/24] drivers/perf: riscv: Use BIT macro for shifting operations
Date: Sat, 20 Apr 2024 08:17:20 -0700
Message-Id: <20240420151741.962500-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is a good practice to use BIT() instead of (1 << x).
Replace the current usages with BIT().

Take this opportunity to replace few (1UL << x) with BIT() as well
for consistency.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 20 ++++++++++----------
 drivers/perf/riscv_pmu_sbi.c |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index ef8311dafb91..4afa2cd01bae 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -233,20 +233,20 @@ enum sbi_pmu_ctr_type {
 #define SBI_PMU_EVENT_IDX_INVALID 0xFFFFFFFF
 
 /* Flags defined for config matching function */
-#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
-#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
-#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
-#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
-#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
-#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
-#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
-#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
 
 /* Flags defined for counter start function */
-#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
 
 /* Flags defined for counter stop function */
-#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
+#define SBI_PMU_STOP_FLAG_RESET BIT(0)
 
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 1823ffb25d35..f23501898657 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -386,7 +386,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 			cmask = 1;
 		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
 			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
-			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
+			cmask = BIT(CSR_INSTRET - CSR_CYCLE);
 		}
 	}
 
-- 
2.34.1


