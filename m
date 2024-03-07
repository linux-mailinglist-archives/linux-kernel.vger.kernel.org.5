Return-Path: <linux-kernel+bounces-96252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A8187594A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A7FB21C33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF9B13BACB;
	Thu,  7 Mar 2024 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aOWpvOx+"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC613C9DB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847002; cv=none; b=hYMOOFKuHcnpuMheJNa3d3q4CZejcrVlFlbkbemUCHrfn8OmMkY2JvQR5Z9e8dRuVRproPOC+4CIDg0uMosgKU0aX0eD4CCk1ojISIQDV4WaV1PcNyWgBntX66yHH0pq1G5MZrbGJ4UOd04AMYRy3OrqiepSznEq/7+gr5+DiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847002; c=relaxed/simple;
	bh=5y+5Y+QY6gAB2RNOp5/TBlRPc7g9nsBG6D+Btj1EDcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XIdh754D1XCdQdLQVbg/DXkXxbJrQsfYdOXRJE5mqK12SkDVpxiQ05SkF53WmRir0DTIFItADGt2OnFAIxh4MjSJdS9FHcPIJc/c9u7nRLi9RV3T3F6gd2rFhCQ5EHhei1dLaLy4anSfS6TMhHw8qjnTNI4pqiBmCSR26GPzWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aOWpvOx+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1130691a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709847000; x=1710451800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtPlDdRGG7kc1hYmgy8nmceKpYj51PZXf/aezhvSfQI=;
        b=aOWpvOx+Vxj6HYw8yDwzpUyDFzm4+ZxB9q6HFK7sFncgmDAx4vlRHqAa8A3q5WWTv6
         zVek0qRZsjNzZ2+T5CHNt0W1q+mpfSusLXO+bTDgtvSeEGsjwRoicLzYIn7NCZy2JiNC
         49l32sGW2kDyfGYjA/JK4NLECAbXXwWKFhhIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847000; x=1710451800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtPlDdRGG7kc1hYmgy8nmceKpYj51PZXf/aezhvSfQI=;
        b=ZMMTdEpDXngpdUpStyhsC3K5gvpLZjBRuQQgrCYAej4JLu9jdnexKEF3aPNc/BtYMB
         +9f4Gc5FmPqnc0ZIBT/ZTSTX8HS9lOXJtLiGqmDOAC9WH9JisWwl+y3u1IrW5Aow8wtz
         7sALtsOAq/Hv/JbEw+HZ61BPhgbVT8Dqdhgnqatno5Z6sJZJnxTIouhAEXpvUzdBvlrx
         21pHnSeAo4BUOGHxHTIaOgTZgayJdJSaL6IYo5miPvrcX5sCkgzO8kQToZ1oyIG1ptUP
         movwRGd1xpJ80fRoVltfVQGJ+6kOSbhiFmC0cuG+Qh4H1b/OD2C30kiAul1rm+IYjcNT
         2BYQ==
X-Gm-Message-State: AOJu0YwT9jyE0IlItMhJ5yLO/MeWzgbOfZecjCRaZIebR3gRogfBxpaZ
	J69aPMJNKfjj+NY83gFqe1WbCBgHfaQ+Jfxou6qbd5nWOobF8fbx12LAknPTUTLfHu7Gshs8lrL
	Qka/1obWjZJcWPQ5gnT8qywULx0EEXy0RCdU27l4blHByif731wlfLjOnVZRJrcBosLb++aA4fw
	3I29pIVrSehknGU5i6BxLpMl8thfFxXmi4F6th3LCOwJz3VEIcAGt6
X-Google-Smtp-Source: AGHT+IFeidGi7gCtna64JWHwj5TSPssTbMK98yEscr59sIdVYXhWQxZIcbgx2XfGV9h3TjoNps/tXg==
X-Received: by 2002:a17:90a:68c7:b0:29b:ae33:6ffe with SMTP id q7-20020a17090a68c700b0029bae336ffemr456960pjj.2.1709847000008;
        Thu, 07 Mar 2024 13:30:00 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([64.186.27.43])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090abd0c00b00299db19a81asm1991021pjr.56.2024.03.07.13.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:29:59 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v7 1/7] x86/vmware: Move common macros to vmware.h
Date: Thu,  7 Mar 2024 13:29:43 -0800
Message-Id: <20240307212949.4166120-2-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
References: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <amakhalov@vmware.com>

Move VMware hypercall macros to vmware.h. This is a prerequisite for
the introduction of vmware_hypercall API. No functional changes besides
exporting vmware_hypercall_mode symbol.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/vmware.h | 72 +++++++++++++++++++++++++++++------
 arch/x86/kernel/cpu/vmware.c  | 57 +++------------------------
 2 files changed, 66 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index ac9fc51e2b18..de2533337611 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -8,25 +8,34 @@
 
 /*
  * The hypercall definitions differ in the low word of the %edx argument
- * in the following way: the old port base interface uses the port
- * number to distinguish between high- and low bandwidth versions.
+ * in the following way: the old I/O port based interface uses the port
+ * number to distinguish between high- and low bandwidth versions, and
+ * uses IN/OUT instructions to define transfer direction.
  *
  * The new vmcall interface instead uses a set of flags to select
  * bandwidth mode and transfer direction. The flags should be loaded
  * into %dx by any user and are automatically replaced by the port
- * number if the VMWARE_HYPERVISOR_PORT method is used.
- *
- * In short, new driver code should strictly use the new definition of
- * %dx content.
+ * number if the I/O port method is used.
  */
 
