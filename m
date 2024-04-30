Return-Path: <linux-kernel+bounces-164776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D138B82B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA161C20C52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C01E877;
	Tue, 30 Apr 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fX7VmZrN"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DDCA6F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517076; cv=none; b=ATZ1Ur04el2Om7tt/d/Ea1V/nehZjOV5Wv6gqnTwOBSGntLeigUe7viMVIllJGt0zIZZz19dgMjKL/cpg2CEEiSkTQ2Ra3IOxFihG50cxH4jn3PSyNEX1JC7MnAQgSqPuvmyUOpr2tD2JTDePSddEy7Sfo1mSACkCnzldZmDnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517076; c=relaxed/simple;
	bh=s/vtXHzjDeTSKmdQ9LzqZ2eqOATOPIO7yhx4A/EXXGw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bWMQU+lutXofVPY8qR+AMVr1cPecza3qhfDAnmh0QfAJdJ84ofJJ1FQt5GoWLOthPJvvBZi0RNBr24a2hXGhIgIY4k96TZeKhiozfh8zwstrwM/wpoGmiqE7t+fgAf3w3CyhiUHs9JbNclwDG2vwkosXHgwWSzrGp6IOwjgqeMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fX7VmZrN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6efefc57621so4229124b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714517074; x=1715121874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCfQmqRoqRQGFI2ezvT1bAn/fSYy9Gcya7Hg4Teq8VQ=;
        b=fX7VmZrNpRmgBQN6Ncv/A0HGt0lZ3c1pCLaauA3jvuUyGKU+kHyqkcVLqkQq1nrEw3
         XzmrDHEX54uDhVC4+HUrnCwASgEGl7nNeUdRku/bJQJB8f3TKzkkdw6wODUlo4clc3ZV
         uaLjWl729Zq/OPlnwSJd/LsA/7UYaEbc5mZD+81e9YgIgEMS4prnUBWI7eiZMaHCCE3M
         wsZlcrEJu+P3dHdcwpS50sK/OKntN7gPhqPlDCbwUQKAcwAnwB4GNKHVbePvv90fyYX5
         C5yt0wgUhtMujDw2IqmB3qTa1ATNI3/ZDWgKwuixt/RXH/8H4iKlYjjjxNPze8mUMIvr
         Q/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517074; x=1715121874;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCfQmqRoqRQGFI2ezvT1bAn/fSYy9Gcya7Hg4Teq8VQ=;
        b=q3YIUuhxibc6jTGFBE5TfRv8ll3WWkeCtd4tD3Mv1cAfS5NXW2U9Z2iOawsuaeF/Ny
         NpabK8d6nvc0lD4yjFEASnHSG6+1TbIjXDYmgaHT+vFGy8PEpsvOZBl3xVXM1WhiRCnR
         sGvu012GD1Y/OaUkNAnIjIsdURDRtJen1C5Pmu89j3Pd2QUAX91DvvrIJZ7IXB7L4IWe
         b+hDyDWCjI9hzD2IZqOI3l9lCHolLnHl0t+Lf/XJ/4faky/JgMq36DijojW/RcbHCI/x
         fuOw9Q0j91xi05Do9f5PAAJjqtkyww6KsTCl5NYlW31FJcju2TXMXRUrGfdea8xkVtz1
         B/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3/FBusAThfwD/5RwkJpypDUN3b6M4lg5CSBBSUgdflcFBdDHoHEX6t76l7xCci9sh8nGdXklcjuyOnjSbaYj35iN/OZo+O7AsO5S
X-Gm-Message-State: AOJu0Yyo9wQJl2lK6dGHaHTNIW+r69yZBQMgD6LKiiXnbayDsBIV1pqL
	ooZt6aIygzGrTLgbZyziQIbsdIchPRT+cVLC6o91z6nJRAYSSlwZAuLbPs8NwHDXE0lldytnYac
	a3g==
X-Google-Smtp-Source: AGHT+IHtUwa4Z35qWLAQcUHI96MDAxoRi8cSj8oEgOMwTeib4s9ut9pZPFvglO4SSGIE0zav39rtWoP14S8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d1a:b0:6e6:f7d0:7ed2 with SMTP id
 fa26-20020a056a002d1a00b006e6f7d07ed2mr92403pfb.3.1714517074091; Tue, 30 Apr
 2024 15:44:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Apr 2024 15:44:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430224431.490139-1-seanjc@google.com>
