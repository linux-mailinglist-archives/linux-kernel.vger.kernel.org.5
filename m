Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C579A2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjIKE7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjIKE7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:59:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D68A138;
        Sun, 10 Sep 2023 21:59:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29486C433CB;
        Mon, 11 Sep 2023 04:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694408353;
        bh=yCdyENSSr2jBoqcU5uuhQp9Eg5ZiZzpyIfgAEWQFG08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqHzNhQypANFa8iW43c8T+CdTyJNbZILeHGR5vSckO9OyBoFNScts3NkhNUB0hUdK
         Rx5bC7TPP6c1kPbTEQm4UdifFD22iGQnZOYHwLiu6/w9NW3rAlGLD3u3xc2w32aOoi
         Nwc02GNkWg4NlNb9IM0GaoGG0vBlM1yRLDmB0t9ggDMobW8Qees4i9hw4wfPsBX+rL
         9ReNouLD2afycjPERmYjFbmeVk/RljkfbhU+Oj9GNhovKG9UKWU0/PnHfb8K6FMVBK
         gyc0JMX3jmy2dgaPh5Fktf3uJRTXqchjoXp1EoKv+dZhBQwxh5fiW9XEZVHusV6w5j
         ZNfpLBdyi3K5g==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Docs/admin-guide/mm/damon/usage: document damos_before_apply tracepoint
Date:   Mon, 11 Sep 2023 04:59:08 +0000
Message-Id: <20230911045908.97649-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911045908.97649-1-sj@kernel.org>
References: <20230911045908.97649-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

