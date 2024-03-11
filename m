Return-Path: <linux-kernel+bounces-99122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DB58783AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51148B21CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9630A4438E;
	Mon, 11 Mar 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MTxJotF0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2253341E22
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170367; cv=none; b=qjMLuCqFHwI43BIRid5MGsow3KPzxGN5ZvFNXpTH8ZKzFAsCwR1GlSBpLkrFHH3RFReu1HRLgyCP9bqJ3RkVRLWagzvsWrZPOD/p3L/lWSZYEZ1BxF7Hh1zCwr+aM2PqdKwxJ9Vw98GcTN3LEDIfouia1/N9X/rmo030We+UO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170367; c=relaxed/simple;
	bh=mhUDaPYEKF+zI420x5qS3qHi5pj6a0r4mo8dpRZVZxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EZO7NYztqSh5jSx2DQYjx6S87yJdV/yTxPg4Y2QbMlEzxBVW4rnFCa78227nJYzQwYQTy917BrcYv8Dx/N2h6ayMGjZA1o3nWqtXycZJPGWG823bNOYvYUqoATK7xQB76CxM5i/cMFN1cK/I/qY7+7GwioqCMij1J21xztldsZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MTxJotF0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8442A40E0028;
	Mon, 11 Mar 2024 15:19:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mpfH9hN-Vvha; Mon, 11 Mar 2024 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710170358; bh=4ZK31KsHejacbgwxLKup5oPeNubaKDbjldebln/g9Fw=;
	h=Date:From:To:Cc:Subject:From;
	b=MTxJotF08Ij86dmkErNW546Z8MvsbsqXFH0ozcco4iVYwLTyt0hUtXrHZH74DjiyX
	 Gst2LcbyFMPQwXTgAUtX7R4DOPaQc4ER296tZSEaiJzY3pQAi3wVhOBaiHcDARJzQJ
	 ZZHF0gDCcTEuBtySE73Qfi9+buipw90vTuMKSaWK+5+/+UXuf86a7BaXwyFxkF3Jn+
	 aHTEGh7u9Z1GDDkIl7lXkh6qONkoyPy9S6u7hiQQd5Z9x2zHCRc73POMPbPkLdJ0uT
	 I4+KpbxktxnUDogJQ9IeD6mi9jQHxdNbCrGaXWGd0pRCh0+SpktEYVFvE+2bbjJjzb
	 bUJ7R79HqFFM9SX0Wrjg+w9jsJZQJ5aHffySAy2zyVxbknFHj+PJI6SZgyWzTNfPad
	 3XUlB2HzS6ODBd3R/fnZGn08/r+SE9K4ByJh3jEGZD60AY0hvj55VX/7OrXIZZ/SFY
	 hylaYxUJffhIBeo2pK6Ls6xAMvhMFdPpdedJqsdG3pe/gxlIUK5e0V/c77AD4WeVsg
	 GQdml4o2tIuA0Q1i/82xDdr6zaBMZMR2hZNiOCraBs2OWWSbLuPpryOQbp7pFeQD6h
	 6I1h4xhC7eL0uQrmSRF+5w5X33D78+kFJxr2XQFkvNR18KkpKGnwSfjCpY20GUBxAz
	 5XMYxKYIxfODMBuRIMF0tvUw=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A658340E0196;
	Mon, 11 Mar 2024 15:19:15 +0000 (UTC)
Date: Mon, 11 Mar 2024 16:19:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v6.9-rc1
Message-ID: <20240311151909.GAZe8g7SqDKRcP4XrO@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a huuuge pile of x86/sev changes for v6.9-rc1.

If you're merging tip pull requests in the chronological order you've
received them, you'll encounter a couple of simple merge conflicts. I'm
adding how I've resolved them at the end of this message in case you
wanna compare notes.

Thx.

---

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.9_rc1

for you to fetch changes up to c0935fca6ba4799e5efc6daeee37887e84707d01:

  x86/sev: Disable KMSAN for memory encryption TUs (2024-03-08 08:59:22 +0100)

----------------------------------------------------------------
- Add the x86 part of the SEV-SNP host support. This will allow the
  kernel to be used as a KVM hypervisor capable of running SNP (Secure
  Nested Paging) guests. Roughly speaking, SEV-SNP is the ultimate goal
  of the AMD confidential computing side, providing the most
  comprehensive confidential computing environment up to date.

  This is the x86 part and there is a KVM part which did not get ready
  in time for the merge window so latter will be forthcoming in the next
  cycle.

