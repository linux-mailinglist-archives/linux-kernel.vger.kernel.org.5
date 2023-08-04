Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8E176F69E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjHDAnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjHDAnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:43:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E899D4696
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:42:36 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68701df1ac7so982976b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 17:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691109756; x=1691714556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2CsV9BMCbijce3IEX7syYt6oaSf9HBzVzUSeSJTTl/c=;
        b=DNaTTcvyymaqWv5JS/b+Ul58o6UASX5Gzy58D8OgNUL3QP3segv+8o1Nz+GizNekfv
         rFDM+9jgVrY2UJtz2kl/i/L6udW4AVtdgPGyAjht4ak4W3jUQVvvpj9GFbt2AV7cn4l+
         38Kkl5Ze1Wn9JzG07hlvDqExeNIGqBvSHZmT6nAMyQFB+uihzhtqKN/XrVFhOHZxwJoJ
         bJ97KvFNHowNRmq00dAMx7hg868GXdY6QdJJAIPSVa5n1tK2uB8ro5zAKxUnv0XJe787
         vRwGsDf3w10BvuLmfXZQHbQLUlzVsbY9ElYEmKScB7sxzF9olsQfyFnqpZRmKvxrB54P
         7c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691109756; x=1691714556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CsV9BMCbijce3IEX7syYt6oaSf9HBzVzUSeSJTTl/c=;
        b=hOU+BXM0lkzUQi4Pdiucw6LzFW88OqwNuGp7r53gnXsZtcbywWGv9FKvTysAH/qPWY
         Tw3B4V4+LSwn1g2jCqiQ1DiRBYuhVulpUXhupswozCu4UaaB1wUPUgbwl1LCA1PwANiE
         mXci6WRBvPVVUGdgY0dQlRmRlxDmJ7R8G8Ms/thsqiL1N0FlrIVA6DLgVoRikVMBWcYk
         4/VL99qvrwiGqSGWskOIiAeHl5VCaR6Ki6xzQtN9KQj6UJsWChl6GsdXQi4MIYSa+Sin
         IdF5+ZhinqEUaedI2N8m+vffne892toMWaAIl+IPHrHWhHYfFTI/RCZscopIKuGGIKIt
         bDtA==
X-Gm-Message-State: AOJu0YwlmzYZx32dDdSv1SngBRUqwh1qOf7YioXoCfQCHHCU68QsfsKB
        VadidMdZsL0o3kam8zxkfzPw0/S485g=
X-Google-Smtp-Source: AGHT+IGuCrgdNKO1/9Fk3u0Zo/Reh2Y3zb5ohylW7eg4Swp9EAXsJiPsGMrXKVJst+F5prtcttfq9x81VV0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:124c:b0:687:926f:e62f with SMTP id
 u12-20020a056a00124c00b00687926fe62fmr1573pfi.2.1691109756391; Thu, 03 Aug
 2023 17:42:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  3 Aug 2023 17:42:26 -0700
In-Reply-To: <20230804004226.1984505-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230804004226.1984505-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804004226.1984505-5-seanjc@google.com>
Subject: [PATCH 4/4] KVM: selftests: Add logic to detect if ioctl() failed
 because VM was killed
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add yet another macro to the VM/vCPU ioctl() framework to detect when an
ioctl() failed because KVM killed/bugged the VM, i.e. when there was
nothing wrong with the ioctl() itself.  If KVM kills a VM, e.g. by way of
a failed KVM_BUG_ON(), all subsequent VM and vCPU ioctl()s will fail with
-EIO, which can be quite misleading and ultimately waste user/developer
time.

Use KVM_CHECK_EXTENSION on KVM_CAP_USER_MEMORY to detect if the VM is
dead and/or bug, as KVM doesn't provide a dedicated ioctl().  Using a
heuristic is obviously less than ideal, but practically speaking the logic
is bulletproof barring a KVM change, and any such change would arguably
break userspace, e.g. if KVM returns something other than -EIO.

Without the detection, tearing down a bugged VM yields a cryptic failure
when deleting memslots:

  ==== Test Assertion Failure ====
  lib/kvm_util.c:689: !ret
  pid=45131 tid=45131 errno=5 - Input/output error
     1	0x00000000004036c3: __vm_mem_region_delete at kvm_util.c:689
     2	0x00000000004042f0: kvm_vm_free at kvm_util.c:724 (discriminator 12)
     3	0x0000000000402929: race_sync_regs at sync_regs_test.c:193
     4	0x0000000000401cab: main at sync_regs_test.c:334 (discriminator 6)
     5	0x0000000000416f13: __libc_start_call_main at libc-start.o:?
     6	0x000000000041855f: __libc_start_main_impl at ??:?
     7	0x0000000000401d40: _start at ??:?
  KVM_SET_USER_MEMORY_REGION failed, rc: -1 errno: 5 (Input/output error)

