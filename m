Return-Path: <linux-kernel+bounces-133717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3D89A7B2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A39283D77
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E66F08B;
	Fri,  5 Apr 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdAtFD/3"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3875D73B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361384; cv=none; b=VZCXkHWn26Uw+G3qCTmlMSKZ7p3galQszI/Yv+86vXEp9A8Uv/ZnTTIinvK9iCNatnXpYsYBZG/LSro08dZwQwFGUDX73FP7KXw7jgiiV7pD2oPL+mTowDIZuV2TIBlbCjzZwFdf1fww7PbpNlbi3yktk0Bllyy3Ex+esV1kF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361384; c=relaxed/simple;
	bh=H6nYKSnkJ9WM2desm7KNbB1Q8JvyoSy87GOitFOzshw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GJV+Wn5yUULlI043Yi2J3jac6lpp9rJsWxDQ1DRlz0CZeHnaP6jCbFUAu4vavQCJPzuDtTZ1Ju3KCIZUX+vt18S22wHLzCdoMXkaxbvej4AQ/ohCGcyr1baoy8WJd15+oIB6TPiw3AtMyN1MdOcSwoR9KlLlPAcxWwe4VVCuuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bdAtFD/3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed007e950dso904546b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712361383; x=1712966183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aBGD+1+NYJryR8MdWegT7yXPgS8gyTtoFLOwao+cTXc=;
        b=bdAtFD/3/yyQx5ZqMKWdJDnywaIKTtT6hHt7IeNwTfPDyIeVnTZtQpci2gwYs6GZ1E
         Etk0puekVsr8Zf+MJCoJgapmXF67idq6bRXOvfSvRsiHiUibjk62f/vcKb9+2doLsOWT
         KDYPJI4vmr6hf0fhJtMxAs8TfYDbeQYd8AkRMaFCS/7mp+DPrBgV9tjQeTxC+WkJTwFj
         8MLtWOuf2K3PXROfCvxEN54PhlBGxxsV9FmT2iNEqw4BVAX/QMYT+xuSFwHxdik1PHfs
         Oo0kaBt05+Jkb3omymypyz/Tyau/jB1/eELq4XeYlLWya75Orf8zM/9YO+gGXNBlZTXK
         WuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712361383; x=1712966183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBGD+1+NYJryR8MdWegT7yXPgS8gyTtoFLOwao+cTXc=;
        b=VNmFeuyRFciGULOZe8KTf6KdcOLZc11xPPYwlQQdxsCC1XcMI2LVchm8lNrrfuXTLM
         yeGKHwvB7rN9ah4R6VL3w6jW1yMysAVFql77ptGMB6k1kMqj0KELK1BVIG4qVD8odLbU
         HUnXGnUD7O2tJBC3mkmFwg26ZfR6Zwjo3J/v5VinpDn8It2Ks99wgXwFhwvQEVd3Y6hE
         vcbfritlUOts6ceUriKefm1XYbKaUUelpLFvzVjf/mZSF88hYlPbX9103JyftLey3ctR
         HrFUqV1w619w9sjjd86alUAmyGK9k1CNwGaJb+hAcoxxUMgJcLjMnvFZ4YZ270uHOLhM
         j3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXtlce2DiFloSYkBRYZS8JZa17ocd6Tk2fhzizn73XySNuMEIUnlF22pB2hG3zhzwiENZYusmqKDHNaOjqlhUTpc+dM+3SVUKFfcqR2
X-Gm-Message-State: AOJu0YxvGaXNOHT2WND25OncSKyERnVyOK47gVBa4kGRrd2S/pWjTIj+
	/z4KEEonYvPy9SX8FzU6V61iLi9DeGaRC2dphGowFtN47Ra7HRJcA+NbraJWRBeuUC+UAJmI3Se
	NGQ==
X-Google-Smtp-Source: AGHT+IF3TVd3OdDVtN3oDGrVy2/CgLa3AqQHgD0Q9oZH7Lgt1wEtK2sbv80Wz4fL6xGg/zn6ticXi0zpknM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:17a2:b0:6ea:f425:dba2 with SMTP id
 s34-20020a056a0017a200b006eaf425dba2mr228426pfg.0.1712361382841; Fri, 05 Apr
 2024 16:56:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Apr 2024 16:56:01 -0700
In-Reply-To: <20240405235603.1173076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405235603.1173076-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405235603.1173076-9-seanjc@google.com>
Subject: [PATCH 08/10] KVM: x86: Allow SYSENTER in Compatibility Mode for all
 Intel compat vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Emulate SYSENTER in Compatibility Mode for all vCPUs models that are
compatible with Intel's architecture, as the behavior if SYSENTER is
architecturally defined in Intel's SDM, i.e. should be followed by any
CPU that implements Intel's architecture.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 1fb73d96bdf0..26e8c197a1d1 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2354,6 +2354,7 @@ setup_syscalls_segments(struct desc_struct *cs, struct desc_struct *ss)
 	ss->avl = 0;
 }
 
+#ifdef CONFIG_X86_64
 static bool vendor_intel(struct x86_emulate_ctxt *ctxt)
 {
 	u32 eax, ebx, ecx, edx;
@@ -2362,6 +2363,7 @@ static bool vendor_intel(struct x86_emulate_ctxt *ctxt)
 	ctxt->ops->get_cpuid(ctxt, &eax, &ebx, &ecx, &edx, true);
 	return is_guest_vendor_intel(ebx, ecx, edx);
 }
+#endif
 
 static int em_syscall(struct x86_emulate_ctxt *ctxt)
 {
@@ -2444,11 +2446,11 @@ static int em_sysenter(struct x86_emulate_ctxt *ctxt)
 		return emulate_gp(ctxt, 0);
 
 	/*
-	 * Not recognized on AMD in compat mode (but is recognized in legacy
-	 * mode).
+	 * Intel's architecture allows SYSENTER in compatibility mode, but AMD
+	 * does not.  Note, AMD does allow SYSENTER in legacy protected mode.
 	 */
-	if ((ctxt->mode != X86EMUL_MODE_PROT64) && (efer & EFER_LMA)
-	    && !vendor_intel(ctxt))
+	if ((ctxt->mode != X86EMUL_MODE_PROT64) && (efer & EFER_LMA) &&
+	    !ctxt->ops->guest_cpuid_is_intel_compatible(ctxt))
 		return emulate_ud(ctxt);
 
 	/* sysenter/sysexit have not been tested in 64bit mode. */
-- 
2.44.0.478.gd926399ef9-goog


