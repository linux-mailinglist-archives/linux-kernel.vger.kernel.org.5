Return-Path: <linux-kernel+bounces-50756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64D0847D9D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A820B296E9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02FA1B95C;
	Sat,  3 Feb 2024 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eF5KUrtV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662012E58
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918984; cv=none; b=rrelGszTY0/KSUjlLNyzPjTrCgIlqzX2PxtOOl+EjhH8kaPYkByPaPXZwbYtORKJm6nTMPLNtUPxEDJ764UHyGuaiyMY6lFUJetWJ045PVM412/bkoey6HF0kiaD7yPVrMuIDELHFPUVvo9ajEa/sAFqr06FIaaEL+N0ELlitNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918984; c=relaxed/simple;
	bh=WErIq3K7OOqOd3xHpYtlDNEPs0UpZWxiYWZgTo/MP4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IwCg1NwaxPV69xySt+sWGoWZS+XOeHDQeGCH1gXpgsWMm1dzjD9UyvIhcnvMF2jlAFLbjJSEEuX8ihv4JX3f3tq8PEIfpuvb2WYuIb+IggR+OHB4fz5QD7JgFAo/64KZJczBvEywezAwD/iHNH9RTQuzRFiCKQV7SuNBPvRY/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eF5KUrtV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6c2643a07so4778994276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 16:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706918978; x=1707523778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XX/qPWiFzcrNc98rmsyPZwe0j7yaMHMPDZjofeW64Pk=;
        b=eF5KUrtVovEJ4MDY6oGzaFPy1rOPDlgm8O18gNe4qm2R10VKwzOXH/clL8xMTRKe5t
         MX5BWFW4o57RNP9UcLtjUpz8pr8XFiA/E9xjW1WoKd8KDE6LumUWVADgMckxLDk+j/Qb
         Rv+L/R8v05AMTl+1NuGlDw5BYyOKEY3PW+S2VEHYFPkKsMt2V8YgY1iMgqLbH0CiEK3E
         rgmRXMQoq2hI1X1OzUGRWDMuU6Kf+kG30Z+OUZ35FrVZ1Ko7+6hXWfd/fDhnVoZ45Jg6
         FTQXsOQFpoLeNscsRsX4jkaaDRvlJZB4yMiseOvl/E4lcKBbSNP0hFFbh25WVwufR4E5
         d8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706918978; x=1707523778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XX/qPWiFzcrNc98rmsyPZwe0j7yaMHMPDZjofeW64Pk=;
        b=nD5g9nBVK7NMO1AqqfIzBmFXU644aJ7/0RABtdqkSwc0/gR2n+L6wU7Oo343bFLTDM
         6JHLZ9jNiAalrZls1zKkbcKmCGThG++c0NBDOxNCUtBnfXiVdGo3khJ7RuIOtJ7yDcxB
         Z8/hC6AgOWyjZEHQgTr6K6/xpMutqH9fyKRnhjWluIqtTZb8c9UAIlXeApH+AvpbYM9S
         eGG99b6rXNVmLl1xlOm82PFNQ48ZjTVquIHaBqkEHHOOUlAqDyDTM40ioXbqls8xA1E3
         zXhMRMNT9Ul4WtRM73SMxGXnO+JASc2gWyi0eaMNUyTSwDhOK8xBXX+NpLZKOHistuXC
         4H0A==
X-Gm-Message-State: AOJu0Yy6aKU5lWYsX+abtiaaCGRTimltFFSQClCzO2m9xCwsDR7G3L/I
	CZgC2ECnY9VGifMmlOlU299/PVOwo8xzO4R14+nNwohKwSF2ZAibFQPEy0hauVJJ1ngeAZHym1/
	Oaw==
X-Google-Smtp-Source: AGHT+IGBKIXyRsAwi5cacC2RTa4GkVM2EUkU98GzGDTFoqRDoIOEQUQo2SlZwq83sHOJV7drFveoG9mVQK8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1085:b0:dc6:e5e9:f3af with SMTP id
 v5-20020a056902108500b00dc6e5e9f3afmr1242765ybu.9.1706918978596; Fri, 02 Feb
 2024 16:09:38 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Feb 2024 16:09:15 -0800
In-Reply-To: <20240203000917.376631-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203000917.376631-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240203000917.376631-10-seanjc@google.com>
Subject: [PATCH v8 09/10] KVM: selftests: Use the SEV library APIs in the
 intra-host migration test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"

Port the existing intra-host SEV(-ES) migration test to the recently added
SEV library, which handles much of the boilerplate needed to create and
configure SEV guests.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/sev_migrate_tests.c  | 67 ++++++-------------
 1 file changed, 21 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index a49828adf294..d6f7428e42c6 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -10,11 +10,9 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
-#include "svm_util.h"
+#include "sev.h"
 #include "kselftest.h"
 
