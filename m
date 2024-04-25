Return-Path: <linux-kernel+bounces-159006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F198B2806
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D18B23AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E7915622E;
	Thu, 25 Apr 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDAfGkxY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B03D15574E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068883; cv=none; b=EyGlvj4sOx6rpNGtWPVR3CemY8Aym1SetLrL3T1AbAVk85ybFj/ADTD3KuA5M5vcSWyp+jTiMAhBsIVfdWeq44ieBF6RybruDKoNFtDHwnBtwwILbr83VnljkL1cMAJTPbUXFL83Db+b64edl4anzqgz+BCGK/AkWqMaJQbn3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068883; c=relaxed/simple;
	bh=XQbuCE10iEXL6Hj41mbGLp/9CQA2+KEDclppIVQzUqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NwUq0nzgNvkEsSr9+OKWun8VW+7Vgtj2HI5HFAV9Tv+EAS+oKYq6MyuFHu2ueTjbVwDhHtZuZntCiNw2g4A5W/SShi0rbQe3kJCnldQSmgdmQAP6pgaENYL3sWKIc5oxR2GzVum3GQgUKupacKol9xy1YuDyy+3IyoTHvBacSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDAfGkxY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de59e612376so838968276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714068881; x=1714673681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iXAD1gTtiwO6R5kc5FsGGbiVN1kl1k4gITxMp5dXiKA=;
        b=eDAfGkxYy589HlReu2v+v08ULFTE4L3nA7ftceBq/ImSOM76BJzAUpdvc1MNml4n7w
         V/mi9B06kW/rRx0U9zQJw7izsrek0FlhNT2mPLWxCe0roEjOiPveIaT1X5bm4PpcDDap
         m4K7SrI1pbjfjrlM8H9JnCQ9tfBlR5kb1FFlElcUDZhoMxOsZtVQVc5tugIdjzBEbmc4
         UEs6VV3FQs4eyv+hPNcBAVueCp9k6pjnULvxl8CeGu0dCVAIbSQDBMi94tvfrY0VgizL
         Sig8zYO4L8sYK9HnTLmhrTPgPVwAdYrE+8CiJU6M3ZKy//JWnIkJ0ZVcaXny+BlaYYVP
         NwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068881; x=1714673681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXAD1gTtiwO6R5kc5FsGGbiVN1kl1k4gITxMp5dXiKA=;
        b=nAzIAHNXIRvahFoW4pu94UHAQij8Clsbq8kDPgNbNAzhdHErn8IMpcyZs7XtNYlGzn
         NjUOXzxXVUPzMyRptq4yxRg1XDE9v6VRuCGkR+pR/pgztwVCpQULr38mcaqmrGqUccwb
         UozNIKvKDdGuAQdoHMy1J89RfbAvka6qozs4DUrVHKGbs+Anm+q0ODRI35cqYwVp68lq
         ZmruExyJTIc2++QJk5k7uU5oRmjdcOsvoqM7TQ9/dVlWDQTBBQyOnraKG+hfhN7jEbxw
         TIKtqjXAuzQrdw68SOxeHbx94OL+C0Fu4Dtu2QB019/ggcWdNVcLBSKgk3tECWv3q5S+
         xK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMhQfSF+7DpeIXAIy7zv7onnPtKdAG99ZnbW0zEtQ8WiAwxTPZdEjAZKW10LFuXiP+3ibdvlNl46TIt7L/lMEj6BnGi4zPhSKZO7mL
X-Gm-Message-State: AOJu0Yz9jYy0cv9damDOmBVzhGAB2oq9w1PzK/h4n7y6IGFu6a/WMNeI
	gEeo+1NgWK5828enj3RuApexXp1NFLRul2g0rmGDdzfjqFZRjzQVHpVLvDI8diWiYfNXZdbpQKO
	odw==
X-Google-Smtp-Source: AGHT+IGUU5V15PYJLb/rvGrpR2O7b0dqV3NWp9gPiWq1USgUBru2IcuP3QcVb64fWJwVI+urhXDfqHkISlY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1006:b0:dcd:3a37:65 with SMTP id
 w6-20020a056902100600b00dcd3a370065mr55877ybt.7.1714068881182; Thu, 25 Apr
 2024 11:14:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Apr 2024 11:14:19 -0700
In-Reply-To: <20240425181422.3250947-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425181422.3250947-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425181422.3250947-8-seanjc@google.com>
Subject: [PATCH 07/10] KVM: x86: Funnel all fancy MSR return value handling
 into a common helper
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a common helper, kvm_do_msr_access(), to invoke the "leaf" APIs that
are type and access specific, and more importantly to handle errors that
are returned from the leaf APIs.  I.e. turn kvm_msr_ignored_check() from a
a helper that is called on an error, into a trampoline that detects errors
*and* applies relevant side effects, e.g. logging unimplemented accesses.

