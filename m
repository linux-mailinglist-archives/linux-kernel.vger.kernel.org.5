Return-Path: <linux-kernel+bounces-71051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB585A003
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A5D281222
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE3249ED;
	Mon, 19 Feb 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="byXsP7sq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF32420B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335758; cv=none; b=CGQFXxAWRORV40J3E+/RrRGJxxfHTwf/8Q0/Kzr7dGN+OC4iykeCqA8EKtevmG7HLxsVZB3qduE+cdmV0UNGXKDHEptpwGV80veAIPj+b9kp2rko3LSOOBzm8ngO96UE7FWJLmuk+l8LVCgmgpMMnAEYV+sD2arBbMDQM8tF2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335758; c=relaxed/simple;
	bh=j6dRbHM1rHyKp3gaEVtJQirzEs2zBxOnB0hIBrgRSI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B05W6et0DIhyRwnKjUmWCUmVJmpEk+Kj1rXgfRzlhpMyUoYZfmieo/Yp/i6shfCj7hSFU9Pq2lY8mGsxbWoDR7arsV2WZnVz8fXSlUrNQtfvKaPEZNXMsPdD0ltOPe5dXMXpi6pHRHCMH34MZZKCWtX89Iy3Mr3v4uEHwAd98wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=byXsP7sq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 074BD40E01BB;
	Mon, 19 Feb 2024 09:42:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z7aAfeFXR0DQ; Mon, 19 Feb 2024 09:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708335750; bh=yCXgwZFpjKx2w5kY7xomV0PW2GNqfaew+W1uSPXnCF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byXsP7sqEgRA6vA0qrP+uuhrb2BheSracE32Iz3M4t36f/I47JAJ33EDZfAuGomPL
	 PX9yfjap9Rb5A62qXIko+E+1MJoUca01dmG6AiLx0md1DTJ4S9EM/g2F7/KkBNY8yb
	 NpJqxggoYkh/HfNCL22dKnWRouOC5A086MInRnSVJP788k41V2DyR53QmBLSW7Ymmb
	 WzRYOEES0Gm8DFBUfDyT5MpO99F7yxj5FW/49ofVWosOs8GWkdiNe3Cw332s2UVikd
	 NNWv0NvQiThs1VKw3IYDjp4xK3MFGguUlF77N6s3Seutoi8xikCcEAqJdvUjZEhnEs
	 AhYQA2cKQUk0NLN84hK8FzD/QII9UBg/h1URLXXapRdY5+IOCCcUXSp40ndQbQ6iy6
	 xbN58zCqcuJPoEUVZQBM9BCms/9/7S3GZyA6nxW01TS6hjGrhT3UygOlIgGgNrpxg7
	 YSA6gFQo5JO181mDdxu+8n5LB6463I7HNdcrmxp9HoMVKpAK9WJg0MszOfTdNLVvI5
	 vxqC26hVUgKqY+Z4iQDqQYsZ841QecDQz9e1TcLzp7ohkNWhl1Q/nDTSCKF+APrS9B
	 dZvHfmTtZi2WqVTZt7k2OFfJemaTLxgT/jA5L5Xi0xm5YkPQd8I65B+58CET++w/L4
	 Uxlq8Tmnxn2BDAQjoUviI/Oo=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2365F40E0196;
	Mon, 19 Feb 2024 09:42:23 +0000 (UTC)
Date: Mon, 19 Feb 2024 10:42:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: [PATCH -v2] x86/sev: Dump SEV_STATUS
Message-ID: <20240219094216.GAZdMieDHKiI8aaP3n@fat_crate.local>
References: <20240213163311.32130-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213163311.32130-1-bp@alien8.de>

From: "Borislav Petkov (AMD)" <bp@alien8.de>

