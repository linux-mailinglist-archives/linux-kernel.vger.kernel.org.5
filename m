Return-Path: <linux-kernel+bounces-99313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAFE878664
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7558FB20E27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A04D13F;
	Mon, 11 Mar 2024 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVi3JBJT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0029CEC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178739; cv=none; b=TsyWPWXIf8y683eDMa5HB5ewA7Lks1qic2oWGN3Pk7s9NlODKTsU72pA85ieHz/+vWm7lwwOIaD8K43KhaCkeQdjtQ5RCf8P5QmjGq33uLF6ksObPXFlGSx5TxRnbPBqgudAAHvg9/OXPamsmXP7YuZoxus45OzIdIIYZazpCVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178739; c=relaxed/simple;
	bh=WnOJaUrEuIGqOTlTLw3nYmV+6+eOVRfx15d7KCV/6dk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0wgb2FV4fe4tysHmleqcrAkfCCWt7kiLxRZ66bAPDL8hXpKzFjFSltwBCmfYYzuQpgpMxpv2salYfBvB+Zj5aGpOT8p3+tqJdfDhxnjKn9ELrLqPw9ai7DkPTRKVzoSITFeEUS5AWlsKh4ZohXUp4VBQONskkU1baIZaTcJHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVi3JBJT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710178737; x=1741714737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WnOJaUrEuIGqOTlTLw3nYmV+6+eOVRfx15d7KCV/6dk=;
  b=DVi3JBJTpsb9KS2YjOvj2l39WKcaLODAInUe997r6eYCwO0Jq6YzXWqB
   W1pCRp25X4REPqLJnRhsA4RABBxMH4KO11ZyZ0oHiXzX7CrpNQKOWGJ3g
   eXL1yACLrc+VE55A/iDv+wins1030du6PxuuSOXTgg8RfY/n2eAi8QaXC
   zR+IZutcqvQW69I9bndWwX5IKp1w/WOdsEJVxmkuQTMCWPFrLKLHGTDIg
   TJ08mfbJae19ElCOpazM7bHN69CIfinW663EjG4OyT6iX8jmLz60nGqGF
   qjNyq6ye0z1NSmQ9g+Inr7Pf8IdyKxlSkcps1g3rHUGY83kFJXEZ3bJpK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="27328138"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="27328138"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 10:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11342038"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmviesa008.fm.intel.com with ESMTP; 11 Mar 2024 10:38:56 -0700
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/tdx for 6.9
Date: Mon, 11 Mar 2024 10:38:55 -0700
Message-Id: <20240311173855.346357-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull an x86/tdx change for 6.9.  This one is rather unremarkable,
just fixing up the fact that TDX is now using movdir64b() for non-__iomem
addresses.

--

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.9

for you to fetch changes up to 5bdd181821b2c65b074cfad07d7c7d5d3cfe20bf:

  x86/asm: Remove the __iomem annotation of movdir64b()'s dst argument (2024-02-22 14:52:09 -0800)

----------------------------------------------------------------
 * Fix sparse warning from TDX use of movdir64b()

----------------------------------------------------------------
Kai Huang (1):
      x86/asm: Remove the __iomem annotation of movdir64b()'s dst argument

 arch/x86/include/asm/io.h            | 2 +-
 arch/x86/include/asm/special_insns.h | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

