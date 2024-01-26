Return-Path: <linux-kernel+bounces-39650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B5E83D450
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8B21C21C06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42173125BA;
	Fri, 26 Jan 2024 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="b2IfmG0s"
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F2017BB9;
	Fri, 26 Jan 2024 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249689; cv=none; b=fsHaJw3HuSxYAtQxqBZ7Hao9W/C//lpjxzYWJ/RivAHCs6vbPfGR574oqyz896cmHWRXPofsXXwer6cKh/BoGnW+bDGiXGTFqpLAvMpEjWu3paeH01N/fK1OCxRfHZX741LQH2XQ4QE/6BfYAlbpnsSEXoaHULaDxtgcTlIzYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249689; c=relaxed/simple;
	bh=i703ReulV9jMhj6m7JiFLkqfqvcoDS18l2oDtfw+d3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/YQZy90ET+eS47jGaEfOkpHHGK7BA6BCAoJnJeKqPzTWQjPSCwoaURsl4sfhmf6fajlPKT09/+bWJsOrKgA4xUNJ8ZVaYSi08QVjzei7wXoC8KZACzSYUempgFPwgPgDpd+ZOIllwxyPuqxjmEHhy+cdmhMAxjat/YpI2e6vTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=b2IfmG0s; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706249687; x=1737785687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i703ReulV9jMhj6m7JiFLkqfqvcoDS18l2oDtfw+d3k=;
  b=b2IfmG0sQ/O05fy92uvEpC3Cfm8O6oTzeQ/skmQaFjAeoq9VcTukPLq3
   dSgaLUQitkzkc7KBQSkIK7LeyCUwMNCwiB3j4bxTyJYaCZAAByWQYOMfU
   2q3lqORO3DTxpHK6fS1pDowXC4MwMj7rB3EdE/2vUzxa5101H4yZJbRfJ
   Dy6s5oJDG4l61llUhtytbVRL6yvC/ShKUMx94HQoOV9NmwChxys7YoNIp
   8mFxXuplsX2Z1B52UFEfFauJEY5Mahb72krArw9yrGVGsIV/Lp+FHVTLD
   c2bRdT27i/9dMfxB2BcOG08LZHHKp8Ubb/sVfllX2pRe2+g5f1/wfDIZs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="135350063"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; 
   d="scan'208";a="135350063"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:13:35 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E6EA7C160C;
	Fri, 26 Jan 2024 15:13:33 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1971E105EE3;
	Fri, 26 Jan 2024 15:13:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 987C6200A7699;
	Fri, 26 Jan 2024 15:13:32 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id CEBDC1A006A;
	Fri, 26 Jan 2024 14:13:31 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 3/4] arch/x86/events/core: use scnprintf to print sub-string
Date: Fri, 26 Jan 2024 14:13:18 +0800
Message-Id: <20240126061319.245901-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240126061319.245901-1-lizhijian@fujitsu.com>
References: <20240126061319.245901-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28142.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28142.005
X-TMASE-Result: 10--4.083000-10.000000
X-TMASE-MatchedRID: A6E5LYvdBmycoTMwci7COSFcmxL76KeOKQNhMboqZloPdZmyx8xAa9gj
	E0ANqbLcIvrftAIhWmLy9zcRSkKatUPu4/hW5W83GYJhRh6sset9LQinZ4QefCP/VFuTOXUTae6
	hIZpj4MuOhzOa6g8Krang5Z2V0DfQWfyqv8nMqvUSKCHp200/LSkNA6iFWUUs7V8SlsiWlvScDb
	GalTbQe89RNfYjXeOIuIwYsUJqUugXkHCbdY7WtxXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
	0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

sysfs_emit is not suitable to to print a substring, convert it to scnprintf
to make coccicheck happy.

CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>
CC: Adrian Hunter <adrian.hunter@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-perf-users@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: new patch address coccinelle warning
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 20d963196e4c..5ed2ba16c6c0 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1892,7 +1892,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
 		if (x86_pmu.hybrid_pmu[i].pmu_type & pmu->pmu_type) {
 			next_str = strchr(str, ';');
 			if (next_str)
-				return snprintf(page, next_str - str + 1, "%s", str);
+				return scnprintf(page, next_str - str + 1, "%s", str);
 			else
 				return sysfs_emit(page, "%s", str);
 		}
-- 
2.29.2


