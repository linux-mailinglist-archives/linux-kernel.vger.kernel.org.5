Return-Path: <linux-kernel+bounces-49723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF906846E8E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C13B1F226DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9439A13E20B;
	Fri,  2 Feb 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnCGCWus"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A4513D504;
	Fri,  2 Feb 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871706; cv=none; b=DljgmwWYIznkx9gjH1WPi2Li0m0T7Sz/Ti2RuLlfE/4TQXWEAbENXj5DIeT/rCj1wkytjfWi3k4BlyH4AqLcL55LU04hzq4ldW+EZXTEKm4EiAKEvPGQulAL90wStY33VqDb1j+cuZaNh+h/xL+/O66iPtVrseG01hJykAtv38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871706; c=relaxed/simple;
	bh=d3RYZ3+6vD59qvNSR99INzel292Ot602uZFnHAzYWPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GpjYRqcyNWHZPthjQHdApSRyiPMI5AyE5n8gsftD4IjBJsrbwQM1XckMXUVFHmqfZqJ99/u/sWJW/xZLhVuCWvT3hHW7vvBz6M82pgMiihQkb9xXhZ5M8UdC3JH1CYr0UfY8ZnKt3/SOaTiVnDnH/m458ByaV8QORxFfXmpQ6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnCGCWus; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706871705; x=1738407705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3RYZ3+6vD59qvNSR99INzel292Ot602uZFnHAzYWPk=;
  b=bnCGCWusKdRx6Mbg8pbxn28hwKfEs9Aq1GB0TPIYy6xo4c6O8jSP622G
   bG6b+xBRAb++X68RdY9eDXq4pI0T8gOiIYfc8dcDVzymc2OVh6lyU6PZL
   UVJuqkknQoYAHchg+gst+wqBhBvP12Eu23/aOkPPs2igUesm7/4bjY7Bv
   loJIdPoK4e/bLiseD7OUS0tUuS9M0grUKBJwV7/7LavVKxMPeWncD+lxm
   nEjuMFr/95IjqimFTeWFp4ncNg9y/BiEW0VnB9rDh5S+R8gCijzN8kOhD
   k3HmkQ+r+aambQEJWfCL2dK+/0MPJ5yxjVPKDzjkMQG+vFW5S+MrronAJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="394571887"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="394571887"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 03:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639303"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.118])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 03:01:43 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Like Xu <like.xu.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf script: Make it possible to see perf's kernel and module memory mappings
Date: Fri,  2 Feb 2024 13:01:29 +0200
Message-Id: <20240202110130.3553-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202110130.3553-1-adrian.hunter@intel.com>
References: <20240202110130.3553-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Dump kmaps if verbose > 2.

Example:

  $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel
  build id event received for /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko: 0691d75e10e72ebbbd45a44c59f6d00a5604badf [20]
  Map: 0-3a3 4f5d8 [kvm_intel].modinfo
  Map: 0-5240 5f280 [kvm_intel]__versions
  Map: 0-30 64 [kvm_intel].note.Linux
  Map: 0-14 644c0 [kvm_intel].orc_header
  Map: 0-5297 43680 [kvm_intel].rodata
  Map: 0-5bee 3b837 [kvm_intel].text.unlikely
  Map: 0-7e0 41430 [kvm_intel].noinstr.text
  Map: 0-2080 713c0 [kvm_intel].bss
  Map: 0-26 705c8 [kvm_intel].data..read_mostly
  Map: 0-5888 6a4c0 [kvm_intel].data
  Map: 0-22 70220 [kvm_intel].data.once
  Map: 0-40 705f0 [kvm_intel].data..percpu
  Map: 0-1685 41d20 [kvm_intel].init.text
  Map: 0-4b8 6fd60 [kvm_intel].init.data
  Map: 0-380 70248 [kvm_intel]__dyndbg
  Map: 0-8 70218 [kvm_intel].exit.data
  Map: 0-438 4f980 [kvm_intel]__param
  Map: 0-5f5 4ca0f [kvm_intel].rodata.str1.1
  Map: 0-3657 493b8 [kvm_intel].rodata.str1.8
  Map: 0-e0 70640 [kvm_intel].data..ro_after_init
  Map: 0-500 70ec0 [kvm_intel].gnu.linkonce.this_module
  Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko

The example above shows how the module section mappings are all wrong
except for the main .text mapping at 0xffffffffc13a7000.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b1f57401ff23..e764b319ef59 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3806,6 +3806,16 @@ static int parse_callret_trace(const struct option *opt __maybe_unused,
 	return 0;
 }
 
+static void dump_kmaps(struct perf_session *session)
+{
+	int save_verbose = verbose;
+
+	pr_debug("Kernel and module maps:\n");
+	verbose = 0; /* Suppress verbose to print a summary only */
+	maps__fprintf(machine__kernel_maps(&session->machines.host), stderr);
+	verbose = save_verbose;
+}
+
 int cmd_script(int argc, const char **argv)
 {
 	bool show_full_info = false;
@@ -4366,6 +4376,9 @@ int cmd_script(int argc, const char **argv)
 
 	flush_scripting();
 
+	if (verbose > 2)
+		dump_kmaps(session);
+
 out_delete:
 	if (script.ptime_range) {
 		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
-- 
2.34.1


