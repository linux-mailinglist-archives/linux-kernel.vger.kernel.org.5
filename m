Return-Path: <linux-kernel+bounces-47375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B4844D02
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC6283EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF4D45C10;
	Wed, 31 Jan 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyN2R6ME"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AA83C08E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743862; cv=none; b=P8Q7+YgwUpX39ibXA8UeMlQvRCC4pfv2dv3b8OgvnzcSjjgquQjMi/ClQlG3Ex+KZJp0YgE0k0dfi53e10FE3DP8p5UdOyIO1V9EqNGRQoBCXZ6i3FkDhNwPij9bJRJX4SG0rOytPJyHV+leu69Tc5y6/DlYQBEEajfgt8VfiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743862; c=relaxed/simple;
	bh=8o3/8syqf7n2/Gv2LAdMhkd0dmDvEMgaYeogylunOwo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Izz6DYfJ+B8+jFZOdTR0mmvBgKxvJov6OkA4+bvX6rWdxxXF7lCTy3BU+XwdgApuwU9LvohaU7nqWqiZjyPnR9xpQOiYth08LVSDh9mbXMnZvW0YFrIhAVeJkMZc2jVz0fzjxWQVklw7seUTMpJtBipdMS4hR71QmwIVAhdr1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyN2R6ME; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706743859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrrbFXu6Bep9UlBaPoKDJV9ChwKD1VqnhXtY2x/ZEGc=;
	b=JyN2R6MEMxM/J7OEIF1dM1u6JXc53gqEY4aGddwdZG5n/7++u4jkeFiNRpDOdXMqLN+IhR
	A8FJeoUWhQtcGHSMLABaGrCBgZZqNxKpCEMJe5JOS7rBiA27ESN9YvArn+/zixjdlFyeyx
	/iZjaDqAAUFF/QoMUGJ4mnd820vKuPI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-mK0OFjNiMCKAInbBnB-fow-1; Wed,
 31 Jan 2024 18:30:57 -0500
X-MC-Unique: mK0OFjNiMCKAInbBnB-fow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D8CE299E755;
	Wed, 31 Jan 2024 23:30:57 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 65A1CC2590D;
	Wed, 31 Jan 2024 23:30:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 6/8] kvm: replace __KVM_HAVE_READONLY_MEM with Kconfig symbol
Date: Wed, 31 Jan 2024 18:30:54 -0500
Message-Id: <20240131233056.10845-7-pbonzini@redhat.com>
In-Reply-To: <20240131233056.10845-1-pbonzini@redhat.com>
References: <20240131233056.10845-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

KVM uses __KVM_HAVE_* symbols in the architecture-dependent uapi/asm/kvm.h to mask
unused definitions in include/uapi/linux/kvm.h.  __KVM_HAVE_READONLY_MEM however
was nothing but a misguided attempt to define KVM_CAP_READONLY_MEM only on
architectures where KVM_CHECK_EXTENSION(KVM_CAP_READONLY_MEM) could possibly
return nonzero.  This however does not make sense, and it prevented userspace
from supporting this architecture-independent feature without recompilation.

Therefore, these days __KVM_HAVE_READONLY_MEM does not mask anything and
is only used in virt/kvm/kvm_main.c.  Userspace does not need to test it
and there should be no need for it to exist.  Remove it and replace it
with a Kconfig symbol within Linux source code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/arm64/include/uapi/asm/kvm.h     | 1 -
 arch/arm64/kvm/Kconfig                | 1 +
 arch/loongarch/include/uapi/asm/kvm.h | 2 --
 arch/loongarch/kvm/Kconfig            | 1 +
 arch/mips/include/uapi/asm/kvm.h      | 2 --
 arch/mips/kvm/Kconfig                 | 1 +
 arch/riscv/include/uapi/asm/kvm.h     | 1 -
 arch/riscv/kvm/Kconfig                | 1 +
 arch/x86/include/uapi/asm/kvm.h       | 1 -
 arch/x86/kvm/Kconfig                  | 1 +
 include/uapi/linux/kvm.h              | 7 +++++++
 virt/kvm/Kconfig                      | 3 +++
 virt/kvm/kvm_main.c                   | 2 +-
 13 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 75809c8dc2f0..9c1040dad4eb 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -39,7 +39,6 @@
 
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
-#define __KVM_HAVE_READONLY_MEM
 #define __KVM_HAVE_VCPU_EVENTS
 
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 99193d3b8312..01398d2996c7 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -34,6 +34,7 @@ menuconfig KVM
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_IRQ_BYPASS
+	select HAVE_KVM_READONLY_MEM
 	select HAVE_KVM_VCPU_RUN_PID_CHANGE
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
index 923d0bd38294..109785922cf9 100644
--- a/arch/loongarch/include/uapi/asm/kvm.h
+++ b/arch/loongarch/include/uapi/asm/kvm.h
@@ -14,8 +14,6 @@
  * Some parts derived from the x86 version of this file.
  */
 
