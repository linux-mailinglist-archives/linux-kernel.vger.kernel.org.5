Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75632799C72
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345844AbjIJDlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343962AbjIJDk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:40:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE4018F;
        Sat,  9 Sep 2023 20:40:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCC7C433CB;
        Sun, 10 Sep 2023 03:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694317256;
        bh=mFM51HzoacyqEH6SUQlgy6Seux4I2scRhn39ZTi26N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggjMC2rmC/l0w3mnxmHmvMLHBY+eoIkIhaqUHgcKJkeLp9KdJd9TOBud13T113lyx
         bK+9WVt2wR8tYBlSMiwDTbbJWBtR8c2uKMve4DoO47Ocw9i1LprtBLoEe8R1sVkRu6
         QaVmD7Domx1Dhzr1xW9KHlMlM8CpgIkYhycXUCR1+xnrQy7lcckR7acPYU9lpf9ZKi
         139vmPrd7zxFCh1zlOZ/eQoDhJMv/Ybu9j8+QqTtqcG/fUvso0W2tLBty1MDSUlTwy
         yyTYrg/FNIF/NEfT3QCrRkNG+qDMx2BtxTu2DvezLkq674bfGaS9kb86X/wN6Q68v5
         MehGv6Co7gdAA==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 7/8] Docs/admin-guide/mm/damon/usage: update for DAMOS apply intervals
Date:   Sun, 10 Sep 2023 03:40:47 +0000
Message-Id: <20230910034048.59191-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910034048.59191-1-sj@kernel.org>
References: <20230910034048.59191-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DAMON usage document's DAMON sysfs interface section for the
newly added DAMOS apply intervals support (apply_interval_us file).

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 6272cd36590a..8507a6e45d86 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -76,7 +76,7 @@ comma (","). ::
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ │ schemes/nr_schemes
-    │ │ │ │ │ │ 0/action
+    │ │ │ │ │ │ 0/action,apply_interval_us
     │ │ │ │ │ │ │ access_pattern/
     │ │ │ │ │ │ │ │ sz/min,max
     │ │ │ │ │ │ │ │ nr_accesses/min,max
@@ -269,8 +269,8 @@ schemes/<N>/
 ------------
 
 In each scheme directory, five directories (``access_pattern``, ``quotas``,
-``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and one file
-(``action``) exist.
+``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and two files
+(``action`` and ``apply_interval``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
@@ -296,6 +296,9 @@ Note that support of each action depends on the running DAMON operations set
  - ``stat``: Do nothing but count the statistics.
    Supported by all operations sets.
 
+The ``apply_interval_us`` file is for setting and getting the scheme's
+:ref:`apply_interval <damon_design_damos>` in microseconds.
+
 schemes/<N>/access_pattern/
 ---------------------------
 
-- 
2.25.1

