Return-Path: <linux-kernel+bounces-68932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA19685820F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2AF1F23A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015C612FB28;
	Fri, 16 Feb 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HJaT5BWS"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF112F588
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099203; cv=none; b=fcO5BckyvR8pUZWqA5oLqpA66JA4IiZ8GD3aPpWocr27TI3gPEZqwg+LkKIhcl7NQpsP6kFWH+V6ixDYECx3DgAe4w1cdfNRkrWjOO5hsj5qg14wRD9AtUvqRo/zmuP7cr9lRLZa+ZwgOhz1MOwTyihV3bLiOf/KeDVk7ci0ZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099203; c=relaxed/simple;
	bh=WBW4bGvns6QMpjKS4b4uKVjwK41RvyqpoB5X0RlniAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5yslsQPvcc23N3q3WxHkshnH0T0DSMNImTGm7XJ5xY6aXMjAusfk1eXLrTxafsyP1M4YoVexgUmbW1a3l+GrsUMH+8xAsUiFS/veS/OX+UPtMb8ppNWd20JHt8agT/hU5NSs4aZhnnGxtFKbnm+kBOm3m288x0fvE9SS/+jBDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJaT5BWS; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708099199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Gmt3BZeS8RFm72X8X8sJg3/SSmmSkJFO1q6nTV3Suo=;
	b=HJaT5BWS4uxFC6UFeVy4nov0HxfRiVDg9bNe5LZ0a3KwXko3RYLdUg1GNNAml18SbfPs+/
	gtkxdGq5pZ1pqrZPBN/puEMYAhm2RHO71RmUhlriBMq+Hy/5a9BDI65VGOgKmLqYLWDvkP
	xWLCC0GZQbLkbnUKZ5z8fkXpOrIsAyk=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvm@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>,
	Sebastian Ene <sebastianene@google.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH] KVM: Get rid of return value from kvm_arch_create_vm_debugfs()
Date: Fri, 16 Feb 2024 15:59:41 +0000
Message-ID: <20240216155941.2029458-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The general expectation with debugfs is that any initialization failure
is nonfatal. Nevertheless, kvm_arch_create_vm_debugfs() allows
implementations to return an error and kvm_create_vm_debugfs() allows
that to fail VM creation.

Change to a void return to discourage architectures from making debugfs
failures fatal for the VM. Seems like everyone already had the right
idea, as all implementations already return 0 unconditionally.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---

Compile-tested on arm64, powerpc, and x86 since I don't trust myself to
even get this simple patch right.

 arch/powerpc/kvm/powerpc.c | 3 +--
 arch/x86/kvm/debugfs.c     | 3 +--
 include/linux/kvm_host.h   | 2 +-
 virt/kvm/kvm_main.c        | 8 ++------
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 23407fbd73c9..d32abe7fe6ab 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -2538,9 +2538,8 @@ void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_
 		vcpu->kvm->arch.kvm_ops->create_vcpu_debugfs(vcpu, debugfs_dentry);
 }
 
-int kvm_arch_create_vm_debugfs(struct kvm *kvm)
+void kvm_arch_create_vm_debugfs(struct kvm *kvm)
 {
 	if (kvm->arch.kvm_ops->create_vm_debugfs)
 		kvm->arch.kvm_ops->create_vm_debugfs(kvm);
-	return 0;
 }
diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 95ea1a1f7403..999227fc7c66 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -189,9 +189,8 @@ static const struct file_operations mmu_rmaps_stat_fops = {
 	.release	= kvm_mmu_rmaps_stat_release,
 };
 
-int kvm_arch_create_vm_debugfs(struct kvm *kvm)
+void kvm_arch_create_vm_debugfs(struct kvm *kvm)
 {
 	debugfs_create_file("mmu_rmaps_stat", 0644, kvm->debugfs_dentry, kvm,
 			    &mmu_rmaps_stat_fops);
-	return 0;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7e7fd25b09b3..9a45f673f687 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1507,7 +1507,7 @@ bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int kvm_arch_post_init_vm(struct kvm *kvm);
 void kvm_arch_pre_destroy_vm(struct kvm *kvm);
-int kvm_arch_create_vm_debugfs(struct kvm *kvm);
+void kvm_arch_create_vm_debugfs(struct kvm *kvm);
 
 #ifndef __KVM_HAVE_ARCH_VM_ALLOC
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 10bfc88a69f7..c681149c382a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1150,10 +1150,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
 				    &stat_fops_per_vm);
 	}
 
-	ret = kvm_arch_create_vm_debugfs(kvm);
-	if (ret)
-		goto out_err;
-
+	kvm_arch_create_vm_debugfs(kvm);
 	return 0;
 out_err:
 	kvm_destroy_vm_debugfs(kvm);
@@ -1183,9 +1180,8 @@ void __weak kvm_arch_pre_destroy_vm(struct kvm *kvm)
  * Cleanup should be automatic done in kvm_destroy_vm_debugfs() recursively, so
  * a per-arch destroy interface is not needed.
  */
-int __weak kvm_arch_create_vm_debugfs(struct kvm *kvm)
+void __weak kvm_arch_create_vm_debugfs(struct kvm *kvm)
 {
-	return 0;
 }
 
 static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.44.0.rc0.258.g7320e95886-goog


