Return-Path: <linux-kernel+bounces-136993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFECF89DADB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F245C1C2084B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AA513791C;
	Tue,  9 Apr 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AL0rE1gW"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1A1304AA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670021; cv=none; b=O6MaJaFUW0htwCDJrinVKNbMRTbO2LnYyS8++HrntiVkUO1j8ZikG19LApBImERcHgnEUJNaKWsf51M4A+h+k8hrrzX7ofELYWa6rB3gNmkH2JQmWUpN/selV5FoFzA9UkJSozVt0thVs6F5ClAZ6UgJG0s1KqMutNCJo/+ID3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670021; c=relaxed/simple;
	bh=paK0j1D+/4vVrfYgv/m+fGb5solSOT1yZOlYXM1gTkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VmxinbUYRWdMsjaPc4KZptzJXUW93Up+aLbao7vrIGaFnTAaaA5nHmpXPm3WbxhiTExfJmnXw41Jq/pysua7DZAtjGP+ATTxZAc7zxKtlmD0I4dkCsfXLeTJyH8fFJ0PFslAj07/xZoKsv6EDCsa2kvBBaQb+cr8De93qDiVHjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AL0rE1gW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ea7f05b543so4063482b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712670019; x=1713274819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rwrtfku1Uu6YgtFtash50js52tGuCTfI0w7dy74ELNU=;
        b=AL0rE1gWHYaH68MkMLgTco+uRHEFDHWY/+tKYuYvexHoqnIp3HUAse9levCqTxKfg3
         Ii9G8eO87b+3/qq/HPoQh4PwpiMKLmIhtyjNfsOx18d+KhIHBemZDBDUB6u9FtsbvWpF
         7l3sGydrd2dyNqmfHEj2R820qOAYYE6ePnqGdbWJnkwK8D73x9JaGOJ38iCSptksJ37G
         y5q2DwXxqauCebI4KyfatEZ6DhexLrL4Q0lFS1KxDCwo2StAhMJ8WiIrFjN/eajDCFYs
         mGCOR0Y84M6jY5GVvf+1rXfkge4bM/DGHabn66YZqno00Dv+C4OtrVD9uKBsGrbOnV0w
         jkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670019; x=1713274819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rwrtfku1Uu6YgtFtash50js52tGuCTfI0w7dy74ELNU=;
        b=jTXnEuzcGrXABDFcIdMRPA1nvRshnKMJ1sWgHzfH1plIVd6N8B28o/FVOae9VVdfSm
         lhhk7EmxQCBCp9XvJKHTaB8Ff6bjEKXw/a/ZT6QPPcOZlXWMdPEVBAOJKJZyWxIMpNzM
         bIs+k+QKw0jjH5rrcEPE5XhgA39Pgdxf8c8E+UF/CU53x6jnkIPZPhBRppjLmkFoi5dk
         iy3QWTQdv26lAZuP3DiKSa1j/4g1CPlEAa/4oZmBtYVYvowdx7/vzZ89hro/xs5y/8nL
         XT02BeCVjP7ksv2Zli0A5Ub4cgKXsDBkkrywbENLIN+65eMz3Pn1B0BuUJ50W0lZ3fu9
         An/A==
X-Gm-Message-State: AOJu0YzYFyQbHK9SPPuZxJqo+uOY9jDfIJKTPVabKrr4LR1lyCljIlai
	ikkyS1L3SdbUrqmnjZrwOfwaVLzlYiUxHrIG8+zM5n1+CihrhiBbT/pnvs5NNoUJ/CsXQ9bJGOa
	3Vw==
X-Google-Smtp-Source: AGHT+IHGWLW0cSClhDE6jv9Wvo3dWLdAOoqhYvm4Qx6uK8Qb6rf86HX7B7bZpf8TC5EWjDFMARrLPq+8ZPg=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:661d:897e:ea86:704d])
 (user=pgonda job=sendgmr) by 2002:a05:6a00:998:b0:6ea:bc68:7354 with SMTP id
 u24-20020a056a00099800b006eabc687354mr1087840pfg.1.1712670019100; Tue, 09 Apr
 2024 06:40:19 -0700 (PDT)
Date: Tue,  9 Apr 2024 06:39:55 -0700
In-Reply-To: <20240409133959.2888018-1-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409133959.2888018-3-pgonda@google.com>
Subject: [PATCH 2/6] Add arch specific additional guest pages
From: Peter Gonda <pgonda@google.com>
To: pgonda@google.com, seanjc@google.com
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SEV-ES guests need additional pages allocated for their GHCBs. Add arch
specific function definition with __weak to allow for overriding for X86
specific SEV-ES functionality.

Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h        |  3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c       | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 4a40b332115d..9a26afd2e82a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -1126,4 +1126,7 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm);
 
 bool vm_is_gpa_protected(struct kvm_vm *vm, vm_paddr_t paddr);
 
+int kvm_arch_vm_additional_pages_required(struct vm_shape shape,
+					  uint64_t page_size);
+
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index adc51b0712ca..2a7b2709eb8d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -314,11 +314,11 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	return vm;
 }
 
-static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
+static uint64_t vm_nr_pages_required(struct vm_shape shape,
 				     uint32_t nr_runnable_vcpus,
 				     uint64_t extra_mem_pages)
 {
-	uint64_t page_size = vm_guest_mode_params[mode].page_size;
+	uint64_t page_size = vm_guest_mode_params[shape.mode].page_size;
 	uint64_t nr_pages;
 
 	TEST_ASSERT(nr_runnable_vcpus,
@@ -350,13 +350,15 @@ static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
 	/* Account for the number of pages needed by ucall. */
 	nr_pages += ucall_nr_pages_required(page_size);
 
-	return vm_adjust_num_guest_pages(mode, nr_pages);
+	nr_pages += kvm_arch_vm_additional_pages_required(shape, page_size);
+
+	return vm_adjust_num_guest_pages(shape.mode, nr_pages);
 }
 
 struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 			   uint64_t nr_extra_pages)
 {
-	uint64_t nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
+	uint64_t nr_pages = vm_nr_pages_required(shape, nr_runnable_vcpus,
 						 nr_extra_pages);
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
@@ -2246,6 +2248,12 @@ __weak void kvm_arch_vm_post_create(struct kvm_vm *vm)
 {
 }
 
+__weak int kvm_arch_vm_additional_pages_required(struct vm_shape shape,
+						 uint64_t page_size)
+{
+	return 0;
+}
+
 __weak void kvm_selftest_arch_init(void)
 {
 }
-- 
2.44.0.478.gd926399ef9-goog


