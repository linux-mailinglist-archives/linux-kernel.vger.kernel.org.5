Return-Path: <linux-kernel+bounces-136995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6EC89DAE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81E81F21748
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC2138483;
	Tue,  9 Apr 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIgNM4ol"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF930137C22
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670025; cv=none; b=RH7bD0REeygPXLgQk6SgXZOItSHJSCbE5jXv/ZpYeNTeYouL2mglapIPfiYmLl19rEx8F8xVX1UEVri4gZ8Z/SKXx13Xir5Pp6+DC9qpnqXmwZNscHbR2rogresQrCakG8yQWlCX+jNwZNcPGODT06N7RfUTXBReJrYkHR8HZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670025; c=relaxed/simple;
	bh=PVCOhdc6DDdw0dTatfHJ5V1Uh3Bi7tZFW7XYqRS1wkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pbqtI22BTtfCFqe3Zayi/SAypcpv1SmfFYAaf2bbhZ89jxr4N+ZwLq8qKAc9qBnJO5O/u9GihRDhrdlN3MAHmitw9EXzGSRWEtCcRt3DL89KNsA0Q3BhDWSJO5cvLGHlVK2GzhZ5zf6mRMdKv/2VAwjgSCtAGk23EtAnNKi47Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIgNM4ol; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pgonda.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e2bb241663so43066415ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 06:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712670023; x=1713274823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeuEK38GC7iVK1ujFFvcKBa5p48Qfvr4eBgbugkaO1k=;
        b=uIgNM4olSYa9ysZXvZp+63Gf1FQXWeggLzsyu94VJb3YM6sUm0ZENCwefqBtOYSwr+
         ugE7ELpNW3WVFxmd6z2ilMrINVRuwFh9B00ufRfIK1MHgzVctVQz0B87/uaMQ3WazDLq
         9KX1NGsa2SCRInWGkZwyNU1B+9pURO9vCHUSeTd7X+CElhuJkGo+iAjkC+tzH7Fe3WjR
         +M3XeWago9jJdVfo12qiMss/qT+/XpHWjwSfKPhR/ce4jLNXi64zCgHS9CxW13+qRluj
         5RkJVSrMnE1k2bKGtG3EIAs3GvlO1TrXX+0Wh63iieWVJqUR48TiN9arIQ7Zx+FrdpmC
         RBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670023; x=1713274823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeuEK38GC7iVK1ujFFvcKBa5p48Qfvr4eBgbugkaO1k=;
        b=RoOMMCMohL0LmbOPI0JhrM+vOUT8oFbHxUV6LWIYyWxo7voFUTMfZ+lHvTjREstZOb
         6AZoAwprcVgb21ZODDToJb9kxrMkJvc5OnB9S9LHS2IKMpwioSM7m8ng/80HRgN36Jod
         O0PW2qnAF+KkfeHhLaCqV27+Ie4RQrUOsn0Ye3kxDjsMxqeCmiZavfEDNN9V8+KOrSKm
         Cf3T+CpvzFvMWKipXENMi5ja0AVC08YLa2AsTwDNWup0glR9I1tznNqYDfM4ssm8tmBP
         XEYQKydH000CQFzalWJScWLZiz+EBEfYRX/n+V1E0DH2GRMuGmqLpCZ8jqapXvDweR1s
         aYCA==
X-Gm-Message-State: AOJu0Yx5ZQX3UuHrTKQk+BbZsI7vbXzXaQ80M/aC6FBWdnwIyh1+En+i
	2PPMi1/JITku3VEF1haS0z6EQSk8KoYIymSwDDQuExDd9LhV2JFFf0QSkaDiHu9rTYMfkHiK2dm
	WfA==
X-Google-Smtp-Source: AGHT+IEzVv8xhsgMwJ9s01BpWKMedisC/JJ+Jv3539Rjq2P8BFX38qPyDM2NqZVs8iG+8eOnrpx1JA2POj8=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:661d:897e:ea86:704d])
 (user=pgonda job=sendgmr) by 2002:a17:902:e806:b0:1e3:cf18:7346 with SMTP id
 u6-20020a170902e80600b001e3cf187346mr532098plg.5.1712670023226; Tue, 09 Apr
 2024 06:40:23 -0700 (PDT)
