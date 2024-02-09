Return-Path: <linux-kernel+bounces-58980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD31D84EF59
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6DADB29BB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75EC38DD6;
	Fri,  9 Feb 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvnuPpkT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53D25610;
	Fri,  9 Feb 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448501; cv=none; b=nQkAPqIHakcMJTnv2TOIk0oHQ5VQ2G96HowL3fIfgm6yfZiQ1EzWeWXf3TRrNoBe3PB0a17Y21LeSDCm2J2YxqApBBl68WU9AI0d2RUAIKjHCsUBv+RHlv5mNSnvXLNEsYQN6ZwU32Yp3/XR6c5oK+wb92x/eeFylf76O+CEkdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448501; c=relaxed/simple;
	bh=UHYv/wd8Tx2Q5u/rY/pti40zJf3hKXnFNuJLdQgtOuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eG03dlf1P2vqToihW3g+2L0micwUf83CTGGbb6cDXVo8trX8+xa83Ub26FjFw5bjf5Zki6p9QP2iLXOUVYVMD4opfLTIzR5DqkAGcPu/BEux6KlBQjwSMEKVUg9pUdInnBfrBHeF4dxhwhXXVjEuHTU0zye0Myai/LvELv9kZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvnuPpkT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448499; x=1738984499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UHYv/wd8Tx2Q5u/rY/pti40zJf3hKXnFNuJLdQgtOuo=;
  b=MvnuPpkT2/KZ6zS4y8pvDvbb3cDm/0MOALVBKWSpREpLkoKfwRKwsRZV
   p6GXRuv6sFMhPfGdxQzDaR1xcR+yc9Jlf9F4slSBDmbe9GYbw0SpM5kAS
   RTilMKcykHgID+m2T2lpLs8dMWj7qyjgnoN6TWCpsVHwGrBcYt1/7Fd1W
   ga/L1VQH5H2rMsiBaGnzBko2+QzJtNtrVsVP4UyvaVkrRGHSblnSeXZe1
   wOvbcWu68Iu1oubh9YMxzlKJr3Cur+u678p3NeGbvWv3fZeEXSzhIlyGp
   F4++1DbtKg6GSdAldW3yUdqNpRnaVsf5xWezLvO/MF/v1U3X/66iTVEAd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257954"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257954"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631469"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 19:14:48 -0800
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
Subject: [RFC PATCH v4 15/15] perf stat: Add hardware-grouping cmd option to perf stat
Date: Thu,  8 Feb 2024 19:14:41 -0800
Message-ID: <20240209031441.943012-16-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240209031441.943012-1-weilin.wang@intel.com>
References: <20240209031441.943012-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add a cmd option to allow user to choose this new metric grouping method.

$ perf stat -M TopdownL1 -a --hardware-grouping

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d08a40c4bae1..e30f7a856122 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1257,6 +1257,8 @@ static struct option stat_options[] = {
 		       "don't try to share events between metrics in a group"),
 	OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
 		       "disable adding events for the metric threshold calculation"),
+	OPT_BOOLEAN(0, "hardware-grouping", &stat_config.hardware_aware_grouping,
+				"Use hardware aware metric grouping method"),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
 			"measure top-down statistics"),
 	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
-- 
2.42.0


