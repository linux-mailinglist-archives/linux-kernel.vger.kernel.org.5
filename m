Return-Path: <linux-kernel+bounces-84194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C786A381
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608841C244D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9FB58AC2;
	Tue, 27 Feb 2024 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpdvJxly"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AFE56770
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076069; cv=none; b=abbDFWYogLW6xTHFIimtF0wk5Nk5+RwqVB3G9GZAQKjiBPcvZmZA0FvYgmULMKIOdP75uOns0auHhcOuNjDTLTah5XfcYNzijfY6Cv4PzdVp5BAA5cyejTMyYMjYsr1ES7uQD5qzEbfcaA1pulIKtyeYsVxxAXdomZ9E43zNL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076069; c=relaxed/simple;
	bh=XlBHQCx38FmjrBgVP6Ygy/SYcOptxbkzc1vEBf1yB7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWv2Vbd9Q0mGTH2/cBhfI+RMgU2+L6uBr4Y5AKu6UbmNDz04TdFDG/NOY3cKywoQG5YeosQe9wH70LISTWPz0Z92OOiACMOipkGplEEvaL5mOVori8GNcpblLWCRHcexnn+de3fCpQ7R9dyram2TR/ZqlF+MrnkKIEyiobD0wOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZpdvJxly; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709076066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/QZpYnHKmC6EaCs8qnJViZdKIgg6hIom6qRkEq0CiA=;
	b=ZpdvJxlyIIGgXouCcxJ1Q41YrNMWyvCc2F7CLl5zb7lytWvbFahhrZuhzILoJD+cYrx8jz
	D/GwTSRfu3DkIJAoaZ4KYGsw30H6+0hJVKqdHclwfF3dPForNDxOW1L6UiPOR48AC8mMU0
	u35Nk+3KuOuSiiBOV0UB+kaa8BNzJf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-DTRdOqsDOA6v9f-G87o9KQ-1; Tue, 27 Feb 2024 18:21:01 -0500
X-MC-Unique: DTRdOqsDOA6v9f-G87o9KQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AA9A85A58C;
	Tue, 27 Feb 2024 23:21:01 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E2E0842283;
	Tue, 27 Feb 2024 23:21:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	isaku.yamahata@intel.com,
	thomas.lendacky@amd.com
Subject: [PATCH 01/21] KVM: x86: Split core of hypercall emulation to helper function
Date: Tue, 27 Feb 2024 18:20:40 -0500
Message-Id: <20240227232100.478238-2-pbonzini@redhat.com>
In-Reply-To: <20240227232100.478238-1-pbonzini@redhat.com>
References: <20240227232100.478238-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

From: Sean Christopherson <seanjc@google.com>

By necessity, TDX will use a different register ABI for hypercalls.
Break out the core functionality so that it may be reused for TDX.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Message-Id: <5134caa55ac3dec33fb2addb5545b52b3b52db02.1705965635.git.isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  4 +++
 arch/x86/kvm/x86.c              | 56 ++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 724a0c778f79..85dc0f7d09e3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2133,6 +2133,10 @@ static inline void kvm_clear_apicv_inhibit(struct kvm *kvm,
 	kvm_set_or_clear_apicv_inhibit(kvm, reason, false);
 }
 
+unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
+				      unsigned long a0, unsigned long a1,
+				      unsigned long a2, unsigned long a3,
+				      int op_64_bit, int cpl);
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
 
 int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b9dfe3179332..f10a5a617120 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10046,26 +10046,15 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
-int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
+unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
+				      unsigned long a0, unsigned long a1,
+				      unsigned long a2, unsigned long a3,
+				      int op_64_bit, int cpl)
 {
-	unsigned long nr, a0, a1, a2, a3, ret;
-	int op_64_bit;
-
-	if (kvm_xen_hypercall_enabled(vcpu->kvm))
-		return kvm_xen_hypercall(vcpu);
-
-	if (kvm_hv_hypercall_enabled(vcpu))
-		return kvm_hv_hypercall(vcpu);
-
-	nr = kvm_rax_read(vcpu);
-	a0 = kvm_rbx_read(vcpu);
-	a1 = kvm_rcx_read(vcpu);
-	a2 = kvm_rdx_read(vcpu);
-	a3 = kvm_rsi_read(vcpu);
+	unsigned long ret;
 
 	trace_kvm_hypercall(nr, a0, a1, a2, a3);
 
-	op_64_bit = is_64_bit_hypercall(vcpu);
 	if (!op_64_bit) {
 		nr &= 0xFFFFFFFF;
 		a0 &= 0xFFFFFFFF;
@@ -10074,7 +10063,7 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 		a3 &= 0xFFFFFFFF;
 	}
 
-	if (static_call(kvm_x86_get_cpl)(vcpu) != 0) {
+	if (cpl) {
 		ret = -KVM_EPERM;
 		goto out;
 	}
@@ -10135,18 +10124,49 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 
 		WARN_ON_ONCE(vcpu->run->hypercall.flags & KVM_EXIT_HYPERCALL_MBZ);
 		vcpu->arch.complete_userspace_io = complete_hypercall_exit;
+		/* stat is incremented on completion. */
 		return 0;
 	}
 	default:
 		ret = -KVM_ENOSYS;
 		break;
 	}
+
 out:
+	++vcpu->stat.hypercalls;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__kvm_emulate_hypercall);
+
+int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
+{
+	unsigned long nr, a0, a1, a2, a3, ret;
+	int op_64_bit;
+	int cpl;
+
+	if (kvm_xen_hypercall_enabled(vcpu->kvm))
+		return kvm_xen_hypercall(vcpu);
+
+	if (kvm_hv_hypercall_enabled(vcpu))
+		return kvm_hv_hypercall(vcpu);
+
+	nr = kvm_rax_read(vcpu);
+	a0 = kvm_rbx_read(vcpu);
+	a1 = kvm_rcx_read(vcpu);
+	a2 = kvm_rdx_read(vcpu);
+	a3 = kvm_rsi_read(vcpu);
+	op_64_bit = is_64_bit_hypercall(vcpu);
+	cpl = static_call(kvm_x86_get_cpl)(vcpu);
+
+	ret = __kvm_emulate_hypercall(vcpu, nr, a0, a1, a2, a3, op_64_bit, cpl);
+	if (nr == KVM_HC_MAP_GPA_RANGE && !ret)
+		/* MAP_GPA tosses the request to the user space. */
+		return 0;
+
 	if (!op_64_bit)
 		ret = (u32)ret;
 	kvm_rax_write(vcpu, ret);
 
-	++vcpu->stat.hypercalls;
 	return kvm_skip_emulated_instruction(vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_hypercall);
-- 
2.39.0



