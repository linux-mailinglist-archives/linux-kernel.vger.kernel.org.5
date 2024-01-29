Return-Path: <linux-kernel+bounces-43530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EEC841530
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207161C22CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17476158D89;
	Mon, 29 Jan 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZumjhOHj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C721586CE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564373; cv=none; b=rLOKs61EqxnFVLX0aQ2KInvNQ9iolMDm8xKTVjwdZOwJIscobkfRue0AoD58JXTN+3sOaKughIEWKCYtwdjsfPevhXkHokkEULQ1iwnQG7I3lgeHnJVbogaSZrtod2IgtnakBqTUPSSou88j/a2wuUGcKrHUwFnN+fcAHvGVi00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564373; c=relaxed/simple;
	bh=7Nu5d56ZeDA6l5eLrmk49xSbFqNKeDMhhp/l9C/XfqI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LMF9UOUX77/aOsJI4LHHqd6OKJyC6RV5/DAy+gdXlNfKefRAucU3BWuw2EwhVjV2cDT292gsQrix+zEQTz/JHKhU8PlX7C55mQBZ+cNspzSftzDNBJdnGevO43lLcx2A7Wy88iu5rrvJ0Q8m/OITuVRaJin+uzTmZs33fWazZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZumjhOHj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc221fad8c7so5076965276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706564371; x=1707169171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B99eaBaQvufEj95SWhNrEVaGQs5nxLAIqm27nnip6fg=;
        b=ZumjhOHjWvebavKmoiTpwKV2HZOWh2JrXNMNeai7+UQ+vz7+V3W+f/UYt9XTAVlNzf
         iqtFgi60YpN800Qku2RlBwzTwYOu7pM1KXzDdtIu1aV6KHygnHcCMYLlbbRKvggcHKIT
         GzklPzp+2CHjdnQVUhbyvvYBSrTrj/DP9S9tkNK7HESw5NsQIzYH4y95cbfa9o3pjH3n
         uCTL2DuDLbKAXicEt6/nHykZkihWKp/DZqyIGeIWxs08jzWl1k76NhYeA8dByvIGox9n
         uNLQUwnGNQIymH/eHYbvO4tq26vKxYZwq+Td+ohxPvSTzWDkh3H7MAklRCH+l9//61b/
         c37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706564371; x=1707169171;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B99eaBaQvufEj95SWhNrEVaGQs5nxLAIqm27nnip6fg=;
        b=FjkPsLsZAAfsO0Ha6ur8XGEbrGx7tK9r9p7WJYOH4+gywU4EpbHCfvvj7XXny1vmQc
         pZHIs5v1w/lk4x8Tyi2wiNkdBnxrdhlW+LtyT3qA9onco8M0K3U1+oeStttMJYBhkg1n
         7T8JzT2mbZCKzVxuvLwXM+S/yBkNlBaYaTadJR2qEr9CKghr4QJyaV6mCjiStmMUiIZy
         QsJayn9kcGKc7ILKZw8Y5d/BUC6KWRF9okfKxpOlHw0TZGTMd5ndribJTzZJpnUJyivf
         ZriMQyP+ATbTj/euSg3FASXsSCauc8coJW7+WVwauyNfK7KxgsgDNpYKWC6ep2EUNbNL
         uf1w==
X-Gm-Message-State: AOJu0YxzKGZYZvijKU3KLkJnvEE+PhFTnDpGuX/Vv7AlccTD9mLhy+9B
	04O3XcwjYqecSxfV+A8IXldlaVWUo/ZZ9GVWG/aIBQtP+gNZv00iwZ06vuniz2/Gr8EhrgXEIkU
	M2Xr4KMoJHnZC8ycKBf2BbQ==
X-Google-Smtp-Source: AGHT+IGygDA4Yqae/lvO9WyCp0eJko74aZVetrKCwp+siiLUcGXRBnWtoHzcunXD7W6Fuab5xM5aed9VfSPBn+KUWA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:2082:b0:dc2:5525:f6b with
 SMTP id di2-20020a056902208200b00dc255250f6bmr2459078ybb.7.1706564370856;
 Mon, 29 Jan 2024 13:39:30 -0800 (PST)
Date: Mon, 29 Jan 2024 21:39:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129213918.3124494-1-coltonlewis@google.com>
Subject: [PATCH] KVM: arm64: Add capability for unconditional WFx passthrough
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add KVM_CAP_ARM_WFX_PASSTHROUGH capability to always allow WFE/WFI
instructions to run without trapping. Current behavior is to only
allow this if the vcpu is the only task running. This commit keeps the
old behavior when the capability is not set.

This allows userspace to set deterministic behavior and increase
efficiency for platforms with direct interrupt injection support.

The implementation adds a new flag
KVM_ARCH_FLAG_WFX_PASSTHROUGH_ENABLED to kvm.arch.flags.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 ++
 arch/arm64/kvm/arm.c              | 7 ++++++-
 include/uapi/linux/kvm.h          | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

This patch is based on v6.8-rc1
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 21c57b812569..e0d5ec2983fa 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -274,6 +274,8 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_TIMER_PPIS_IMMUTABLE		6
 	/* Initial ID reg values loaded */
 #define KVM_ARCH_FLAG_ID_REGS_INITIALIZED		7
+	/* Never trap WFE/WFI instructions */
+#define KVM_ARCH_FLAG_WFX_PASSTHROUGH_ENABLED		8
 	unsigned long flags;

 	/* VM-wide vCPU feature set */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a25265aca432..6d993991bd7a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -116,6 +116,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->slots_lock);
 		break;
+	case KVM_CAP_ARM_WFX_PASSTHROUGH:
+		r = 0;
+		set_bit(KVM_ARCH_FLAG_WFX_PASSTHROUGH_ENABLED, &kvm->arch.flags);
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -456,7 +460,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
 		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);

-	if (single_task_running())
+	if (single_task_running() ||
+	    test_bit(KVM_ARCH_FLAG_WFX_PASSTHROUGH_ENABLED, &vcpu->kvm->arch.flags))
 		vcpu_clear_wfx_traps(vcpu);
 	else
 		vcpu_set_wfx_traps(vcpu);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c3308536482b..7635b5cd2b3b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1155,6 +1155,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_MEMORY_ATTRIBUTES 233
 #define KVM_CAP_GUEST_MEMFD 234
 #define KVM_CAP_VM_TYPES 235
+#define KVM_CAP_ARM_WFX_PASSTHROUGH 236

 #ifdef KVM_CAP_IRQ_ROUTING

--
2.43.0.429.g432eaa2c6b-goog

