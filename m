Return-Path: <linux-kernel+bounces-124342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FBC8915FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B37E1C222EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807118063E;
	Fri, 29 Mar 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FYXbOwAT"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB147E57D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704498; cv=none; b=GrlP91fk+h35EMVMjoqrm2r/X0UTi0tqxJNan3V+9O8k4eiALNR3ADZpbbpe6h4R08T4xEo09aSZMdArlWVFGzRRQT5WVQev6HNm5bH1qBdiycNRKuI2u5MnGVOC5nQUtUhAI0N6e3nm8pts/6TcvCGmuj7G4T/KPj2V/4CtuI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704498; c=relaxed/simple;
	bh=bQlDZHUxe+DlLwpEaFAb1U/lWAzGpXz5Uk4pAXpoJP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHIQFXnjaoFEcwzenaSnxMBGDfJUyghpYWEM0qFxMQu44360Ta/VV6JVFWoM8ixrNRTaQV+egHJmNKlolv3Fqyn9O3YgCWULcL1hlVqYpabWlSZ3T5IlpWuxRLyEfhx0X0PjWIY58xypc2ZWOloeQBSFgWwidMNCCALP2ldF8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FYXbOwAT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29dedcd244dso1376081a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704496; x=1712309296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lyzq0wGOrToQ2iQEyeXKMeMPovCKQNw+2NCntCzWKQ=;
        b=FYXbOwATeZgdTGKgPxwSFYqJVy/+FaR3oLsB/zmkjxmTcYUjC8TUp5GVi3DQaw94xt
         4qQ/nVjczIXj7dBM27oOGl7QQSy1bY6pP3AaqWUjC/GVTpS209Dwpe04XMhKwVRbv6eN
         FGwvpjQyjm8F1uepTaUHgnY8ru5Mc6mK3L31cUlAPCTSVd390oawVFcRMuyc5KLZEpnA
         JqRb0Wc+JKsr9/qbjWojGxGNGW9PmTpDSX9DhtsM3NLCGMEIhxJMGNw+T2AID/v5RtKZ
         5NaY4NlUI2/mgrRZowVb23fE/mx+toxgl+PaGYQNgL2YpOCfaKIAJXI2IUNAcf42MmJw
         ASjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704496; x=1712309296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lyzq0wGOrToQ2iQEyeXKMeMPovCKQNw+2NCntCzWKQ=;
        b=RCWyOjK7bMbV0tyPalG7iZxupOyj3HZbL4Bz2sdEDQVJrhb3vWcFPDM9XL8Njav5pp
         AgDgblDIVN1OlxVFtV3BBv50cnXIAn5cmr+FqRpj26Xnu+V8Lk16b6fb8v/rDqWs2c89
         jmWQ+sdOEAzyi5o6G07/W8JcxTQPf60xwu0N6AjvVYv7h3+vETpAU7l773yxZ+riDANM
         +8XAapDhhi7QoisDTf4MMPuPNMaSDsY0G6jh2MZJmg4A3AS9DCFrKvDdJRJ/7rNNpqM3
         hCaVipJL7S1wjip9r7VAFyQL4YuqBmNJxgiTyI0B3H0rjDpXAhzeLK3BFwcauUW2tSSe
         neeA==
X-Forwarded-Encrypted: i=1; AJvYcCWrivEMU1JnWTcaHMfiEn16NzUUgGYIvYOWPVBrrsecsdC6azvHC4s1DmtTSHEf+J4IgMDpy58Twxs+oxvt+8X/relqnIzYabHI0aZq
X-Gm-Message-State: AOJu0Yzsj+EFZKvOK1bQs9YH28ASvie6afzZT6Zu8mH//mkde+D+WDfZ
	fnhxq8Wqebg+ZcbaMxOH4wm+OpeVs8QynvlT/GP5Xgg5p50j/HZAncN+NdsLnG4=
X-Google-Smtp-Source: AGHT+IERD9iL6cC6QBlpwrE+WhviS3lzGnj6I0fmkcIha5EAxHWeUpBSJ6740UpJGEHt1s0r02s0NQ==
X-Received: by 2002:a17:90b:1091:b0:2a0:2b14:6d8d with SMTP id gj17-20020a17090b109100b002a02b146d8dmr1780476pjb.1.1711704496150;
        Fri, 29 Mar 2024 02:28:16 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:28:15 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 29 Mar 2024 17:26:26 +0800
Subject: [PATCH RFC 10/11] riscv: KVM: Add hcontext support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-10-1534f93b94a7@sifive.com>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
In-Reply-To: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 Max Hsu <max.hsu@sifive.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.13.0

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

