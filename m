Return-Path: <linux-kernel+bounces-58966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5113184EF4A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E671C2625D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58FF4C9D;
	Fri,  9 Feb 2024 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAPZcWYe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361934A28;
	Fri,  9 Feb 2024 03:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448490; cv=none; b=QERdp1YwJrF+07zJgsx4ayyw2xUSW7pz3WgRFs3MEezSLXvbsrvaU6Tp+1gfzXA/dQkXxcm+hJ3JkvAVkaJyzfgaE2KnYdraW/pwt4aAgdYnS+OpI5IshVCt89N5cc5NlWxN8o/lbpJ4GECI4WZf7JAMuLRWMrmxI94yOAOKKV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448490; c=relaxed/simple;
	bh=/qrAJe4JPth0HrN2viuXOrLNb41b0iCYzbzAL5ueynA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLrWrG2NiVKxl7MXQG4/zApIqoRr3LZ5YMVQApgKgKCaem/JGvXpuQUY3sKdRbmLHmMUXP9xpPmQZ/GPQ6PPdwpsKlY3BUvGW406E9/iK1buGFK+x/KzURrukQ48H92jj4+gu+2OM4u3NyYz+pea5d9KBI9T2my/OAkwa0IBMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAPZcWYe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448488; x=1738984488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/qrAJe4JPth0HrN2viuXOrLNb41b0iCYzbzAL5ueynA=;
  b=LAPZcWYezbSaKBFwIwgT2s8SdYQv6F2jQMjx0OnxcQgdMqgbyJKV0sS+
   UuYb9JQprWFJult9yaP6Cg2jZs8xQcc0G+t+tLWcama+yfgdtGRySnnlf
   5H5Zp68X65DXm7Sid7PKXI+SKwM49/5M6HHbxh/MSFkEKBKOCfXIidiFR
   BJ1M5IEqnyadBryt9UUxzAUqtcgBJPGmhVPH+rHWhAhIEKhFKjSGh5bI6
   or2zA0g0zgyZtkJ4/MvdVHXXZCQLp1VYqa4ztXYUhsbvp3vd6Yz6NyfnX
   VEKD5g2RGH907ihwbtyiOePwAFAE6JoFAvSFo6mM+gfcz7lFq2Q+JZGP7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257869"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257869"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631398"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 19:14:47 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH v4 00/15]  Perf stat metric grouping with hardware information
Date: Thu,  8 Feb 2024 19:14:26 -0800
Message-ID: <20240209031441.943012-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Changes in v4:
- Update bitmap operation functions [Kan, Ian]
- Move data struct definitions to metricgroup.c for smaller scope [Ian]
- Update variable names and comments for better readbility [Ian]
- Exclude JSON files from this patch. A seperate patch set with complete set of
JSON files will be submitted soon.

v3: https://lore.kernel.org/all/20231212230224.1473300-1-weilin.wang@intel.com/

Weilin Wang (15):
  perf stat: Add new field in stat_config to enable hardware aware
    grouping.
  perf stat: Add basic functions for the hardware aware grouping
  perf pmu-events: Add functions in jevent.py to parse counter and event
    info for hardware aware grouping
  find_bit: add _find_last_and_bit() to support finding the most
    significant set bit
  perf stat: Add functions to set counter bitmaps for hardware-grouping
    method
  perf stat: Add functions to get counter info
  perf stat: Add functions to create new group and assign events into
    groups
  perf stat: Add build string function and topdown events handling in
    hardware-grouping
  perf stat: Add function to handle special events in hardware-grouping
  perf stat: Add function to combine metrics for hardware-grouping
  perf stat: Handle taken alone in hardware-grouping
  perf stat: Handle NMI in hardware-grouping
  perf stat: Code refactoring in hardware-grouping
  perf stat: Add tool events support in hardware-grouping
  perf stat: Add hardware-grouping cmd option to perf stat

 tools/include/linux/find.h         |   18 +
 tools/lib/find_bit.c               |   33 +
 tools/perf/builtin-stat.c          |    7 +
 tools/perf/pmu-events/jevents.py   |  192 +++-
 tools/perf/pmu-events/pmu-events.h |   35 +-
 tools/perf/util/metricgroup.c      | 1338 +++++++++++++++++++++++++---
 tools/perf/util/metricgroup.h      |    1 +
 tools/perf/util/stat.h             |    1 +
 8 files changed, 1464 insertions(+), 161 deletions(-)

--
2.42.0


