Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FDC7BF03B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379333AbjJJB0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379272AbjJJB0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:26:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C499E;
        Mon,  9 Oct 2023 18:26:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F91C433CD;
        Tue, 10 Oct 2023 01:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696901168;
        bh=PRMNaWi4eLwEr1ddca0C6ItteLnRKdFxcFRimSLMbuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DinnA0mIa0xXyxJyvyJPWRn0gfhZL4OuTtZEyU3zDNJ24JTTZMqczCXaW2VxkR2HD
         9/SCzw1uhvAFQOO25rh75JnffxCNj6eyVIgAoSbetEBVXf7UZoouWyNpUYRhKPVzFL
         hsXezDNiIK/6jDuO3EJf2XG2trq4vlFHii7KB+umOOp6rlfwtGkO7RikibyFV9WOgB
         fBwpcMEJb+9ze5Mn8+zY9PMJoZiDp0LrwO/3PNxkdUjxCJ2TVeuVbNIBjl8+upxgTH
         Mag4Z3w65XlP8fXvzuI0flSiII5ELHCFKiSEEtuzTZqS65EarNJLY/SLDy6g5Xp3Cg
         LgwoNZvdyVH6Q==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] Docs/admin-guide/mm/damon/usage: update for tried regions update time interval
Date:   Tue, 10 Oct 2023 01:26:00 +0000
Message-Id: <20231010012600.83140-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010012600.83140-1-sj@kernel.org>
References: <20231010012600.83140-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation says DAMOS tried regions update feature of DAMON sysfs
interface is doing the update for one aggregation interval after the
request is made.  Since the introduction of the per-scheme apply
interval, that behavior makes no much sense.  Hence the implementation
has changed to update the regions for each scheme for only its apply
interval.  Further update the document to reflect the real behavior.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 8507a6e45d86..da94feb97ed1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -432,9 +432,9 @@ that reading it returns the total size of the scheme tried regions, and creates
 directories named integer starting from ``0`` under this directory.  Each
 directory contains files exposing detailed information about each of the memory
 region that the corresponding scheme's ``action`` has tried to be applied under
-this directory, during next :ref:`aggregation interval
-<sysfs_monitoring_attrs>`.  The information includes address range,
-``nr_accesses``, and ``age`` of the region.
+this directory, during next :ref:`apply interval <damon_design_damos>` of the
+corresponding scheme.  The information includes address range, ``nr_accesses``,
+and ``age`` of the region.
 
 Writing ``update_schemes_tried_bytes`` to the relevant ``kdamonds/<N>/state``
 file will only update the ``total_bytes`` file, and will not create the
-- 
2.34.1

