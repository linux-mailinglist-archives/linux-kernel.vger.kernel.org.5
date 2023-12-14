Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBF81303A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573075AbjLNMdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573076AbjLNMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:33:20 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0DF116;
        Thu, 14 Dec 2023 04:33:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VyUUufW_1702557199;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VyUUufW_1702557199)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 20:33:21 +0800
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     james.clark@arm.com, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        al.grant@arm.com, mathieu.poirier@linaro.org, tor@ti.com,
        acme@redhat.com, Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 2/3] perf scripts python: arm-cs-trace-disasm.py: set start vm addr of exectable file to 0
Date:   Thu, 14 Dec 2023 20:33:03 +0800
Message-Id: <20231214123304.34087-3-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

