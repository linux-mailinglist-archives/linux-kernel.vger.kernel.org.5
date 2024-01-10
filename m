Return-Path: <linux-kernel+bounces-21664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109C382928F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324592880F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964363D9;
	Wed, 10 Jan 2024 02:56:36 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890624A3C;
	Wed, 10 Jan 2024 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W-KKTUe_1704855384;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W-KKTUe_1704855384)
          by smtp.aliyun-inc.com;
          Wed, 10 Jan 2024 10:56:26 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: james.clark@arm.com,
	coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	leo.yan@linaro.org,
	al.grant@arm.com,
	mathieu.poirier@linaro.org,
	tor@ti.com,
	acme@redhat.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v2 1/1] perf scripts python: arm-cs-trace-disasm.py: add option to print virtual address
Date: Wed, 10 Jan 2024 10:56:17 +0800
Message-Id: <20240110025617.66646-2-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240110025617.66646-1-tianruidong@linux.alibaba.com>
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
 <20240110025617.66646-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm-cs-trace-disasm just print offset for library dso now:

    0000000000002200 <memcpy>:
        2200: d503201f      nop
        2204: 8b020024      add     x4, x1, x2
        2208: 8b020005      add     x5, x0, x2

Add a option `-a` to print virtual offset other than offset:

    # perf script -s scripts/python/arm-cs-trace-disasm.py -- -d llvm-objdump -a
    ...
    ffffb4c23200 <memcpy>:
        ffffb4c23200: d503201f      nop
        ffffb4c23204: 8b020024      add     x4, x1, x2
        ffffb4c23208: 8b020005      add     x5, x0, x2
    ...

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d973c2baed1c..78419498237e 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -36,7 +36,10 @@ option_list = [
 		    help="Set path to objdump executable file"),
 	make_option("-v", "--verbose", dest="verbose",
 		    action="store_true", default=False,
-		    help="Enable debugging log")
+		    help="Enable debugging log"),
+	make_option("-a", "--vaddr", dest="vaddr",
+			action="store_true", default=False,
+			help="Enable virtual address")
 ]
 
 parser = OptionParser(option_list=option_list)
@@ -108,6 +111,14 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
 			m = disasm_re.search(line)
 			if m is None:
 				continue
+
+		# Replace offset with virtual address
+		if (options.vaddr == True):
+			offset = re.search(r"^\s*([0-9a-fA-F]+)", line).group()
+			if offset:
+				virt_addr = dso_start + int(offset, 16)
+				line = line.replace(offset.lstrip(), "%x" % virt_addr)
+
 		print("\t" + line)
 
 def print_sample(sample):
-- 
2.33.1


