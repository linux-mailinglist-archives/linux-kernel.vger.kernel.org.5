Return-Path: <linux-kernel+bounces-69608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC100858C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB931C21608
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6AA2556C;
	Sat, 17 Feb 2024 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISsyfP3Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1A241E1;
	Sat, 17 Feb 2024 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131529; cv=none; b=PXanwopSashG0LAWmRo6MQgganVST878wkgqCF3TEQ9r17xTypfXQQPdsmjbeyBLkp4bxwrmq4RVFKvkfcHSmyKtcPL8I51ajOMgOquTiX4WHQSSARB6wh4p5H+w/X3bx5IjCXGK5rFVFSe9kTyAdLMiSaVU+gMmBx0sSoUroaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131529; c=relaxed/simple;
	bh=6n2FATexNcLId4djVWKHF9wa5NUBH9cgNCITDt2Fr18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kH4ayuRYfUhlJXvfdM0MBVAe2ij7dBBw/ij/+YtESxwhaaVaGv/dOvCZS+A9n41JKYQw65UVjtKMveCBfgsY0s48wLJ7ZB8yDbRKWX7AgpuJFhctEUsVr8/IzTxOMmrZtzwhS7Rh5tez7tXVjClfUuX67IdU8JAjUdfkT9Q9RxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISsyfP3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CB8C433F1;
	Sat, 17 Feb 2024 00:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131529;
	bh=6n2FATexNcLId4djVWKHF9wa5NUBH9cgNCITDt2Fr18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISsyfP3ZrwLmaMw1RafF3JsD6d33RuEvcLcbAEmduwXDR9M2kuhUQTy9tz9cN7tTz
	 NDeLa3meDWtsWp9y5+LB/9snyNbOChBxsbAKgTHiUQQyw4KeuVlYNhzGrX9uRpIS6x
	 p/rhICMyyMBvQi+QYZMOESAHbv6fCQ+rQg1OwiPV4fneYCcCi6QM8vMhAeyCzBzCKR
	 ekGrLzkmFRU6AekKPY9dToMotM6+gIEbLim4OOw7olVO397RqeIlqxXnMqOrc/iQtq
	 ZG1CsALtnmtEPzB490JOvu11WJrILRoOW3W7aGazKv0zLOKUClugFBU3Ejeue9tFem
	 Bf0eNvc+wkDuQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Docs/mm/damon: move monitoring target regions setup detail from the usage to the design document
Date: Fri, 16 Feb 2024 16:58:41 -0800
Message-Id: <20240217005842.87348-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240217005842.87348-1-sj@kernel.org>
References: <20240217005842.87348-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Design doc is aimed to have all concept level details, while the usage
doc is focused on only how the features can be used.  Some details about
monitoring target regions construction is on the usage doc.  Move the
details about the monitoring target regions construction differences for
DAMON operations set from the usage to the design doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 16 +++++-----------
 Documentation/mm/damon/design.rst            | 12 +++++++++---
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index be0924f47a42..fefe62e0a466 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -242,17 +242,11 @@ process to the ``pid_target`` file.
 targets/<N>/regions
 -------------------
 
-When ``vaddr`` monitoring operations set is being used (``vaddr`` is written to
-the ``contexts/<N>/operations`` file), DAMON automatically sets and updates the
-monitoring target regions so that entire memory mappings of target processes
-can be covered.  However, users could want to set the initial monitoring region
-to specific address ranges.
-
-In contrast, DAMON do not automatically sets and updates the monitoring target
-regions when ``fvaddr`` or ``paddr`` monitoring operations sets are being used
-(``fvaddr`` or ``paddr`` have written to the ``contexts/<N>/operations``).
-Therefore, users should set the monitoring target regions by themselves in the
-cases.
+In case of ``fvaddr`` or ``paddr`` monitoring operations sets, users are
+required to set the monitoring target address ranges.  In case of ``vaddr``
+operations set, it is not mandatory, but users can optionally set the initial
+monitoring region to specific address ranges.  Please refer to the :ref:`design
+<damon_design_vaddr_target_regions_construction>` for more details.
 
 For such cases, users can explicitly set the initial monitoring target regions
 as they want, by writing proper values to the files under this directory.
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 6abf976dd71f..2bd0c203dcfb 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -83,12 +83,18 @@ describe how those work.
  - paddr: Monitor the physical address space of the system
 
 
+ .. _damon_design_vaddr_target_regions_construction:
+
 VMA-based Target Address Range Construction
 -------------------------------------------
 
-This is only for the virtual address space monitoring operations
-implementation.  That for the physical address space simply asks users to
-manually set the monitoring target address ranges.
+A mechanism of ``vaddr`` DAMON operations set that automatically initializes
+and updates the monitoring target address regions so that entire memory
+mappings of the target processes can be covered.
+
+This mechanism is only for the ``vaddr`` operations set.  In cases of
+``fvaddr`` and ``paddr`` operation sets, users are asked to manually set the
+monitoring target address ranges.
 
 Only small parts in the super-huge virtual address space of the processes are
 mapped to the physical memory and accessed.  Thus, tracking the unmapped
-- 
2.39.2


