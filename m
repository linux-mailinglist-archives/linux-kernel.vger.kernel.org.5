Return-Path: <linux-kernel+bounces-132618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F90D899761
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D43B1F21D1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C074143882;
	Fri,  5 Apr 2024 08:00:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0F713D27F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304020; cv=none; b=reNZ0x37vkTDO1s37PnUC1fOMLt4Ub0oYYWfg/ozPbhPp+wgRmBkITfHtLBUOUqqsudq1gg4W1zJhwICTqIQTgxDs8aed3qeEvDfDHzWLXXW7zdJfgg+X8f443p0NPSLZeurnWLxRT6gDbSMj4mKKTK2CyTSnkm8LXkPONnEOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304020; c=relaxed/simple;
	bh=K0jbqizd5zPHT9aXGkLOAN145XISiFK3wtDOu1N1MTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EVJoyyM5AX6XmxoCmcmPNxNYVpk6+BtW9i8wO+7XBgxmsDiMUlXgxMOfYB3stxBlXP9neY8Gqjl03eAGStFfRlvnTzLeet6T0O+lA+tMpEslv3YBLOplausn9LNJtbtd+j+23YFAq0l+HCAs0ccTVPIbY7DueeLl/63ZMGy5gYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D362DFEC;
	Fri,  5 Apr 2024 01:00:48 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B0C63F64C;
	Fri,  5 Apr 2024 01:00:13 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC 0/8] arm64/hw_breakpoint: Enable FEAT_Debugv8p9
Date: Fri,  5 Apr 2024 13:30:00 +0530
Message-Id: <20240405080008.1225223-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables FEAT_Debugv8p9 thus extending breakpoint and watchpoint
support upto 64. This has been lightly tested and still work is in progress
but would like to get some early feedback on the approach.

Possible impact of context switches while tracing kernel addresses needs to
be evaluated regarding MDSELR_EL1 access. This series is based on v6.9-rc2.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (8):
  arm64/sysreg: Add register fields for MDSELR_EL1
  arm64/sysreg: Add register fields for HDFGRTR2_EL2
  arm64/sysreg: Add register fields for HDFGWTR2_EL2
  arm64/sysreg: Update ID_AA64MMFR0_EL1 register
  KVM: arm64: Explicitly handle MDSELR_EL1 traps as UNDEFINED
  arm64/cpufeature: Add field details for ID_AA64DFR1_EL1 register
  arm64/boot: Enable EL2 requirements for FEAT_Debugv8p9
  arm64/hw_breakpoint: Enable FEAT_Debugv8p9

 Documentation/arch/arm64/booting.rst    | 19 +++++++
 arch/arm64/include/asm/debug-monitors.h |  2 +-
 arch/arm64/include/asm/el2_setup.h      | 27 ++++++++++
 arch/arm64/include/asm/hw_breakpoint.h  | 46 +++++++++++++----
 arch/arm64/include/asm/kvm_arm.h        |  1 +
 arch/arm64/kernel/cpufeature.c          | 21 ++++++--
 arch/arm64/kernel/debug-monitors.c      | 16 ++++--
 arch/arm64/kernel/hw_breakpoint.c       | 33 ++++++++++++
 arch/arm64/kvm/sys_regs.c               |  1 +
 arch/arm64/tools/sysreg                 | 68 +++++++++++++++++++++++++
 10 files changed, 214 insertions(+), 20 deletions(-)

-- 
2.25.1


