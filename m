Return-Path: <linux-kernel+bounces-168003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681BF8BB218
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0A11C22C4A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F13C158DCE;
	Fri,  3 May 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7w9nGDb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48A158DA3;
	Fri,  3 May 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759408; cv=none; b=a5pjIjFEwWsbsWmnCTraDGXnH74oW0u1Dh4678G+OC62rM+R23wAQUS7voU/aEwz4ih5FKSYZUko/ePt2/18OlfJYsjl0+vXcpCCro4QPwedZYMp9karWdQN0vux7EJHLnktChPOZNuXcdaKCWJRx9aS4XQ0IWyWRG3XpLnkkxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759408; c=relaxed/simple;
	bh=Kr16aWsUWHmzs0T3rMgu4QN0Xzu0Ms/e3QljzklXCpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdNY3KGDm+qn3e0Oc5ejDQBdTIly0CW61MsN2SLhleRZOYenopmGLKNhXZkQFyn4IVrIBUIoaAxQHN9fNbM8cv9hGDvLaLgDzB4hLaZZkxZ7LY6u9asKObTnOSSY0PR4zlnSFTdg6Z0xYeA5aFTetbrflfWZfe+n+oGcGVzPHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7w9nGDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0AAC4AF19;
	Fri,  3 May 2024 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759407;
	bh=Kr16aWsUWHmzs0T3rMgu4QN0Xzu0Ms/e3QljzklXCpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7w9nGDbaTbVNvv//EAR/1njh5p6lE60qGH7jBDMIDT21if4xM2hV4mOvqwVQspqI
	 WsDHWJ4RMZ8lILUhRxAXa6KZBwXZB1jht2lDxwbn4FJ5Kgif8TlZfFBnJmtpVVXSL+
	 JL6RPq9/hqZHjGgDIoPUxqiB9JvYWxwqA90sLjcXJi/KZwvqOB58k9SKgWIX1hHMg9
	 5SgjtB0adzb/2Ubt6JS3QO2DkwLz2HxGJSUmuV8u/JnZM9WSZTGOqmAxl241tHBo7G
	 q8VfeLPNsrd76mwdWktnd/q1Dv9RiaQPQJpZxMaaWkEo45v3Y3l3BUClaqInZxJaif
	 70PRjztQYcfxA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] Docs/mm/damon/design: use a list for supported filters
Date: Fri,  3 May 2024 11:03:16 -0700
Message-Id: <20240503180318.72798-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503180318.72798-1-sj@kernel.org>
References: <20240503180318.72798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filters section is listing currently supported filter types in a normal
paragraph.  Since the number of types are higher than four, it is not
easy to read for only specific types.  Use a list for easier finding of
specific types.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 46 +++++++++++++++++--------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index f2baf617184d..1873755358af 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -461,26 +461,32 @@ number of filters for each scheme.  Each filter specifies the type of target
 memory, and whether it should exclude the memory of the type (filter-out), or
 all except the memory of the type (filter-in).
 
-Currently, anonymous page, memory cgroup, young page, address range, and DAMON
-monitoring target type filters are supported by the feature.  Some filter
-target types require additional arguments.  The memory cgroup filter type asks
-users to specify the file path of the memory cgroup for the filter.  The
-address range type asks the start and end addresses of the range.  The DAMON
-monitoring target type asks the index of the target from the context's
-monitoring targets list.  Hence, users can apply specific schemes to only
-anonymous pages, non-anonymous pages, pages of specific cgroups, all pages
-excluding those of specific cgroups, pages that not accessed after the last
-access check from the scheme, pages that accessed after the last access check
-from the scheme, pages in specific address range, pages in specific DAMON
-monitoring targets, and any combination of those.
-
-To handle filters efficiently, the address range and DAMON monitoring target
-type filters are handled by the core layer, while others are handled by
-operations set.  If a memory region is filtered by a core layer-handled filter,
-it is not counted as the scheme has tried to the region.  In contrast, if a
-memory regions is filtered by an operations set layer-handled filter, it is
-counted as the scheme has tried.  The difference in accounting leads to changes
-in the statistics.
+For efficient handling of filters, some types of filters are handled by the
+core layer, while others are handled by operations set.  In the latter case,
+hence, support of the filter types depends on the DAMON operations set.  In
+case of the core layer-handled filters, the memory regions that excluded by the
+filter are not counted as the scheme has tried to the region.  In contrast, if
+a memory regions is filtered by an operations set layer-handled filter, it is
+counted as the scheme has tried.  This difference affects the statistics.
+
+Below types of filters are currently supported.
+
+- anonymous page
+  - Applied to pages that containing data that not stored in files.
+  - Handled by operations set layer.  Supported by only ``paddr`` set.
+- memory cgroup
+  - Applied to pages that belonging to a given cgroup.
+  - Handled by operations set layer.  Supported by only ``paddr`` set.
+- young page
+  - Applied to pages that are accessed after the last access check from the
+    scheme.
+  - Handled by operations set layer.  Supported by only ``paddr`` set.
+- address range
+  - Applied to pages that belonging to a given address range.
+  - Handled by the core logic.
+- DAMON monitoring target
+  - Applied to pages that belonging to a given DAMON monitoring target.
+  - Handled by the core logic.
 
 
 Application Programming Interface
-- 
2.39.2


