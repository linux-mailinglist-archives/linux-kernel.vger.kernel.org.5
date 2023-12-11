Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0983B80C96B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbjLKMTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjLKMTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:19:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A96121;
        Mon, 11 Dec 2023 04:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297168; x=1733833168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vPpeVxwgKgA10NtRD0qnRLNR26RhoObWkXlHgTY7uYc=;
  b=MWGofS3JfsyAERaFVvnzMLRW36GS2qs8ENuC+PtNn6oFzjwNYwNR8fhb
   hPnpXJimUI+HvXRalsSVA4n9ZKCDJ4rswytL+zFmQs9J7LILbM3F4P/nf
   BQMnsUwvpUE1BSMbRlszMxaRYmu6GB06JaRekX6JHO5Eil2td2MMJOMXu
   FQF1dpZb+BcBtAzZ+c/AjVn3ISQAnyi8f72siCIjoUudE3jfJJzEVKZY/
   fLMlP74ZnSqGEC5TkCAH4/VAbvh8iMrPoNEYsmm7mvSk0AI7xwigPK1+E
   NjNgY74VoRekpkPzxUT0cIkHJ5XfUGzmUuHVUyP2ZwWyJWFKC6YXYbjWg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1757878"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1757878"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104461108"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104461108"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:19:22 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 05/29] selftests/resctrl: Split fill_buf to allow tests finer-grained control
Date:   Mon, 11 Dec 2023 14:18:02 +0200
Message-Id: <20231211121826.14392-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MBM, MBA and CMT test cases call run_fill_buf() that in turn calls
fill_cache() to alloc and loop indefinitely around the buffer. This
binds buffer allocation and running the benchmark into a single bundle
so that a selftest cannot allocate a buffer once and reuse it. CAT test
doesn't want to loop around the buffer continuously and after rewrite
it needs the ability to allocate the buffer separately.

Split buffer allocation out of fill_cache() into alloc_buffer(). This
change is part of preparation for the new CAT test that allocates a
buffer and does multiple passes over the same buffer (but not in an
infinite loop).

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v3:
- Moved error printout removal to other patch
---
 tools/testing/selftests/resctrl/fill_buf.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 0f6cca61ec94..6d1d5eed595c 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -135,24 +135,34 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
 	return 0;
 }
 
-static int fill_cache(size_t buf_size, int memflush, int op, bool once)
+static unsigned char *alloc_buffer(size_t buf_size, int memflush)
 {
 	unsigned char *buf;
-	int ret;
 
 	buf = malloc_and_init_memory(buf_size);
 	if (!buf)
-		return -1;
+		return NULL;
 
 	/* Flush the memory before using to avoid "cache hot pages" effect */
 	if (memflush)
 		mem_flush(buf, buf_size);
 
+	return buf;
+}
+
+static int fill_cache(size_t buf_size, int memflush, int op, bool once)
+{
+	unsigned char *buf;
+	int ret;
+
+	buf = alloc_buffer(buf_size, memflush);
+	if (!buf)
+		return -1;
+
 	if (op == 0)
 		ret = fill_cache_read(buf, buf_size, once);
 	else
 		ret = fill_cache_write(buf, buf_size, once);
-
 	free(buf);
 
 	if (ret) {
@@ -160,8 +170,7 @@ static int fill_cache(size_t buf_size, int memflush, int op, bool once)
 		return -1;
 	}
 
-
-	return 0;
+	return ret;
 }
 
 int run_fill_buf(size_t span, int memflush, int op, bool once)
-- 
2.30.2

