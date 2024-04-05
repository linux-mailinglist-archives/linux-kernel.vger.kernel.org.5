Return-Path: <linux-kernel+bounces-133718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BFB89A7B4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5321F1F210FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0975476035;
	Fri,  5 Apr 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQS684c4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88B70CC8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361387; cv=none; b=P1AZPJE8N+0lkkSaphC0djB2nif0VGn4bwnDnXY0isgcW+3Qur6eoDzq9wmk032Cu3WDCehDy97berdMPvrl4ZdI5V+TmH66x5Z5hovDPxYVqMKdGMBdimlgbrR9MaRsIrPCRx1RdXGPVSLPwJ7MwRtUAxC2mORf9qdYde/fZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361387; c=relaxed/simple;
	bh=b/B5Yxc1o5uGiHJ7jeAtZBsI3i+lBvUWpy7nGRTLMZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=doHf4X4/gMj5IDgdf0H09bY6aeS32TUE9lNpBpkK07RelDufPI65OsmSqrVMHu0s5n94pqehGkp5zrMb7A8CGYPpT7xMd60Z+KDJzieurIzhgm7m2xrvkbjj7HI8GKXoA1TT7etU7LaPJVJ7/mgB48SpXchV1k1GkffgzYV0Yms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQS684c4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6152135cd23so39789637b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712361385; x=1712966185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2SJx+1wJFr0pWJuRZAhG+dHu/wPMI/D+PKH1v3GyCs=;
        b=nQS684c4a9A+0qoXhwtNKGH/328FgAm+mK/aUdb5JEBu6YSUSstc1ba8zBH5XT4fJx
         RyGRKnkCYWI4PsS424HbZE2lowr1+qvVI9v5aJaFbuDhJFCiqjJXvXpWf1MuAHVRe2Ww
         B3C9mWKHEqQ/akKPqJkMY2eyKLAIV4xVjQdBqE/K1q2E/+l9nMSjB1eorYvv8BahuNaX
         dYcqck083YKCYCt22vQIzCivsYHIkZASNUSXz/FOL8A3Oa7FFOCSVPZsk0VkxyuZu9eX
         Jn2a+MLxj2HCPcwOIInZNQPTkjXD0HhTIootK/STwqg5kYi66l9KIlrhZCyNyfNiqzT3
         iisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712361385; x=1712966185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2SJx+1wJFr0pWJuRZAhG+dHu/wPMI/D+PKH1v3GyCs=;
        b=jLozQRCSfJXlSgWNory6Ln3NwOcPMvjc8tGD+PbxifVzzLEehq/83rErkLjnpUrwul
         Q8setqdRFDR2QpAWtTb85KMyq8pSr9e4Zgon1jkfS5aZ5oG2FIrEJ4FOwjecNcRYujqn
         /7+JfuxCIHf/F9wGCYNB/qfQ2mohKKviThhY1OzumylS2d8iaAk4t6hyaPyYdYXKnmEU
         JgrmSrpkt/rmFln5HUWg5rF2DBfOp66XxvsxfQmi0dhjQBmCqrZ8rKu1Em8jzvtzZxQl
         V4uRQWv0/6IFN2G0ZlyaZ/yqQoW4YtQc8ZUaPZwvUZFlkaiQ0q4M94Qu9zBovMTVpdv2
         oaGg==
X-Forwarded-Encrypted: i=1; AJvYcCXaHuOALMBFF12H9VomPNzomPvw8OCW9BRnrH+pULlDIV9XkRWBumihVZaTb+JQwaVYZgfCCeGRWA2EChotwDt8eKtAk3guR6Y8hCIu
X-Gm-Message-State: AOJu0YxJauqWunNUvTNnJayaI7Tm0z1UPn+q9r2aCBEt1wvwsvKB20KS
	1FkeRVDAiJAVongiShbGH0Wi5AJEeMpulVwqi3k+J4meUc2s1kGnvLMf/PmGwG5QO2QuIPMYz34
	1lQ==
X-Google-Smtp-Source: AGHT+IEAQcVWaY2kxMZHD+fyUuyDnGFHrg0CbB+w3iHQiSVLJqyqN5x6yG2JtfvWF0cd2xOm/IS3a+FB7Bg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:8341:0:b0:615:3072:1934 with SMTP id
 t62-20020a818341000000b0061530721934mr659372ywf.10.1712361384736; Fri, 05 Apr
 2024 16:56:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Apr 2024 16:56:02 -0700
In-Reply-To: <20240405235603.1173076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405235603.1173076-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405235603.1173076-10-seanjc@google.com>
Subject: [PATCH 09/10] KVM: x86: Open code vendor_intel() in string_registers_quirk()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Open code the is_guest_vendor_intel() check in string_registers_quirk() to
discourage makiking exact vendor==Intel checks in the emulator, and to
remove the rather awful #ifdeffery.

The string quirk is literally the only Intel specific, *non-architectural*
behavior that KVM emulates.  All Intel specific behavior that is
architecturally defined applies to all vendors that are compatible with
Intel's architecture, i.e. should use guest_cpuid_is_intel_compatible().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 26e8c197a1d1..1acd97c6fa53 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2354,17 +2354,6 @@ setup_syscalls_segments(struct desc_struct *cs, struct desc_struct *ss)
 	ss->avl = 0;
 }
 
-#ifdef CONFIG_X86_64
-static bool vendor_intel(struct x86_emulate_ctxt *ctxt)
-{
-	u32 eax, ebx, ecx, edx;
-
-	eax = ecx = 0;
-	ctxt->ops->get_cpuid(ctxt, &eax, &ebx, &ecx, &edx, true);
-	return is_guest_vendor_intel(ebx, ecx, edx);
-}
-#endif
-
 static int em_syscall(struct x86_emulate_ctxt *ctxt)
 {
 	const struct x86_emulate_ops *ops = ctxt->ops;
@@ -2622,7 +2611,14 @@ static void string_registers_quirk(struct x86_emulate_ctxt *ctxt)
 	 * manner when ECX is zero due to REP-string optimizations.
 	 */
 #ifdef CONFIG_X86_64
-	if (ctxt->ad_bytes != 4 || !vendor_intel(ctxt))
+	u32 eax, ebx, ecx, edx;
+
+	if (ctxt->ad_bytes != 4)
+		return;
+
+	eax = ecx = 0;
+	ctxt->ops->get_cpuid(ctxt, &eax, &ebx, &ecx, &edx, true);
+	if (!is_guest_vendor_intel(ebx, ecx, edx))
 		return;
 
 	*reg_write(ctxt, VCPU_REGS_RCX) = 0;
-- 
2.44.0.478.gd926399ef9-goog