Date: Tue,  9 Apr 2024 06:39:57 -0700
In-Reply-To: <20240409133959.2888018-1-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409133959.2888018-5-pgonda@google.com>
Subject: [PATCH 4/6] Add GHCB allocations and helpers
From: Peter Gonda <pgonda@google.com>
To: pgonda@google.com, seanjc@google.com
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add GHCB management functionality similar to the ucall management.
Allows for selftest vCPUs to acquire GHCBs for their usage.

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
 .../selftests/kvm/include/x86_64/sev.h        |  2 +
 .../selftests/kvm/lib/x86_64/processor.c      |  8 ++
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 77 +++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 8a1bf88474c9..bfd481707f67 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -27,6 +27,8 @@ enum sev_guest_state {
 
 #define GHCB_MSR_TERM_REQ	0x100
 
+int ghcb_nr_pages_required(uint64_t page_size);
+
 void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 49288fe10cd3..fd94a1bd82c9 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -584,6 +584,14 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
 		sev_es_vm_init(vm);
 }
 
+int kvm_arch_vm_additional_pages_required(struct vm_shape shape, uint64_t page_size)
+{
+	if (shape.subtype == VM_SUBTYPE_SEV_ES)
+		return  ghcb_nr_pages_required(page_size);
+
+	return 0;
+}
+
 void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 {
 	struct kvm_regs regs;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index e248d3364b9c..27ae1d3b1355 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -4,6 +4,80 @@
 #include <stdbool.h>
 
 #include "sev.h"
+#include "linux/bitmap.h"
+#include "svm.h"
+#include "svm_util.h"
+
+struct ghcb_entry {
+	struct ghcb ghcb;
+
+	/* Guest physical address of this GHCB. */
+	void *gpa;
+
+	/* Host virtual address of this struct. */
+	struct ghcb_entry *hva;
+};
+
+struct ghcb_header {
+	struct ghcb_entry ghcbs[KVM_MAX_VCPUS];
+	DECLARE_BITMAP(in_use, KVM_MAX_VCPUS);
+};
+
+static struct ghcb_header *ghcb_pool;
+
+int ghcb_nr_pages_required(uint64_t page_size)
+{
+	return align_up(sizeof(struct ghcb_header), page_size) / page_size;
+}
+
+void ghcb_init(struct kvm_vm *vm)
+{
+	struct ghcb_header *hdr;
+	struct ghcb_entry *entry;
+	vm_vaddr_t vaddr;
+	int i;
+
+	vaddr = vm_vaddr_alloc_shared(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR,
+				      MEM_REGION_DATA);
+	hdr = (struct ghcb_header *)addr_gva2hva(vm, vaddr);
+	memset(hdr, 0, sizeof(*hdr));
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		entry = &hdr->ghcbs[i];
+		entry->hva = entry;
+		entry->gpa = addr_hva2gpa(vm, &entry->ghcb);
+	}
+
+	write_guest_global(vm, ghcb_pool, (struct ghcb_header *)vaddr);
+}
+
+static struct ghcb_entry *ghcb_alloc(void)
+{
+	return &ghcb_pool->ghcbs[0];
+	struct ghcb_entry *entry;
+	int i;
+
+	if (!ghcb_pool)
+		goto ucall_failed;
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		if (!test_and_set_bit(i, ghcb_pool->in_use)) {
+			entry = &ghcb_pool->ghcbs[i];
+			memset(&entry->ghcb, 0, sizeof(entry->ghcb));
+			return entry;
+		}
+	}
+
+ucall_failed:
+	return NULL;
+}
+
+static void ghcb_free(struct ghcb_entry *entry)
+{
+	/* Beware, here be pointer arithmetic.  */
+	clear_bit(entry - ghcb_pool->ghcbs, ghcb_pool->in_use);
+}
+
 
 /*
  * sparsebit_next_clear() can return 0 if [x, 2**64-1] are all set, and the
@@ -44,6 +118,9 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
 	struct kvm_sev_guest_status status;
 	int ctr;
 
+	if (policy & SEV_POLICY_ES)
+		ghcb_init(vm);
+
 	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_START, &launch_start);
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
 
-- 
2.44.0.478.gd926399ef9-goog


