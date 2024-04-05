Return-Path: <linux-kernel+bounces-132943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0BF899C44
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CB4B2459B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661716D30B;
	Fri,  5 Apr 2024 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qb2Zwydr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D816C86E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318484; cv=none; b=srFr9TjcIp2o9F0s1Dv2DOT8blYMQXsZ3oFmkm0T+mTOhOGGIcH9PjttwEoTpBtyP0JzhVgdiWY5kGUZ3UKGWQHfwgJhqgh8/kZRfQ6fDQp8tQg/qFDLXrNFphUbiqppzgAwzVKjXYjjOBUG9sfNzbmWBH4SLbb53Q0O0XvArSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318484; c=relaxed/simple;
	bh=/0jN/zskn+pvye9zhGa9kX2fqd2uuUdTKatvYSPMGHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnwL0w9/yANkJvVcT3CHXO6XQViQiotGHZhrKsHpFYuqMTQaEmHqItny+TdLMKxMahyhussgWXqTUQnV7+JaB62eQ1yfxYAEelYddsfgmXvYCYEhB6FTmMPUsKNJggCDvax8MIAvTrRsLsKhtMMQUtnQ84te7IQoKeHWLXctz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qb2Zwydr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712318482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsSFcUbsThM5IkqFm5UZmPp81ZNMKoAIhMlsT6uF7yg=;
	b=Qb2ZwydrKaa675QYBQ7dPMWeZNLPyq6L9mk50JwrLsQ3ZDTLcgZA9Pz84RCO4hqUl5g6Dh
	waSA1tGn5POy9bGkPy8N1WJx7q8hu4RIHiIJjtGPh9eynEFL2cTXRm9RUqncmCcOtqaIz9
	6exlnop4x9iqn8NDM2v7L9mmMH7IxAA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-OPspJuaKNhSwY_ngpVa5fw-1; Fri, 05 Apr 2024 08:01:21 -0400
X-MC-Unique: OPspJuaKNhSwY_ngpVa5fw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-430b7f75294so20851211cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712318480; x=1712923280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsSFcUbsThM5IkqFm5UZmPp81ZNMKoAIhMlsT6uF7yg=;
        b=AIP+5oDB5k1BNIUW9uZyLS7rCtHJqj+CB8KW5SCE/8U9geUfEhJtgOga2NlwpHzA5D
         DPtyF20/krwJ/JiHa1cEvCwN/kIErlHngrNJGSep6Hb0CZmJAbaPp751x+3vSrbxgP7w
         tNv55GCTnuyJyQW2vnvS+RL/H6bHJiia9Lyn1GDxR+6GBVC7sMczGSf7Or5FmtAgKnQd
         E3lHVVfrQKu5m8dOATFsxYMcr/wTJ5pC6Sb8hQtWUmnj5w0D8AfB5ck/E5lHbKLbKZJf
         mS7ktxRGu9lfM5jyNace9UZ56wFbQUPHFHNR8oSm0dgNylCdgy8GXeaFqotqWJO66yIt
         rzuw==
X-Forwarded-Encrypted: i=1; AJvYcCWRevx+vZDMd96dNW7FxjPenGoz5A1i+ItAIDgMZ31Iqa4D8G8eJbD5s31VovsSDqBuRh8rCWm4d6S1CgSrf2tJm9TFLPGUG+GN1ekc
X-Gm-Message-State: AOJu0Yxqj72AoEsOJLvGuPTF3yk5+l0BZZ3p6PecDJ4I12SsOhbW6ZAE
	Y1sebXAwnsI2InFFoAXq3veGBdwrOdduI10T4A/5nMwPY0YST8e3jhOSk6/LWETa9U61SX7vzg8
	TZnrBg1zCQdUNMxQ03l26eR+NaK/c1MTh4mUaTfel//FK+revqi4PnTbgwE7ZLg==
