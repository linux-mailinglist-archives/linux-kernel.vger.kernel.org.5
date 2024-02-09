Return-Path: <linux-kernel+bounces-59817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F6E84FC1B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F842845D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484D12AADA;
	Fri,  9 Feb 2024 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX9kSoB5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB0823AA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503874; cv=none; b=JEhyVlnU2/8lSXMcqrNf8yYXhScdvIO7gosErQFRPqScqjRXI8sz5NYwPxfAHE1zQ3WFXA4l/TTPRfzseQLMOnlH7AyhqVPGSFrGdqMXJ3poTdYsxucJdNW7Nj7SfpAIW9J7MO014eVNUKVri2Pg4Mw74zLW4I8ZC3u22nbJE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503874; c=relaxed/simple;
	bh=PzAxlB8XQojjeTv5NkAo89/w447OO0774KDS41PsIfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYKPs0gz75aaGoSsz7pqOj98rpXRTsCudLtck3Vm/26aNeSygmlUtVme4YqVPrKILPQRy982Ls9B1gqx/rwokW6vBonOPg/ZinyHgRfyMOuAWhZCkDKfJVQOEgDEgc8UKQYVZwvpDFJPBHtRZq+gxFu+wiyXkQjIvJIQVDDQwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eX9kSoB5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707503870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SahA0ruwv7SwB+EbvMU7EpLJXosjckZBZUDsYpgF0Wc=;
	b=eX9kSoB5eZNoJr1H8mb28dCHH/oJHRdihXaV2hdyr2esUTW7OzRG7HANtLShXRlaVrD5kb
	KJB8+d85Gb8QnqUddG8H/ffrWTzchCVY9LVmRB9yKAGHaricBpxwhUtQ9BLOZfdjiIwo/m
	snZbSB79rkOcQ/rrWgdgMXXnOpBTBQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-lKeR37rVMNaD_o3QyGQqNA-1; Fri, 09 Feb 2024 13:37:46 -0500
X-MC-Unique: lKeR37rVMNaD_o3QyGQqNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39EF5185A784;
	Fri,  9 Feb 2024 18:37:46 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0A4232166B33;
	Fri,  9 Feb 2024 18:37:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	aik@amd.com,
	isaku.yamahata@intel.com
Subject: [PATCH 10/10] selftests: kvm: add tests for KVM_SEV_INIT2
Date: Fri,  9 Feb 2024 13:37:42 -0500
Message-Id: <20240209183743.22030-11-pbonzini@redhat.com>
In-Reply-To: <20240209183743.22030-1-pbonzini@redhat.com>
References: <20240209183743.22030-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/kvm_util_base.h     |   6 +-
 .../selftests/kvm/set_memory_region_test.c    |   8 +-
 .../selftests/kvm/x86_64/sev_init2_tests.c    | 147 ++++++++++++++++++
 4 files changed, 154 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_init2_tests.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 492e937fab00..a81a89b1dc2a 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -116,6 +116,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_caps_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
+TEST_GEN_PROGS_x86_64 += x86_64/sev_init2_tests
 TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
 TEST_GEN_PROGS_x86_64 += x86_64/amx_test
 TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 9e5afc472c14..44b6ea56a205 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -846,17 +846,15 @@ static inline struct kvm_vm *vm_create_barebones(void)
 	return ____vm_create(VM_SHAPE_DEFAULT);
 }
 
-#ifdef __x86_64__
-static inline struct kvm_vm *vm_create_barebones_protected_vm(void)
+static inline struct kvm_vm *vm_create_barebones_type(unsigned long type)
 {
 	const struct vm_shape shape = {
 		.mode = VM_MODE_DEFAULT,
-		.type = KVM_X86_SW_PROTECTED_VM,
+		.type = type,
 	};
 
 	return ____vm_create(shape);
 }
-#endif
 
 static inline struct kvm_vm *vm_create(uint32_t nr_runnable_vcpus)
 {
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 075b80dbe237..0ac6c21d7251 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -339,7 +339,7 @@ static void test_invalid_memory_region_flags(void)
 
 #ifdef __x86_64__
 	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
-		vm = vm_create_barebones_protected_vm();
+		vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
 	else
 #endif
 		vm = vm_create_barebones();
@@ -452,7 +452,7 @@ static void test_add_private_memory_region(void)
 
 	pr_info("Testing ADD of KVM_MEM_GUEST_MEMFD memory regions\n");
 
-	vm = vm_create_barebones_protected_vm();
+	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
 
 	test_invalid_guest_memfd(vm, vm->kvm_fd, 0, "KVM fd should fail");
 	test_invalid_guest_memfd(vm, vm->fd, 0, "VM's fd should fail");
@@ -461,7 +461,7 @@ static void test_add_private_memory_region(void)
 	test_invalid_guest_memfd(vm, memfd, 0, "Regular memfd() should fail");
 	close(memfd);
 
-	vm2 = vm_create_barebones_protected_vm();
+	vm2 = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
 	memfd = vm_create_guest_memfd(vm2, MEM_REGION_SIZE, 0);
 	test_invalid_guest_memfd(vm, memfd, 0, "Other VM's guest_memfd() should fail");
 
@@ -489,7 +489,7 @@ static void test_add_overlapping_private_memory_regions(void)
 
 	pr_info("Testing ADD of overlapping KVM_MEM_GUEST_MEMFD memory regions\n");
 
-	vm = vm_create_barebones_protected_vm();
+	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
 
 	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 4, 0);
 
