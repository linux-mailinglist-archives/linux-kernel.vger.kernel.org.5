Return-Path: <linux-kernel+bounces-57962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A558F84DFC2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E021C24689
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F46F098;
	Thu,  8 Feb 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6LFcP28"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE0A71B4A;
	Thu,  8 Feb 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391923; cv=none; b=b6Y47gioKS6M7aT3LBL3NdJ0bYRV6ljtjVVgaCDTpgLOPcFs98D81scBTqhGtFETIMkLSjr0atuEa1jKKLyLOn2FNN0qz8/+Tb62C1TeDu2U2yzq26zSNuGpoccFKe3KG8UgkOznBAT3yp01T0QzzOy42PBBy+Wwx14HG+XLo/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391923; c=relaxed/simple;
	bh=ymurIB97b11IqH9GZGJPPvkYT9r0Cf4QevmMQfDhVpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHuzshRCFuBqCYPvXzHWx52HfWDhkG6IyWX2KkoBH0XLdXjJvF00tr9ZSg+3mnfwWLz7ckCLBRU4xxCBd4dQHi+k8JPk01GZpfnWRyt5SxPhT2K5SrJjOoYi4tqoIFFwOC1QtYkgZAKuJlLQr1Gz7+pnzm74quMWzyeSJkCeuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6LFcP28; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707391923; x=1738927923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymurIB97b11IqH9GZGJPPvkYT9r0Cf4QevmMQfDhVpY=;
  b=G6LFcP28S+N2D4PREKdYvWWX2igv4nKU6DF9T2k6ULGmBRQRMSOJC5D4
   HgvNbO+6v+CgNAxBkxGUcvq6bkWDHFnmn0lVEADPcs1eKOalRdc0EX4oK
   7X/P54TrkEAZ16UJru49s1I67ytYsbhiHaK5XaSjuZMBAQTVe9oTdz+BO
   j9OonfEbn05bqGvUXvC333dZ1GZ6XQ6JJun4ham0EJ6wV9LAHcfBJhsRQ
   4/7sxsdBnj3yudBjXB2e2l/dWU4AaBLR/wW77i7JRCI9uTaLZwva8RbDA
   TXgdiEXYVIi4egLQNkB2hgCGdkKbg/3FKnl37ZO2rOdV03iai5CTdrgFL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1345508"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1345508"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:32:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1957470"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.219.88])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:31:56 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V5 03/12] perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
Date: Thu,  8 Feb 2024 13:31:18 +0200
Message-Id: <20240208113127.22216-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208113127.22216-1-adrian.hunter@intel.com>
References: <20240208113127.22216-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Events with aux actions or aux sampling expect the PMI to coincide with the
event, which does not happen for large PEBS, so do not enable large PEBS in
that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3804f21ab049..d50f4325d42a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3885,6 +3885,12 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
 }
 
+static inline bool has_aux_action(struct perf_event *event)
+{
+	return event->attr.aux_pause || event->attr.aux_resume ||
+	       event->attr.aux_sample_size;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -3902,8 +3908,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
-			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event))) {
+			if (!(event->attr.sample_type & ~intel_pmu_large_pebs_flags(event)) &&
+			    !has_aux_action(event)) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
 				event->attach_state |= PERF_ATTACH_SCHED_CB;
 			}
-- 
2.34.1


