Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49231767717
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjG1Ufe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjG1UfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D37A44B1;
        Fri, 28 Jul 2023 13:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A747762205;
        Fri, 28 Jul 2023 20:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93157C433CB;
        Fri, 28 Jul 2023 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690576496;
        bh=/3fkCyEgrxb/AUOocTnJxHaLWQx7r2oBGZrkuNBIGj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxWEhRuPcnfrcCVwBiXAj7XlQmmkMrkW9e3U/XpZL+HwfZYSYxvDTK5NHZ3PAyPG6
         U8vjA9kEWx5bcJ05v0Z7MHa4bCwtMcGu8JCoYAlrEuJlCc7Vs7yyR1v/Sxx8AY4gfZ
         Rw47IgpK69FeRYLEkwZWWigquez9wdXepYBOd5mb5fOCaqcRIYMh/HbwR+mAwukQcL
         tsjQgy/BD9KP302rVfPdIHEJ0+GnxpHGFfbSeDr/Uo22p1aCiX6TZMCWTl5RbLO+R8
         Ab1ecYyLD2f4biH6bjWAY5swpY2S9TkcobXnu7R2EqLBDptkXTK7f6lWry3g+yYHfP
         I7uhEvHyiwGGw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/13] Docs/mm/damon/design: update for DAMON monitoring target type DAMOS filter
Date:   Fri, 28 Jul 2023 20:34:42 +0000
Message-Id: <20230728203444.70703-12-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DAMON design document for the newly added DAMON monitoring target
type DAMOS filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 33 +++++++++++++++++--------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 134912166f5a..a20383d01a95 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -380,21 +380,24 @@ number of filters for each scheme.  Each filter specifies the type of target
 memory, and whether it should exclude the memory of the type (filter-out), or
 all except the memory of the type (filter-in).
 
-Currently, anonymous page, memory cgroup, and address range type filters are
-supported by the feature.  Some filter target types can require additional
-arguments.  For example, the memory cgroup filter type asks users to specify
-the file path of the memory cgroup for the filter, while the address range type
-asks the start and end addresses of the range.  Hence, users can apply specific
-schemes to only anonymous pages, non-anonymous pages, pages of specific
-cgroups, all pages excluding those of specific cgroups, pages in specific
-address range, and any combination of those.
-
-To handle filters efficiently, the address range type filter is handled by the
-core layer, while others are handled by operations set.  If a memory region is
-filtered by the core layer-handled filter, it is not counted as the scheme has
-tried to the region.  In contrast, if a memory regions is filtered by an
-operations set layer-handled filter, it is counted as the scheme has tried.
-The difference in accounting leads to changes in the statistics.
+Currently, anonymous page, memory cgroup, address range, and DAMON monitoring
+target type filters are supported by the feature.  Some filter target types
+require additional arguments.  The memory cgroup filter type asks users to
+specify the file path of the memory cgroup for the filter.  The address range
+type asks the start and end addresses of the range.  The DAMON monitoring
+target type asks the index of the target from the context's monitoring targets
+list.  Hence, users can apply specific schemes to only anonymous pages,
+non-anonymous pages, pages of specific cgroups, all pages excluding those of
+specific cgroups, pages in specific address range, pages in specific DAMON
+monitoring targets, and any combination of those.
+
+To handle filters efficiently, the address range and DAMON monitoring target
+type filters are handled by the core layer, while others are handled by
+operations set.  If a memory region is filtered by a core layer-handled filter,
+it is not counted as the scheme has tried to the region.  In contrast, if a
+memory regions is filtered by an operations set layer-handled filter, it is
+counted as the scheme has tried.  The difference in accounting leads to changes
+in the statistics.
 
 
 Application Programming Interface
-- 
2.25.1

