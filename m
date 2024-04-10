Return-Path: <linux-kernel+bounces-139155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F5789FF32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BD01C22DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5D817F395;
	Wed, 10 Apr 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjN/qLo+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F817F37B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771720; cv=none; b=s7spg0S+UW9Crt/IOG4HZ2EBhegMOi5CZBjGqS4KyRRj1/q8T/I7a8L5HI4hx/V+/R7XJIQrWoZftzS79+ZpCop4muYFZAZtqkbjKJs0ESOUFRSt3SgNZpWhk0ZARFkXHHvMuTVgNXGcnOOnJBugIs+1w6RbAPUB5J1UxRhJYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771720; c=relaxed/simple;
	bh=c5vOu3wln/bzFkI50zK54TLDDdF576q5OSt+R4RYCW0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hZP3OR8efw1YV1tVuV+el/9YIqo9OV+vbXcDY7xvSK7HlUzG9qgyTzb9py/wtHpAHjsrPLmUsMclRP0Gd18wsg7ieyzXTwYS5dx+4vgwYFrq+Gyu+g8uXU2xorDa9vUFD38joAI/x3j54zZjoIrgg/6EiZ4ibnkYpEguAS8Rjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjN/qLo+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60ab69a9e6fso1224377b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712771718; x=1713376518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oTRds48YQAuzki9smTU0zbOfJX16SMcTfKd42zPqGTw=;
        b=NjN/qLo+8P4Ap71VpMAba/PrNVkDASi5njcnBqX0uUTk3wi1eVRMkoCmBsqzwaUb0M
         hlD+OdgY5qbavZHavTXev59BojFGj0Oz1Myv7wEOGykrx6Qu8YekKG11yNiLsPiOJFOX
         SjQ0wJhfb5vblmXhXN159ObhMthOTHRPkQJqFd00G6Z0RgLxOfmjyj+5yguRJ3su1cYf
         fFZeMx8ZcLrZ9O35KLZKnUJUZM0PFWQrafA7OAp3u+IepSTcg6/oI/4H4kYeNlqEmZPG
         jq5WVf1CQvYXGeRN8bWmSIXr4Iu08Q9bZUmmE2PCKSF9TBJ0p+btW6Nmlts02+uqqRKV
         EJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771718; x=1713376518;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTRds48YQAuzki9smTU0zbOfJX16SMcTfKd42zPqGTw=;
        b=gXg240ZI7n9EvfUWQIn6pOdPTSxP0HKYT1qaIDEWt3ini8/msyYEJIL0C5HUnjPsst
         OAeFTRlEkqw5rhzZoq4kYsBvxUjB/QN1bsUKPWtESWe0pcUNxwjJpAJepXHMfjByWabR
         sUmFrebvgt2MxlkXZZhvGwaIhQG6YLxcCU8Lu6n3Y7qv9NuAHyuJGwyv79AYVLzu5aIJ
         Z0N7e0K3ck7Wa5trgXk/iO7tlprky56ZyqR3eaZiPKeurH/a3UXHPxJQtonqAZAUeoE/
         ZwE4MqZbGMx3l161SB/SrcB/7qnyV43/XmpBbCq3/Q7kw8AJKqSkIFLVE87/X6uewta+
         YTBg==
X-Forwarded-Encrypted: i=1; AJvYcCUdozR84LR5Og2947eRcdyniPLOr0KsE2i2Gdbr0aKPOA1k/O/lZtlRryB3kZfDdnsD8BSO55khRGU6ufldlkp7anWMm+Ed4rRelBFX
X-Gm-Message-State: AOJu0YwQrlRCwWoMjD+u1rS9B9sNue//77zEy65lMqcJ6wmD0pQQWMfM
	H8Uza2+P2MkMDQXn46Vgg8+dJBwhum7MBWkGX8//h6DxdrlpMP3cT39gs6g/TTy15ekBI1YPwTW
	VYN2T8cuyehHQuMfxdQqBEA==
