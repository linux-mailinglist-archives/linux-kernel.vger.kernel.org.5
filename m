Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF6C796EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbjIGC3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242124AbjIGC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:29:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA519B0;
        Wed,  6 Sep 2023 19:29:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E37C433C9;
        Thu,  7 Sep 2023 02:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694053781;
        bh=/4c0bNqammeumkz0XhdEYekAGWITk+eiJUgJ8I1y+iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1aBIvrVp1OYAQpfz00zRovXOneOesmUDSZyTevcK820XKsGAeBqVz+uKLkcn19ia
         t6iRL/0aRlSuwJh0x/3UVFXNGwBKDRIioHx4gYhpYlanDqU5oNeS/uQo/0Kf0FYlTn
         yHWjH8sqOnKWJtQ8ZXjS0fEpJY2oDw3OKXbcwx4Q8uXajUh3jhQ00R6lMX83jpsFLU
         7qB3XGpSq8hnVEiIUFzsOtdQuhLHqy8onWed+iUqj13gYcdnfp+m/ndsdEmepn6P66
         SD0M9Ouci60A3Zf8RhsozItBrOl647bJks1M3TsZTbi3TpBkLEJgMaWCHyNU2RtBuS
         owRht7VtaeJcQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] Docs/admin-guide/mm/damon/usage: explain the format of damon_aggregate tracepoint
Date:   Thu,  7 Sep 2023 02:29:23 +0000
Message-Id: <20230907022929.91361-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example of the section for damon_aggregated tracepoint is not
explaining how the output looks like, and how it can be interpreted.
Add it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 14 ++++++++++++++
 Documentation/mm/damon/design.rst            |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index e48101c777e1..758575d33ab6 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -513,6 +513,20 @@ results using tracepoint supporting tools like ``perf``.  For example::
     # kill 9 $(pidof perf)
     # echo off > monitor_on
     # perf script
+    kdamond.0 46568 [027] 79357.842179: damon:damon_aggregated: target_id=0 nr_regions=11 122509119488-135708762112: 0 864
+    [...]
+
+Each line of the perf script output represents each monitoring region.  The
+first five fields are as usual other tracepoint outputs.  The sixth field
+(``target_id=X``) shows the ide of the monitoring target of the region.  The
+seventh field (``nr_regions=X``) shows the total number of monitoring regions
+for the target.  The eighth field (``X-Y:``) shows the start (``X``) and end
+(``Y``) addresses of the region in bytes.  The ninth field (``X``) shows the
+``nr_accesses`` of the region (refer to
+:ref:`design <damon_design_region_based_sampling>` for more details of the
+counter).  Finally the tenth field (``X``) shows the ``age`` of the region
+(refer to :ref:`design <damon_design_age_tracking>` for more details of the
+counter).
 
 .. _debugfs_interface:
 
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5c465835a44f..51aab9b0621a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -154,6 +154,8 @@ The monitoring overhead of this mechanism will arbitrarily increase as the
 size of the target workload grows.
 
 
+.. _damon_design_region_based_sampling:
+
 Region Based Sampling
 ~~~~~~~~~~~~~~~~~~~~~
 
@@ -191,6 +193,8 @@ In this way, DAMON provides its best-effort quality and minimal overhead while
 keeping the bounds users set for their trade-off.
 
 
+.. _damon_design_age_tracking:
+
 Age Tracking
 ~~~~~~~~~~~~
 
-- 
2.25.1

