Return-Path: <linux-kernel+bounces-159904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412948B3602
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B4B284CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732471465A3;
	Fri, 26 Apr 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMhJQGCI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1814533F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128606; cv=none; b=HmF6YLPkZbrvvyNc2WJAz3kKJuP9K+dHDTmH1MiVyUc0Zn+jW5hgPhUGHPqXF+n//rQRO3SiaOPWtetZB0OXCwbO1l7tC9FZLLh0lpsmbzf1v3pJBTAULAMANUoVw+oAnCODSWnORAv2uQW/kyhndXitO2v61InXjO0fs8umMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128606; c=relaxed/simple;
	bh=9tf8evFXPxZIsJtfON0tpY2q9B/4pD7lHgFXwfjZ268=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5QEPs3ziweC86riO5Aqd3b2KM6d+87QZpmFbyRsfIk6SZZFkWFNLIr+FtuhvUGy4UGnN3+VLXwlmDe+dUzo0701FxxJb8i5cDibCAGyHw3MwCTJHMGC7BByS7PZkAh/m5Yy9kmElpa1lY33oBsuDE90WvWIdruR1Rusi/T0XO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMhJQGCI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714128602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWPuNZam4oUpFHKljOPQcZMbiol5epXIuKViics5wNw=;
	b=SMhJQGCIfsF/usswwgrmCt/wQZeEt2Z0EIjuqe5NMF6BHPfFE0z51KDtkCNGjeDI/vJs2R
	0WX2Td2hIKe3uSQBe+bn8ACyQSH0wl31wkUnx6rxX4hd8zqLZiG3dNLqJKWkjZy6i1na77
	28OGkF39FE8dan0euSphIzRNjc8IhRE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-3q8hvuHgMI6kPRy4aOPFsw-1; Fri, 26 Apr 2024 06:50:01 -0400
X-MC-Unique: 3q8hvuHgMI6kPRy4aOPFsw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69b123bfbd9so24981296d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128601; x=1714733401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWPuNZam4oUpFHKljOPQcZMbiol5epXIuKViics5wNw=;
        b=uo2jMFQ0hpsiaQiXKV/5CxO5KipuF68TOiXFA0M8CZPcdaU/udUMa5iTQmEQQ14IVo
         12Oe2ICfQ+8Gwdj89zUMePpLwnRnat90M7MAbkU8rRoP03tbg12DSGgEeGEjeVA7P6GJ
         +bWZlSkd3Q2VEF53V0X8z8qf8yDkiWPmj/LWsYNg2B2QpbQQ8uGwMGqQ5nZl5JXVq3t6
         QLWdeMdsGT+5vxawkH2TWy4+8tPZQMQrNHa7+Vng2/Lsn3e3ttRI7W3LHXR3b6Ny2opi
         YAHSknBM0jUPDUIUrSJALhA/5YYM5uJyHxvvR449PSYOl/6sLdY8wGUpmVF4sJH8QK9D
         eu2A==
X-Forwarded-Encrypted: i=1; AJvYcCXh5xATdu//KpBz7VKXzhpt5Z8Q3EkSvE2OJ6zRqnXDEDGhECz3fO+KyoVZ8LG3aaRpfuqXiVlR1NN3AwDdShuVRifA9NtVfvEi8lVx
X-Gm-Message-State: AOJu0YyIcLz6gXpjiT5LmfHls7bXTZzs+VsXpV2vY2zHNZRGlnycq51d
	OXM2u5PZiDl8uy0YyfItba7Y8RP0uAEwcMYCUJA+XAQsLt+wjl2pCWKgGihnfnlTqChMqTdm8Th
	/vle4Aic4e1vS299QvaYYyCTMBNLcYJB6HQexEoYM3aXlV3WJqwjk67Ai1ZXTpg==
