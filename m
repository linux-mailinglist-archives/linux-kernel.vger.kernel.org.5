Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA6E7BA9BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjJETGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjJETGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:06:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E54BD9;
        Thu,  5 Oct 2023 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696532797; x=1728068797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Idg8ltgyFZaayjhZqPMjxwfK9UI2JApxxyIZyfMjKUk=;
  b=GYLfpluDeVMuZW+WyB0/L2uLMqRzIBuF1ZFpTVxE5tkVQOeL+7p0Np0c
   AevmLnwWksu0eQkMUfHZDwnfsPBCJs4bTCe9SPOqpo1jlPjHt0erl98dH
   msyDgRGdnVT3UwLXDhvcly8JjJ9ZR+vaADaIcvl5EdH4XC0Y6V+9KxAiP
   z4Zh9KHKQkjj7X8gMijCDzw8jAC8Rn5ubP50bnhRFuHbAsdek89CB68Fs
   CQHR9tpb6KtgH54+Q0PyevGUVFLiCRGxZ1eLYS/1olVRoVI1kaFNM26f2
   ZqvqxjEwA7M+lITBSgY96S3d53Ppl0fIpo9nUV0/2aJgAjW4ppHwgaAnx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383488268"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383488268"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999055209"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999055209"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.35.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:18 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 5/5] perf intel-pt: Prefer get_unaligned_le64 to memcpy_le64
Date:   Thu,  5 Oct 2023 22:04:51 +0300
Message-Id: <20231005190451.175568-6-adrian.hunter@intel.com>
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

Use get_unaligned_le64() instead of memcpy_le64(..., 8) because it produces
simpler code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 7a90218aecb1..bccb988a7a44 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -190,7 +190,7 @@ static int intel_pt_get_mnt(const unsigned char *buf, size_t len,
 	if (len < 11)
 		return INTEL_PT_NEED_MORE_BYTES;
 	packet->type = INTEL_PT_MNT;
-	memcpy_le64(&packet->payload, buf + 3, 8);
+	packet->payload = get_unaligned_le64(buf + 3);
 	return 11;
 }
 
@@ -302,7 +302,7 @@ static int intel_pt_get_bip_8(const unsigned char *buf, size_t len,
 		return INTEL_PT_NEED_MORE_BYTES;
 	packet->type = INTEL_PT_BIP;
 	packet->count = buf[0] >> 3;
-	memcpy_le64(&packet->payload, buf + 1, 8);
+	packet->payload = get_unaligned_le64(buf + 1);
 	return 9;
 }
 
@@ -341,7 +341,7 @@ static int intel_pt_get_evd(const unsigned char *buf, size_t len,
 	packet->type = INTEL_PT_EVD;
 	packet->count = buf[2] & 0x3f;
 	packet->payload = buf[3];
-	memcpy_le64(&packet->payload, buf + 3, 8);
+	packet->payload = get_unaligned_le64(buf + 3);
 	return 11;
 }
 
-- 
2.34.1

