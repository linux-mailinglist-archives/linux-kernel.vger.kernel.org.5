Return-Path: <linux-kernel+bounces-160715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C658B4181
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB21F227F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D79381A4;
	Fri, 26 Apr 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiCRcSnM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8958374C6;
	Fri, 26 Apr 2024 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168301; cv=none; b=KEyq6wt6iokfmY+icUoyJheKlIzr4bRimKfW/OKk/eQETUX+RoAoy7eQKn+ES6rjWZdmnbLJnInkvK/qqct1CvPZjYK4hEf42CEw3HIRCEkK77uvX1i29AcRib2koD5ZuzzgDORP6T7AXCaVYmcnmmnjMXRinp0NsXg9hvmn2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168301; c=relaxed/simple;
	bh=ILtUrOVDvMYtd4HDjAPc/XxCz7q3QopNgkfhinc9zBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HW2u07vwNQSHRLk2YH5NrKOBH6khfaXy3Z579slg/LW/YcxESR/aVFijEm2Xtx357lVOTV9tBb7WFXtLxavHVHELvgJxJdqinv2reNk+kwLtmVwv/NmaCwjN1CmVqPSFVsImbW4qMA6VFeNKVyPW7EBbKtAi/6qPJjbC+8fifDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiCRcSnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D629C32781;
	Fri, 26 Apr 2024 21:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714168300;
	bh=ILtUrOVDvMYtd4HDjAPc/XxCz7q3QopNgkfhinc9zBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiCRcSnMUWcNrIUaPcY1Nr4AnVEEsTUuVRWxbzdbXFdfrfk8s13/kcRSCd9RF9qAJ
	 eO+NuQVEfnRch3atuuatG9F804CIF2s4hpou2jNsTCT0Cff5PI3AzlP58deJ0nFve5
	 +Gi/eNd5nh7gbUAQRXvY1luLe6yVb8PuRtJPKJo4J96bzAMTWOhmuSDsBd9zsRy0yF
	 GSEoqm1XpzTAykd0xXL/xWHIs1bePm+n+2lLNSrHKXorWvtdznWoYL5PO+i6WC6Zhf
	 ZxPrhEGEf2C3Fi5HS19bqitzL59xqntGeYsw51g9WvIWOmgvk9xGSMBFSmzYnf5dKh
	 nqB2rD5xJehQA==
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
Subject: [PATCH 2/2] perf symbol: Simplify kernel module checking
Date: Fri, 26 Apr 2024 14:51:39 -0700
Message-ID: <20240426215139.1271039-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426215139.1271039-1-namhyung@kernel.org>
References: <20240426215139.1271039-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dso__load(), it checks if the dso is a kernel module by looking the
symtab type.  Actually dso has 'is_kmod' field to check that easily and
dso__set_module_info() set the symtab type and the is_kmod bit.  So it
should have the same result to check the is_kmod bit.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 63936269ec15..50969c687135 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1811,10 +1811,7 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	kmod = dso__symtab_type(dso) == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
-		dso__symtab_type(dso) == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
-		dso__symtab_type(dso) == DSO_BINARY_TYPE__GUEST_KMODULE ||
-		dso__symtab_type(dso) == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
+	kmod = dso__is_kmod(dso);
 
 	if (dso__kernel(dso) && !kmod) {
 		if (dso__kernel(dso) == DSO_SPACE__KERNEL)
-- 
2.44.0.769.g3c40516874-goog


