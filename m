Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0BF7FE704
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjK3CiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjK3CiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:38:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA01724
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:37:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC48C43397;
        Thu, 30 Nov 2023 02:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701311825;
        bh=hrTz5NA/0bpRG+IM7KT93kpboj36cTnKZu8N5QKEqUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvVUGnsUsiWCKqpDlmOX2XKk6UqdaHKsZaVRWF91tLjhwdxfdUtr9Yomb5BxOaIqJ
         FBXVuQfdLlmiSoWtD+ymomcu7SR+EVWV5O37jMU2y3G9C7TwprdJZb2uRZ0h/dLDVt
         pEkCA+vn2BnVIMRYYOiCLX46TP/NmsVyzhueBhNVLK2Y3iiLwzsiY2sS+RJ8AVbAkW
         l9gL7SBopuNkfmne+dJdUmCFE4I/1ZjVxk+CNKdEzM0fdaEU2Pnyz2z7t1263Ab6LJ
         IhBMQSbOi7qkVCFuIAe7E5otrcTrE5vJM6ctuRQXsR+QSb9ASNSWzaooKDvNJ7m8Dy
         mXxIO/shZsVIA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] Docs/admin-guide/mm/damon/usage: document for quota goals
Date:   Thu, 30 Nov 2023 02:36:52 +0000
Message-Id: <20231130023652.50284-10-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130023652.50284-1-sj@kernel.org>
References: <20231130023652.50284-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DAMON sysfs usage for newly added DAMOS quota goals interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 48 +++++++++++++++++---
 Documentation/mm/damon/design.rst            |  2 +
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index da94feb97ed1..ff9f62e65722 100644
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
@@ -113,6 +115,8 @@ details) exists.  In the beginning, this directory has only one file,
 child directories named ``0`` to ``N-1``.  Each directory represents each
 kdamond.
 
+.. _sysfs_kdamond:
+
 kdamonds/<N>/
 -------------
 
@@ -121,11 +125,18 @@ In each kdamond directory, two files (``state`` and ``pid``) and one directory
 
 Reading ``state`` returns ``on`` if the kdamond is currently running, or
 ``off`` if it is not running.  Writing ``on`` or ``off`` makes the kdamond be
-in the state.  Writing ``commit`` to the ``state`` file makes kdamond reads the
+in the state.
+
+Writing ``commit`` to the ``state`` file makes kdamond reads the
 user inputs in the sysfs files except ``state`` file again.  Writing
-``update_schemes_stats`` to ``state`` file updates the contents of stats files
-for each DAMON-based operation scheme of the kdamond.  For details of the
-stats, please refer to :ref:`stats section <sysfs_schemes_stats>`.
+``commit_schemes_quota_goals`` to the ``state`` file makes kdamond reads the
+DAMON-based operation schemes' :ref:`quota goals <sysfs_schemes_quota_goals>`
+of the kdamond.
+
+Writing ``update_schemes_stats`` to ``state`` file updates the
+contents of stats files for each DAMON-based operation scheme of the kdamond.
+For details of the stats, please refer to :ref:`stats section
+<sysfs_schemes_stats>`.
 
 Writing ``update_schemes_tried_regions`` to ``state`` file updates the
 DAMON-based operation scheme action tried regions directory for each
@@ -319,8 +330,7 @@ The directory for the :ref:`quotas <damon_design_damos_quotas>` of the given
 DAMON-based operation scheme.
 
 Under ``quotas`` directory, three files (``ms``, ``bytes``,
-``reset_interval_ms``) and one directory (``weights``) having three files
-(``sz_permil``, ``nr_accesses_permil``, and ``age_permil``) in it exist.
+``reset_interval_ms``) and two directores (``weights`` and ``goals``) exist.
 
 You can set the ``time quota`` in milliseconds, ``size quota`` in bytes, and
 ``reset interval`` in milliseconds by writing the values to the three files,
@@ -330,11 +340,35 @@ apply the action to only up to ``bytes`` bytes of memory regions within the
 ``reset_interval_ms``.  Setting both ``ms`` and ``bytes`` zero disables the
 quota limits.
 
-You can also set the :ref:`prioritization weights
+Under ``weights`` directory, three files (``sz_permil``,
+``nr_accesses_permil``, and ``age_permil``) exist.
+You can set the :ref:`prioritization weights
 <damon_design_damos_quotas_prioritization>` for size, access frequency, and age
 in per-thousand unit by writing the values to the three files under the
 ``weights`` directory.
 
+.. _sysfs_schemes_quota_goals:
+
+schemes/<N>/quotas/goals/
+-------------------------
+
+The directory for the :ref:`automatic quota tuning goals
+<damon_design_damos_quotas_auto_tuning>` of the given DAMON-based operation
+scheme.
+
+In the beginning, this directory has only one file, ``nr_goals``.  Writing a
+number (``N``) to the file creates the number of child directories named ``0``
+to ``N-1``.  Each directory represents each goal and current achievement.
+Among the multiple feedback, the best one is used.
+
+Each goal directory contains two files, namely ``target_value`` and
+``current_value``.  Users can set and get any number to those files to set the
+feedback.  User space main workload's latency or throughput, system metrics
+like free memory ratio or memory pressure stall time (PSI) could be example
+metrics for the values.  Note that users should write
+``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
+directory <sysfs_kdamond>` to pass the feedback to DAMON.
+
 schemes/<N>/watermarks/
 -----------------------
 
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 947c9df6cd33..8b4a49ac057d 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -346,6 +346,8 @@ the weight will be respected are up to the underlying prioritization mechanism
 implementation.
 
 
+.. _damon_design_damos_quotas_auto_tuning:
+
 Aim-oriented Feedback-driven Auto-tuning
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-- 
2.34.1

