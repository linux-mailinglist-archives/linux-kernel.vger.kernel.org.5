Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B6A80680B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377015AbjLFHP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376923AbjLFHP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:15:27 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9361B6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:15:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28657040cdcso4116612a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 23:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701846932; x=1702451732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEXkb7RcLOhQOzgtH+aAjv/qiW7MZwXrdo2K4Kz8Ir4=;
        b=FKrd2JVf7ftKlLAUsCOp9bPhuvu0KezTfqDF8j4ZFajsI/k1BoxPAXD8cin/ZQ38V6
         8G3jY8zdhM2phjDQfY/PTL+TrkEh/e2vLdS4Tf4cOjs/HRB4bFTHwYM3evKdtFb0G/A3
         mSYU7nMToh9dvM1LnDGjT5E46bYRBKXdyEoPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846932; x=1702451732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEXkb7RcLOhQOzgtH+aAjv/qiW7MZwXrdo2K4Kz8Ir4=;
        b=R22uT8gC3uhmeBfLefAsRdNPfcyqdN5lEIWWgAAIJIpcRpUcgh5mQfXXR3nlPMAhKa
         /QhHFHNnifNlP0eeCPVtGbM02pdgjwVGhQGrxEILoWANWXZfMUApDfC3d6oNRU4M+c5T
         AIG6pEjfEySA9NXAPELe8IORPMJ02JcWDa5c45fOVliABhZkWox8+3kWAstrtSBAYiNw
         L4bOCsarTauQsZ5/02ftS6dpvze0kDylzRhXcx46d7bWrvFAYRZtkoqwy0V9AZj4rBzd
         Yl9lB6C6/wfy+l+8wYJ+e5gRpJA1Yyp+eLDgkHjrbRSiCiHRWB1R78huA1PArPn4l/q+
         nQKw==
X-Gm-Message-State: AOJu0YwQPQ2sSUA/z+/90oRDHLrAFeGy8WZPvbRtggb4szIjgPKv3eXt
        DFHI7kRA/EV2HnvELYBCOQ2TYsXxNNXR4+xrxOtGhd+QXUmc8gaxsdwN2osCKAwIdB+3p9DkZ1b
        3vmCwUmzqu1Z8SZuinip8eyWkbe+kD8zuW4p1qpAzVR/0A5GJyg57Qf7LZsRtdu5R0dhNV1vIYl
        M5Xuc1dXwD05rg1zjx+m4=
X-Google-Smtp-Source: AGHT+IHS/CX3frLLXF6gU7wRnzFuV71agPlBUrAK65X9MJWz50+3bfdK4aocLGNC5Z7qIpfdViwjoA==
X-Received: by 2002:a17:90b:4b11:b0:286:6cc1:2cbd with SMTP id lx17-20020a17090b4b1100b002866cc12cbdmr310756pjb.71.1701846931498;
        Tue, 05 Dec 2023 23:15:31 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([64.186.27.43])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a191c00b0028591079e6fsm13721185pjg.24.2023.12.05.23.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:15:30 -0800 (PST)
From:   Alexey Makhalov <alexey.makhalov@broadcom.com>
To:     linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        hpa@zytor.com, dave.hansen@linux.intel.co, bp@alien8.d,
        mingo@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com
Cc:     x86@kernel.org, netdev@vger.kernel.org, richardcochran@gmail.com,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        pv-drivers@vmware.com, namit@vmware.com, timothym@vmware.com,
        akaher@vmware.com, jsipek@vmware.com,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, horms@kernel.org
Subject: [PATCH] x86/vmware: Add TDX hypercall support
Date:   Tue,  5 Dec 2023 23:15:27 -0800
Message-Id: <20231206071527.59171-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <ef8d3e17-7028-47fd-ad31-54dadbb6796d@broadcom.com>
References: <ef8d3e17-7028-47fd-ad31-54dadbb6796d@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Makhalov <amakhalov@vmware.com>

VMware hypercalls use I/O port, VMCALL or VMMCALL instructions.
Add __tdx_hypercall path to support TDX guests.

No change in high bandwidth hypercalls, as only low bandwidth
ones are supported for TDX guests.

Co-developed-by: Tim Merrifield <timothym@vmware.com>
Signed-off-by: Tim Merrifield <timothym@vmware.com>
Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/vmware.h | 72 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/vmware.c  | 10 +++++
 2 files changed, 82 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 17091eba68cb..cd58ff8ef1af 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -40,6 +40,54 @@
 
 extern u8 vmware_hypercall_mode;
 
