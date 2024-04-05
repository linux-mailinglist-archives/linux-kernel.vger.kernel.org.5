Return-Path: <linux-kernel+bounces-132945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C15899C47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5EA28223A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0C416D33A;
	Fri,  5 Apr 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWsMO/YQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11A16C6B5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318494; cv=none; b=DHCDsGxl5hu33QV/L3/ZkzbQwZd1Wa2w+pQYdhms5dZKy9ZYY8DjVXynwbzdf1QM3XnnNTSrSSjR5m+gvCDn22cRLYbu8a78CeaxAC+SyYl72t/IjnIOqGSvjIlIw3C7e4808+0d8aHxPNl+0KByfnfHfFRVkwEDrhuTBX5Jpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318494; c=relaxed/simple;
	bh=jqn2XCZxEDbBltMtM+7J9+MGFZAyGlmvapHglxRoTiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7xLPRVpS+cAMHb1Bh3LFrGUIfDpfii1hVsvFgGxh5r+1/Nlc7yk8h35SL9TC+BJjST+cGQdcTuSJOHvXEgE8tdUxLquHZ+XzV0yNx3BDPoJHaT9W7GRncaaFNViXf/sTQPMkshk4ADLyJnmgkKxz/utDfUVbelNY40xCEXLHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWsMO/YQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712318491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Er4m6dF4CTJ/JTa0OQR3uPXdnB5OQd8nc24oiwvaXBk=;
	b=jWsMO/YQ08g0xQwIzLliRaVqqvcONohz4ip6nfLuZ9aa09Vo+HxaNNpiJuO+mR0KX3i9Au
	reFarCA/DhbYUuVdVYjpwD5f0Ee7XqZq+G3OZ/KSFrE5lsLJccGrKo+/vfwtRKkBM4R5g+
	IbjuVk4Ae3Iw1MDLbaSha5DoDvJMfUE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-6s_a9PAjNtqQQbZk-DyMsg-1; Fri, 05 Apr 2024 08:01:30 -0400
X-MC-Unique: 6s_a9PAjNtqQQbZk-DyMsg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4311b01a1ecso21592101cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712318490; x=1712923290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Er4m6dF4CTJ/JTa0OQR3uPXdnB5OQd8nc24oiwvaXBk=;
        b=hz96x3j/5IpK11Ez6CnSCxYbDkoP5uCK2Q/BM4ItpIKgr9SXI5cFGMyZi0wVKlXDYD
         GD2QyOwMUlU2t7XDUvU37pb9Ry/ZVeBiv0KjYxvuixxfmTmh9lFEE8ZsHO/X4FikpyPj
         X7M+OqyCMhTK6Kr/ZS+JVABZ7YoUlHFMbVD8U7XuxHxe3nGCHr7ShaNCZnDxKtcgOZJS
         T5rSb1OQ0yQxFZtS9NMlE4+2K5eIIq8nXXS1ZMLU8qupOHnglaCfuBj0n/66SqIoIY62
         j821Cf35pGgdDZiQiOx3o2lH5oCnfHnRgAK02Owrm1cegV0LzH6CSXtPE4I12PnlpICK
         pyTg==
X-Forwarded-Encrypted: i=1; AJvYcCVCQHJPxacGcvgALgqvb3sya+QvCeTgVF0Sfx7OeFlJeeKyeaN/Wsz+cIGW9XiQ4Uw8Yw4CLCj2ItJq6wzfeQgel3C1KDMtBHVgLhDe
X-Gm-Message-State: AOJu0YwB+jllmo13yWtAID3eR6lrbBsm9P1v4PlwNOHCP/Je81839hXc
	5Kry6Lg8L+ygaA7LGvV9ZZ1yc9Fkvpi3ohrYcnGedMFfZfriiRjuNPjEs4mlK3L3NV392QCd80q
	MXktMrd32MphbXGz1Yy4DB/VR+yOvosdQabisDEv+W7xqZuyAlRUfAvHTuDavZQ==
X-Received: by 2002:a05:622a:40b:b0:434:3e7c:ff29 with SMTP id n11-20020a05622a040b00b004343e7cff29mr1054725qtx.8.1712318485071;
        Fri, 05 Apr 2024 05:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiyCyRJp19IZ/hMqBIxQeEde5V/OMaJJ5oWTE9Op1Wu8z9M5yrM5kFTCU5Bk+wY8/8Aog8fg==
X-Received: by 2002:a05:622a:40b:b0:434:3e7c:ff29 with SMTP id n11-20020a05622a040b00b004343e7cff29mr1054631qtx.8.1712318483158;
        Fri, 05 Apr 2024 05:01:23 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4c24001316a1e598258370.dip0.t-ipconnect.de. [2003:c9:3f4c:2400:1316:a1e5:9825:8370])
        by smtp.gmail.com with ESMTPSA id fb17-20020a05622a481100b00434383f2518sm679808qtb.87.2024.04.05.05.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:01:22 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 3/4] KVM: arm64: add emulation for CTR_EL0 register