X-Received: by 2002:a05:6214:246d:b0:69f:6b0d:3f62 with SMTP id im13-20020a056214246d00b0069f6b0d3f62mr3254511qvb.55.1714128600970;
        Fri, 26 Apr 2024 03:50:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJyH5OHPJ7TR40RC5KizCF/4egd908tGs6YVstwmK3Jxz72fvFPFvoPA1KvhVgGxDZ+ojbww==
X-Received: by 2002:a05:6214:246d:b0:69f:6b0d:3f62 with SMTP id im13-20020a056214246d00b0069f6b0d3f62mr3254486qvb.55.1714128600530;
        Fri, 26 Apr 2024 03:50:00 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id vv26-20020a05620a563a00b007907b57aa1fsm3888019qkn.12.2024.04.26.03.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:50:00 -0700 (PDT)
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
Subject: [PATCH v2 3/6] KVM: arm64: maintain per VM value for CTR_EL0
Date: Fri, 26 Apr 2024 12:49:47 +0200
Message-ID: <20240426104950.7382-4-sebott@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426104950.7382-1-sebott@redhat.com>
References: <20240426104950.7382-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for CTR_EL0 emulation maintain a per VM for this
register and use it where appropriate.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/kvm/sys_regs.c         | 15 ++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 696acba883c1..0c84cdb11c97 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -340,6 +340,8 @@ struct kvm_arch {
 #define KVM_ARM_ID_REG_NUM	(IDREG_IDX(sys_reg(3, 0, 0, 7, 7)) + 1)
 	u64 id_regs[KVM_ARM_ID_REG_NUM];
 
+	u64 ctr_el0;
+
 	/* Masks for VNCR-baked sysregs */
 	struct kvm_sysreg_masks	*sysreg_masks;
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index ac366d0b614a..1488b93050d4 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -219,9 +219,9 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
  * Returns the minimum line size for the selected cache, expressed as
  * Log2(bytes).
  */
-static u8 get_min_cache_line_size(bool icache)
+static u8 get_min_cache_line_size(struct kvm *kvm, bool icache)
 {
-	u64 ctr = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u64 ctr = kvm->arch.ctr_el0;
 	u8 field;
 
 	if (icache)
@@ -248,7 +248,7 @@ static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
 	if (vcpu->arch.ccsidr)
 		return vcpu->arch.ccsidr[csselr];
 
-	line_size = get_min_cache_line_size(csselr & CSSELR_EL1_InD);
+	line_size = get_min_cache_line_size(vcpu->kvm, csselr & CSSELR_EL1_InD);
 
 	/*
 	 * Fabricate a CCSIDR value as the overriding value does not exist.
@@ -283,7 +283,7 @@ static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
 	u32 i;
 
 	if ((val & CCSIDR_EL1_RES0) ||
-	    line_size < get_min_cache_line_size(csselr & CSSELR_EL1_InD))
+	    line_size < get_min_cache_line_size(vcpu->kvm, csselr & CSSELR_EL1_InD))
 		return -EINVAL;
 
 	if (!ccsidr) {
@@ -1862,7 +1862,7 @@ static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (p->is_write)
 		return write_to_read_only(vcpu, p, r);
 
-	p->regval = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	p->regval = vcpu->kvm->arch.ctr_el0;
 	return true;
 }
 
@@ -1882,7 +1882,7 @@ static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
  */
 static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
-	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u64 ctr_el0 = vcpu->kvm->arch.ctr_el0;
 	u64 clidr;
 	u8 loc;
 
@@ -1935,8 +1935,8 @@ static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 static int set_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		      u64 val)
 {
-	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
 	u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) && !CLIDR_LOUU(val));
+	u64 ctr_el0 = vcpu->kvm->arch.ctr_el0;
 
 	if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
 		return -EINVAL;
@@ -3509,6 +3509,7 @@ static void kvm_reset_id_regs(struct kvm_vcpu *vcpu)
 		return;
 
 	lockdep_assert_held(&kvm->arch.config_lock);
+	kvm->arch.ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
 
 	/* Initialize all idregs */
 	while (is_id_reg(id)) {
-- 
2.42.0


