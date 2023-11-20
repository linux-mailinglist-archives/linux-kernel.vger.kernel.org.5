Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615137F1173
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjKTLOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjKTLOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:14:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F88C5;
        Mon, 20 Nov 2023 03:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478850; x=1732014850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3w5YPzsrJAtu6IwpvvctKCS09dxA4ulRia909xdQq0U=;
  b=la5ILu7z2kI+O0YnwUFjV367xdIWwGBKkFAvBJK1vtUm2gfsJchhlv0Q
   TOV+14I5QGLQQ4B0xvMRZPC657r1o0q+4RVMVvb3TbidSL9a/N3ogj9WG
   n7UwVAjH0r5EcCrafjRFFT3oH1czVC/9CHizhwhb8hzSl2bJQ4Plk922+
   8sAtY7/9o+0KAqjz9yJgAsnRNvafcRw9AI90FrNNWFRVfxMKtR7rzM3zU
   yYShPPY/qxEhiC02/I3k9hxURFmYeNchad3dypR7UC05ub4sMpkJ+ROqo
   21SInO7uk6UlWpqFntQWptOQbsJazDAruNIj+R+jGG4eDmVj3HPHBvhgt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="458095860"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="458095860"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="716179264"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="716179264"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:07 -0800
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
Subject: [PATCH v2 02/26] selftests/resctrl: Split fill_buf to allow tests finer-grained control
Date:   Mon, 20 Nov 2023 13:13:16 +0200
Message-Id: <20231120111340.7805-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 tools/testing/selftests/resctrl/fill_buf.c | 26 +++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 0d425f26583a..6f32f44128e1 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -135,33 +135,37 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
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
 
-	if (ret) {
-		printf("\n Error in fill cache read/write...\n");
-		return -1;
-	}
-
-
-	return 0;
+	return ret;
 }
 
 int run_fill_buf(size_t span, int memflush, int op, bool once)
-- 
2.30.2

