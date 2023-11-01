Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF47E7DE20D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjKANmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKANmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:42:08 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5899912A;
        Wed,  1 Nov 2023 06:42:04 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778925998cbso466744685a.0;
        Wed, 01 Nov 2023 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698846123; x=1699450923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5nQo5QAmg18pLngnuIRNmy7fqh3tLqP/m6ROg4gk6+E=;
        b=cwuk0MpHjw64t27xiF2d3DVeNwTyBCdzBM28VttLnTgFWe1oPRnDP8PUPH1BHqeBhK
         g2rKhB22dyrDnL3A7f2hpxLspW2w9XwSo6R/dOJxM7uhXa7QeFqVJOn9IL5o3mokkBIo
         +vvFA2umJCAoqkZgcoUeB5jjZ17GpcjDDlzxwQGAuvwDLZ2o+eKHymP3XO17HBfHS2ic
         i+vFc2Wr44/4zPvksgobqmdXojlRSmUWwEAJ9yli+zZ5c0lg2Fem6xZFBqybljPSbmec
         mayH6uFuhJm+M2mPqGa25GFHhBFK0dg4zcWLt5v0yIciAwi1NWMUBXxmEDxXXa+tEFpE
         I2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698846123; x=1699450923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nQo5QAmg18pLngnuIRNmy7fqh3tLqP/m6ROg4gk6+E=;
        b=bbEYEB3JhAvBtY0uCzJhMgdSliy3Kl8el3SX+xVdt7lT5rY0ZvYZwAlZcP/4mOZObY
         Zrta2jQVfehw2SlCzD7yiuhgaAdTz/buZeS7XWWa56+NQkXrug9JUQ6HObRo7kxvkcwW
         wL2SMR+uH4jXw2Mnm6ArlXWTpPi8xUm1IaZBYVKmK/6c6fv3W8Rk4P4zHeZUHPYBQaXG
         Ecpe1YuD+6COPx9OeIOQqsSUvNWolC5p/qSjv87xD0npGHa3MaCgnP7mns8F74hY2Gcu
         t7sWDIqz7MR8Oj9R2OnzdHusKBIN1RRDD0Y9QkTK5XHpKFgi7qHfFrrzZA79WUGKOMyV
         BskA==
X-Gm-Message-State: AOJu0Yyddb9Vw6wmMG6k9p+R4KUg/71ADXhJ60I0a5pY35n+di3G71Dr
        +//vBHfX/jStqIsSHInKjvc=
X-Google-Smtp-Source: AGHT+IGFKvgB4JFJWNM7MuiXcvAJMvG91K9x/Ey1AKCZT8LeTf2DTYrE5N72zByeJa9VrrfrODcTxQ==
X-Received: by 2002:a05:620a:2687:b0:76f:2214:e2c3 with SMTP id c7-20020a05620a268700b0076f2214e2c3mr17147730qkp.64.1698846123326;
        Wed, 01 Nov 2023 06:42:03 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id y24-20020a37e318000000b00767d6ec578csm1435758qki.20.2023.11.01.06.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 06:42:02 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     michal.wilczynski@intel.com,
        Roger Pau Monne <roger.pau@citrix.com>,
        stable@vger.kernel.org, Jason Andryuk <jandryuk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v4] acpi/processor: sanitize _OSC/_PDC capabilities for Xen dom0
Date:   Wed,  1 Nov 2023 09:41:52 -0400
Message-ID: <20231101134154.18336-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Pau Monne <roger.pau@citrix.com>

The Processor capability bits notify ACPI of the OS capabilities, and
so ACPI can adjust the return of other Processor methods taking the OS
capabilities into account.

When Linux is running as a Xen dom0, the hypervisor is the entity
in charge of processor power management, and hence Xen needs to make
sure the capabilities reported by _OSC/_PDC match the capabilities of
the driver in Xen.

