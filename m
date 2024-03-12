Return-Path: <linux-kernel+bounces-100504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D928798CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DE31F21A92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAC27D409;
	Tue, 12 Mar 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="camh+/iE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B367A127
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260493; cv=none; b=gV+oBQO708GVRNzxUms9U43mDox4zljBiogsiLEXyHViiRbR/HIWaPPq+MQ6AL+MRxb4AoIy6LKEGj8lzcnIv2F6BQBZgFLTBxQhQpOEg0L7UY/HYwyFYxjpWXBY4TCR6Mz11kPuvpjjkbJci6RJL+V3C6R7UO0oEGqA7k5669Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260493; c=relaxed/simple;
	bh=MsRp4JisI5eNtN5dgiPuwkfeV04dXLem3AOVgjpaZK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BEdJU/QQmNmeA0QpgSOmfBoGaMyz/i1cgVDgRt7lz82W3WuVomkhHB4N/Q/vTnTVCPhYjZ3XjqkU618kRykaNkFxon+pOj1xI7houAXYozMfz7Cok74CkCoq3L59kO3j5NZgiYpJeEP1k2COwtjZtBNuxIByM8v659RcJKf5iDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=camh+/iE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710260491; x=1741796491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MsRp4JisI5eNtN5dgiPuwkfeV04dXLem3AOVgjpaZK4=;
  b=camh+/iEnRGQjNMe7XzKGtQGOvrhz3bAvyFg1aXYQaMOqfMHP9899wVl
   jbfN4b33rOiMUH5oVJSxOp2pgjuCHM1LZa2aIcFHdpsRlsabafdu9uIwW
   9pSL+BdOK5kw1dVfgzdJcqjw2CK3EhbYaCWefIR/L7LGaYNlUPddnmUs4
   axXguPfXFYG2CBJ0kCSFkEAHCh+hg7lcMyWU/CWsOFgY7IoGOs7+umblG
   jT/HGkNDDVXviyt7u1fqkiA3GGF1G+7bl7FGBrzo7/glFcQJE+7vNXUsC
   2fpDLnosGVFuSm8PJtIvqGzFIkgCohRQgQdvQARwMer0fDnNbQj3monKq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5585656"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5585656"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 09:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11686637"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmviesa008.fm.intel.com with ESMTP; 12 Mar 2024 09:21:30 -0700
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/apic for 6.9-rc1 (includes a new revert)
Date: Tue, 12 Mar 2024 09:21:25 -0700
Message-Id: <20240312162125.136813-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull an x86/apic revert.  The reverted commit is not x86/apic
material and was cruft left over from a merge.

I believe the sequence of events went something like this:

 * The commit in question was added to x86/urgent
 * x86/urgent was merged into x86/apic to resolve a conflict
 * The commit was zapped from x86/urgent, but *not* from x86/apic
 * x86/apic got pullled (yesterday)

I think we need to be a bit more vigilant when zapping things to
make sure none of the other branches are depending on the zapped
material.

--

The following changes since commit f0551af021308a2a1163dc63d1f1bba3594208bd:

  x86/topology: Ignore non-present APIC IDs in a present package (2024-03-06 14:35:30 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86-apic-2024-03-12

for you to fetch changes up to 532a0c57d7ff75e8f07d4e25cba4184989e2a241:

  Revert "x86/bugs: Use fixed addressing for VERW operand" (2024-03-12 08:33:51 -0700)

----------------------------------------------------------------
 * Revert VERW fixed addressing patch

----------------------------------------------------------------
Dave Hansen (1):
      Revert "x86/bugs: Use fixed addressing for VERW operand"

 arch/x86/include/asm/nospec-branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

