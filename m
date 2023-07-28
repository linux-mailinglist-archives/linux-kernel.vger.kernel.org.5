Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AC7676E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjG1USr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjG1USb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F24487;
        Fri, 28 Jul 2023 13:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A263B621F3;
        Fri, 28 Jul 2023 20:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E1BC433CA;
        Fri, 28 Jul 2023 20:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690575509;
        bh=yEbF4+MD2fwxwTT+Hga32t2Dr/eR/mptRKFvKfgNyUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDJUz30ZehPsXA+PQlXSm9ldhk+fPDLca0I+OUG/yn3vxepk0mbOOs2+GH/ZLVgH9
         idSbNzHHPgRSd+wZmFUG5A4pMJ9xHp5IqXtfaMPxw7Nw9L1lNa1zDqNV+aKEWrzb8E
         SpKo4kEuErqGFwO7SQgmuh+u8bXDBqdIvDPCYxKX6SvpNHL6Tk3v1/R12mIXf3KnZU
         Q0lwrt0sVWMLxDpK7V0LGTQjb/CFLs3nG2e+LYXeiLf2AbeTn2AcPon1z/CCsEQubS
         pvh07PquPFmXHGk8+pCbivFx3M0GZqW177OkD5L/twoxcbMh2BbtU2zFuCZEGvX8KH
         4jU15BTtd3P7A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] Docs/admin-guide/mm/damon/usage: update for tried_regions/total_bytes
Date:   Fri, 28 Jul 2023 20:18:17 +0000
Message-Id: <20230728201817.70602-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728201817.70602-1-sj@kernel.org>
References: <20230728201817.70602-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the DAMON usage document for newly added
schemes/.../tried_regions/total_bytes file and the
update_schemes_tried_bytes command.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 42 +++++++++++++-------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 2d495fa85a0e..1859dd6c3834 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -87,7 +87,7 @@ comma (","). ::
     │ │ │ │ │ │ │ filters/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
     │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
-    │ │ │ │ │ │ │ tried_regions/
+    │ │ │ │ │ │ │ tried_regions/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
@@ -127,14 +127,18 @@ in the state.  Writing ``commit`` to the ``state`` file makes kdamond reads the
 user inputs in the sysfs files except ``state`` file again.  Writing
 ``update_schemes_stats`` to ``state`` file updates the contents of stats files
 for each DAMON-based operation scheme of the kdamond.  For details of the
-stats, please refer to :ref:`stats section <sysfs_schemes_stats>`.  Writing
-``update_schemes_tried_regions`` to ``state`` file updates the DAMON-based
-operation scheme action tried regions directory for each DAMON-based operation
-scheme of the kdamond.  Writing ``clear_schemes_tried_regions`` to ``state``
-file clears the DAMON-based operating scheme action tried regions directory for
-each DAMON-based operation scheme of the kdamond.  For details of the
-DAMON-based operation scheme action tried regions directory, please refer to
-:ref:`tried_regions section <sysfs_schemes_tried_regions>`.
+stats, please refer to :ref:`stats section <sysfs_schemes_stats>`.
+
+Writing ``update_schemes_tried_regions`` to ``state`` file updates the
+DAMON-based operation scheme action tried regions directory for each
+DAMON-based operation scheme of the kdamond.  Writing
+``update_schemes_tried_bytes`` to ``state`` file updates only
+``.../tried_regions/total_bytes`` files.  Writing
+``clear_schemes_tried_regions`` to ``state`` file clears the DAMON-based
+operating scheme action tried regions directory for each DAMON-based operation
+scheme of the kdamond.  For details of the DAMON-based operation scheme action
+tried regions directory, please refer to :ref:`tried_regions section
+<sysfs_schemes_tried_regions>`.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
@@ -406,13 +410,21 @@ stats by writing a special keyword, ``update_schemes_stats`` to the relevant
 schemes/<N>/tried_regions/
 --------------------------
 
+This directory initially has one file, ``total_bytes``.
+
 When a special keyword, ``update_schemes_tried_regions``, is written to the
-relevant ``kdamonds/<N>/state`` file, DAMON creates directories named integer
-starting from ``0`` under this directory.  Each directory contains files
-exposing detailed information about each of the memory region that the
-corresponding scheme's ``action`` has tried to be applied under this directory,
-during next :ref:`aggregation interval <sysfs_monitoring_attrs>`.  The
-information includes address range, ``nr_accesses``, and ``age`` of the region.
+relevant ``kdamonds/<N>/state`` file, DAMON updates the ``total_bytes`` file so
+that reading it returns the total size of the scheme tried regions, and creates
+directories named integer starting from ``0`` under this directory.  Each
+directory contains files exposing detailed information about each of the memory
+region that the corresponding scheme's ``action`` has tried to be applied under
+this directory, during next :ref:`aggregation interval
+<sysfs_monitoring_attrs>`.  The information includes address range,
+``nr_accesses``, and ``age`` of the region.
+
+Writing ``update_schemes_tried_bytes`` to the relevant ``kdamonds/<N>/state``
+file will only update the ``total_bytes`` file, and will not create the
+subdirectories.
 
 The directories will be removed when another special keyword,
 ``clear_schemes_tried_regions``, is written to the relevant
-- 
2.25.1

