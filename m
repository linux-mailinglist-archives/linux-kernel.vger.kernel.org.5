Return-Path: <linux-kernel+bounces-85613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC886B84C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAAD9B24B75
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2A315DBC1;
	Wed, 28 Feb 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoovqNOP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B574413;
	Wed, 28 Feb 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149040; cv=none; b=mhftdAfUsdtNvMIn7oLohMqmGLBbEZx5j8S+gKuRZtUGidYPFmPQTYG3afhGygOjr6ZjgtlDT1BHRA2HSGGQ4w7gga0MoaCjISxxYylw/xaJq20dYw/QgCWwAP1SLQc9gFlhqR5XQ9bD5EP8NJoSWeHrQNb8z2IQtj2aCtCWnxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149040; c=relaxed/simple;
	bh=qRN8tgRWPtXi3u4gmjpERHUYkozuPU04HqhOdsqu3zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeOGV4wdQec6oEBtheOBqcuWGJZRpBDkMei+prcaB0o/XbMQo2VjJf06LW7su2NMRV4LDQ9RKg04YJhX43J1IobraM9jVYw3izWkpR8fI7KmfQlnzJRJS0+gEzK5Ur5TCaUI2BjYZYcY3vwTP7caQr0eKSU9r/kYmHmXJNX+apA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoovqNOP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149039; x=1740685039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qRN8tgRWPtXi3u4gmjpERHUYkozuPU04HqhOdsqu3zY=;
  b=PoovqNOPh83g5hELR3CeUjXf9+EJV8xWLMvLCZddLeNFIzIqXaSDSz1d
   pP2At7L9ONjDTHF/w4YFXwph/Cm8K/h0IHySiEQ4pRbg/BBVfA6CFCjzE
   SPWY9AkowbuK9cZxRnAjrkA3lFuMHR+jod9NwOpIqCYIJWeh4ZFIDCA+q
   ykF9L2MXCX5ZulMnXNKJOM3lx4xcJnFBIcS5p3REbd2sFSNeVoEXQJjGb
   VHS7Sh7KR1cNQpOPe2OpDiY31LevW6sIcG/t/HEe5+/wyS2Uwq5ReS1UP
   2Lqe6SyRbRRt1NJv74Ax6656jts8PaFDpLLtCoYI1c5ZwWgJ6CYrDVEfZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3495445"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3495445"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7485363"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:37:17 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 0/2] x86/resctrl: Pass domain to target CPU
Date: Wed, 28 Feb 2024 11:36:52 -0800
Message-ID: <20240228112952.8090-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228112215.8044-tony.luck@intel.com>
References: <20240228112215.8044-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a function is called via IPI, it isn't possible for assertions
in source code to check that the right locks are held when those
locks were obtained by the sender of the IPI.

Restructure some code to avoid the need for the check.

Patch 1 has the actual fix

Patch 2 is just some code cleanups

Changes since V3: https://lore.kernel.org/all/20240222185039.72201-1-tony.luck@intel.com/

Reinette:
1) Improve commit comments in both patches by changing to
   imperative.

2) Move initialzation of "m.res" in domain_setup_ctrlval() from
   patch 1 to patch 2

Tony Luck (2):
  x86/resctrl: Pass domain to target CPU
  x86/resctrl: Simplify call convention for MSR update functions

 arch/x86/kernel/cpu/resctrl/internal.h    |  5 ++-
 arch/x86/kernel/cpu/resctrl/core.c        | 55 +++++++++--------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 42 +++++------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 ++----
 4 files changed, 38 insertions(+), 78 deletions(-)


base-commit: c0d848fcb09d80a5f48b99f85e448185125ef59f
-- 
2.43.0


