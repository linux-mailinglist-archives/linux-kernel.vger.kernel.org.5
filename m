Return-Path: <linux-kernel+bounces-133584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E889A5FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29E51C213F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58794175548;
	Fri,  5 Apr 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdQHHlSf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F741C687;
	Fri,  5 Apr 2024 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351882; cv=none; b=MgX2ETF1VZJJFVeZZYeCd156k2ICmz2uPrLwguOtBgaN6j8/uZZEJ9Fga/dCmgdMU8pIJ+olXZCTKwEmZQ1ip7tSDtKP/9XRGwHSMgcK6G3XBIEWiSC1VQUuXLtzfSr2226HwSqVldrkiRi1mieIc086dkUr+JYWsuftjqdy0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351882; c=relaxed/simple;
	bh=tCCd1z5eJPCWR12UPaSgmUTe7fVkb7E0/uRdD8rdRpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IwNktzGgguHDWfKBE57QFB6PFPbQKc3csJwbCDvbozXbst4YS8+Fa4NHOGlaYLMjZbJhKLIMSfCdZWE2kS61j6xprV8sFdYBGX+DXMaB4qyQ/1GIgFosPKVIcpry+eSVYqJ4jWj+VieWgYGvt4tX1usl9M6gETU0L5qT9F+sZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdQHHlSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B905C433F1;
	Fri,  5 Apr 2024 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712351882;
	bh=tCCd1z5eJPCWR12UPaSgmUTe7fVkb7E0/uRdD8rdRpM=;
	h=From:To:Cc:Subject:Date:From;
	b=OdQHHlSfCKuwflpqeoV71BtCnypygaVCiVJses1Knma6hcQyq8CDPNwlG2Yx7Nsza
	 utlwXF+GJzCdORQ8HAv0RkxnglNvRNhZ9yIE50dOrSmHN3L2/D/EB5jIsiARJr/y8h
	 I7SNbDftSp+bxF5RqW5sELEFBHNW42LNBeTDHIenqc/JSoAuQR+SL133VQyHwyw+pp
	 oxGTBimY0ncSMjRbf8m3IPewABGYOKsGsxI28oiTBc9Nt8H8keTgcOdqQFusg18lYc
	 5hMMXb31rllheRRUOrY+JqWjr7Z9hWYrrEpO0Pp91wQuItamE6X26T6Jm2Nj2emNMY
	 Ri0FNN0SwfQQQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] perf annotate-data: small random fixes and updates
Date: Fri,  5 Apr 2024 14:17:56 -0700
Message-ID: <20240405211800.1412920-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I found some problems in the data type profiling with perf annotate.
The patch 1 should go to perf-tools and others can go to perf-tools-next.

Thanks,
Namhyung


Namhyung Kim (4):
  perf annotate: Make sure to call symbol__annotate2() in TUI
  perf annotate-data: Fix global variable lookup
  perf annotate-data: Do not delete non-asm lines
  perf annotate: Get rid of symbol__ensure_annotate()

 tools/perf/ui/browsers/annotate.c |   2 +-
 tools/perf/util/annotate-data.c   |  10 ++-
 tools/perf/util/annotate.c        | 104 ++++++++++++++++++++----------
 3 files changed, 80 insertions(+), 36 deletions(-)


base-commit: b6347cb5e04e9c1d17342ab46e2ace2d448de727
-- 
2.44.0.478.gd926399ef9-goog


