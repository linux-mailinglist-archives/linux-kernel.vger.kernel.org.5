Return-Path: <linux-kernel+bounces-82192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B69D868075
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 240ECB2670F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81C0132C31;
	Mon, 26 Feb 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WF9n+k84"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2C12FF8C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974236; cv=none; b=MnYOD5P9fHlPOxhKMKdSt3kv0sYMmmj25Jgts84aavvQkkxgTbfrWiC4bKfb2DkieF+UDlabs5HOZPcE+TlPuI8Z9ZBiOLPL8Sl2bk/dVVR80QOT1SgYiKMKcZ6xgNioz1bI2eOlRVAx7lze/z7ogesEOUkqzau4ot928br50oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974236; c=relaxed/simple;
	bh=xRuYJawEF4kvHSjkADqCRreS8rILKCdjMjmSYx1/tFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YerVleh2Mm7Y9H1yC/TitjOsLFVT5nfJnmu7Qp08TXzowVsOTD+6WnXaE1l4VMjFHIxWSYFsrKrYKU4n09+BsSglEX446XxTiE+hClITp0142/3CDv+E0v8YdG1AePfe2ZZaaDGEgq+BFYvuvuBNJPQf8qcvmgM0dI0eEB4Ort4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WF9n+k84; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708974231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cUZ/D/2UiLjM9T2gYRl36gTxhVW4aQM4GLnpybbj2E=;
	b=WF9n+k84Hh5+g72tA1YYHSGpGqBoa4bl0OFA3HGksjljdctEEdPt1wNc2ZuxmnC4qQgHEX
	JKmWuZr6eK2UEbYrpO53kLf1nRCmrJT6tiDKQVdxtyxGm0IRR6fKJ8HRLTI1NMdCbjhWCW
	6VPEk1ymH/8Z2LAdUTNpELmzY3itM5w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615--VDt4PPOM7C11CRlyBtIbA-1; Mon, 26 Feb 2024 14:03:46 -0500
X-MC-Unique: -VDt4PPOM7C11CRlyBtIbA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44AD1185A783;
	Mon, 26 Feb 2024 19:03:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C098492BC6;
	Mon, 26 Feb 2024 19:03:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	aik@amd.com
Subject: [PATCH v3 03/15] KVM: SVM: Invert handling of SEV and SEV_ES feature flags
Date: Mon, 26 Feb 2024 14:03:32 -0500
Message-Id: <20240226190344.787149-4-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Sean Christopherson <seanjc@google.com>

Leave SEV and SEV_ES '0' in kvm_cpu_caps by default, and instead set them
in sev_set_cpu_caps() if SEV and SEV-ES support are fully enabled.  Aside
from the fact that sev_set_cpu_caps() is wildly misleading when it *clears*
capabilities, this will allow compiling out sev.c without falsely
advertising SEV/SEV-ES support in KVM_GET_SUPPORTED_CPUID.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/cpuid.c   | 2 +-
 arch/x86/kvm/svm/sev.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adba49afb5fe..bde4df13a7e8 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -761,7 +761,7 @@ void kvm_set_cpu_caps(void)
 	kvm_cpu_cap_mask(CPUID_8000_000A_EDX, 0);
 
 	kvm_cpu_cap_mask(CPUID_8000_001F_EAX,
-		0 /* SME */ | F(SEV) | 0 /* VM_PAGE_FLUSH */ | F(SEV_ES) |
+		0 /* SME */ | 0 /* SEV */ | 0 /* VM_PAGE_FLUSH */ | 0 /* SEV_ES */ |
 		F(SME_COHERENT));
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f06f9e51ad9d..aec3453fd73c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2178,10 +2178,10 @@ void sev_vm_destroy(struct kvm *kvm)
 
 void __init sev_set_cpu_caps(void)
 {
-	if (!sev_enabled)
-		kvm_cpu_cap_clear(X86_FEATURE_SEV);
-	if (!sev_es_enabled)
-		kvm_cpu_cap_clear(X86_FEATURE_SEV_ES);
+	if (sev_enabled)
+		kvm_cpu_cap_set(X86_FEATURE_SEV);
+	if (sev_es_enabled)
+		kvm_cpu_cap_set(X86_FEATURE_SEV_ES);
 }
 
 void __init sev_hardware_setup(void)
-- 
2.39.1



