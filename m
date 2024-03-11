Return-Path: <linux-kernel+bounces-99308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B518C878652
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6968A1F22F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970674D108;
	Mon, 11 Mar 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmRrOpNV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36543AD6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178246; cv=none; b=qOtTQfvwoWSOA0XAwY0Bj7DMWcWg39KhJCpBzL+DZ8lUI8Xv6vwnWfsfQ0Ogg7XTZAyxZNSZKWa44XUoUX6YGJ17VzjVSpnMb4aYSr8mW/qmhU4TnNO2OXeT5qph0n4qhzvv7vp+KPjwNf9EP4Fxv6jAHEbf5IStXGURkZRxBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178246; c=relaxed/simple;
	bh=5WP9lf3hnr6aq0ogvU4rMIUGFF7GFrRpn9zsCB+QEXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=alf9xUmIA/G51wSsEqHsYVk4d3yaWVB3yFIsIX2EUFSDx3gVilCrMVi0u5arunLOznNqmnz8fiBbCHGEBeanvCoGGq3pzNxK/AKzpIblYV6p2lsVq2y/IRy2gmwUbDENdG9MX1r19YMRkJyDfKr+OCdnrG3ZzqA8/EqVQvb0TGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmRrOpNV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710178245; x=1741714245;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5WP9lf3hnr6aq0ogvU4rMIUGFF7GFrRpn9zsCB+QEXA=;
  b=kmRrOpNVz78Lkpxppi1OdoSfZLTdvuLDLZiWcVRHU0IibTtvubkkdfEG
   J5l71gsUSNYGEcJiOHw6rOj+bjXgDqwdbtpxUeQjuaJf+5ekjlfIjoH3c
   a9TysONc6GBEJs9ltvHBVyKklKGunY2mlcbDovl0ytn2w+OA3qyom1cdV
   5Tr8+uI4BDz+af8+1s0TujgO+CZqzQ3QGcXOhGOEgl5w/5KQVIcx3s3xy
   XN0NJnOeLIHWsWNeysdKaf2Wf1vd3K4LUiCIZ0kqSg3p4ThMdUmoSoFAa
   3azD+mPlYVeEPBCcLSZsPumZspawVHM3URJLlqrpHEIq5xJs3rl9o0mZS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="7804247"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="7804247"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 10:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11665910"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orviesa006.jf.intel.com with ESMTP; 11 Mar 2024 10:30:44 -0700
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/mm for 6.9
Date: Mon, 11 Mar 2024 10:30:34 -0700
Message-Id: <20240311173034.345007-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull some x86/mm changes for 6.9.  The three changes are quite
diverse.  No real common themes across them.

There is an extra merge in here from Ingo after 6.8-rc1.  I believe
there were some early 6.8 bugs that were complicating testing x86/mm
and the merge made thing easier.

--

The following changes since commit ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7:

  Merge tag 'net-6.8-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-01-25 10:58:35 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.9

for you to fetch changes up to 82ace185017fbbe48342bf7d8a9fd795f9c711cd:

  x86/mm/cpa: Warn for set_memory_XXcrypted() VMM fails (2024-02-22 14:25:41 -0800)

----------------------------------------------------------------
 * Add a warning when memory encryption conversions fail.  These
   operations require VMM cooperation, even in CoCo environments
   where the VMM is untrusted.  While it's _possible_ that memory
   pressure could trigger the new warning, the odds are that a
   guest would only see this from an attacking VMM.
 * Simplify page fault code by re-enabling interrupts unconditionally
 * Avoid truncation issues when pfns are passed in to
   pfn_to_kaddr() with small (<64-bit) types.

----------------------------------------------------------------
Ingo Molnar (1):
      Merge branch 'linus' into x86/mm, to refresh the branch and pick up fixes

Linus Torvalds (1):
      x86/mm: Get rid of conditional IF flag handling in page fault path

Michael Roth (1):
      x86/mm: Ensure input to pfn_to_kaddr() is treated as a 64-bit type

Rick Edgecombe (1):
      x86/mm/cpa: Warn for set_memory_XXcrypted() VMM fails

 arch/x86/include/asm/page.h  |  6 +++++-
 arch/x86/mm/fault.c          | 27 ++++++++++++++-------------
 arch/x86/mm/pat/set_memory.c | 19 +++++++++++++------
 3 files changed, 32 insertions(+), 20 deletions(-)

