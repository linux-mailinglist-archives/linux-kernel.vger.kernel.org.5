Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305907FC1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbjK1Oyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346279AbjK1OyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:54:25 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B411BDD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:28 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cf8c462766so39941695ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183268; x=1701788068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqxVg8l3Hg6Frv7KJ86Slj6nrb0o+W/dOYeQGaFJwTE=;
        b=RwnLmE4rkrQMvGRi/+5v+L5fyf0KqiEjfivfQtk29e0o0NlGtHVDzFrB6WV41va5Dn
         37UM8/GTdAKsQy0/2BdVsa2BlEZS5DkVJ48dgSTjILpcoVXEjeDSgsQ6Mun9i0Muicux
         vuM3jpyyYilBA1VRqPD66VZwX1gqUKNB7K4bwD6tfH+qGzXRZPCXbrF/+m7ixduyEel4
         DqEdlwhbzt7ppX++rAwqaxfi5mi4vfwtvJmLLVHHFyPdrRl3zulTyl859b5Segj4HpPD
         nppb//Ov0jqf6FS6C8mjsD/Ajyns9q/NbmEPe1DD0aX79WeJbCBST3Dt2CQTQPVcaSAq
         tfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183268; x=1701788068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqxVg8l3Hg6Frv7KJ86Slj6nrb0o+W/dOYeQGaFJwTE=;
        b=gKP1bwfBgy7dF9OtXgZyO8i42q0+f5T7wTfpOxrvQG4R1wS1fMeid3if+BnHEoaUBc
         6i+FBaDBVTLgleEhnFBbnnBm88go5NOA7ykHH16TJHHRfw9P5I+zZz5cGwwp2jIZsKJR
         Ds1F6n7y2xYbfc/4+9OGF8Ix9f1TMZbU7Vt+/UKRemrTSrrVJKoo7blFxlUvBNnzl6d0
         UB3lxMfMKveI+pnCwjKJadn7WTPn8qiOKLRi8Q8Bc5POaKUsVRYM5DkfOh8c+YRlsoKN
         0mFQG/rY2kQeT/b+3TbNMQ/rd9To9NJ5n7XLNVbh14WRW3vt3LxkEGg0M6s0WLvo9elT
         bzCw==
X-Gm-Message-State: AOJu0YwG9piYP4X8QmvrFjJpJmV/Zs9BcjDenOIywb2tVbrDpnorN+TY
        y5GwhTzpFWX4mUlrpQBW8q+Bqw==
X-Google-Smtp-Source: AGHT+IFcoaA2hxnFbXCCUocOR1sG99CREnANM1PmTY3hLfSSQRNudLUWraMAAhbsdJoHp2lrLA44uw==
X-Received: by 2002:a17:903:11c4:b0:1cc:4072:22c6 with SMTP id q4-20020a17090311c400b001cc407222c6mr17937667plh.24.1701183267919;
        Tue, 28 Nov 2023 06:54:27 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:27 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 04/15] RISC-V: KVM: Allow scalar crypto extensions for Guest/VM
Date:   Tue, 28 Nov 2023 20:23:46 +0530
Message-Id: <20231128145357.413321-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We extend the KVM ISA extension ONE_REG interface to allow KVM
user space to detect and enable scalar crypto extensions for
Guest/VM. This includes extensions Zbkb, Zbkc, Zbkx, Zknd, Zkne,
Zknh, Zkr, Zksed, Zksh, and Zkt.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 10 ++++++++++
 arch/riscv/kvm/vcpu_onereg.c      | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 518b368b41e5..7b54fa215d6d 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -140,6 +140,16 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_SMSTATEEN,
 	KVM_RISCV_ISA_EXT_ZICOND,
 	KVM_RISCV_ISA_EXT_ZBC,
+	KVM_RISCV_ISA_EXT_ZBKB,
+	KVM_RISCV_ISA_EXT_ZBKC,
+	KVM_RISCV_ISA_EXT_ZBKX,
+	KVM_RISCV_ISA_EXT_ZKND,
+	KVM_RISCV_ISA_EXT_ZKNE,
+	KVM_RISCV_ISA_EXT_ZKNH,
+	KVM_RISCV_ISA_EXT_ZKR,
+	KVM_RISCV_ISA_EXT_ZKSED,
+	KVM_RISCV_ISA_EXT_ZKSH,
+	KVM_RISCV_ISA_EXT_ZKT,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index f789517c9fae..b0beebd4f86e 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -43,6 +43,9 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZBA),
 	KVM_ISA_EXT_ARR(ZBB),
 	KVM_ISA_EXT_ARR(ZBC),
+	KVM_ISA_EXT_ARR(ZBKB),
+	KVM_ISA_EXT_ARR(ZBKC),
+	KVM_ISA_EXT_ARR(ZBKX),
 	KVM_ISA_EXT_ARR(ZBS),
 	KVM_ISA_EXT_ARR(ZICBOM),
 	KVM_ISA_EXT_ARR(ZICBOZ),
@@ -52,6 +55,13 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZIFENCEI),
 	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
 	KVM_ISA_EXT_ARR(ZIHPM),
+	KVM_ISA_EXT_ARR(ZKND),
+	KVM_ISA_EXT_ARR(ZKNE),
+	KVM_ISA_EXT_ARR(ZKNH),
+	KVM_ISA_EXT_ARR(ZKR),
+	KVM_ISA_EXT_ARR(ZKSED),
+	KVM_ISA_EXT_ARR(ZKSH),
+	KVM_ISA_EXT_ARR(ZKT),
 };
 
 static unsigned long kvm_riscv_vcpu_base2isa_ext(unsigned long base_ext)
@@ -94,6 +104,9 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_RISCV_ISA_EXT_ZBB:
 	case KVM_RISCV_ISA_EXT_ZBC:
+	case KVM_RISCV_ISA_EXT_ZBKB:
+	case KVM_RISCV_ISA_EXT_ZBKC:
+	case KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_RISCV_ISA_EXT_ZBS:
 	case KVM_RISCV_ISA_EXT_ZICNTR:
 	case KVM_RISCV_ISA_EXT_ZICOND:
@@ -101,6 +114,13 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZIFENCEI:
 	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
 	case KVM_RISCV_ISA_EXT_ZIHPM:
+	case KVM_RISCV_ISA_EXT_ZKND:
+	case KVM_RISCV_ISA_EXT_ZKNE:
+	case KVM_RISCV_ISA_EXT_ZKNH:
+	case KVM_RISCV_ISA_EXT_ZKR:
+	case KVM_RISCV_ISA_EXT_ZKSED:
+	case KVM_RISCV_ISA_EXT_ZKSH:
+	case KVM_RISCV_ISA_EXT_ZKT:
 		return false;
 	/* Extensions which can be disabled using Smstateen */
 	case KVM_RISCV_ISA_EXT_SSAIA:
-- 
2.34.1

