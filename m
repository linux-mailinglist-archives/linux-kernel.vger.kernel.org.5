Return-Path: <linux-kernel+bounces-159009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E098B280F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7996A1F21F08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42726156C65;
	Thu, 25 Apr 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6jRa0OD"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C02150990
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068889; cv=none; b=JsO4X7RNYutxhp8vcxBAqqdFufcrDj5sTQ/8YYxMgKfgSiK5syBSOH7r6Vc8xv48Rw/JMV99Xi768Ha6X2kCowkCZ+t12ZpdfgfQO9Nr/qXdLkBHgOvS8F0IQAE8+uMNeEnlnK6OBDH02EsAkwVW01IluZzJWG0nRzBCK2wUVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068889; c=relaxed/simple;
	bh=h3nH2RXwDRleABI7UvTpJNwiSjFJO/iubybYunLFYQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M5xB7pIkVNNr+fuOSDnv4X7FGFhvpshf35sf7lPZirrO7XiaRV55FXEXR/+9f9/NWY7/sFzkpiswKqIdAnVfccqGy7c2ueSWvIUvQ09vro67UXUmLnrWBo/BgIPJAL0+HpmHPlRzP8+3jiod9c10E0KXuVA5C/gt9W8Fgs97D0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6jRa0OD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6150e36ca0dso23829217b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714068887; x=1714673687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7x2xDm7ORIVYu8+DJIH/haFx3NIITex91VRf9yc3OHU=;
        b=f6jRa0ODT67ORWX27GVK/+mTZ31jdHbXp/6k3hpIfU/jHbO8lCsZAAGv8q6TDhrwnt
         iGlQdIiqywZdu8dD5gZSdyqYjXuGKkJhCy5DuFfcf8ZCG3gNuSJpTz6a5SZGZIJUrLnB
         XUHPvzcNBNIqNru0lO1hPsf02GKQrU7y9s4eXm7swjbYswE+UOp5jWWTtBkFRulndO7f
         F5hQbSwxevLP4xxsPF3U1N35v9yyPGyHDL0IU5+3p2BZdthJ7ZDDTaH7MMkg6SgQ81Xf
         9jqp3FZQo43e5Je8X6t32xRuPg1MSz9Qm/vgRi2EECB1PUJ/TzJA58TdDk0ONWNB2Scm
         g8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068887; x=1714673687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7x2xDm7ORIVYu8+DJIH/haFx3NIITex91VRf9yc3OHU=;
        b=Cy082AkguOVPdJjxeeip4K7FNo6LTuSRGoyEG2sHA6UTuBU8bZDvUpKbLP/b8zjG7f
         sp/uek9dRL89kbCW2iRDQnXh666uK+rOcCNyU1/9xH1DKlvwpTk3a82fUf9Gww6DwD0R
         INP+ySUsABhztJN7rhC17NTIgRAUtMiSKfpxUzQbQpdPRHlpOoF1YxfetyfkcCj3s3yg
         HOIkZEZG5oU4c2cO4k17J3itGHzj+D6Od0KGVlfAaVs6clXeWvRhPRh/WvLvnrL/kOT+
         J7+hPrenXuL57fMn+Tvc0w86BBVyNT1Hv0oOHzklE99/KgYc3Z8MQ4PKZQL+TyPSbTkK
         xnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXclZMwCOfmvfeo4E014G5beWW27xo1Dnk/FSyX96yJcrFd0qTe+vtQyxULyLlo8wQHlRrA9jZyFs4Km/qxFp69DP5VSP+k0mKdT9b0
X-Gm-Message-State: AOJu0YxpjEgR9gBpFoVQJQshWrwT2H/mNlVr+j8McrC1RsLG81wUYUIb
	Ag2WV0rrsFoBkWk9KOd9Oji5cKJwglAa6ff52V1nR0hIzHJ0AAv3wimf0/7K4SuDq704IMYoHZ8
	39Q==
X-Google-Smtp-Source: AGHT+IHGxfcO/CIV3+AB7r4yk31j4bBnsDca+v9/E+BSPM3jBz9ZdrHoD7SFSvI0zaKSkrDLyCCPkzvrZLU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a106:0:b0:61a:d016:60ff with SMTP id
 y6-20020a81a106000000b0061ad01660ffmr36102ywg.2.1714068887134; Thu, 25 Apr
 2024 11:14:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Apr 2024 11:14:22 -0700
In-Reply-To: <20240425181422.3250947-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425181422.3250947-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425181422.3250947-11-seanjc@google.com>
Subject: [PATCH 10/10] KVM: x86: Suppress userspace access failures on
 unsupported, "emulated" MSRs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Extend KVM's suppression of userspace MSR access failures to MSRs that KVM
reports as emulated, but are ultimately unsupported, e.g. if the VMX MSRs
are emulated by KVM, but are unsupported given the vCPU model.

Suggested-by: Weijiang Yang <weijiang.yang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4c91189342ff..14cfa25ef0e7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -491,7 +491,7 @@ static bool kvm_is_immutable_feature_msr(u32 msr)
 	return false;
 }
 
-static bool kvm_is_msr_to_save(u32 msr_index)
+static bool kvm_is_advertised_msr(u32 msr_index)
 {
 	unsigned int i;
 
@@ -500,6 +500,11 @@ static bool kvm_is_msr_to_save(u32 msr_index)
 			return true;
 	}
 
+	for (i = 0; i < num_emulated_msrs; i++) {
+		if (emulated_msrs[i] == msr_index)
+			return true;
+	}
+
 	return false;
 }
 
@@ -529,11 +534,11 @@ static __always_inline int kvm_do_msr_access(struct kvm_vcpu *vcpu, u32 msr,
 
 	/*
 	 * Userspace is allowed to read MSRs, and write '0' to MSRs, that KVM
-	 * reports as to-be-saved, even if an MSR isn't fully supported.
+	 * advertises to userspace, even if an MSR isn't fully supported.
 	 * Simply check that @data is '0', which covers both the write '0' case
 	 * and all reads (in which case @data is zeroed on failure; see above).
 	 */
-	if (host_initiated && !*data && kvm_is_msr_to_save(msr))
+	if (host_initiated && !*data && kvm_is_advertised_msr(msr))
 		return 0;
 
 	if (!ignore_msrs) {
-- 
2.44.0.769.g3c40516874-goog


