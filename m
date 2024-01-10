Return-Path: <linux-kernel+bounces-22789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA0D82A2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712BA1C26523
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B84F219;
	Wed, 10 Jan 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7W6pNwj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0A4EB5B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704919888; x=1736455888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QHnyFo9ejNaykr4G0UljJ5k6cMGEXXchv5ezu/u559Y=;
  b=g7W6pNwjtj3c6XZJemugNfafgY+IYhqoA7/uuPIpAFdY1rCbp8kjHXJ1
   HHXBMp5g2L735PEvRQYD4HHrzLwAE04Mb7xldTE0ktGzFfQrIEB40IFSg
   NAkR6UvrGNzUbhF2lTAcAWCTR+YxYBRAHmGB6+C5iooI8jYr6cWIAGmog
   AtbBVRMKouGq7GRfKC+0Za1D9Q+6vDBsJ9kwXPGOO63t3FGH11+jiYRzs
   Aoen4vA90n2k4sUi2c+y6RD24QqstWlC1T2K7HjVAF9g0c1Y+pbFXU31Z
   6evswRDUTcaQW44txAH2CeFmeBXC6n1S0rmm5nBaWAp1asUGuRdu+3Gx9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5729010"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5729010"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 12:51:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="785735678"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="785735678"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2024 12:51:26 -0800
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/sgx for 6.8
Date: Wed, 10 Jan 2024 12:51:24 -0800
Message-Id: <20240110205124.3007385-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull some x86/sgx changes for 6.8.  This time, these are
entirely confined to SGX selftests fixes.

The mini SGX enclave built by the selftests has garnered some
attention because it stands alone and does not need the sizable
infrastructure of the official SGX SDK. I think that's why folks
are suddently interested in cleaning it up.

--

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.8

for you to fetch changes up to 981cf568a8644161c2f15c02278ebc2834b51ba6:

  selftests/sgx: Skip non X86_64 platform (2023-12-08 10:08:17 -0800)

----------------------------------------------------------------
 - Clean up selftest compilation issues, mostly from non-gcc compilers
 - Avoid building selftests when not on x86

----------------------------------------------------------------
Jo Van Bulck (13):
      selftests/sgx: Fix uninitialized pointer dereference in error path
      selftests/sgx: Fix uninitialized pointer dereferences in encl_get_entry
      selftests/sgx: Include memory clobber for inline asm in test enclave
      selftests/sgx: Separate linker options
      selftests/sgx: Specify freestanding environment for enclave compilation
      selftests/sgx: Remove redundant enclave base address save/restore
      selftests/sgx: Produce static-pie executable for test enclave
      selftests/sgx: Handle relocations in test enclave
      selftests/sgx: Fix linker script asserts
      selftests/sgx: Ensure test enclave buffer is entirely preserved
      selftests/sgx: Ensure expected location of test enclave buffer
      selftests/sgx: Discard unsupported ELF sections
      selftests/sgx: Remove incomplete ABI sanitization code in test enclave

Zhao Mengmeng (1):
      selftests/sgx: Skip non X86_64 platform

 tools/testing/selftests/sgx/Makefile              | 14 +++--
 tools/testing/selftests/sgx/defines.h             |  2 +
 tools/testing/selftests/sgx/load.c                |  9 ++-
 tools/testing/selftests/sgx/sigstruct.c           |  5 +-
 tools/testing/selftests/sgx/test_encl.c           | 67 +++++++++++++++--------
 tools/testing/selftests/sgx/test_encl.lds         | 10 ++--
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 28 +++-------
 7 files changed, 78 insertions(+), 57 deletions(-)

