Return-Path: <linux-kernel+bounces-82186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C408868062
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFE81C24B99
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D5130E40;
	Mon, 26 Feb 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzENHL8t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1611C12FB13
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974234; cv=none; b=lMy9XOfuX78NZt9N5+zaJqCzrhHLJKGIKMb+jX4cwyvRSdGFL9YWcArD/XgoLxVBIqo/xziyMH2xMHir3GwWsEdUQWb0YbO25kc0hvz/VfCIMM0SCIuZC9zexzu29jPssQnFSuR0oMM4emFwVaahvh94znLxI39EiKn4UtqrvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974234; c=relaxed/simple;
	bh=ueogXMXjMx+FUzyBfdkqvsoWA/QpQjXs4+C7r2E26+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpIv8DD3NEntiCgrKhnk6//nQZWj/GdsgUKz3cNiSP+phqjsWJ1AzbVBWmxHaKU6pa98Gtlr0LTIBRkfNOZrhZnPoXvFtIXvukHdi9Ao3oldndcRFLgpPcGZEyDQoextMzJmSoln9pEmda4PigocTufwdqQGTBaUjq8NmftNu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JzENHL8t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708974230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36QbKVn/TBWqPf7/5XAMBk40KvDkqfCaZzPS8LUR4Ho=;
	b=JzENHL8tdJK8hydg+cG/g6lua0CRCZFWzQrA4tszNd2BSvb7mopDz48WcJIyWBH/2w3ftZ
	9gcXhzfuO/7oCseZybzaU1oihiCQuSLPqD04bWpK2gwEMOLCrFAQVPnuuWH564RZpMaZWq
	4WVpmmQVNrY9LtG650RN8rcl/MPZkN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-HX_Ofk9gNO6QkBWHpEkLkg-1; Mon, 26 Feb 2024 14:03:48 -0500
X-MC-Unique: HX_Ofk9gNO6QkBWHpEkLkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F115B8352A9;
	Mon, 26 Feb 2024 19:03:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CADEC401A77C;
	Mon, 26 Feb 2024 19:03:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	aik@amd.com
Subject: [PATCH v3 11/15] KVM: x86: Add supported_vm_types to kvm_caps
Date: Mon, 26 Feb 2024 14:03:40 -0500
Message-Id: <20240226190344.787149-12-pbonzini@redhat.com>
In-Reply-To: <20240226190344.787149-1-pbonzini@redhat.com>
References: <20240226190344.787149-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

This simplifies the implementation of KVM_CHECK_EXTENSION(KVM_CAP_VM_TYPES),
and also allows the vendor module to specify which VM types are supported.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 12 ++++++------
 arch/x86/kvm/x86.h |  2 ++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9d91eb1b3080..3b87e65904ae 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -94,6 +94,7 @@
 
 struct kvm_caps kvm_caps __read_mostly = {
 	.supported_mce_cap = MCG_CTL_P | MCG_SER_P,
+	.supported_vm_types = BIT(KVM_X86_DEFAULT_VM),
 };
 EXPORT_SYMBOL_GPL(kvm_caps);
 
@@ -4578,9 +4579,7 @@ static int kvm_ioctl_get_supported_hv_cpuid(struct kvm_vcpu *vcpu,
 
 static bool kvm_is_vm_type_supported(unsigned long type)
 {
-	return type == KVM_X86_DEFAULT_VM ||
-	       (type == KVM_X86_SW_PROTECTED_VM &&
-		IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) && tdp_mmu_enabled);
+	return type < 32 && (kvm_caps.supported_vm_types & BIT(type));
 }
 
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
@@ -4781,9 +4780,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = kvm_caps.has_notify_vmexit;
 		break;
 	case KVM_CAP_VM_TYPES:
-		r = BIT(KVM_X86_DEFAULT_VM);
-		if (kvm_is_vm_type_supported(KVM_X86_SW_PROTECTED_VM))
-			r |= BIT(KVM_X86_SW_PROTECTED_VM);
+		r = kvm_caps.supported_vm_types;
 		break;
 	default:
 		break;
@@ -9790,6 +9787,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 
 	kvm_register_perf_callbacks(ops->handle_intel_pt_intr);
 
+	if (IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) && tdp_mmu_enabled)
+		kvm_caps.supported_vm_types |= BIT(KVM_X86_SW_PROTECTED_VM);
+
 	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
 		kvm_caps.supported_xss = 0;
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 2f7e19166658..997017d35f3a 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -24,6 +24,8 @@ struct kvm_caps {
 	bool has_bus_lock_exit;
 	/* notify VM exit supported? */
 	bool has_notify_vmexit;
+	/* bit mask of VM types */
+	u32 supported_vm_types;
 
 	u64 supported_mce_cap;
 	u64 supported_xcr0;
-- 
2.39.1



