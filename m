Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6997EFCE9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 02:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbjKRBOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 20:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjKRBOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 20:14:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E299D7E;
        Fri, 17 Nov 2023 17:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700270072; x=1731806072;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oIqFPPpoTHQs4xq99OVhu029UoVsLXPhd+E7X5IVh3o=;
  b=aE3YjKoTg1kAnAN+Wu0A3MwZGNEC3vsOz9plqPuewJBqQoRVUWo3nstO
   Ghea1QWWvKXPWn0opJ/8Lq9t6Xto6VeHDHoXDaxG56tbehrgNzQZ2ca1V
   l9836SeljUrAy45FWMAA0eU7pjkhIFwitktv4Bhuy58E30IzIdxAuwA8P
   EVV6qTEGMKqrJJlvvkkYyoEND2rDc2Rlj7HiB6QHFbbw6237HpfXJ4jhp
   oz5Vu6LVQxvfOJNqgJ4+UZ2hwYT/YpXYBGzCRFufx85fW/1ZmjLKTTgxw
   XWkdk9PD5EvNm1npgI4lVdq2po7MNEUYwO08kmb3aSXSIvR/Ggh4iZWTn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390256193"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390256193"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 17:14:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="889406625"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="889406625"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.174.178])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 17:14:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 17 Nov 2023 17:14:21 -0800
Subject: [PATCH 1/2] cxl/cdat: Handle cdat table build errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-fix-cdat-cs-v1-1-ffc2b116ca6c@intel.com>
References: <20231117-fix-cdat-cs-v1-0-ffc2b116ca6c@intel.com>
In-Reply-To: <20231117-fix-cdat-cs-v1-0-ffc2b116ca6c@intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Fan Ni <nifan.cxl@gmail.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700270069; l=1101;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=oIqFPPpoTHQs4xq99OVhu029UoVsLXPhd+E7X5IVh3o=;
 b=xj+akvU9k2Rgms457NSCfkr8e0jOgcHBlBnyCxkkz1QCa6T/ronilXiJqoB2Bg2WF5XOsQqSI
 7HC/IfMg0gZDxMje9fOiQnli/bq1qo65/b33yTZghL7FZz8GpAxeWV5
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback for building CDAT tables may return negative error codes.
This was previously unhandled and will result in potentially huge
allocations later on in ct3_build_cdat()

Detect the negative error code and defer cdat building.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
This likely needs to have some more robust error handling in the event
of errors.  But this at least prevents more errors down the line with
invalid allocations.
---
 hw/cxl/cxl-cdat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 639a2db3e17b..24829cf2428d 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -63,7 +63,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
                                                  cdat->private);
 
-    if (!cdat->built_buf_len) {
+    if (cdat->built_buf_len <= 0) {
         /* Build later as not all data available yet */
         cdat->to_update = true;
         return;

-- 
2.41.0

