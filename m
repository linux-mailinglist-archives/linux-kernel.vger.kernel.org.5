Return-Path: <linux-kernel+bounces-124033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D990891169
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D7028E97D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B522232A;
	Fri, 29 Mar 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cirGLDIs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96972C6B2;
	Fri, 29 Mar 2024 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678180; cv=none; b=RfQsP+b4wKHtXR+xl4VaG4gGjKuWvbgEXIWlycAWLcCIhiSvxasDINNUlsNkkk9sDdRYyaTY4+B/rFZIJfl5sK6hfv/bECnDxLB22KDdj5wRN/miXoq6e9/Uh5/+Re3f3zQSG/JD7ldAfC2s2pq46Auw5lUFmyEmbLRbLnuH6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678180; c=relaxed/simple;
	bh=SYfo7FsBA6K+tnItKudH2rQ2gHHfa93TWwRVJIqbrE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxJrhGMxSfDdS3DSoHE3OydoNQZptQmG8tvagwLWSWYWio7nO1W6lf1n68p43vEc12EfQd0s+yfzw+w9GfYZuDdiQNTxK8o00nR78TFmcPscYJGu//YH5idxjRUzCl2VrkAg6q/VbHtPAL1mxIKs/HBhnV71GAv6izft5ka7UTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cirGLDIs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678177; x=1743214177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SYfo7FsBA6K+tnItKudH2rQ2gHHfa93TWwRVJIqbrE8=;
  b=cirGLDIs6Rg/JAnFQph/A9hVcUJFOjRSL1IP1DrmoWNUbMkdh1Np6Vzq
   vTcAvB7ipjqJUHMqVbf0U+lEu/FzCV2TqPRF+JWjn7QR+d03wWA9UciwH
   R7kKUtYDxeCqgB8qtG/SLxRWnY1LimBRgoodelirBtYYpxPuW6ZvCapZy
   wJOcJmMXEWW8/NhjF3Oy3eJW9JbDcoocQDRUArZxSMG9xH8vWRyqiEHWS
   JqL6LkXKFIGea5e+soPcKuWTMx15qOBqQ2O71QdpDCxr4ves4lo+era29
   dAfYOBOMVGwwnhF4mpPJuDtkWFYG2vKLW4uUf5ZUt82yC9LRv0B5IRtZX
   w==;
X-CSE-ConnectionGUID: KSH3KfosR9G7sXyEwY6Orw==
X-CSE-MsgGUID: CwRmN5NfRw+vExxzPyggVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700018"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700018"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301372"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:36 -0700
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
	chang.seok.bae@intel.com,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v9 01/14] Documentation/x86: Document Key Locker
Date: Thu, 28 Mar 2024 18:53:33 -0700
Message-Id: <20240329015346.635933-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015346.635933-1-chang.seok.bae@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the overview of the feature along with relevant consideration
when provisioning dm-crypt volumes with AES-KL instead of AES-NI.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
Changes from v8:
* Change wording of documentation slightly. (Randy Dunlap and Bagas
  Sanjaya)

