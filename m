Return-Path: <linux-kernel+bounces-103897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B887C659
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993C61C2115F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C01B969;
	Thu, 14 Mar 2024 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEorJR7P"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90071182D4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458811; cv=none; b=p6mAqwsRRhUfKdrwUUWsEgpZN3ocP3cW31rCUzZ4RkQ8uSYrT5nJsdtZUE2VVe7D9v2B6PlnVPjDLbxdpbdaLgplo3xh+o/GLkfM6nQwRD+cZKr4kQy+XKk2CFGS7Wor+iZ8fbllewQDBMTkgNY0RyJbqB4tG2ghl+YLoD6iJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458811; c=relaxed/simple;
	bh=kL1anMirud9R6581IlVg1+Shvk0whf3zxCiXUgx5dcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LRITzfMeFaXf/Dyo1EfLFzcDYoGvXX6Zogp+WisWkEnG+AYFFPMcq0JrIJpL3Mnz+3FVHodaQjKYe16Ap1m4Y2Wthp2uCA4Hxt6u9BUPIzECcoKSBF12Q+2281a5qzM1K8lsWNE4ULKaeFVDGYRyfHycOmrUhOekptKd3YjqGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEorJR7P; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e6b63a34baso1501262b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710458809; x=1711063609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=k1ceQ+0+7x0dggVxu3pfjgACx/CpWN/VJ25BN1jj24Q=;
        b=tEorJR7Pk1777OeprdZbHu64T980PUw6+gbCBdyq6AI8mEqhZk+IIW7sv8D/hGtICO
         WfsWa2vNGz2yrQS1j4tnw5KU2d/uCBwyAElNJzLhXJ0mDgT+Pcc5YWMicGDLCqogAltV
         BJQaQmMIrOXe3mFalISbKFEthhyY3Y2i9hb4RxNP0HjNv4fW9d8yDpTH/1Vgngd5ibR5
         U0E1T8peGUELMZmG3zKZ4QkeEChbtoDhamuj7k1FO6RT7MhqHn31DydpBm06AjprUonS
         mWryYCeoNBPzsNla5hqVyRzkQEkD8KgkS/J0gjq/fmlrXSKlSWqEuZuMKnJHF1Dj3AcE
         hGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458809; x=1711063609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1ceQ+0+7x0dggVxu3pfjgACx/CpWN/VJ25BN1jj24Q=;
        b=utHIZRv9o70/V7BYkUQUW+fEn4v9cZf1DiodAVSGs2gDpgWG1JQ7QO6Uir6XPJJf0Q
         6mqPuQOkP3c2xmXbQPVhN/4SxtAZY80CCRTOVMlqhGmX3PmRTvkbO7Ng1POJPBxY+twH
         9YAO+qpnS0RntwWn7uR6J17M6ocMI4bd/LNdOReY2uBKcscyUV4/NXhL81/admzYDHf5
         vP2BRl1gGT6Jtqw5T3M53/zQKRx/PjKkw0/FmtZL9oe6Dr7cA4henosPWBq9HjkQVRuz
         5ttjdukeZdZ7MvpcHjfsudaX6pwZVluWUVf/gFIhBB4Z0qK0iJ8qy5DxSja9+lwN1f9H
         jdmg==
X-Forwarded-Encrypted: i=1; AJvYcCWwgiKd7W9b1gK7pmlvyGjC5sJuQJIViCvyPQHRZVStRy1EwroQY4iUv0KOmK1odV5E3sdjUEeRI7BkiWKJCgYHIqFMjFP1Zf3zEg7f
X-Gm-Message-State: AOJu0Yz35kQqCRkbJX+gzPmeP4KBGT+q84eTf92zneVXXXU8R+EYp8pA
	2CLnZLGZpN8ld1xD3a5zaMlR+U40544FGpyTqzlUV9glhViDAprGRq7DZ8toRFhQdt5URhsg0W6
	U0A==
X-Google-Smtp-Source: AGHT+IFa6Xo5alB77JWBKkmfaT2866W5+uuYd+R94MhsO58PTc0FssqvQ3Br5ekzS9Hb9uDd/sllma8cTz8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:23c6:b0:6e6:c374:f104 with SMTP id
 g6-20020a056a0023c600b006e6c374f104mr152102pfc.0.1710458808854; Thu, 14 Mar
 2024 16:26:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 16:26:24 -0700
In-Reply-To: <20240314232637.2538648-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314232637.2538648-6-seanjc@google.com>
Subject: [PATCH 05/18] KVM: selftests: Move platform_info_test's main assert
 into guest code
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

As a first step toward gracefully handling the expected #GP on RDMSR in
platform_info_test, move the test's assert on the non-faulting RDMSR
result into the guest itself.  This will allow using a unified flow for
the host userspace side of things.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/platform_info_test.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/platform_info_test.c b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
index 87011965dc41..cdad7e2124c8 100644
--- a/tools/testing/selftests/kvm/x86_64/platform_info_test.c
+++ b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
@@ -29,7 +29,9 @@ static void guest_code(void)
 
 	for (;;) {
 		msr_platform_info = rdmsr(MSR_PLATFORM_INFO);
-		GUEST_SYNC(msr_platform_info);
+		GUEST_ASSERT_EQ(msr_platform_info & MSR_PLATFORM_INFO_MAX_TURBO_RATIO,
+				MSR_PLATFORM_INFO_MAX_TURBO_RATIO);
+		GUEST_SYNC(0);
 		asm volatile ("inc %r11");
 	}
 }
@@ -42,13 +44,15 @@ static void test_msr_platform_info_enabled(struct kvm_vcpu *vcpu)
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
-	get_ucall(vcpu, &uc);
-	TEST_ASSERT(uc.cmd == UCALL_SYNC,
-			"Received ucall other than UCALL_SYNC: %lu", uc.cmd);
-	TEST_ASSERT((uc.args[1] & MSR_PLATFORM_INFO_MAX_TURBO_RATIO) ==
-		MSR_PLATFORM_INFO_MAX_TURBO_RATIO,
-		"Expected MSR_PLATFORM_INFO to have max turbo ratio mask: %i.",
-		MSR_PLATFORM_INFO_MAX_TURBO_RATIO);
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+		break;
+	}
 }
 
 static void test_msr_platform_info_disabled(struct kvm_vcpu *vcpu)
-- 
2.44.0.291.gc1ea87d7ee-goog