-#define __KVM_HAVE_READONLY_MEM
-
 #define KVM_COALESCED_MMIO_PAGE_OFFSET	1
 #define KVM_DIRTY_LOG_PAGE_OFFSET	64
 
diff --git a/arch/loongarch/kvm/Kconfig b/arch/loongarch/kvm/Kconfig
index ac4de790dc31..c4ef2b4d9797 100644
--- a/arch/loongarch/kvm/Kconfig
+++ b/arch/loongarch/kvm/Kconfig
@@ -27,6 +27,7 @@ config KVM
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_GENERIC_MMU_NOTIFIER
 	select KVM_MMIO
+	select HAVE_KVM_READONLY_MEM
 	select KVM_XFER_TO_GUEST_WORK
 	help
 	  Support hosting virtualized guest machines using
diff --git a/arch/mips/include/uapi/asm/kvm.h b/arch/mips/include/uapi/asm/kvm.h
index edcf717c4327..9673dc9cb315 100644
--- a/arch/mips/include/uapi/asm/kvm.h
+++ b/arch/mips/include/uapi/asm/kvm.h
@@ -20,8 +20,6 @@
  * Some parts derived from the x86 version of this file.
  */
 
-#define __KVM_HAVE_READONLY_MEM
-
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 
 /*
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 8916b3ed0f90..ab57221fa4dd 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -26,6 +26,7 @@ config KVM
 	select KVM_MMIO
 	select KVM_GENERIC_MMU_NOTIFIER
 	select KVM_GENERIC_HARDWARE_ENABLING
+	select HAVE_KVM_READONLY_MEM
 	help
 	  Support for hosting Guest kernels.
 
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 7499e88a947c..fdf4ba066131 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -16,7 +16,6 @@
 #include <asm/ptrace.h>
 
 #define __KVM_HAVE_IRQ_LINE
-#define __KVM_HAVE_READONLY_MEM
 
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index d490db943858..26d1727f0550 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -24,6 +24,7 @@ config KVM
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_MSI
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
+	select HAVE_KVM_READONLY_MEM
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index bf68e56fd484..c5e682ee7726 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -51,7 +51,6 @@
 #define __KVM_HAVE_DEBUGREGS
 #define __KVM_HAVE_XSAVE
 #define __KVM_HAVE_XCRS
-#define __KVM_HAVE_READONLY_MEM
 
 /* Architectural interrupt line count. */
 #define KVM_NR_INTERRUPTS 256
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 5692393b7565..d43efae05794 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -29,6 +29,7 @@ config KVM
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
 	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_IRQ_ROUTING
+	select HAVE_KVM_READONLY_MEM
 	select KVM_ASYNC_PF
 	select USER_RETURN_NOTIFIER
 	select KVM_MMIO
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index aa8a7ee0f554..29b73eedfe74 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -52,6 +52,9 @@ config KVM_ASYNC_PF_SYNC
 config HAVE_KVM_MSI
        bool
 
+config HAVE_KVM_READONLY_MEM
+       bool
+
 config HAVE_KVM_CPU_RELAX_INTERCEPT
        bool
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 10bfc88a69f7..ff588677beb7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1614,7 +1614,7 @@ static int check_memory_region_flags(struct kvm *kvm,
 	if (mem->flags & KVM_MEM_GUEST_MEMFD)
 		valid_flags &= ~KVM_MEM_LOG_DIRTY_PAGES;
 
-#ifdef __KVM_HAVE_READONLY_MEM
+#ifdef CONFIG_HAVE_KVM_READONLY_MEM
 	valid_flags |= KVM_MEM_READONLY;
 #endif
 
-- 
2.39.0



