Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B505F7BA9BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjJETGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjJETGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:06:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE64DDE;
        Thu,  5 Oct 2023 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696532795; x=1728068795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U76zY0O5kmHJh4OzAqNOSoPGSwZlGkT5ypjB3gSNylc=;
  b=l2p0CPXi33NIXnsbOBW8NrUe9MlJhYAT5TAL6uYZUDOvFyrTAx3iS5iE
   EVlNVBV8KtXc0jRKCBrFolm8o+wJyH36I0BllWgwNvrzmJQ7CNWZTNI/m
   X5eLJdwh+aozs+RRMste/j0URZLmtZTkEqiMNHCVkHzsxcbJjvqpCXZhG
   GNT/1xdqRBeXopiMTa+RZWNQHwiRXxQh6vPTiI5IidhqByaShpVZc2psi
   4YtCZO8jWI58LTVYN6sPVtynbHlkecnhrAPCzE4uxy5lNf/DIlOecI0MK
   N5xeclbU61KyPFol5kGL6ZnG04xCtWvClRAdR6YB+rQNGfTAZJsIqfZqD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383488254"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383488254"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999055177"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999055177"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.35.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:16 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 4/5] perf intel-pt: Use get_unaligned_le16() etc
Date:   Thu,  5 Oct 2023 22:04:50 +0300
Message-Id: <20231005190451.175568-5-adrian.hunter@intel.com>
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

Avoid unaligned access by using get_unaligned_le16(), get_unaligned_le32()
and get_unaligned_le64().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../intel-pt-decoder/intel-pt-pkt-decoder.c     | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index ffd0d647473c..7a90218aecb1 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -10,6 +10,7 @@
 #include <byteswap.h>
 #include <linux/kernel.h>
 #include <linux/compiler.h>
+#include <asm-generic/unaligned.h>
 
 #include "intel-pt-pkt-decoder.h"
 
@@ -78,7 +79,7 @@ static int intel_pt_get_long_tnt(const unsigned char *buf, size_t len,
 	if (len < 8)
 		return INTEL_PT_NEED_MORE_BYTES;
 
-	payload = le64_to_cpu(*(uint64_t *)buf);
+	payload = get_unaligned_le64(buf);
 
 	for (count = 47; count; count--) {
 		if (payload & BIT63)
@@ -119,7 +120,7 @@ static int intel_pt_get_cbr(const unsigned char *buf, size_t len,
 	if (len < 4)
 		return INTEL_PT_NEED_MORE_BYTES;
 	packet->type = INTEL_PT_CBR;
-	packet->payload = le16_to_cpu(*(uint16_t *)(buf + 2));
+	packet->payload = get_unaligned_le16(buf + 2);
 	return 4;
 }
 
@@ -218,12 +219,12 @@ static int intel_pt_get_ptwrite(const unsigned char *buf, size_t len,
 	case 0:
 		if (len < 6)
 			return INTEL_PT_NEED_MORE_BYTES;
-		packet->payload = le32_to_cpu(*(uint32_t *)(buf + 2));
+		packet->payload = get_unaligned_le32(buf + 2);
 		return 6;
 	case 1:
 		if (len < 10)
 			return INTEL_PT_NEED_MORE_BYTES;
-		packet->payload = le64_to_cpu(*(uint64_t *)(buf + 2));
+		packet->payload = get_unaligned_le64(buf + 2);
 		return 10;
 	default:
 		return INTEL_PT_BAD_PACKET;
@@ -248,7 +249,7 @@ static int intel_pt_get_mwait(const unsigned char *buf, size_t len,
 	if (len < 10)
 		return INTEL_PT_NEED_MORE_BYTES;
 	packet->type = INTEL_PT_MWAIT;
-	packet->payload = le64_to_cpu(*(uint64_t *)(buf + 2));
+	packet->payload = get_unaligned_le64(buf + 2);
 	return 10;
 }
 
@@ -455,13 +456,13 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type type, unsigned int byte,
 		if (len < 3)
 			return INTEL_PT_NEED_MORE_BYTES;
 		ip_len = 2;
-		packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
+		packet->payload = get_unaligned_le16(buf + 1);
 		break;
 	case 2:
 		if (len < 5)
 			return INTEL_PT_NEED_MORE_BYTES;
 		ip_len = 4;
-		packet->payload = le32_to_cpu(*(uint32_t *)(buf + 1));
+		packet->payload = get_unaligned_le32(buf + 1);
 		break;
 	case 3:
 	case 4:
@@ -474,7 +475,7 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type type, unsigned int byte,
 		if (len < 9)
 			return INTEL_PT_NEED_MORE_BYTES;
 		ip_len = 8;
-		packet->payload = le64_to_cpu(*(uint64_t *)(buf + 1));
+		packet->payload = get_unaligned_le64(buf + 1);
 		break;
 	default:
 		return INTEL_PT_BAD_PACKET;
-- 
2.34.1

