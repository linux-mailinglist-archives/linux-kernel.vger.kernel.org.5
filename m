Return-Path: <linux-kernel+bounces-57675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1584DC16
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84591C25D9D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256466D1B6;
	Thu,  8 Feb 2024 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoaB5s/c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA36535DC;
	Thu,  8 Feb 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382422; cv=none; b=X5Yq3IRvUYGAF3t4l8QIsxn93gKGLUTEYXWu/qNgLbud0AreM5F88WKkK3YfqgBmbaEJSpJBX5Z8iqvXXUxPWB04Pt93nvTyDinobDOL9Oxc+4qpiCy3iBPT+v+APeRxUtlDUz/++natbKcGerIrv/uLMvQ65tFEl9CTjNhOQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382422; c=relaxed/simple;
	bh=UQNJ3qjwLz7Jv4K3EqKF8D67gnCfaH98/kcXiVcl2Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m/1LmOcCI1GB8MbSzIkmM56RL4HYigdOGvAk4vpfMGS/l65USqNVNpJDr9UdzCBjC78yrjqSvLQQtXEAwqdCr+HIdaqO8QV39WEphb7sehJ72JPqSr+OpYO2RVGMCwM4S3pp3j2YHZWeXH5x8YrhrlUY5FEy8QbOQxlc7RyWYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoaB5s/c; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707382420; x=1738918420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UQNJ3qjwLz7Jv4K3EqKF8D67gnCfaH98/kcXiVcl2Tg=;
  b=MoaB5s/clY7z6IwuIvDxOyZQXqTmw16ot7UqXjxwIFNrv2zP/cvkwojH
   omygfNmHfCiH3XEQQFIi1eJVK5STqKw+CQWOUF3fcKUuu4EYdZlQD/RYV
   t734rrDF4Ur4bXfKrmTJ4sVdzfl9uZrsEENxQhZS+Boi1/ea/uBLbSeLJ
   9yyi5Ufr0gVo3OAHc0TOr6gcgOzJ7XVrooSbNvi0e6w2WyRRUTnU09ktz
   Os92Qogrr1r+mdnuR78t7L/hMJxzWPCTN1A4mxhAaAWcAY8kqYYXxiSKs
   tbou+t/rEUypwHyq1xfq2S5S3+AQ6eAqQkt6L/XqQCcuCdg7hy3kgcsvB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1329186"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1329186"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1589475"
Received: from lnielsex-mobl.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.219.88])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:53:37 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Like Xu <like.xu.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V3 0/2] perf symbols: Slightly improve module file executable section mappings
Date: Thu,  8 Feb 2024 10:53:24 +0200
Message-Id: <20240208085326.13432-1-adrian.hunter@intel.com>
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


Changes in V3:

  Re-base

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

