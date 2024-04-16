Return-Path: <linux-kernel+bounces-147404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1F28A737C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC1A1C2082D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED49C13A3E5;
	Tue, 16 Apr 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1Ll2VWzI"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E6139CE6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293091; cv=none; b=d8oi3sp4gudnWTop5VjhCzUH6Blv0W0Bvl2NAb/0uc8ZBG+1v7/N6iwyIvH+TOIPvoY9sZwUea0kO4WiO2xutb8qqc+KsVnCOWEpSniTJC8rb4Hl76chjanlNXXr62b2Rpp+gLMDtHqUpIgHDVkYIw1QmZHnuYoj/krDhblvgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293091; c=relaxed/simple;
	bh=Gs/9X2hzactn0W0hn5UFwracoeJp45KmCczLf6NHuME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OG+ZLmMIKl01ZCQXnyqTNbE177zyJI6xRGyNAUMrJh6O7StcV9aXcRcdb8sqCJaARo8y5EuE2YT+ub303RFrEL50kL/OuLB5u9vo6MI+OsiqRONL0u3BFrDWWaEOQmaRefLnzxeHO6axm7JYa0l69C2GCmwuRStHMs8q/8INYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1Ll2VWzI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso32395b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293088; x=1713897888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=1Ll2VWzI8W1YGIG7FRLM/yINoz+qdRHCJvrBveY2tk+XPBhORoKAra57rHdvwo0sXx
         adokXKRUBWSm+ochnEqNK+gjuVnWAo/0pKLfnzrtKQWG9CrsdOJeUqaY/DSXLPFF5W84
         r6gTDxi9CDAPCFg5c/DPFdV177A1Cp8E0X+f+mBgZCLph6z6D2kJ0prxOwY+Ty5W1fCA
         d6wIoJ5fW/QZjdHVPcSKMuvMNhEfIlapKGvdpFmLBGh2/VgZH9nFgvQJgSnbP27oqcjv
         rCnBTXWTYHBSPJLYQcLpgupcbzSC/ErVJbkKZZnXhcsrhfGkzrkHoUVHVfIRXYf7ivtR
         YkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293088; x=1713897888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0lXa0RA4+kQWkomLRJk1QW7kf666EFgaJ2j58l79bA=;
        b=ScZJnu9amduzr4OGOOZuwcl9kTCFUueuRZAgywENxe0th7rmiPuQz0Rkxt2Rju7iNJ
         gbJzWJBfhF8jU3Ci4mjCyFusxXmM5tproBKLA5ZpdAdMN924KNwkn6NwnGdTOzdxTBXX
         MhyU+WKoY6Lu3tkSmnaaxmFV6OEnotUGX0EG9GgNzPWZW0zrkUZZhg646VClM9ndxWVp
         GwP1oX4QNW2QT1WkKEIFSF1kO/SL3j0+2Sw4vqmlZjdLsU1ByRLxCsbnSL16mJVXh5Qv
         kjk/6CTm0G0uH3GkOIzVE7Vu5G98JXYEDTgH8v+cszeH1mZX7IZSOUWlGIGilt3OB8+h
         /VGQ==
X-Gm-Message-State: AOJu0YzXQt/Tu0XknAiPg9eWCBsbCUNciFt5oaoKvGE4bcnpYTW8uDnx
	STmF2JI0+1W2YJeRyGim2BHJAtAcnmDJBBmuW+X5BGExFxGzFA4vo3iRIzHD3pyuzVT9h+HweZq
	l
X-Google-Smtp-Source: AGHT+IEy4ZrQc6VpWHcofWnBnFX841IYpr0DACATgSN6h23DP3YRcVds0NngKjdBNkuEvrMjPFCw+A==
X-Received: by 2002:a17:90b:4c8e:b0:2aa:b56b:5bdb with SMTP id my14-20020a17090b4c8e00b002aab56b5bdbmr3174156pjb.9.1713293088546;
        Tue, 16 Apr 2024 11:44:48 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:48 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Subject: [PATCH v7 05/24] RISC-V: Add SBI PMU snapshot definitions
Date: Tue, 16 Apr 2024 11:44:02 -0700
Message-Id: <20240416184421.3693802-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SBI PMU Snapshot function optimizes the number of traps to
higher privilege mode by leveraging a shared memory between the S/VS-mode
and the M/HS mode. Add the definitions for that extension and new error
codes.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 4afa2cd01bae..9aada4b9f7b5 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -132,6 +132,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
 	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
 };
 
 union sbi_pmu_ctr_info {
@@ -148,6 +149,13 @@ union sbi_pmu_ctr_info {
 	};
 };
 
+/* Data structure to contain the pmu snapshot data */
+struct riscv_pmu_snapshot_data {
+	u64 ctr_overflow_mask;
+	u64 ctr_values[64];
+	u64 reserved[447];
+};
+
 #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
 #define RISCV_PMU_RAW_EVENT_IDX 0x20000
 
@@ -244,9 +252,11 @@ enum sbi_pmu_ctr_type {
 
 /* Flags defined for counter start function */
 #define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
+#define SBI_PMU_START_FLAG_INIT_SNAPSHOT BIT(1)
 
 /* Flags defined for counter stop function */
 #define SBI_PMU_STOP_FLAG_RESET BIT(0)
+#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
 
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
@@ -285,6 +295,7 @@ struct sbi_sta_struct {
 #define SBI_ERR_ALREADY_AVAILABLE -6
 #define SBI_ERR_ALREADY_STARTED -7
 #define SBI_ERR_ALREADY_STOPPED -8
+#define SBI_ERR_NO_SHMEM	-9
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
-- 
2.34.1