-/* Old port-based version */
-#define VMWARE_HYPERVISOR_PORT    0x5658
-#define VMWARE_HYPERVISOR_PORT_HB 0x5659
+#define VMWARE_HYPERVISOR_HB		BIT(0)
+#define VMWARE_HYPERVISOR_OUT		BIT(1)
+
+#define VMWARE_HYPERVISOR_PORT		0x5658
+#define VMWARE_HYPERVISOR_PORT_HB	(VMWARE_HYPERVISOR_PORT | \
+					 VMWARE_HYPERVISOR_HB)
+
+#define VMWARE_HYPERVISOR_MAGIC		0x564d5868U
+
+#define VMWARE_CMD_GETVERSION		10
+#define VMWARE_CMD_GETHZ		45
+#define VMWARE_CMD_GETVCPU_INFO		68
+#define VMWARE_CMD_STEALCLOCK		91
+
+#define CPUID_VMWARE_FEATURES_ECX_VMMCALL	BIT(0)
+#define CPUID_VMWARE_FEATURES_ECX_VMCALL	BIT(1)
 
-/* Current vmcall / vmmcall version */
-#define VMWARE_HYPERVISOR_HB   BIT(0)
-#define VMWARE_HYPERVISOR_OUT  BIT(1)
+extern u8 vmware_hypercall_mode;
 
 /* The low bandwidth call. The low word of edx is presumed clear. */
 #define VMWARE_HYPERCALL						\
@@ -54,4 +63,43 @@
 		      "rep insb",					\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
+
+#define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
+	__asm__("inl (%%dx), %%eax" :					\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(VMWARE_HYPERVISOR_PORT), "b"(UINT_MAX) :		\
+		"memory")
+
+#define VMWARE_VMCALL(cmd, eax, ebx, ecx, edx)				\
+	__asm__("vmcall" :						\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(0), "b"(UINT_MAX) :					\
+		"memory")
+
+#define VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx)				\
+	__asm__("vmmcall" :						\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(0), "b"(UINT_MAX) :					\
+		"memory")
+
+#define VMWARE_CMD(cmd, eax, ebx, ecx, edx) do {		\
+	switch (vmware_hypercall_mode) {			\
+	case CPUID_VMWARE_FEATURES_ECX_VMCALL:			\
+		VMWARE_VMCALL(cmd, eax, ebx, ecx, edx);		\
+		break;						\
+	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:			\
+		VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx);	\
+		break;						\
+	default:						\
+		VMWARE_PORT(cmd, eax, ebx, ecx, edx);		\
+		break;						\
+	}							\
+	} while (0)
+
 #endif
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 11f83d07925e..4db8e1daa4a1 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -41,60 +41,14 @@
 
 #define CPUID_VMWARE_INFO_LEAF               0x40000000
 #define CPUID_VMWARE_FEATURES_LEAF           0x40000010
-#define CPUID_VMWARE_FEATURES_ECX_VMMCALL    BIT(0)
-#define CPUID_VMWARE_FEATURES_ECX_VMCALL     BIT(1)
 
-#define VMWARE_HYPERVISOR_MAGIC	0x564D5868
-
-#define VMWARE_CMD_GETVERSION    10
-#define VMWARE_CMD_GETHZ         45
-#define VMWARE_CMD_GETVCPU_INFO  68
-#define VMWARE_CMD_LEGACY_X2APIC  3
-#define VMWARE_CMD_VCPU_RESERVED 31
-#define VMWARE_CMD_STEALCLOCK    91
+#define VCPU_LEGACY_X2APIC	3
+#define VCPU_RESERVED		31
 
 #define STEALCLOCK_NOT_AVAILABLE (-1)
 #define STEALCLOCK_DISABLED        0
 #define STEALCLOCK_ENABLED         1
 
-#define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
-	__asm__("inl (%%dx), %%eax" :					\
-		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
-		"a"(VMWARE_HYPERVISOR_MAGIC),				\
-		"c"(VMWARE_CMD_##cmd),					\
-		"d"(VMWARE_HYPERVISOR_PORT), "b"(UINT_MAX) :		\
-		"memory")
-
-#define VMWARE_VMCALL(cmd, eax, ebx, ecx, edx)				\
-	__asm__("vmcall" :						\
-		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
-		"a"(VMWARE_HYPERVISOR_MAGIC),				\
-		"c"(VMWARE_CMD_##cmd),					\
-		"d"(0), "b"(UINT_MAX) :					\
-		"memory")
-
-#define VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx)                         \
-	__asm__("vmmcall" :						\
-		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
-		"a"(VMWARE_HYPERVISOR_MAGIC),				\
-		"c"(VMWARE_CMD_##cmd),					\
-		"d"(0), "b"(UINT_MAX) :					\
-		"memory")
-
-#define VMWARE_CMD(cmd, eax, ebx, ecx, edx) do {		\
-	switch (vmware_hypercall_mode) {			\
-	case CPUID_VMWARE_FEATURES_ECX_VMCALL:			\
-		VMWARE_VMCALL(cmd, eax, ebx, ecx, edx);		\
-		break;						\
-	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:			\
-		VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx);	\
-		break;						\
-	default:						\
-		VMWARE_PORT(cmd, eax, ebx, ecx, edx);		\
-		break;						\
-	}							\
-	} while (0)
-
 struct vmware_steal_time {
 	union {
 		uint64_t clock;	/* stolen time counter in units of vtsc */
@@ -108,7 +62,8 @@ struct vmware_steal_time {
 };
 
 static unsigned long vmware_tsc_khz __ro_after_init;
-static u8 vmware_hypercall_mode     __ro_after_init;
+u8 vmware_hypercall_mode __ro_after_init;
+EXPORT_SYMBOL_GPL(vmware_hypercall_mode);
 
 static inline int __vmware_platform(void)
 {
@@ -476,8 +431,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & BIT(VCPU_RESERVED)) &&
+		(eax & BIT(VCPU_LEGACY_X2APIC));
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-- 
2.39.0


