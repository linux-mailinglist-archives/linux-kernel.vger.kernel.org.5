Return-Path: <linux-kernel+bounces-74209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815985D12E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5BE1F2429B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220783AC24;
	Wed, 21 Feb 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKYzUhTV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92913A8DC;
	Wed, 21 Feb 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500082; cv=none; b=YXd/RMB42A9uO7r75xf61mKfmIEGR+Eqc78IVc2Bm0JUrB3ReSlYE8fUnpgv4voKU4TQnInkikbPz4AqMrW9kvY2QYdVRc5YjGqNGMPbNA1Pv2ItRLkRRfrwHYmJYm9DgRuuvPPcf1kKV3rBEzmM48VPicV1WpCPaUiylkVdqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500082; c=relaxed/simple;
	bh=sWO/YOZX9yLq9g+MSLAwia1i/l0SObPObXL2TnzZdww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oF6+jgfUbKnTXuWd7ai81Dt1AIqmoUo2HqgTl0gSckqOHMMT6HEUBFomyBG85HFpksCcAiMK5xTDDLJFClBKJozMVquGYZTdX6Fg/Y0A8zJp9QO9L9a88xlejY/f4slMjgh94/tugvSQDSICPqa6orMdv5Mb7RRn+QtDFyaI7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKYzUhTV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708500080; x=1740036080;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sWO/YOZX9yLq9g+MSLAwia1i/l0SObPObXL2TnzZdww=;
  b=fKYzUhTVKw86dHuoLLizh+gioXemXY55/QX0USOV9E7kUubGgxLnB+vQ
   xr5dF6GHxsS9Mlb/mFkMViZ9VnjCslOxmVXyS5khry0gDklho/RzrXhqR
   tsg3D6ASfuBivK+vti0TG4w6StBixQvOc3iiwmCC8bKp4YS+tL4iGvS2v
   oX6+XOX4Sxl41Gk8596TEZmayTUbyDta2b4/wlP/IS7uHwMAEhR72v3L8
   ambGDL8ag9ANCYVwucoZLca/4E1si/p25nKwEXc3rivISIaC8WQ46zMiX
   8PwfVLiNgmkgnuT8m/XBfnJtuHK+ba2uC2CzfH2VXcTQadoQDlx+Uee10
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2529991"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2529991"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5017427"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa010.fm.intel.com with ESMTP; 20 Feb 2024 23:21:19 -0800
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
Subject: [RFC PATCH v1 0/5] TPEBS counting mode support
Date: Wed, 21 Feb 2024 02:20:54 -0500
Message-ID: <20240221072100.412939-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

TPEBS is one of the features provided by the next generation of Intel PMU.
Please refer to Section 8.4.1 of "Intel® Architecture Instruction Set Extensions
Programming Reference" [1] for more details about this feature.

This set of patches supports TPEBS in counting mode. The code works in the
following way: it forks a perf record process from perf stat when retire_latency
of one or more events are used in a metric formula. Perf stat would send a
SIGTERM signal to perf record before it needs the retire latency value for
metric calculation. Perf stat will then process sample data to extract the
retire latency data for metric calculations. Currently, the code uses the
arithmetic average of retire latency values.

[1] https://www.intel.com/content/www/us/en/content-details/812218/intel-architecture-instruction-set-extensions-programming-reference.html?wapkw=future%20features

  perf stat: Parse and find tpebs events when parsing metrics to prepare
    for perf record sampling
  perf stat: Fork and launch perf record when perf stat needs to get
    retire latency value for a metric.
  perf stat: Add retire latency values into the expr_parse_ctx to
    prepare for final metric calculation
  perf stat: Create another thread for sample data processing
  perf stat: Add retire latency print functions to print out at the very
    end of print out

 tools/perf/builtin-stat.c      | 222 ++++++++++++++++++++++++++++++++-
 tools/perf/util/data.c         |   4 +
 tools/perf/util/data.h         |   1 +
 tools/perf/util/metricgroup.c  |  61 +++++++--
 tools/perf/util/metricgroup.h  |  18 ++-
 tools/perf/util/stat-display.c |  65 ++++++++++
 tools/perf/util/stat-shadow.c  |  18 +++
 tools/perf/util/stat.h         |   5 +
 8 files changed, 376 insertions(+), 18 deletions(-)

--
2.43.0


