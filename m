Return-Path: <linux-kernel+bounces-63892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4626D853618
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED39A28BED4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E08182C5;
	Tue, 13 Feb 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CX7MjTsp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E6EB65E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842021; cv=none; b=PvkgzOVPVg/c3tu0zvse8aWbNMhfL9F69HwXIRhZVJQU542Co7RGRqi7pLzU7pz/75Xul/ZTfhgc8HDm2Q+piC9Sl/gSJxIXB7PD0Iwkh3ds0D8WzvSWNoaPDdi1YKWlVXYcv3TxsLElta13YvzyHgiRL5dPQLUgeZxZIkMomn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842021; c=relaxed/simple;
	bh=5jQ1Ka12EAGOH8zms0sfSvukl8ITZgCU3NhL3KvRbuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kf6+lBsKARaUPL4Pcw5zmMvHfLS72twYRm8wk8IxuuqUpMG03n5a//KZZriebrmFswxw8NsmqOxFIho3PXmUTtctnxCKMBnYN9JZGkvUUHToRp/5tiSP/97lgQ0Sgs0nvulOJQh28UYCsnA4iDx0JADbFr8a+30B6YA/ldMHKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CX7MjTsp reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 095ED40E01BB;
	Tue, 13 Feb 2024 16:33:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i06m16FqcGaU; Tue, 13 Feb 2024 16:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707842011; bh=A4/n0a2vShw34lG097pRAqyupWEd4jE83G8sy516dXw=;
	h=From:To:Cc:Subject:Date:From;
	b=CX7MjTsptR9uUUfX035w7Xflpu5P2s5lKApsA2a3szw1u48uFPTtaWf6iiQW1UuDJ
	 7DG49vDUG/GzjwIRWYm+rQ/91TCi/G8LlkVcCcoiQlhRq+pyv6jvvxX82aHHhBcv57
	 VyW1dXiB3t1JB+9GqiEtL5nRbiZCnwyLhpWcL1Dc8wv3uSSVySnRxeI5ANQMhzEUoi
	 5zBbrqm5M7anbZcOXSb759OcIitVo4qPE/VNI84kPcp3ha31e3FVegqm87f/kYOW99
	 nJun6MZMxEhUGtC0PeqlRqJLunlYiuwwx8RryKJQLuw/72LSnBt10gAGPP9ikZQ+Zu
	 M+Fdmqr9qcDen3Y+Wqzj4SQo5beo3D5dSDjAk83GeInN0Wuhr/Fsdo6atbBkzgkHtU
	 vKW+xZGv2qY8X+V0OhRirnzqey0/9hhXz5j0Btg87qbAP8sEwcrsGRhhxbBm6TecYE
	 6KB8LjAaOB7DJvug/YM579C/bMUKjbeCRHsajXscl9DGjCEUuGdIuXzdV1jbE12FQA
	 deDv4HAQ+vg/fu3t31tLHvs24P4d1RFvFN/JeZCg1zn24Kp5WvIq24Tr7FmJv4viXo
	 BvYSS911aF2gURKQi8L7ykFQEbqBwNBbaAmNN2/14eBCgt0/A9eVowboeiQUuYTJrK
	 aRk84ilYY7P6fYQHHtXImQ0I=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32B1940E00B2;
	Tue, 13 Feb 2024 16:33:26 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/sev: Dump SEV_STATUS
Date: Tue, 13 Feb 2024 17:33:11 +0100
Message-ID: <20240213163311.32130-1-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

It is, and will be even more useful in the future, to dump the SEV
features enabled according to SEV_STATUS. Do so:

  [    0.542753] Memory Encryption Features active: AMD SEV SEV-ES SEV-SN=
P
  [    0.544425] SEV: Status: SEV SEV-ES SEV-SNP DebugSwap

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/boot/compressed/sev.c   |  2 +-
 arch/x86/include/asm/msr-index.h | 59 +++++++++++++++++++-------------
 arch/x86/include/asm/sev.h       |  2 ++
 arch/x86/kernel/sev.c            | 35 +++++++++++++++++++
 arch/x86/mm/mem_encrypt.c        |  5 +++
 5 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/se=
v.c
index fffdba4ae806..97561eabfbef 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -370,7 +370,7 @@ static void enforce_vmpl0(void)
 				 MSR_AMD64_SNP_VMPL_SSS |		\
 				 MSR_AMD64_SNP_SECURE_TSC |		\
 				 MSR_AMD64_SNP_VMGEXIT_PARAM |		\