Changes from v6:
* Rebase on the upstream -- commit ff61f0791ce9 ("docs: move x86
  documentation into Documentation/arch/"). (Nathan Huckleberry)
* Remove a duplicated sentence -- 'But there is no AES-KL instruction
  to process a 192-bit key.'
* Update the text for clarity and readability:
  - Clarify the error code and exemplify the backup failure
  - Use 'wrapping key' instead of less readable 'IWKey'

Changes from v5:
* Fix a typo: 'feature feature' -> 'feature'

Changes from RFC v2:
* Add as a new patch.

The preview is available here:
  https://htmlpreview.github.io/?https://github.com/intel-staging/keylocker/kdoc/arch/x86/keylocker.html
---
 Documentation/arch/x86/index.rst     |  1 +
 Documentation/arch/x86/keylocker.rst | 96 ++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/arch/x86/keylocker.rst

diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
index 8ac64d7de4dc..669c239c009f 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -43,3 +43,4 @@ x86-specific Documentation
    features
    elf_auxvec
    xstate
+   keylocker
diff --git a/Documentation/arch/x86/keylocker.rst b/Documentation/arch/x86/keylocker.rst
new file mode 100644
index 000000000000..b28addb8eaf4
--- /dev/null
+++ b/Documentation/arch/x86/keylocker.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+x86 Key Locker
+==============
+
+Introduction
+============
+
+Key Locker is a CPU feature to reduce key exfiltration opportunities
+while maintaining a programming interface similar to AES-NI. It
+converts the AES key into an encoded form, called the 'key handle'.
+The key handle is a wrapped version of the clear-text key where the
+wrapping key has limited exposure. Once converted, all subsequent data
+encryption using new AES instructions (AES-KL) uses this key handle,
+reducing the exposure of private key material in memory.
+
+CPU-internal Wrapping Key
+=========================
+
+The CPU-internal wrapping key is an entity in a software-invisible CPU
+state. On every system boot, a new key is loaded. So the key handle that
+was encoded by the old wrapping key is no longer usable on system shutdown
+or reboot.
+
+And the key may be lost on the following exceptional situation upon wakeup:
+
+Wrapping Key Restore Failure
+----------------------------
+
+The CPU state is volatile with the ACPI S3/4 sleep states. When the system
+supports those states, the key has to be backed up so that it is restored
+on wake up. The kernel saves the key in non-volatile media.
+
+Upon the event of a wrapping key restore failure upon resume from suspend,
+all established key handles become invalid. In flight dm-crypt operations
+receive error results from pending operations. In the likely scenario that
+dm-crypt is hosting the root filesystem the recovery is identical to if a
+storage controller failed to resume from suspend or reboot. If the volume
+impacted by a wrapping key restore failure is a data volume then it is
+possible that I/O errors on that volume do not bring down the rest of the
+system. However, a reboot is still required because the kernel will have
+soft-disabled Key Locker. Upon the failure, the crypto library code will
+return -ENODEV on every AES-KL function call. The Key Locker implementation
+only loads a new wrapping key at initial boot, not any time after like
+resume from suspend.
+
+Use Case and Non-use Cases
+==========================
+
+Bare metal disk encryption is the only intended use case.
+
+Userspace usage is not supported because there is no ABI provided to
+communicate and coordinate wrapping-key restore failure to userspace. For
+now, key restore failures are only coordinated with kernel users. But the
+kernel can not prevent userspace from using the feature's AES instructions
+('AES-KL') when the feature has been enabled. So, the lack of userspace
+support is only documented, not actively enforced.
+
+Key Locker is not expected to be advertised to guest VMs and the kernel
+implementation ignores it even if the VMM enumerates the capability. The
+expectation is that a guest VM wants private wrapping key state, but the
+architecture does not provide that. An emulation of that capability, by
+caching per-VM wrapping keys in memory, defeats the purpose of Key Locker.
+The backup / restore facility is also not performant enough to be suitable
+for guest VM context switches.
+
+AES Instruction Set
+===================
+
+The feature accompanies a new AES instruction set. This instruction set is
+analogous to AES-NI. A set of AES-NI instructions can be mapped to an
+AES-KL instruction. For example, AESENC128KL is responsible for ten rounds
+of transformation, which is equivalent to nine times AESENC and one
+AESENCLAST in AES-NI.
+
+But they have some notable differences:
+
+* AES-KL provides a secure data transformation using an encrypted key.
+
+* If an invalid key handle is provided, e.g. a corrupted one or a handle
+  restriction failure, the instruction fails with setting RFLAGS.ZF. The
+  crypto library implementation includes the flag check to return -EINVAL.
+  Note that this flag is also set if the wrapping key is changed, e.g.,
+  because of the backup error.
+
+* AES-KL implements support for 128-bit and 256-bit keys, but there is no
+  AES-KL instruction to process an 192-bit key. The AES-KL cipher
+  implementation logs a warning message with a 192-bit key and then falls
+  back to AES-NI. So, this 192-bit key-size limitation is only documented,
+  not enforced. It means the key will remain in clear-text in memory. This
+  is to meet Linux crypto-cipher expectation that each implementation must
+  support all the AES-compliant key sizes.
+
+* Some AES-KL hardware implementation may have noticeable performance
+  overhead when compared with AES-NI instructions.
-- 
2.34.1


