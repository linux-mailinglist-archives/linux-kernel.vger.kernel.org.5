Return-Path: <linux-kernel+bounces-131585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB198989C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DD6286855
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBC6129A74;
	Thu,  4 Apr 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtRsklA3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03625823D0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240289; cv=none; b=OHVKQ3ardpcNMn3zPWFMB0YakFOIbQ9chor1C4SX13vIjKrjoYiZBzXnmYxorT+C1S434ZEDnPZ7GbL082v1Y63nqCSCIrKPhtmMbTvNTC6XGUDm3PQIosOgx6mIU/JmaRqOHNerIoquQFVn0jZUtObpsAvQd8Zpuy1sOT9xAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240289; c=relaxed/simple;
	bh=0R4kNPXFRWw5JZlP3UgRfrZbUP2J4I3eJItlMeBUI54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mHSomdDZt7FDXURcuMCNihgVtdcD/6YwMZAIeOX0wndzwbzL50X1T+G0AST7u9UZGXTumQH+Va8rp7thyJgpdtYpC6FB4NrGtB/ETqIsByrQBJNDs2epCnQd8U5oU1Yx1A0O1aYC/FMXAN0ZkWWUiqfIDVSoWNqetlQEChlhzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtRsklA3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712240289; x=1743776289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0R4kNPXFRWw5JZlP3UgRfrZbUP2J4I3eJItlMeBUI54=;
  b=FtRsklA3iFHhtyTprZdCoWoftLtPcqArtYG/OtYTlYgL4M8VmCmMNVlP
   fs7BNRKggLiKcbp+A9MGxEolsuUyLnXfNCjW5fno3RH0epvWxc4FT6ben
   9GzPkiXcH8jru0VcI4e3N5pBQu2fVqngKbpGKtaPtJH/Wo5UpIun6AVPi
   od4wrqIfcUOcL7CAm/FsQCoAAd2SGQS2FyIbVFcRQT1BJHkW2rx8JmPbt
   4/vZbDHPFltOYfkFo8o71/5xg83PWe2eEf5GfnXwBDLY330NsnsmSSCnb
   c19tAmt0uoTafyJMoBcgP3kQMPoq4EfiWl/oFwR+KFg2zZnsNde5m/oEg
   g==;
X-CSE-ConnectionGUID: O/D9YR5ZQ/SRcZZ0b944rw==
X-CSE-MsgGUID: owIfIx8kRlaLIVENRj13VQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7632414"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7632414"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:18:08 -0700
X-CSE-ConnectionGUID: mXBcMkSqRjSDQR28vfsnzQ==
X-CSE-MsgGUID: 63qsQRvuSXyxPOpNAeB14Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23448344"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 04 Apr 2024 07:18:06 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/4] Support Lunar Lake and Arrow Lake uncore PMU
Date: Thu,  4 Apr 2024 07:17:02 -0700
Message-Id: <20240404141706.1235531-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

From the uncore PMU's perspective, the Lunar Lake and Arrow Lake are the
same, which are similar to the previous generation Meteor Lake. The
uncore PerfMon registers are located at both MSR and MMIO space.
The patch set is to enable the uncore PMUs for the Lunar Lake and
Arrow Lake.

Kan Liang (2):
  perf/x86/intel/uncore: Factor out common MMIO init and ops functions
  perf/x86/intel/uncore: Add Lunar Lake and Arrow Lake support

Zhenyu Wang (2):
  perf/x86/intel/uncore: Add LNL uncore iMC freerunning support
  perf/x86/intel/uncore: Use D0:F0 as a default device

 arch/x86/events/intel/uncore.c     |   7 ++
 arch/x86/events/intel/uncore.h     |   2 +
 arch/x86/events/intel/uncore_snb.c | 169 ++++++++++++++++++++++++++---
 3 files changed, 161 insertions(+), 17 deletions(-)

-- 
2.35.1