diff --git a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
new file mode 100644
index 000000000000..639863978405
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kvm.h>
+#include <linux/psp-sev.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <pthread.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "kselftest.h"
+
+#define SVM_SEV_FEAT_DEBUG_SWAP 32u
+
+/*
+ * Some features may have hidden dependencies, or may only work
+ * for certain VM types.  Err on the side of safety and don't
+ * expect that all supported features can be passed one by one
+ * to KVM_SEV_INIT2.
+ *
+ * (Well, right now there's only one...)
+ */
+#define KNOWN_FEATURES SVM_SEV_FEAT_DEBUG_SWAP
+
+int kvm_fd;
+u64 supported_features;
+bool have_sev_es;
+
+static int __sev_ioctl(int vm_fd, int cmd_id, void *data)
+{
+	struct kvm_sev_cmd cmd = {
+		.id = cmd_id,
+		.data = (uint64_t)data,
+		.sev_fd = open_sev_dev_path_or_exit(),
+	};
+	int ret;
+
+	ret = ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
+	TEST_ASSERT(ret < 0 || cmd.error == SEV_RET_SUCCESS,
+		    "%d failed: fw error: %d\n",
+		    cmd_id, cmd.error);
+
+	return ret;
+}
+
+static void test_init2(unsigned long vm_type, struct kvm_sev_init *init)
+{
+	struct kvm_vm *vm;
+	int ret;
+
+	vm = vm_create_barebones_type(vm_type);
+	ret = __sev_ioctl(vm->fd, KVM_SEV_INIT2, init);
+	TEST_ASSERT(ret == 0,
+		    "KVM_SEV_INIT2 return code is %d (expected 0), errno: %d",
+		    ret, errno);
+	kvm_vm_free(vm);
+}
+
+static void test_init2_invalid(unsigned long vm_type, struct kvm_sev_init *init)
+{
+	struct kvm_vm *vm;
+	int ret;
+
+	vm = vm_create_barebones_type(vm_type);
+	ret = __sev_ioctl(vm->fd, KVM_SEV_INIT2, init);
+	TEST_ASSERT(ret == -1 && errno == EINVAL,
+		    "KVM_SEV_INIT2 return code %d, errno: %d (expected EINVAL)",
+		    ret, errno);
+	kvm_vm_free(vm);
+}
+
+void test_vm_types(void)
+{
+	test_init2(KVM_X86_SEV_VM, &(struct kvm_sev_init){});
+
+	if (have_sev_es)
+		test_init2(KVM_X86_SEV_ES_VM, &(struct kvm_sev_init){});
+	else
+		test_init2_invalid(KVM_X86_SEV_ES_VM, &(struct kvm_sev_init){});
+
+	test_init2_invalid(0, &(struct kvm_sev_init){});
+	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))
+		test_init2_invalid(KVM_X86_SW_PROTECTED_VM, &(struct kvm_sev_init){});
+}
+
+void test_flags(uint32_t vm_type)
+{
+	int i;
+
+	for (i = 0; i < 32; i++)
+		test_init2_invalid(vm_type, &(struct kvm_sev_init){
+			.flags = 1u << i,
+		});
+}
+
+void test_features(uint32_t vm_type)
+{
+	int i;
+
+	for (i = 0; i < 64; i++) {
+		if (!(supported_features & (1u << i)))
+			test_init2_invalid(vm_type, &(struct kvm_sev_init){
+				.vm_type = vm_type,
+				.vmsa_features = 1u << i,
+			});
+		else if (KNOWN_FEATURES & (1u << i))
+			test_init2(vm_type, &(struct kvm_sev_init){
+				.vmsa_features = 1u << i,
+			});
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int kvm_fd = open_kvm_dev_path_or_exit();
+	bool have_sev;
+
+	TEST_REQUIRE(__kvm_has_device_attr(kvm_fd, 0, KVM_X86_SEV_VMSA_FEATURES) == 0);
+	kvm_device_attr_get(kvm_fd, 0, KVM_X86_SEV_VMSA_FEATURES, &supported_features );
+
+	have_sev = kvm_cpu_has(X86_FEATURE_SEV);
+	TEST_ASSERT(have_sev == !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM)),
+		    "sev: KVM_CAP_VM_TYPES (%x) does not match cpuid (checking %x)",
+		    kvm_check_cap(KVM_CAP_VM_TYPES), 1 << KVM_X86_SEV_VM);
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM));
+	have_sev_es = kvm_cpu_has(X86_FEATURE_SEV_ES);
+
+	TEST_ASSERT(have_sev_es == !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_ES_VM)),
+		    "sev-es: KVM_CAP_VM_TYPES (%x) does not match cpuid (checking %x)",
+		    kvm_check_cap(KVM_CAP_VM_TYPES), 1 << KVM_X86_SEV_ES_VM);
+
+	test_vm_types();
+
+	test_flags(KVM_X86_SEV_VM);
+	if (have_sev_es)
+		test_flags(KVM_X86_SEV_ES_VM);
+
+	test_features(KVM_X86_SEV_VM);
+	if (have_sev_es)
+		test_features(KVM_X86_SEV_ES_VM);
+
+	return 0;
+}
-- 
2.39.0



