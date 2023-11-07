Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C77E49AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjKGUUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjKGUUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:20:23 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6191D10CB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:20:21 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6d31f3feb12so7924531a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699388420; x=1699993220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHtSZXfxM41A5xelmirKq8UJ34KMEqQJ6uQM49e88n4=;
        b=PosLP695pD3EvW9V3sE+ynXunoprW2/1tAzhImNB1RSMEGZSIdgQn41cEO9ffluZET
         lh+fiajt4dPLNK5EJWAaSh23YOUv5JBPUF9/GED2yHF53pQZY2a40jXtTAP8EENtT7Ql
         HqO38p5Kz8JHGTbC+xfJwxYDt7+B5wQTEu5NmUtSDtHUVujVjWllZzXztmHcRLrC38Fu
         AVozGNLv1g6hOv1GiQ4+LUP3jznj4A31GEUs+ZmwnGrW+1y21ZL5Nlib1p6HWFwYDqE7
         LqyYg4Wbe6Jt2iq94qnmS/dVoEqHVaqWRMOzSuXoTbfAJ0Yu3LCI9umyzTdG16i45xA5
         tfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699388420; x=1699993220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHtSZXfxM41A5xelmirKq8UJ34KMEqQJ6uQM49e88n4=;
        b=FVq7PNxwJ52XVd692dZFFIK/1J86MJw0+ROg5DGSs9m0QnuC+lGoS0L/oT3ZQHdRhp
         SWaTLq9eDEdobTOnFMmZJa0Vo8BC6NZFIsyMBwsISPBj6pnhX5TH5kBcAEGfrEyWImX+
         4nAfyVmBbLjj/lcgRSe5XsNhwIdx+nWgsvTLOvLHll0mB+7Uc8QXVO6ctNN5oRM5tZA7
         bN9GS9+C/SI9yL4LHmjw+ccga7WQVW7zG9H8WrgkIXc18DOQx2FqFvhgSK5ewMZQdtBh
         sXyZF6GK0fNsFWiZNdl8epOqlBH2dcSpLa/J8HJyBZKLygunodX8kmy+9cb5zZZbR/WE
         tnNw==
X-Gm-Message-State: AOJu0YzTHmo084yiM7kLPX72FPl5ygEivIDuM4btEiTyd74OJMsSS01+
        bYB2A+S5eHnjtGxg2lzX4Du2inYlr/3oiQ==
X-Google-Smtp-Source: AGHT+IH+sJeS0ROAOq43lwtwQUvZBoMusw05VPI8LA5O035oWce3ho1ohN0fd1vRG/n1OuGrAfAPNCHaW1P53w==
X-Received: from aghulati-dev.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:18bb])
 (user=aghulati job=sendgmr) by 2002:a05:6830:26da:b0:6c4:7e6c:cb4e with SMTP
 id m26-20020a05683026da00b006c47e6ccb4emr9658721otu.5.1699388420723; Tue, 07
 Nov 2023 12:20:20 -0800 (PST)
Date:   Tue,  7 Nov 2023 20:19:52 +0000
In-Reply-To: <20231107202002.667900-1-aghulati@google.com>
Mime-Version: 1.0
References: <20231107202002.667900-1-aghulati@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107202002.667900-5-aghulati@google.com>
Subject: [RFC PATCH 04/14] KVM: x86: Create stubs for a new VAC module
From:   Anish Ghulati <aghulati@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        peterz@infradead.org, paulmck@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Anish Ghulati <aghulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create emtpy stub files for what will eventually be a new module named
Virtualization Acceleration Code: Unupgradable Units Module (backronym:
VACUUM, or VAC for short). VAC will function as a base module for
multiple KVM modules and will contain the code needed to manage
system-wide virtualization resources, like enabling/disabling
virtualization hardware.

Signed-off-by: Anish Ghulati <aghulati@google.com>
---
 arch/x86/kvm/Makefile  | 2 ++
 arch/x86/kvm/svm/vac.c | 2 ++
 arch/x86/kvm/vac.c     | 3 +++
 arch/x86/kvm/vac.h     | 6 ++++++
 arch/x86/kvm/vmx/vac.c | 2 ++
 virt/kvm/Makefile.kvm  | 1 +
 virt/kvm/vac.c         | 3 +++
 virt/kvm/vac.h         | 6 ++++++
 8 files changed, 25 insertions(+)
 create mode 100644 arch/x86/kvm/svm/vac.c
 create mode 100644 arch/x86/kvm/vac.c
 create mode 100644 arch/x86/kvm/vac.h
 create mode 100644 arch/x86/kvm/vmx/vac.c
 create mode 100644 virt/kvm/vac.c
 create mode 100644 virt/kvm/vac.h

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 3e965c90e065..b3de4bd7988f 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -13,6 +13,8 @@ kvm-y			+= x86.o emulate.o i8259.o irq.o lapic.o \
 			   hyperv.o debugfs.o mmu/mmu.o mmu/page_track.o \
 			   mmu/spte.o
 
+kvm-y                   += vac.o vmx/vac.o svm/vac.o
+
 ifdef CONFIG_HYPERV
 kvm-y			+= kvm_onhyperv.o
 endif
diff --git a/arch/x86/kvm/svm/vac.c b/arch/x86/kvm/svm/vac.c
new file mode 100644
index 000000000000..4aabf16d2fc0
--- /dev/null
+++ b/arch/x86/kvm/svm/vac.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
diff --git a/arch/x86/kvm/vac.c b/arch/x86/kvm/vac.c
new file mode 100644
index 000000000000..18d2ae7d3e47
--- /dev/null
+++ b/arch/x86/kvm/vac.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "vac.h"
diff --git a/arch/x86/kvm/vac.h b/arch/x86/kvm/vac.h
new file mode 100644
index 000000000000..4d5dc4700f4e
--- /dev/null
+++ b/arch/x86/kvm/vac.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_X86_KVM_VAC_H
+#define ARCH_X86_KVM_VAC_H
+
+#endif // ARCH_X86_KVM_VAC_H
diff --git a/arch/x86/kvm/vmx/vac.c b/arch/x86/kvm/vmx/vac.c
new file mode 100644
index 000000000000..4aabf16d2fc0
--- /dev/null
+++ b/arch/x86/kvm/vmx/vac.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index 4de10d447ef3..7876021ea4d7 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -11,6 +11,7 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
 ifdef CONFIG_VFIO
 kvm-y += $(KVM)/vfio.o
 endif
+kvm-y += $(KVM)/vac.o
 kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
 kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
 kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
diff --git a/virt/kvm/vac.c b/virt/kvm/vac.c
new file mode 100644
index 000000000000..18d2ae7d3e47
--- /dev/null
+++ b/virt/kvm/vac.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "vac.h"
diff --git a/virt/kvm/vac.h b/virt/kvm/vac.h
new file mode 100644
index 000000000000..8f7123a916c5
--- /dev/null
+++ b/virt/kvm/vac.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __KVM_VAC_H__
+#define __KVM_VAC_H__
+
+#endif
-- 
2.42.0.869.gea05f2083d-goog

