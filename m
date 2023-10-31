Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07EB7DC38B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbjJaAU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjJaAU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:20:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B79E1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:20:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03ef6fc30so4796275276.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698711653; x=1699316453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBv8J2j2tFrn/qyS6YAMefYGNMpKBA+EnJ/tz9XeZcQ=;
        b=DutbvxFdNj+zxFsXIApxuqgL/svtHFE4X/w9rnzDlctDS5aEKYBHsMFuGsD2ppEan5
         YFMqvnCKG53Rlybn98y5q77a5MpuTtAucEPhIo7eNk2V2+s7EPAj4EjoZBsxjiDA1Wgp
         wZyw9LMd2L4yUILKkMIJFH/1f1+Ais7lSpK/pUNwe4B9tfDfsTc1jUYuMaYPzxVg7ODU
         Iwvs+PMW6VidbEzn0tHKXJ+viUEAs8xkSYidMx8TdObaEwuzsWe2YmDYf0JxpwIfdben
         DccNkbIfGdDwrnq3qLloMhx6T6yKHqGXtqh+AZmjyqVu2zal4Z5Kh2E43uC+4/vEsslQ
         BfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698711653; x=1699316453;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBv8J2j2tFrn/qyS6YAMefYGNMpKBA+EnJ/tz9XeZcQ=;
        b=nLuhsRI71Fwn5AW2bQ19XKfg/QpZCo8wntd9hCGJ5FmleXsp9CeXqc9p/Vysw97ach
         TV1q0igbepDTJYTgm22M56lO3XAEnmRvgoCqGwPBlmiMsJx46XfX7VysZVhK+4YdWSRx
         /Gm+BasJ/cgopIHPgb9IteMPcpivHcmhvAoPUVSHIUWvXWRncLmcszAflM1ZWOfheXax
         NKobiENmsm/rdmSv0bZAibTERwQzm91sjWyMFC6jmBiI1zccZK/zXXd6xe9zi0b2Ly9p
         ionPqc/bGJQQ1WaICDNbIPBeTGvX3ar444WCALjs+XejYAaHR8HWeGUmCyg88EZVHWmE
         WQwA==
X-Gm-Message-State: AOJu0Yw+zn6moSM6kXiph54oSSzPEE3l42lamLOwd98ivXfBqaWpoeAw
        9eFZ0gY4+VcoWZcHllDBW6QESiR3ka0=
X-Google-Smtp-Source: AGHT+IHDrosN2uCkEGjbekhzE56kmIuP6ZdJ4qX5BxhY2UQvH9WBnwhhS/T43sOArnZ3ZTMzAD09hmalB/w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:168c:b0:da0:3e46:8ba5 with SMTP id
 bx12-20020a056902168c00b00da03e468ba5mr205460ybb.8.1698711652929; Mon, 30 Oct
 2023 17:20:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 30 Oct 2023 17:20:49 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031002049.3915752-1-seanjc@google.com>
Subject: [PATCH guest_memfd] KVM: selftests: Add a memory region subtest to
 validate invalid flags
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a subtest to set_memory_region_test to verify that KVM rejects invalid
flags and combinations with -EINVAL.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Selftest that *tries* to detect cases where KVM allows v2 flags for
KVM_SET_USER_MEMORY_REGION.  It's kinda worthless because KVM will likely fail
with EINVAL anyways, but maybe it'll provide meaningful coverage in concert
with a sanitizer?

 .../selftests/kvm/set_memory_region_test.c    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index ca83e3307a98..268baf853bd6 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -326,6 +326,53 @@ static void test_zero_memory_regions(void)
 }
 #endif /* __x86_64__ */
 
+static void test_invalid_memory_region_flags(void)
+{
+	uint32_t supported_flags = KVM_MEM_LOG_DIRTY_PAGES;
+	const uint32_t v2_only_flags = KVM_MEM_PRIVATE;
+	struct kvm_vm *vm;
+	int r, i;
+
+#ifdef __x86_64__
+	supported_flags |= KVM_MEM_READONLY;
+
+	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
+		vm = vm_create_barebones_protected_vm();
+	else
+#endif
+		vm = vm_create_barebones();
+
+	if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) & KVM_MEMORY_ATTRIBUTE_PRIVATE)
+		supported_flags |= KVM_MEM_PRIVATE;
+
+	for (i = 0; i < 32; i++) {
+		if ((supported_flags & BIT(i)) && !(v2_only_flags & BIT(i)))
+			continue;
+
+		r = __vm_set_user_memory_region(vm, MEM_REGION_SLOT, BIT(i),
+						MEM_REGION_GPA, MEM_REGION_SIZE, NULL);
+
+		TEST_ASSERT(r && errno == EINVAL,
+			    "KVM_SET_USER_MEMORY_REGION should have failed on v2 only flag 0x%lx", BIT(i));
+
+		if (supported_flags & BIT(i))
+			continue;
+
+		r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, BIT(i),
+						 MEM_REGION_GPA, MEM_REGION_SIZE, NULL, 0, 0);
+		TEST_ASSERT(r && errno == EINVAL,
+			    "KVM_SET_USER_MEMORY_REGION2 should have failed on unsupported flag 0x%lx", BIT(i));
+	}
+
+	if (supported_flags & KVM_MEM_PRIVATE) {
+		r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT,
+						 KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_PRIVATE,
+						 MEM_REGION_GPA, MEM_REGION_SIZE, NULL, 0, 0);
+		TEST_ASSERT(r && errno == EINVAL,
+			    "KVM_SET_USER_MEMORY_REGION2 should have failed, dirty logging private memory is unsupported");
+	}
+}
+
 /*
  * Test it can be added memory slots up to KVM_CAP_NR_MEMSLOTS, then any
  * tentative to add further slots should fail.
@@ -491,6 +538,8 @@ int main(int argc, char *argv[])
 	test_zero_memory_regions();
 #endif
 
+	test_invalid_memory_region_flags();
+
 	test_add_max_memory_regions();
 
 	if (kvm_has_cap(KVM_CAP_GUEST_MEMFD) &&

base-commit: 881375a408c0f4ea451ff14545b59216d2923881
-- 
2.42.0.820.g83a721a137-goog

