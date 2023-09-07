Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0187796EE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbjIGC3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240065AbjIGC3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:29:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BA219A6;
        Wed,  6 Sep 2023 19:29:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756FAC433CA;
        Thu,  7 Sep 2023 02:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694053779;
        bh=ddAwo+PJ4HbDbLRCVex0LmwHXE3nv9K1631hg64QSQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P13xdxS4wlGAVIBUe5kpWPR/UNmFyYTU4FLLLMcCHrKh3uUJ1xUCoyNRngufVl8B/
         VvJ+If3uwJfzB71IHKAUD238aAFRPRvh8Uc+23igy+x6rguGNyGfpt4cIiqz/Rwyvo
         cdqrwQY0g6DFBeJuVmSoMlAdEBwMPPBXGOpAGZSZW9CAoGUbfGNuZuucH6JmAOaim5
         xFvqb7c55zEtR86oxNiJVzFYZMGAV/FfX8LJYvMggb+uNfja4GUtBfiHvpAUH9XBdL
         2bsLXJNCa0vHIZ7Ef6iRQ0I/ijEwT0vn62cEXBrYQpc4PQITTO9myhuqgpaT2/1QB8
         suwu4x18IKU/A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] Docs/admin-guide/mm/damon/usage: place debugfs usage at the bottom
Date:   Thu,  7 Sep 2023 02:29:20 +0000
Message-Id: <20230907022929.91361-3-sj@kernel.org>
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

debugfs interface is deprecated.  Put it at the bottom of the document
so that readers have less chances to read it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 39 ++++++++++----------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 834eefe39650..bffe9dd9b0d6 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -495,6 +495,25 @@ Please note that it's highly recommended to use user space tools like `damo
 <https://github.com/awslabs/damo>`_ rather than manually reading and writing
 the files as above.  Above is only for an example.
 
+.. _tracepoint:
+
+Tracepoint for Monitoring Results
+=================================
+
+Users can get the monitoring results via the :ref:`tried_regions
+<sysfs_schemes_tried_regions>` or a tracepoint, ``damon:damon_aggregated``.
+While the tried regions directory is useful for getting a snapshot, the
+tracepoint is useful for getting a full record of the results.  While the
+monitoring is turned on, you could record the tracepoint events and show
+results using tracepoint supporting tools like ``perf``.  For example::
+
+    # echo on > monitor_on
+    # perf record -e damon:damon_aggregated &
+    # sleep 5
+    # kill 9 $(pidof perf)
+    # echo off > monitor_on
+    # perf script
+
 .. _debugfs_interface:
 
 debugfs Interface (DEPRECATED!)
@@ -790,23 +809,3 @@ directory by putting the name of the context to the ``rm_contexts`` file. ::
 
 Note that ``mk_contexts``, ``rm_contexts``, and ``monitor_on`` files are in the
 root directory only.
-
-
-.. _tracepoint:
-
-Tracepoint for Monitoring Results
-=================================
-
-Users can get the monitoring results via the :ref:`tried_regions
-<sysfs_schemes_tried_regions>` or a tracepoint, ``damon:damon_aggregated``.
-While the tried regions directory is useful for getting a snapshot, the
-tracepoint is useful for getting a full record of the results.  While the
-monitoring is turned on, you could record the tracepoint events and show
-results using tracepoint supporting tools like ``perf``.  For example::
-
-    # echo on > monitor_on
-    # perf record -e damon:damon_aggregated &
-    # sleep 5
-    # kill 9 $(pidof perf)
-    # echo off > monitor_on
-    # perf script
-- 
2.25.1

