Return-Path: <linux-kernel+bounces-26921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF5C82E7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE621C22BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7B1468D;
	Tue, 16 Jan 2024 02:09:27 +0000 (UTC)
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98ADF4A;
	Tue, 16 Jan 2024 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W-kA6Fq_1705370948;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W-kA6Fq_1705370948)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 10:09:10 +0800
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
Subject: [PATCH v3 2/3] perf scripts python: arm-cs-trace-disasm.py: set start vm addr of exectable file to 0
Date: Tue, 16 Jan 2024 10:08:54 +0800
Message-Id: <20240116020854.56030-4-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240116020854.56030-1-tianruidong@linux.alibaba.com>
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
 <20240116020854.56030-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For exectable ELF file, which e_type is ET_EXEC, dso start address is a
absolute address other than offset. Just set vm_start to zero when dso
start is 0x400000, which means it is a exectable file.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 46bf6b02eea1..c9e14af5b58c 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -260,8 +260,9 @@ def process_event(param_dict):
 
 	if (options.objdump_name != None):
 		# It doesn't need to decrease virtual memory offset for disassembly
-		# for kernel dso, so in this case we set vm_start to zero.
-		if (dso == "[kernel.kallsyms]"):
+		# for kernel dso and executable file dso, so in this case we set
+		# vm_start to zero.
+		if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
 			dso_vm_start = 0
 		else:
 			dso_vm_start = int(dso_start)
-- 
2.33.1


