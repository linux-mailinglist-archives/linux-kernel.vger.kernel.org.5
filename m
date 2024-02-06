Return-Path: <linux-kernel+bounces-54987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D0F84B5EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0436C282CE2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4412FF9F;
	Tue,  6 Feb 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZB58BqL3"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847471DA3F;
	Tue,  6 Feb 2024 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224715; cv=none; b=DJG/49QKaQnPtkN4nNqdSV3SgIjKdeTQTRJuixG6kfFCp8tqCby2ws2xSo49wJnQIgwyY7bAHVGb7Ft6nTafalzQL0u97WCuYVeOwxXDlUyVljwqIkVDyfD38S3T5kJa4KjjB8d3psF+DjxmhqfCz564iGK/zbVgrW0frzRo7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224715; c=relaxed/simple;
	bh=wVw9qf7WnHE9ADCIENN6XtG8+XAbmJBfpkrWnYewZjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tvHGCL8FXFE7bzHbIqrE6BAjZX6/gXL/mtIP4OWDshGdm7ZBycklIjLNgy4v177hVpzYCWw3+kaLuNcPKxegsSsb9Lsh5TYxNOSdWpmSquMoVMEymE9H6nKe7Y40AJcGCA9xBOWvDVRtpF+6GGR3mqW2YRop8NiBNfzKd9+TZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZB58BqL3; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707224713; x=1738760713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wVw9qf7WnHE9ADCIENN6XtG8+XAbmJBfpkrWnYewZjw=;
  b=ZB58BqL3cLb4nSbj4OR27TQpNqXDVRRN0yN/A8ceBhTvgO352vO2nap1
   WKgl4KrokU3gYOEx0Q6LHHxLl7R7EeowUJdqZ4FNIpgZi0jGBYCpWPPDU
   +69jIwCTZ+wuH1LOZvXIe7GzqkMyg03pQIdiEiXq5su0bFcz5i7+nADuR
   KmAv6WA2ZN5oZg/g+edr6ARcjRcu/ej328rHP//nZJ2DJtPqigIpVNspi
   XaQqdC9cXr2SgFZztCrq4N4zLYf60y048jbsAfIkvA8OZCq4v4FyVZDN6
   LqHs1eVBTlEyDnzmQ8HUMwv5cJcVSqYVgBKOzZYCXWiFl5uXuGsd7Ojsa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="395161860"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="395161860"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:05:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="999413"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:05:10 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Like Xu <like.xu.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V2 0/2] perf symbols: Slightly improve module file executable section mappings
Date: Tue,  6 Feb 2024 15:04:56 +0200
Message-Id: <20240206130458.8867-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Currently perf does not record module section addresses except for
the .text section. In general that means perf cannot get module section
mappings correct (except for .text) when loading symbols from a kernel
module file. (Note using --kcore does not have this issue)

Here are a couple of patches to help shed light upon and slightly improve
the situation.


Changes in V2:

  perf tools: Make it possible to see perf's kernel and module memory mappings
    - add dump to perf report (if no browser) as well as perf script
    - add 'perf --debug kmaps' option also to dump kmaps


Adrian Hunter (2):
      perf tools: Make it possible to see perf's kernel and module memory mappings
      perf symbols: Slightly improve module file executable section mappings

 tools/perf/Documentation/perf.txt |  2 ++
 tools/perf/builtin-report.c       |  2 ++
 tools/perf/builtin-script.c       |  3 ++
 tools/perf/util/debug.c           |  3 ++
 tools/perf/util/debug.h           |  1 +
 tools/perf/util/python.c          |  1 +
 tools/perf/util/session.c         | 11 ++++++
 tools/perf/util/session.h         |  2 ++
 tools/perf/util/symbol-elf.c      | 75 +++++++++++++++++++++++++++++++++++++--
 9 files changed, 98 insertions(+), 2 deletions(-)


Regards
Adrian

