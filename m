Return-Path: <linux-kernel+bounces-148816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C438A87BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD121B217D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5437014882C;
	Wed, 17 Apr 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrbcM825"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBD146D59
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368098; cv=none; b=gZdGZNQusM9ds4TG3LvhOVv63x8/65qPwly7AU+4ZNE9LJjFzGjahLB+xH5VjOZLL2rF9o7uF9OUkgsJ9uETVJsaE6A58FI+UgYogCTS+apC+WZm0Z6GBmePHofI5SjV9HIodep19w2BsxzKKIJtdvX+r4NdCa8asgziXsGGstk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368098; c=relaxed/simple;
	bh=L7GanalmRhcS5JLx9XE1Hz67smUvUszxA2GzyAUJq7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGtr/z1fr/lmTWIBRhVa7e3B5ByJLSYEuzmq4uyEnMGs00RGvw0tyiVbnZfP1tH8Ic5s37jh+2qT9p9Yu96mODxbGfRKExlX2trG7oFO284vlceo4aiVpin7VOsmOTxNQ4C+KqAcJikCiTZ9bapZMr6XkDTcrkLaeb1PyrI6oBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrbcM825; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713368095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaDHxUBbyM9NAtjyjLLo4Vwi1b0JqYRQ5feEYlXA/BY=;
	b=VrbcM825gLzTedBll045Wlyld4G+n/sp/n+4oM5kf+UW+v7dEia51uQsXN6pL/Htwu3MIb
	1KO2KrG++Ifqg2Y2nbHcYuhaiG0Nh187/jt0FnrqWM2p0XBlBcb1X7RDE2p/68IRdbalur
	HBRGwdFdZFtUaHPfPb8A/9p6N0hYtIk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-sJ5cafnoOg2dSl8G-rl8Iw-1; Wed, 17 Apr 2024 11:34:52 -0400
X-MC-Unique: sJ5cafnoOg2dSl8G-rl8Iw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA193802A6F;
	Wed, 17 Apr 2024 15:34:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A1C0581CD;
	Wed, 17 Apr 2024 15:34:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 2/7] KVM: Add KVM_MAP_MEMORY vcpu ioctl to pre-populate guest memory
Date: Wed, 17 Apr 2024 11:34:45 -0400
Message-ID: <20240417153450.3608097-3-pbonzini@redhat.com>
In-Reply-To: <20240417153450.3608097-1-pbonzini@redhat.com>
References: <20240417153450.3608097-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

From: Isaku Yamahata <isaku.yamahata@intel.com>

Add a new ioctl KVM_MAP_MEMORY in the KVM common code. It iterates on the
memory range and calls the arch-specific function.  Add stub arch function
as a weak symbol.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Message-ID: <819322b8f25971f2b9933bfa4506e618508ad782.1712785629.git.isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h |  5 ++++
 include/uapi/linux/kvm.h | 10 +++++++
 virt/kvm/Kconfig         |  3 ++
 virt/kvm/kvm_main.c      | 61 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 8dea11701ab2..2b0f0240a64c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2478,4 +2478,9 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages
 void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 #endif
 
+#ifdef CONFIG_KVM_GENERIC_MAP_MEMORY
+int kvm_arch_vcpu_map_memory(struct kvm_vcpu *vcpu,
+			     struct kvm_map_memory *mapping);
+#endif
+
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2190adbe3002..4d233f44c613 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -917,6 +917,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_MEMORY_ATTRIBUTES 233
 #define KVM_CAP_GUEST_MEMFD 234
 #define KVM_CAP_VM_TYPES 235
+#define KVM_CAP_MAP_MEMORY 236
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1548,4 +1549,13 @@ struct kvm_create_guest_memfd {
 	__u64 reserved[6];
 };
 
+#define KVM_MAP_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_map_memory)
+
+struct kvm_map_memory {
+	__u64 base_address;
+	__u64 size;
+	__u64 flags;
+	__u64 padding[5];
+};
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 754c6c923427..1b94126622e8 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -67,6 +67,9 @@ config HAVE_KVM_INVALID_WAKEUPS
 config KVM_GENERIC_DIRTYLOG_READ_PROTECT
        bool
 
+config KVM_GENERIC_MAP_MEMORY
+       bool
+
 config KVM_COMPAT
        def_bool y
        depends on KVM && COMPAT && !(S390 || ARM64 || RISCV)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 38b498669ef9..350ead98e9a6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4379,6 +4379,47 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 	return fd;
 }
 
+#ifdef CONFIG_KVM_GENERIC_MAP_MEMORY
+static int kvm_vcpu_map_memory(struct kvm_vcpu *vcpu,
+			       struct kvm_map_memory *mapping)
+{
+	int idx, r;
+	u64 full_size;
+
+	if (mapping->flags)
+		return -EINVAL;
+
+	if (!PAGE_ALIGNED(mapping->base_address) ||
+	    !PAGE_ALIGNED(mapping->size) ||
+	    mapping->base_address + mapping->size <= mapping->base_address)
+		return -EINVAL;
+
+	vcpu_load(vcpu);
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+	r = 0;
+	full_size = mapping->size;
+	while (mapping->size) {
+		if (signal_pending(current)) {
+			r = -EINTR;
+			break;
+		}
+
+		r = kvm_arch_vcpu_map_memory(vcpu, mapping);
+		if (r)
+			break;
+
+		cond_resched();
+	}
+
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	vcpu_put(vcpu);
+
+	/* Return success if at least one page was mapped successfully.  */
+	return full_size == mapping->size ? r : 0;
+}
+#endif
+
 static long kvm_vcpu_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -4580,6 +4621,20 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = kvm_vcpu_ioctl_get_stats_fd(vcpu);
 		break;
 	}
+#ifdef CONFIG_KVM_GENERIC_MAP_MEMORY
+	case KVM_MAP_MEMORY: {
+		struct kvm_map_memory mapping;
+
+		r = -EFAULT;
+		if (copy_from_user(&mapping, argp, sizeof(mapping)))
+			break;
+		r = kvm_vcpu_map_memory(vcpu, &mapping);
+		/* Pass back leftover range. */
+		if (copy_to_user(argp, &mapping, sizeof(mapping)))
+			r = -EFAULT;
+		break;
+	}
+#endif
 	default:
 		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
 	}
@@ -4863,6 +4918,12 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #ifdef CONFIG_KVM_PRIVATE_MEM
 	case KVM_CAP_GUEST_MEMFD:
 		return !kvm || kvm_arch_has_private_mem(kvm);
+#endif
+#ifdef CONFIG_KVM_GENERIC_MAP_MEMORY
+	case KVM_CAP_MAP_MEMORY:
+		if (!kvm)
+			return 1;
+		/* Leave per-VM implementation to kvm_vm_ioctl_check_extension().  */
 #endif
 	default:
 		break;
-- 
2.43.0