Introduce a small helper to sanitize the buffer when running as Xen
dom0.

When Xen supports HWP, this serves as the equivalent of commit
a21211672c9a ("ACPI / processor: Request native thermal interrupt
handling via _OSC") to avoid SMM crashes.  Xen will set bit
ACPI_PROC_CAP_COLLAB_PROC_PERF (bit 12) in the capability bits and the
_OSC/_PDC call will apply it.

[ jandryuk: Mention Xen HWP's need.  Support _OSC & _PDC ]
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
v4:
Use xen_santize_proc_cap_bits() name - Michal
Rephrase comment - Michal

v3:
Move xen_sanitize_pdc() call to arch_acpi_set_proc_cap_bits() to cover
_OSC and _PDC.
drivers/xen/pcpu.c is CONFIG_DOM0 && CONFIG_X86

v2:
Move local variables in acpi_processor_eval_pdc() to reuse in both conditions.
---
 arch/x86/include/asm/acpi.h           | 14 ++++++++++++++
 arch/x86/include/asm/xen/hypervisor.h |  9 +++++++++
 drivers/xen/pcpu.c                    | 21 +++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index c8a7fc23f63c..f896eed4516c 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -16,6 +16,9 @@
 #include <asm/x86_init.h>
 #include <asm/cpufeature.h>
 #include <asm/irq_vectors.h>
+#include <asm/xen/hypervisor.h>
+
+#include <xen/xen.h>
 
 #ifdef CONFIG_ACPI_APEI
 # include <asm/pgtable_types.h>
@@ -127,6 +130,17 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 	if (!cpu_has(c, X86_FEATURE_MWAIT) ||
 	    boot_option_idle_override == IDLE_NOMWAIT)
 		*cap &= ~(ACPI_PROC_CAP_C_C1_FFH | ACPI_PROC_CAP_C_C2C3_FFH);
+
+	if (xen_initial_domain()) {
+		/*
+		 * When Linux is running as Xen dom0, the hypervisor is the
+		 * entity in charge of the processor power management, and so
+		 * Xen needs to check the OS capabilities reported in the
+		 * processor capabilities buffer matches what the hypervisor
+		 * driver supports.
+		 */
+		xen_sanitize_proc_cap_bits(cap);
+	}
 }
 
 static inline bool acpi_has_cpu_in_madt(void)
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 7048dfacc04b..a9088250770f 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -100,4 +100,13 @@ static inline void leave_lazy(enum xen_lazy_mode mode)
 
 enum xen_lazy_mode xen_get_lazy_mode(void);
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
+void xen_sanitize_proc_cap_bits(uint32_t *buf);
+#else
+static inline void xen_sanitize_proc_cap_bits(uint32_t *buf)
+{
+	BUG();
+}
+#endif
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index b3e3d1bb37f3..7000701dff8f 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -47,6 +47,9 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
+#ifdef CONFIG_ACPI
+#include <acpi/processor.h>
+#endif
 
 /*
  * @cpu_id: Xen physical cpu logic number
@@ -400,4 +403,22 @@ bool __init xen_processor_present(uint32_t acpi_id)
 
 	return online;
 }
+
+void xen_sanitize_proc_cap_bits(uint32_t *cap)
+{
+	struct xen_platform_op op = {
+		.cmd			= XENPF_set_processor_pminfo,
+		.u.set_pminfo.id	= -1,
+		.u.set_pminfo.type	= XEN_PM_PDC,
+	};
+	u32 buf[3] = { ACPI_PDC_REVISION_ID, 1, *cap };
+	int ret;
+
+	set_xen_guest_handle(op.u.set_pminfo.pdc, buf);
+	ret = HYPERVISOR_platform_op(&op);
+	if (ret)
+		pr_err("sanitize of _PDC buffer bits from Xen failed: %d\n",
+		       ret);
+	*cap = buf[2];
+}
 #endif
-- 
2.41.0

