Return-Path: <linux-kernel+bounces-136003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61AB89CECB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E541C21AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5351A1448DD;
	Mon,  8 Apr 2024 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9/lYa/j"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0917A149DF1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618105; cv=none; b=EugSfTmdpfKohheFfspWdbvQMVBUPtn2XrlMwYICeHkJi/ZdcosRAH0EgL4bH3gYJhJOTPa6yJNN+9/DTDbuWzlc6PfuE1ME06SWCQ2giEQMglD/51qmb6MZxdNsrKayOy+TSaoxotxk7N36Ebtxgq5RX7Jfm7p73mbVaZeLuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618105; c=relaxed/simple;
	bh=DOYw13QQ4X0EPu4h0Hk0eMsaMAsay1WGuwkMc6K7le8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BAYKScKlqsPAKbUBqFq9gEJpOHi5uwbFuCbbETdwh9qC2es24Noa4I1/EPMVipaTkS+yTXdDDQb/9Mu0F2xmhmVhSOgs8gLU7EromD1oVlt2Lixm6ZJHO5ZkoxkywJ52aCfscMeEy+Fx5STh2eO+D49tF5zI6Ld0U19BMkslNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9/lYa/j; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61561dbdf14so67364807b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712618103; x=1713222903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyUIHRfCAjlDtpSvIRtUoFNFSXoqUQf0joMFOoV5o3U=;
        b=K9/lYa/jp6prmEfLMwI+0eg8vywjF5AS6ULA893TEFk3NAtuqQzD/qDsGNEgIhV1Ce
         DujRWEUhIxLtsFKfORll8x/yHkdwYHfQMK/mY4rYt9b+mYpVRIcaJOLPglmjlP0fiXFJ
         TPHtZdw9DyR4YTtyRXTVuXiW9Sgvv+5yhoAdquEORODAbmpPuTBYYmI4dTvHF1gISFh/
         m0/IfQYwGrHlrVESZg0AV+93z9fgMqe3v/u1XDqyNrQ/r8v9NPtT+Lr5A9e2NXXut5aq
         +XqlJL7ikceTRBQN0SgSTt/27dB0FDfcam+pFU2wdq9UQRivRkZfGCMhxI1FY7SW+bzT
         jsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712618103; x=1713222903;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyUIHRfCAjlDtpSvIRtUoFNFSXoqUQf0joMFOoV5o3U=;
        b=W4RvupaNmlqTrHyjB6Xub8AbJOf6Yzwc6KROaaB+CblGVuiyAJzsaZdTQek1jfy2Mr
         ipEcvdjusdp6W2w8I0AJSbKdPbpgK4Swd00ikVnAgLH8vT7Jt5+t+HOlBuhGawM7FQtL
         4xKNW5DmbjJCR+yT/1RFKpUGcDdStLJQ2VNuoJm+v64aS7t/grBWp8oUdKw1uXiyC+zu
         iC6hRIxptRUcSQURfvJ/srgq7/fVf3fQooODuCbXWVQPQaBqtNse4vbS/2psk44KQ6fO
         RdvgNxkfUq27c/hXIUcOPhdUB3VYe0U6M86+GxPISGEfsv2EMzhH3yMgW6qyB82htul5
         vaDg==
X-Forwarded-Encrypted: i=1; AJvYcCW+X7HS4GRE2mazg2ThTlaEFz9k/DduljtSsK1RnynxwO8r3M7xWjvx3SxSeeBnfitjAMDIS56HWuBzFW/mj3LhLntfQYRe0kaGfnBk
X-Gm-Message-State: AOJu0YwvZHiso8xp/ljeRkMkGQ0Vi4sLHJ4+S2SCM0VfCmxvyUhaxBl/
	8OHNNam5Lr9qG3VLtbgZ/7LYpxrKkKq9wJbaKn8uAWyluGP90/+UXVYCS9PEtMKyvh6WzRhhzuu
	elw==
X-Google-Smtp-Source: AGHT+IE3/k1q393IctUF8bjpLVCbrBuBXVYLZXFh+i0hQyGqBHqiXi49PbzgGkXsdYxTtNv5ROu1Xh/+mYs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2d07:b0:dd9:2782:d1c6 with SMTP id
 fo7-20020a0569022d0700b00dd92782d1c6mr332864ybb.1.1712618103073; Mon, 08 Apr
 2024 16:15:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  8 Apr 2024 16:15:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408231500.1388122-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Allow, don't ignore, same-value writes to immutable MSRs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

When handling userspace writes to immutable feature MSRs for a vCPU that
has already run, fall through into the normal code to set the MSR instead
of immediately returning '0'.  I.e. allow such writes, instead of ignoring
such writes.  This fixes a bug where KVM incorrectly allows writes to the
VMX MSRs that enumerate which CR{0,4} can be set, but only if the vCPU has
already run.

The intent of returning '0' and thus ignoring the write, was to avoid any
side effects, e.g. refreshing the PMU and thus doing weird things with
perf events while the vCPU is running.  That approach sounds nice in
theory, but in practice it makes it all but impossible to maintain a sane
ABI, e.g. all VMX MSRs return -EBUSY if the CPU is post-VMXON, and the VMX
MSRs for fixed-1 CR bits are never writable, etc.

As for refreshing the PMU, kvm_set_msr_common() explicitly skips the PMU
refresh if MSR_IA32_PERF_CAPABILITIES is being written with the current
value, specifically to avoid unwanted side effects.  And if necessary,
adding similar logic for other MSRs is not difficult.

Fixes: 0094f62c7eaa ("KVM: x86: Disallow writes to immutable feature MSRs after KVM_RUN")
Reported-by: Jim Mattson <jmattson@google.com>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 47d9f03b7778..a3358c80a88e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2230,16 +2230,13 @@ static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 	/*
 	 * Disallow writes to immutable feature MSRs after KVM_RUN.  KVM does
 	 * not support modifying the guest vCPU model on the fly, e.g. changing
-	 * the nVMX capabilities while L2 is running is nonsensical.  Ignore
+	 * the nVMX capabilities while L2 is running is nonsensical.  Allow
 	 * writes of the same value, e.g. to allow userspace to blindly stuff
 	 * all MSRs when emulating RESET.
 	 */
-	if (kvm_vcpu_has_run(vcpu) && kvm_is_immutable_feature_msr(index)) {
-		if (do_get_msr(vcpu, index, &val) || *data != val)
-			return -EINVAL;
-
-		return 0;
-	}
+	if (kvm_vcpu_has_run(vcpu) && kvm_is_immutable_feature_msr(index) &&
+	    (do_get_msr(vcpu, index, &val) || *data != val))
+		return -EINVAL;
 
 	return kvm_set_msr_ignored_check(vcpu, index, *data, true);
 }

base-commit: 8cb4a9a82b21623dbb4b3051dd30d98356cf95bc
-- 
2.44.0.478.gd926399ef9-goog