hcontext CSR store the ID of the currently running machine status.
When a virtual machine is initialized, it will obtain and utilize
the first available ID.
It will be updated to VM ID when switch to a virtual machine,
and updated to 0 when switch back to host machine.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Co-developed-by: Max Hsu <max.hsu@sifive.com>
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/include/asm/kvm_host.h       |  3 ++
 arch/riscv/include/asm/kvm_vcpu_debug.h |  7 +++
 arch/riscv/kvm/main.c                   |  4 ++
 arch/riscv/kvm/vcpu_debug.c             | 78 +++++++++++++++++++++++++++++++++
 arch/riscv/kvm/vm.c                     |  4 ++
 5 files changed, 96 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index d495279d99e1..b5d972783116 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -103,6 +103,9 @@ struct kvm_arch {
 
 	/* AIA Guest/VM context */
 	struct kvm_aia aia;
+
+	/* hcontext ID for guest VM */
+	unsigned long hcontext;
 };
 
 struct kvm_cpu_trap {
diff --git a/arch/riscv/include/asm/kvm_vcpu_debug.h b/arch/riscv/include/asm/kvm_vcpu_debug.h
index 6e7ce6b408a6..0a025fc4e6dd 100644
--- a/arch/riscv/include/asm/kvm_vcpu_debug.h
+++ b/arch/riscv/include/asm/kvm_vcpu_debug.h
@@ -11,6 +11,13 @@
 
 #include <linux/types.h>
 
+DECLARE_STATIC_KEY_FALSE(use_hcontext);
+extern atomic_long_t hcontext_id_share;
+
+void kvm_riscv_debug_init(void);
+void kvm_riscv_debug_exit(void);
+void kvm_riscv_debug_get_hcontext_id(struct kvm *kvm);
+void kvm_riscv_debug_return_hcontext_id(struct kvm *kvm);
 void kvm_riscv_debug_vcpu_swap_in_guest_context(struct kvm_vcpu *vcpu);
 void kvm_riscv_debug_vcpu_swap_in_host_context(struct kvm_vcpu *vcpu);
 
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 225a435d9c9a..ff28b96ad70b 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -125,6 +125,8 @@ static int __init riscv_kvm_init(void)
 		return rc;
 	}
 
+	kvm_riscv_debug_init();
+
 	return 0;
 }
 module_init(riscv_kvm_init);
@@ -133,6 +135,8 @@ static void __exit riscv_kvm_exit(void)
 {
 	kvm_riscv_aia_exit();
 
+	kvm_riscv_debug_exit();
+
 	kvm_exit();
 }
 module_exit(riscv_kvm_exit);
diff --git a/arch/riscv/kvm/vcpu_debug.c b/arch/riscv/kvm/vcpu_debug.c
index e7e9263c2e30..5081c272f01d 100644
--- a/arch/riscv/kvm/vcpu_debug.c
+++ b/arch/riscv/kvm/vcpu_debug.c
@@ -6,6 +6,84 @@
 #include <linux/kvm_host.h>
 #include <asm/switch_to.h>
 
+DEFINE_SPINLOCK(hcontext_lock);
+unsigned long *hcontext_bitmap;
+unsigned long hcontext_bitmap_len;
+
+static __always_inline bool has_hcontext(void)
+{
+	return static_branch_likely(&use_hcontext);
+}
+
+void kvm_riscv_debug_init(void)
+{
+	/*
+	 * As from riscv-debug-spec, Chapter 5.7.9:
+	 * If the H extension is implemented, it’s recommended to
+	 * implement no more than 7 bits on RV32 and 14 on RV64.
+	 * Allocating bit array according to spec size.
+	 */
+#if __riscv_xlen > 32
+	unsigned long tmp = atomic_long_read(&hcontext_id_share) & GENMASK(13, 0);
+#else
+	unsigned long tmp = atomic_long_read(&hcontext_id_share) & GENMASK(6, 0);
+#endif
+	if (has_hcontext()) {
+		while (tmp) {
+			kvm_info("hcontext: try to allocate 0x%lx-bit array\n", tmp);
+			hcontext_bitmap_len = tmp + 1;
+			hcontext_bitmap = bitmap_zalloc(tmp, 0);
+			if (hcontext_bitmap)
+				break;
+			tmp = tmp >> 1;
+		}
+
+		if (tmp == 0) {
+			/* We can't allocate any space for hcontext bitmap */
+			static_branch_disable(&use_hcontext);
+		} else {
+			/* ID 0 is hypervisor */
+			set_bit(0, hcontext_bitmap);
+		}
+	}
+}
+
+void kvm_riscv_debug_exit(void)
+{
+	if (has_hcontext()) {
+		static_branch_disable(&use_hcontext);
+		kfree(hcontext_bitmap);
+	}
+}
+
+void kvm_riscv_debug_get_hcontext_id(struct kvm *kvm)
+{
+	if (has_hcontext()) {
+		unsigned long free_id;
+
+		spin_lock(&hcontext_lock);
+		free_id = find_first_zero_bit(hcontext_bitmap, hcontext_bitmap_len);
+
+		/* share the maximum ID when we run out of the hcontext ID */
+		if (free_id <= hcontext_bitmap_len)
+			set_bit(free_id, hcontext_bitmap);
+		else
+			free_id -= 1;
+
+		kvm->arch.hcontext = free_id;
+		spin_unlock(&hcontext_lock);
+	}
+}
+
+void kvm_riscv_debug_return_hcontext_id(struct kvm *kvm)
+{
+	if (has_hcontext()) {
+		spin_lock(&hcontext_lock);
+		clear_bit(kvm->arch.hcontext, hcontext_bitmap);
+		spin_unlock(&hcontext_lock);
+	}
+}
+
 void kvm_riscv_debug_vcpu_swap_in_guest_context(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_sdtrig_csr *csr = &vcpu->arch.sdtrig_csr;
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index ce58bc48e5b8..275f5f05d4dd 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -45,6 +45,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm_riscv_guest_timer_init(kvm);
 
+	kvm_riscv_debug_get_hcontext_id(kvm);
+
 	return 0;
 }
 
@@ -53,6 +55,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_destroy_vcpus(kvm);
 
 	kvm_riscv_aia_destroy_vm(kvm);
+
+	kvm_riscv_debug_return_hcontext_id(kvm);
 }
 
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,

-- 
2.43.2


