Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E11380E73A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346229AbjLLJTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjLLJTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:19:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F77E4;
        Tue, 12 Dec 2023 01:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702372764; x=1733908764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QlPZW0GBZiFo9wZtaFy36OmisO9WZ283w6A3O/gJtXc=;
  b=Zk7LtFjt7CYJYZk2W+XortbkzF5cYyl4qnmSYYZ2TzyZn96XWa7rsb8K
   vKnrP3gNYSISgvJ58N55EziraKiYundikconMGVVTHqM3aSsqzsE5y02G
   /rheTg41iUFXDMufTcABlI5gcu6692X4wNVyJKokKiheyJnK8esIlXZVr
   NUtEjkcdwhqIB2LKVeSh1e+3OoBcedzlVZxrLXwyBTAiyITa4dOwKbOZD
   lA5VPcOHgURCxvLKZy/eCGg9NdxEbfffBM+/J95lNbSjymMMKv9WQDuBU
   m/qMFjDXy7vRDtPrGNmKVTCzNx751JUqH6Fhjx2pHOZ9puOeUkrmsQ7CQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480974169"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="480974169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917212848"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917212848"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:19:15 -0800
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Samuel Holland <samuel@sholland.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Sean Christopherson <seanjc@google.com>,
        Like Xu <likexu@tencent.com>, Peter Xu <peterx@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v4 01/11] selftests/kvm: Fix issues with $(SPLIT_TESTS)
Date:   Tue, 12 Dec 2023 17:31:10 +0800
Message-Id: <234ad46de32c345cb5b26212a27f0336ce0c9379.1702371136.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702371136.git.haibo1.xu@intel.com>
References: <cover.1702371136.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

The introduction of $(SPLIT_TESTS) also introduced a warning when
building selftests on architectures that include get-reg-lists:

    make: Entering directory '/root/kvm/tools/testing/selftests/kvm'
    Makefile:272: warning: overriding recipe for target '/root/kvm/tools/testing/selftests/kvm/get-reg-list'
    Makefile:267: warning: ignoring old recipe for target '/root/kvm/tools/testing/selftests/kvm/get-reg-list'
    make: Leaving directory '/root/kvm/tools/testing/selftests/kvm'

In addition, the rule for $(SPLIT_TESTS_TARGETS) includes _all_
the $(SPLIT_TESTS_OBJS), which only works because there is just one.
So fix both by adjusting the rules:

- remove $(SPLIT_TESTS_TARGETS) from the $(TEST_GEN_PROGS) rules,
  and rename it to $(SPLIT_TEST_GEN_PROGS)

- fix $(SPLIT_TESTS_OBJS) so that it plays well with $(OUTPUT),
  rename it to $(SPLIT_TEST_GEN_OBJ), and list the object file
  explicitly in the $(SPLIT_TEST_GEN_PROGS) link rule

Fixes: 17da79e009c3 ("KVM: arm64: selftests: Split get-reg-list test code", 2023-08-09)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/Makefile | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 52c59bad7213..2200f06b740b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -251,32 +251,36 @@ LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
 LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
-SPLIT_TESTS_TARGETS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
-SPLIT_TESTS_OBJS := $(patsubst %, $(ARCH_DIR)/%.o, $(SPLIT_TESTS))
+SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
+SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH_DIR)/%.o, $(SPLIT_TESTS))
 
 TEST_GEN_OBJ = $(patsubst %, %.o, $(TEST_GEN_PROGS))
 TEST_GEN_OBJ += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
 TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_OBJ))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBKVM_OBJS))
-TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TESTS_OBJS))
+TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TEST_GEN_OBJ))
 -include $(TEST_DEP_FILES)
 
-$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
+x := $(shell mkdir -p $(sort $(OUTPUT)/$(ARCH_DIR) $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
+
+$(filter-out $(SPLIT_TEST_GEN_PROGS), $(TEST_GEN_PROGS)) \
+$(TEST_GEN_PROGS_EXTENDED): %: %.o
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM_OBJS) $(LDLIBS) -o $@
 $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
+$(SPLIT_TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(OUTPUT)/$(ARCH_DIR)/%.o
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
+$(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH_DIR)/%.o: $(ARCH_DIR)/%.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
 EXTRA_CLEAN += $(GEN_HDRS) \
 	       $(LIBKVM_OBJS) \
-	       $(SPLIT_TESTS_OBJS) \
+	       $(SPLIT_TEST_GEN_OBJ) \
 	       $(TEST_DEP_FILES) \
 	       $(TEST_GEN_OBJ) \
 	       cscope.*
 
-x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
 $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
@@ -290,7 +294,7 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
 
 x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
-$(SPLIT_TESTS_OBJS): $(GEN_HDRS)
+$(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
 $(TEST_GEN_OBJ): $(GEN_HDRS)
-- 
2.34.1

