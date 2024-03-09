Return-Path: <linux-kernel+bounces-97730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E12876E8B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18323B21386
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CA336AEE;
	Sat,  9 Mar 2024 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s85dU/Wv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1B2E631
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 01:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709947660; cv=none; b=LhkjXnqIRCrf3JJ0aTJ1XNJwVKbSZliW7vN4CKAHYji130e78GmowGfbePllrTdyaF0Xw09LB16aGM55F9gKGhnOyKw9AK/pYFQsMOdqBqw+BPcsHuxhj5wVGUdhEafIy2GRiWDgZdz/vDypBCwqZFdulESgM+Qw62tifKF4rGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709947660; c=relaxed/simple;
	bh=cSo/9H4LV+ugQDK8WH64MT/A8kylvoerz+EThSRDTZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tZspA6pzvPLX6sdTybKaXgGRiiK4f+JLO7wLTx9oV5aOqz7/jonitz+NqUvlFxzsfzqMwBH9ojxeSiNdhXpShhFuxzzrEmiCAmOzgy1t3ca+bUhNhFOeScwo64JUUHW20WzCeHgUBPLo5VlzHByLzjc4wqSlsPOIPVr1C1KS7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s85dU/Wv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609ff3206c3so32385927b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 17:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709947658; x=1710552458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J2mk3yjINFLzpjFivjrb5N/1XLkVh6F5pa6/JTyW+Xg=;
        b=s85dU/WvNT6ambJeTz55S2TJcT8bgzf2wWEEFHu0dKcS3Qv6uzfwJAbFAgJSxuuLYo
         EchOugvVQNajRruIO3ECwj6usk2UZ5X+H1T0BffxnsCm4Irs0Pxi+c72NdTC4y6ViRwq
         2xZ7ZoWgyBp/u0zLjKDXSG1rUBU3jhk5d67edHlWz20p95ID/dXyB7RJsn4vj7mDbCBs
         v94oKwCfjaYeAa1mRxKfMA40cGFFwFHnmbq5eqJwcMMnbyaeaSndEXWPCjIgTIUbUFXd
         i05LAOZpzKVt4Dzv+fJvAGoxILN1zvTBkEa+aPDQAQ3PU9f9q22RmFbnOevnoERbpwiL
         uC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709947658; x=1710552458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2mk3yjINFLzpjFivjrb5N/1XLkVh6F5pa6/JTyW+Xg=;
        b=tfrv1qcJHHBlZNWkxV9wVM+1UIseFTEx4NGaHnYoJUUbR8LJVXYJi07/DAuEoYCqpz
         t257vf68akpRwg4WKklnmwPWvnMO8da4W1NieNRdo9sK9BBG5DDW993SKpmdGKVyAj/M
         eXreLXj6trUOddlqVCqve5yho7rEsNwyadbEWCr/owMfBCLJpCz0dnuZdenv93sWAM6j
         qjPVXiN95/jBI0eie5Fy+Rtbwzz9pzAdwVfwUMnfG8+RXfz5/hKjZz5JWvSNaoOmHBZP
         dJIwphlKE/4xMLlMocNoIN9RX7tnO0WP/qJoCUSj3o5vWvKUUsX9TPdBZ0OkydWgMGSv
         OYXw==
X-Gm-Message-State: AOJu0YzKg79P+Eu26yVJigXYBlH0CesayDBP+WfuPOUTx7Op8XCPq0tI
	g5r8jPQ7INYhDSyVm/ZdaF1Fzl1TXUIN+w4Kvi3vFE+3z08wGWxD/Nb42wJImqA3LRape/roTfx
	yew==
X-Google-Smtp-Source: AGHT+IHrI5FDrUBoUl0r6JtHEuthwtAy7BhRUu74r7xvlQts2botI/ZyPUrf7LiPIj+ypGRGHDyvqTmpyOU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ef46:0:b0:dcd:88e9:e508 with SMTP id
 w6-20020a25ef46000000b00dcd88e9e508mr185467ybm.5.1709947658336; Fri, 08 Mar
 2024 17:27:38 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 17:27:20 -0800
In-Reply-To: <20240309012725.1409949-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309012725.1409949-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309012725.1409949-5-seanjc@google.com>
Subject: [PATCH v6 4/9] KVM: VMX: Move MSR_IA32_VMX_BASIC bit defines to asm/vmx.h
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Shan Kang <shan.kang@intel.com>, Kai Huang <kai.huang@intel.com>, Xin Li <xin3.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Xin Li <xin3.li@intel.com>

Move the bit defines for MSR_IA32_VMX_BASIC from msr-index.h to vmx.h so
that they are colocated with other VMX MSR bit defines, and with the
helpers that extract specific information from an MSR_IA32_VMX_BASIC value.

Opportunistically use BIT_ULL() instead of open coding hex values.

Opportunistically rename VMX_BASIC_64 to VMX_BASIC_32BIT_PHYS_ADDR_ONLY,
as "VMX_BASIC_64" is widly misleading.  The flag enumerates that addresses
are limited to 32 bits, not that 64-bit addresses are allowed.

Cc: Shan Kang <shan.kang@intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
[sean: split to separate patch, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/msr-index.h | 8 --------
 arch/x86/include/asm/vmx.h       | 7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index af71f8bb76ae..5ca81ad509b5 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1122,14 +1122,6 @@
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 #define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
 
-/* VMX_BASIC bits and bitmasks */
-#define VMX_BASIC_VMCS_SIZE_SHIFT	32
-#define VMX_BASIC_TRUE_CTLS		(1ULL << 55)
-#define VMX_BASIC_64		0x0001000000000000LLU
-#define VMX_BASIC_MEM_TYPE_SHIFT	50
-#define VMX_BASIC_MEM_TYPE_MASK	0x003c000000000000LLU
-#define VMX_BASIC_INOUT		0x0040000000000000LLU
-
 /* Resctrl MSRs: */
 /* - Intel: */
 #define MSR_IA32_L3_QOS_CFG		0xc81
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 4fdc76263066..c3a97dca4a33 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -133,6 +133,13 @@
 #define VMX_VMFUNC_EPTP_SWITCHING               VMFUNC_CONTROL_BIT(EPTP_SWITCHING)
 #define VMFUNC_EPTP_ENTRIES  512
 
+#define VMX_BASIC_VMCS_SIZE_SHIFT		32
+#define VMX_BASIC_32BIT_PHYS_ADDR_ONLY		BIT_ULL(48)
+#define VMX_BASIC_DUAL_MONITOR_TREATMENT	BIT_ULL(49)
+#define VMX_BASIC_MEM_TYPE_SHIFT		50
+#define VMX_BASIC_INOUT				BIT_ULL(54)
+#define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
+
 static inline u32 vmx_basic_vmcs_revision_id(u64 vmx_basic)
 {
 	return vmx_basic & GENMASK_ULL(30, 0);
-- 
2.44.0.278.ge034bb2e1d-goog


