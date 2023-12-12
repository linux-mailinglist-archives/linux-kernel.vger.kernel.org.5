Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7390C80E765
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbjLLJVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjLLJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:21:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB03F7;
        Tue, 12 Dec 2023 01:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702372876; x=1733908876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tcwg5cDbVW/bdr5Y+a/ZcTpguYUa0xH/g6hVAHEIPkU=;
  b=Qz42eD5vf+0GzxbtRohjKpEwroLvja+B06m5KxKADIqJ8EpVn1dE9VRs
   0jijGe/qMp002PfPNnwDHssGCq2ShheuKPcZ5XKMOoCqnlkF0M2lBaYhR
   Pr9l9n02SS2igeiWc3SSo8N51vKvEbTr9pSbQpqWz2Y4mxT53grCKOgV6
   5gl0256tfeyJ7GkGmgq29YpgkIpaisRBldgXYISi07uxXTdGxI0/DR6o3
   wx+QCT8Gz7KpnOdmufDzueCSd4EwZ5AjugvSjcFZFW6wyqBryoiinBXpM
   +iSRZIroEtcJHwBL0gbbUe7fZGYhWjObx6gZwdmHW+LCHXZLugYqcRSxo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480974420"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="480974420"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:21:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917213407"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917213407"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:21:07 -0800
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        wchen <waylingii@gmail.com>, Jisheng Zhang <jszhang@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Samuel Holland <samuel@sholland.org>,
        Sean Christopherson <seanjc@google.com>,
        Like Xu <likexu@tencent.com>, Peter Xu <peterx@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v4 08/11] KVM: riscv: selftests: Add guest helper to get vcpu id
Date:   Tue, 12 Dec 2023 17:31:17 +0800
Message-Id: <02f6c9ccaaeb4ceb67137863e0317f62cef62496.1702371136.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702371136.git.haibo1.xu@intel.com>
References: <cover.1702371136.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add guest_get_vcpuid() helper to simplify accessing to per-cpu
private data. The sscratch CSR was used to store the vcpu id.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/include/aarch64/processor.h | 4 ----
 tools/testing/selftests/kvm/include/kvm_util_base.h     | 9 +++++++++
 tools/testing/selftests/kvm/lib/riscv/processor.c       | 8 ++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index c42d683102c7..16ae0ac01879 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -226,8 +226,4 @@ void smccc_smc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
 	       uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5,
 	       uint64_t arg6, struct arm_smccc_res *res);
 
-
-
-uint32_t guest_get_vcpuid(void);
-
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index a18db6a7b3cf..666438113d22 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -932,4 +932,13 @@ void kvm_selftest_arch_init(void);
 
 void kvm_arch_vm_post_create(struct kvm_vm *vm);
 
+void vm_init_vector_tables(struct kvm_vm *vm);
+void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
+
+struct ex_regs;
+typedef void(*exception_handler_fn)(struct ex_regs *);
+void vm_install_exception_handler(struct kvm_vm *vm, int vector, exception_handler_fn handler);
+
+uint32_t guest_get_vcpuid(void);
+
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index efd9ac4b0198..39a1e9902dec 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -316,6 +316,9 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.sp), stack_vaddr + stack_size);
 	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_code);
 
+	/* Setup sscratch for guest_get_vcpuid() */
+	vcpu_set_reg(vcpu, RISCV_CSR_REG(sscratch), vcpu_id);
+
 	/* Setup default exception vector of guest */
 	vcpu_set_reg(vcpu, RISCV_CSR_REG(stvec), (unsigned long)guest_unexp_trap);
 
@@ -436,3 +439,8 @@ void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_fn handle
 
 	handlers->exception_handlers[1][0] = handler;
 }
+
+uint32_t guest_get_vcpuid(void)
+{
+	return csr_read(CSR_SSCRATCH);
+}
-- 
2.34.1