It is, and will be even more useful in the future, to dump the SEV
features enabled according to SEV_STATUS. Do so:

  [    0.542753] Memory Encryption Features active: AMD SEV SEV-ES SEV-SNP
  [    0.544425] SEV: Status: SEV SEV-ES SEV-SNP DebugSwap

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/boot/compressed/sev.c   |  2 +-
 arch/x86/include/asm/msr-index.h | 59 +++++++++++++++++++-------------
 arch/x86/include/asm/sev.h       |  2 ++
 arch/x86/kernel/sev.c            | 35 +++++++++++++++++++
 arch/x86/mm/mem_encrypt.c        |  5 +++
 5 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
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
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
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
+#define MSR_AMD64_SNP_RESTRICTED_INJ	BIT_ULL(MSR_AMD64_SNP_RESTRICTED_INJ_BIT)
+#define MSR_AMD64_SNP_ALT_INJ_BIT	6
+#define MSR_AMD64_SNP_ALT_INJ		BIT_ULL(MSR_AMD64_SNP_ALT_INJ_BIT)
+#define MSR_AMD64_SNP_DEBUG_SWAP_BIT	7
+#define MSR_AMD64_SNP_DEBUG_SWAP	BIT_ULL(MSR_AMD64_SNP_DEBUG_SWAP_BIT)
+#define MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT 8
+#define MSR_AMD64_SNP_PREVENT_HOST_IBS	BIT_ULL(MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT)
+#define MSR_AMD64_SNP_BTB_ISOLATION_BIT	9
+#define MSR_AMD64_SNP_BTB_ISOLATION	BIT_ULL(MSR_AMD64_SNP_BTB_ISOLATION_BIT)
+#define MSR_AMD64_SNP_VMPL_SSS_BIT	10
+#define MSR_AMD64_SNP_VMPL_SSS		BIT_ULL(MSR_AMD64_SNP_VMPL_SSS_BIT)
+#define MSR_AMD64_SNP_SECURE_TSC_BIT	11
+#define MSR_AMD64_SNP_SECURE_TSC	BIT_ULL(MSR_AMD64_SNP_SECURE_TSC_BIT)
+#define MSR_AMD64_SNP_VMGEXIT_PARAM_BIT	12
+#define MSR_AMD64_SNP_VMGEXIT_PARAM	BIT_ULL(MSR_AMD64_SNP_VMGEXIT_PARAM_BIT)
+#define MSR_AMD64_SNP_RESERVED_BIT13	BIT_ULL(13)
+#define MSR_AMD64_SNP_IBS_VIRT_BIT	14
+#define MSR_AMD64_SNP_IBS_VIRT		BIT_ULL(MSR_AMD64_SNP_IBS_VIRT_BIT)
+#define MSR_AMD64_SNP_RESERVED_BIT15	BIT_ULL(15)
+#define MSR_AMD64_SNP_VMSA_REG_PROT_BIT	16
+#define MSR_AMD64_SNP_VMSA_REG_PROT	BIT_ULL(MSR_AMD64_SNP_VMSA_REG_PROT_BIT)
+#define MSR_AMD64_SNP_SMT_PROT_BIT	17
+#define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
+#define MSR_AMD64_SNP_RESV_BIT		18
+#define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
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
@@ -229,6 +229,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void kdump_sev_callback(void);
+void sev_show_status(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -258,6 +259,7 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
+static inline void sev_show_status(void) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ef7ae806a01..7d242898852f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -59,6 +59,25 @@
 #define AP_INIT_CR0_DEFAULT		0x60000010
 #define AP_INIT_MXCSR_DEFAULT		0x1f80
 
+static const char * const sev_status_feat_names[] = {
+	[MSR_AMD64_SEV_ENABLED_BIT]		= "SEV",
+	[MSR_AMD64_SEV_ES_ENABLED_BIT]		= "SEV-ES",
+	[MSR_AMD64_SEV_SNP_ENABLED_BIT]		= "SEV-SNP",
+	[MSR_AMD64_SNP_VTOM_BIT]		= "vTom",
+	[MSR_AMD64_SNP_REFLECT_VC_BIT]		= "ReflectVC",
+	[MSR_AMD64_SNP_RESTRICTED_INJ_BIT]	= "RI",
+	[MSR_AMD64_SNP_ALT_INJ_BIT]		= "AI",
+	[MSR_AMD64_SNP_DEBUG_SWAP_BIT]		= "DebugSwap",
+	[MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT]	= "NoHostIBS",
+	[MSR_AMD64_SNP_BTB_ISOLATION_BIT]	= "BTBIsol",
+	[MSR_AMD64_SNP_VMPL_SSS_BIT]		= "VmplSSS",
+	[MSR_AMD64_SNP_SECURE_TSC_BIT]		= "SecureTSC",
+	[MSR_AMD64_SNP_VMGEXIT_PARAM_BIT]	= "VMGExitParam",
+	[MSR_AMD64_SNP_IBS_VIRT_BIT]		= "IBSVirt",
+	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSARegProt",
+	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
+};
+
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
 
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
+	for (i = 0; i < MSR_AMD64_SNP_RESV_BIT; i++) {
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
 
+#include <asm/sev.h>
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
@@ -74,6 +76,9 @@ static void print_mem_encrypt_feature_info(void)
 			pr_cont(" SEV-SNP");
 
 		pr_cont("\n");
+
+		sev_show_status();
+
 		break;
 	default:
 		pr_cont("Unknown\n");
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