Date: Fri,  5 Apr 2024 14:01:07 +0200
Message-ID: <20240405120108.11844-4-sebott@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405120108.11844-1-sebott@redhat.com>
References: <20240405120108.11844-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CTR_EL0 is currently handled as an invariant register, thus
guests will be presented with the host value of that register.
Add emulation for CTR_EL0 based on a per VM value.

When CTR_EL0 is changed the reset function for CLIDR_EL1 is
called to make sure we present the guest with consistent
register values.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 72 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4d29b1a0842d..b0ba292259f9 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1874,6 +1874,55 @@ static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+static u64 reset_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd)
+{
+	vcpu->kvm->arch.ctr_el0 = 0;
+	return kvm_get_ctr_el0(vcpu->kvm);
+}
+
+static int get_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		   u64 *val)
+{
+	*val = kvm_get_ctr_el0(vcpu->kvm);
+	return 0;
+}
+
+static const struct sys_reg_desc *get_sys_reg_desc(u32 encoding);
+
+static int set_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		   u64 val)
+{
+	u64 host_val = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u64 old_val = kvm_get_ctr_el0(vcpu->kvm);
+	const struct sys_reg_desc *clidr_el1;
+	int ret;
+
+	if (val == old_val)
+		return 0;
+
+	if (kvm_vm_has_ran_once(vcpu->kvm))
+		return -EBUSY;
+
+	mutex_lock(&vcpu->kvm->arch.config_lock);
+	ret = arm64_check_features(vcpu, rd, val);
+	if (ret) {
+		mutex_unlock(&vcpu->kvm->arch.config_lock);
+		return ret;
+	}
+	if (val != host_val)
+		vcpu->kvm->arch.ctr_el0 = val;
+	else
+		vcpu->kvm->arch.ctr_el0 = 0;
+
+	mutex_unlock(&vcpu->kvm->arch.config_lock);
+
+	clidr_el1 = get_sys_reg_desc(SYS_CLIDR_EL1);
+	if (clidr_el1)
+		clidr_el1->reset(vcpu, clidr_el1);
+
+	return 0;
+}
+
 static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
 {
@@ -2460,7 +2509,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
-	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
+	{ SYS_DESC(SYS_CTR_EL0), access_ctr, .reset = reset_ctr,
+	  .get_user = get_ctr, .set_user = set_ctr, .val = (CTR_EL0_DIC_MASK |
+							    CTR_EL0_IDC_MASK |
+							    CTR_EL0_DminLine_MASK |
+							    CTR_EL0_IminLine_MASK)},
 	{ SYS_DESC(SYS_SVCR), undef_access },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
@@ -3623,6 +3676,13 @@ static bool index_to_params(u64 id, struct sys_reg_params *params)
 	}
 }
 
+static const struct sys_reg_desc *get_sys_reg_desc(u32 encoding)
+{
+	struct sys_reg_params params = encoding_to_params(encoding);
+
+	return find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+}
+
 const struct sys_reg_desc *get_reg_by_id(u64 id,
 					 const struct sys_reg_desc table[],
 					 unsigned int num)
@@ -3676,18 +3736,11 @@ FUNCTION_INVARIANT(midr_el1)
 FUNCTION_INVARIANT(revidr_el1)
 FUNCTION_INVARIANT(aidr_el1)
 
-static u64 get_ctr_el0(struct kvm_vcpu *v, const struct sys_reg_desc *r)
-{
-	((struct sys_reg_desc *)r)->val = read_sanitised_ftr_reg(SYS_CTR_EL0);
-	return ((struct sys_reg_desc *)r)->val;
-}
-
 /* ->val is filled in by kvm_sys_reg_table_init() */
 static struct sys_reg_desc invariant_sys_regs[] __ro_after_init = {
 	{ SYS_DESC(SYS_MIDR_EL1), NULL, get_midr_el1 },
 	{ SYS_DESC(SYS_REVIDR_EL1), NULL, get_revidr_el1 },
 	{ SYS_DESC(SYS_AIDR_EL1), NULL, get_aidr_el1 },
-	{ SYS_DESC(SYS_CTR_EL0), NULL, get_ctr_el0 },
 };
 
 static int get_invariant_sys_reg(u64 id, u64 __user *uaddr)
@@ -4049,6 +4102,9 @@ void kvm_init_sysreg(struct kvm_vcpu *vcpu)
 			vcpu->arch.hcrx_el2 |= (HCRX_EL2_MSCEn | HCRX_EL2_MCE2);
 	}
 
+	if (vcpu->kvm->arch.ctr_el0)
+		vcpu->arch.hcr_el2 |= HCR_TID2;
+
 	if (test_bit(KVM_ARCH_FLAG_FGU_INITIALIZED, &kvm->arch.flags))
 		goto out;
 
-- 
2.42.0


