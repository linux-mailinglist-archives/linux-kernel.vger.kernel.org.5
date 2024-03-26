Return-Path: <linux-kernel+bounces-118548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A84988BC7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8F41F32652
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FA8EEA8;
	Tue, 26 Mar 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnpbjfLa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F617C9;
	Tue, 26 Mar 2024 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441958; cv=none; b=nAP+cZ0Fuz5cxKG+5M8djk3agZH2QxBcSLEijZ3WrSbrkTs/p9XUcskgBZLmkYUPB+lB35ab1YxKU3eF5Wk7UT2ljAg9biwhM+fB8T7H/hR3BkAYRrDL+F85ATmppeG1/jVKlgbNThoiyfZ/YHchUTA/qlJHWl7cfjixUTsLs8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441958; c=relaxed/simple;
	bh=vtibaTy0fmAZOxfP+IoeO8sTpBtyzW8llhwWsl5a9Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5N0uCKP80dT8OpyLs65qGaWz6vuvr/RhYes2VtOdfwaNUrICn4jgz6kMT/hZc7OJ8AFqTUv4wgohDByGvsY9j81EvGAwXyhHCbKdVa9nKBPjpKAr3w9dMQ6RRMde6I2MfzTUkJeROtcKxUiXB/wt05nDXCoaRDN3rwekI2JLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnpbjfLa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711441956; x=1742977956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vtibaTy0fmAZOxfP+IoeO8sTpBtyzW8llhwWsl5a9Q4=;
  b=dnpbjfLaegZ8/x1Qv+7S97bHmQGt8Ee1O4nyzLwulFgtkcAovEZpcZO4
   idDrNHPHfcG2yXgymwpmltdSjjFgyJs2XOc9TSrEjluhvd8Hrcu0WRWh8
   rSyVCFzNJiQRYiNtxp32DQZNkqX0ap3CTjOy+QDL04Pgw8J+Re5R0KK6p
   cdCxosQTzdaA9IJDbrGL/BJT5InziHeVEqqsPYG0TtWgsWJbu9EHYCNdl
   F1p0vcO5i6woAKD4tetotp1jUClT5RFjqNx+XoKRklm+cwxDHjltHKq93
   ro6SyfUDK6jcWZLBuoNRASsmI+9IEg1USWfrqXiDIkpSkwU5SeRTmJ6xr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17910815"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="17910815"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 01:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="15931833"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.215])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 01:32:33 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf intel-pt: Fix unassigned instruction op
Date: Tue, 26 Mar 2024 10:32:23 +0200
Message-Id: <20240326083223.10883-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320162619.1272015-1-irogers@google.com>
References: <20240320162619.1272015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

MemorySanitizer discovered instances where the instruction op value was
not assigned.:

  WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x5581c00a76b3 in intel_pt_sample_flags tools/perf/util/intel-pt.c:1527:17
  Uninitialized value was stored to memory at
    #0 0x5581c005ddf8 in intel_pt_walk_insn tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:1256:25

The op value is used to set branch flags for branch instructions
encountered when walking the code, so fix by setting op to
INTEL_PT_OP_OTHER in other cases.

Reported-by: Ian Rogers <irogers@google.com>
Closes: https://lore.kernel.org/linux-perf-users/20240320162619.1272015-1-irogers@google.com/
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
 tools/perf/util/intel-pt.c                          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index b450178e3420..e733f6b1f7ac 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1319,6 +1319,8 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder, bool no_tip)
 	bool ret = false;
 
 	decoder->state.type &= ~INTEL_PT_BRANCH;
+	decoder->state.insn_op = INTEL_PT_OP_OTHER;
+	decoder->state.insn_len = 0;
 
 	if (decoder->set_fup_cfe_ip || decoder->set_fup_cfe) {
 		bool ip = decoder->set_fup_cfe_ip;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f38893e0b036..4db9a098f592 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -764,6 +764,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 
 	addr_location__init(&al);
 	intel_pt_insn->length = 0;
+	intel_pt_insn->op = INTEL_PT_OP_OTHER;
 
 	if (to_ip && *ip == to_ip)
 		goto out_no_cache;
@@ -898,6 +899,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 
 			if (to_ip && *ip == to_ip) {
 				intel_pt_insn->length = 0;
+				intel_pt_insn->op = INTEL_PT_OP_OTHER;
 				goto out_no_cache;
 			}
 
-- 
2.34.1


