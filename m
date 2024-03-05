Return-Path: <linux-kernel+bounces-92352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A427D871EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C89F284E4F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A15A7A4;
	Tue,  5 Mar 2024 12:20:29 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48559B5E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641229; cv=none; b=XFDBCSyh2tE7UsKw98SoV7nW1dxLQSpf11WQfaA6GL7MlJ5tYWuqI6XVaBEqoPP1i7/TXwGMJrasxMzrBjG3giqCUNw0bcrGNvRskgQsxi4Gme/gqcbYM9F0KU126RAfs0UoODuZNQ+HyoODbaeH0ygvuzBh76pDbW4znB2+O+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641229; c=relaxed/simple;
	bh=Z4ag4dmgkwg6QKinQ/3ZUdEqVOO6seGs6xNzDBwT5gs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaVyAyHREtHdREt8zM7qMVYQn1t+hrVkSbNS0inAW0O4WvT45hAemLU5IPJXSwMf/N0f+gL+KUDGB1g7wPUAAXYQaQpIbf3cGxAqwAhNVIjZbnbj1ghzUFmvKVsA4BrdpUzNKMUXK7bQO6nhdIKwv+zHrpq8/jtzwGg2uPgyzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 425C5uoP023912
	for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2024 20:05:56 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 425C5kAv023873;
	Tue, 5 Mar 2024 20:05:46 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Mar 2024
 20:05:43 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC: <dylan@andestech.com>, <tim609@andestech.com>,
        Ben Zong-You Xie
	<ben717@andestech.com>
Subject: [PATCH 2/2] perf riscv: Fix the warning due to the incompatible type
Date: Tue, 5 Mar 2024 20:05:01 +0800
Message-ID: <20240305120501.1785084-3-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305120501.1785084-1-ben717@andestech.com>
References: <20240305120501.1785084-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 425C5uoP023912

In the 32-bit platform, the second argument of getline is expectd to be
'size_t *'(aka 'unsigned int *'), but line_sz is of type 
'unsigned long *'. Therefore, declare line_sz as size_t.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 tools/perf/arch/riscv/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/riscv/util/header.c b/tools/perf/arch/riscv/util/header.c
index 4a41856938a8..1b29030021ee 100644
--- a/tools/perf/arch/riscv/util/header.c
+++ b/tools/perf/arch/riscv/util/header.c
@@ -41,7 +41,7 @@ static char *_get_cpuid(void)
 	char *mimpid = NULL;
 	char *cpuid = NULL;
 	int read;
-	unsigned long line_sz;
+	size_t line_sz;
 	FILE *cpuinfo;
 
 	cpuinfo = fopen(CPUINFO, "r");
-- 
2.34.1


