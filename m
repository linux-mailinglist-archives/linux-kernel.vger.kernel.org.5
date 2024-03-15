Return-Path: <linux-kernel+bounces-104102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAFA87C8FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9461F21AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D832014AA9;
	Fri, 15 Mar 2024 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SE1/bntu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB412E7E;
	Fri, 15 Mar 2024 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710486831; cv=none; b=dL5IBbQZzRRkCSz0QyMoCRcNH9CorFPhl18PnCA6MiJnIZn+RdpLvZZEQxdNgLb5HveTrUeKTo35JOlBxdxU5alAcql61FZke5UHK1ECC3kvVuv3JIbNhQk6a+LZeoJ5ZYC2SpoHsH+h3uIQof0DVyptaTMRSNIfhcVqp/IAW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710486831; c=relaxed/simple;
	bh=UyFBeKvLT+ZiBhexR+XrfHeJIbOTRyU4RjqwtKWn9FI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ruQRpzQ+yUx5BF/S3pGFislGih+mMyIYLbi/Ad537sPHfACCSUWxXxzWa1VfjdNPyFdb9ik6ON2Jn+EOX+/46RrlJPnXT+xsZvfAKJFMVJEBpk2/zrUo9N4GsZ3ryAVexvaHkxq3enmytJOavZSgHHSra/9jm2J7vfyC4J7A1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SE1/bntu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710486829; x=1742022829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UyFBeKvLT+ZiBhexR+XrfHeJIbOTRyU4RjqwtKWn9FI=;
  b=SE1/bntuGkrjxHaXSBjrYyyhk62VV8F54G3kmcNYrmUbToAsLnvzrKy4
   77Y2/rhn2XQuODpsNRVD9IUCZ1ZQtyR3Pu3+zA6M916RYTQSkYRIn6hpI
   AWK3sYxLNr4QnH7WxxXdq4oW6yEhinWeCxRFEBXj1R1TFPVd5I4n8nyqV
   LO04WxET8qUHzgeSl4RYhU503T9YcewzeqCbGGAtrWdAoV1fbMHfJORyq
   H90T44PUjAzjUmFzfCMTg6mi1JmUXZL6BwmJWfHgCCk56AP7CYjH+gnvl
   BkhZv4deHjGsN/4Zils8WOSrQxO9VkgJpDTCEgy9yE9U0rVc/QOZpbrMw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5944034"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5944034"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 00:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12494623"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.209.226])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 00:13:45 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf script: Show also errors for --insn-trace option
Date: Fri, 15 Mar 2024 09:13:33 +0200
Message-Id: <20240315071334.3478-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

The trace could be misleading if trace errors are not taken into
account, so display them also by adding the itrace "e" option.

Note --call-trace and --call-ret-trace already add the itrace "e"
option.

Fixes: b585ebdb5912 ("perf script: Add --insn-trace for instruction decoding")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 37088cc0ff1b..2e7148d667bd 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3806,7 +3806,7 @@ static int parse_insn_trace(const struct option *opt __maybe_unused,
 	if (ret < 0)
 		return ret;
 
-	itrace_parse_synth_opts(opt, "i0ns", 0);
+	itrace_parse_synth_opts(opt, "i0nse", 0);
 	symbol_conf.nanosecs = true;
 	return 0;
 }
-- 
2.34.1