X-Google-Smtp-Source: AGHT+IFGk/yictiXP/bmh1HJDKurTfI9OfoF/LDokYTgZALVerLy33LdKx5oD0s+3wIFHKHy3OTGRtA6WddrXew0Eg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:1148:b0:dd9:20c1:85b6 with
 SMTP id p8-20020a056902114800b00dd920c185b6mr109753ybu.2.1712771718281; Wed,
 10 Apr 2024 10:55:18 -0700 (PDT)
Date: Wed, 10 Apr 2024 17:54:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410175437.793508-1-coltonlewis@google.com>
Subject: [PATCH v3] KVM: arm64: Add early_param to control WFx trapping
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an early_param to control WFx (WFI or WFE) trapping. This is so
interrupts can be passed through if the CPU has support for direct
interrupt injection, a feature of GICv4. This is described as an
enumeration with three possible behaviors, always passthrough (never
trap), never passthrough (always trap), or default (trap if more than
one task is running. Default matches the current behavior.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
v3:
* Changed control mechanism to an early_param on Marc's advice this should be
  a system level decision and not exposed via uapi
* Reduced behavior to an enum from an integer as there are only a few options
  that make logical sense
* Limit option for always passthrough to systems with GICv4 since the primary
  case for always passthrough is systems with direct interrupt injection

v2:
https://lore.kernel.org/kvmarm/20240319164341.1674863-1-coltonlewis@google.com/

v1:
https://lore.kernel.org/kvmarm/20240129213918.3124494-1-coltonlewis@google.com/

arch/arm64/include/asm/kvm_host.h |  7 +++++++
 arch/arm64/kvm/arm.c              | 30 +++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 21c57b812569..e9225b1d0e9b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -67,6 +67,13 @@ enum kvm_mode {
 	KVM_MODE_NV,
 	KVM_MODE_NONE,
 };
+
+enum kvm_interrupt_passthrough {
+	KVM_INTERRUPT_PASSTHROUGH_DEFAULT,
+	KVM_INTERRUPT_PASSTHROUGH_ALWAYS,
+	KVM_INTERRUPT_PASSTHROUGH_NEVER,
+};
+
 #ifdef CONFIG_KVM
 enum kvm_mode kvm_get_mode(void);
 #else
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a25265aca432..5d0ea6b2c652 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -46,6 +46,7 @@
 #include <kvm/arm_psci.h>

 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
+static enum kvm_interrupt_passthrough kvm_interrupt_passthrough = KVM_INTERRUPT_PASSTHROUGH_DEFAULT;

 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);

@@ -456,7 +457,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
 		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);

-	if (single_task_running())
+	if ((kvm_interrupt_passthrough == KVM_INTERRUPT_PASSTHROUGH_ALWAYS
+	     && kvm_vgic_global_state.has_gicv4) ||
+	    (kvm_interrupt_passthrough == KVM_INTERRUPT_PASSTHROUGH_DEFAULT
+	     && single_task_running()))
 		vcpu_clear_wfx_traps(vcpu);
 	else
 		vcpu_set_wfx_traps(vcpu);
@@ -2654,6 +2658,30 @@ static int __init early_kvm_mode_cfg(char *arg)
 }
 early_param("kvm-arm.mode", early_kvm_mode_cfg);

+static int __init early_kvm_interrupt_passthrough_cfg(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "always") == 0) {
+		kvm_interrupt_passthrough = KVM_INTERRUPT_PASSTHROUGH_ALWAYS;
+		return 0;
+	}
+
+	if (strcmp(arg, "never") == 0) {
+		kvm_interrupt_passthrough = KVM_INTERRUPT_PASSTHROUGH_NEVER;
+		return 0;
+	}
+
+	if (strcmp(arg, "default") == 0) {
+		kvm_interrupt_passthrough = KVM_INTERRUPT_PASSTHROUGH_DEFAULT;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+early_param("kvm-arm.interrupt-passthrough", early_kvm_interrupt_passthrough_cfg);
+
 enum kvm_mode kvm_get_mode(void)
 {
 	return kvm_mode;
--
2.44.0.478.gd926399ef9-goog

