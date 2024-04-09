Return-Path: <linux-kernel+bounces-136996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F348D89DAE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE70128B6D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADDB1384A9;
	Tue,  9 Apr 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UngtIgYw"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F15137C5C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670028; cv=none; b=mAQMT1o8FigARnsoEviFEApYNJIZpudGOIkPKQRkrspDpibpUDpMjG9lkXsD177k2tM7Kvuakr5aQp5h73yFHVs0FehRcfVzit0WMSNRL++eEV/dVG+LUMPuAkp2ZGKYaQvICqR+UcOqJPN1249N0W2unddjc0cZu8tVqDWsrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670028; c=relaxed/simple;
	bh=kpn8QpUPjU41tHhs6YrXc4wG2KdMlh6dZl1b3/aCiUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BBxRnOQIfCmK/BVjZzHL7jE1rgnJFLfR9z5+Ugn1Xuv57BPsJ5ImBDAr42qfJ8BVlnYjTYxZywqRsG1QdJTgcLrXhhtwgJzIGqfRkRtL0KZTjt5FXms36f50xVDPJeFtCP1kK+sVVfQIg2YgLk6WiwX3WXe0e0K8KFrmm94QWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UngtIgYw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so8698475276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712670025; x=1713274825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=swALstFhx8te8uqCAXh0tcCwXkuPkv7dSWAmNCKm21A=;
        b=UngtIgYw0wF4NFXRe7703iGbL5qPBFykv0LyvqGwyv+OISk0UAYLPBVWWBX+uSIL7G
         AxLOqlGRY0DR47GimlXo+UQU7UzvoRjb6Ud8q0xMvUVDGkJPxq+4Nkv0mKZGeLpuz3y8
         kC5KvCQfWSiLdTF9kWQcSmPb7p38rYd+PEfS7Nossp10H85uSD67hZ/NFcWuhNIJQrmq
         KXqTiKy4JBCGxkICF2E8Oo5Tyh1ky/pUuy6IJU5NmthsdMBhowd75xAOO15eB+Rp3v6E
         K5myJN79TxgnOzM+BSK5cx1cSkCQkfIbzJ1FVBFWA/J25MYgxFmGeXqgTuiIZrXitzkB
         QeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670025; x=1713274825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swALstFhx8te8uqCAXh0tcCwXkuPkv7dSWAmNCKm21A=;
        b=WVHHV5NP+HwJdpfiJ+SpYEOznxBUFYMLgYL31PS+6dBeQI6TRPwSxoQWpMP9HMSw/o
         FyCYV91KGfU/unZ/gj3GoSZ5qjLKtF9QioP+VQ2qOjLTqrxJGMzUvKkQkLnw7XFdlDKl
         t8mc9jRUzU+tOggWvpyJEKZlpNJcd4RoFhaz6bkAy1EX5EqTkCnP1eFuSMxztkVvOhSM
         eURV/IOKXKSAYlUzmlDKcJX9T4WZY7dkawlEpd8RCPKbFEwb1yyu2SWdX7CWhfhOBxvq
         zFnoFl7yz+Q9CFSsmsCPjKVZ+KExRe72RKcK1hIYL0nazQDlqj7YN0rxM3z+XZMZhY6+
         23WA==
X-Gm-Message-State: AOJu0Yyyht3914yvjMycipLaQfHcoADI1r35KjsuJYPeBqoZbeqkJ6GU
	j6TsQd0FnAwUFwzT735esJYi/ppwq77weqVyrWZtHMT3gVG1PSGV8mz5XV0PEnt/aLZle32lD+d
	TlQ==
X-Google-Smtp-Source: AGHT+IHdPdBeuKCxc/8NwL15eUK2EBgdZgnDXUcGzBmxvL8RbS53CsDRdjG2Cqvot7LiyWOln4WPGksiaYY=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:661d:897e:ea86:704d])
 (user=pgonda job=sendgmr) by 2002:a05:6902:1149:b0:dbe:a0c2:df25 with SMTP id
 p9-20020a056902114900b00dbea0c2df25mr551705ybu.8.1712670025038; Tue, 09 Apr
 2024 06:40:25 -0700 (PDT)
Date: Tue,  9 Apr 2024 06:39:58 -0700
In-Reply-To: <20240409133959.2888018-1-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409133959.2888018-6-pgonda@google.com>
Subject: [PATCH 5/6] Add is_sev_enabled() helpers
From: Peter Gonda <pgonda@google.com>
To: pgonda@google.com, seanjc@google.com
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"

Add helper functions for guest code to check the status of SEV and
SEV-ES.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/sev.h    |  3 +++
 tools/testing/selftests/kvm/lib/x86_64/sev.c        | 11 +++++++++++
 tools/testing/selftests/kvm/x86_64/sev_smoke_test.c |  5 ++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index bfd481707f67..691dc005e2a1 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -106,4 +106,7 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
 }
 
+bool is_sev_enabled(void);
+bool is_sev_es_enabled(void);
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index 27ae1d3b1355..5b3f0a8a931a 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -189,3 +189,14 @@ struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t policy, void *guest_code,
 
 	return vm;
 }
+
+bool is_sev_enabled(void)
+{
+	return rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED;
+}
+
+bool is_sev_es_enabled(void)
+{
+	return is_sev_enabled() &&
+	       rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED;
+}
diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 026779f3ed06..1d84e78e7ae2 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -16,8 +16,7 @@
 static void guest_sev_es_code(void)
 {
 	/* TODO: Check CPUID after GHCB-based hypercall support is added. */
-	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
-	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED);
+	GUEST_ASSERT(is_sev_es_enabled());
 
 	/*
 	 * TODO: Add GHCB and ucall support for SEV-ES guests.  For now, simply
@@ -30,7 +29,7 @@ static void guest_sev_es_code(void)
 static void guest_sev_code(void)
 {
 	GUEST_ASSERT(this_cpu_has(X86_FEATURE_SEV));
-	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
+	GUEST_ASSERT(is_sev_enabled());
 
 	GUEST_DONE();
 }
-- 
2.44.0.478.gd926399ef9-goog


