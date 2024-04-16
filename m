Return-Path: <linux-kernel+bounces-147417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E518A73B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64677281795
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1813FD7E;
	Tue, 16 Apr 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="snwywB6x"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21613D539
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293109; cv=none; b=QI5eeieWh0SN5py4TMvKJ8tGh7Xq4ZxV6PiDYN5JyMV186aKiSeWPukDEJa6SdOEMtjl3xjWQ1Jct/q0wHS3NApbQ6mNU9KER0kqx3+deG+6KLuEZb1XOOyx+J1GZYbqoR7pVf9kDMM6Vyri9WepeJI2i0FRoVkP4Ry549Z0pd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293109; c=relaxed/simple;
	bh=RcVsdOTpWmQDe3QFQB057eZKtxuHNPDvA9mLhc2A9Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKc7Uc8sOX+zkyENFobMcixSMLuOZ7jI74X9Mbuz1242KQzrAxV+wESKaziGxNBesZl4lFTrwujHznV7GRdn+bgvdTH1kSkvuPEtpqJttoM870VuXgYndiyf+15I+sRl8Mbtjf2veT43Ugt46B6mxqQPVx0utNhwJgBuK8ux6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=snwywB6x; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so47639a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293107; x=1713897907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=snwywB6x/3UYo6Sz2k/vaH6cYHfVblxy4eiN9A0CLwoitN8wmbLafPdvyXRVGVeQhk
         Hyz2dcCSctc8pwk6cfhBRob2ORmU1ApcAnc3i7La9eX5UlOKIRvCbxx9dbAVzFYIH18h
         mAWJRhZMYBgsf4EyPk+SFCql4ReGh5bcZ4RhEZwh2ZK4PcknxW5VTi4e21BDzIRluQvv
         84dG0jZLcUonrVg4FSLe524JTsE6/FzHUMsVfKEg/S1VvEE7ue+qSxtBmeWmjd7rtJSi
         x7A4d1rlJPNz+2mIJ0Dn3Rs+PU4U9hra6wjYUjin2gZVBnkPMSb/tDH035uJXu3qMdig
         Okqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293107; x=1713897907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBWeKaYtpXhvKjSg+whNN/rWnhjngNSIx7A/W77I8WQ=;
        b=efr2PqQvEz1VxnfMFDhEKyEH6Z9hVzcY9E8lHbdVh5sTHo7JxBxdWSr2He5TYt8t2X
         NswVYHhPqMTcR1ddvmi+mBiJMq2Qpp6gz8gBk4s05zcQYJ8Htj6kb1gcdeirbO3EZX0R
         3ZCiFswZMtFbpgconIz7uST1MKaxwiLEQLYKDS3ZXCXesh0qjGYtWk11FBZBI5VD79Sv
         uuDhRXi5+a/M5sOZbzSsK73t/ihjHW0UlVvt08QK0GmP6c7AVu8QpJEF67Z4R/0yJQJG
         7vtQjfEvjNfIzM19dv4sjX9HEdZvo8v4cVVAfxZqKWX3tGkWZJ9dbXqTHFRZ20TLxW6d
         W9dw==
X-Gm-Message-State: AOJu0YwNID0fsd8WOuLEyYEfpzu2e/vZ1K9xxwoDvp0FliHp55kAZCHM
	zeEhRprQmaOdnDfILKnvu9npKYZ3A2sAbkbRb2bnzToGeBQ4JSryk2sutvBN/GSi3BfwTTGvZl2
	S
X-Google-Smtp-Source: AGHT+IEmOJnsCqKgMiSjK9JvIG/qr/zmtZv2INOC30OQkmamLtid+925iE6tPmkwso7m5t8fIgxSaw==
X-Received: by 2002:a17:90a:bc1:b0:2a1:64a:bb63 with SMTP id x1-20020a17090a0bc100b002a1064abb63mr4135416pjd.2.1713293106909;
        Tue, 16 Apr 2024 11:45:06 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:06 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v7 18/24] KVM: riscv: selftests: Add helper functions for extension checks
Date: Tue, 16 Apr 2024 11:44:15 -0700
Message-Id: <20240416184421.3693802-19-atishp@rivosinc.com>
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

__vcpu_has_ext can check both SBI and ISA extensions when the first
argument is properly converted to SBI/ISA extension IDs. Introduce
two helper functions to make life easier for developers so they
don't have to worry about the conversions.

Replace the current usages as well with new helpers.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 10 ++++++++++
 tools/testing/selftests/kvm/riscv/arch_timer.c        |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 3b9cb39327ff..5f389166338c 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -50,6 +50,16 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 
 bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
 
+static inline bool __vcpu_has_isa_ext(struct kvm_vcpu *vcpu, uint64_t isa_ext)
+{
+	return __vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(isa_ext));
+}
+
+static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sbi_ext)
+{
+	return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
+}
+
 struct ex_regs {
 	unsigned long ra;
 	unsigned long sp;
diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
index 0f9cabd99fd4..735b78569021 100644
--- a/tools/testing/selftests/kvm/riscv/arch_timer.c
+++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
@@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
 	int nr_vcpus = test_args.nr_vcpus;
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
-	__TEST_REQUIRE(__vcpu_has_ext(vcpus[0], RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),
+	__TEST_REQUIRE(__vcpu_has_isa_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
 				   "SSTC not available, skipping test\n");
 
 	vm_init_vector_tables(vm);
-- 
2.34.1