-#define SEV_POLICY_ES 0b100
-
 #define NR_MIGRATE_TEST_VCPUS 4
 #define NR_MIGRATE_TEST_VMS 3
 #define NR_LOCK_TESTING_THREADS 3
@@ -22,46 +20,24 @@
 
 bool have_sev_es;
 
-static int __sev_ioctl(int vm_fd, int cmd_id, void *data, __u32 *fw_error)
-{
-	struct kvm_sev_cmd cmd = {
-		.id = cmd_id,
-		.data = (uint64_t)data,
-		.sev_fd = open_sev_dev_path_or_exit(),
-	};
-	int ret;
-
-	ret = ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
-	*fw_error = cmd.error;
-	return ret;
-}
-
-static void sev_ioctl(int vm_fd, int cmd_id, void *data)
-{
-	int ret;
-	__u32 fw_error;
-
-	ret = __sev_ioctl(vm_fd, cmd_id, data, &fw_error);
-	TEST_ASSERT(ret == 0 && fw_error == SEV_RET_SUCCESS,
-		    "%d failed: return code: %d, errno: %d, fw error: %d",
-		    cmd_id, ret, errno, fw_error);
-}
-
 static struct kvm_vm *sev_vm_create(bool es)
 {
 	struct kvm_vm *vm;
-	struct kvm_sev_launch_start start = { 0 };
 	int i;
 
 	vm = vm_create_barebones();
-	sev_ioctl(vm->fd, es ? KVM_SEV_ES_INIT : KVM_SEV_INIT, NULL);
+	if (!es)
+		sev_vm_init(vm);
+	else
+		sev_es_vm_init(vm);
+
 	for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
 		__vm_vcpu_add(vm, i);
+
+	sev_vm_launch(vm, es ? SEV_POLICY_ES : 0);
+
 	if (es)
-		start.policy |= SEV_POLICY_ES;
-	sev_ioctl(vm->fd, KVM_SEV_LAUNCH_START, &start);
-	if (es)
-		sev_ioctl(vm->fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
+		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 	return vm;
 }
 
@@ -181,7 +157,7 @@ static void test_sev_migrate_parameters(void)
 	sev_vm = sev_vm_create(/* es= */ false);
 	sev_es_vm = sev_vm_create(/* es= */ true);
 	sev_es_vm_no_vmsa = vm_create_barebones();
-	sev_ioctl(sev_es_vm_no_vmsa->fd, KVM_SEV_ES_INIT, NULL);
+	sev_es_vm_init(sev_es_vm_no_vmsa);
 	__vm_vcpu_add(sev_es_vm_no_vmsa, 1);
 
 	ret = __sev_migrate_from(sev_vm, sev_es_vm);
@@ -230,13 +206,13 @@ static void sev_mirror_create(struct kvm_vm *dst, struct kvm_vm *src)
 	TEST_ASSERT(!ret, "Copying context failed, ret: %d, errno: %d", ret, errno);
 }
 
-static void verify_mirror_allowed_cmds(int vm_fd)
+static void verify_mirror_allowed_cmds(struct kvm_vm *vm)
 {
 	struct kvm_sev_guest_status status;
+	int cmd_id;
 
-	for (int cmd_id = KVM_SEV_INIT; cmd_id < KVM_SEV_NR_MAX; ++cmd_id) {
+	for (cmd_id = KVM_SEV_INIT; cmd_id < KVM_SEV_NR_MAX; ++cmd_id) {
 		int ret;
-		__u32 fw_error;
 
 		/*
 		 * These commands are allowed for mirror VMs, all others are
@@ -256,14 +232,13 @@ static void verify_mirror_allowed_cmds(int vm_fd)
 		 * These commands should be disallowed before the data
 		 * parameter is examined so NULL is OK here.
 		 */
-		ret = __sev_ioctl(vm_fd, cmd_id, NULL, &fw_error);
-		TEST_ASSERT(
-			ret == -1 && errno == EINVAL,
-			"Should not be able call command: %d. ret: %d, errno: %d",
-			cmd_id, ret, errno);
+		ret = __vm_sev_ioctl(vm, cmd_id, NULL);
+		TEST_ASSERT(ret == -1 && errno == EINVAL,
+			    "Should not be able call command: %d. ret: %d, errno: %d",
+			    cmd_id, ret, errno);
 	}
 
-	sev_ioctl(vm_fd, KVM_SEV_GUEST_STATUS, &status);
+	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
 }
 
 static void test_sev_mirror(bool es)
@@ -281,9 +256,9 @@ static void test_sev_mirror(bool es)
 		__vm_vcpu_add(dst_vm, i);
 
 	if (es)
-		sev_ioctl(dst_vm->fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
+		vm_sev_ioctl(dst_vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 
-	verify_mirror_allowed_cmds(dst_vm->fd);
+	verify_mirror_allowed_cmds(dst_vm);
 
 	kvm_vm_free(src_vm);
 	kvm_vm_free(dst_vm);
-- 
2.43.0.594.gd9cf4e227d-goog


