Return-Path: <linux-kernel+bounces-84196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F31586A3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279B3B2ECA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5B25C5FD;
	Tue, 27 Feb 2024 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI77K5qT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0765730D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076070; cv=none; b=gfta8FVBU7BWHWjxClNQie0rBWpNPgT4BC1BlezUY3mJehb+5uXsMZVRNA0UjJKA4U0MUWX3Z5lrc+xz9L4D14Jd7YIxeChkEvNyUKUAhqqs4VbBBNt5es5dHk70K6fK7NFjKxcC0pYvCzW5MyPVMfLjy8YYZUKs6sAzJPSO+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076070; c=relaxed/simple;
	bh=Xq5uW8rV6TjUmWfHQZGYhVIIKq7qjLsZpre/vZqpxPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SV0DInOIdw7J2hpFhOeVvBzSwepN84B0W9STw73jIP6AxiKfzsuFRhr8ngsYOm/dLZE/DV+hOZwsoWYs/feevXDpR1GpQiI4IvVZV5cGzHQhqDLTckArLwR9X6oUTzRWriQCRTZUkl2rw1Gwn7m22rSxXK0ZPGJNLMaP1R/zeJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EI77K5qT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709076067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yP7FPgxDoOexDyh5Qexk3wyBa3Ras1Oco07sQANBHZ8=;
	b=EI77K5qTX/gjlepU0gG1dXINjOycFYVLmDW7e+7nuEMZoQFnoR/RyYO48SnkP+6pTrCyKQ
	lKMaEA0B8NyZW/sB93aVJ1IbPLJHb3pRrupbi/l8QcfNXsTwi+KgF8exNYvY2u/PauxPYb
	k9sL4TEZoy7MVABOTiqQFzWEOFe3OEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Kcs_drJBNwKwcbEvDnCKLA-1; Tue, 27 Feb 2024 18:21:03 -0500
X-MC-Unique: Kcs_drJBNwKwcbEvDnCKLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50E2F185A783;
	Tue, 27 Feb 2024 23:21:03 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F102C040F7;
	Tue, 27 Feb 2024 23:21:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	isaku.yamahata@intel.com,
	thomas.lendacky@amd.com,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 10/21] KVM: SEV: Use a VMSA physical address variable for populating VMCB
Date: Tue, 27 Feb 2024 18:20:49 -0500
Message-Id: <20240227232100.478238-11-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Tom Lendacky <thomas.lendacky@amd.com>

In preparation to support SEV-SNP AP Creation, use a variable that holds
the VMSA physical address rather than converting the virtual address.
This will allow SEV-SNP AP Creation to set the new physical address that
will be used should the vCPU reset path be taken.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Message-Id: <20231230172351.574091-26-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 3 +--
 arch/x86/kvm/svm/svm.c | 9 ++++++++-
 arch/x86/kvm/svm/svm.h | 1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a9e2fcf494a2..2bde1ad6bcfd 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3094,8 +3094,7 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm)
 	 * the VMSA will be NULL if this vCPU is the destination for intrahost
 	 * migration, and will be copied later.
 	 */
-	if (svm->sev_es.vmsa)
-		svm->vmcb->control.vmsa_pa = __pa(svm->sev_es.vmsa);
+	svm->vmcb->control.vmsa_pa = svm->sev_es.vmsa_pa;
 
 	/* Can't intercept CR register access, HV can't modify CR registers */
 	svm_clr_intercept(svm, INTERCEPT_CR0_READ);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f4a750426b24..8893975826f1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1459,9 +1459,16 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
 	svm_switch_vmcb(svm, &svm->vmcb01);
 
-	if (vmsa_page)
+	if (vmsa_page) {
 		svm->sev_es.vmsa = page_address(vmsa_page);
 
+		/*
+		 * Do not include the encryption mask on the VMSA physical
+		 * address since hardware will access it using the guest key.
+		 */
+		svm->sev_es.vmsa_pa = __pa(svm->sev_es.vmsa);
+	}
+
 	svm->guest_state_loaded = false;
 
 	return 0;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7a921acc534f..1812fd61ea56 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -198,6 +198,7 @@ struct vcpu_sev_es_state {
 	struct ghcb *ghcb;
 	u8 valid_bitmap[16];
 	struct kvm_host_map ghcb_map;
+	hpa_t vmsa_pa;
 	bool received_first_sipi;
 
 	/* SEV-ES scratch area support */
-- 
2.39.0



