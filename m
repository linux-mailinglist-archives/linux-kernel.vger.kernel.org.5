Return-Path: <linux-kernel+bounces-124032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B677891166
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E016A1F245C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D042DF7D;
	Fri, 29 Mar 2024 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTxu05Wi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B52C68C;
	Fri, 29 Mar 2024 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678178; cv=none; b=RDdMbRO3MABg4zzNIVbfMNVvm7fAI24g8AuHZVAMRSNQyI/MiKbjcMTqApLuQoUEd4THM1zDbuhWQGdDYfgLT9ofOKUUQtlnAKi0nJ/tAtXS2uMHl89Le9RjPLaI8fYJKCkaUt9IFGPmuoHBUgZNjhEi5fGscIB8I1+dQ01ueOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678178; c=relaxed/simple;
	bh=FSsoc2bilwBnLscLx6U4GiKDrWPS92uMLAaFdcmDj7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9V9bqNfxUhPAzPS0IVL+Aw1QSJlxyf6iLOKVsth1H8oTHM8qSwOe+20KYlJ18CjEvCuogxcFg+96pfmvDDI2jliiYVAYl6dHqQPZVIQfqjVWqkXoVwmigNB46vXZITZVywV6jFt24wykjN4Oo+qn+JuTdKqqiGNtLPCn60dvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTxu05Wi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678176; x=1743214176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FSsoc2bilwBnLscLx6U4GiKDrWPS92uMLAaFdcmDj7k=;
  b=kTxu05WihevV2ekoa9ehtieAgJVBXLf9PC3nTfzUQZkywYhRbVkWCFd5
   m9lLRjz35/eh+fbkYpD5RY/NfL1dDDBRY9lc2DJGEY77z4vhFwTmi/Wfc
   29G9lzsWoBY4TGFrX7ovtkRihUcoZSCmib43qdUgxv64h4P0s3sDUhyKK
   3a+Y46pFEwmTV9qSaNDDjETgSU6yZqqFiD1JsFB42ZDghPPZeOVbhxd0d
   q2M+aaJ2dJWsqPU3lzITFLgTcgOuddeHfdTlxG6bC6NI9gBq00uLbXPJt
   tYE1eBpgsJdB+JSrJLaGJhRBKcAz3M2e+RDWIJfiThv2bD1AimhaQvOJ5
   Q==;
X-CSE-ConnectionGUID: GaWborRxRRqH+K5VqPwN/A==
X-CSE-MsgGUID: 6ftjLkmGRYWujFrMuMJ0Rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700009"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700009"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301369"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:34 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dm-devel@redhat.com
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 00/14] x86: Support Key Locker
Date: Thu, 28 Mar 2024 18:53:32 -0700
Message-Id: <20240329015346.635933-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603152227.12335-1-chang.seok.bae@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

As posting this version, I wanted to make sure these code changes were
acknowledgeable at first:

The previous enabling process has been paused to address vulnerabilities
[1][2] that could compromise Key Locker's ability to protect AES keys.
Now, with the mainlining of mitigations [3][4], patches (Patch 10-11)
were added to ensure the application of these mitigations.