Because the leaf APIs are used for guest accesses, userspace accesses, and
KVM accesses, and because KVM supports restricting access to MSRs from
userspace via filters, the error handling is subtly non-trivial.  E.g. KVM
has had at least one bug escape due to making each "outer" function handle
errors.  See commit 3376ca3f1a20 ("KVM: x86: Fix KVM_GET_MSRS stack info
leak").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 86 +++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c0727df18e92..a0506878d58e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -319,25 +319,40 @@ u64 __read_mostly host_xcr0;
 
 static struct kmem_cache *x86_emulator_cache;
 
-/*
- * When called, it means the previous get/set msr reached an invalid msr.
- * Return true if we want to ignore/silent this failed msr access.
- */
-static bool kvm_msr_ignored_check(u32 msr, u64 data, bool write)
+typedef int (*msr_access_t)(struct kvm_vcpu *vcpu, u32 index, u64 *data,
+			    bool host_initiated);
+
+static __always_inline int kvm_do_msr_access(struct kvm_vcpu *vcpu, u32 msr,
+					     u64 *data, bool host_initiated,
+					     enum kvm_msr_access rw,
+					     msr_access_t msr_access_fn)
 {
-	const char *op = write ? "wrmsr" : "rdmsr";
-
-	if (ignore_msrs) {
-		if (report_ignored_msrs)
-			kvm_pr_unimpl("ignored %s: 0x%x data 0x%llx\n",
-				      op, msr, data);
-		/* Mask the error */
-		return true;
-	} else {
+	const char *op = rw == MSR_TYPE_W ? "wrmsr" : "rdmsr";
+	int ret;
+
+	BUILD_BUG_ON(rw != MSR_TYPE_R && rw != MSR_TYPE_W);
+
+	/*
+	 * Zero the data on read failures to avoid leaking stack data to the
+	 * guest and/or userspace, e.g. if the failure is ignored below.
+	 */
+	ret = msr_access_fn(vcpu, msr, data, host_initiated);
+	if (ret && rw == MSR_TYPE_R)
+		*data = 0;
+
+	if (ret != KVM_MSR_RET_UNSUPPORTED)
+		return ret;
+
+	if (!ignore_msrs) {
 		kvm_debug_ratelimited("unhandled %s: 0x%x data 0x%llx\n",
-				      op, msr, data);
-		return false;
+				      op, msr, *data);
+		return ret;
 	}
+
+	if (report_ignored_msrs)
+		kvm_pr_unimpl("ignored %s: 0x%x data 0x%llx\n", op, msr, *data);
+
+	return 0;
 }
 
 static struct kmem_cache *kvm_alloc_emulator_cache(void)
@@ -1705,16 +1720,8 @@ static int kvm_get_feature_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 
 static int do_get_feature_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 {
-	int r;
-
-	/* Unconditionally clear the output for simplicity */
-	*data = 0;
-	r = kvm_get_feature_msr(vcpu, index, data, true);
-
-	if (r == KVM_MSR_RET_UNSUPPORTED && kvm_msr_ignored_check(index, 0, false))
-		r = 0;
-
-	return r;
+	return kvm_do_msr_access(vcpu, index, data, true, MSR_TYPE_R,
+				 kvm_get_feature_msr);
 }
 
 static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
@@ -1901,16 +1908,17 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 	return static_call(kvm_x86_set_msr)(vcpu, &msr);
 }
 
+static int _kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
+			bool host_initiated)
+{
+	return __kvm_set_msr(vcpu, index, *data, host_initiated);
+}
+
 static int kvm_set_msr_ignored_check(struct kvm_vcpu *vcpu,
 				     u32 index, u64 data, bool host_initiated)
 {
-	int ret = __kvm_set_msr(vcpu, index, data, host_initiated);
-
-	if (ret == KVM_MSR_RET_UNSUPPORTED)
-		if (kvm_msr_ignored_check(index, data, true))
-			ret = 0;
-
-	return ret;
+	return kvm_do_msr_access(vcpu, index, &data, host_initiated, MSR_TYPE_W,
+				 _kvm_set_msr);
 }
 
 /*
@@ -1949,16 +1957,8 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 static int kvm_get_msr_ignored_check(struct kvm_vcpu *vcpu,
 				     u32 index, u64 *data, bool host_initiated)
 {
-	int ret = __kvm_get_msr(vcpu, index, data, host_initiated);
-
-	if (ret == KVM_MSR_RET_UNSUPPORTED) {
-		/* Unconditionally clear *data for simplicity */
-		*data = 0;
-		if (kvm_msr_ignored_check(index, 0, false))
-			ret = 0;
-	}
-
-	return ret;
+	return kvm_do_msr_access(vcpu, index, data, host_initiated, MSR_TYPE_R,
+				 __kvm_get_msr);
 }
 
 static int kvm_get_msr_with_filter(struct kvm_vcpu *vcpu, u32 index, u64 *data)
-- 
2.44.0.769.g3c40516874-goog


