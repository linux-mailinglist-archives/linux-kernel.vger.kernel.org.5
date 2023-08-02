Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3171376D9DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjHBVoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjHBVng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:43:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF7269A;
        Wed,  2 Aug 2023 14:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C877461B5D;
        Wed,  2 Aug 2023 21:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2885FC433CA;
        Wed,  2 Aug 2023 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691012604;
        bh=jeC4GAEfQQwmVnTIZskvg6L9vM/nrayE2m9ijer6n98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoWA1fuvDjK7jXhUhoEI65MmGUs7H6QEze0nam2eSmQQDmKFqwbEc7ntj+UTqkneK
         s4V78zjTnozT3fM3yX/OWz1tCwvhnBtviwrfyEqCpROqYVe+H58xxnNHCrW6kpG0U+
         JfEyQScqzF993YUJ7gMeYUcyg+IYEmqdJEcNAZn4CL3Zv5SqighkfbzL2O+Y/acMFw
         JQyEs1Docsz/CwWvVuiYbxfTuk/A6rfZ3aQYHL1HFWVWpjJiPICbVZEmzELUXP/ErR
         Kak42ueYfq7zOBq8BrEh/YZeMTARGPU9y7ifjguZbR1kbjoyPqdgg3UPBGHm15Vncu
         pVaT/urDi+FOw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] Docs/admin-guide/mm/damon/usage: update for DAMON monitoring target type DAMOS filter
Date:   Wed,  2 Aug 2023 21:43:12 +0000
Message-Id: <20230802214312.110532-14-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
MIME-Version: 1.0
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

Update DAMON usage document for newly added DAMON monitoring target type
DAMOS filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 37 +++++++++++---------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index a9cb9949b796..084f0a32b421 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -363,18 +363,21 @@ number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each filter.  The filters are evaluated
 in the numeric order.
 
-Each filter directory contains five files, namely ``type``, ``matcing``,
-``memcg_path``, ``addr_start``, and ``addr_end``.  To ``type`` file, you can
-write one of three special keywords: ``anon`` for anonymous pages, ``memcg``
-for specific memory cgroup, or ``addr`` for specific address range (an
-open-ended interval) filtering.  In case of the memory cgroup filtering, you
-can specify the memory cgroup of the interest by writing the path of the memory
-cgroup from the cgroups mount point to ``memcg_path`` file.  In case of the
-address range filtering, you can specify the start and end address of the range
-to ``addr_start`` and ``addr_end`` files, respectively.  You can write ``Y`` or
-``N`` to ``matching`` file to filter out pages that does or does not match to
-the type, respectively.  Then, the scheme's action will not be applied to the
-pages that specified to be filtered out.
+Each filter directory contains six files, namely ``type``, ``matcing``,
+``memcg_path``, ``addr_start``, ``addr_end``, and ``target_idx``.  To ``type``
+file, you can write one of four special keywords: ``anon`` for anonymous pages,
+``memcg`` for specific memory cgroup, ``addr`` for specific address range (an
+open-ended interval), or ``target`` for specific DAMON monitoring target
+filtering.  In case of the memory cgroup filtering, you can specify the memory
+cgroup of the interest by writing the path of the memory cgroup from the
+cgroups mount point to ``memcg_path`` file.  In case of the address range
+filtering, you can specify the start and end address of the range to
+``addr_start`` and ``addr_end`` files, respectively.  For the DAMON monitoring
+target filtering, you can specify the index of the target between the list of
+the DAMON context's monitoring targets list to ``target_idx`` file.  You can
+write ``Y`` or ``N`` to ``matching`` file to filter out pages that does or does
+not match to the type, respectively.  Then, the scheme's action will not be
+applied to the pages that specified to be filtered out.
 
 For example, below restricts a DAMOS action to be applied to only non-anonymous
 pages of all memory cgroups except ``/having_care_already``.::
@@ -391,11 +394,11 @@ pages of all memory cgroups except ``/having_care_already``.::
 Note that ``anon`` and ``memcg`` filters are currently supported only when
 ``paddr`` `implementation <sysfs_contexts>` is being used.
 
-Also, memory regions that are filtered out by ``addr`` filters are not counted
-as the scheme has tried to those, while regions that filtered out by other type
-filters are counted as the scheme has tried to.  The difference is applied to
-:ref:`stats <damos_stats>` and :ref:`tried regions
-<sysfs_schemes_tried_regions>`.
+Also, memory regions that are filtered out by ``addr`` or ``target`` filters
+are not counted as the scheme has tried to those, while regions that filtered
+out by other type filters are counted as the scheme has tried to.  The
+difference is applied to :ref:`stats <damos_stats>` and
+:ref:`tried regions <sysfs_schemes_tried_regions>`.
 
 .. _sysfs_schemes_stats:
 
-- 
2.25.1