- Rework the early code's position-dependent SEV variable references in
  order to allow building the kernel with clang and -fPIE/-fPIC and
  -mcmodel=kernel

- The usual set of fixes, cleanups and improvements all over the place

----------------------------------------------------------------
Ard Biesheuvel (2):
      x86/sme: Fix memory encryption setting if enabled by default and not overridden
      x86/sev: Fix position dependent variable references in startup code

Ashish Kalra (6):
      iommu/amd: Don't rely on external callers to enable IOMMU SNP support
      x86/mtrr: Don't print errors if MtrrFixDramModEn is set when SNP enabled
      x86/sev: Introduce an SNP leaked pages list
      iommu/amd: Clean up RMP entries for IOMMU pages during SNP shutdown
      crypto: ccp: Add panic notifier for SEV/SNP firmware shutdown on kdump
      iommu/amd: Fix failure return from snp_lookup_rmpentry()

Borislav Petkov (AMD) (5):
      x86/sev: Harden #VC instruction emulation somewhat
      x86/Kconfig: Remove CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
      crypto: ccp: Make snp_range_list static
      crypto: ccp - Have it depend on AMD_IOMMU
      x86/sev: Dump SEV_STATUS

Brijesh Singh (14):
      x86/cpufeatures: Add SEV-SNP CPU feature
      x86/sev: Add SEV-SNP host initialization support
      x86/sev: Add RMP entry lookup helpers
      x86/fault: Add helper for dumping RMP entries
      x86/traps: Define RMP violation #PF error code
      x86/sev: Add helper functions for RMPUPDATE and PSMASH instruction
      crypto: ccp: Define the SEV-SNP commands
      crypto: ccp: Add support to initialize the AMD-SP for SEV-SNP
      crypto: ccp: Provide an API to issue SEV and SNP commands
      crypto: ccp: Handle the legacy TMR allocation when SNP is enabled
      crypto: ccp: Handle legacy SEV commands when SNP is enabled
      KVM: SEV: Make AVIC backing, VMSA and VMCB memory allocation SNP safe
      crypto: ccp: Add the SNP_PLATFORM_STATUS command
      crypto: ccp: Add the SNP_SET_CONFIG command

Changbin Du (1):
      x86/sev: Disable KMSAN for memory encryption TUs

Kim Phillips (1):
      x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled

Kirill A. Shutemov (1):
      x86/mm: Fix memory encryption features advertisement

Michael Roth (4):
      x86/fault: Dump RMP table information when RMP page faults occur
      x86/sev: Adjust the directmap to avoid inadvertent RMP faults
      x86/cpufeatures: Enable/unmask SEV-SNP CPU feature
      Documentation: virt: Fix up pre-formatted text block for SEV ioctls

Tom Lendacky (2):
      crypto: ccp: Handle non-volatile INIT_EX data when SNP is enabled
      crypto: ccp: Add the SNP_COMMIT command

 Documentation/admin-guide/kernel-parameters.txt  |    4 +-
 Documentation/arch/x86/amd-memory-encryption.rst |   16 +-
 Documentation/virt/coco/sev-guest.rst            |   52 +
 arch/x86/Kbuild                                  |    2 +
 arch/x86/Kconfig                                 |   13 -
 arch/x86/boot/compressed/sev.c                   |    6 +-
 arch/x86/coco/core.c                             |    7 +-
 arch/x86/include/asm/asm.h                       |   14 +
 arch/x86/include/asm/coco.h                      |    8 +-
 arch/x86/include/asm/cpufeatures.h               |    1 +
 arch/x86/include/asm/disabled-features.h         |    8 +-
 arch/x86/include/asm/iommu.h                     |    1 +
 arch/x86/include/asm/kvm-x86-ops.h               |    1 +
 arch/x86/include/asm/kvm_host.h                  |    1 +
 arch/x86/include/asm/mem_encrypt.h               |   15 +-
 arch/x86/include/asm/msr-index.h                 |   66 +-
 arch/x86/include/asm/sev.h                       |   40 +
 arch/x86/include/asm/trap_pf.h                   |   20 +-
 arch/x86/kernel/Makefile                         |    1 +
 arch/x86/kernel/cpu/amd.c                        |   21 +-
 arch/x86/kernel/cpu/common.c                     |    7 +-
 arch/x86/kernel/cpu/mtrr/generic.c               |    3 +
 arch/x86/kernel/crash.c                          |    3 +
 arch/x86/kernel/sev-shared.c                     |  114 +-
 arch/x86/kernel/sev.c                            |   54 +-
 arch/x86/kvm/lapic.c                             |    5 +-
 arch/x86/kvm/svm/nested.c                        |    2 +-
 arch/x86/kvm/svm/sev.c                           |   37 +-
 arch/x86/kvm/svm/svm.c                           |   17 +-
 arch/x86/kvm/svm/svm.h                           |    1 +
 arch/x86/mm/Makefile                             |    1 +
 arch/x86/mm/fault.c                              |    5 +
 arch/x86/mm/mem_encrypt.c                        |   55 +-
 arch/x86/mm/mem_encrypt_identity.c               |   40 +-
 arch/x86/virt/svm/Makefile                       |    3 +
 arch/x86/virt/svm/sev.c                          |  560 ++++++++++
 drivers/crypto/ccp/Kconfig                       |    2 +-
 drivers/crypto/ccp/sev-dev.c                     | 1260 +++++++++++++++++++---
 drivers/crypto/ccp/sev-dev.h                     |    5 +
 drivers/iommu/amd/amd_iommu.h                    |    1 -
 drivers/iommu/amd/init.c                         |  125 ++-
 include/linux/amd-iommu.h                        |    6 +-
 include/linux/psp-sev.h                          |  321 +++++-
 include/uapi/linux/psp-sev.h                     |   59 +
 tools/arch/x86/include/asm/cpufeatures.h         |    1 +
 45 files changed, 2677 insertions(+), 307 deletions(-)
 create mode 100644 arch/x86/virt/svm/Makefile
 create mode 100644 arch/x86/virt/svm/sev.c

