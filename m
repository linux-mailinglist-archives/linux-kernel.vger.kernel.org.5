Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891EB7E925E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjKLTqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjKLTqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:46:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE442139
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:46:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91CFC433CD;
        Sun, 12 Nov 2023 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699818378;
        bh=fBe7fu6fdhvjb2Vl3O+hHCTrOe9yrQAdsDE2H6K6JUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6SJsMg5KavzlrZgEup4w6srQLVMAzL1OT3+mkIGn838VdebxO4YPThMRTBxbHVjW
         arJxb9kZ9SKHg0X2BJUxftHNHaTNPpPTXR8N974jOsMd+MJc2mvO6cCvMf5pMKR2NX
         lHbrm8j2ERD7CrCkcHxTVFX+jc0PdTLZ8B+CmqEXc2xjnLcOghjG8oRZpNLFiTBHFr
         LZm9mfo7sUjlJu8DyHzMB55sUkkjMsO/+XXGDDSeH5GvHbyL2WuuXhy5UwbvB+LrGD
         eBq+cYwgAFEVvUJR5V+BJ+pMei61W+C9LpZYo+csOCuMf/OiQ/LPjZppZRFO6smDq2
         23aDyqdfNzXhA==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/8] Docs/admin-guide/mm/damon/usage: update for quota goals
Date:   Sun, 12 Nov 2023 19:46:07 +0000
Message-Id: <20231112194607.61399-9-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112194607.61399-1-sj@kernel.org>
References: <20231112194607.61399-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DAMON sysfs usage for newly added DAMOS quota goals interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 25 +++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index da94feb97ed1..3a2d308ca1e1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -83,6 +83,8 @@ comma (","). ::
     │ │ │ │ │ │ │ │ age/min,max
     │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
+    │ │ │ │ │ │ │ │ goals/nr_goals
+    │ │ │ │ │ │ │ │ │ 0/target_value,current_value
     │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ filters/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
@@ -123,9 +125,12 @@ Reading ``state`` returns ``on`` if the kdamond is currently running, or
 ``off`` if it is not running.  Writing ``on`` or ``off`` makes the kdamond be
 in the state.  Writing ``commit`` to the ``state`` file makes kdamond reads the
 user inputs in the sysfs files except ``state`` file again.  Writing
-``update_schemes_stats`` to ``state`` file updates the contents of stats files
-for each DAMON-based operation scheme of the kdamond.  For details of the
-stats, please refer to :ref:`stats section <sysfs_schemes_stats>`.
+``commit_schemes_quota_goals`` to the ``state`` file makes kdamond reads the
+DAMON-based operation schemes' :ref:`quota goals <sysfs_schemes_quota_goals>`
+of the kdamond.  Writing ``update_schemes_stats`` to ``state`` file updates the
+contents of stats files for each DAMON-based operation scheme of the kdamond.
+For details of the stats, please refer to :ref:`stats section
+<sysfs_schemes_stats>`.
 
 Writing ``update_schemes_tried_regions`` to ``state`` file updates the
 DAMON-based operation scheme action tried regions directory for each
@@ -319,8 +324,7 @@ The directory for the :ref:`quotas <damon_design_damos_quotas>` of the given
 DAMON-based operation scheme.
 
 Under ``quotas`` directory, three files (``ms``, ``bytes``,
-``reset_interval_ms``) and one directory (``weights``) having three files
-(``sz_permil``, ``nr_accesses_permil``, and ``age_permil``) in it exist.
+``reset_interval_ms``) and two directores (``weights`` and ``goals``) exist.
 
 You can set the ``time quota`` in milliseconds, ``size quota`` in bytes, and
 ``reset interval`` in milliseconds by writing the values to the three files,
@@ -330,11 +334,20 @@ apply the action to only up to ``bytes`` bytes of memory regions within the
 ``reset_interval_ms``.  Setting both ``ms`` and ``bytes`` zero disables the
 quota limits.
 
-You can also set the :ref:`prioritization weights
+Under ``weights`` directory, three files (``sz_permil``,
+``nr_accesses_permil``, and ``age_permil``) exist.
+You can set the :ref:`prioritization weights
 <damon_design_damos_quotas_prioritization>` for size, access frequency, and age
 in per-thousand unit by writing the values to the three files under the
 ``weights`` directory.
 
+.. sysfs_schemes_quota_goals
+
+schemes/<N>/quotas/goals/
+-------------------------
+
+The directory for the DAMOS goals.
+
 schemes/<N>/watermarks/
 -----------------------
 
-- 
2.34.1

