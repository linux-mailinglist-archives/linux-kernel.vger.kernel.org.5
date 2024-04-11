Return-Path: <linux-kernel+bounces-139571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0D58A0499
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479BC28955A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE893DBB2;
	Thu, 11 Apr 2024 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IBUB3eac"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B23D0D0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794134; cv=none; b=ug6ntWe1yYSrGG61GKdjI0znechsl/PbKLkV15R0mdMUExmSRQZSqBPy78QkwlDubHyL2SVs+0/Xhf4tvv8EdR+1s39VS+wZFuXSCkdRkzSOeYZbYmKizZumn/bs9xQ34bxXq8pJR0FXjby2OgcjDoveqKFDVowYWu4C8SXN+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794134; c=relaxed/simple;
	bh=iSleVGmYPORH0YJ6M9GKkX0luLVW1L/lHmqsDNV+cHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7v1A3TIZEgl9p3wVlCrLANKg17LRgJyKYmDFEheJv1fVx3VdEeYbql4iEJ8tC/N9lpeBj/siFzh4qnea5/66fdSXG3STA4Irq+zhxDvXqDJQpuv+V3jadEYQxKaWj6I8Yx7kx3Lxj0lrW7kjblxn6zG9UlYkBHmIHobWHeyQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IBUB3eac; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e4f341330fso9791065ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794131; x=1713398931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvJukw934GuSrXeFuup9ak7dnmqxN0Lb+FQnvb7sFPo=;
        b=IBUB3eac0zfUacwAQqjGVBpCZMKM5KbhukFcpOTOjfCraPDQvCbDc8q5jSkY3/OGlK
         cl4yDrgUMKCGORWa/BeNu96KCb+p+u6LAon8Qzz+27SstjUDw+sfMv0enbmxj7VyJCDP
         XsWdTTG6wlk/4pLZOhNgfhLQuwMyBJOP7X+PtFS0czhcXrQ9Ouy7JIroedqctKihcRgY
         TG0AKxgNcPBIdQCSui3Hl9RRDOqbVRftWAf1xmW6nx59W38/2GayuUMPUhNMd7YZ/iDO
         tPi0Nq4bGyCfcIgZJyR7K8TECQRYDzTsB8SxcoE7nmol1CerrPJdRQfRfEgMdgDg3H4V
         niEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794131; x=1713398931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvJukw934GuSrXeFuup9ak7dnmqxN0Lb+FQnvb7sFPo=;
        b=ZGtdXCbWQyQKNmQNQM8oKLtfgRhpYDEwNMcnG2Wa7/ekad9wnqdggTqoFXh6hty8oT
         EgCfKh3pPaBfeKKVYI0RKL8NO8JMvGyT6F6rwm3PqexVhO/uUd4dPwOjT1sM9NQSBPTr
         W1oEBqP15U8xaJVSwTW63wNTQ9T8K7jV7v57zFMeRVaep1d9myKNIHaz+909Y/MfohIn
         94qNZqr8UejW+ub2CM/0y2xJfEQTRiAaYFaqxkZQgEgHXbZs6bxqa9voo/KeNN3UKWeN
         Kw3i87sVGyOvsR6dORsUZBcDk+NDP8OW4PwTuRE3bPWGEobxBIN/Uh+Z9yRT2xi/tG2B
         iOCg==
X-Gm-Message-State: AOJu0Yy6aAZpg64QaXZrqFPkUXAWbpk/upKr+LYbQeEAm5BiuW6naACv
	tSoms2ox4+i0/bLEGUACVVgEkczJvJwG+H34UrqXf/xjd14irkSDdAEuBlDp27DMNlphxVroFjs
	A
X-Google-Smtp-Source: AGHT+IGQl1xQbgxg+nNMIsyytsihji4E3ebv+uAWttmmQwL/4Oe9eSB0Um2dnBeEnpUODnyh1XkRQw==
X-Received: by 2002:a17:902:db09:b0:1e3:dd66:58e1 with SMTP id m9-20020a170902db0900b001e3dd6658e1mr5752619plx.44.1712794131255;
        Wed, 10 Apr 2024 17:08:51 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:50 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 16/24] RISC-V: KVM: Improve firmware counter read function
Date: Wed, 10 Apr 2024 17:07:44 -0700
Message-Id: <20240411000752.955910-17-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the function to indicate that it is meant for firmware
counter read. While at it, add a range sanity check for it as
well.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h | 2 +-
 arch/riscv/kvm/vcpu_pmu.c             | 7 ++++++-
 arch/riscv/kvm/vcpu_sbi_pmu.c         | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 55861b5d3382..fa0f535bbbf0 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -89,7 +89,7 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 				     unsigned long ctr_mask, unsigned long flags,
 				     unsigned long eidx, u64 evtdata,
 				     struct kvm_vcpu_sbi_return *retdata);
-int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
+int kvm_riscv_vcpu_pmu_fw_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata);
 int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
 				      struct kvm_vcpu_sbi_return *retdata);
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index e1409ec9afc0..04db1f993c47 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -235,6 +235,11 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 	u64 enabled, running;
 	int fevent_code;
 
+	if (cidx >= kvm_pmu_num_counters(kvpmu) || cidx == 1) {
+		pr_warn("Invalid counter id [%ld] during read\n", cidx);
+		return -EINVAL;
+	}
+
 	pmc = &kvpmu->pmc[cidx];
 
 	if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW) {
@@ -747,7 +752,7 @@ int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
 	return 0;
 }
 
-int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
+int kvm_riscv_vcpu_pmu_fw_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata)
 {
 	int ret;
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index cf111de51bdb..e4be34e03e83 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -62,7 +62,7 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		ret = kvm_riscv_vcpu_pmu_ctr_stop(vcpu, cp->a0, cp->a1, cp->a2, retdata);
 		break;
 	case SBI_EXT_PMU_COUNTER_FW_READ:
-		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
+		ret = kvm_riscv_vcpu_pmu_fw_ctr_read(vcpu, cp->a0, retdata);
 		break;
 	case SBI_EXT_PMU_COUNTER_FW_READ_HI:
 		if (IS_ENABLED(CONFIG_32BIT))
-- 
2.34.1