---

Merge conflicts resolve:

---

commit ad844f23969df842cbbdba40b2d3954a618c96d8 (refs/remotes/amd/merge-test)
Merge: a720c4257e69 c0935fca6ba4
Author: Bob the builder <bp@alien8.de>
Date:   Mon Mar 11 14:55:57 2024 +0000

    Merge remote-tracking branch 'tip/x86/sev' into merge-test
    
     Conflicts:
            arch/x86/include/asm/coco.h
            arch/x86/include/asm/disabled-features.h
            arch/x86/include/asm/mem_encrypt.h
            arch/x86/mm/fault.c
    
    Signed-off-by: Bob the builder <bp@alien8.de>

diff --cc arch/x86/include/asm/coco.h
index 76c310b19b11,21940ef8d290..42871bb262d0
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@@ -10,9 -11,15 +11,15 @@@ enum cc_vendor 
  	CC_VENDOR_INTEL,
  };
  
 -extern enum cc_vendor cc_vendor;
+ extern u64 cc_mask;
+ 
  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 +extern enum cc_vendor cc_vendor;
- void cc_set_mask(u64 mask);
+ static inline void cc_set_mask(u64 mask)
+ {
+ 	RIP_REL_REF(cc_mask) = mask;
+ }
+ 
  u64 cc_mkenc(u64 val);
  u64 cc_mkdec(u64 val);
  #else
diff --cc arch/x86/include/asm/disabled-features.h
index 1f23960d2b06,3332d2940020..da4054fbf533
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@@ -117,12 -117,12 +117,18 @@@
  #define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
  #endif
  
 +#ifdef CONFIG_X86_FRED
 +# define DISABLE_FRED	0
 +#else
 +# define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
 +#endif
 +
+ #ifdef CONFIG_KVM_AMD_SEV
+ #define DISABLE_SEV_SNP		0
+ #else
+ #define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
+ #endif
+ 
  /*
   * Make sure to add features to the correct mask
   */
diff --cc arch/x86/kernel/sev-shared.c
index fcc6d834e2c4,ae79f9505298..a200bd72fadc
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@@ -9,11 -9,11 +9,13 @@@
   * and is included directly into both code-bases.
   */
  
 +#include <asm/setup_data.h>
 +
  #ifndef __BOOT_COMPRESSED
- #define error(v)	pr_err(v)
- #define has_cpuflag(f)	boot_cpu_has(f)
+ #define error(v)			pr_err(v)
+ #define has_cpuflag(f)			boot_cpu_has(f)
+ #define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
+ #define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
  #else
  #undef WARN
  #define WARN(condition, format...) (!!(condition))
diff --cc arch/x86/mm/fault.c
index e1ac86396446,859adcd123c9..cdb5045a0428
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@@ -34,7 -34,7 +34,8 @@@
  #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
  #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
  #include <asm/irq_stack.h>
 +#include <asm/fred.h>
+ #include <asm/sev.h>			/* snp_dump_hva_rmpentry()	*/
  
  #define CREATE_TRACE_POINTS
  #include <asm/trace/exceptions.h>


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

