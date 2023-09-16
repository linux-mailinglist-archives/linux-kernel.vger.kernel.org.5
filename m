Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409427A2C7F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbjIPAfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbjIPAeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:34:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B951273C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:31:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so3057562276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694824292; x=1695429092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qo2m7xsYGxv0LvZBx1IOU3suTnYOrGiO/bIX70mqbME=;
        b=0Xk8gZPflQVqaq/vlUJdcRa9p7xIMOzEa5g9R42WTgCevO3d5rSYLZjmLcqdaKD+OT
         hif3vZaEQg18h0S3QKbC7F9dj9R2Pp4vparuModnLT2yf/tR8fwlco7cqJwYaMekK2Ih
         IbdLjirPOEJs+F4hM7TgiB8Frh+lOWgXKoN3h24nBPndBVizR74FLh3A+l3WiA0JUFSe
         gGjMnbO+/D7TY9rIiQTo2hKzDcyrhlFn1QcWDnr72nyQRv6sBYi14uq7CcjnLbvQThVs
         Y158Bgn/1VYRbgy8SSitkxWpQUZwm4r3vP95VIXYT4VivNqCF9pIE/EY+b5gWBkhhdon
         ErbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824292; x=1695429092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qo2m7xsYGxv0LvZBx1IOU3suTnYOrGiO/bIX70mqbME=;
        b=b//+QIK9ZGj2quHu/dTM/H6USG49kP/s7OC1SgDYLVM3+zcRD/HuhUywbImQCYmAry
         lMndUZqPjgq9lKwP2+tLqgbHtGE4Dx1px70WwjFlfoRioyGk55slb3SgvofKHLi0n9Aq
         uCHtqqNORePH0vY8QXt6muRJtJ40XHY12WzTMv125nhu0MHJTuYg7gHCoHu3XGYag9FS
         RC6mYQC7D1APn++m4BArwfgzBwHX3gOilWWn+5ISS3YqHT1RP2p0dgnSUy2WZ2B/4+Zg
         TiCxi/Td562tVKjHhD1DG57znBeA3XqhLaPi3XmK87WSCXjFf89izUj+FbakxEpGtUg/
         Fm6g==
X-Gm-Message-State: AOJu0YyWcHhYMK9a5Vk0Tsdva50oIXAGRX9wwwoTg+PTu+WISR2q4N1w
        yCfYZlB/02dUMsODBBxdSg03AKXudWk=
X-Google-Smtp-Source: AGHT+IGldyHqJlNQwUdnpkugxOOkbUw+dVHZu9n7C9ywbITmCocjjVdCkDZmP9v50Lpi+O1mI86Ze95fAkM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d045:0:b0:d7e:afff:c8fa with SMTP id
 h66-20020a25d045000000b00d7eafffc8famr73977ybg.5.1694824292733; Fri, 15 Sep
 2023 17:31:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Sep 2023 17:30:58 -0700
In-Reply-To: <20230916003118.2540661-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916003118.2540661-7-seanjc@google.com>
Subject: [PATCH 06/26] KVM: Drop CONFIG_KVM_VFIO and just look at KVM+VFIO
From:   Sean Christopherson <seanjc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop KVM's KVM_VFIO Kconfig, and instead compile in VFIO support if
and only if VFIO itself is enabled.  Similar to the recent change to have
VFIO stop looking at HAVE_KVM, compiling in support for talking to VFIO
just because the architecture supports VFIO is nonsensical.

This fixes a bug where RISC-V doesn't select KVM_VFIO, i.e. would silently
fail to do connect KVM and VFIO, even though RISC-V supports VFIO.  The
bug is benign as the only driver in all of Linux that actually uses the
KVM reference provided by VFIO is KVM-GT, which is x86/Intel specific.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/Kconfig   | 1 -
 arch/powerpc/kvm/Kconfig | 1 -
 arch/s390/kvm/Kconfig    | 1 -
 arch/x86/kvm/Kconfig     | 1 -
 virt/kvm/Kconfig         | 3 ---
 virt/kvm/Makefile.kvm    | 4 +++-
 virt/kvm/vfio.h          | 2 +-
 7 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 83c1e09be42e..2b5c332f157d 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -28,7 +28,6 @@ menuconfig KVM
 	select KVM_MMIO
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_XFER_TO_GUEST_WORK
-	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 902611954200..c4beb49c0eb2 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -22,7 +22,6 @@ config KVM
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
-	select KVM_VFIO
 	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
 	select INTERVAL_TREE
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 45fdf2a9b2e3..459d536116a6 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -31,7 +31,6 @@ config KVM
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_INVALID_WAKEUPS
 	select HAVE_KVM_NO_POLL
-	select KVM_VFIO
 	select INTERVAL_TREE
 	select MMU_NOTIFIER
 	help
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index ed90f148140d..0f01e5600b5f 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -45,7 +45,6 @@ config KVM
 	select HAVE_KVM_NO_POLL
 	select KVM_XFER_TO_GUEST_WORK
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
-	select KVM_VFIO
 	select INTERVAL_TREE
 	select HAVE_KVM_PM_NOTIFIER if PM
 	select KVM_GENERIC_HARDWARE_ENABLING
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 484d0873061c..f0be3b55cea6 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -59,9 +59,6 @@ config HAVE_KVM_MSI
 config HAVE_KVM_CPU_RELAX_INTERCEPT
        bool
 
-config KVM_VFIO
-       bool
-
 config HAVE_KVM_INVALID_WAKEUPS
        bool
 
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index 2c27d5d0c367..29373b59d89a 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -6,7 +6,9 @@
 KVM ?= ../../../virt/kvm
 
 kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
-kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
+ifdef CONFIG_VFIO
+kvm-y += $(KVM)/vfio.o
+endif
 kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
 kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
 kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
diff --git a/virt/kvm/vfio.h b/virt/kvm/vfio.h
index e130a4a03530..af475a323965 100644
--- a/virt/kvm/vfio.h
+++ b/virt/kvm/vfio.h
@@ -2,7 +2,7 @@
 #ifndef __KVM_VFIO_H
 #define __KVM_VFIO_H
 
-#ifdef CONFIG_KVM_VFIO
+#if IS_ENABLED(CONFIG_KVM) && IS_ENABLED(CONFIG_VFIO)
 int kvm_vfio_ops_init(void);
 void kvm_vfio_ops_exit(void);
 #else
-- 
2.42.0.459.ge4e396fd5e-goog

