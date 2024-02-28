Return-Path: <linux-kernel+bounces-85333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A459686B45F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452011F25C32
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FEF15E5BB;
	Wed, 28 Feb 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8W2TVQV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55615DBC6;
	Wed, 28 Feb 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136759; cv=none; b=Ynk2KtCEJt2iNeAJkBPEocxSw88JRyNMZRuf1fz+XM+JtQBNLDE7fL0ebN5DpklGXieHy7ZvHdS322Fv1ZFIJxgoar7ljkdmA3kMxK+/13yTL7akH2exqmurhbpdufgX13TfmvEmMWr1chzmEX47JiPef6DdhgTPAGuDUdCXSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136759; c=relaxed/simple;
	bh=TtxlkLjemhVA7naUWEsRN3piPn2lTf4DBGen143ZDxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbixGd/G7cfGDMi66xxz4b6tjXORBOErs6EeZodFJqqn5Z6sb4rQ6fhlo2PWfxaZlCzyIaedxRfG9p++fMQgI2QLJv4bztTXscA0SR/ZAQ3FpcsOyNAVderkZrGSae1I3OaM2j3umFepSOsIsWbLUkxIGzStMM2fpAcp56yLPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8W2TVQV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709136758; x=1740672758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TtxlkLjemhVA7naUWEsRN3piPn2lTf4DBGen143ZDxA=;
  b=L8W2TVQV6sTr3UzaKOg1j6YM69Yb1vSi0KVWPcoDWdr8zoKaOwvYeE1B
   dP/Ehl7mFKJyjOqYJ0iFHm9aiy+WtBMF/PPlRaH4WBK4blKE/JjV3yEFk
   wtAI0n7gtjoxVa96+lR/TmQIJRtmHsqeVjfeakughnpUzi9VD/2cEpTdH
   qJdjt9K9gJ1QiUVLhsmQi7ByPykkz+QK8QJRjfTdpPiDYnL+JDi50yk4H
   lNqB52bdDK608oQrn5XhO7+nYn2NqW7qsWseo5ndOnxYAPHNMrjva9tAB
   ilDwnvleG7CVOX/J976gpqwx05d5iLD7KmCIPQGcNBgQ/GcIIZqpf+9d9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14185440"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14185440"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7418084"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa010.jf.intel.com with ESMTP; 28 Feb 2024 08:12:36 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v2 0/6] TPEBS counting mode support
Date: Wed, 28 Feb 2024 11:12:21 -0500
Message-ID: <20240228161227.484886-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Changes in v2:
- Add MTL metric file
- Add more descriptions and example to the patch [Arnaldo]

Here is an example of running perf stat to collect a metric that uses
retire_latency value of event MEM_INST_RETIRED.STLB_HIT_STORES on a MTL system.

In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORES sample.
Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p count and retire_latency value
are all 0.

/perf stat -M tma_dtlb_store -a -- sleep 1

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.000 MB - ]

 Performance counter stats for 'system wide':

       181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tma_dtlb_store
         3,195,608      cpu_core/topdown-retiring/
        40,156,649      cpu_core/topdown-mem-bound/
         3,550,925      cpu_core/topdown-bad-spec/
       117,571,818      cpu_core/topdown-fe-bound/
        57,118,087      cpu_core/topdown-be-bound/
            69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
             4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
        30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
        30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
           168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
              0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0        0

       1.003105924 seconds time elapsed

v1: https://lore.kernel.org/all/20240221072100.412939-1-weilin.wang@intel.com/

Weilin Wang (6):
  perf stat: Parse and find tpebs events when parsing metrics to prepare
    for perf record sampling
  perf stat: Fork and launch perf record when perf stat needs to get
    retire latency value for a metric.
  perf stat: Add retire latency values into the expr_parse_ctx to
    prepare for final metric calculation
  perf stat: Create another thread for sample data processing
  perf stat: Add retire latency print functions to print out at the very
    end of print out
  perf vendor events intel: Add MTL metric json files

 tools/perf/builtin-stat.c                     |  222 +-
 .../arch/x86/meteorlake/metricgroups.json     |  127 +
 .../arch/x86/meteorlake/mtl-metrics.json      | 2531 +++++++++++++++++
 tools/perf/util/data.c                        |    4 +
 tools/perf/util/data.h                        |    1 +
 tools/perf/util/metricgroup.c                 |   73 +-
 tools/perf/util/metricgroup.h                 |   18 +-
 tools/perf/util/stat-display.c                |   65 +
 tools/perf/util/stat-shadow.c                 |   18 +
 tools/perf/util/stat.h                        |    5 +
 10 files changed, 3046 insertions(+), 18 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json

--
2.43.0


