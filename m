Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4247C76D9D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjHBVnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjHBVnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:43:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1284B211F;
        Wed,  2 Aug 2023 14:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B0C61B49;
        Wed,  2 Aug 2023 21:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF748C433C7;
        Wed,  2 Aug 2023 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691012599;
        bh=OCzjAXySbo2P2W2ofPo/GLfYFykKqV/gINis3/IWY+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUY46xF7JqWyv4xqIFT5XLrz9FauytM1EkCm1oel9sWJQ0iCMj0WzZBtKq2pXQ+eH
         2wuOPp+Gpx8XS7jBUD5QU1IobXgPnT/MdQMklMZD/IoaZQRWBVJfnLrtqGBljC1BZ8
         oSrKO0CnfUwrjpnPBPt7lHU4RAIrgaJY18cWctBUEzU/3n+5ZfAZdkq9XBuaANfRKO
         QYaY46+oWoNTKZJrtiEGDB8ls7al1YS94keLHmddp2Es71dupRGlPFPdY9Clwc9uI6
         f3waIxdyaJ652r3kNBOxrQAZXy7XuA9Owyh3fs5aRS/bIsxrpEHBuERf7H7wP0Ptxl
         FekurPKo97gLg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] Docs/mm/damon/design: update for address range filters
Date:   Wed,  2 Aug 2023 21:43:04 +0000
Message-Id: <20230802214312.110532-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
MIME-Version: 1.0
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

Update DAMON design document's DAMOS filters section for address range
DAMOS filters.  Because address range filters are handled by the core
layer and it makes difference in schemes tried regions and schemes
statistics, clearly describe it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 4bfdf1d30c4a..134912166f5a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -380,12 +380,21 @@ number of filters for each scheme.  Each filter specifies the type of target
 memory, and whether it should exclude the memory of the type (filter-out), or
 all except the memory of the type (filter-in).
 
-As of this writing, anonymous page type and memory cgroup type are supported by
-the feature.  Some filter target types can require additional arguments.  For
-example, the memory cgroup filter type asks users to specify the file path of
-the memory cgroup for the filter.  Hence, users can apply specific schemes to
-only anonymous pages, non-anonymous pages, pages of specific cgroups, all pages
-excluding those of specific cgroups, and any combination of those.
+Currently, anonymous page, memory cgroup, and address range type filters are
+supported by the feature.  Some filter target types can require additional
+arguments.  For example, the memory cgroup filter type asks users to specify
+the file path of the memory cgroup for the filter, while the address range type
+asks the start and end addresses of the range.  Hence, users can apply specific
+schemes to only anonymous pages, non-anonymous pages, pages of specific
+cgroups, all pages excluding those of specific cgroups, pages in specific
+address range, and any combination of those.
+
+To handle filters efficiently, the address range type filter is handled by the
+core layer, while others are handled by operations set.  If a memory region is
+filtered by the core layer-handled filter, it is not counted as the scheme has
+tried to the region.  In contrast, if a memory regions is filtered by an
+operations set layer-handled filter, it is counted as the scheme has tried.
+The difference in accounting leads to changes in the statistics.
 
 
 Application Programming Interface
-- 
2.25.1

