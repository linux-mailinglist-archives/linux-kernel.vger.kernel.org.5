Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049A47BA9BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjJETGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjJETGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:06:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F4ADB;
        Thu,  5 Oct 2023 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696532795; x=1728068795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qtF8zRHNP255BfSQ+DVT/RKn8FRUesePocVsXbPofQc=;
  b=QoDHwYG6p4azHfsI7MeXDqAdWFsA3Udnh6EirWfssBMDUrb8gibTBdoq
   1dEIgG09RlWEhPDSH7L/Hf21lNulqJ1h0wGQ1TlgjOL6xV1lhtmBg81li
   VRpRQ96KlHavBd0GpFbz+iwQrQOH9nT1GMiQB/HX4l8gxvapibMWqTL4R
   QgME3JYQ06IWBtpIRAcZZ1v6ADTaPjovX3jIUn47SdximacJzsPdbdbPw
   8DBPtj81V6Y7I/3WQCtKhSI18bkyQ1Ux9YC53uja/s0JLNV/LPnpDgf7I
   GnjKuK65IJ6XKafTqDjzpGvhm81qhI20vwgbDjO5JbYS0fPFpwSNNgCtO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383488244"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383488244"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999055151"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999055151"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.35.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/5] perf intel-pt: Use existing definitions of le16_to_cpu() etc
Date:   Thu,  5 Oct 2023 22:04:49 +0300
Message-Id: <20231005190451.175568-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005190451.175568-1-adrian.hunter@intel.com>
References: <20231005190451.175568-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use definitions from tools/include/linux/kernel.h

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 249610cc9284..ffd0d647473c 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <linux/kernel.h>
 #include <linux/compiler.h>
 
 #include "intel-pt-pkt-decoder.h"
@@ -17,17 +18,11 @@
 #define BIT63		((uint64_t)1 << 63)
 
 #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-#define le16_to_cpu bswap_16
-#define le32_to_cpu bswap_32
-#define le64_to_cpu bswap_64
 #define memcpy_le64(d, s, n) do { \
 	memcpy((d), (s), (n));    \
 	*(d) = le64_to_cpu(*(d)); \
 } while (0)
 #else
-#define le16_to_cpu
-#define le32_to_cpu
-#define le64_to_cpu
 #define memcpy_le64 memcpy
 #endif
 
-- 
2.34.1

