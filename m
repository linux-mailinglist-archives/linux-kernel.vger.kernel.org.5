Return-Path: <linux-kernel+bounces-103702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C4287C324
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849601F256B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62E768EA;
	Thu, 14 Mar 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7h1zFPT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F00763F3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442513; cv=none; b=MBazmkeY/6+VyLFmyrb64HSjBBYFxN9kkZsnW0/jrGlrVCyuVvcdbWdnfWYNKOZoeOuvIu3+Yum1jwOPJinrrL5HI1F/mRw8N7jerzYmLChpZnKSzWaZ2fa5eKb0vRBAtqBfaPDeXxl8qO3nhpHW/yiORHj4qtKSquVdhlSNddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442513; c=relaxed/simple;
	bh=iOEWUnvMcKbJVvSSFCN/LBW8KrePKwutjmximUKTeCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OmJp/TngSSHy6rfFADVEggSsczBH8NwBFed00U4P9uva33gj2WfUKTq5jSiP9Z0MOkJK5g8Ad0mTMYOpnwiown7ZD7bBkCNCH44K2pKzEuokr8pGv10EH4t+BtNZ7JsFZeW578C6z+CLCBnfpfgge9903xbXB7Lt/9i7Yp/hTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7h1zFPT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so2107418276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710442510; x=1711047310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SXV3IRJxaCu6BKITriq5GONv2Stn6rDuSzNVATcf3ok=;
        b=I7h1zFPT+IO1DoZIfs1y7xma6seA+BGighd9b9wjtK5bip3FDL3/AUY8EEI8MbYv34
         PAaQkuRohSboGdw8TvMn0JeRLU92MpnawPUpFWgg+oINmbAARSCpZmBQxHoFQVWmzt/q
         UmcszwU+s6kYQzvRQuOp4Ym9GaGWN/XyUbK74Dl5EAYq+h8MAQozpwJYPZTXoA8Ro0KM
         8zt+vlpbVRP4GHq6pMKyDcxdj5aSKzTP4KjQl+65QqALtDpD2mynsusb/4YcOixOsWmv
         VAiSREdj9ZEYNaK7wONQOSMKuk2pAaHrGnRB/whJkgwjybHU63ftffEccDWNOrPGLi8L
         efug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710442510; x=1711047310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXV3IRJxaCu6BKITriq5GONv2Stn6rDuSzNVATcf3ok=;
        b=YKCChy+FKMBN9KsrAVMsBjcVgG37bYt4xpvpQ4elI0Q9PG9VAEumqD3j+qiiXLC+e9
         9Cz7r5wCNCur0nho8Pk+07uS/nYcTYHCcE9piV7Z6e0+QcUeQ1w6K/vyez6poyoJLCoY
         L+DnP0ZEsSEgnXkld1XgcUzv4ZC7WIbl/KCZEBrcBkEccwEv+5XuBI0x7kLV4y987p8Y
         Z2XyIluDXxapF6lfrK7ouvECxaV5JDCOes8v3Q4DQWP6qkHRUmfjhF47j5hjU7XRmvha
         UY8L7yWPSLiJk0BHeQeOM/SmX1Z4vQzmPGhsVp+MGeLQqPRcLSzDZaFc3OrlN1A43h/k
         eFDg==
X-Forwarded-Encrypted: i=1; AJvYcCU/s43IWNy3OUM1/YAXfPetQK6qFaXL9Z1J6lsRBYZmvAo65GVlIXovKN9Da3nwE0FQKuUNo6xd5fkzjBPzndz8z02m6LTivlk444Ib
X-Gm-Message-State: AOJu0YwpD7YHX6q1OZuaGtZ3BN/L59r3YJmfRcIqbngwbQ3qm1Q2r6G+
	XV2USZWDgya3zstBS1VDJ9uYfoqy6IV4ldubWzQvOExExcPj7vNi/OC0cg5HHkoqYysBtx1gaYZ
	uzA==
X-Google-Smtp-Source: AGHT+IFNVe74LE8W8P7Yaw4D0J9QhZPSNUyoxo07UooabXpjGUfUAjGuX8DB8V93Lg5hvCPkskdsrUZukWY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1004:b0:dc7:5aad:8965 with SMTP id
 w4-20020a056902100400b00dc75aad8965mr106806ybt.0.1710442510714; Thu, 14 Mar
 2024 11:55:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 11:54:58 -0700
In-Reply-To: <20240314185459.2439072-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314185459.2439072-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314185459.2439072-6-seanjc@google.com>
Subject: [PATCH 5/5] KVM: selftests: Randomly force emulation on x86 writes
 from guest code
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Override vcpu_arch_put_guest() to randomly force emulation on supported
accesses.  Force emulation of LOCK CMPXCHG as well as a regular MOV to
stress KVM's emulation of atomic accesses, which has a unique path in
KVM's emulator.

Arbitrarily give all the decisions 50/50 odds; absent much, much more
sophisticated infrastructure for generating random numbers, it's highly
unlikely that doing more than a coin flip with affect selftests' ability
to find KVM bugs.

This is effectively a regression test for commit 910c57dfa4d1 ("KVM: x86:
Mark target gfn of emulated atomic instruction as dirty").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/include/x86_64/kvm_util_arch.h        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h b/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
index 41aba476640a..d0b587c38e07 100644
--- a/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
+++ b/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
@@ -5,6 +5,8 @@
 #include <stdbool.h>
 #include <stdint.h>
 
+#include "test_util.h"
+
 extern bool is_forced_emulation_enabled;
 
 struct kvm_vm_arch {
@@ -22,4 +24,23 @@ static inline bool __vm_arch_has_protected_memory(struct kvm_vm_arch *arch)
 #define vm_arch_has_protected_memory(vm) \
 	__vm_arch_has_protected_memory(&(vm)->arch)
 
+#define vcpu_arch_put_guest(mem, __val)							\
+do {											\
+	const typeof(mem) val = (__val);						\
+											\
+	if (!is_forced_emulation_enabled || guest_random_bool(&guest_rng)) {		\
+		(mem) = val;								\
+	} else if (guest_random_bool(&guest_rng)) {					\
+		__asm__ __volatile__(KVM_FEP "mov %1, %0"				\
+				     : "+m" (mem)					\
+				     : "r" (val) : "memory");				\
+	} else {									\
+		uint64_t __old = READ_ONCE(mem);					\
+											\
+		__asm__ __volatile__(KVM_FEP LOCK_PREFIX "cmpxchg %[new], %[ptr]"	\
+				     : [ptr] "+m" (mem), [old] "+a" (__old)		\
+				     : [new]"r" (val) : "memory", "cc");		\
+	}										\
+} while (0)
+
 #endif  // SELFTEST_KVM_UTIL_ARCH_H
-- 
2.44.0.291.gc1ea87d7ee-goog


