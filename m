Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8267EE010
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345110AbjKPLov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:44:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ECDB182
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:44:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F1E1595;
        Thu, 16 Nov 2023 03:45:30 -0800 (PST)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.214.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E26B3F6C4;
        Thu, 16 Nov 2023 03:44:39 -0800 (PST)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     maz@kernel.org, james.morse@arm.com, will@kernel.org
Cc:     rmk@armlinux.org.uk, salil.mehta@huawei.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        jianyong.wu@arm.com
Subject: [PATCH] arm64/kvm: Introduce feature extension for SMCCC filter
Date:   Thu, 16 Nov 2023 11:41:52 +0000
Message-Id: <20231116114152.912344-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

821d935c87b introduces support for userspace SMCCC filtering, but lack
of a way to tell userspace if we have this feature. Add a corresponding
feature extension can resolve this issue.

For example, the incoming feature Vcpu Hotplug needs the SMCCC filter.
As there is no way to check this feature, VMM will run into error when
it calls this feature on an old kernel. It's bad for backward compatible.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 Documentation/virt/kvm/api.rst | 3 ++-
 arch/arm64/kvm/arm.c           | 1 +
 include/uapi/linux/kvm.h       | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 7025b3751027..559c6c531bfd 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6395,7 +6395,8 @@ For arm64:
 ----------
 
 SMCCC exits can be enabled depending on the configuration of the SMCCC
-filter. See the Documentation/virt/kvm/devices/vm.rst
+filter. This feature can be only available if KVM_CAP_ARM_VM_SMCCC is
+upported. See the Documentation/virt/kvm/devices/vm.rst
 ``KVM_ARM_SMCCC_FILTER`` for more details.
 
 ``nr`` contains the function ID of the guest's SMCCC call. Userspace is
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e5f75f1f1085..44583da440ae 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -241,6 +241,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_SYSTEM_SUSPEND:
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_COUNTER_OFFSET:
+	case KVM_CAP_ARM_VM_SMCCC:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 211b86de35ac..e67fb1df508d 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1201,6 +1201,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
 #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
 #define KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES 230
+#define KVM_CAP_ARM_VM_SMCCC 231
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.34.1

