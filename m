Return-Path: <linux-kernel+bounces-84825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128B086AC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4152B21317
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD47352F85;
	Wed, 28 Feb 2024 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObDuppDF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711324F1F5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115529; cv=none; b=F2XlvcE0s8L528/q/1AgoCd26uxv49gg3ZmNsY9DJ45iHL7yXZzWR9StAez2KnVMi24yMD/au+oC4afC43kwqwmfMrTnrzWstFQwQV7CzNXIqtl0rqUfScTBObk6xUkBFjttYVIcKE004LTCfXAbx5KHKkwiRUwQzO0gfUmu5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115529; c=relaxed/simple;
	bh=AFrt1azRX6F6xoU8LmSGEkM6KPcieGDLWHZpLZFggGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0/PZjWmmcjhhNjqNVsMyEIjzXdvA5l4qtAoclcoKj3s9hhuYNXKDIGBnVCSdYYpsFri0kuXBLRLmOGCMVPtOefQ7tMtWq4iwcazFQGx8Ic9cuCDvbE4nHCrkIUOlyjq5a1Ch4+WSkPWpzfgPAZJWr6cSMf896C0XBqfOwsYWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObDuppDF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709115526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/5jpa1XgBVWLxk01sM9mNbfC1AL5hF7JpXXB/j4JUM=;
	b=ObDuppDFJnNffluS8ysPt/7xJe020OVhvQ166TLdXnkSgmDNMJImkSqnCbrqeJh9xlFX+1
	6e5Zt6WUzBzSvk4WUR4fx90siGWK5U+fJmHjLaDWQSVK9Rmm23pjggMF08vxvaLONpxF+b
	h8wK1VvNjCePp6vZKl+OanEjyfBT8TM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-W1AfAvOYOdWms_GIF-BClA-1; Wed, 28 Feb 2024 05:18:42 -0500
X-MC-Unique: W1AfAvOYOdWms_GIF-BClA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF6BA185A785;
	Wed, 28 Feb 2024 10:18:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C75E58177;
	Wed, 28 Feb 2024 10:18:40 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Li RongQing <lirongqing@baidu.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] KVM: x86: Use actual kvm_cpuid.base for clearing KVM_FEATURE_PV_UNHALT
Date: Wed, 28 Feb 2024 11:18:36 +0100
Message-ID: <20240228101837.93642-3-vkuznets@redhat.com>
In-Reply-To: <20240228101837.93642-1-vkuznets@redhat.com>
References: <20240228101837.93642-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Commit ee3a5f9e3d9b ("KVM: x86: Do runtime CPUID update before updating
vcpu->arch.cpuid_entries") moved tweaking of the supplied CPUID
data earlier in kvm_set_cpuid() but __kvm_update_cpuid_runtime() actually
uses 'vcpu->arch.kvm_cpuid' (though __kvm_find_kvm_cpuid_features()) which
gets set later in kvm_set_cpuid(). In some cases, e.g. when kvm_set_cpuid()
is called for the first time and 'vcpu->arch.kvm_cpuid' is clear,
__kvm_find_kvm_cpuid_features() fails to find KVM PV feature entry and the
logic which clears KVM_FEATURE_PV_UNHALT after enabling
KVM_X86_DISABLE_EXITS_HLT does not work.

The logic, introduced by the commit ee3a5f9e3d9b ("KVM: x86: Do runtime
CPUID update before updating vcpu->arch.cpuid_entries") must stay: the
supplied CPUID data is tweaked by KVM first (__kvm_update_cpuid_runtime())
and checked later (kvm_check_cpuid()) and the actual data
(vcpu->arch.cpuid_*, vcpu->arch.kvm_cpuid, vcpu->arch.xen.cpuid,..) is only
updated on success.

Switch to searching for KVM_SIGNATURE in the supplied CPUID data to
discover KVM PV feature entry instead of using stale 'vcpu->arch.kvm_cpuid'.

While on it, drop pointless "&& (best->eax & (1 << KVM_FEATURE_PV_UNHALT)"
check when clearing KVM_FEATURE_PV_UNHALT bit.

Fixes: ee3a5f9e3d9b ("KVM: x86: Do runtime CPUID update before updating vcpu->arch.cpuid_entries")
Reported-and-tested-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/cpuid.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0e1e3e5df6dd..bfc0bfcb2bc6 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -224,22 +224,22 @@ static struct kvm_hypervisor_cpuid kvm_get_hypervisor_cpuid(struct kvm_vcpu *vcp
 					  vcpu->arch.cpuid_nent, sig);
 }
 
-static struct kvm_cpuid_entry2 *__kvm_find_kvm_cpuid_features(struct kvm_vcpu *vcpu,
-					      struct kvm_cpuid_entry2 *entries, int nent)
+static struct kvm_cpuid_entry2 *__kvm_find_kvm_cpuid_features(struct kvm_cpuid_entry2 *entries,
+							      int nent, u32 kvm_cpuid_base)
 {
-	u32 base = vcpu->arch.kvm_cpuid.base;
-
-	if (!base)
-		return NULL;
-
-	return cpuid_entry2_find(entries, nent, base | KVM_CPUID_FEATURES,
+	return cpuid_entry2_find(entries, nent, kvm_cpuid_base | KVM_CPUID_FEATURES,
 				 KVM_CPUID_INDEX_NOT_SIGNIFICANT);
 }
 
 static struct kvm_cpuid_entry2 *kvm_find_kvm_cpuid_features(struct kvm_vcpu *vcpu)
 {
-	return __kvm_find_kvm_cpuid_features(vcpu, vcpu->arch.cpuid_entries,
-					     vcpu->arch.cpuid_nent);
+	u32 base = vcpu->arch.kvm_cpuid.base;
+
+	if (!base)
+		return NULL;
+
+	return __kvm_find_kvm_cpuid_features(vcpu->arch.cpuid_entries,
+					     vcpu->arch.cpuid_nent, base);
 }
 
 void kvm_update_pv_runtime(struct kvm_vcpu *vcpu)
@@ -273,6 +273,7 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
 				       int nent)
 {
 	struct kvm_cpuid_entry2 *best;
+	struct kvm_hypervisor_cpuid kvm_cpuid;
 
 	best = cpuid_entry2_find(entries, nent, 1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
 	if (best) {
@@ -299,10 +300,12 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
 		     cpuid_entry_has(best, X86_FEATURE_XSAVEC)))
 		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
 
-	best = __kvm_find_kvm_cpuid_features(vcpu, entries, nent);
-	if (kvm_hlt_in_guest(vcpu->kvm) && best &&
-		(best->eax & (1 << KVM_FEATURE_PV_UNHALT)))
-		best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);
+	kvm_cpuid = __kvm_get_hypervisor_cpuid(entries, nent, KVM_SIGNATURE);
+	if (kvm_cpuid.base) {
+		best = __kvm_find_kvm_cpuid_features(entries, nent, kvm_cpuid.base);
+		if (kvm_hlt_in_guest(vcpu->kvm) && best)
+			best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);
+	}
 
 	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT)) {
 		best = cpuid_entry2_find(entries, nent, 0x1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
-- 
2.43.0


