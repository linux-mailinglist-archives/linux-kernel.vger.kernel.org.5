Return-Path: <linux-kernel+bounces-125313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444C8923E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F381F24267
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DA31327ED;
	Fri, 29 Mar 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiPfjqN1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74393134BC;
	Fri, 29 Mar 2024 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739569; cv=none; b=esk6k1VQRoQhZ26OTxF7Cs8VdzFwhk4zrcZDCSMS3sCGDv7wrjwzxpEj9Ma1bEClvV8cmWMlik6GfGHBtdwlI0S5R3vFctwl8AfpHnrGqfrouxAh3PSaaaa8oCn5cY+z3SXD2MJvY9e4RitE0dYNrEPV2UgUsrc+FN+C6i7CUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739569; c=relaxed/simple;
	bh=PhJsaVSIH+3Xn404O+UuU0ng9/qhbjK6g4uHW3AZtUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJfa18EkrNobGmjoMxy98DPS9EYc0su0vbiwd2urxhBTzMBAKTVhdf4RJsSZNyoJ95kGf0nIEzXZy/aqqbKG0qHKIjSeRuDVuMBWf+HJ1BDvqk+QWZw87aX2ShRHSHlPBX9rQmMhCFag58SsqwTdDN6aMznqd2+gWZjNDDX45Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiPfjqN1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711739567; x=1743275567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PhJsaVSIH+3Xn404O+UuU0ng9/qhbjK6g4uHW3AZtUc=;
  b=DiPfjqN1pmZy4/ha8/O+jtZ+sHHbT+0+KrlHwP3977rjuVg2fayY7tiZ
   Pg7h6rpnXk19A5loyb5zl9Wk0VM8gGqYqyo6BZZZl02Cxqggl54pIaMgu
   AuT6ShceG6gRXmXdiaEglX8DLf/M0APL4IMSZtFqhazKzQwXw5ZvX4gYa
   sOzhCV6bxMoXk0kaYUXmlDXeYALVO8Tm4MBc49sZb9d/zX5V4vRqXptiJ
   cGk7F2gZdoh7omomZaupbWnahBO6OP2xKu5NXJuE1G/O6y1O9490WQ9am
   FpZRtcP7Qo+aMjTRYPoXUm4YJp93i3CTLFrSxGuICo8KLDRDOuHs28sc2
   A==;
X-CSE-ConnectionGUID: i98yuQrjTCSWMCYw/DrTCA==
X-CSE-MsgGUID: AKTKWhvPTTWg7Db1pcNdsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7531713"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7531713"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 12:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="54506849"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa001.jf.intel.com with ESMTP; 29 Mar 2024 12:12:46 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v6 0/5] TPEBS counting mode support
Date: Fri, 29 Mar 2024 15:12:19 -0400
Message-ID: <20240329191224.1046866-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Changes in v5:
- Update code and add comments for better code quality [Namhyung]
- Remove the added fd var and directly pass the opened fd to data.file.fd [Namhyung]
- Add kill() to stop perf record when perf stat exists early [Namhyung]
- Add command opt check to ensure only start perf record when -a/-C given [Namhyung]
- Squash commits [Namhyung]

v5: https://lore.kernel.org/lkml/CO6PR11MB56353F87C19F5D1DD913F94FEE3A2@CO6PR11MB5635.namprd11.prod.outlook.com/

Weilin Wang (5):
  perf stat: Parse and find tpebs events when parsing metrics to prepare
    for perf record sampling
  perf stat: Fork and launch perf record when perf stat needs to get
    retire latency value for a metric.
  perf stat: Add retire latency values into the expr_parse_ctx to
    prepare for final metric calculation
  perf stat: Add retire latency print functions to print out at the very
    end of print out
  perf vendor events intel: Add MTL metric json files

 tools/perf/builtin-stat.c                     |  225 +-
 .../arch/x86/meteorlake/metricgroups.json     |  127 +
 .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
 tools/perf/util/data.c                        |    6 +-
 tools/perf/util/metricgroup.c                 |   88 +-
 tools/perf/util/metricgroup.h                 |   22 +-
 tools/perf/util/stat-display.c                |   65 +
 tools/perf/util/stat-shadow.c                 |   19 +
 tools/perf/util/stat.h                        |    4 +
 9 files changed, 3087 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json

--
2.43.0


