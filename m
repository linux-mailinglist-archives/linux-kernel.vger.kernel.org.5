Return-Path: <linux-kernel+bounces-131389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7867898702
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F671C26270
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA612DDBC;
	Thu,  4 Apr 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6vKx7KM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55397128818
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232820; cv=none; b=c1Wo6c3NOYOVeF0FFwG4xgM/rjSLKdYwaU1Brw8CGYD5oXQt2FyNDTX8l7O/QQ61wCDGHSQ/Hzh/anQQ3CXnjFU5ByolMzs+V0VT8DMUuGeig1zg1vHgTBjaWYWZ9jAzTqeZBu/W+CeGZ1binLj6rgdqfVZ6esPZJe3HdLlJTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232820; c=relaxed/simple;
	bh=DpTVlNXrctec4b3CsWrFlQYf/h/hDyzV3LAmJBcqDjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHICvv6xqoLNiKePpXfCk1GnfzmeUJSKKquJoV09rkHrNOaFgrSWc8jjw3gnrwnsVVuzzojheRzS8+qREyhCc6p4vHn5CdAd6gSkTW9Pv+0FJ6zblnRjQ6tO+fe9gBYi2aZAlCX8L9mOjRYouG/M6MuR3d6sTEItEQiwy0xBMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6vKx7KM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712232816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtkIQ4MjvqbejQVBH3/CsAsyaYz00eM1hO1APdOnE38=;
	b=b6vKx7KMPFHeGzOmdqTS1ZN4FR8Q/wUYNuaSyQp11l6CXpXDsc1UqP6ASth/IhuZ+drCSN
	qBHoc2Jd9rsKkaprb3hQ9cqX/LL8QgvLlrmdQZwnQ1t2HOkrhVtnbWYYv1Ec6/tiktbQcJ
	v532jx2rXn8xH70UfGqhdq9fTcZ/rDY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-PvQcHVhhNLOGLgCYdt5aAA-1; Thu, 04 Apr 2024 08:13:31 -0400
X-MC-Unique: PvQcHVhhNLOGLgCYdt5aAA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A1349423C8;
	Thu,  4 Apr 2024 12:13:31 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 485C7492BC6;
	Thu,  4 Apr 2024 12:13:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: michael.roth@amd.com,
	isaku.yamahata@intel.com
Subject: [PATCH v5 16/17] selftests: kvm: split "launch" phase of SEV VM creation
Date: Thu,  4 Apr 2024 08:13:26 -0400
Message-ID: <20240404121327.3107131-17-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Allow the caller to set the initial state of the VM.  Doing this
before sev_vm_launch() matters for SEV-ES, since that is the
place where the VMSA is updated and after which the guest state
becomes sealed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/include/x86_64/sev.h |  3 ++-
 tools/testing/selftests/kvm/lib/x86_64/sev.c     | 16 ++++++++++------
 .../selftests/kvm/x86_64/sev_smoke_test.c        |  7 ++++++-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index 0719f083351a..82c11c81a956 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -31,8 +31,9 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
 void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
 void sev_vm_launch_finish(struct kvm_vm *vm);
 
-struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t policy, void *guest_code,
+struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu);
+void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement);
 
 kvm_static_assert(SEV_RET_SUCCESS == 0);
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index 597994fa4f41..d482029b6004 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -113,26 +113,30 @@ void sev_vm_launch_finish(struct kvm_vm *vm)
 	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_RUNNING);
 }
 
-struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t policy, void *guest_code,
+struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t type, void *guest_code,
 					   struct kvm_vcpu **cpu)
 {
 	struct vm_shape shape = {
 		.mode = VM_MODE_DEFAULT,
-		.type = policy & SEV_POLICY_ES ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM,
+		.type = type,
 	};
 	struct kvm_vm *vm;
 	struct kvm_vcpu *cpus[1];
-	uint8_t measurement[512];
 
 	vm = __vm_create_with_vcpus(shape, 1, 0, guest_code, cpus);
 	*cpu = cpus[0];
 
+	return vm;
+}
+
+void vm_sev_launch(struct kvm_vm *vm, uint32_t policy, uint8_t *measurement)
+{
 	sev_vm_launch(vm, policy);
 
-	/* TODO: Validate the measurement is as expected. */
+	if (!measurement)
+		measurement = alloca(256);
+
 	sev_vm_launch_measure(vm, measurement);
 
 	sev_vm_launch_finish(vm);
-
-	return vm;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 026779f3ed06..234c80dd344d 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -41,7 +41,12 @@ static void test_sev(void *guest_code, uint64_t policy)
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	vm = vm_sev_create_with_one_vcpu(policy, guest_code, &vcpu);
+	uint32_t type = policy & SEV_POLICY_ES ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
+
+	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
+
+	/* TODO: Validate the measurement is as expected. */
+	vm_sev_launch(vm, policy, NULL);
 
 	for (;;) {
 		vcpu_run(vcpu);
-- 
2.43.0



