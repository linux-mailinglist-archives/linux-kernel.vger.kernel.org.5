Return-Path: <linux-kernel+bounces-7878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A712181AE9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E1AB23019
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D967CB642;
	Thu, 21 Dec 2023 06:04:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA46FB9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VywbA6j_1703138595;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VywbA6j_1703138595)
          by smtp.aliyun-inc.com;
          Thu, 21 Dec 2023 14:03:55 +0800
From: Jing Zhang <renyu.zj@linux.alibaba.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: kajoljain <kjain@linux.ibm.com>,
	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
	Ian Rogers <irogers@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] perf vendor events: Remove UTF-8 characters from cmn.json
Date: Thu, 21 Dec 2023 14:03:13 +0800
Message-Id: <1703138593-50486-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cmn.json contains UTF-8 characters in brief description which
could break the perf build on some distros.

Fix this issue by removing the UTF-8 characters from cmn.json.

without the fix:
$find tools/perf/pmu-events/ -name "*.json" | xargs file -i | grep -v us-ascii
tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json:                   application/json; charset=utf-8

with the fix:
$file -i tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json: text/plain; charset=us-ascii

Fixes: 0b4de7bdf46c5215 ("perf jevents: Add support for Arm CMN PMU aliasing")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.com>
Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
index 428605c..5ec157c 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
@@ -107,7 +107,7 @@
 		"EventName": "hnf_qos_hh_retry",
 		"EventidCode": "0xe",
 		"NodeType": "0x5",
-		"BriefDescription": "Counts number of times a HighHigh priority request is protocolretried at the HN‑F.",
+		"BriefDescription": "Counts number of times a HighHigh priority request is protocolretried at the HN-F.",
 		"Unit": "arm_cmn",
 		"Compat": "(434|436|43c|43a).*"
 	},
-- 
1.8.3.1