Which morphs into a more pointed error message with the detection:

  ==== Test Assertion Failure ====
  lib/kvm_util.c:689: false
  pid=80347 tid=80347 errno=5 - Input/output error
     1	0x00000000004039ab: __vm_mem_region_delete at kvm_util.c:689 (discriminator 5)
     2	0x0000000000404660: kvm_vm_free at kvm_util.c:724 (discriminator 12)
     3	0x0000000000402ac9: race_sync_regs at sync_regs_test.c:193
     4	0x0000000000401cb7: main at sync_regs_test.c:334 (discriminator 6)
     5	0x0000000000418263: __libc_start_call_main at libc-start.o:?
     6	0x00000000004198af: __libc_start_main_impl at ??:?
     7	0x0000000000401d90: _start at ??:?
  KVM killed/bugged the VM, check the kernel log for clues

Suggested-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 34 ++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index b35b0bd23683..49ad681d2161 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -269,18 +269,44 @@ static __always_inline void static_assert_is_vm(struct kvm_vm *vm) { }
 	kvm_do_ioctl((vm)->fd, cmd, arg);			\
 })
 
+/*
+ * Assert that a VM or vCPU ioctl() succeeded, with extra magic to detect if
+ * the ioctl() failed because KVM killed/bugged the VM.  To detect a dead VM,
+ * probe KVM_CAP_USER_MEMORY, which (a) has been supported by KVM since before
+ * selftests existed and (b) should never outright fail, i.e. is supposed to
+ * return 0 or 1.  If KVM kills a VM, KVM returns -EIO for all ioctl()s for the
+ * VM and its vCPUs, including KVM_CHECK_EXTENSION.
+ */
+#define TEST_ASSERT_VM_VCPU_IOCTL(cond, name, ret, vm)					\
+do {											\
+	int __errno = errno;								\
+											\
+	static_assert_is_vm(vm);							\
+											\
+	if (cond)									\
+		break;									\
+											\
+	if (errno == EIO &&								\
+	    __vm_ioctl(vm, KVM_CHECK_EXTENSION, (void *)KVM_CAP_USER_MEMORY) < 0) {	\
+		TEST_ASSERT(errno == EIO, "KVM killed the VM, should return -EIO");	\
+		TEST_FAIL("KVM killed/bugged the VM, check the kernel log for clues");	\
+	}										\
+	errno = __errno;								\
+	TEST_ASSERT(cond, __KVM_IOCTL_ERROR(name, ret));				\
+} while (0)
+
 #define vm_ioctl(vm, cmd, arg)					\
 ({								\
 	int ret = __vm_ioctl(vm, cmd, arg);			\
 								\
-	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(#cmd, ret));	\
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, vm);		\
 })
 
 #define vm_fd_ioctl(vm, cmd, arg)				\
 ({								\
 	int fd = __vm_ioctl(vm, cmd, arg);			\
 								\
-	TEST_ASSERT(fd >= 0, __KVM_IOCTL_ERROR(#cmd, fd));	\
+	TEST_ASSERT_VM_VCPU_IOCTL(fd >= 0, #cmd, fd, vm);	\
 	fd;							\
 })
 
@@ -296,14 +322,14 @@ static __always_inline void static_assert_is_vcpu(struct kvm_vcpu *vcpu) { }
 ({								\
 	int ret = __vcpu_ioctl(vcpu, cmd, arg);			\
 								\
-	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(#cmd, ret));	\
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, (vcpu)->vm);	\
 })
 
 #define vcpu_fd_ioctl(vcpu, cmd, arg)				\
 ({								\
 	int fd = __vcpu_ioctl(vcpu, cmd, arg);			\
 								\
-	TEST_ASSERT(fd >= 0, __KVM_IOCTL_ERROR(#cmd, fd));	\
+	TEST_ASSERT_VM_VCPU_IOCTL(fd >= 0, #cmd, fd, (vcpu)->vm);\
 	fd;							\
 })
 
-- 
2.41.0.585.gd2178a4bd4-goog

