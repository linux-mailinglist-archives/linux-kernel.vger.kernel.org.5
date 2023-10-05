Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661657BA9BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjJETGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJETGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:06:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B644FEA;
        Thu,  5 Oct 2023 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696532794; x=1728068794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dx4bgn3zzTZ9xOLzFW1eBj7lM2vIsla8X5xiYClbPKg=;
  b=GcXzKhMsdO3FDl35O3GpDpY1GlBXi2Bl2Rl1Mh9wUIB9hAsgBxOJbRHi
   0nRfqICQ/fOKoxdu4iwEQFfe6dQ0CY9pM9xSZSqANgUsamLIuFhrT2mbv
   LsPvTb3PngKBOMLxKhuSDPbIGVQC+gQBIIVlOBBRa7JOf3i6DV1jdKpf0
   VmUfeBbtb+sagL+uwE66C/FfmUI+jVNIzfGEmWP1s1Cjz+5OIqETm8XDg
   5WXGt1uYDYxc8kK3sS9CvwEuF/1+kxUbCIY9pBgFcnXZwUTj20RRZDGYG
   pqqnwl/IZmA6JpjQyPF3LwWQ70tnbBL9t6paqFGP3RkQqIBntMzUqlT86
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383488228"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383488228"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999055088"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999055088"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.35.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:05:10 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/5] perf tools: Add get_unaligned_leNN()
Date:   Thu,  5 Oct 2023 22:04:47 +0300
Message-Id: <20231005190451.175568-2-adrian.hunter@intel.com>
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

Add get_unaligned_le16(), get_unaligned_le32 and get_unaligned_le64, same
as include/asm-generic/unaligned.h.

Use diagnostic pragmas to ignore -Wpacked used by perf build.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/include/asm-generic/unaligned.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
index 47387c607035..9140bb4e16c6 100644
--- a/tools/include/asm-generic/unaligned.h
+++ b/tools/include/asm-generic/unaligned.h
@@ -6,6 +6,9 @@
 #ifndef __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
 #define __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpacked"
+
 #define __get_unaligned_t(type, ptr) ({						\
 	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
 	__pptr->x;								\
@@ -19,5 +22,22 @@
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
 #define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
 
+static inline u16 get_unaligned_le16(const void *p)
+{
+	return le16_to_cpu(__get_unaligned_t(__le16, p));
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return le32_to_cpu(__get_unaligned_t(__le32, p));
+}
+
+static inline u64 get_unaligned_le64(const void *p)
+{
+	return le64_to_cpu(__get_unaligned_t(__le64, p));
+}
+
+#pragma GCC diagnostic pop
+
 #endif /* __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H */
 
-- 
2.34.1

