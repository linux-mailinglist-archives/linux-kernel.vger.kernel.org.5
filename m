Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1276796EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244906AbjIGC3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243335AbjIGC3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:29:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A2A171F;
        Wed,  6 Sep 2023 19:29:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34969C433CA;
        Thu,  7 Sep 2023 02:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694053782;
        bh=M64Pfxcjf04QA6IY4mZMjdI8QQdmOQDItlzxRcwz4LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVm2PfWXGzcgo0kBxY/8/P25MQuwXf2YFzHZmudczea0VOOSzggdox8oqOLX3u4Nr
         ZlZHTblD7l+UcOvhoYenzWvOLWWxJslj5dYbFGfNz0oN3B81Pcxt+aPPDKmI6jrtMo
         YllggfJnHAK1A1kkPPl/wWO7P2zWYpBc1Pe//JP9NYo6K6Q70bKcUnlzBrImIpv2NS
         izprI02tEPyUMz1Hfpctj6gMDM09k49HVu5q+X2frB82M8+ahs+8gOQpnkbrxSw5zm
         Qkvh9AomlCBXMtNeaCR/vzEj0YIX85F7RxK58U3UuYr+LD8Mxn/OkeIaAZNfHgvaPS
         MjJ6rWY4ilFKQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] Docs/admin-guide/mm/damon/usage: link design doc for details of kdamond and context
Date:   Thu,  7 Sep 2023 02:29:25 +0000
Message-Id: <20230907022929.91361-8-sj@kernel.org>
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

The explanation of kdamond and context is duplicated in the design and
the usage documents.  Replace that in the usage with links to those in
the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 19 +++++++++----------
 Documentation/mm/damon/design.rst            |  2 ++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 758575d33ab6..282062b6f134 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -105,14 +105,12 @@ having the root permission could use this directory.
 kdamonds/
 ---------
 
-The monitoring-related information including request specifications and results
-are called DAMON context.  DAMON executes each context with a kernel thread
-called kdamond, and multiple kdamonds could run in parallel.
-
 Under the ``admin`` directory, one directory, ``kdamonds``, which has files for
-controlling the kdamonds exist.  In the beginning, this directory has only one
-file, ``nr_kdamonds``.  Writing a number (``N``) to the file creates the number
-of child directories named ``0`` to ``N-1``.  Each directory represents each
+controlling the kdamonds (refer to
+:ref:`design <damon_design_execution_model_and_data_structures>` for more
+details) exists.  In the beginning, this directory has only one file,
+``nr_kdamonds``.  Writing a number (``N``) to the file creates the number of
+child directories named ``0`` to ``N-1``.  Each directory represents each
 kdamond.
 
 kdamonds/<N>/
@@ -150,9 +148,10 @@ kdamonds/<N>/contexts/
 
 In the beginning, this directory has only one file, ``nr_contexts``.  Writing a
 number (``N``) to the file creates the number of child directories named as
-``0`` to ``N-1``.  Each directory represents each monitoring context.  At the
-moment, only one context per kdamond is supported, so only ``0`` or ``1`` can
-be written to the file.
+``0`` to ``N-1``.  Each directory represents each monitoring context (refer to
+:ref:`design <damon_design_execution_model_and_data_structures>` for more
+details).  At the moment, only one context per kdamond is supported, so only
+``0`` or ``1`` can be written to the file.
 
 .. _sysfs_contexts:
 
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index ee099d45fea8..18e9b42673f8 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -478,6 +478,8 @@ more detail, please read the usage documents for those
 :doc:`/admin-guide/mm/damon/lru_sort`).
 
 
+.. _damon_design_execution_model_and_data_structures:
+
 Execution Model and Data Structures
 ===================================
 
-- 
2.25.1

