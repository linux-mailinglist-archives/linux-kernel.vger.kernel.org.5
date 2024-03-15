Return-Path: <linux-kernel+bounces-104103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D787C8FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62664B21C25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467B515E97;
	Fri, 15 Mar 2024 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwCi5mVS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF891426E;
	Fri, 15 Mar 2024 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710486832; cv=none; b=HWx9cSbMDdMMKNnNsGbaeVuYya6IO04DGzpMvToauOsYIS9oWnHz619NeA+2jirmljOWIq6EYXif/tTkM9/aZKy6hqI5m6RB2zXbZdAiFxkvdBZK2uAXJpUyVwW10eQFvfg/lH5NOlB1p4OsDqElGak8AUc+0CaUhFM82TUGteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710486832; c=relaxed/simple;
	bh=GNfAooz/wTLMQAqprwx4AAcUd3RDnPeWtqu1ErkFcGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXMPQTM608q04DRmiODeo9TFEjPgYXCurFDBOtWyR3ohwWrS7E6FVQoyCz27Tn9jGNmCXqq/lUr5aA748KpLqsOFODA0IJgNkR2HL20q4vra3wpKfu8sS9C88dG3cl1s+Fbr0VzRmJDVt7eMQyrF9Rt7739tGYN4FO17Fd2xVNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwCi5mVS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710486831; x=1742022831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNfAooz/wTLMQAqprwx4AAcUd3RDnPeWtqu1ErkFcGo=;
  b=GwCi5mVS7D6qenj5vFAN5Jmmu/JHeeHeHY8eeEHAYXJ6f5cxpXV+2byr
   T89srqhLwZMV2aF1xlgLv7foFLVHBkp3ZsVwqwZ1PhUuhiHSPPNETXQsA
   SIK69FG2KEF1lHbrBi4jzEjU/SMtljvwOSkwe9LEjVSPrBb7HsvZCcF5z
   9CpEwsE4+nvTxMq1uCk5dxcDpRtr2sLd/QB8lKtUA1mD+yBM170Ul4qnZ
   PVYpROwzprLfzQ4IpwVXsOiI5MlewAiMk+M+gnebE+rcLmIrFl15inJku
   A328gwGsAAWDYghNQOBBhvD3WhV8zoULw7i9iXdG3GgDXVCpwYPdeyIE4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5944043"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5944043"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 00:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12494637"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.209.226])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 00:13:48 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf auxtrace: Fix multiple use of --itrace option
Date: Fri, 15 Mar 2024 09:13:34 +0200
Message-Id: <20240315071334.3478-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315071334.3478-1-adrian.hunter@intel.com>
References: <20240315071334.3478-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

If the --itrace option is used more than once, the options are
combined, but "i" and "y" (sub-)options can be corrupted because
itrace_do_parse_synth_opts() incorrectly overwrites the period type and
period with default values.

For example, with:

	--itrace=i0ns --itrace=e

The processing of "--itrace=e", resets the "i" period from 0 nanoseconds
to the default 100 microseconds.

Fix by performing the default setting of period type and period only if
"i" or "y" are present in the currently processed --itrace value.

Fixes: f6986c95af84 ("perf session: Add instruction tracing options")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 3684e6009b63..ef314a5797e3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1466,6 +1466,7 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 	char *endptr;
 	bool period_type_set = false;
 	bool period_set = false;
+	bool iy = false;
 
 	synth_opts->set = true;
 
@@ -1484,6 +1485,7 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 		switch (*p++) {
 		case 'i':
 		case 'y':
+			iy = true;
 			if (p[-1] == 'y')
 				synth_opts->cycles = true;
 			else
@@ -1649,7 +1651,7 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 		}
 	}
 out:
-	if (synth_opts->instructions || synth_opts->cycles) {
+	if (iy) {
 		if (!period_type_set)
 			synth_opts->period_type =
 					PERF_ITRACE_DEFAULT_PERIOD_TYPE;
-- 
2.34.1


