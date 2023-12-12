Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA780F832
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377375AbjLLUsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjLLUr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:47:29 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084EC10F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:24 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2869cdac540so3534401a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414044; x=1703018844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOWQKACugG9g7cz1/AmBUQwWqXmyF/X6aVaYz3Y0fys=;
        b=xEsg+OcraIn1wXFiLbdcLlsvoQ7XrcnNSRujN/AX1yG2NSZwu0+sr2Ac3X6shM3EAg
         bl+rVA1HYCsXgLW2NxMMZ55Zo44UY/WcF7kMR9cGIL7NDf7/4dwfR1+ZH/m7WrVPyUaS
         voknZB+KcKzc21caD9XiY6nTY/iZFNWp/mySUHkSPZpvYOP4tPCPTyA4fY4XELLwjj4g
         /tC6TdM05yTeNd/Jujgq0g/v9lmbpd+/l8yHmyJxLcUY9TZ4JZo0OzbU7EmQM0iky9jh
         uSzsyYQxbQVazo21s5rstc1zQQcijjLX9HlP2kz5FRpkZa2iCzqT8N84TmjYCNJn5SGV
         qGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414044; x=1703018844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOWQKACugG9g7cz1/AmBUQwWqXmyF/X6aVaYz3Y0fys=;
        b=v3iU8RrYz1Ktk5EoazB3hbdpcKKXSlzQAmhNajGWNuAq96wM7GAHcVzlKesWKXDJqV
         /fLS+jaUvsggnAESa8/skzaiTHt+l4QZNDsHhuHO9EXmkKgIGtQV2BcuNbIcvw1vd+3O
         iMkCIWHV6rL/Lq/bacPXDPR7tzivQo8Rz9DZ27C0mwNgSKAxvVlNK1WNaOxL4FC9no/F
         Uxhb7tn2Y82kfYZ1L8KPDLEfJM5CgSZlSR3WrBRr/BnJrDBWBFHJmgsIMlj979xvk8zS
         nDBLHfpeQXcaOsQASXvFenRETGZUD6zfnQIBvJTS6mlqVCTtswaRvprW92m36BySjnbW
         iN7A==
X-Gm-Message-State: AOJu0Yw28WvVJ2TH7yKHOywpi2f9hkVrcYzIBl2zT8OaQvkJjyPYRkT3
        CDYsnTkU62B+PPEzmzaX45fmKrlb8Q==
X-Google-Smtp-Source: AGHT+IGLlrmxTENwZC6SGbM6jr4r7WDmCiJAWrdAa/8w6lr8saM6Dsnuvy2FguUg9MN6N/MAkqVuDY/IjA==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:903:32cb:b0:1d0:c3e7:d4c with SMTP id
 i11-20020a17090332cb00b001d0c3e70d4cmr53041plr.2.1702414044401; Tue, 12 Dec
 2023 12:47:24 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:46:29 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-15-sagis@google.com>
Subject: [RFC PATCH v5 14/29] KVM: selftests: TDX: Add TDX IO reads test
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

The test verifies IO reads of various sizes from the host to the guest.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index a2b3e1aef151..699cba36e9ce 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -429,6 +429,92 @@ void verify_guest_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_IO_READS_TEST_PORT 0x52
+
+/*
+ * Verifies IO functionality by reading values of different sizes
+ * from the host.
+ */
+void guest_io_reads(void)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 1,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0xAB)
+		tdx_test_fatal(1);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 2,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0xABCD)
+		tdx_test_fatal(2);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 4,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0xFFABCDEF)
+		tdx_test_fatal(4);
+
+	// Read an invalid number of bytes.
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 5,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_reads(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_io_reads);
+	td_finalize(vm);
+
+	printf("Verifying guest reads:\n");
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 1,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xAB;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 2,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xABCD;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xFFABCDEF;
+
+	td_vcpu_run(vcpu);
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -444,6 +530,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_cpuid);
 	run_in_new_process(&verify_get_td_vmcall_info);
 	run_in_new_process(&verify_guest_writes);
+	run_in_new_process(&verify_guest_reads);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog

