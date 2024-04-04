Return-Path: <linux-kernel+bounces-131377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3EF8986E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CE21F278F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AF127B69;
	Thu,  4 Apr 2024 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RW8ocvU5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A68528F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232815; cv=none; b=NCKXBK1KHEdKRbswaT6v2DJ8/ao7HmNxCWL7txzjL74aebuHDt7q6M8PhSXlCjLWnJbAnuefrHUVSAAbLa4Uhr4Ja1KOp2/OFvO4j2RFamvbqQrjbKpkaCQ7PnO4MOOSwlU/3XU6ibjv8UiVXWbs1ikjxwdp+RJkY4y77+K3xJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232815; c=relaxed/simple;
	bh=Oq0pmnhKqjL0PP9rp3fn5DQ2ICohIPxTiVNrDVZWnc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMVfyyhJ/f1UIjrLMT28jLOIQuHOSixyXI/VvVNY+uuj5/z+l3QaZspi79fFoRA5eDoPq0KNVd96cPCqpuNNBJ4PwJxbbLkvQCV7l5dRB5g3iQC/nsNMAH0HHn+hjK1V633v6eHjGbZRT9uFs7b3AUeZEAdx+yAgOyb7i0wGHy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RW8ocvU5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712232812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjdjYgvbojNeNWXf7qeq0JUWl1hYimGE6Mt2Wjy5ES4=;
	b=RW8ocvU5JxCe4vooJFFGbR+ZIGjjqKll7TNogZ7CPwT3cpDjun9apmMGkdEo/q4w4lrpUW
	qbmLznkyzUfBF/eUgMLS3ikHpD1XV31TfZh/H2wi2WgGneNyw9YFxy5ZJ5y3rwvYgr9FRu
	wRaMUxRPnw/DWKHcOpj2P/Mv0B6jwiA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-ScvGxuACOjmzz_i4PzBUlg-1; Thu,
 04 Apr 2024 08:13:29 -0400
X-MC-Unique: ScvGxuACOjmzz_i4PzBUlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DDEC1C05AB1;
	Thu,  4 Apr 2024 12:13:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 75B5E202451F;
	Thu,  4 Apr 2024 12:13:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: michael.roth@amd.com,
	isaku.yamahata@intel.com,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v5 01/17] KVM: SVM: Invert handling of SEV and SEV_ES feature flags
Date: Thu,  4 Apr 2024 08:13:11 -0400
Message-ID: <20240404121327.3107131-2-pbonzini@redhat.com>
In-Reply-To: <20240404121327.3107131-1-pbonzini@redhat.com>
References: <20240404121327.3107131-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Sean Christopherson <seanjc@google.com>

Leave SEV and SEV_ES '0' in kvm_cpu_caps by default, and instead set them
in sev_set_cpu_caps() if SEV and SEV-ES support are fully enabled.  Aside
from the fact that sev_set_cpu_caps() is wildly misleading when it *clears*
capabilities, this will allow compiling out sev.c without falsely
advertising SEV/SEV-ES support in KVM_GET_SUPPORTED_CPUID.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/cpuid.c   | 2 +-
 arch/x86/kvm/svm/sev.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index bfc0bfcb2bc6..51bd2197feed 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -771,7 +771,7 @@ void kvm_set_cpu_caps(void)
 	kvm_cpu_cap_mask(CPUID_8000_000A_EDX, 0);
 
 	kvm_cpu_cap_mask(CPUID_8000_001F_EAX,
-		0 /* SME */ | F(SEV) | 0 /* VM_PAGE_FLUSH */ | F(SEV_ES) |
+		0 /* SME */ | 0 /* SEV */ | 0 /* VM_PAGE_FLUSH */ | 0 /* SEV_ES */ |
 		F(SME_COHERENT));
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e5a4d9b0e79f..382c745b8ba9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2186,10 +2186,10 @@ void sev_vm_destroy(struct kvm *kvm)
 
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
2.43.0