+#define VMWARE_TDX_VENDOR_LEAF 0x1AF7E4909ULL
+#define VMWARE_TDX_HCALL_FUNC  1
+
+extern void vmware_tdx_hypercall_args(struct tdx_module_args *args);
+
+/*
+ * TDCALL[TDG.VP.VMCALL] uses rax (arg0) and rcx (arg2), while the use of
+ * rbp (arg6) is discouraged by the TDX specification. Therefore, we
+ * remap those registers to r12, r13 and r14, respectively.
+ */
+static inline
+unsigned long vmware_tdx_hypercall(unsigned long cmd, unsigned long in1,
+				   unsigned long in3, unsigned long in4,
+				   unsigned long in5, unsigned long in6,
+				   uint32_t *out1, uint32_t *out2,
+				   uint32_t *out3, uint32_t *out4,
+				   uint32_t *out5, uint32_t *out6)
+{
+	struct tdx_module_args args = {
+		.r10 = VMWARE_TDX_VENDOR_LEAF,
+		.r11 = VMWARE_TDX_HCALL_FUNC,
+		.r12 = VMWARE_HYPERVISOR_MAGIC,
+		.r13 = cmd,
+		.rbx = in1,
+		.rdx = in3,
+		.rsi = in4,
+		.rdi = in5,
+		.r14 = in6,
+	};
+
+	vmware_tdx_hypercall_args(&args);
+
+	if (out1)
+		*out1 = args.rbx;
+	if (out2)
+		*out2 = args.r13;
+	if (out3)
+		*out3 = args.rdx;
+	if (out4)
+		*out4 = args.rsi;
+	if (out5)
+		*out5 = args.rdi;
+	if (out6)
+		*out6 = args.r14;
+
+	return args.r12;
+}
+
 /*
  * The low bandwidth call. The low word of edx is presumed to have OUT bit
  * set. The high word of edx may contain input data from the caller.
@@ -67,6 +115,10 @@ unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, 0, 0, 0, 0, NULL, NULL,
+					    NULL, NULL, NULL, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0)
 		: [port] "i" (VMWARE_HYPERVISOR_PORT),
@@ -85,6 +137,10 @@ unsigned long vmware_hypercall3(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, 0, 0, 0, 0, out1, out2,
+					    NULL, NULL, NULL, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0), "=b" (*out1), "=c" (*out2)
 		: [port] "i" (VMWARE_HYPERVISOR_PORT),
@@ -104,6 +160,10 @@ unsigned long vmware_hypercall4(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, 0, 0, 0, 0, out1, out2,
+					    out3, NULL, NULL, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
 		: [port] "i" (VMWARE_HYPERVISOR_PORT),
@@ -123,6 +183,10 @@ unsigned long vmware_hypercall5(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, in3, in4, in5, 0, NULL,
+					    out2, NULL, NULL, NULL, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0), "=c" (*out2)
 		: [port] "i" (VMWARE_HYPERVISOR_PORT),
@@ -145,6 +209,10 @@ unsigned long vmware_hypercall6(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, in3, 0, 0, 0, NULL, out2,
+					    out3, out4, out5, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0), "=c" (*out2), "=d" (*out3), "=S" (*out4),
 		  "=D" (*out5)
@@ -166,6 +234,10 @@ unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
 {
 	unsigned long out0;
 
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return vmware_tdx_hypercall(cmd, in1, in3, in4, in5, 0, out1,
+					    out2, out3, NULL, NULL, NULL);
+
 	asm_inline volatile (VMWARE_HYPERCALL
 		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
 		: [port] "i" (VMWARE_HYPERVISOR_PORT),
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 3aa1adaed18f..29a31d4eaa27 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -428,6 +428,16 @@ static bool __init vmware_legacy_x2apic_available(void)
 		(eax & BIT(VCPU_LEGACY_X2APIC));
 }
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+/* Export tdx hypercall and allow it only for VMware guests. */
+void vmware_tdx_hypercall_args(struct tdx_module_args *args)
+{
+	if (hypervisor_is_type(X86_HYPER_VMWARE))
+		__tdx_hypercall(args);
+}
+EXPORT_SYMBOL_GPL(vmware_tdx_hypercall_args);
+#endif
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 static void vmware_sev_es_hcall_prepare(struct ghcb *ghcb,
 					struct pt_regs *regs)
-- 
2.39.0

