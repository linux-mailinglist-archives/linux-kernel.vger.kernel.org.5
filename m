Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056580F80F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377208AbjLLUqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjLLUqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:46:53 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F83BC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:00 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d3376c1c83so5305305ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414019; x=1703018819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNdApJhYNj7CgDTo7NNKspnxbte38oVK+sy/EZvIraM=;
        b=N94F31B3bIZLtNWdfrDSo5htih+Hoe3JRgnTjzbaAwRIDTfLpJAFgNE/T9Jer0/hkF
         ju7eCQ4LABrzkPtc+eNyhaa/lBI15nag9szWsemTSnXtr5rluizdTTT1g8iowN8DQ3yS
         xtx74XlfkGJU5sijJeGGCUmLW9e+2/kksPfLU8HP/mS7gm1rwEKo8oRGhYWxydqM5SYO
         qjDGWEJxgZsC4JPDqqVBvoQbibi0xXNccMkV1L0FpQTQOUE1rtMiDpBiRaafHOhdqpPH
         vhquKXN9fQbdcQnnkQJp3TfbhvBgDAG5NcvqjweoUuUGUK4nHY/Sk0d6eXDnyMTZF4Hf
         jyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414019; x=1703018819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNdApJhYNj7CgDTo7NNKspnxbte38oVK+sy/EZvIraM=;
        b=Z/HCdOrRKbhmGWhOpknNrADXa6vSodlkwFcWzYlSHvZ20gz5uHWMJh2nHM/0Hzc0kS
         GQUe0tSJ/oPwvcXpVuP2o5XaJmkeWiKNbadN47KQYoxh0gGpA0Y4q3Y5R37GHEbK31DC
         92gJ9eBgsdu0VZbCFpJ51IJ3hBGHr71iU4hNggMiyWd5Dw9F+7cGqr+5GfCSG3xkwoUx
         ys0MWyTbw4sG/Cqo93U1DVBgvFhkvqq+/0an1QLgUhlImZY08Aa0qnunZ+T/QSDrsb7x
         /sTz+d4SqzNNEFw/RuLPu4uNTtAGWpsLO9Go+kUj7XB1MNz3DmHCpIQQGwt+ICJXT/yz
         6vvQ==
X-Gm-Message-State: AOJu0YyePvGnC97Y7qUABBE7UWWQ1IChWey8S6BA9MybZzaH+oy4RGxu
        4/mm193JXEwnJpA5gWTiVTzqOHpTqA==
X-Google-Smtp-Source: AGHT+IFZJwJRZcoWgNgtpTbykf4LZtBAxjnj8x3+a2qkplSA1n0mJv6jcJdIXWysboMlPxbmymXIpA//uQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:db09:b0:1d0:8fff:cd75 with SMTP id
 m9-20020a170902db0900b001d08fffcd75mr51402plx.10.1702414019454; Tue, 12 Dec
 2023 12:46:59 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:46:16 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-2-sagis@google.com>
Subject: [RFC PATCH v5 01/29] KVM: selftests: Add function to allow one-to-one
 GVA to GPA mappings
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

One-to-one GVA to GPA mappings can be used in the guest to set up boot
sequences during which paging is enabled, hence requiring a transition
from using physical to virtual addresses in consecutive instructions.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 63 ++++++++++++++++---
 2 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 1426e88ebdc7..c2e5c5f25dfc 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -564,6 +564,8 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			    enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz,
+			       vm_vaddr_t vaddr_min, uint32_t data_memslot);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
 				 enum kvm_mem_region_type type);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index febc63d7a46b..4f1ae0f1eef0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1388,17 +1388,37 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
 	return pgidx_start * vm->page_size;
 }
 
+/*
+ * VM Virtual Address Allocate Shared/Encrypted
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   sz - Size in bytes
+ *   vaddr_min - Minimum starting virtual address
+ *   paddr_min - Minimum starting physical address
+ *   data_memslot - memslot number to allocate in
+ *   encrypt - Whether the region should be handled as encrypted
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Starting guest virtual address
+ *
+ * Allocates at least sz bytes within the virtual address space of the vm
+ * given by vm.  The allocated bytes are mapped to a virtual address >=
+ * the address given by vaddr_min.  Note that each allocation uses a
+ * a unique set of pages, with the minimum real allocation being at least
+ * a page.
+ */
 static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
-				     vm_vaddr_t vaddr_min,
-				     enum kvm_mem_region_type type,
-				     bool encrypt)
+				     vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
+				     uint32_t data_memslot, bool encrypt)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages,
-					      KVM_UTIL_MIN_PFN * vm->page_size,
-					      vm->memslots[type], encrypt);
+	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages, paddr_min,
+					       data_memslot, encrypt);
 
 	/*
 	 * Find an unused range of virtual page addresses of at least
@@ -1408,8 +1428,7 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
 
 	/* Map the virtual pages. */
 	for (vm_vaddr_t vaddr = vaddr_start; pages > 0;
-		pages--, vaddr += vm->page_size, paddr += vm->page_size) {
-
+	     pages--, vaddr += vm->page_size, paddr += vm->page_size) {
 		virt_pg_map(vm, vaddr, paddr);
 
 		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
@@ -1421,12 +1440,16 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
 vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			    enum kvm_mem_region_type type)
 {
-	return ____vm_vaddr_alloc(vm, sz, vaddr_min, type, vm->protected);
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min,
+				  KVM_UTIL_MIN_PFN * vm->page_size,
+				  vm->memslots[type], vm->protected);
 }
 
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 {
-	return ____vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA, false);
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min,
+				  KVM_UTIL_MIN_PFN * vm->page_size,
+				  vm->memslots[MEM_REGION_TEST_DATA], false);
 }
 
 /*
@@ -1453,6 +1476,26 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 	return __vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA);
 }
 
+/**
+ * Allocate memory in @vm of size @sz in memslot with id @data_memslot,
+ * beginning with the desired address of @vaddr_min.
+ *
+ * If there isn't enough memory at @vaddr_min, find the next possible address
+ * that can meet the requested size in the given memslot.
+ *
+ * Return the address where the memory is allocated.
+ */
+vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz,
+			       vm_vaddr_t vaddr_min, uint32_t data_memslot)
+{
+	vm_vaddr_t gva = ____vm_vaddr_alloc(vm, sz, vaddr_min,
+					    (vm_paddr_t)vaddr_min, data_memslot,
+					    vm->protected);
+	TEST_ASSERT_EQ(gva, addr_gva2gpa(vm, gva));
+
+	return gva;
+}
+
 /*
  * VM Virtual Address Allocate Pages
  *
-- 
2.43.0.472.g3155946c3a-goog

