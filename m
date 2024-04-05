Return-Path: <linux-kernel+bounces-133719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C4689A7B6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C4F1C21798
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EF481ABB;
	Fri,  5 Apr 2024 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3s+Y8Sq"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A574BF5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361389; cv=none; b=hyTUk28zoKO6cXGyPPFB6HEK6nA4hltdg9TU418VigXt6kj4biSflx+KKQGmRP0YA8FmJu4+Mpz1iguctgQDS1VHczVYr/gK0DRSStdnyiXIwCbaLUe+R+Q2umIIZ9rsD0ZhLJ4LZqLn9j6WfyZ9GaCzuPKpaWticnS96ORkJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361389; c=relaxed/simple;
	bh=5RDlYnCWS4ayQasdUGV2EFJf2g/5sa2I9izwXCuUezI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dBAEDnGjAOTY0AMcHldM3r8bz4PbYF1yIOZj4XTanDdgDEoaUwTf2K6aWhYgta/PPJtNX5rrp8wlRdoqBSKX5FwB6THDnXIew+8NfJ8I8wBI+TmeqyDE13wCggTI+aDt7c7xl6ctwG4dGxig9HvNQ5osluaLa4VIyBdGv7ypbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3s+Y8Sq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615110c3472so48681627b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712361386; x=1712966186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GbwikEYWbQPXHEM5/lws4KQQn5EqaCgsUvoAMFf6UNk=;
        b=T3s+Y8SqupuAdHuqAourmoM0WiRcDm/9RvAI+UhLOgJaCvTEX38tD20PUzelLg9CCM
         Evf9MLKH+Ccd3gqgomBYmBjuGNzvV+Q3p3CzNNG31V8eR4lLo9QC1KaNdA8qf5Iu6ZG5
         VGRuxMiNrr/+CBYYCeCjL86cVLdu8T+a6YH7I0HGlfXFOAuiN3l+SpjsdEUsUm8jICqP
         OHGNDG1M9bVqmTJXA++UM2afd3wAF3ayrmHVmiANJh5DLCGsLKROencvAGLd56Tugp+q
         +2s/ROuQNzHkmqVeiPHGIEYX3MKQsR+6yCOPSi37czkRMXvmKbcFdE0HL+tGWM6vFmdt
         djWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712361386; x=1712966186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbwikEYWbQPXHEM5/lws4KQQn5EqaCgsUvoAMFf6UNk=;
        b=h6i+gMPwcTyWMk34Lyi5uguc9pEcCBT3OlUobOTwDv9yJ/gqrPgkblqI3PQjhrbHjH
         A8H1nBn1omMfmyuPo/WrbXf8wkcnujAN5yJZVofLTs8CE4vckIi9jRyL3ZpLtQuvTNOZ
         yJNBGM+2aedPIKemFW7Pba3VvAXLiezuvNVlTp+wkS9+JINJHxLp/2ahjVArU1qR9uQt
         TOElCVVjjdg/qoW2wCh/adNNinA3EuHH2DxzskL0xkUyY03dW1xK2n7RJdRzC8QZEoeE
         lbfuuTQztXaBKEfRG69kM2gRPS353bolbAir125ZkoVs9nRN9JVauvzv/nhs3BOfvHFG
         b/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMhsdrt9LFe6YcG3TFjQx51GQ+/6di/qauaeaFnIzmiWHSHSNnGEWBPy3eFfKf7iH03Sx2mQvfp3zfuqptgt/BpiQsV4U6J1+SzKRG
X-Gm-Message-State: AOJu0YzlcIYgcCWtrvnXkk9Iq4iZpR+Phx79MOpGIAq6iupZr2Vcaoal
	3y5yM2IN8mCGSsMO/7l3ueA6bJJVoDR+bQ6qPQyZMbahUzk3JnfKdTdncr91RMKG/3puw0yEqol
	OPQ==
X-Google-Smtp-Source: AGHT+IE8jGFCNdnvcQoFiWg4slvFmL6J7M5uI9g+aVjoREsOBmGh3S15qyummmRu81lWYixJYoV7vfpkwtw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:d0c:b0:617:cbcf:8233 with SMTP id
 cn12-20020a05690c0d0c00b00617cbcf8233mr712182ywb.2.1712361386753; Fri, 05 Apr
 2024 16:56:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Apr 2024 16:56:03 -0700
In-Reply-To: <20240405235603.1173076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405235603.1173076-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405235603.1173076-11-seanjc@google.com>
Subject: [PATCH 10/10] KVM: x86: Bury guest_cpuid_is_amd_or_hygon() in cpuid.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Move guest_cpuid_is_amd_or_hygon() into cpuid.c now that, except for one
Intel quirk in the emulator, KVM checks for AMD vs. Intel *compatible*
vCPUs, not exact vendors, i.e. now that there should not be any reason for
KVM at-large to care about the exact vendor.

Opportunistically refactor the guts of the helper to use "entry" instead
of "best", and short circuit the !entry path to make the common case more
readable.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 12 ++++++++++++
 arch/x86/kvm/cpuid.h | 10 ----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 77352a4abd87..c5fb39930213 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -335,6 +335,18 @@ static bool kvm_cpuid_has_hyperv(struct kvm_cpuid_entry2 *entries, int nent)
 #endif
 }
 
+static bool guest_cpuid_is_amd_or_hygon(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *entry;
+
+	entry = kvm_find_cpuid_entry(vcpu, 0);
+	if (!entry)
+		return false;
+
+	return is_guest_vendor_amd(entry->ebx, entry->ecx, entry->edx) ||
+	       is_guest_vendor_hygon(entry->ebx, entry->ecx, entry->edx);
+}
+
 static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 03d015e9ce33..41697cca354e 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -102,16 +102,6 @@ static __always_inline void guest_cpuid_clear(struct kvm_vcpu *vcpu,
 		*reg &= ~__feature_bit(x86_feature);
 }
 
-static inline bool guest_cpuid_is_amd_or_hygon(struct kvm_vcpu *vcpu)
-{
-	struct kvm_cpuid_entry2 *best;
-
-	best = kvm_find_cpuid_entry(vcpu, 0);
-	return best &&
-	       (is_guest_vendor_amd(best->ebx, best->ecx, best->edx) ||
-		is_guest_vendor_hygon(best->ebx, best->ecx, best->edx));
-}
-
 static inline bool guest_cpuid_is_amd_compatible(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.is_amd_compatible;
-- 
2.44.0.478.gd926399ef9-goog