-				 MSR_AMD64_SNP_VMSA_REG_PROTECTION |	\
+				 MSR_AMD64_SNP_VMSA_REG_PROT |		\
 				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
 				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
 				 MSR_AMD64_SNP_RESERVED_MASK)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
index 237c50cc1c72..24c575cdd6b9 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -605,36 +605,47 @@
 #define MSR_AMD64_SEV_ES_GHCB		0xc0010130
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
-#define MSR_AMD64_SEV_ES_ENABLED_BIT	1
-#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
+#define MSR_AMD64_SEV_ES_ENABLED_BIT	1
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
+#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
-#define MSR_AMD64_RMP_BASE		0xc0010132
-#define MSR_AMD64_RMP_END		0xc0010133
-
-/* SNP feature bits enabled by the hypervisor */
-#define MSR_AMD64_SNP_VTOM			BIT_ULL(3)
-#define MSR_AMD64_SNP_REFLECT_VC		BIT_ULL(4)
-#define MSR_AMD64_SNP_RESTRICTED_INJ		BIT_ULL(5)
-#define MSR_AMD64_SNP_ALT_INJ			BIT_ULL(6)
-#define MSR_AMD64_SNP_DEBUG_SWAP		BIT_ULL(7)
-#define MSR_AMD64_SNP_PREVENT_HOST_IBS		BIT_ULL(8)
-#define MSR_AMD64_SNP_BTB_ISOLATION		BIT_ULL(9)
-#define MSR_AMD64_SNP_VMPL_SSS			BIT_ULL(10)
-#define MSR_AMD64_SNP_SECURE_TSC		BIT_ULL(11)
-#define MSR_AMD64_SNP_VMGEXIT_PARAM		BIT_ULL(12)
-#define MSR_AMD64_SNP_IBS_VIRT			BIT_ULL(14)
-#define MSR_AMD64_SNP_VMSA_REG_PROTECTION	BIT_ULL(16)
-#define MSR_AMD64_SNP_SMT_PROTECTION		BIT_ULL(17)
-
-/* SNP feature bits reserved for future use. */
-#define MSR_AMD64_SNP_RESERVED_BIT13		BIT_ULL(13)
-#define MSR_AMD64_SNP_RESERVED_BIT15		BIT_ULL(15)
-#define MSR_AMD64_SNP_RESERVED_MASK		GENMASK_ULL(63, 18)
+#define MSR_AMD64_SNP_VTOM_BIT		3
+#define MSR_AMD64_SNP_VTOM		BIT_ULL(MSR_AMD64_SNP_VTOM_BIT)
+#define MSR_AMD64_SNP_REFLECT_VC_BIT	4
+#define MSR_AMD64_SNP_REFLECT_VC	BIT_ULL(MSR_AMD64_SNP_REFLECT_VC_BIT)
+#define MSR_AMD64_SNP_RESTRICTED_INJ_BIT 5
+#define MSR_AMD64_SNP_RESTRICTED_INJ	BIT_ULL(MSR_AMD64_SNP_RESTRICTED_IN=
J_BIT)
+#define MSR_AMD64_SNP_ALT_INJ_BIT	6
+#define MSR_AMD64_SNP_ALT_INJ		BIT_ULL(MSR_AMD64_SNP_ALT_INJ_BIT)
+#define MSR_AMD64_SNP_DEBUG_SWAP_BIT	7
+#define MSR_AMD64_SNP_DEBUG_SWAP	BIT_ULL(MSR_AMD64_SNP_DEBUG_SWAP_BIT)
+#define MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT 8
+#define MSR_AMD64_SNP_PREVENT_HOST_IBS	BIT_ULL(MSR_AMD64_SNP_PREVENT_HOS=
T_IBS_BIT)
+#define MSR_AMD64_SNP_BTB_ISOLATION_BIT	9
+#define MSR_AMD64_SNP_BTB_ISOLATION	BIT_ULL(MSR_AMD64_SNP_BTB_ISOLATION_=
BIT)
+#define MSR_AMD64_SNP_VMPL_SSS_BIT	10
+#define MSR_AMD64_SNP_VMPL_SSS		BIT_ULL(MSR_AMD64_SNP_VMPL_SSS_BIT)
+#define MSR_AMD64_SNP_SECURE_TSC_BIT	11
+#define MSR_AMD64_SNP_SECURE_TSC	BIT_ULL(MSR_AMD64_SNP_SECURE_TSC_BIT)
+#define MSR_AMD64_SNP_VMGEXIT_PARAM_BIT	12
+#define MSR_AMD64_SNP_VMGEXIT_PARAM	BIT_ULL(MSR_AMD64_SNP_VMGEXIT_PARAM_=
BIT)
+#define MSR_AMD64_SNP_RESERVED_BIT13	BIT_ULL(13)
+#define MSR_AMD64_SNP_IBS_VIRT_BIT	14
+#define MSR_AMD64_SNP_IBS_VIRT		BIT_ULL(MSR_AMD64_SNP_IBS_VIRT_BIT)
+#define MSR_AMD64_SNP_RESERVED_BIT15	BIT_ULL(15)
+#define MSR_AMD64_SNP_VMSA_REG_PROT_BIT	16
+#define MSR_AMD64_SNP_VMSA_REG_PROT	BIT_ULL(MSR_AMD64_SNP_VMSA_REG_PROT_=
BIT)
+#define MSR_AMD64_SNP_SMT_PROT_BIT	17
+#define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		18
+#define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_B=
IT)
=20
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
=20
+#define MSR_AMD64_RMP_BASE		0xc0010132
+#define MSR_AMD64_RMP_END		0xc0010133
+
 /* AMD Collaborative Processor Performance Control MSRs */
 #define MSR_AMD_CPPC_CAP1		0xc00102b0
 #define MSR_AMD_CPPC_ENABLE		0xc00102b1
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index d7b27cb34c2b..10f9f1b259c3 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -229,6 +229,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t=
 end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void kdump_sev_callback(void);
