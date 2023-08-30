Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BFF78DDF7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343973AbjH3S4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242582AbjH3JF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:05:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7409ECCF;
        Wed, 30 Aug 2023 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693386353; x=1724922353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B3xJHByR9FLreUMgknnXx21neDGe39Jnr+0yJmg88DY=;
  b=Wnsq8t0eWFDSQ/6Esj30a0w7XuAj44dMDJsG+7cJNs4VOwNJ4DAKLqNF
   pbNeSuwc1ml5oBxHdzXjRj/crzu2vG1db6yVHgqrWT9Jzhaw24DuMPZHz
   UBjE7V6Kb0v25aLTusAm3r0u6QYdZQkIR7x6o+ZQWLY+597JLi67bPKVs
   Kbm/vUCZ1uQZDjjXQFUvKDZrOhsEMWKfgNbx0hap1Cohe2Hek+g1P7YzP
   qJFtzECyDLAnmBhlh/0AcvTxhZ0RmK723kuQLf7pu8xvMzokpt/ADJ2DB
   fh+urvEb8KKa1ii2uAniPDvTjsRj+u6owkoeLi75Yw9EgbwoYRYscQeIK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="375545132"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="375545132"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 02:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="739032896"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="739032896"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.47.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 02:05:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf dlfilter: Avoid leak in v0 API test use of resolve_address()
Date:   Wed, 30 Aug 2023 12:05:39 +0300
Message-Id: <20230830090539.68206-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of reference counting causes the v0 API
perf_dlfilter_fns.resolve_address() to leak. v2 API introduced
perf_dlfilter_fns.al_cleanup() to prevent that. For the v0 API, avoid the
leak by exiting the addr_location immediately, since the documentation
makes it clear that pointers obtained via perf_dlfilter_fns are not
necessarily valid (dereferenceable) after 'filter_event' and
'filter_event_early' return.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202308232146.94d82cb4-oliver.sang@intel.com
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/dlfilter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index e0f822ebb9b9..1dbf27822ee2 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -187,6 +187,8 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
 
 	if (has_priv(d_al_p))
 		d_al_p->priv = memdup(&al, sizeof(al));
+	else /* Avoid leak for v0 API */
+		addr_location__exit(&al);
 
 	return 0;
 }
-- 
2.34.1

