Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B09180E766
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346223AbjLLJVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjLLJV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:21:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2363AD5;
        Tue, 12 Dec 2023 01:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702372892; x=1733908892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QhUq9FlvTvIr7jwQydmT4vM1c+dwWoHc5WAb4PAhk+o=;
  b=E2G3CUkrKXIsSRPCPQVv2cRaitQpnW42sYFbY4DWnL+cvM5L2VOYm1m6
   RzAWhSp9sUm/hmgxoXzaMbsbCO/8i3tyNiegtln0blaX0U+vXNYFHQcKp
   uuzIvV8g3F+tPFdBGS8O3+rcJEe2t/siE55nK7c/0FMCr86tTnv8FQYcq
   wneP0ZPq2MH2BLoWkxTUlrGxYb9YFKRi0JxdpE8QjYkPAvyrlfOwGmvU3
   URiqMi02ZgMrJc8eXl4lC1EvNGMAUt3XVSTsxKdNIm0lQoy7NQANQdTNY
   nbusEiM/5b8cTZzIiM57LGaf/wLZl4nUzfgiH/du0hEY1lTBrZELzZQ01
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480974446"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="480974446"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:21:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917213519"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917213519"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:21:23 -0800
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
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Minda Chen <minda.chen@starfivetech.com>,
        Samuel Holland <samuel@sholland.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v4 09/11] KVM: riscv: selftests: Change vcpu_has_ext to a common function
Date:   Tue, 12 Dec 2023 17:31:18 +0800
Message-Id: <3972ba512474a0a3c492877db82d19e988d7095e.1702371136.git.haibo1.xu@intel.com>
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

Move vcpu_has_ext to the processor.c and rename it to __vcpu_has_ext
so that other test cases can use it for vCPU extension check.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h |  2 ++
 tools/testing/selftests/kvm/lib/riscv/processor.c     | 10 ++++++++++
 tools/testing/selftests/kvm/riscv/get-reg-list.c      | 11 +----------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index b68b1b731a34..bd27e1c67579 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 #define RISCV_ISA_EXT_REG(idx)	__kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
 					     idx, KVM_REG_SIZE_ULONG)
 
+bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
+
 struct ex_regs {
 	unsigned long ra;
 	unsigned long sp;
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 39a1e9902dec..dad73ce18164 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -15,6 +15,16 @@
 
 static vm_vaddr_t exception_handlers;
 
+bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
+{
+	unsigned long value = 0;
+	int ret;
+
+	ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
+
+	return !ret && !!value;
+}
+
 static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
 {
 	return (v + vm->page_size) & ~(vm->page_size - 1);
diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 6bedaea95395..5da230e86728 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -75,15 +75,6 @@ bool check_reject_set(int err)
 	return err == EINVAL;
 }
 
-static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
-{
-	int ret;
-	unsigned long value;
-
-	ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
-	return (ret) ? false : !!value;
-}
-
 void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 {
 	unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };
@@ -111,7 +102,7 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 		__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature), 1);
 
 		/* Double check whether the desired extension was enabled */
-		__TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
+		__TEST_REQUIRE(__vcpu_has_ext(vcpu, s->feature),
 			       "%s not available, skipping tests\n", s->name);
 	}
 }
-- 
2.34.1

