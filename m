Return-Path: <linux-kernel+bounces-60090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91E584FFB7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163821C23743
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D063D0BA;
	Fri,  9 Feb 2024 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLAyxBTW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24C3984F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517031; cv=none; b=BvvyMKOvOhQoQNVqsk6WJSChAHRTekQcO33hGIHX3w90DxcZYebGhATYSzX4KuTFYn6Y9WRozWUZnVtkQ1S3LnkEfcyccdVmoq/BAKok4I0rdwU4I93Jdk9XgLpHiq7+di8LEgK1QPjlK4J/01zWRDPy6axhX9XUqk65vEw3CQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517031; c=relaxed/simple;
	bh=5ROcmTVvSgXvIbGuiN/CZtA5rWbe5pIknCwUED8ic5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vCdEF5RxzvS7gnFtFUaDSFak9s203S36V+m1xoOBKh9dn+x9VXqUikaCFn3t7Ufm2P3Z5OwDw/JKzvjOgVR5NDL5jH3021dEr5h5hg6WMf2aAGAwNU/008cj4ZC5oNuaXTlZRAxu0u6iuGCB/hwSqMLK4Kd+Q6i2FPw90Rxr9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLAyxBTW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6049520940dso29909037b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707517028; x=1708121828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xriXj5ETw+SM6HIrjBhtRYR+FpAUxlK2qVu7eV3/IuU=;
        b=GLAyxBTWGWdBIiHRzZZ2cDdHVFRWzPWB0gVp6BnC9IrZBal8Uom1oqFhpI+RXcY6cX
         I+iz04yAbfy9jFA7RMYaSJMP1h1uw1jE+d3N/zVMVfFoh2yV0WL5zJw+vBIhc9XANZvb
         zT1igYLPYy1oqbKNCf9NNkTNTyRBJRtVONL7AVmLMNS4UGi1Pxhq77N9UEzHsyeey99s
         5oIuiN2nilmffCHvWblbG2yfFPopqqu7XgCaYn8QcjEdnQqwuj1Jf62Fg20DMP2iW9tN
         ZK5gNr+mZbtg9/HAKOuiCBkd6qR0G0gTT02qUbRcfV1IQRIocC0UfDTJJt9GPN2pbzeJ
         3Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517028; x=1708121828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xriXj5ETw+SM6HIrjBhtRYR+FpAUxlK2qVu7eV3/IuU=;
        b=uFPl2xlgWuNQCEmOx0yok90hW56G8wAE7u17I7kE2te/dHKAII0NwlpHIfQMK/TYdF
         vAVR5QJw8nkY//vrSrHyh9PWgjY7I/MWcfnXucUxET1sfRPZpOOKLFpCNTmlFW1clrVo
         JRzW/UPqJi/sghB0bvAaG62lKR8dhmuPVQGdZhYtU7tNQbecDphqDopoKZtTxf/hDIW2
         bV87P1VfPricTRV1eV4d3N+HUQyiGMYIicop9vl/vcAGgcKMQT5IGbRTy/Vy82UVkTNx
         y5hlUcdu7Fsl6/RTjj6F2xtioWzf855bP/4FCQCIYB5Laye1NkPOPgIOLz8t8eBwLUYI
         FzMg==
X-Gm-Message-State: AOJu0Ywy0/mY4z1AcjGfnfGMKjvLABl4APFJmSYTozSHGM9doxKQoEfV
	eq1yu/rrbj4HyCf0tn+VS7CciXRqR442xoM1FVfsKfbvH6IjrMWh4BXBh6d0WLbMWix9yGGPYT7
	1Vw==
X-Google-Smtp-Source: AGHT+IFBb4C7Le8Uy1i1H/KekvmVJQcT8a1e7ObuqcVXCQx3MQ2cKGmrti4S38CyLF4p9XbPUBMPk0eKB5o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:d82:b0:604:ac3b:75d5 with SMTP id
 da2-20020a05690c0d8200b00604ac3b75d5mr123597ywb.7.1707517028741; Fri, 09 Feb
 2024 14:17:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Feb 2024 14:17:00 -0800
In-Reply-To: <20240209221700.393189-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209221700.393189-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209221700.393189-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: nVMX: Add a sanity check that nested PML Full stems
 from EPT Violations
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a WARN_ON_ONCE() sanity check to verify that a nested PML Full VM-Exit
is only synthesized when the original VM-Exit from L2 was an EPT Violation.
While KVM can fallthrough to kvm_mmu_do_page_fault() if an EPT Misconfig
occurs on a stale MMIO SPTE, KVM should not treat the access as a write
(there isn't enough information to know *what* the access was), i.e. KVM
should never try to insert a PML entry in that case.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4d0561136e70..29df186dac84 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -416,6 +416,16 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 		vm_exit_reason = EXIT_REASON_PML_FULL;
 		vmx->nested.pml_full = false;
 
+		/*
+		 * It should be impossible to trigger a nested PML Full VM-Exit
+		 * for anything other than an EPT Violation from L2.  KVM *can*
+		 * trigger nEPT page fault injection in response to an EPT
+		 * Misconfig, e.g. if the MMIO SPTE was stale and L1's EPT
+		 * tables also changed, but KVM should not treat EPT Misconfig
+		 * VM-Exits as writes.
+		 */
+		WARN_ON_ONCE(vmx->exit_reason.basic != EXIT_REASON_EPT_VIOLATION);
+
 		/*
 		 * PML Full and EPT Violation VM-Exits both use bit 12 to report
 		 * "NMI unblocking due to IRET", i.e. the bit can be propagated
-- 
2.43.0.687.g38aa6559b0-goog


