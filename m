Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B1D80F81B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377288AbjLLUrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377254AbjLLUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:47:04 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179FBF2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:09 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d09a64eaebso54431485ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414028; x=1703018828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=63FW+3XX5/e8zea7VCMPF1eNiMssQ00z9r2TQiyi8pA=;
        b=mTsUbYawaFu4uUJg03yc2JUrbrvQKJW6LxsvxthD45xTSefLhQWOZ1UxgTIpGAXlG3
         GEMQ1AM38NOiiWZm6HIsTjovI16+xDY/WznpeoE7nZHifj/luV+t8mryxjNBdox4u/ad
         r8Yq3PK87taTRxvaWQxVpaCouM3H+lW9ZzGsuON6GoR9CZnilQkstLkgA4fCUULQJWyY
         GUwOiKBvEb1wU3OeHIJdqGkd+ITSOptTcASBf3mHbXyDgSnLxs28N7eemEzJRkoreLFB
         DuMP+hTEaJbQONDLv/Bo+T7rQwPOWM2sjnxnxq1JWsRiUTilpRPujNSMnv+Ki9aN4nmU
         FxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414028; x=1703018828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63FW+3XX5/e8zea7VCMPF1eNiMssQ00z9r2TQiyi8pA=;
        b=b+wAZT21bIfwKOR2rL1d+aZt36U9VnlbaFMN988xnSHGJi+l2uIcbFsHOsO/NcYB3i
         2gfunpL1ixetm+Z2c+t4qGdVQYmEr4YOM/+NOaYwb305x1fkD326WroGsEdiOCVV8Ugj
         /5roSRcUj+33/93Z+amQnFjSOdDurIeDFg5aELHJezfy0wOyRORaTZBo98NybiqyGF5R
         8ZvQJJFa/gVU1PTF1Fptu5YEzl4RGCWbX7w0WrbgzjVw7kmPCrPvxTBgiVuO8mgRE16P
         iekAp7GMatxmTJrTNgdEugZrsz5oL5ezR5aliu6YrzHCEGz9FFbB+Y/sQ5JdRD7qNQTM
         gHFg==
X-Gm-Message-State: AOJu0YzUvWpPwJofMJcLATYdIrBa6yhBSeMg8i1bGY1h2IUeeiMMhxpv
        JYxY9OUhDTpvpLjOu9kle2hKys8aag==
X-Google-Smtp-Source: AGHT+IH6ncVDoAW1Mu0I8+yN+N2a6MAdsdDn6tV65AJTStVCqp2NOxk5JgLw7Qu1wnmKPp61ATAwmDH9Kg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:e74e:b0:1d0:820a:cf0d with SMTP id
 p14-20020a170902e74e00b001d0820acf0dmr51718plf.6.1702414028261; Tue, 12 Dec
 2023 12:47:08 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:46:21 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-7-sagis@google.com>
Subject: [RFC PATCH v5 06/29] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org,
        Ackerley Tng <ackerleytng@google.com>,
        Ryan Afranji <afranji@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Roger Wang <runanwang@google.com>,
        Vipin Sharma <vipinsh@google.com>, jmattson@google.com,
        dmatlack@google.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ackerley Tng <ackerleytng@google.com>

This also exercises the KVM_TDX_CAPABILITIES ioctl.

Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 69 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
index 9b69c733ce01..6b995c3f6153 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -27,10 +27,9 @@ static char *tdx_cmd_str[] = {
 };
 #define TDX_MAX_CMD_STR (ARRAY_SIZE(tdx_cmd_str))
 
-static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+static int _tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
 {
 	struct kvm_tdx_cmd tdx_cmd;
-	int r;
 
 	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
 		    ioctl_no);
@@ -40,11 +39,58 @@ static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
 	tdx_cmd.flags = flags;
 	tdx_cmd.data = (uint64_t)data;
 
-	r = ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+	return ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+}
+
+static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+{
+	int r;
+
+	r = _tdx_ioctl(fd, ioctl_no, flags, data);
 	TEST_ASSERT(r == 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
 		    errno);
 }
 
+static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
+{
+	int i;
+	int rc = -1;
+	int nr_cpuid_configs = 4;
+	struct kvm_tdx_capabilities *tdx_cap = NULL;
+
+	do {
+		nr_cpuid_configs *= 2;
+
+		tdx_cap = realloc(
+			tdx_cap, sizeof(*tdx_cap) +
+			nr_cpuid_configs * sizeof(*tdx_cap->cpuid_configs));
+		TEST_ASSERT(tdx_cap != NULL,
+			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n",
+			    nr_cpuid_configs);
+
+		tdx_cap->nr_cpuid_configs = nr_cpuid_configs;
+		rc = _tdx_ioctl(vm->fd, KVM_TDX_CAPABILITIES, 0, tdx_cap);
+	} while (rc < 0 && errno == E2BIG);
+
+	TEST_ASSERT(rc == 0, "KVM_TDX_CAPABILITIES failed: %d %d",
+		    rc, errno);
+
+	pr_debug("tdx_cap: attrs: fixed0 0x%016llx fixed1 0x%016llx\n"
+		 "tdx_cap: xfam fixed0 0x%016llx fixed1 0x%016llx\n",
+		 tdx_cap->attrs_fixed0, tdx_cap->attrs_fixed1,
+		 tdx_cap->xfam_fixed0, tdx_cap->xfam_fixed1);
+
+	for (i = 0; i < tdx_cap->nr_cpuid_configs; i++) {
+		const struct kvm_tdx_cpuid_config *config =
+			&tdx_cap->cpuid_configs[i];
+		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x eax 0x%08x ebx 0x%08x ecx 0x%08x edx 0x%08x\n",
+			 i, config->leaf, config->sub_leaf,
+			 config->eax, config->ebx, config->ecx, config->edx);
+	}
+
+	return tdx_cap;
+}
+
 #define XFEATURE_MASK_CET (XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL)
 
 static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
@@ -78,6 +124,21 @@ static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
 	}
 }
 
+static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	/* TDX spec: any bits 0 in attrs_fixed0 must be 0 in attributes */
+	TEST_ASSERT_EQ(attributes & ~tdx_cap->attrs_fixed0, 0);
+
+	/* TDX spec: any bits 1 in attrs_fixed1 must be 1 in attributes */
+	TEST_ASSERT_EQ(attributes & tdx_cap->attrs_fixed1, tdx_cap->attrs_fixed1);
+
+	free(tdx_cap);
+}
+
 static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
 {
 	const struct kvm_cpuid2 *cpuid;
@@ -91,6 +152,8 @@ static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
 	memset(init_vm, 0, sizeof(*init_vm));
 	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
 
+	tdx_check_attributes(vm, attributes);
+
 	init_vm->attributes = attributes;
 
 	tdx_apply_cpuid_restrictions(&init_vm->cpuid);
-- 
2.43.0.472.g3155946c3a-goog

