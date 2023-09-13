Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647FA79DE42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbjIMCVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238166AbjIMCVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:21:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1242E1716;
        Tue, 12 Sep 2023 19:21:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2810DC433C8;
        Wed, 13 Sep 2023 02:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694571660;
        bh=yCdyENSSr2jBoqcU5uuhQp9Eg5ZiZzpyIfgAEWQFG08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+l4nTmJpLTnnS7zeMq7sUR0wx9A3+mSu7hZCG0AI8qsphhiKn/LA+9HqEahsbJkW
         0VIYo5N/jkiNWdz5mJ70XL49dQ1xejMgCB+uYW73vVraKzDPiM3zegf5Y/bgvYN7IZ
         GFK1gmEqs8YH7k18ckYgFZfPa9qs/iuxvztNwWFzkudCTmJxoaqxbL2/lTf1DP9WWV
         H5iXINSUW0dB57rg3MTW4mQnxqtXQMBWidwbBIrWXua4awmxZq9qLDfCQrCqK3P3wK
         uKb+G+s+SL95eFpdJuOuJMiT5S4CRPUVwuI/bAZipHgcHpNPnNf8KjGOw7iRv3DTw1
         rjAKkU//Pz6RA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 2/2] Docs/admin-guide/mm/damon/usage: document damos_before_apply tracepoint
Date:   Wed, 13 Sep 2023 02:20:50 +0000
Message-Id: <20230913022050.2109-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913022050.2109-1-sj@kernel.org>
References: <20230913022050.2109-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document damos_before_apply tracepoint on the usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 37 ++++++++++++++++----
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 282062b6f134..6272cd36590a 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -496,15 +496,24 @@ the files as above.  Above is only for an example.
 
 .. _tracepoint:
 
-Tracepoint for Monitoring Results
-=================================
+Tracepoints for Monitoring Results
+==================================
 
 Users can get the monitoring results via the :ref:`tried_regions
-<sysfs_schemes_tried_regions>` or a tracepoint, ``damon:damon_aggregated``.
-While the tried regions directory is useful for getting a snapshot, the
-tracepoint is useful for getting a full record of the results.  While the
-monitoring is turned on, you could record the tracepoint events and show
-results using tracepoint supporting tools like ``perf``.  For example::
+<sysfs_schemes_tried_regions>`.  The interface is useful for getting a
+snapshot, but it could be inefficient for fully recording all the monitoring
+results.  For the purpose, two trace points, namely ``damon:damon_aggregated``
+and ``damon:damos_before_apply``, are provided.  ``damon:damon_aggregated``
+provides the whole monitoring results, while ``damon:damos_before_apply``
+provides the monitoring results for regions that each DAMON-based Operation
+Scheme (:ref:`DAMOS <damon_design_damos>`) is gonna be applied.  Hence,
+``damon:damos_before_apply`` is more useful for recording internal behavior of
+DAMOS, or DAMOS target access
+:ref:`pattern <damon_design_damos_access_pattern>` based query-like efficient
+monitoring results recording.
+
+While the monitoring is turned on, you could record the tracepoint events and
+show results using tracepoint supporting tools like ``perf``.  For example::
 
     # echo on > monitor_on
     # perf record -e damon:damon_aggregated &
@@ -527,6 +536,20 @@ counter).  Finally the tenth field (``X``) shows the ``age`` of the region
 (refer to :ref:`design <damon_design_age_tracking>` for more details of the
 counter).
 
+If the event was ``damon:damos_beofre_apply``, the ``perf script`` output would
+be somewhat like below::
+
+    kdamond.0 47293 [000] 80801.060214: damon:damos_before_apply: ctx_idx=0 scheme_idx=0 target_idx=0 nr_regions=11 121932607488-135128711168: 0 136
+    [...]
+
+Each line of the output represents each monitoring region that each DAMON-based
+Operation Scheme was about to be applied at the traced time.  The first five
+fields are as usual.  It shows the index of the DAMON context (``ctx_idx=X``)
+of the scheme in the list of the contexts of the context's kdamond, the index
+of the scheme (``scheme_idx=X``) in the list of the schemes of the context, in
+addition to the output of ``damon_aggregated`` tracepoint.
+
+
 .. _debugfs_interface:
 
 debugfs Interface (DEPRECATED!)
-- 
2.25.1