During this period, there was a significant change in the mainline commit
b81fac906a8f ("x86/fpu: Move FPU initialization into
arch_cpu_finalize_init()"). This affected Key Locker's initialization
code, which clobbers XMM registers for loading a wrapping key, as it
depends on FPU initialization.

In this revision, the setup code was adjusted to separate the
initialization part to be invoked during arch_initcall(). The remaining
code for copying the wrapping key from the backup resides in the
identify_cpu() -> setup_keylocker() path. This separation simplifies the
code and resolves an issue with hotplug.

The remaining changes mainly focus on the AES crypto driver, addressing
feedback from Eric. Notably, while doing so, it was realized better to
disallow a module build. Key Locker's AES instructions do not support
192-bit keys. Supporting a module build would require exporting some
AES-NI functions, leading to performance-impacting indirect calls. I
think we can revisit module support later if necessary.

Then, the following is a summary of changes per patch since v8 [6]:

PATCH7-8:
* Invoke the setup code via arch_initcall() due to upstream changes
  delaying the FPU setup.

PATCH9-11:
* Add new patches for security and hotplug support clarification

PATCH12:
* Drop the "nokeylocker" option. (Borislav Petkov)

PATCH13:
* Introduce 'union x86_aes_ctx'. (Eric Biggers)
* Ensure 'inline' for wrapper functions.

PATCH14:
* Combine the XTS enc/dec assembly code in a macro.  (Eric Biggers)
* Define setkey() as void instead of returning 'int'.  (Eric Biggers)
* Rearrange the assembly code to reduce jumps, especially for success
  cases.  (Eric Biggers)
* Update the changelog for clarification. (Eric Biggers)
* Exclude module build.

This series is based on my AES-NI setkey() cleanup [7], which has been
recently merged into the crypto repository [8], and I thought it was
better to go first. You can also find this series here:
    git://github.com/intel-staging/keylocker.git kl-v9

Thanks,
Chang

[1] Gather Data Sampling (GDS)
    https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/gather-data-sampling.html
[2] Register File Data Sampling (RFDS)
    https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/register-file-data-sampling.html
[3] Mainlining of GDS mitigation
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=64094e7e3118aff4b0be8ff713c242303e139834
[4] Mainlining of RFDS Mitigation
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e33cf955f07e3991e45109cb3e29fbc9ca51d06
[5]  Initialize FPU late
    https://lore.kernel.org/lkml/168778151512.3634408.11432553576702911909.tglx@vps.praguecc.cz/
[6] V8: https://lore.kernel.org/lkml/20230603152227.12335-1-chang.seok.bae@intel.com/
[7] https://lore.kernel.org/lkml/20240322230459.456606-1-chang.seok.bae@intel.com/
[8] git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git

Chang S. Bae (14):
  Documentation/x86: Document Key Locker
  x86/cpufeature: Enumerate Key Locker feature
  x86/insn: Add Key Locker instructions to the opcode map
  x86/asm: Add a wrapper function for the LOADIWKEY instruction
  x86/msr-index: Add MSRs for Key Locker wrapping key
  x86/keylocker: Define Key Locker CPUID leaf
  x86/cpu/keylocker: Load a wrapping key at boot time
  x86/PM/keylocker: Restore the wrapping key on the resume from ACPI
    S3/4
  x86/hotplug/keylocker: Ensure wrapping key backup capability
  x86/cpu/keylocker: Check Gather Data Sampling mitigation
  x86/cpu/keylocker: Check Register File Data Sampling mitigation
  x86/Kconfig: Add a configuration for Key Locker
  crypto: x86/aes - Prepare for new AES-XTS implementation
  crypto: x86/aes-kl - Implement the AES-XTS algorithm

 Documentation/arch/x86/index.rst            |   1 +
 Documentation/arch/x86/keylocker.rst        |  96 +++++
 arch/x86/Kconfig                            |   3 +
 arch/x86/Kconfig.assembler                  |   5 +
 arch/x86/crypto/Kconfig                     |  17 +
 arch/x86/crypto/Makefile                    |   3 +
 arch/x86/crypto/aes-helper_asm.S            |  22 ++
 arch/x86/crypto/aes-helper_glue.h           | 168 ++++++++
 arch/x86/crypto/aeskl-intel_asm.S           | 412 ++++++++++++++++++++
 arch/x86/crypto/aeskl-intel_glue.c          | 187 +++++++++
 arch/x86/crypto/aeskl-intel_glue.h          |  35 ++
 arch/x86/crypto/aesni-intel_asm.S           |  47 +--
 arch/x86/crypto/aesni-intel_glue.c          | 193 ++-------
 arch/x86/crypto/aesni-intel_glue.h          |  40 ++
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/disabled-features.h    |   8 +-
 arch/x86/include/asm/keylocker.h            |  42 ++
 arch/x86/include/asm/msr-index.h            |   6 +
 arch/x86/include/asm/special_insns.h        |  28 ++
 arch/x86/include/uapi/asm/processor-flags.h |   2 +
 arch/x86/kernel/Makefile                    |   1 +
 arch/x86/kernel/cpu/common.c                |   4 +-
 arch/x86/kernel/cpu/cpuid-deps.c            |   1 +
 arch/x86/kernel/keylocker.c                 | 219 +++++++++++
 arch/x86/lib/x86-opcode-map.txt             |  11 +-
 arch/x86/power/cpu.c                        |   2 +
 tools/arch/x86/lib/x86-opcode-map.txt       |  11 +-
 27 files changed, 1363 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/arch/x86/keylocker.rst
 create mode 100644 arch/x86/crypto/aes-helper_asm.S
 create mode 100644 arch/x86/crypto/aes-helper_glue.h
 create mode 100644 arch/x86/crypto/aeskl-intel_asm.S
 create mode 100644 arch/x86/crypto/aeskl-intel_glue.c
 create mode 100644 arch/x86/crypto/aeskl-intel_glue.h
 create mode 100644 arch/x86/crypto/aesni-intel_glue.h
 create mode 100644 arch/x86/include/asm/keylocker.h
 create mode 100644 arch/x86/kernel/keylocker.c


base-commit: 3a447c31d337bdec7fbc605a7a1e00aff4c492d0
-- 
2.34.1


