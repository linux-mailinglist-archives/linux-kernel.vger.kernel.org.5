Return-Path: <linux-kernel+bounces-69607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C770E858C4C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1E2B2215B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E83B250EC;
	Sat, 17 Feb 2024 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1LRIars"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2FB21100;
	Sat, 17 Feb 2024 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131529; cv=none; b=hlXFef9vtaGwaHb+MzVsLh4qGhp8uY8ebLN2PovHLzML85VPkbXBmfHyl5Cm+QG66YOmFUBorjZ6Hkt182uHuxPuEj38KsdOqfgZuuL68ShC0k7+efpujktK26hcRnel1c2WvJ7mX3Ji5k1tI2+Q8St6j+Ot0FXh85thKknMrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131529; c=relaxed/simple;
	bh=PHukevGUaPQZ0Um8hgVXJLMqOMYMR4EFewceSXfTR20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L4nTWxQXHhMxY7ywXPaJCC0lnFRFYNWYoa06puRvABJRvIRxsI5hu5q2u7IUhqW5e/cj7lTxYsBLOXXf11RXMJj6J8JHQLkWE3Evo01U+Nb18fVQcFfcQciJJnpdcm5XnKtrrt8pLPE43G6cRc91uo2yeRqnZKMObhvBrf27PPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1LRIars; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7F1C43390;
	Sat, 17 Feb 2024 00:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131528;
	bh=PHukevGUaPQZ0Um8hgVXJLMqOMYMR4EFewceSXfTR20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1LRIarsi4JEdp5awudjc8ZjiK4TTDFQvBacB7HgvC9og6SplSDfSj8p9vx7Nj1vU
	 MXt6mtUIt/A3GuCr60Kt4C+LT1P/BFtsSq+1sFP5SzhpblfgpDJHEx1coctwHfxF4Y
	 1aflAnUaAPr8y286nDAaC2Bx03T5qXXnXP06wYAtuL//9xKsm8/mbH/ZdM2H3zWRAm
	 4fW0ZDYAO0hI2FGOwq5MynjPnqmI6ulZsgjSumQuTmBN1vesW0pIRAvRFhu216FWyw
	 w0N6B3qOo/dajkSf/2tCIL8phQRnHhfS9cwp+sb++optf0lUc91VHsTIbSMYg2mbVc
	 vi47D6ILa3s6g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Docs/mm/damon: move DAMON operation sets list from the usage to the design document
Date: Fri, 16 Feb 2024 16:58:40 -0800
Message-Id: <20240217005842.87348-4-sj@kernel.org>
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

The list of DAMON operation sets and their explanation, which may better
to be on design document, is written on the usage document.  Move the
detail to design document and make the usage document only reference the
design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 19 +++++++------------
 Documentation/mm/damon/design.rst            | 12 ++++++++++--
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 0335d584956b..be0924f47a42 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -180,19 +180,14 @@ In each context directory, two files (``avail_operations`` and ``operations``)
 and three directories (``monitoring_attrs``, ``targets``, and ``schemes``)
 exist.
 
-DAMON supports multiple types of monitoring operations, including those for
-virtual address space and the physical address space.  You can get the list of
-available monitoring operations set on the currently running kernel by reading
+DAMON supports multiple types of :ref:`monitoring operations
+<damon_design_confiurable_operations_set>`, including those for virtual address
+space and the physical address space.  You can get the list of available
+monitoring operations set on the currently running kernel by reading
 ``avail_operations`` file.  Based on the kernel configuration, the file will
-list some or all of below keywords.
-
- - vaddr: Monitor virtual address spaces of specific processes
- - fvaddr: Monitor fixed virtual address ranges
- - paddr: Monitor the physical address space of the system
-
-Please refer to :ref:`regions sysfs directory <sysfs_regions>` for detailed
-differences between the operations sets in terms of the monitoring target
-regions.
+list different available operation sets.  Please refer to the :ref:`design
+<damon_operations_set>` for the list of all available operation sets and their
+brief explanations.
 
 You can set and get what type of monitoring operations DAMON will use for the
 context by writing one of the keywords listed in ``avail_operations`` file and
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 9f16c4e62e72..6abf976dd71f 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -31,6 +31,8 @@ DAMON subsystem is configured with three layers including
   interfaces for the user space, on top of the core layer.
 
 
+.. _damon_design_configurable_operations_set:
+
 Configurable Operations Set
 ---------------------------
 
@@ -63,6 +65,8 @@ modules that built on top of the core layer using the API, which can be easily
 used by the user space end users.
 
 
+.. _damon_operations_set:
+
 Operations Set Layer
 ====================
 
@@ -71,8 +75,12 @@ The monitoring operations are defined in two parts:
 1. Identification of the monitoring target address range for the address space.
 2. Access check of specific address range in the target space.
 
-DAMON currently provides the implementations of the operations for the physical
-and virtual address spaces. Below two subsections describe how those work.
+DAMON currently provides below three operation sets.  Below two subsections
+describe how those work.
+
+ - vaddr: Monitor virtual address spaces of specific processes
+ - fvaddr: Monitor fixed virtual address ranges
+ - paddr: Monitor the physical address space of the system
 
 
 VMA-based Target Address Range Construction
-- 
2.39.2