X-Received: by 2002:a05:622a:298f:b0:434:6094:beaa with SMTP id hd15-20020a05622a298f00b004346094beaamr1267267qtb.39.1712318480549;
        Fri, 05 Apr 2024 05:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnpiinNv2C2T+YikhgYDSg8DJI+6kCRzyHodV6nkO8b80TJOicClVWNFFNXPLtsSMcu3AVIQ==
X-Received: by 2002:a05:622a:298f:b0:434:6094:beaa with SMTP id hd15-20020a05622a298f00b004346094beaamr1267234qtb.39.1712318480054;
        Fri, 05 Apr 2024 05:01:20 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4c24001316a1e598258370.dip0.t-ipconnect.de. [2003:c9:3f4c:2400:1316:a1e5:9825:8370])
        by smtp.gmail.com with ESMTPSA id fb17-20020a05622a481100b00434383f2518sm679808qtb.87.2024.04.05.05.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:01:19 -0700 (PDT)
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
Subject: [PATCH 2/4] KVM: arm64: maintain per VM value for CTR_EL0
Date: Fri,  5 Apr 2024 14:01:06 +0200
Message-ID: <20240405120108.11844-3-sebott@redhat.com>
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

In preparation for CTR_EL0 emulation maintain a per VM for this
register and use it where appropriate.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/sys_regs.c         | 22 +++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9e8a496fb284..481216febb46 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -318,6 +318,7 @@ struct kvm_arch {
 
 	/* PMCR_EL0.N value for the guest */
 	u8 pmcr_n;
+	u64 ctr_el0;
 
 	/* Iterator for idreg debugfs */
 	u8	idreg_debugfs_iter;
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 131f5b0ca2b9..4d29b1a0842d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -215,13 +215,21 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
 /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
 #define CSSELR_MAX 14
 
+static u64 kvm_get_ctr_el0(struct kvm *kvm)
+{
+	if (kvm->arch.ctr_el0)
+		return kvm->arch.ctr_el0;
+
+	return read_sanitised_ftr_reg(SYS_CTR_EL0);
+}
+
 /*
  * Returns the minimum line size for the selected cache, expressed as
  * Log2(bytes).
  */
-static u8 get_min_cache_line_size(bool icache)
+static u8 get_min_cache_line_size(struct kvm *kvm, bool icache)
 {
-	u64 ctr = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u64 ctr = kvm_get_ctr_el0(kvm);
 	u8 field;
 
 	if (icache)
@@ -248,7 +256,7 @@ static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
 	if (vcpu->arch.ccsidr)
 		return vcpu->arch.ccsidr[csselr];
 
-	line_size = get_min_cache_line_size(csselr & CSSELR_EL1_InD);
+	line_size = get_min_cache_line_size(vcpu->kvm, csselr & CSSELR_EL1_InD);
 
 	/*
 	 * Fabricate a CCSIDR value as the overriding value does not exist.
@@ -283,7 +291,7 @@ static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
 	u32 i;
 
 	if ((val & CCSIDR_EL1_RES0) ||
-	    line_size < get_min_cache_line_size(csselr & CSSELR_EL1_InD))
+	    line_size < get_min_cache_line_size(vcpu->kvm, csselr & CSSELR_EL1_InD))
 		return -EINVAL;
 
 	if (!ccsidr) {
@@ -1862,7 +1870,7 @@ static bool access_ctr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (p->is_write)
 		return write_to_read_only(vcpu, p, r);
 
-	p->regval = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	p->regval = kvm_get_ctr_el0(vcpu->kvm);
 	return true;
 }
 
@@ -1882,7 +1890,7 @@ static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
  */
 static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
-	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u64 ctr_el0 = kvm_get_ctr_el0(vcpu->kvm);
 	u64 clidr;
 	u8 loc;
 
@@ -1935,7 +1943,7 @@ static u64 reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 static int set_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		      u64 val)
 {
-	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u64 ctr_el0 = kvm_get_ctr_el0(vcpu->kvm);
 	u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) && !CLIDR_LOUU(val));
 
 	if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
-- 
2.42.0


