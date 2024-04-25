Return-Path: <linux-kernel+bounces-159008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F1F8B2809
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A438D1F21536
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E70315665D;
	Thu, 25 Apr 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUjHHqXX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60915624B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068887; cv=none; b=qUFF1hNOIaiSvNCjNKqAXzg3BH5iKZ6506TeMGSkyYHAomOzvrCI0lY293mu7XqUr5Zm1X1Fn2d9B+9n/oyFw23GSIafmvOZphe5OMQKZO6/wirZ6/qfQKRWujuzzYZql2so5epOwNkLYcXy5xwlF5qEBiQ8FYTKGnOVPmCka+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068887; c=relaxed/simple;
	bh=247P5YIdaIT018imI0/FIsolw28zSgLr6OXAMGjYu4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iG9zELxCBJi3dqpTCLiOx14YF2Eay2veBIVoDIasJylXG6I5cT1uMwd97+kfxZZZHv/1IflJbChFxh/7kFH34M2igCV0Tv7EVpMBAOAQQvYkMtURdPE6MHAFUxNk8HgCRmwIuiAi00OORDkVMv82ZwPzVLTTuQmZ6v8sEHkVCLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GUjHHqXX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4f312a995so1129387a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714068885; x=1714673685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aNpP1eW5DP+TAfE/NjGLi9NUaYZsZjI/uTGRPzZPo4M=;
        b=GUjHHqXX8gP+CwPGBOYzK9I7kFPOLFy8gUhL3rM4BtNb1lfCnrBlpJrtXf8OBq+Yvi
         zXHtNofv/WBOwl+YHZMo8chv2MN1MNk8HyKm94WNmlPqXzg/Hf1hOF0wd+QUQeJrHKaA
         ycKSohc0mAL5x8Srj8oTC4JYa3pXlA76W9gIdU4bZoRtKXLEPlh7oEYNKoYsl29j83Qj
         T+WhOcOldOviG7QLjtjvIVPEq6zJ/mh0v5F5JLqSqVjwZcHLSeGsO0L6V3xDCpnzcD8p
         c2rhKGOskRFAu1OFj7ORkG+tX1n19O+npMSNl3cejrl4JH2OFb9mqbt5x8Z/1mPG7a2/
         aJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068885; x=1714673685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNpP1eW5DP+TAfE/NjGLi9NUaYZsZjI/uTGRPzZPo4M=;
        b=KrbpzHwqS6f/vG+CPKED2kvsUHNhUEud/qyWZaN/T0WWpAHUAOgmNGgBImgOl2+yRS
         bdudptKY/wcPBAWDiZ3o84IYTkMsCzZihf80pXZFxcevwxeU15Rhz6g5sGJA7WBaJF5w
         ttgRYElKTQhP2F8Ind11XKFKNGEx8cK1ziBk1L8m8qQSbbUEB+yQqnfnAmuxdCyPB9R6
         zr+6BIYg7AqrMdUuPZylC7N+nc1679xu69FLx7TMwculVxHd9Pi3YoFOhv0Mb//ixOza
         hhbXy1mEVN5OBHtBAy0qE6rgtf4fVlEaxXpIgakbigaC/Ez/rjoobNoePjoNm/t+3OFe
         yx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwa6+5L/4h5Pu4TqGAUGbMqEI7VenxUWqJVeto3polIzkeK5/ZJcnyElwJo4LxsXrfx0UOAshn2P0XUI59NqovKq5H22CsKaZi/mPn
X-Gm-Message-State: AOJu0YwuN9MdXFg2hjD4H8YSwJvkMj+abx0JmvtNRQPWMfxlkfd/3luB
	mSygC4wE4ElPKppvgTXUh94NEP0Gw+lK1Vui+2c7gvuK6f0MBCUUNBJwa8iRMV9NnRT+jG8xI/f
	Dfw==
X-Google-Smtp-Source: AGHT+IF+pktbKA5ERhhI9ACh0DvxCWS2IxmYMfxElb+yYd48b/kvPmDGRCometGGY/kYmjTT7Oe1ih0b4Y0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6556:0:b0:5dc:1b0a:48e1 with SMTP id
 a22-20020a656556000000b005dc1b0a48e1mr1095pgw.1.1714068885143; Thu, 25 Apr
 2024 11:14:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Apr 2024 11:14:21 -0700
In-Reply-To: <20240425181422.3250947-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425181422.3250947-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425181422.3250947-10-seanjc@google.com>
Subject: [PATCH 09/10] KVM: x86: Suppress failures on userspace access to
 advertised, unsupported MSRs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Extend KVM's suppression of failures due to a userspace access to an
unsupported, but advertised as a "to save" MSR to all MSRs, not just those
that happen to reach the default case statements in kvm_get_msr_common()
and kvm_set_msr_common().  KVM's soon-to-be-established ABI is that if an
MSR is advertised to userspace, then userspace is allowed to read the MSR,
and write back the value that was read, i.e. why an MSR is unsupported
doesn't change KVM's ABI.

Practically speaking, this is very nearly a nop, as the only other paths
that return KVM_MSR_RET_UNSUPPORTED are {svm,vmx}_get_feature_msr(), and
it's unlikely, though not impossible, that userspace is using KVM_GET_MSRS
on unsupported MSRs.

The primary goal of moving the suppression to common code is to allow
returning KVM_MSR_RET_UNSUPPORTED as appropriate throughout KVM, without
having to manually handle the "is userspace accessing an advertised"
waiver.  I.e. this will allow formalizing KVM's ABI without incurring a
high maintenance cost.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 04a5ae853774..4c91189342ff 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -527,6 +527,15 @@ static __always_inline int kvm_do_msr_access(struct kvm_vcpu *vcpu, u32 msr,
 	if (ret != KVM_MSR_RET_UNSUPPORTED)
 		return ret;
 
+	/*
+	 * Userspace is allowed to read MSRs, and write '0' to MSRs, that KVM
+	 * reports as to-be-saved, even if an MSR isn't fully supported.
+	 * Simply check that @data is '0', which covers both the write '0' case
+	 * and all reads (in which case @data is zeroed on failure; see above).
+	 */
+	if (host_initiated && !*data && kvm_is_msr_to_save(msr))
+		return 0;
+
 	if (!ignore_msrs) {
 		kvm_debug_ratelimited("unhandled %s: 0x%x data 0x%llx\n",
 				      op, msr, *data);
@@ -4163,14 +4172,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
 
-		/*
-		 * Userspace is allowed to write '0' to MSRs that KVM reports
-		 * as to-be-saved, even if an MSRs isn't fully supported.
-		 */
-		if (msr_info->host_initiated && !data &&
-		    kvm_is_msr_to_save(msr))
-			break;
-
 		return KVM_MSR_RET_UNSUPPORTED;
 	}
 	return 0;
@@ -4522,16 +4523,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
 			return kvm_pmu_get_msr(vcpu, msr_info);
 
-		/*
-		 * Userspace is allowed to read MSRs that KVM reports as
-		 * to-be-saved, even if an MSR isn't fully supported.
-		 */
-		if (msr_info->host_initiated &&
-		    kvm_is_msr_to_save(msr_info->index)) {
-			msr_info->data = 0;
-			break;
-		}
-
 		return KVM_MSR_RET_UNSUPPORTED;
 	}
 	return 0;
-- 
2.44.0.769.g3c40516874-goog


