Return-Path: <linux-kernel+bounces-72781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA69885B8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1851C22AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B441612CE;
	Tue, 20 Feb 2024 10:09:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0E760EF3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423795; cv=none; b=F8kPnvwYBE1B0LzcWKv+gpxOLOfNWW3/2g4Jp6zZ/yyc67sZxgAUVy9D0mMBIABcaA4mexTE4iImZlqPxiaMpCdfTqZ1i8IeXdil3YjZKUyfWWgTmu0XFxHMD/EDI2xq7X71QpDVc2eR/DvtPtoyjA+HyeKhuq3GRO81DMB/eR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423795; c=relaxed/simple;
	bh=A2eOSnPIv2BnCL8/8a9vmmcXJ7iPeW5lcw5+Fy9dzjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o2m6OLoXLhJWtH6tt1r+t/8gUI3JUWfbJwVcQkPXrq8Rsn29RVNBf5s8HlUa8A0UqVyoKR9LsDSkl408bTDJtUCWR9te8JIRr3JZSoZoFAihfr95mWHtO6XaU3RSVVk/54JKpUqU1SCzkp+W9iXCCAV+f/yP+49ZT3igjEhhiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B05FEC;
	Tue, 20 Feb 2024 02:10:27 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 236ED3F762;
	Tue, 20 Feb 2024 02:09:42 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	oliver.upton@linux.dev,
	broonie@kernel.org
Cc: James Clark <james.clark@arm.com>,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Donnefort <vdonnefort@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] kvm/coresight: Support exclude guest and exclude host
Date: Tue, 20 Feb 2024 10:09:10 +0000
Message-Id: <20240220100924.2761706-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a combination of the RFC for nVHE here [1] and v3 of VHE version
here [2]. After a few of the review comments it seemed much simpler for
both versions to use the same interface and be in the same patchset.

FEAT_TRF is a Coresight feature that allows trace capture to be
completely filtered at different exception levels, unlike the existing
TRCVICTLR controls which may still emit target addresses of branches,
even if the following trace is filtered.

Without FEAT_TRF, it was possible to start a trace session on a host and
also collect trace from the guest as TRCVICTLR was never programmed to
exclude guests (and it could still emit target addresses even if it
was).

With FEAT_TRF, the current behavior of trace in guests exists depends on
whether nVHE or VHE are being used. Both of the examples below are from
the host's point of view, as Coresight isn't accessible from guests.
This patchset is only relevant to when FEAT_TRF exists, otherwise there
is no change.

  nVHE/pKVM:

  Because the host and the guest are both using TRFCR_EL1, trace will be
  generated in guests depending on the same filter rules the host is
  using. For example if the host is tracing userspace only, then guest
  userspace trace will also be collected.

  (This is further limited by whether TRBE is used because an issue
  with TRBE means that it's completely disabled in nVHE guests, but it's
  possible to have other tracing components.)

  VHE:

  With VHE, the host filters will be in TRFCR_EL2, but the filters in
  TRFCR_EL1 will be active when the guest is running. Because we don't
  write to TRFCR_EL1, guest trace will be completely disabled.

With this change, the guest filtering rules from the Perf session are
now honored for both nVHE and VHE modes. This is done by either writing
to TRFCR_EL12 at the start of the Perf session and doing nothing else
further, or caching the guest value and writing it at guest switch for
nVHE. In pKVM, trace is now be disabled for both protected and
unprotected guests.

---

Changes since V4 [3]:
  * Remove all V3 changes that made it work in pKVM and just disable
    trace there instead
  * Restore PMU host/hyp state sharing back to how it was
    (kvm_pmu_update_vcpu_events())
  * Simplify some of the duplication in the comments and function docs
  * Add a WARN_ON_ONCE() if kvm_etm_set_guest_trfcr() is called when
    the trace filtering feature doesn't exist.
  * Split sysreg change into a tools update followed by the new register
    addition

Changes since V3:
  * Create a new shared area to store the host state instead of copying
    it before each VCPU run
  * Drop commit that moved SPE and trace registers from host_debug_state
    into the kvm sysregs array because the guest values were never used 
  * Document kvm_etm_set_guest_trfcr()
  * Guard kvm_etm_set_guest_trfcr() with a feature check
  * Drop Mark B and Suzuki's review tags on the sysreg patch because it
    turned out that broke the Perf build and needed some unconventional
    changes to fix it (as in: to update the tools copy of the headers in
    the same commit as the kernel changes)

Changes since V2:

  * Add a new iflag to signify presence of FEAT_TRF and keep the
    existing TRBE iflag. This fixes the issue where TRBLIMITR_EL1 was
    being accessed even if TRBE didn't exist
  * Reword a commit message

Changes since V1:

  * Squashed all the arm64/tools/sysreg changes into the first commit
  * Add a new commit to move SPE and TRBE regs into the kvm sysreg array
  * Add a comment above the TRFCR global that it's per host CPU rather
    than vcpu

Changes since nVHE RFC [1]:

 * Re-write just in terms of the register value to be written for the
   host and the guest. This removes some logic from the hyp code and
   a value of kvm_vcpu_arch:trfcr_el1 = 0 no longer means "don't
   restore".
 * Remove all the conditional compilation and new files.
 * Change the kvm_etm_update_vcpu_events macro to a function.
 * Re-use DEBUG_STATE_SAVE_TRFCR so iflags don't need to be expanded
   anymore.
 * Expand the cover letter.

Changes since VHE v3 [2]:

 * Use the same interface as nVHE mode so TRFCR_EL12 is now written by
   kvm.

[1]: https://lore.kernel.org/kvmarm/20230804101317.460697-1-james.clark@arm.com/
[2]: https://lore.kernel.org/kvmarm/20230905102117.2011094-1-james.clark@arm.com/
[3]: https://lore.kernel.org/linux-arm-kernel/20240104162714.1062610-1-james.clark@arm.com/

James Clark (7):
  arm64: KVM: Fix renamed function in comment
  arm64/sysreg/tools: Update tools copy of sysreg.h
  arm64/sysreg/tools: Move TRFCR definitions to sysreg
  arm64: KVM: Add iflag for FEAT_TRF
  arm64: KVM: Add interface to set guest value for TRFCR register
  arm64: KVM: Write TRFCR value on guest switch with nVHE
  coresight: Pass guest TRFCR value to KVM

 arch/arm64/include/asm/kvm_host.h             |   7 +-
 arch/arm64/include/asm/sysreg.h               |  12 -
 arch/arm64/kernel/image-vars.h                |   1 +
 arch/arm64/kvm/debug.c                        |  50 ++-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c            |  53 ++-
 arch/arm64/kvm/hyp/nvhe/setup.c               |   2 +-
 arch/arm64/tools/sysreg                       |  41 ++
 .../coresight/coresight-etm4x-core.c          |  42 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   3 +
 tools/arch/arm64/include/asm/sysreg.h         | 375 +++++++++++++++++-
 tools/include/linux/kasan-tags.h              |  15 +
 12 files changed, 541 insertions(+), 62 deletions(-)
 create mode 100644 tools/include/linux/kasan-tags.h

-- 
2.34.1


