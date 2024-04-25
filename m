Return-Path: <linux-kernel+bounces-159000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE1E8B27F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED9B1C21004
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED87152172;
	Thu, 25 Apr 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PruVeND5"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBF14F9EF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068870; cv=none; b=qSKZQ0Kn0gK1ZHu+fHmZzCZZiW7zl5Tp7vKrosgceFmKrEuOZRTlvZRGlEW6/SzSvfCTh6NhpeXMFORKuiRZ8KnOST6XnIVYnNMF1hyhl+RefgUQp5mRlIHRK93xQwaMlMSq1ffBXADHEkw6H78Ru/UUYzh7lAvjaZ5ecJwfayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068870; c=relaxed/simple;
	bh=puiewvMq7VQ3MSCBcWLocV/OvKUjYEGDnK6E7gHhlaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UKIdy6o/pcKkPetrfnEFAA9maZ8BgWDqEASBdp88i02+aIu4t5gVDM1p9PDR+ly/ecTZyYht14O2UNBP+RVw0Rg1jdWzQzoPeB2x65Ysm6/NJoF+Nn8IF92EKsxOBkNrXoAZ9/0zSAWwqg7okm6fNQgrPYZnW6FN+ufv/w7NkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PruVeND5; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45c577ca9so3010970276.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714068868; x=1714673668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bwEBzadNGVu08MehwcHFWlb8XgA5vulEsBKMYAk18b4=;
        b=PruVeND5+AnfyRifT/iGvcEpJmvsSslyPJ8T9is1pNzWo2RndY2vJzjksAvSEAkqu8
         PTKD1nWhRYPNLUsCN3+0D7cWn7ojHV5SXBNWLnfvC0ikxPJo9mGdQWHpXG/gp8ceO4ZN
         r13wgt/hoUd1AVpqFhVsj7DxzfGVXA0fLXzPRrc3vLyzIbF747bAV8AQ7KmqdwlD9fi+
         dshyoVOrl0lMj/zJ/INlZsatik69rWlOP9WiGiZKMUXd676PDIscIEEmJIXb+O3sPWRu
         yac72LsadvWVBjJmSSKcDySy0knL+BmXZrqzW3c/vTqEeQ/esDGwu5RNz4IG335Gt8O6
         KKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068868; x=1714673668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwEBzadNGVu08MehwcHFWlb8XgA5vulEsBKMYAk18b4=;
        b=GBd9sy1Bk4pPedkjwwucodvDSEqAksYL58MuQ355nqVn4Itz244hCFaLMm3AH1vH3W
         v67Q4zQmg4k+d9PuGJ1bhi3kT1hWvuYaENHUhVzRAFZTtwtEuE8T37GcLFGIIKaMsjl8
         jaX6bBK3XuKnbAxKvD3AITKyeloc82yS/fM90BSXJoR5yJyF/Nr0QrUIPmNLH93iAHdU
         CW4i0FYH60Ulv7RJtX6I4N+E5Gce8WntJWRK4cb3n8iBAjyW6Tc/To1yVv/dMvAydjGz
         R6rgVRQgjT95vnC0r2AZ1rWLG2pNnbOVxXIS2GN2qGTuv8RGd9MVGXQYFj2+Q1+vS3Ft
         gfvw==
X-Forwarded-Encrypted: i=1; AJvYcCV98RY/DUxifxtZnijlbQJPuaTku6Eqj/unzgE/bzoG4RXe2C61s5vr/ozmGwj9wmll1iKEyKOkagu2MYjrHqyQIDE0LtZXYvvGb4cb
X-Gm-Message-State: AOJu0Yw0R3naazIfKtlqlt9Rv//Xfq3DmogWcfYOWjrVaTKBHfQcGSFV
	J9M6T7I+oa0ruE/2oUdOLCUX0JYzxVM2iWUYUAFVi2alflC+NJoI0cBkk6Qqn+/I9sxPVlkGQLr
	61g==
X-Google-Smtp-Source: AGHT+IEdr27nAL6TTBgRfhhpiXP0Na4QEfa+A2U/3wduykWma3sUjuk0A0CXUovCOClCtXc5FotAoWMmAq0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1b0c:b0:dcc:2267:796e with SMTP id
 eh12-20020a0569021b0c00b00dcc2267796emr892328ybb.2.1714068868004; Thu, 25 Apr
 2024 11:14:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Apr 2024 11:14:13 -0700
In-Reply-To: <20240425181422.3250947-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425181422.3250947-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425181422.3250947-2-seanjc@google.com>
Subject: [PATCH 01/10] KVM: SVM: Disallow guest from changing userspace's
 MSR_AMD64_DE_CFG value
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Inject a #GP if the guest attempts to change MSR_AMD64_DE_CFG from its
*current* value, not if the guest attempts to write a value other than
KVM's set of supported bits.  As per the comment and the changelog of the
original code, the intent is to effectively make MSR_AMD64_DE_CFG read-
only for the guest.

Opportunistically use a more conventional equality check instead of an
exclusive-OR check to detect attempts to change bits.

Fixes: d1d93fa90f1a ("KVM: SVM: Add MSR-based feature support for serializing LFENCE")
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0f3b59da0d4a..00f0c0b506d4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3142,8 +3142,13 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (data & ~msr_entry.data)
 			return 1;
 
-		/* Don't allow the guest to change a bit, #GP */
-		if (!msr->host_initiated && (data ^ msr_entry.data))
+		/*
+		 * Don't let the guest change the host-programmed value.  The
+		 * MSR is very model specific, i.e. contains multiple bits that
+		 * are completely unknown to KVM, and the one bit known to KVM
+		 * is simply a reflection of hardware capatibilies.
+		 */
+		if (!msr->host_initiated && data != svm->msr_decfg)
 			return 1;
 
 		svm->msr_decfg = data;
-- 
2.44.0.769.g3c40516874-goog


