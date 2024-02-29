Return-Path: <linux-kernel+bounces-85977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6A86BDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928EF1C22CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F07B53804;
	Thu, 29 Feb 2024 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ChaL/aZ9"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7235336A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168522; cv=none; b=K0KEWEmXxhmWMcysAiHSEOJ/sd5K0f2hkP0rr88keB29Np0zWh4oU7E/t3+5AhJOLo95lkQTm8yT8NzoCN2GAfLIjQB/jXwxAvrT9kwRmpVqpFJay+ap3oiAoRsBc/vo/EMcnCOM+r6IX0ARCY8zW/U63IgQ+jLl7wlJzJW4Mzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168522; c=relaxed/simple;
	bh=mi1psca7/TYa7Xbgyv1aKnA/Q28+V+NGU7LpsFzFNKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nu9QgOJQIfwuiwG3GPn1oH9MRJlhxTeo0Ff7RC66pFE9eJEt4NL60GN0kpxb2MJDC8hkT5RclQvagKrAnolBUSB698u0sYLik2Mpo00N3BwKiCoa67avw2dvn09VEso7ahrfx/TTIQRoo84di37fKjAf7EspKIumHzpb80ili4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ChaL/aZ9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e4f5e84abeso221761b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709168519; x=1709773319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYucTeemWfRAPiCQTQ9yl6A+rrlCW5ybprNtXprP6Dk=;
        b=ChaL/aZ9JRer9bQGSW3q4ivQ8+NSWLygC8gLmtvYwh9/SZInom/iHIqacuEsk/XSAN
         FAQfQdCSIUgxFt/sw2Wjuy1gu78lX9BYJZqIsIwsbLRjDomi9Ki63iOLkvgUzprnvuhJ
         9S+4y81vATWE5AoVlR5VXc02mOmD3Rjdzgjv+OlPvsJKr0oWefUN06lTBY0/tyCU912F
         CjLFPwdOm5rjQoDQ4lWVyVpfBdDZhES/Datb2/IbJXP2LIyle9kjLKRvAydsMCXOuxKV
         kU0a+90vkwcENkFzzFgdg0LmYv8rG6y/4mF8cNQC4sdawiK3NOGJa0DPSNVQNXV2kdDp
         aytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168519; x=1709773319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYucTeemWfRAPiCQTQ9yl6A+rrlCW5ybprNtXprP6Dk=;
        b=hPv3nXUrtV+PMjahKkQcTIyXTFGTIM7rjupwGlhkG90K8JhUypG2E+CY9sWfSkBQ3A
         7MhWIFivnlj+GysjZXPXfKR9A81QbXp1imPLsulil5JxLlcbD76PH4Jvp199A+mTzPKV
         ZEaU9GPIM2Tt3mnrchoWSdxuMRGUeAQ5d47RPH3pg1oQLH5kcNmWVLWzSvR/BUpIsFTc
         Sba+bVuSIPYRbvaNsfy+Rx9TcnhFh2DViRtT9mZY99qwLwSQs/i7H35DeibnNQYhSrN2
         QtYIdVAIjwt07PmsZySJM7JnvaIoRR8n0q4lGZSRQdRKJgBWH4N/knn7Op7jhtaeFGd/
         mJhA==
X-Gm-Message-State: AOJu0YwqGA/p1DkdtohP2LYVS2zLlgPNRMFB6i7T1F87OXfG9UUpFt5a
	6xbnVXy58WLZhFkO8VP2BclrGxejibSVNrAEDubqnjvkC/RK9fUHH7duiCD/D5INmbit8GbF8Wn
	B
X-Google-Smtp-Source: AGHT+IEqfUh8VhDhXoq+Go9ekEejbXEHcnMgKviwusjZtfeHpsgbIZB0qPIiuNWau2agFB9+Q5OVJw==
X-Received: by 2002:a05:6a20:249:b0:1a0:df5f:99cb with SMTP id o9-20020a056a20024900b001a0df5f99cbmr802349pzo.27.1709168518919;
        Wed, 28 Feb 2024 17:01:58 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm78043plx.144.2024.02.28.17.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:01:58 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v4 10/15] RISC-V: KVM: Support 64 bit firmware counters on RV32
Date: Wed, 28 Feb 2024 17:01:25 -0800
Message-Id: <20240229010130.1380926-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229010130.1380926-1-atishp@rivosinc.com>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI v2.0 introduced a fw_read_hi function to read 64 bit firmware
counters for RV32 based systems.

Add infrastructure to support that.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h |  4 ++-
 arch/riscv/kvm/vcpu_pmu.c             | 37 ++++++++++++++++++++++++++-
 arch/riscv/kvm/vcpu_sbi_pmu.c         |  6 +++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 8cb21a4f862c..e0ad27dea46c 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -20,7 +20,7 @@ static_assert(RISCV_KVM_MAX_COUNTERS <= 64);
 
 struct kvm_fw_event {
 	/* Current value of the event */
-	unsigned long value;
+	u64 value;
 
 	/* Event monitoring status */
 	bool started;
@@ -91,6 +91,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 				     struct kvm_vcpu_sbi_return *retdata);
 int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata);
+int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+				      struct kvm_vcpu_sbi_return *retdata);
 void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned long saddr_low,
 				      unsigned long saddr_high, unsigned long flags,
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index a02f7b981005..469bb430cf97 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -196,6 +196,29 @@ static int pmu_get_pmc_index(struct kvm_pmu *pmu, unsigned long eidx,
 	return kvm_pmu_get_programmable_pmc_index(pmu, eidx, cbase, cmask);
 }
 
+static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+			      unsigned long *out_val)
+{
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	int fevent_code;
+
+	if (!IS_ENABLED(CONFIG_32BIT))
+		return -EINVAL;
+
+	pmc = &kvpmu->pmc[cidx];
+
+	if (pmc->cinfo.type != SBI_PMU_CTR_TYPE_FW)
+		return -EINVAL;
+
+	fevent_code = get_event_code(pmc->event_idx);
+	pmc->counter_val = kvpmu->fw_event[fevent_code].value;
+
+	*out_val = pmc->counter_val >> 32;
+
+	return 0;
+}
+
 static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 			unsigned long *out_val)
 {
@@ -702,6 +725,18 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 	return 0;
 }
 
+int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+				      struct kvm_vcpu_sbi_return *retdata)
+{
+	int ret;
+
+	ret = pmu_fw_ctr_read_hi(vcpu, cidx, &retdata->out_val);
+	if (ret == -EINVAL)
+		retdata->err_val = SBI_ERR_INVALID_PARAM;
+
+	return 0;
+}
+
 int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata)
 {
@@ -775,7 +810,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
 			pmc->cinfo.csr = CSR_CYCLE + i;
 		} else {
 			pmc->cinfo.type = SBI_PMU_CTR_TYPE_FW;
-			pmc->cinfo.width = BITS_PER_LONG - 1;
+			pmc->cinfo.width = 63;
 		}
 	}
 
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index 9f61136e4bb1..58a0e5587e2a 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -64,6 +64,12 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case SBI_EXT_PMU_COUNTER_FW_READ:
 		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
 		break;
+	case SBI_EXT_PMU_COUNTER_FW_READ_HI:
+		if (IS_ENABLED(CONFIG_32BIT))
+			ret = kvm_riscv_vcpu_pmu_fw_ctr_read_hi(vcpu, cp->a0, retdata);
+		else
+			retdata->out_val = 0;
+		break;
 	case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
 		ret = kvm_riscv_vcpu_pmu_setup_snapshot(vcpu, cp->a0, cp->a1, cp->a2, retdata);
 		break;
-- 
2.34.1