+void sev_show_status(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -258,6 +259,7 @@ static inline void snp_accept_memory(phys_addr_t star=
t, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
+static inline void sev_show_status(void) { }
 #endif
=20
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ef7ae806a01..081d1391bc18 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -59,6 +59,25 @@
 #define AP_INIT_CR0_DEFAULT		0x60000010
 #define AP_INIT_MXCSR_DEFAULT		0x1f80
=20
+static const char * const sev_status_feat_names[] =3D {
+	[MSR_AMD64_SEV_ENABLED_BIT]		=3D "SEV",
+	[MSR_AMD64_SEV_ES_ENABLED_BIT]		=3D "SEV-ES",
+	[MSR_AMD64_SEV_SNP_ENABLED_BIT]		=3D "SEV-SNP",
+	[MSR_AMD64_SNP_VTOM_BIT]		=3D "vTom",
+	[MSR_AMD64_SNP_REFLECT_VC_BIT]		=3D "Reflect VC",
+	[MSR_AMD64_SNP_RESTRICTED_INJ_BIT]	=3D "RI",
+	[MSR_AMD64_SNP_ALT_INJ_BIT]		=3D "AI",
+	[MSR_AMD64_SNP_DEBUG_SWAP_BIT]		=3D "DebugSwap",
+	[MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT]	=3D "No HostIBS",
+	[MSR_AMD64_SNP_BTB_ISOLATION_BIT]	=3D "BTB Isol",
+	[MSR_AMD64_SNP_VMPL_SSS_BIT]		=3D "VmplSSS",
+	[MSR_AMD64_SNP_SECURE_TSC_BIT]		=3D "Secure TSC",
+	[MSR_AMD64_SNP_VMGEXIT_PARAM_BIT]	=3D "VMGExit param",
+	[MSR_AMD64_SNP_IBS_VIRT_BIT]		=3D "IBS Virt",
+	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	=3D "VMSA reg prot",
+	[MSR_AMD64_SNP_SMT_PROT_BIT]		=3D "SMT prot",
+};
+
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
=20
@@ -2275,3 +2294,19 @@ void kdump_sev_callback(void)
 	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP))
 		wbinvd();
 }
+
+void sev_show_status(void)
+{
+	int i;
+
+	pr_info("Status: ");
+	for (i =3D 0; i < MSR_AMD64_SNP_RESV_BIT; i++) {
+		if (sev_status & BIT_ULL(i)) {
+			if (!sev_status_feat_names[i])
+				continue;
+
+			pr_cont("%s ", sev_status_feat_names[i]);
+		}
+	}
+	pr_cont("\n");
+}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index d035bce3a2b0..6f3b3e028718 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -14,6 +14,8 @@
 #include <linux/mem_encrypt.h>
 #include <linux/virtio_anchor.h>
=20
+#include <asm/sev.h>
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRY=
PTED */
 bool force_dma_unencrypted(struct device *dev)
 {
@@ -74,6 +76,9 @@ static void print_mem_encrypt_feature_info(void)
 			pr_cont(" SEV-SNP");
=20
 		pr_cont("\n");
+
+		sev_show_status();
+
 		break;
 	default:
 		pr_cont("Unknown\n");
--=20
2.43.0


