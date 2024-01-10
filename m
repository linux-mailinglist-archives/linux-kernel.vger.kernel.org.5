Return-Path: <linux-kernel+bounces-22809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C239882A32E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC00286B24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEF54F5EC;
	Wed, 10 Jan 2024 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8fgbPxK"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515644F219
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704921507; x=1736457507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cfaP81IHOOzCGJygxejGsPS0pogAXrgN8vCCGYRNWNU=;
  b=n8fgbPxKtnJ15jHZa9ClnWFpy3Rnhpf5l3WxQm1yCc2JvWZXBaIlFd7p
   Wb39t9uof9hmC1skszlfWYrMknZ/NJXKhDB3bE5xxNmqGoBZ38NR6zAB6
   YyZNRWCxp6hauidcIWjt0ERcJRIpryjtYZCsPEEfMBsn4U8mqwdiObvqj
   e2dqNQ5rdXm0xgNKRiHH+3W8DyFWzL8NaEDe8dqc6jTGb2ctLkttePAwt
   tWEetW27kM5qubLKrBprqFmJ36ecTu1+4ReYWNkldw+zQMD177dymsOmE
   ldTr1frEa2VxTcOjskOvZGDFaA3sljQ+Rwrj7AhANSn+Zmn03etS2aQfH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="484837195"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="484837195"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 13:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="816485570"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="816485570"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2024 13:18:25 -0800
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/tdx for 6.8
Date: Wed, 10 Jan 2024 13:18:22 -0800
Message-Id: <20240110211822.3014608-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull some x86/tdx changes for 6.8.  This contains the initial
support for host-side TDX support so that KVM can run TDX-protected
guests.  This does not include the actual KVM-side support which
will come from the KVM folks.  The TDX host interactions with kexec
also needs to be ironed out before this is ready for prime time, so
this code is currently Kconfig'd off when kexec is on.

The majority of the code here is the kernel telling the TDX module
which memory to protect and handing some additional memory over to it
to use to store TDX module metadata.  That sounds pretty simple, but
the TDX architecture is rather flexible and it takes quite a bit of
back-and-forth to say, "just protect all memory, please."

There is also some code tacked on near the end of the series to handle
a hardware erratum.  The erratum can make software bugs such as a
kernel write to TDX-protected memory cause a machine check and
masquerade as a real hardware failure.  The erratum handling watches
out for these and tries to provide nicer user errors.

--

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.8

for you to fetch changes up to 83e1bdc94f32dcf52dfcd2025acc7a2b9376b1e8:

  x86/virt/tdx: Make TDX host depend on X86_MCE (2023-12-14 14:08:24 -0800)

----------------------------------------------------------------
 - Add support managing TDX host hardware

----------------------------------------------------------------
Dave Hansen (1):
      x86/virt/tdx: Disable TDX host support when kexec is enabled

Kai Huang (20):
      x86/virt/tdx: Detect TDX during kernel boot
      x86/virt/tdx: Define TDX supported page sizes as macros
      x86/virt/tdx: Make INTEL_TDX_HOST depend on X86_X2APIC
      x86/virt/tdx: Handle SEAMCALL no entropy error in common code
      x86/virt/tdx: Add SEAMCALL error printing for module initialization
      x86/virt/tdx: Add skeleton to enable TDX on demand
      x86/virt/tdx: Use all system memory when initializing TDX module as TDX memory
      x86/virt/tdx: Get module global metadata for module initialization
      x86/virt/tdx: Add placeholder to construct TDMRs to cover all TDX memory regions
      x86/virt/tdx: Fill out TDMRs to cover all TDX memory regions
      x86/virt/tdx: Allocate and set up PAMTs for TDMRs
      x86/virt/tdx: Designate reserved areas for all TDMRs
      x86/virt/tdx: Configure TDX module with the TDMRs and global KeyID
      x86/virt/tdx: Configure global KeyID on all packages
      x86/virt/tdx: Initialize all TDMRs
      x86/virt/tdx: Handle TDX interaction with sleep and hibernation
      x86/cpu: Detect TDX partial write machine check erratum
      x86/mce: Differentiate real hardware #MCs from TDX erratum ones
      Documentation/x86: Add documentation for TDX host support
      x86/virt/tdx: Make TDX host depend on X86_MCE

 Documentation/arch/x86/tdx.rst     |  207 ++++-
 arch/x86/Kconfig                   |    5 +
 arch/x86/coco/tdx/tdx-shared.c     |    6 +-
 arch/x86/include/asm/cpufeatures.h |    2 +
 arch/x86/include/asm/msr-index.h   |    3 +
 arch/x86/include/asm/shared/tdx.h  |    6 +
 arch/x86/include/asm/tdx.h         |   38 +
 arch/x86/kernel/cpu/common.c       |    2 +
 arch/x86/kernel/cpu/mce/core.c     |   15 +
 arch/x86/kernel/setup.c            |    2 +
 arch/x86/virt/vmx/tdx/Makefile     |    2 +-
 arch/x86/virt/vmx/tdx/tdx.c        | 1492 ++++++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h        |  121 +++
 13 files changed, 1886 insertions(+), 15 deletions(-)
 create mode 100644 arch/x86/virt/vmx/tdx/tdx.c
 create mode 100644 arch/x86/virt/vmx/tdx/tdx.h