Subject: [PATCH DO NOT APPLY] KVM: SVM: Cache volatile task state to avoid
 VMSAVE in core run loop
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Do not apply.  This code is not functional, and is probably a terrible
idea in the first place.

Not-signed-off-by: Sean Christopherson <seanjc@google.com>
---

Tom, this is the idea I was talking about at PUCK for avoiding VMSAVE when a
vCPU is scheduled back in.  The idea is to:

 1) Do VMSAVE during KVM_RUN's vcpu_load()
 2) Snapshot the state that is per-task and manually shove that state into the
    save area (via memory) during svm_prepare_switch_to_guest().
 3) For state that is (theoretically) common to all tasks, e.g. the SYSENTER
    entry point, rely on the initial VMSAVE.
 4) Refresh the snapshot during kvm_sched_in() if the vCPU is being migrated to
    a different pCPU to account for per-CPU state, e.g. GS.base.

QEMU segfaults on FS: access though, specifically if I omit the VMSAVE in the
sched_in path, so I'm missing something.

And this really was so supposed to be for illustrative purposes only, I just
couldn't resist seeing if it would work :-)

 arch/x86/kvm/svm/svm.c | 34 ++++++++++++++++++++++++----------
 arch/x86/kvm/svm/svm.h |  5 +++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6d9763dc4fed..348addf0d4cf 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1499,6 +1499,7 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
+	struct vmcb_save_area *sa = page_address(sd->save_area);
 
 	if (sev_es_guest(vcpu->kvm))
 		sev_es_unmap_ghcb(svm);
@@ -1506,17 +1507,13 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	if (svm->guest_state_loaded)
 		return;
 
-	/*
-	 * Save additional host state that will be restored on VMEXIT (sev-es)
-	 * or subsequent vmload of host save area.
-	 */
-	vmsave(sd->save_area_pa);
-	if (sev_es_guest(vcpu->kvm)) {
-		struct sev_es_save_area *hostsa;
-		hostsa = (struct sev_es_save_area *)(page_address(sd->save_area) + 0x400);
+	sa->ldtr = svm->saved_ldtr;
+	sa->tr = svm->saved_tr;
+	sa->fs = svm->saved_fs;
+	sa->kernel_gs_base = svm->saved_kernel_gs_base;
 
-		sev_es_prepare_switch_to_guest(svm, hostsa);
-	}
+	if (sev_es_guest(vcpu->kvm))
+		sev_es_prepare_switch_to_guest(svm, (void *)sa + 0x400);
 
 	if (tsc_scaling)
 		__svm_write_tsc_multiplier(vcpu->arch.tsc_scaling_ratio);
@@ -1543,6 +1540,7 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu, bool sched_in)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
+	struct vmcb_save_area *sa = page_address(sd->save_area);
 
 	if (sched_in && !kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
@@ -1555,6 +1553,22 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu, bool sched_in)
 	}
 	if (kvm_vcpu_apicv_active(vcpu))
 		avic_vcpu_load(vcpu, cpu);
+
+	/*
+	 * If the vCPU is being loaded for KVM_RUN, save additional host state
+	 * that will be restored on VMEXIT (sev-es) or subsequent vmload of
+	 * host save area.  No need to re-save state if the vCPU task was
+	 * scheduled out from within KVM_RUN and is being scheduled back in on
+	 * the same pCPU.
+	 */
+	if (vcpu->wants_to_run && (vcpu->cpu != cpu || !sched_in)) {
+		vmsave(sd->save_area_pa);
+
+		svm->saved_ldtr = sa->ldtr;
+		svm->saved_tr = sa->tr;
+		svm->saved_fs = sa->fs;
+		svm->saved_kernel_gs_base = sa->kernel_gs_base;
+	}
 }
 
 static void svm_vcpu_put(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 323901782547..d0b93a69453a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -219,6 +219,11 @@ struct vcpu_svm {
 	u32 sysenter_eip_hi;
 	uint64_t tsc_aux;
 
+	struct vmcb_seg saved_ldtr;
+	struct vmcb_seg saved_tr;
+	struct vmcb_seg saved_fs;
+	u64 saved_kernel_gs_base;
+
 	u64 msr_decfg;
 
 	u64 next_rip;

base-commit: 662c1834094920e74ef48f6d52eba112094ae730
-- 
2.45.0.rc0.197.gbae5840b3b-goog


